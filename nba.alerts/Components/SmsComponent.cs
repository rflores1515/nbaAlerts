using nbaAlerts.Integration.Sports;

namespace  nbaAlerts.Components 
{
    public interface ISmsComponent
    {
        void GetTeamData(string body);
    }


    public class SmsComponent : ISmsComponent
    {
        private readonly ISportsService _sportsService;
        public SmsComponent(ISportsService sportsService)
        {
            _sportsService = sportsService;
        }
        public void GetTeamData(string body)
        {
            _sportsService.GetTeamData(body);
        }
    }
}