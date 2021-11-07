using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RumLogger.Core.Repository
{
    public interface IUserRepository
    {
        Task<int> GetUserId(string name);

    }
}
