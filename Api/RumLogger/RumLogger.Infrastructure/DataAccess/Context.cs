using Microsoft.EntityFrameworkCore;
using RumLogger.Core.Entity;

namespace RumLogger.Infrastructure.DataAccess
{
    class Context : DbContext
    {
        public DbSet<User> Users { get; set; }
        public Context(DbContextOptions<Context> options) : base(options)
        { }

        protected override void OnModelCreating(ModelBuilder builder)
        {
        }
    }
}
