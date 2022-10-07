with Ada.Text_IO; use Ada.Text_IO;
with Ddsarchitectspy.Command_Line;
with DDSArchitectSpy_DDS;
with Ddsarchitectspy.Images;
package body Ddsarchitectspy is
   use DDS;
   use GNATCOLL.Strings;

   procedure Initialze  is
   begin
      Participant := Factory.Create_Participant (Domain_Id => Command_Line.DomainId.Get);
      BuiltinSubscriber := Participant.Get_Builtin_Subscriber;

      Participants_DR  := DDS.ParticipantBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.PARTICIPANT_TOPIC_NAME));
      Publications_DR  := DDS.PublicationBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.PUBLICATION_TOPIC_NAME));
      Subscriptions_DR  := DDS.SubscriptionBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.SUBSCRIPTION_TOPIC_NAME));
   end;

   ------------
   -- Append --
   ------------

   procedure Append (Self : in out Participant_Contianer; Data : Subscriber_Info)
   is
   begin
      for I of Self loop
         if I.Id = Data.Participant_Id then
            I.Subscribers.Append (Data);
         end if;
      end loop;
   end Append;

   ------------
   -- Append --
   ------------

   procedure Append (Self : in out Participant_Contianer; Data : Publisher_Info)
   is
   begin
      for I of Self loop
         if I.Id = Data.Participant_Id then
            I.Publishers.Append (Data);
         end if;
      end loop;
   end Append;

   procedure Append (Self : in out Participant_Contianer; Data : DDS.ParticipantBuiltinTopicData)
   is
   begin
      Self.Append (As_Participant_Info (Data));
   end Append;

   procedure Append (Self : in out Participant_Contianer; Data : DDS.PublicationBuiltinTopicData)
   is
   begin
      Self.Append (As_Publisher_Info (Data));
   end Append;

   procedure Append (Self : in out Participant_Contianer; Data : DDS.SubscriptionBuiltinTopicData)
   is
   begin
      Self.Append (As_Subscriber_Info (Data));
   end Append;

   function Equivalent_Elements (Left, Right : Participant_Info) return Boolean  is
   begin
      return Left.Id = Right.Id;
   end;

   function Hash (Element : Participant_Info) return Ada.Containers.Hash_Type is
   begin
      return DDSArchitectSpy_DDS.Hash (Element.Id);
   end;

   function As_Participant_Info (Item : DDS.ParticipantBuiltinTopicData) return Participant_Info is
   begin
      return Ret : Participant_Info do
         for P of Item.Property.Value loop
            declare
               Name : constant String := P.all.Name.To_Standard_String;
            begin
               if Name = "dds.sys_info.hostname" then
                  Ret.Hostname := To_XString (P.all.Value.To_Standard_String);
               elsif Name =  "dds.sys_info.process_id" then
                  Ret.PID := Natural'Value (P.all.Value.To_Standard_String);
               end if;
            end;
         end loop;
         Ret.Id := Item.Key;
      end return;
   end;

   function As_Publisher_Info (Item : DDS.PublicationBuiltinTopicData) return Publisher_Info is
   begin
      return Ret : Publisher_Info do
         Ret.Topic_Name := To_XString (Item.Topic_Name.To_Standard_String);
         Ret.Type_Name := To_XString (Item.Type_Name.To_Standard_String);
         Ret.Id := Item.Key;
         Ret.Participant_Id := Item.Participant_Key;
      end return;
   end;

   function As_Subscriber_Info (Item : DDS.SubscriptionBuiltinTopicData) return Subscriber_Info is
   begin
      return Ret : Subscriber_Info do
         Ret.Topic_Name := To_XString (Item.Topic_Name.To_Standard_String);
         Ret.Type_Name := To_XString (Item.Type_Name.To_Standard_String);
         Ret.Id := Item.Key;
         Ret.Participant_Id := Item.Participant_Key;
      end return;
   end;

end Ddsarchitectspy;
