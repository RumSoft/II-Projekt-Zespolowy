using Microsoft.Extensions.DependencyInjection;
using RumLogger.Application.Service;
using RumLogger.Application.Service.Interfaces;

namespace RumLogger.Application
{
    public static class Extenstions
    {
        public static IServiceCollection AddApplication(this IServiceCollection builder)
        {
            builder.AddScoped<IUserService, UserService>();
            builder.AddScoped<IProcessingLogsService, ProcessingLogsService>();
            return builder;
        }
    }
}
