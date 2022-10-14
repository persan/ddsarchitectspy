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

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Octet) is
   begin
      Write (To, Item'Img);
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Octet_Seq.Sequence) is
      First_Line : Boolean := True;
   begin
      Write (To, "[");
      for I of Item loop
         Write (To, (if First_Line then "" else ","));
         First_Line := False;
         Write (To, I.all);
      end loop;
      Write (To, "]");
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : UserDataQosPolicy) is
   begin
      Write (To, Item.Value);
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.Boolean) is
   begin
      Write (To, (if Item then "true" else "false"));
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Property_T) is
   begin
      Write (To, "{""Name"" : "); Write (To, Item.Name); Write (To, "," & ASCII.LF);
      Write (To, " ""Value"" : "); Write (To, Item.Value); Write (To, "," & ASCII.LF);
      Write (To, " ""Propagate"" : "); Write (To, Item.Propagate); Write (To, "}");
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : Property_T_Seq.Sequence) is
      First_Line : Boolean := True;
   begin
      Write (To, "[");
      for I of Item loop
         Write (To, (if First_Line then "" else "," &ASCII.LF));
         First_Line := False;
         Write (To, I.all);
      end loop;
      Write (To, "]");
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : PropertyQosPolicy) is
   begin
       Write (To, Item.Value);
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : VendorId_Array_T) is
      First_Line : Boolean := True;
   begin
      Write (To, "[");
      for I of Item loop
         Write (To, (if First_Line then "" else ","));
         First_Line := False;
         Write (To, I);
      end loop;
      Write (To, "]");
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : VendorId_T) is
   begin
      Write (To, Item.VendorId);
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DomainId_T) is
   begin
      Write (To, Item'Image);
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.ParticipantBuiltinTopicData) is
   begin
      Write (To, "{");
      Write (To, """Key"" : "); Write (To, Item.Key); Write (To, "," & ASCII.LF);
      Write (To, """User_Data"" : "); Write (To, Item.User_Data); Write (To, "," & ASCII.LF);
      Write (To, """Property"" : "); Write (To, Item.Property); Write (To, "," & ASCII.LF);
      Write (To, """Rtps_Vendor_Id"" : "); Write (To, Item.Rtps_Vendor_Id); Write (To, "," & ASCII.LF);
      Write (To, """Domain_Id"" : "); Write (To, Item.Domain_Id);
      Write (To, "}");
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.PublicationBuiltinTopicData) is
   begin
      Write (To, "{");
      Write (To, """Key"" : "); Write (To, Item.Key); Write (To, "," & ASCII.LF);
      Write (To, """Participant_Key"" : "); Write (To, Item.Participant_Key); Write (To, "," & ASCII.LF);
      Write (To, """Topic_Name"" : "); Write (To, Item.Topic_Name); Write (To, "," & ASCII.LF);
      Write (To, """Type_Name"" : "); Write (To, Item.Type_Name); Write (To, "," & ASCII.LF);
      Write (To, """User_Data"" : "); Write (To, Item.User_Data);
      Write (To, "}");
   end Write;

   procedure Write (To : not null access Ada.Streams.Root_Stream_Type'Class; Item : DDS.SubscriptionBuiltinTopicData) is
   begin
      Write (To, "{");
      Write (To, """Key"" : "); Write (To, Item.Key); Write (To, "," & ASCII.LF);
      Write (To, """Participant_Key"" : "); Write (To, Item.Participant_Key); Write (To, "," & ASCII.LF);
      Write (To, """Topic_Name"" : "); Write (To, Item.Topic_Name); Write (To, "," & ASCII.LF);
      Write (To, """Type_Name"" : "); Write (To, Item.Type_Name); Write (To, "," & ASCII.LF);
      Write (To, """User_Data"" : "); Write (To, Item.User_Data);
      Write (To, "}");
   end Write;

end DDS.JSON;
