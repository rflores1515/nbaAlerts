namespace nbaAlerts.Components
{
    public interface IConfigurationComponent
    {
        public string GetConfiguration(int id);
    }

    public class ConfigurationComponent : IConfigurationComponent
    {
        private readonly NbaAlertsContext _context;
        public ConfigurationComponent(NbaAlertsContext context)
        {
            _context = context;
        }
        public string GetConfiguration(int id)
        {
            var entitity = _context.Configuration.Find(1);
            return entitity.Value;
        }
    }
}