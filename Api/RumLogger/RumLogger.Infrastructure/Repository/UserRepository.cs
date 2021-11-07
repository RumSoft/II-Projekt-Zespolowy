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

        public Task<int> GetUserId(string name)
        {
            return Task.FromResult(context.Users.FirstOrDefault(x => x.Name == name)?.Id ?? 0);
        }

        public Task<User> GetUser(int id)
        {
            return Task.FromResult(context.Users.FirstOrDefault(x => x.Id == id));
        }

        public Task<List<User>> GetUsers()
        {
            return Task.FromResult(context.Users.ToList());
        }

        public Task UpdateUser(User user)
        {
            context.Users.Update(user);
            context.SaveChanges();
            return Task.CompletedTask;
        }

        public Task AddUser(User user)
        {
            context.Users.Add(user);
            context.SaveChanges();
            return Task.CompletedTask;
        }
    }
}
