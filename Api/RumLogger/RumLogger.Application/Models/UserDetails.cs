using System;

namespace RumLogger.Application.Models
{
    public class UserDetails
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Logs { get; set; }
        public string FilteredLogs { get; set; }
        public DateTime LastLogged { get; set; }
    }
}
