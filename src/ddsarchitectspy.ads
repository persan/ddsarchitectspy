with DDS.DomainParticipant;
with DDS.DomainParticipantFactory;
with DDS.ParticipantBuiltinTopicData_DataReader;
with DDS.PublicationBuiltinTopicData_DataReader;
with DDS.SubscriptionBuiltinTopicData_DataReader;
with DDS.Subscriber;
package DDSArchitectSpy is
   Factory           : constant DDS.DomainParticipantFactory.Ref_Access := DDS.DomainParticipantFactory.Get_Instance;
   Participant       : DDS.DomainParticipant.Ref_Access;
   BuiltinSubscriber : DDS.Subscriber.Ref_Access;

   Participants_DR     : DDS.ParticipantBuiltinTopicData_DataReader.Ref_Access;
   Publications_DR     : DDS.PublicationBuiltinTopicData_DataReader.Ref_Access;
   Subscriptions_DR    : DDS.SubscriptionBuiltinTopicData_DataReader.Ref_Access;

   procedure Initialze;

end DDSArchitectSpy;
