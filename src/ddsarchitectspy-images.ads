package DDSArchitectSpy.Images is

   function Image (Item : DDS.BuiltinTopicKey_T) return String;
   function Image (Item : DDS.String) return String;
   function Image (Item : DDS.EntityNameQosPolicy) return String;
   function Image (Item : GNATCOLL.Strings.XString) return String;
   function Image (Item : Natural) return String is (Item'Img);

   --  Helpers to provide Image.
   --------------------------------------------------------------------

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Participant_Contianer);
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Participant_Info);
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Publisher_Info_Vectors.Vector);
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Publisher_Info);
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Subscriber_Info_Vectors.Vector);
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Subscriber_Info);
   procedure Write (To_Path : String; Item : Participant_Contianer);
   --
   --  Writes ths content in "Ada-format".

end DDSArchitectSpy.Images;
