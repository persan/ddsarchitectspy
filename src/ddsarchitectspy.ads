with DDS.DomainParticipant;
with DDS.DomainParticipantFactory;
with DDS.ParticipantBuiltinTopicData_DataReader;
with DDS.PublicationBuiltinTopicData_DataReader;
with DDS.SubscriptionBuiltinTopicData_DataReader;
with DDS.Subscriber;
with Ada.Containers.Vectors;
with Ada.Containers.Hashed_Sets;

with GNATCOLL.Strings;
package DDSArchitectSpy is
   VERSION : constant String := "0.0.0";

   Factory           : constant DDS.DomainParticipantFactory.Ref_Access := DDS.DomainParticipantFactory.Get_Instance;
   Participant       : DDS.DomainParticipant.Ref_Access;
   BuiltinSubscriber : DDS.Subscriber.Ref_Access;

   Participants_DR     : DDS.ParticipantBuiltinTopicData_DataReader.Ref_Access;
   Publications_DR     : DDS.PublicationBuiltinTopicData_DataReader.Ref_Access;
   Subscriptions_DR    : DDS.SubscriptionBuiltinTopicData_DataReader.Ref_Access;

   procedure Initialze;
   type Publisher_Info is record
      Topic_Name     : GNATCOLL.Strings.XString;
      Type_Name      : GNATCOLL.Strings.XString;
      Id             : DDS.BuiltinTopicKey_T;
      Participant_Id : DDS.BuiltinTopicKey_T;
   end record;
   package Publisher_Info_Vectors is new Ada.Containers.Vectors (Natural, Publisher_Info);
   type Subscriber_Info is record
      Topic_Name     : GNATCOLL.Strings.XString;
      Type_Name      : GNATCOLL.Strings.XString;
      Id             : DDS.BuiltinTopicKey_T;
      Participant_Id : DDS.BuiltinTopicKey_T;
   end record;
   package Subscriber_Info_Vectors is new Ada.Containers.Vectors (Natural, Subscriber_Info);

   type Participant_Info is record
      Hostname    : GNATCOLL.Strings.XString;
      PID         : Natural;
      Id          : DDS.BuiltinTopicKey_T;
      Publishers  : Publisher_Info_Vectors.Vector;
      Subscribers : Subscriber_Info_Vectors.Vector;
   end record;

   function Equivalent_Elements (Left, Right : Participant_Info) return Boolean;
   function Hash (Element : Participant_Info) return Ada.Containers.Hash_Type;

   package Participant_Info_Vectors is new Ada.Containers.Vectors (Natural, Participant_Info);
   type Participant_Contianer is new Participant_Info_Vectors.Vector with null record;

   procedure Append (Self : in out Participant_Contianer; Data : Subscriber_Info);
   procedure Append (Self : in out Participant_Contianer; Data : Publisher_Info);

   procedure Append (Self : in out Participant_Contianer; Data : DDS.ParticipantBuiltinTopicData);
   procedure Append (Self : in out Participant_Contianer; Data : DDS.PublicationBuiltinTopicData);
   procedure Append (Self : in out Participant_Contianer; Data : DDS.SubscriptionBuiltinTopicData);

   function As_Participant_Info (Item : DDS.ParticipantBuiltinTopicData) return Participant_Info;
   function As_Publisher_Info (Item : DDS.PublicationBuiltinTopicData) return Publisher_Info;
   function As_Subscriber_Info (Item : DDS.SubscriptionBuiltinTopicData) return Subscriber_Info;

end DDSArchitectSpy;
