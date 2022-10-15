with Ada.Strings.Unbounded;
with DDS.DomainParticipant;
with DDS.DomainParticipantFactory;
with DDS.ParticipantBuiltinTopicData_DataReader;
with DDS.PublicationBuiltinTopicData_DataReader;
with DDS.SubscriptionBuiltinTopicData_DataReader;
with DDS.Subscriber;

with GNAT.Exception_Traces;
with GNAT.Traceback.Symbolic;
with Ada.Text_Io;
with GNATCOLL.Opt_Parse;
with GNATCOLL.JSON;
with DDS.JSON_Out;
with Ada.Streams.Stream_IO;
procedure DDS.architecurespy is
   VERSION : constant Standard.String := "1.0.0";
   use Ada.Streams.Stream_IO;
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

   end Command_Line;

   Factory           : constant DDS.DomainParticipantFactory.Ref_Access := DDS.DomainParticipantFactory.Get_Instance;
   Participant       : DDS.DomainParticipant.Ref_Access;
   BuiltinSubscriber : DDS.Subscriber.Ref_Access;

   Participants_DR     : DDS.ParticipantBuiltinTopicData_DataReader.Ref_Access;
   Publications_DR     : DDS.PublicationBuiltinTopicData_DataReader.Ref_Access;
   Subscriptions_DR    : DDS.SubscriptionBuiltinTopicData_DataReader.Ref_Access;
   outf                : File_Type;

   first_Line          : Boolean := True;
begin
   if Command_Line.Parser.Parse then
      if Command_Line.Version.Get then
         Ada.Text_Io.Put_Line (VERSION);
      else
         GNAT.Exception_Traces.Trace_On (GNAT.Exception_Traces.Every_Raise);
         GNAT.Exception_Traces.Set_Trace_Decorator (GNAT.Traceback.Symbolic.Symbolic_Traceback_No_Hex'Access);

         Participant := Factory.Create_Participant (Domain_Id => Command_Line.DomainId.Get);
         BuiltinSubscriber := Participant.Get_Builtin_Subscriber;

         Participants_DR  := DDS.ParticipantBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.PARTICIPANT_TOPIC_NAME));
         Publications_DR  := DDS.PublicationBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.PUBLICATION_TOPIC_NAME));
         Subscriptions_DR := DDS.SubscriptionBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.SUBSCRIPTION_TOPIC_NAME));

         delay Command_Line.DiscoveryTime.Get;

         outf.create (Out_File, Command_Line.SaveTo.Get.To_String);
         Standard.String'Write (Outf.Stream, "{""architecture"" : {"  & ASCII.LF);
         first_Line := True;
         Standard.String'Write (Outf.Stream, """participants"" : [");
         for I of Participants_DR.Read  loop
            if I.Sample_Info.Valid_Data then
                Standard.String'Write (Outf.Stream, (if first_Line then "" else "," & ASCII.LF));
               first_Line := False;
               DDS.JSON_Out.Write (Outf.Stream, I.Data.all);
            end if;
         end loop;
          Standard.String'Write (Outf.Stream, "],");

         first_Line := True;
          Standard.String'Write (Outf.Stream, """publications"" : [");
         for I of Publications_DR.Read loop
            if I.Sample_Info.Valid_Data then
                Standard.String'Write (Outf.Stream, (if first_Line then "" else "," & ASCII.LF));
               first_Line := False;
               DDS.JSON_Out.Write (Outf.Stream, I.Data.all);
            end if;
         end loop;
          Standard.String'Write (Outf.Stream, "],");

         first_Line := True;
          Standard.String'Write (Outf.Stream, """subscriptions"" : [");
         for I of Subscriptions_DR.Read loop
            if I.Sample_Info.Valid_Data then
                Standard.String'Write (Outf.Stream, (if first_Line then "" else "," & ASCII.LF));
               first_Line := False;
               DDS.JSON_Out.Write (Outf.Stream, I.Data.all);
            end if;
         end loop;
         Standard.String'Write (Outf.Stream, "]"); -- subscriptions
         Standard.String'Write (Outf.Stream, "}}"); -- architecture
         outf.close;
      end if;
   end if;
   if Command_Line.Format_Output.Get then
      Outf.Open (In_File, Command_Line.SaveTo.Get.To_String);

      declare
         Size : constant Count := Outf.Size;
         Buffer : Ada.Streams.Stream_Element_Array (1 .. Ada.Streams.Stream_Element_Offset (Size));
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
end DDS.architecurespy;
