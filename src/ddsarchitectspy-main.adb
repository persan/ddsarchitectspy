with Ada.Tags;
with Ada.Text_IO;
with DDS.Entity;
use DDS.Entity;
with Ddsarchitectspy.Command_Line;
with GNAT.Exception_Traces;
with GNAT.Traceback.Symbolic;
with DDSArchitectSpy.DDSExtra;
with RTIDDS.Config;
with GNAT.Formatted_String;
procedure Ddsarchitectspy.Main is
   use DDSArchitectSpy.DDSExtra;

   procedure Put (Item : String) is
   begin
      if Command_Line.Verbosity.Get > 1 then
         Ada.Text_IO.Put (Item);
      end if;
   end;
   procedure Put_Line (Item : String) is
   begin
      if Command_Line.Verbosity.Get > 1 then
         Ada.Text_IO.Put_Line (Item);
      end if;
   end;

   function Image (Item : DDS.BuiltinTopicKey_T) return String is
      use GNAT.Formatted_String;
      F : constant GNAT.Formatted_String.Formatted_String := +("[%08x, %08x %08x, %08x]");
   begin
      return -(F & Long_Integer (Item.Value (Item.Value'First))  & Long_Integer (Item.Value (Item.Value'First + 1)) & Long_Integer (Item.Value (Item.Value'First + 2)) & Long_Integer (Item.Value (Item.Value'First + 3)));
   end;

   function Image (Item : DDS.String) return String is
      use DDS;
   begin
      return '"' & (if Item = DDS.NULL_String then """" else (Item.To_Standard_String & '"'));
   end;

   function Image (Item : DDS.EntityNameQosPolicy) return String is
      use DDS;
   begin
      return "[" & Image (Item.Name) & ", " & Image (Item.Role_Name) & "]";
   end;

   procedure Put (Item : DDS.ParticipantBuiltinTopicData) is
      First_Line : Boolean := True;
   begin
      Put_Line ("(Key              => " & Image (Item.Key) & ",");
      Put_Line (" Participant_Name => " & Image (Item.Participant_Name) & ",");
      Put      (" Property         => [");
      for P of Item.Property.Value loop
         Put ((if First_Line then """" else "," & ASCII.LF & "                      """));
         First_Line := False;
         Put (P.all.Name.To_Standard_String & """=> """ & P.all.Value.To_Standard_String & """");
      end loop;
      Put_Line ("],");
      Put_Line (" Domain_Id        => " & Item.Domain_Id'Img & ")");
   end Put;
   procedure Put (Item : DDS.PublicationBuiltinTopicData) is
      First_Line : Boolean := True;
   begin
      Put_Line ("(Key              => " & Image (Item.Key) & ",");
      Put_Line (" Participant_Key  => " & Image (Item.Participant_Key) & ",");
      Put_Line (" Publication_Name => " & Image (Item.Publication_Name) & ",");
      Put_Line (" Topic_Name       => " & Image (Item.Topic_Name) & ",");
      Put_Line (" Type_Name        =>  " & Image (Item.Type_Name) & ",");
      Put      (" Property         => [");
      for P of Item.Property.Value loop
         Put ((if First_Line then """" else "," & ASCII.LF & "                      """));
         First_Line := False;
         Put (P.all.Name.To_Standard_String & """=> """ & P.all.Value.To_Standard_String & """");
      end loop;
      Put_Line ("],");
   end Put;

   procedure Put (Item : DDS.SubscriptionBuiltinTopicData) is
      First_Line : Boolean := True;
   begin
      Put_Line ("(Key              => " & Image (Item.Key) & ",");
      Put_Line (" Participant_Key  => " & Image (Item.Participant_Key) & ",");
      Put_Line (" Subscription_Name=> " & Image (Item.Subscription_Name) & ",");

      Put_Line (" Topic_Name       => " & Image (Item.Topic_Name) & ",");
      Put_Line (" Type_Name        =>  " & Image (Item.Type_Name) & ",");
      Put      (" Property         => [");
      for P of Item.Property.Value loop
         Put ((if First_Line then """" else "," & ASCII.LF & "                      """));
         First_Line := False;
         Put (P.all.Name.To_Standard_String & """=> """ & P.all.Value.To_Standard_String & """");
      end loop;
      Put_Line ("],");
   end Put;

   E : DDS.Entity.Ref_Access;
begin

   GNAT.Exception_Traces.Trace_On (GNAT.Exception_Traces.Every_Raise);
   GNAT.Exception_Traces.Set_Trace_Decorator (GNAT.Traceback.Symbolic.Symbolic_Traceback_No_Hex'Access);

   if Command_Line.Parser.Parse then
      Initialze;
      delay Command_Line.DiscoveryTime.Get;
      Put_Line ("Participants:");
      for I of Participants_DR.Read  loop
         if I.Sample_Info.Valid_Data then
            Put (I.Data.all);
         end if;
      end loop;
      Put_Line ("Publications:");
      for I of Publications_DR.Read loop
         if I.Sample_Info.Valid_Data then
            Put (I.Data.all);
         end if;
      end loop;

      Put_Line ("Subscriptions:");
      for I of Subscriptions_DR.Read loop
         if I.Sample_Info.Valid_Data then
            Put (I.Data.all);
         end if;
      end loop;

   end if;

end Ddsarchitectspy.Main;
