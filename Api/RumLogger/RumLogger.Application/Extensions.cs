﻿using Microsoft.Extensions.DependencyInjection;
using RumLogger.Application.Service;
using RumLogger.Core.Service;

namespace RumLogger.Application
{
    public static class Extenstions
    {
        public static IServiceCollection AddApplication(this IServiceCollection builder)
        {
            builder.AddScoped<IUserService, UserService>();
            return builder;
        }
    }
}
