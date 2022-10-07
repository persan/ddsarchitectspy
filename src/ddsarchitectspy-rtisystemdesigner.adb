with Ada.Text_IO.Text_Streams;
with DDSArchitectSpy.Command_Line;
with Ada.Containers.Indefinite_Hashed_Sets;
with Ada.Strings.Hash;
package body DDSArchitectSpy.RTISystemDesigner is
   package String_Sets is new Ada.Containers.Indefinite_Hashed_Sets (String, Ada.Strings.Hash, "=", "=");
   use type Ada.Containers.Count_Type;
   -----------
   -- Write --
   -----------

   procedure Write
     (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDSArchitectSpy.Participant_Contianer)
   is
      Topics                          : String_Sets.Set;
      Types                           : String_Sets.Set;
      Domain_Name                     : constant String := "CombatDomain";
      Domain_Library_Name             : constant String := "lib";
      Domain_Participant_Library_Name : constant String := "participants";
   begin

      String'Write (To, "<?xml version=""1.0"" encoding=""UTF-8""?>" & ASCII.LF);
      String'Write (To, "<dds xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xsi:noNamespaceSchemaLocation=""http://community.rti.com/schema/7.0.0/rti_dds_profiles.xsd"" version=""7.0.0"">" & ASCII.LF);

      String'Write (To, "    <domain_library name=""" & Domain_Library_Name & """>" & ASCII.LF);
      String'Write (To, "      <domain name=""" & Domain_Name & """ domain_id=""" & Command_Line.DomainId.Get'Img & """>" & ASCII.LF);

      String'Write (To, "        <register_type name=""ture"" type_ref=""ture""/>" & ASCII.LF);
      String'Write (To, "        <topic name=""speed"" register_type_ref=""ture""/>" & ASCII.LF);

      String'Write (To, "      </domain>" & ASCII.LF);
      String'Write (To, "    </domain_library>" & ASCII.LF);

      String'Write (To, "    <domain_participant_library name=""" & Domain_Participant_Library_Name & """>" & ASCII.LF);
      declare

      begin
         for P of Item loop
            String'Write (To, "      <domain_participant name=""" & P.Hostname.To_String & """ domain_ref=""" & Domain_Library_Name & "::" & Domain_Name & """>" & ASCII.LF);
            String'Write (To, "        <publisher name=""auto-publisher"">" & ASCII.LF);
            for Writer of P.Publishers loop
               String'Write (To, "          <data_writer name=""" & Writer.Topic_Name.To_String & "-writer"" topic_ref=""" & Writer.Topic_Name.To_String & """/>" & ASCII.LF);
            end loop;
            String'Write (To, "        </publisher>" & ASCII.LF);
            if P.Subscribers.Length > 0 then
               String'Write (To, "        <subscriber name=""auto-subscriber"">" & ASCII.LF);
               for Subscriber of P.Subscribers loop
                  String'Write (To, "          <data_reated name=""" & Subscriber.Topic_Name.To_String & "-reader"" topic_ref=""" & Subscriber.Topic_Name.To_String & """/>" & ASCII.LF);
               end loop;
               String'Write (To, "        </subscriber>" & ASCII.LF);
            end if;
         end loop;
      end;

      String'Write (To, "      </domain_participant>" & ASCII.LF);
      String'Write (To, "    </domain_participant_library>" & ASCII.LF);

      String'Write (To, "</dds>" & ASCII.LF);
   end Write;

   -----------
   -- Write --
   -----------

   procedure Write (To_Path : String; Item : Participant_Contianer)
   is
      F : Ada.Text_IO.File_Type;
   begin
      F.Create (Ada.Text_Io.Out_File, To_Path);
      Write (Ada.Text_IO.Text_Streams.Stream (F), Item);
      F.Close;
   end Write;

end DDSArchitectSpy.RTISystemDesigner;
