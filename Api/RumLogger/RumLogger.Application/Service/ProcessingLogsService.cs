using Microsoft.Extensions.Configuration;
using RumLogger.Application.Service.Interfaces;
using System.Threading.Tasks;
using System.Net.Http;
using System;
using System.Collections.Generic;
using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Linq;

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
                string jsonString = ExtractValues(text);

                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(configuration.GetSection("LogProcessorUrl").Value + "addKeywords");
                    var content = new StringContent(jsonString, Encoding.UTF8, "application/json");
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

        private static string ExtractValues(string text)
        {
            List<KeyValuePair<string, string[]>> keywords = new List<KeyValuePair<string, string[]>>();

            var categories = text.Split('|');
            foreach (var category in categories)
            {
                var key = category.Split(':')[0];
                var valuesString = category.Split(':')[1].Split(';');
                var keyValue = new KeyValuePair<string, string[]>(key, valuesString);
                keywords.Add(keyValue);
            }

            string jsonString = JsonConvert.SerializeObject(keywords);
            return jsonString;
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
