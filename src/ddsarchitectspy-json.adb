with Ada.Text_IO.Text_Streams;
with DDSArchitectSpy.IMAGEs; use DDSArchitectSpy.IMAGEs;
with GNAT.Formatted_String;
package body DDSArchitectSpy.JSON is
   function Image (Item : DDS.BuiltinTopicKey_T) return String is
      use GNAT.Formatted_String;
      F : constant GNAT.Formatted_String.Formatted_String := +("[%u, %u, %u, %u]");
   begin
      return -(F & Long_Integer (Item.Value (Item.Value'First))  & Long_Integer (Item.Value (Item.Value'First + 1)) & Long_Integer (Item.Value (Item.Value'First + 2)) & Long_Integer (Item.Value (Item.Value'First + 3)));
   end;

   function Image (Item : GNATCOLL.Strings.XString) return String is
   begin
      return '"' & GNATCOLL.Strings.To_String (Item) & '"';
   end;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Subscriber_Info) is
   begin
      String'Write (To, Ascii.LF &
                        "{   ""topic_name"" : " & Image (Item.Topic_Name) & "," & Ascii.LF);
      String'Write (To, "    ""topic_type"" : " & Image (Item.Type_Name) & "," & Ascii.LF);
      String'Write (To, "    ""id"" : " & Image (Item.Id) & "," & Ascii.LF);
      String'Write (To, "    ""participant_id"" : " & Image (Item.Participant_Id) & "}");
   end;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Subscriber_Info_Vectors.Vector) is
      First_Element : Boolean := True;
   begin
      String'Write (To, "[");
      for I of Item loop
         String'Write (To, (if First_Element then "" else "," & ASCII.LF));
         First_Element := False;
         Write (To, I);
      end loop;
      String'Write (To, "]");
   end;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Publisher_Info) is
   begin
      String'Write (To, Ascii.LF &
                      "{  ""topic_name"" : " & Image (Item.Topic_Name) & "," & Ascii.LF);
      String'Write (To, "   ""topic_type"" : " & Image (Item.Type_Name) & "," & Ascii.LF);
      String'Write (To, "   ""id"" : " & Image (Item.Id) & "," & Ascii.LF);
      String'Write (To, "   ""participant_id"" : " & Image (Item.Participant_Id) & "}" & ASCII.LF);
   end;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Publisher_Info_Vectors.Vector) is
      First_Element : Boolean := True;
   begin
      String'Write (To, "[");
      for I of Item loop
         String'Write (To, (if First_Element then "" else "," & ASCII.LF));
         First_Element := False;
         Write (To,  I);
      end loop;
      String'Write (To, "]");
   end;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Participant_Info) is
   begin
      String'Write (To, """participant_info"" : {" & ASCII.LF);
      String'Write (To, "  ""hostname"" : " & Image (Item.Hostname) & ", " & ASCII.LF);
      String'Write (To, "  ""pid"" : " & Image (Item.PID) & "," & ASCII.LF);
      String'Write (To, "  ""id""  : " & Image (Item.Id) & "," & ASCII.LF);
      String'Write (To, "  ""publishers"" : ");
      Write (To, Item.Publishers);
      String'Write (To, "," & ASCII.LF);
      String'Write (To, "  ""subscribers"" : ");
      Write (To, Item.Subscribers);
      String'Write (To, "}" & ASCII.LF);
   end;

   -----------
   -- Write --
   -----------

   procedure Write
     (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDSArchitectSpy.Participant_Contianer)
   is
      First_Element : Boolean := True;
   begin
      String'Write (To, "{" & ASCII.LF);
      for I of Item loop
         String'Write (To, (if First_Element then "" else "," & ASCII.LF));
         Write (To, I);
         First_Element := False;
      end loop;
      String'Write (To, "}" & ASCII.LF);
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
      F.close;
   end Write;

end DDSArchitectSpy.JSON;
