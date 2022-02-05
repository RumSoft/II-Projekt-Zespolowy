using RumLogger.Core.Entity;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace RumLogger.Core.Repository
{
    public interface IUserRepository
    {
        Task<int> GetUserId(string name);
        Task<User> GetUser(int id);
        Task<User> GetUserWithLogs(int id);
        Task<List<User>> GetUsers();
        Task UpdateUser(User user);
        Task<User> AddUser(User user);
        Task AddLog(Log log);
    }
}
