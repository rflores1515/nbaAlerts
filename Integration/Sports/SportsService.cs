namespace nbaAlerts.Integration.Sports 
{
    public interface ISportsService 
    {
        public void GetTeamData(string team);
    }

    public class SportsService : ISportsService
    {
        private readonly ISportsClient _sportsClient;
        public SportsService(ISportsClient sportsClient)
        {
            _sportsClient = sportsClient;
        }
        public void GetTeamData(string team)
        {
            _sportsClient.GetTeamData(team);
        }
    }
}