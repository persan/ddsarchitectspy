with Ada.Strings.Unbounded;
with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;
with DDS.DomainParticipant;
with DDS.DomainParticipantFactory;
with DDS.ParticipantBuiltinTopicData_DataReader;
with DDS.PublicationBuiltinTopicData_DataReader;
with DDS.SubscriptionBuiltinTopicData_DataReader;
with DDS.Subscriber;

with GNAT.Exception_Traces;
with GNAT.Traceback.Symbolic;

with GNATCOLL.Opt_Parse;
with DDS.JSON;

procedure DDS.architecurespy is
   VERSION : constant Standard.String := "1.0.0";
   use Ada.Text_IO;
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
         Help        => "Time to wait for discovery to complete (default 5.0 sec).",
         Default_Val => 5.0);

      Default_SaveTo  : constant Standard.String := "architechure.json";
      package SaveTo is new Parse_Option
        (Parser      => Parser,
         Short       => "-o",
         Long        => "--output",
         Arg_Type    => Ada.Strings.Unbounded.Unbounded_String,
         Help        => "File to save arhitecture to (default """ & Default_SaveTo & """).",
         Default_Val => To_Unbounded_String (Source => Default_SaveTo));

   end Command_Line;

   Factory           : constant DDS.DomainParticipantFactory.Ref_Access := DDS.DomainParticipantFactory.Get_Instance;
   Participant       : DDS.DomainParticipant.Ref_Access;
   BuiltinSubscriber : DDS.Subscriber.Ref_Access;

   Participants_DR     : DDS.ParticipantBuiltinTopicData_DataReader.Ref_Access;
   Publications_DR     : DDS.PublicationBuiltinTopicData_DataReader.Ref_Access;
   Subscriptions_DR    : DDS.SubscriptionBuiltinTopicData_DataReader.Ref_Access;
   outf                : Ada.Text_IO.File_Type;
   first_Line          : Boolean := True;
begin
   if Command_Line.Parser.Parse then
      if Command_Line.Version.Get then
         Put_Line (VERSION);
      else
         GNAT.Exception_Traces.Trace_On (GNAT.Exception_Traces.Every_Raise);
         GNAT.Exception_Traces.Set_Trace_Decorator (GNAT.Traceback.Symbolic.Symbolic_Traceback_No_Hex'Access);

         Participant := Factory.Create_Participant (Domain_Id => Command_Line.DomainId.Get);
         BuiltinSubscriber := Participant.Get_Builtin_Subscriber;

         Participants_DR  := DDS.ParticipantBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.PARTICIPANT_TOPIC_NAME));
         Publications_DR  := DDS.PublicationBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.PUBLICATION_TOPIC_NAME));
         Subscriptions_DR := DDS.SubscriptionBuiltinTopicData_DataReader.Ref_Access (BuiltinSubscriber.Lookup_DataReader (DDS.SUBSCRIPTION_TOPIC_NAME));

         delay Command_Line.DiscoveryTime.Get;
         outf.create (Ada.Text_IO.Out_File, Command_Line.SaveTo.Get.To_String);
         outf.Put_Line ("""architecture"" : {");
         first_Line := True;
         outf.Put_Line ("""participants"" : [");
         for I of Participants_DR.Read  loop
            if I.Sample_Info.Valid_Data then
               outf.Put_Line ((if first_Line then "" else "," & ASCII.LF));
               first_Line := False;
               DDS.JSON.Write (Ada.Text_IO.Text_Streams.Stream (outf), I.Data.all);
            end if;
         end loop;
         outf.Put_Line ("],");

         first_Line := True;
         outf.Put_Line ("""publications"" : [");
         for I of Publications_DR.Read loop
            if I.Sample_Info.Valid_Data then
               outf.Put_Line ((if first_Line then "" else "," & ASCII.LF));
               first_Line := False;
               DDS.JSON.Write (Ada.Text_IO.Text_Streams.Stream (outf), I.Data.all);
            end if;
         end loop;
         outf.Put_Line ("],");

         first_Line := True;
         outf.Put_Line ("""publications"" : [");
         for I of Subscriptions_DR.Read loop
            if I.Sample_Info.Valid_Data then
               outf.Put_Line ((if first_Line then "" else "," & ASCII.LF));
               first_Line := False;
               DDS.JSON.Write (Ada.Text_IO.Text_Streams.Stream (outf), I.Data.all);
            end if;
         end loop;
         outf.Put_Line ("]");
         outf.Put_Line ("}");
         outf.close;
      end if;
   end if;

end DDS.architecurespy;
