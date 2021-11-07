using RumLogger.Application.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace RumLogger.Application.Service.Interfaces
{
    public interface IUserService
    {
        Task AddUserData(AddUserDataRequest request);
        Task<List<UserShort>> GetUserList();
        Task<UserDetails> GetUser(int id);
    }
}
