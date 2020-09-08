using Microsoft.EntityFrameworkCore;
using nbaAlerts.Entities;

namespace nbaAlerts
{
    public class NbaAlertsContext : DbContext
    {
        public NbaAlertsContext(DbContextOptions<NbaAlertsContext> options)
        : base(options)
        { }


        public DbSet<Configuration> Configuration { get; set; }
        public DbSet<Team> Team { get; set; }

    }
}