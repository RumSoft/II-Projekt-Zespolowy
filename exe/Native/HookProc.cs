using System;

namespace RumLogger.Native;

public delegate IntPtr HookProc(int code, IntPtr wParam, IntPtr lParam);