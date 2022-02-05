using RumLogger.Application.Models;
using RumLogger.Core.Repository;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Threading.Tasks;
using RumLogger.Core;
using RumLogger.Core.Entity;
using RumLogger.Application.Service.Interfaces;
using System.Text;

namespace RumLogger.Application.Service
{
    public class UserService : IUserService
    {
        private readonly IUserRepository repository;
        private readonly IProcessingLogsService processingLogsService;

        public UserService(IUserRepository repository, IProcessingLogsService processingLogsService)
        {
            this.repository = repository;
            this.processingLogsService = processingLogsService;
        }

        public async Task AddUserData(AddUserDataRequest request)
        {
            var userId = await repository.GetUserId(request.Name);
            User user;

            if (userId.IsNotCorrectId())
            {
                user = new User()
                {
                    Name = request.Name,
                    LastUserLogTime = DateTime.Now
                };
                user = await repository.AddUser(user);
            }
            else
            {
                user = await repository.GetUser(userId);
                user.LastUserLogTime = DateTime.Now;
                await repository.UpdateUser(user);
            }

            var log = new Log
            {
                UserId = user.Id,
                LogValue = request.Logs,
                DateTime = DateTime.Now,
            };

            await repository.AddLog(log);
            await UpdateProcessedLogs(user.Id);
        }

        public async Task<UserDetails> GetUser(int id)
        {
            var user = await repository.GetUserWithLogs(id);

            if (user == null)
                throw new Exception("User not found");

            var result = new UserDetails()
            {
                Id = user.Id,
                Name = user.Name,
                Logs = new StringBuilder().AppendJoin(" ", user.Logs.Select(x => x.LogValue).ToArray()).ToString(),
                FilteredLogs = user.ProcessedLogs,
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

        private async Task UpdateProcessedLogs(int userId)
        {
            try
            {
                var user = await repository.GetUserWithLogs(userId);
                var logs = new StringBuilder().AppendJoin(" ", user.Logs.Select(x => x.LogValue).ToArray()).ToString();
                var processedLogs = await processingLogsService.GetProcessedLogs(logs);
                user.ProcessedLogs = processedLogs;
                await repository.UpdateUser(user);
            }
            catch (Exception ex)
            {

              
            }
         
        }
    }
}
