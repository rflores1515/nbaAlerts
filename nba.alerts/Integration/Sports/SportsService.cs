using nbaAlerts.Entities;

namespace nbaAlerts.Integration.Sports 
{
    public interface ISportsService 
    {
        public Root GetTeamData(int teamId);
    }

    public class SportsService : ISportsService
    {
        private readonly ISportsClient _sportsClient;
        public SportsService(ISportsClient sportsClient)
        {
            _sportsClient = sportsClient;
        }
        public Root GetTeamData(int teamId)
        {
            var teamData = _sportsClient.GetTeamData(teamId);

            return teamData;
        }
    }
}