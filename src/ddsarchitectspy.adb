with Ddsarchitectspy.Command_Line;
package body Ddsarchitectspy is

   procedure Initialze  is
   begin
      Participant := Factory.Create_Participant (Domain_Id => Command_Line.DomainId.Get);
      BuiltinSubscriber := Participant.Get_Builtin_Subscriber;

      Participants_DR  := DDS.ParticipantBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.PARTICIPANT_TOPIC_NAME));
      Publications_DR  := DDS.PublicationBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.PUBLICATION_TOPIC_NAME));
      Subscriptions_DR  := DDS.SubscriptionBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.SUBSCRIPTION_TOPIC_NAME));

   end;

end Ddsarchitectspy;
