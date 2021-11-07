using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RumLogger.Core.Entity
{
    public class User
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Logs { get; set; }
        public DateTime DateEdit { get; set; }
        public string FilteredLogs { get; set; }
        public bool IsFilterActive { get; set; }
    }
}
