using System;
using System.Collections.Generic;

namespace RumLogger.Core.Entity
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<Log> Logs { get; set; }
        public DateTime LastUserLogTime { get; set; }
        public string ProcessedLogs { get; set; } = string.Empty;
    }
}
