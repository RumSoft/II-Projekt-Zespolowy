using System;
using System.Runtime.InteropServices;

namespace RumLogger.Native;

[StructLayout(LayoutKind.Sequential)]
public struct NativeMessage
{
    public IntPtr handle;
    public uint msg;
    public IntPtr wParam;
    public IntPtr lParam;
    public uint time;
    public System.Drawing.Point p;
}