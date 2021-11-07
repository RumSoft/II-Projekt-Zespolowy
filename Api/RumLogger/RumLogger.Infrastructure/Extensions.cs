using Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using RumLogger.Core.Repository;
using RumLogger.Infrastructure.Repository;
using RumLogger.Infrastructure.DataAccess;

namespace RumLogger.Application
{
    public static class Extenstions
    {
        public static IServiceCollection AddApplication(this IServiceCollection builder)
        {
            builder.AddRepositories();
            builder.AddDbContext<Context>(opt => opt.UseInMemoryDatabase("RumLogger"));

            return builder;
        }
        private static IServiceCollection AddRepositories(this IServiceCollection builder)
        {
            builder.AddScoped<IUserRepository, UserRepository>();
            return builder;
        }
    }
}
