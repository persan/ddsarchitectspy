with Ada.Text_IO.Text_Streams;
with GNAT;
with GNAT.Formatted_String;
with Ada.Directories;
package body DDSArchitectSpy.Images is

   -----------
   -- Write --
   -----------

   procedure Write
     (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Participant_Contianer)
   is
      First_Element : Boolean := True;
   begin
      String'Write (To, "Participant_Contianer'(");
      for I of Item loop
         String'Write (To, (if First_Element then "" else "," & ASCII.LF));
         Write (To, I);
         First_Element := False;
      end loop;
      String'Write (To, ")" & ASCII.LF);
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Participant_Info) is
   begin
      String'Write (To, "Participant_Info'(Hostname => " & Image (Item.Hostname) & "," & ASCII.LF);
      String'Write (To, " PID => " & Image (Item.PID) & "," & ASCII.LF);
      String'Write (To, " Id => " & Image (Item.Id) & "," & ASCII.LF);
      String'Write (To, " Publishers =>");
      Write (To, Item.Publishers);
      String'Write (To, "," & ASCII.LF);
      String'Write (To, " Subscribers =>");
      Write (To, Item.Subscribers);
      String'Write (To, ")" & ASCII.LF);
   end;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Publisher_Info_Vectors.Vector) is
      First_Element : Boolean := True;
   begin
      String'Write (To, "(");
      for I of Item loop
         String'Write (To, (if First_Element then "" else "," & ASCII.LF));
         First_Element := False;
         Write (To,  I);
      end loop;
      String'Write (To, ")");
   end;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Publisher_Info) is
   begin
      String'Write (To, "Publisher_Info'(Topic_Name => " & Image (Item.Topic_Name) & "," & Ascii.LF);
      String'Write (To, " Topic_Type => " & Image (Item.Type_Name) & "," & Ascii.LF);
      String'Write (To, " Id => " & Image (Item.Id) & "," & Ascii.LF);
      String'Write (To, " Participant_Id => " & Image (Item.Participant_Id) & ")");
   end;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Subscriber_Info_Vectors.Vector) is
      First_Element : Boolean := True;
   begin
      String'Write (To, "(");
      for I of Item loop
         String'Write (To, (if First_Element then "" else "," & ASCII.LF));
         First_Element := False;
         Write (To, I);
      end loop;
      String'Write (To, ")");
   end;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Subscriber_Info) is
   begin
      String'Write (To, "Subscriber_Info'(Topic_Name => " & Image (Item.Topic_Name) & "," & Ascii.LF);
      String'Write (To, " Topic_Type => " & Image (Item.Type_Name) & "," & Ascii.LF);
      String'Write (To, " Id => " & Image (Item.Id) & "," & Ascii.LF);
      String'Write (To, " Participant_Id => " & Image (Item.Participant_Id) & ")");
   end;

   -----------
   -- Write --
   -----------

   procedure Write (To_Path : String; Item : Participant_Contianer)
   is
      F : Ada.Text_IO.File_Type;
      Name : constant String := Ada.Directories.Base_Name (To_Path);
   begin
      F.Create (Ada.Text_Io.Out_File, To_Path);
      F.Put_Line ("with DDSArchitectSpy;");
      F.Put_Line ("package " & Name & " is");
      Write (Ada.Text_IO.Text_Streams.Stream (F), Item);
      F.Put_Line ("end " & Name & ";");
      F.Close;
   end Write;

   function Image (Item : DDS.BuiltinTopicKey_T) return String is
      use GNAT.Formatted_String;
      F : constant GNAT.Formatted_String.Formatted_String := +("(16#%08x#, 16#%08x#, 16#%08x#, 16#%08x#)");
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
      return "(" & Image (Item.Name) & ", " & Image (Item.Role_Name) & ")";
   end;

   function Image (Item : GNATCOLL.Strings.XString) return String is
   begin
      return GNATCOLL.Strings.To_String (Item);
   end;

end DDSArchitectSpy.Images;
