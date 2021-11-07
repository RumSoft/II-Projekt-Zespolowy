﻿using System;

namespace RumLogger.Core.Entity
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Logs { get; set; }
        public DateTime LastUserLogTime { get; set; } 
        public string FilteredLogs { get; set; }
        public bool IsFilterActive { get; set; }
    }
}
