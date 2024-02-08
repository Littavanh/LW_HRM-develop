using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRMS.API.Models
{
    public class AddNewsParam
    {
        public string TokenKey { get; set; }
        public string newsTitle { get; set; }
        public string newsContent { get; set; }
        public string attachec_file { get; set; }
        public DateTime pubish_date { get; set; }
        public DateTime exp_date { get; set; }
    }

    public class NewsListParam
    {
        public string TokenKey { get; set; }
    }

    public class DeleteNewsParam
    {
        public string TokenKey { get; set; }
        public string newsID { get; set; }      
    }


    public class AddNTaskParam
    {
        public string TokenKey { get; set; }
        public string taskName { get; set; }
        public string taskDetail { get; set; }
        public string emp_id { get; set; }
        public byte[] Task_attachec_file { get; set; }
        public string lang { get; set; }

    }

    public class DeleteTaskParam
    {
        public string TokenKey { get; set; }
        public string taskID { get; set; }
        public string lang { get; set; }
    }

    public class UpdateTaskParam
    {
        public string TokenKey { get; set; }
        public string taskID { get; set; }
        public Boolean CompleteStatus { get; set; }
        public string lang { get; set; }
    }

    public class TaskListParam
    {
        public string TokenKey { get; set; }
        public string lang { get; set; }
    }


}