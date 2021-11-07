using RumLogger.Application.Models;
using RumLogger.Core.Repository;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;
using RumLogger.Core;
using RumLogger.Core.Entity;

namespace RumLogger.Application.Service
{
    public class UserService : IUserService
    {
        private readonly IUserRepository repository;
        public UserService(IUserRepository repository)
        {
            this.repository = repository;
        }

        public async Task AddUserData(AddUserDataRequest request)
        {
            var userId = await repository.GetUserId(request.Name);

            if(userId.IsNotCorrectId())
            {
                var user = new User()
                {
                    Name = request.Name,
                    Logs = request.Logs,
                    IsFilterActive = false,
                    FilteredLogs = string.Empty,
                    LastUserLogTime = DateTime.Now
                };

                await repository.AddUser(user);
            }
            else
            {
                var user = await repository.GetUser(userId);
                user.Logs += request.Logs;
                user.IsFilterActive = false;
                user.LastUserLogTime = DateTime.Now;
                await repository.UpdateUser(user);
            }
        }

        public async Task<UserDetails> GetUser(int id)
        {
            var user = await repository.GetUser(id);

            if (user == null)
                throw new Exception("User not found");

            var result = new UserDetails()
            {
                Id = user.Id,
                Name = user.Name,
                Logs = user.Logs,
                FilteredLogs = user.FilteredLogs,
                LastLogged = user.LastUserLogTime
            };
            return result;
        }

        public async Task<List<UserShort>> GetUserList()
        {
            var users = await repository.GetUsers();
            var result = users.Select(x => new UserShort()
            {
                Id = x.Id,
                Name = x.Name
            });
            return result.ToList();
        }
    }
}
