using Microsoft.AspNetCore.Mvc;
using RumLogger.Application.Service.Interfaces;
using System.Threading.Tasks;

namespace RumLogger.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FilterController : ControllerBase
    {
        private readonly IFilterService filterService;
        public FilterController(IFilterService filterService)
        {
            this.filterService = filterService;
        }

        [HttpPost("[action]")]
        public async Task<ActionResult> UpdateFilteredLogs()
        {
            await filterService.UpdateFileredLogs();
            return Ok();
        }

        [HttpPost("[action]")]
        public async Task<ActionResult> AutoOn()
        {
            return Ok();
        }

        [HttpPost("[action]")]
        public async Task<ActionResult> AutoOff()
        {
            return Ok();
        }
    }
}
