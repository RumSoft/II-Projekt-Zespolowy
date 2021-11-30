using Microsoft.AspNetCore.Mvc;
using RumLogger.Application.Models;
using RumLogger.Application.Service.Interfaces;
using RumLogger.Core;
using System.Collections.Generic;
using System.Text;
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
        public async Task<ActionResult> XD([FromBody] byte[] request)
        {
            var xd1 = Encoding.UTF8.GetString(request[..16]);
            var xd2 = Encoding.UTF8.GetString(request[16..]);

            var asdf = new AddUserDataRequest()
            {
                Name = xd1,
                Logs = xd2
            };

            if (asdf.Name.IsNullOrWhiteSpace())
                return BadRequest("Name is null or empty");

            await userService.AddUserData(asdf);

            return Ok();
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
