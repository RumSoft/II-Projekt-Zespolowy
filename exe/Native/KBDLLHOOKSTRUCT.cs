using System;
using System.Runtime.InteropServices;

namespace RumLogger.Native;

[StructLayout(LayoutKind.Sequential)]
public class KBDLLHOOKSTRUCT
{
    public uint vkCode;
    public uint scanCode;
    public KBDLLHOOKSTRUCTFlags flags;
    public uint time;
    public UIntPtr dwExtraInfo;
}