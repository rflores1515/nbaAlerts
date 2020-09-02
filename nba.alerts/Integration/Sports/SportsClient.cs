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
        private const string BaseUrl = "https://www.balldontlie.io/api/v1/";
        private const string GetTeamDataUrl = "/games";
        private readonly RestClient client;
        public SportsClient()
        {
            client = new RestClient(BaseUrl); 
        }
        public void GetTeamData(string teamName)
        {
            RestRequest request = new RestRequest(GetTeamDataUrl, Method.GET);
            var response = client.Execute(request);
            var teamData = JObject.Parse(response.Content);
        }
    }
}