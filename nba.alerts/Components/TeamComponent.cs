using System.Linq;
using nbaAlerts.Entities;

namespace nbaAlerts.Components
{
    public interface ITeamComponent 
    {
        public Team GetTeamByName(string name);
        public Team GetTeamById(int Id);
    }

    public class TeamComponent : ITeamComponent
    {
        private readonly NbaAlertsContext _context;
        public TeamComponent(NbaAlertsContext context)
        {
            _context = context;
        }

        public Team GetTeamById(int Id)
        {
            var team = _context.Team.Where(x => x.TeamId == Id).FirstOrDefault();
            return team;
        }

        public Team GetTeamByName(string name)
        {
            var team = _context.Team.Where(x => x.Name.Contains(name)).FirstOrDefault();
            return team;
        }


    }
}