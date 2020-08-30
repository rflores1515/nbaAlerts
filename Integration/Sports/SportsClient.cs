using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;

namespace nbaAlerts.Integration.Sports
{
    public interface ISportsClient
    {
        public void GetTeamData(string teamName);
    }


    public class SportsClient : ISportsClient
    {
        private const string BaseUrl = "http://site.api.espn.com/";
        private const string GetDataUrl = "apis/site/v2/sports/basketball/nba/scoreboard";
        private readonly RestClient client;
        public SportsClient()
        {
            client = new RestClient(BaseUrl); 
        }
        public void GetTeamData(string teamName)
        {
            RestRequest request = new RestRequest(GetDataUrl, Method.GET);
            var response = client.Execute(request);
            var teamData = JObject.Parse(response.Content);
        }
    }
}