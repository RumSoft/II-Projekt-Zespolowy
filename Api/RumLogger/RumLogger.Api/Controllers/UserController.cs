using Microsoft.AspNetCore.Mvc;
using RumLogger.Application.Models;
using RumLogger.Application.Service;
using RumLogger.Core;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace RumLogger.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserService userService;
        public UserController(IUserService userService)
        {
            this.userService = userService;
        }

        [HttpPost("[action]")]
        public async Task<ActionResult> AddUserData([FromQuery] AddUserDataRequest request)
        {
            if (request.Name.IsNullOrWhiteSpace())
                return BadRequest("Name is null or empty");

            await userService.AddUserData(request);

            return Ok();
        }

        [HttpGet("[action]")]
        public async Task<ActionResult<IList<UserShort>>> GetUserList()
        {
            var users = await userService.GetUserList();
            return Ok(users);
        }

        [HttpGet("[action]")]
        public async Task<ActionResult<UserDetails>> GetUser([FromQuery] int id)
        {
            if(id.IsNotCorrectId())
                return BadRequest("Id is not correct");

            var user = await userService.GetUser(id);
            return Ok(user);
        }
    }
}
