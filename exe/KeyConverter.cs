using System;
using System.Windows.Forms;

namespace RumLogger;

public delegate string Converter(Keys key, bool shift, bool caps);

static class KeyConverter
{
    internal static string ToString(Keys key, bool shift, bool caps)
    {
        return key switch
        {
            >= Keys.A and <= Keys.Z when shift || caps => key.ToString(), // upper
            >= Keys.A and <= Keys.Z  => key.ToString().ToLower(), // lower

            Keys.D1 => shift ? "!" : "1",
            Keys.D2 => shift ? "@" : "2",
            Keys.D3 => shift ? "#" : "3",
            Keys.D4 => shift ? "$" : "4",
            Keys.D5 => shift ? "%" : "5",
            Keys.D6 => shift ? "^" : "6",
            Keys.D7 => shift ? "&" : "7",
            Keys.D8 => shift ? "*" : "8",
            Keys.D9 => shift ? "(" : "9",
            Keys.D0 => shift ? ")" : "0",

            Keys.Left => "«Left»",
            Keys.Up => "«Up»",
            Keys.Right => "«Right»",
            Keys.Down => "«Down»",

            Keys.Back => "«Back»",
            Keys.Tab => "«Tab»",
            Keys.ShiftKey or Keys.LShiftKey or Keys.RShiftKey or Keys.Shift => "",
            Keys.ControlKey or Keys.LControlKey or Keys.RControlKey or Keys.Control => "«Ctrl»",
            Keys.Escape => "«Esc»",
            Keys.End => "«End»",
            Keys.Home => "«Home»",
            Keys.LWin or Keys.RWin  => "«Win»",

            Keys.LineFeed => "«LF»",
            Keys.Clear => "«Clear»",
            Keys.Return => "«Enter»",

            Keys.RMenu or Keys.LMenu or Keys.Menu => "«Alt»",

            Keys.Space => " ",

            Keys.NumPad0 => "0",
            Keys.NumPad1 => "1",
            Keys.NumPad2 => "2",
            Keys.NumPad3 => "3",
            Keys.NumPad4 => "4",
            Keys.NumPad5 => "5",
            Keys.NumPad6 => "6",
            Keys.NumPad7 => "7",
            Keys.NumPad8 => "8",
            Keys.NumPad9 => "9",
            Keys.Multiply => "*",
            Keys.Add => "+",
            Keys.Separator => ",",
            Keys.Subtract => "-",
            Keys.Decimal => ".",
            Keys.Divide => "/",

            Keys.LButton or Keys.RButton or Keys.MButton => "",

            Keys.OemOpenBrackets => shift ? "{" : "[",
            Keys.OemCloseBrackets => shift ? "}" : "]",
            Keys.Oem1 => shift ? ":" : ";",
            Keys.Oem7 => shift ? "\"" : "'",
            Keys.Oemcomma => shift ? "<" : ",",
            Keys.OemPeriod => shift ? ">" : ".",
            Keys.OemQuestion => shift ? "?" : "/",
            Keys.Oem5 or Keys.OemBackslash => shift ? "|" : "\\",
            Keys.Oemtilde => shift ? "~" : "`",
            Keys.OemMinus => shift ? "_" : "-",
            Keys.Oemplus => shift ? "+" : "=",
            
            Keys.Capital => "",
            //Keys.KeyCode => expr,
            //Keys.Modifiers => expr,
            //Keys.None => expr,
            //Keys.Cancel => expr,
            //Keys.MButton => expr,
            //Keys.XButton1 => expr,
            //Keys.XButton2 => expr,

            //Keys.Menu => expr,
            //Keys.Pause => expr,
            //Keys.Capital => expr,
            //Keys.KanaMode => expr,
            //Keys.JunjaMode => expr,
            //Keys.FinalMode => expr,
            //Keys.HanjaMode => expr,
            //Keys.IMEConvert => expr,
            //Keys.IMENonconvert => expr,
            //Keys.IMEAccept => expr,
            //Keys.IMEModeChange => expr,
            //Keys.Prior => expr,
            //Keys.Next => expr,

            //Keys.Select => expr,
            //Keys.Print => expr,
            //Keys.Execute => expr,
            //Keys.Snapshot => expr,
            //Keys.Insert => expr,
            //Keys.Delete => expr,
            //Keys.Help => expr,

            //Keys.Apps => expr,
            //Keys.Sleep => expr,

            //Keys.NumLock => expr,
            //Keys.Scroll => expr,

            //Keys.LMenu => expr,
            //Keys.RMenu => expr,
            //Keys.BrowserBack => expr,
            //Keys.BrowserForward => expr,
            //Keys.BrowserRefresh => expr,
            //Keys.BrowserStop => expr,
            //Keys.BrowserSearch => expr,
            //Keys.BrowserFavorites => expr,
            //Keys.BrowserHome => expr,
            //Keys.VolumeMute => expr,
            //Keys.VolumeDown => expr,
            //Keys.VolumeUp => expr,
            //Keys.MediaNextTrack => expr,
            //Keys.MediaPreviousTrack => expr,
            //Keys.MediaStop => expr,
            //Keys.MediaPlayPause => expr,
            //Keys.LaunchMail => expr,
            //Keys.SelectMedia => expr,
            //Keys.LaunchApplication1 => expr,
            //Keys.LaunchApplication2 => expr,
            //Keys.OemSemicolon => expr,
            //Keys.OemPipe => expr,
            //Keys.OemQuotes => expr,
            //Keys.Oem8 => expr,
            //Keys.OemBackslash => expr,
            //Keys.ProcessKey => expr,
            //Keys.Packet => expr,
            //Keys.Attn => expr,
            //Keys.Crsel => expr,
            //Keys.Exsel => expr,
            //Keys.EraseEof => expr,
            //Keys.Play => expr,
            //Keys.Zoom => expr,
            //Keys.NoName => expr,
            //Keys.Pa1 => expr,
            //Keys.OemClear => expr,
            //Keys.Alt => expr,
            _ => $"«{key:G}»"
        };
    }
}