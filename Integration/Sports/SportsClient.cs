using RestSharp;

namespace nbaAlerts.Integration.Sports
{
    public interface ISportsClient
    {
        public void GetScoresData(string teamName);
    }


    public class SportsClient : ISportsClient
    {
        private const string BaseUrl = "http://site.api.espn.com/";
        public void GetScoresData(string teamName)
        {
            throw new System.NotImplementedException();
        }
    }
}