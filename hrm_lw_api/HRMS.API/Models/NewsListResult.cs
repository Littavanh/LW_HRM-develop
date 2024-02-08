using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HRMS.API.Models
{
    public class NewsListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<NewsListViewModel> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }

    public class NewsListViewModel
    {
        public string newsID { get; set; }
        public string newsTitle { get; set; }
        public string newContent { get; set; }
        public string file_path { get; set; }
        public string newAttachedfile { get; set; }
        public string expDate { get; set; }
        public int createBy { get; set; }
    }

    public class TaskListResult
    {
        public string ModelErrors { get; set; }
        public IEnumerable<TaskListViewModel> ResultObject { get; set; }
        public int StatusCode { get; set; }
        public Boolean IsSuccess { get; set; }
        public string CommonErrors { get; set; }
    }


    public class TaskListViewModel
    {
        public string taskID { get; set; }
        public string taskName { get; set; }
        public string taskDetail { get; set; }
        public string createTask { get; set; }
        public string asignTo { get; set; }
        public string file_path { get; set; }
        public byte[] taskAttachedfile { get; set; }
        public Boolean? taskStatus { get; set; }
    }


}