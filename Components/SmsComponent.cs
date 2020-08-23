namespace  nbaAlerts.Components 
{
    public interface ISmsComponent
    {
        void GetTeamSchedule(string body);
    }


    public class SmsComponent : ISmsComponent
    {
        
        public SmsComponent()
        {
            
        }
        public void GetTeamSchedule(string body)
        {
            throw new System.NotImplementedException();
        }
    }
}