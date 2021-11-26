#define _WIN32_WINNT 0x0400
#pragma comment( lib, "user32.lib" )

#include <iostream>
#include <Windows.h>
#include <cstdio>

HHOOK hKeyboardHook;

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

int main(int argc, char** argv)
{
	DWORD threadId;

	const auto threadHandle = CreateThread(nullptr, NULL, my_HotKey, argv[0], NULL, &threadId);

	return threadHandle
		? WaitForSingleObject(threadHandle, INFINITE)
		: 2137;
}
