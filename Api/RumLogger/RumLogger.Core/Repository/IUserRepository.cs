using RumLogger.Core.Entity;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace RumLogger.Core.Repository
{
    public interface IUserRepository
    {
        Task<int> GetUserId(string name);
        Task<User> GetUser(int id);
        Task<List<User>> GetUsers();
        Task UpdateUser(User user);
        Task AddUser(User user);
        Task<List<User>> GetUsersWithInactiveFilter();
    }
}
