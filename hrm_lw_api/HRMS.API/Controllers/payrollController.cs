using HRMS.API.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web.Http;
using HRMS.Data;
using System.Drawing;
using System.Text;
using System.Security.Cryptography;

namespace HRMS.API.Controllers
{
    public class payrollController : ApiController
    {
        public static string connectionString = ConfigurationManager.ConnectionStrings["db_hrmsEntities.Properties.Settings.db_hrmsConnectionString"].ConnectionString;

    }
}