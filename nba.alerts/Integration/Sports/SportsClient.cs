using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;

namespace nbaAlerts.Integration.Sports
{
    public interface ISportsClient
    {
        public Root GetTeamData(int id, string season = "2019");
    }


    public class SportsClient : ISportsClient
    {
        private const string BaseUrl = "https://www.balldontlie.io/api/v1/";
        private const string GetTeamDataUrl = "/games";
        private readonly RestClient client;
        public SportsClient()
        {
            client = new RestClient(BaseUrl); 
        }
        public Root GetTeamData(int id, string season = "2019")
        {
            RestRequest request = new RestRequest(GetTeamDataUrl, Method.GET);
            request.AddQueryParameter("team_ids[]", id.ToString());
            request.AddQueryParameter("seasons[]", season);
            request.AddQueryParameter("postseason", "true");
            var response = client.Execute<Root>(request);
            return response.Data;
        }
    }
}