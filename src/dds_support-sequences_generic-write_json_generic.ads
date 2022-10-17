generic
   type Stream is private;
   with procedure write (To : Stream; Item : in Element) is <>;
   with procedure write (To : Stream; Item : Standard.String) is <>;
procedure DDS_Support.Sequences_Generic.Write_JSON_Generic (To : Stream; Item : Sequence);
