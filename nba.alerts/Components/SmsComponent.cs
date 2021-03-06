using System;
using System.Linq;
using nbaAlerts.Entities;
using nbaAlerts.Integration.Sports;

namespace  nbaAlerts.Components 
{
    public interface ISmsComponent
    {
        Root GetTeamData(string teamName);
        string GetRecentScore(string body);
    }


    public class SmsComponent : ISmsComponent
    {
        private readonly ISportsService _sportsService;
        private readonly ITeamComponent _teamComponent;
        public SmsComponent(ISportsService sportsService, ITeamComponent teamComponent)
        {
            _teamComponent = teamComponent;
            _sportsService = sportsService;
        }

        public string GetRecentScore(string body)
        {
            var teamData = GetTeamData(body);
            var scoreData = GetLatestGame(teamData);
            var formatedScore = FormatedScore(scoreData);
            return formatedScore;
        }

        private Datum GetLatestGame(Root teamData)
        {
            return teamData.data.Where(x => x.home_team_score > 0).OrderByDescending(x => x.date).FirstOrDefault();
        }

        private string FormatedScore(Datum scoreData)
        {
            return $"{scoreData.home_team.name} {scoreData.home_team_score} {scoreData.visitor_team.name} {scoreData.visitor_team_score}";
        }

        public Root GetTeamData(string teamName)
        {
            var team = _teamComponent.GetTeamByName(teamName);
            return _sportsService.GetTeamData(team.TeamId);
        }
    }
}