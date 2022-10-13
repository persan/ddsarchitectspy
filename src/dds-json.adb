package body DDS.JSON is

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Standard.String) is
   begin
      Standard.String'Write (To, Item);
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.BuiltinTopicKey_T) is
   begin
      Standard.String'Write (To, "[" & Item.Value (Item.Value'First)'Img & "," &
                               Item.Value (Item.Value'First + 1)'Img  & "," &
                               Item.Value (Item.Value'First + 2)'Img & "," &
                               Item.Value (Item.Value'First + 3)'Img & "]");
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.String) is
   begin
      Standard.String'Write (To,  '"' & (if Item = DDS.NULL_STRING then """" else (To_Standard_String (Item) & '"')));
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.EntityNameQosPolicy)  is
   begin
      Write (To,  "[");
      Write (To, Item.Name);
      Write (To, ", ");
      Write (To, Item.Role_Name);
      Write (To, "]");
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Natural) is
   begin
      Write (To, Item'Img);
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.ParticipantBuiltinTopicData) is
   begin
      Write (To, "{");
      Write (To, """Key"" : "); Write (To, Item.Key); Write (To, "," & ASCII.LF);
      Write (To, "}");
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.PublicationBuiltinTopicData) is
   begin
      Write (To, "{");
      Write (To, """Key"" : "); Write (To, Item.Key); Write (To, "," & ASCII.LF);
      Write (To, "}");
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.SubscriptionBuiltinTopicData) is
   begin
      Write (To, "{");
      Write (To, """Key"" : "); Write (To, Item.Key); Write (To, "," & ASCII.LF);
      Write (To, "}");
   end Write;

end DDS.JSON;
