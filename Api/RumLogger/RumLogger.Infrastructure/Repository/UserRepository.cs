using Microsoft.EntityFrameworkCore;
using RumLogger.Core.Entity;
using RumLogger.Core.Repository;
using RumLogger.Infrastructure.DataAccess;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RumLogger.Infrastructure.Repository
{
    class UserRepository : IUserRepository
    {
        private readonly Context context;

        public UserRepository(Context context)
        {
            this.context = context;
        }

        public async Task<int> GetUserId(string name)
        {
            var user = await context.Users.FirstOrDefaultAsync(x => x.Name == name);
            return user?.Id ?? 0;
        }

        public async Task<User> GetUser(int id) 
            => await context.Users.FirstOrDefaultAsync(x => x.Id == id);

        public async Task<User> GetUserWithLogs(int id)
            => await context.Users.Include(x =>x.Logs).FirstOrDefaultAsync(x => x.Id == id);

        public async Task<List<User>> GetUsers() 
            => await context.Users.ToListAsync();

        public Task UpdateUser(User user)
        {
            context.Users.Update(user);
            context.SaveChanges();
            return Task.CompletedTask;
        }

        public async Task<User> AddUser(User user)
        {
            var newUser = await context.Users.AddAsync(user);
            context.SaveChanges();
            return newUser.Entity;
        }

        public async Task AddLog(Log log)
        {
            await context.Logs.AddAsync(log);
            context.SaveChanges();
        }
    }
}
