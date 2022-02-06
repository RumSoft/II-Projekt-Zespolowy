using Microsoft.Extensions.Configuration;
using RumLogger.Application.Service.Interfaces;
using System.Threading.Tasks;
using System.Net.Http;
using System;
using System.Collections.Generic;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace RumLogger.Application.Service
{
    public class ProcessingLogsService : IProcessingLogsService
    {
        private readonly IConfiguration configuration;

        public ProcessingLogsService(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public async Task AddNewKeywords(string text)
        {


            try
            {
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(configuration.GetSection("LogProcessorUrl").Value);
                    var content = new StringContent(JsonConvert.SerializeObject(new
                    {
                        logs = text
                    }), Encoding.UTF8, "application/json");
                    var result = await client.PostAsync("", content);
                    string resultContent = await result.Content.ReadAsStringAsync();
                    dynamic data = JObject.Parse(resultContent);
                    var processedLogs = data.summary;
                    var processedLogs2 = data.filteredLogs;
                }
            }
            catch (Exception)
            {

            }
        }

        public async Task<string> GetProcessedLogs(string logsValue)
        {
            try
            {
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(configuration.GetSection("LogProcessorUrl").Value + "parseKeystrokes");
                    var content = new StringContent(JsonConvert.SerializeObject(new
                    {
                        logs = logsValue
                    }), Encoding.UTF8, "application/json");
                    var result = await client.PostAsync("", content);
                    string resultContent = await result.Content.ReadAsStringAsync();
                    dynamic data = JObject.Parse(resultContent);
                    var processedLogs = data.summary;
                    var processedLogs2 = data.filteredLogs;
                    return processedLogs + "\n\n" + processedLogs2 ?? logsValue;
                }
            }
            catch (Exception)
            {

                return logsValue;
            }

        }
    }
}
