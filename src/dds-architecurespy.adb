with Ada.Calendar;
with Ada.Streams.Stream_IO;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

with DDS.DomainParticipant;
with DDS.DomainParticipantFactory;
with DDS.JSON_Out_Generic;
with DDS.ParticipantBuiltinTopicData_DataReader;
with DDS.PublicationBuiltinTopicData_DataReader;
with DDS.Subscriber;
with DDS.SubscriptionBuiltinTopicData_DataReader;

with GNAT.Ctrl_C;
with GNAT.Exception_Traces;
with GNAT.Traceback.Symbolic;

with GNATCOLL.Opt_Parse;
with GNATCOLL.JSON;

procedure DDS.Architecurespy is
   VERSION : constant Standard.String := "1.0.0";
   use Ada.Streams.Stream_IO;
   use Ada.Calendar;

   package Command_Line is
      use Ada.Strings.Unbounded;
      use GNATCOLL.Opt_Parse;

      Parser : Argument_Parser := Create_Argument_Parser
        (Help =>
           "DDSArchitect spy (" & VERSION & ")captures the domain architecture to .json-file");

      package Version is new Parse_Flag
        (Parser => Parser,
         Short  => "-v",
         Long   => "--version",
         Help   => "Prints version number and exits");

      function Convert (Arg : Standard.String) return DDS.DomainId_T is (DDS.DomainId_T'Value (Arg));

      Default_DomainId : constant DDS.DomainId_T := 0;

      package DomainId is new Parse_Option
        (Parser      => Parser,
         Long        => "--domainId",
         Arg_Type    => DDS.DomainId_T,
         Help        => "Sets the domainId (default " & Default_DomainId'Img & ").",
         Default_Val => Default_DomainId);

      function Convert (Arg : Standard.String) return Duration is
        (Duration'Value (Arg));

      package DiscoveryTime is new Parse_Option
        (Parser      => Parser,
         Short       => "-t",
         Long        => "--discoverytime",
         Arg_Type    => Duration,
         Help        => "Time to wait for discovery to complete (default 20.0 sec).",
         Default_Val => 20.0);

      Default_SaveTo  : constant Standard.String := "architechure.json";
      package SaveTo is new Parse_Option
        (Parser      => Parser,
         Short       => "-o",
         Long        => "--output",
         Arg_Type    => Ada.Strings.Unbounded.Unbounded_String,
         Help        => "File to save arhitecture to (default """ & Default_SaveTo & """).",
         Default_Val => To_Unbounded_String (Source => Default_SaveTo));

      package Format_Output is new Parse_Flag
        (Parser => Parser,
         Short  => "-f",
         Long   => "--format",
         Help   => "Format output for redability.");
      package Trace_Exceptions is new Parse_Flag
        (Parser => Parser,
         Long   => "--exceptions",
         Help   => "Log all exceptions");

   end Command_Line;

   procedure Write (Stream : Ada.Streams.Stream_IO.Stream_Access; Item : Standard.String) is
   begin
      Standard.String'Write (Stream, Item);
   end;
   package JSON_Out is new DDS.JSON_Out_Generic (Stream_Access, Write);

   Waiting             : Boolean := True;
   Run_Until           : Ada.Calendar.Time;

   procedure On_Ctrl_C is
   begin
      Waiting := False;
      GNAT.Ctrl_C.Uninstall_Handler;
   end;

   Factory           : constant DDS.DomainParticipantFactory.Ref_Access := DDS.DomainParticipantFactory.Get_Instance;
   Participant       : DDS.DomainParticipant.Ref_Access;
   BuiltinSubscriber : DDS.Subscriber.Ref_Access;

   Participants_DR     : DDS.ParticipantBuiltinTopicData_DataReader.Ref_Access;
   Publications_DR     : DDS.PublicationBuiltinTopicData_DataReader.Ref_Access;
   Subscriptions_DR    : DDS.SubscriptionBuiltinTopicData_DataReader.Ref_Access;
   Outf                : File_Type;

   First_Line          : Boolean := True;

begin
   if Command_Line.Parser.Parse then
      if Command_Line.Version.Get then
         Ada.Text_Io.Put_Line (VERSION);
      else
         GNAT.Ctrl_C.Install_Handler (On_Ctrl_C'Unrestricted_Access);
         if Command_Line.Trace_Exceptions.get then
            GNAT.Exception_Traces.Trace_On (GNAT.Exception_Traces.Every_Raise);
            GNAT.Exception_Traces.Set_Trace_Decorator (GNAT.Traceback.Symbolic.Symbolic_Traceback_No_Hex'Access);
         end if;

         Participant := Factory.Create_Participant (Domain_Id => Command_Line.DomainId.Get);
         BuiltinSubscriber := Participant.Get_Builtin_Subscriber;

         Participants_DR  := DDS.ParticipantBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.PARTICIPANT_TOPIC_NAME));
         Publications_DR  := DDS.PublicationBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.PUBLICATION_TOPIC_NAME));
         Subscriptions_DR := DDS.SubscriptionBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.SUBSCRIPTION_TOPIC_NAME));
         Run_Until :=  Ada.Calendar.Clock + Command_Line.DiscoveryTime.Get;

         Ada.Text_Io.Put_Line ("Wait for discovery");
         while Waiting and (Run_Until >= Ada.Calendar.Clock) loop
            delay 0.5;
            Ada.Text_Io.Put (".");
         end loop;
         Ada.Text_Io.New_Line;
         Ada.Text_Io.Put_Line ("Collecting data");

         Outf.Create (Out_File, Command_Line.SaveTo.Get.To_String);
         Standard.String'Write (Outf.Stream, "{""architecture"" : {"  & ASCII.LF);
         First_Line := True;
         Standard.String'Write (Outf.Stream, """participants"" : [");
         for I of Participants_DR.Read  loop
            if I.Sample_Info.Valid_Data then
               Standard.String'Write (Outf.Stream, (if First_Line then "" else "," & ASCII.LF));
               First_Line := False;
               JSON_Out.Write (Outf.Stream, I.Data.all);
            end if;
         end loop;
         Standard.String'Write (Outf.Stream, "],");

         First_Line := True;
         Standard.String'Write (Outf.Stream, """publications"" : [");
         for I of Publications_DR.Read loop
            if I.Sample_Info.Valid_Data then
               Standard.String'Write (Outf.Stream, (if First_Line then "" else "," & ASCII.LF));
               First_Line := False;
               JSON_Out.Write (Outf.Stream, I.Data.all);
            end if;
         end loop;
         Standard.String'Write (Outf.Stream, "],");

         First_Line := True;
         Standard.String'Write (Outf.Stream, """subscriptions"" : [");
         for I of Subscriptions_DR.Read loop
            if I.Sample_Info.Valid_Data then
               Standard.String'Write (Outf.Stream, (if First_Line then "" else "," & ASCII.LF));
               First_Line := False;
               JSON_Out.Write (Outf.Stream, I.Data.all);
            end if;
         end loop;
         Standard.String'Write (Outf.Stream, "]"); -- subscriptions
         Standard.String'Write (Outf.Stream, "}}"); -- architecture
         Outf.Close;

         if Command_Line.Format_Output.Get then
            Outf.Open (In_File, Command_Line.SaveTo.Get.To_String);

            declare
               Size             : constant Count := Outf.Size;
               Buffer           : Ada.Streams.Stream_Element_Array (1 .. Ada.Streams.Stream_Element_Offset (Size));
               Buffer_As_String : Standard.String (1 .. Standard.Natural (Size)) with
                 Import => True,
                 Address => Buffer'Address;
               Last             : Ada.Streams.Stream_Element_Offset;
            begin
               Outf.Read (Buffer, Last);
               Outf.Close;
               Outf.Create (Out_File, Command_Line.SaveTo.Get.To_String);
               Standard.String'Write (Outf.Stream, GNATCOLL.JSON.Write (GNATCOLL.JSON.Read (Buffer_As_String), Compact => False));
            end;
         end if;

         Participant.Delete_Contained_Entities;
         Factory.Delete_Participant (Participant);
      end if;
   end if;
end DDS.Architecurespy;
