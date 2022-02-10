using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RumLogger.Application.Service.Interfaces
{
    public interface IProcessingLogsService
    {
        Task<string> GetProcessedLogs(string logs);
        Task AddNewKeywords(string text);
    }
}
