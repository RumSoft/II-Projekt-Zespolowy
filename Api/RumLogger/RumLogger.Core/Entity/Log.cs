using System;

namespace RumLogger.Core.Entity
{
    public class Log
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string LogValue { get; set; }
        public DateTime DateTime { get; set; }
    }
}
