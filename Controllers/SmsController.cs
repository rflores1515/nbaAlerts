using nbaAlerts.Components;
using Twilio.AspNet.Common;
using Twilio.AspNet.Core;
using Twilio.TwiML;

namespace TwilioReceive.Controllers
{
    public class SmsController : TwilioController
    {
        private readonly ISmsComponent _smsComponent;
        public SmsController(ISmsComponent smsComponent)
        {
            _smsComponent = smsComponent;
        }
        public TwiMLResult Index(SmsRequest incomingMessage)
        {
            var messagingResponse = new MessagingResponse();
            // messagingResponse.Message("The copy cat says: " +
            //                           incomingMessage.Body);
            _smsComponent.GetTeamSchedule(incomingMessage.Body);
            

            return TwiML(messagingResponse);
        }
    }
}