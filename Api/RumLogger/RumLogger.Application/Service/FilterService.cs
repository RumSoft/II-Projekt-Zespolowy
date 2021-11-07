using Microsoft.Extensions.Configuration;
using RumLogger.Application.Service.Interfaces;
using RumLogger.Core.Repository;
using RumLogger.Core;
using System.Threading.Tasks;
using System.Net.Http;

namespace RumLogger.Application.Service
{
    public class FilterService : IFilterService
    {
        private readonly IUserRepository userRepository;
        private readonly IConfiguration configuration;
        private readonly HttpClient httpClient;

        public FilterService(IUserRepository userRepository, IConfiguration configuration)
        {
            this.userRepository = userRepository;
            this.configuration = configuration;

            httpClient = new HttpClient();
        }

        public async Task UpdateFileredLogs()
        {
            if (!ShouldUpdateLogs())
                return;

            var users = await userRepository.GetUsersWithInactiveFilter();
            foreach (var user in users)
            {
                var filteredLogs = await GetFilteredData(user.Logs);
                user.FilteredLogs = filteredLogs;
                user.IsFilterActive = true;
                await userRepository.UpdateUser(user);
            }
        }

        private bool ShouldUpdateLogs()
        {
            var enabled = configuration.GetSection("Filter:Enabled").Value.ToBool();
            var url = configuration.GetSection("Filter:Url").Value;

            return enabled && !url.IsNullOrWhiteSpace();
        }

        private async Task<string> GetFilteredData(string data)
        {
            var url = configuration.GetSection("Filter:Url").Value;
            var result = await httpClient.GetAsync(url + data);
            return result.Content.ToString();
        }
    }
}
