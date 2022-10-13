with Ada.Streams;
package DDS.JSON is

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.ParticipantBuiltinTopicData);
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.PublicationBuiltinTopicData);
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.SubscriptionBuiltinTopicData);

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.BuiltinTopicKey_T);
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.String);
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.EntityNameQosPolicy);
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Natural);
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Standard.String);

end DDS.JSON;
