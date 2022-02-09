﻿using System;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using RumLogger.Application.Models;
using RumLogger.Application.Service.Interfaces;
using RumLogger.Core;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace RumLogger.Api.Controllers
{
    [EnableCors]
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserService userService;
        private readonly IProcessingLogsService processingLogsService;
        public UserController(IUserService userService, IProcessingLogsService processingLogsService)
        {
            this.userService = userService;
            this.processingLogsService = processingLogsService;
        }

        [HttpPost("[action]/{name}")]
        public async Task<ActionResult> AddUserDataV2([FromRoute] string name, [FromBody] string content)
        {
            if (name.IsNullOrWhiteSpace())
                return BadRequest("Name is null or empty");

            var str = Decode64(content);
            await userService.AddUserData(new AddUserDataRequest
            {
                Logs = str,
                Name = name
            });

            return Ok();
        }

        [HttpPost("[action]")]
        public async Task<ActionResult> AddNewKeywords([FromQuery] string text)
        {
            await processingLogsService.AddNewKeywords(text);
            await userService.UpdateProcessedLogsForAllUsers();
            return Ok();
        }

        private string Decode64(string str)
        {
            return Encoding.UTF8.GetString(Convert.FromBase64String(str));
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
