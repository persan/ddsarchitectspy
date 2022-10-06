with DDS.DomainParticipant;
with DDS.DomainParticipantFactory;
with DDS.ParticipantBuiltinTopicData_DataReader;
with DDS.PublicationBuiltinTopicData_DataReader;
with DDS.SubscriptionBuiltinTopicData_DataReader;
with DDS.Subscriber;
package DDSArchitectSpy is
   factory : constant DDS.DomainParticipantFactory.Ref_Access := DDS.DomainParticipantFactory.Get_Instance;
   participant : DDS.DomainParticipant.Ref_Access;
   builtinSubscriber : DDS.Subscriber.Ref_Access;

   participants_DR    : DDS.ParticipantBuiltinTopicData_DataReader.ref_access;
   publications_DR    : DDS.PublicationBuiltinTopicData_DataReader.ref_access;
   subscriptions_DR    : DDS.SubscriptionBuiltinTopicData_DataReader.ref_access;

   procedure initialze;

end DDSArchitectSpy;
