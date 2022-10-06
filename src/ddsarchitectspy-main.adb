with Ada.Tags;
with Ada.Text_IO;
with DDS.Entity;
use DDS.Entity;
with Ddsarchitectspy.Command_Line;
with GNAT.Exception_Traces;
with GNAT.Traceback.Symbolic;
with DDSArchitectSpy.DDSExtra;
with RTIDDS.Config;

procedure Ddsarchitectspy.Main is
   use Ada.Text_IO;
   use DDSArchitectSpy.DDSExtra;

   procedure Put_Line (Item : DDS.ParticipantBuiltinTopicData) is
   begin
      Put_Line ("Name => """ & Item.Participant_Name.Name.To_Standard_String & """");
      Put_Line (Item.Key'Img);
      for P of Item.Property.Value loop
         Put_Line (P.all.Name.To_Standard_String & "-> " & P.all.Value.To_Standard_String);
      end loop;
   end Put_Line;
   E : DDS.Entity.Ref_Access;
begin

   GNAT.Exception_Traces.Trace_On (GNAT.Exception_Traces.Every_Raise);
   GNAT.Exception_Traces.Set_Trace_Decorator (GNAT.Traceback.Symbolic.Symbolic_Traceback_No_Hex'Access);

   if Command_Line.Parser.Parse then
      Initialze;
      delay 5.0;
      for I of Publications_DR.Read loop
         Put_Line (I.Data.Topic_Name.To_Standard_String & " : " & I.Data.Type_Name.To_Standard_String);
         E := Lookup_Entity (Participant, I.Data.Key);

         Put_Line ((if E /= null then Ada.Tags.External_Tag (E'Tag) else "<NULL>"));
      end loop;

      Put_Line ("------------------------------------------------");
      for I of Participants_DR.Read  loop
         begin
            Put_Line (I.Data.all);
         exception
            when others =>
               Put_Line ("unable to read");
         end;

      end loop;

   end if;

end Ddsarchitectspy.Main;
