with Ada.Directories;
with Ada.Tags;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Text_IO.Text_Streams;

with Ddsarchitectspy.Command_Line;
with DDSArchitectSpy.Images;
with DDSArchitectSpy.JSON;
with DDSArchitectSpy.RTISystemDesigner;
with DDSArchitectSpy.Xmi;

with GNAT.Exception_Traces;
with GNAT.Traceback.Symbolic;

procedure Ddsarchitectspy.Main is
   Data       : DDSArchitectSpy.Participant_Contianer;
begin

   if Command_Line.Parser.Parse then
      if Command_Line.Version.Get then
         Put_Line (VERSION);
      else
         GNAT.Exception_Traces.Trace_On (GNAT.Exception_Traces.Every_Raise);
         GNAT.Exception_Traces.Set_Trace_Decorator (GNAT.Traceback.Symbolic.Symbolic_Traceback_No_Hex'Access);

         Initialze;

         delay Command_Line.DiscoveryTime.Get;

         for I of Participants_DR.Read  loop
            if I.Sample_Info.Valid_Data then
               Data.Append (I.Data.all);
            end if;
         end loop;

         for I of Publications_DR.Read loop
            if I.Sample_Info.Valid_Data then
               Data.Append (I.Data.all);
            end if;
         end loop;

         for I of Subscriptions_DR.Read loop
            if I.Sample_Info.Valid_Data then
               Data.Append (I.Data.all);
            end if;
         end loop;

         declare
            Suffix : constant String := Ada.Directories.Extension (Command_Line.SaveTo.Get.To_String);
         begin
            if Suffix = "json" then
               DDSArchitectSpy.JSON.Write (Command_Line.SaveTo.Get.To_String, Data);
            elsif Suffix = "xml" then
               DDSArchitectSpy.RTISystemDesigner.Write (Command_Line.SaveTo.Get.To_String, Data);
            elsif Suffix = "xmi" then
               DDSArchitectSpy.XMI.Write (Command_Line.SaveTo.Get.To_String, Data);
            else
               DDSArchitectSpy.Images.Write (Command_Line.SaveTo.Get.To_String, Data);
            end if;
         end;
      end if;
   end if;

end Ddsarchitectspy.Main;
