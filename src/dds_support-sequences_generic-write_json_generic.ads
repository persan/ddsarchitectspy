with Ada.Streams;
generic
   with procedure write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : in Element) is <>;
   with procedure write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Standard.String) is <>;
procedure DDS_Support.Sequences_Generic.Write_JSON_Generic (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Sequence);
