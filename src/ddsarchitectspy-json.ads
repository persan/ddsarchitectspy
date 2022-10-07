package DDSArchitectSpy.JSON is
   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDSArchitectSpy.Participant_Contianer);
   procedure Write (To_Path : String; Item : Participant_Contianer);
end DDSArchitectSpy.JSON;
