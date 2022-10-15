procedure DDS_Support.Sequences_Generic.Write_JSON_Generic
  (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Sequence)
is
      First_Line : Boolean := True;
begin
      write (To, "[");
      for I of Item loop
         write (To, (if First_Line then "" else ","));
         First_Line := False;
         write (To, I.all);
      end loop;
      write (To, "]");
end DDS_Support.Sequences_Generic.Write_JSON_Generic;
