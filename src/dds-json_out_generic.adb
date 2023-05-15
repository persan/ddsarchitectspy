package body DDS.JSON_Out_Generic is

   procedure Write (To : Stream; Item : DDS.BuiltinTopicKey_T) is
   begin
      Write (To, "[" & Item.Value (Item.Value'First)'Img & "," &
               Item.Value (Item.Value'First + 1)'Img  & "," &
               Item.Value (Item.Value'First + 2)'Img & "," &
               Item.Value (Item.Value'First + 3)'Img & "]");
   end Write;

   procedure Write (To : Stream; Item : DDS.String) is
   begin
      Write (To,  '"' & (if Item = DDS.NULL_STRING then """" else (To_Standard_String (Item) & '"')));
   end Write;

   procedure Write (To : Stream; Item : DDS.EntityNameQosPolicy)  is
   begin
      Write (To,  "[");
      Write (To, Item.Name);
      Write (To, ", ");
      Write (To, Item.Role_Name);
      Write (To, "]");
   end Write;

   procedure Write (To : Stream; Item : Natural) is
   begin
      Write (To, Item'Img);
   end Write;

   procedure Write (To : Stream; Item : Octet) is
   begin
      Write (To, Item'Img);
   end Write;

   procedure Write_Array_Generic (To : Stream; Item : Array_Type) is
      First_Line : Boolean := True;
   begin
      Write (To, "[");
      for I of Item loop
         Write (To, (if First_Line then "" else ","));
         First_Line := False;
         Write (To, I);
      end loop;
      Write (To, "]");
   end Write_Array_Generic;

   procedure Write (To : Stream; Item : UserDataQosPolicy) is
   begin
      Write (To, Item.Value);
   end Write;

   procedure Write (To : Stream; Item : DDS.Boolean) is
   begin
      Write (To, (if Item then "true" else "false"));
   end Write;

   procedure Write (To : Stream; Item : Property_T) is
   begin
      Write (To, "{""Name"" : "); Write (To, Item.Name); Write (To, "," & ASCII.LF);
      Write (To, " ""Value"" : "); Write (To, Item.Value); Write (To, "," & ASCII.LF);
      Write (To, " ""Propagate"" : "); Write (To, Item.Propagate); Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : PropertyQosPolicy) is
   begin
      Write (To, Item.Value);
   end Write;

   procedure Write (To : Stream; Item : VendorId_Array_T) is
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

   procedure Write (To : Stream; Item : VendorId_T) is
   begin
      Write (To, Item.VendorId);
   end Write;

   procedure Write (To : Stream; Item : DomainId_T) is
   begin
      Write (To, Item'Image);
   end Write;

   procedure Write (To : Stream; Item : EncapsulationId_T) is
   begin
      Write (To, Item'Image);
   end Write;

   procedure Write (To : Stream; Item : Transport_ClassId_T) is
   begin
      Write (To, Item'Image);
   end Write;

   procedure Write (To : Stream; Item : Unsigned_Long) is
   begin
      Write (To, Item'Image);
   end Write;

   procedure Write (To : Stream; Item : Locator_Address_Array_T) is
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

   procedure Write (To : Stream; Item : GUID_T_Value_Array) is
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

   procedure Write (To : Stream; Item : Guid_T) is
   begin
      Write (To, Item.Value);
   end Write;

   procedure Write (To : Stream; Item : Duration_T) is
   begin
      Write (To, "{");
      Write (To, """Sec"" : "); Write (To, Item.Sec); Write (To, "," & ASCII.LF);
      Write (To, """Nanosec"" : "); Write (To, Item.Nanosec);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : Locator_T) is
   begin
      Write (To, "{");
      Write (To, """Kind"" : "); Write (To, Item.Kind); Write (To, "," & ASCII.LF);
      Write (To, """Port"" : "); Write (To, Item.Port); Write (To, "," & ASCII.LF);
      Write (To, """Address"" : "); Write (To, Item.Address); Write (To, "," & ASCII.LF);
      Write (To, """Encapsulations"" : "); Write (To, Item.Encapsulations);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : OwnershipQosPolicyKind) is
   begin
      Write (To, (case Item is
                when SHARED_OWNERSHIP_QOS    => """SHARED_OWNERSHIP_QOS""",
                when EXCLUSIVE_OWNERSHIP_QOS => """EXCLUSIVE_OWNERSHIP_QOS""",
                when others                  => """<INVALID_OWNERSHIP_QOS>"""
            ));
   end Write;

   procedure Write (To : Stream; Item : OwnershipQosPolicy) is
   begin
      Write (To, "{");
      Write (To, """Kind"" : "); Write (To, Item.Kind);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : PartitionQosPolicy) is
   begin
      Write (To, "{");
      Write (To, """Name"" : ");
      Write (To, Item.Name);
      Write (To, "}");
   end Write;
   procedure Write (To : Stream; Item : OwnershipStrengthQosPolicy) is
   begin
      Write (To, Item.Value);
   end Write;

   procedure Write (To : Stream; Item : TransportInfo_T) is
   begin
      Write (To, "{");
      Write (To, """Class_Id"" : "); Write (To, Item.Class_Id); Write (To, "," & ASCII.LF);
      Write (To, """Message_Size_Max"" : "); Write (To, Item.Message_Size_Max);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : DestinationOrderQosPolicyKind) is
   begin
      Write (To, Item'Image);
   end Write;

   procedure Write (To : Stream; Item : DestinationOrderQosPolicyScopeKind) is
   begin
      Write (To, Item'Image);
   end Write;

   procedure Write (To : Stream; Item : TopicDataQosPolicy) is
   begin
      Write (To, Item.Value);
   end Write;

   procedure Write (To : Stream; Item : Tags_T) is
   begin
      Write (To, "{");
      Write (To, """Name"" : "); Write (To, Item.Name); Write (To, "," & ASCII.LF);
      Write (To, """Value"" : "); Write (To, Item.Value);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : DataTagQosPolicy) is
   begin
      Write (To, Item.Value);
   end Write;

   procedure Write (To : Stream; Item : PresentationQosPolicyAccessScopeKind) is
   begin
      Write (To => To, Item => (case Item is
                                   when INSTANCE_PRESENTATION_QOS        => """INSTANCE_PRESENTATION_QOS""",
                                   when TOPIC_PRESENTATION_QOS           => """TOPIC_PRESENTATION_QOS""",
                                   when GROUP_PRESENTATION_QOS           => """GROUP_PRESENTATION_QOS""",
                                   when HIGHEST_OFFERED_PRESENTATION_QOS => """HIGHEST_OFFERED_PRESENTATION_QOS""",
                                   when others                           => """<ILEGAL_PRESENTATION_QOS>"""
                               ));
   end Write;

   procedure Write (To : Stream; Item : DestinationOrderQosPolicy) is
   begin
      Write (To, "{");
      Write (To, """Kind"" : "); Write (To, Item.Kind); Write (To, "," & ASCII.LF);
      Write (To, """Scope"" : "); Write (To, Item.Scope); Write (To, "," & ASCII.LF);
      Write (To, """Source_Timestamp_Tolerance"" : "); Write (To, Item.Source_Timestamp_Tolerance);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : PresentationQosPolicy) is
   begin
      Write (To, "{");
      Write (To, """Access_Scope"" : "); Write (To, Item.Access_Scope); Write (To, "," & ASCII.LF);
      Write (To, """Coherent_Access"" : "); Write (To, Item.Coherent_Access); Write (To, "," & ASCII.LF);
      Write (To, """Ordered_Access"" : "); Write (To, Item.Ordered_Access);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : DurabilityQosPolicyKind) is
   begin
      Write (To, Item'Image);
   end Write;
   procedure Write (To : Stream; Item : ServiceQosPolicy) is
   begin

      Write (To => To, Item => (case Item.Kind is
                                   when NO_SERVICE_QOS                   => """NO_SERVICE_QOS""",
                                   when PERSISTENCE_SERVICE_QOS          => """PERSISTENCE_SERVICE_QOS""",
                                   when QUEUING_SERVICE_QOS              => """QUEUING_SERVICE_QOS""",
                                   when ROUTING_SERVICE_QOS              => """ROUTING_SERVICE_QOS""",
                                   when RECORDING_SERVICE_QOS            => """RECORDING_SERVICE_QOS""",
                                   when REPLAY_SERVICE_QOS               => """REPLAY_SERVICE_QOS""",
                                   when DATABASE_INTEGRATION_SERVICE_QOS => """DATABASE_INTEGRATION_SERVICE_QOS""",
                                   when DDS_WEB_INTEGRATION_SERVICE_QOS  => """DDS_WEB_INTEGRATION_SERVICE_QOS""",
                                   when others                           => """<ILEGAL_SERVICE_QOS>"""
                               ));
   end Write;

   procedure Write (To : Stream; Item : DurabilityQosPolicy) is
   begin
      Write (To, "{");
      Write (To, """Kind"" : "); Write (To, Item.Kind); Write (To, "," & ASCII.LF);
      Write (To, """Direct_Communication"" : "); Write (To, Item.Direct_Communication); Write (To, "," & ASCII.LF);
      Write (To, """Writer_Depth"" : "); Write (To, Item.Writer_Depth);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : LivelinessQosPolicyKind) is
   begin
      Write (To => To, Item => (case Item is
                                   when AUTOMATIC_LIVELINESS_QOS             => """AUTOMATIC_LIVELINESS_QOS""",
                                   when MANUAL_BY_PARTICIPANT_LIVELINESS_QOS => """MANUAL_BY_PARTICIPANT_LIVELINESS_QOS""",
                                   when MANUAL_BY_TOPIC_LIVELINESS_QOS       => """MANUAL_BY_TOPIC_LIVELINESS_QOS""",
                                   when others                               => """<ILEGAL_LIVELINESS_QOS>"""
                               ));
   end Write;

   procedure Write (To : Stream; Item : LivelinessQosPolicy) is
   begin
      Write (To, "{");
      Write (To, """Kind"" : "); Write (To, Item.Kind); Write (To, "," & ASCII.LF);
      Write (To, """Lease_Duration"" : "); Write (To, Item.Lease_Duration); Write (To, "," & ASCII.LF);
      Write (To, """Assertions_Per_Lease_Duration"" : "); Write (To, Item.Assertions_Per_Lease_Duration);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : DeadlineQosPolicy) is
   begin
      Write (To, "{");
      Write (To, """Period"" : "); Write (To, Item.Period);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : LatencyBudgetQosPolicy) is
   begin
      Write (To, "{");
      Write (To, """Duration"" : "); Write (To, Item.Duration);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : DataRepresentationId_T) is
   begin
      Write (To => To, Item => (if Item = XCDR_DATA_REPRESENTATION then """XCDR_DATA_REPRESENTATION"""
                                elsif Item = XML_DATA_REPRESENTATION then """XML_DATA_REPRESENTATION"""
                                elsif Item = XCDR2_DATA_REPRESENTATION then """XCDR2_DATA_REPRESENTATION"""
                                elsif Item = AUTO_DATA_REPRESENTATION  then """AUTO_DATA_REPRESENTATION"""
                                else                                """<ILEGAL_DATA_REPRESENTATION>"""
                               ));
   end Write;

   procedure Write (To : Stream; Item : CompressionSettings_T) is
   begin
      Write (To, "{");
      Write (To, """Compression_Ids"" : "); Write (To, Item.Compression_Ids); Write (To, "," & ASCII.LF);
      Write (To, """Writer_Compression_Level"" : "); Write (To, Item.Writer_Compression_Level); Write (To, "," & ASCII.LF);
      Write (To, """Writer_Compression_Threshold"" : "); Write (To, Item.Writer_Compression_Threshold);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : DataRepresentationQosPolicy) is
   begin
      Write (To, "{");
      Write (To, """Value"" : "); Write (To, Item.Value); Write (To, "," & ASCII.LF);
      Write (To, """Compression_Settings"" : "); Write (To, Item.Compression_Settings);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : ParticipantTrustAttributesMask) is
   begin
      Write (To, Item'Image);
   end Write;

   procedure Write (To : Stream; Item : PluginParticipantTrustAttributesMask) is
   begin
      Write (To, Item'Image);
   end Write;

   procedure Write (To : Stream; Item : EndpointTrustAttributesMask) is
   begin
      Write (To, Item'Image);
   end Write;
   procedure Write (To : Stream; Item : PluginEndpointTrustAttributesMask) is
   begin
      Write (To, Item'Image);
   end Write;

   procedure Write (To : Stream; Item : EndpointTrustProtectionInfo) is
   begin
      Write (To, "{""bitmask"" : "); Write (To, Item.Bitmask); Write (To, "," & ASCII.LF);
      Write (To, " ""plugin_bitmask"" : "); Write (To, Item.Plugin_Bitmask); Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : TrustAlgorithmSet) is
   begin
      Write (To, Item'Image);
   end Write;

   procedure Write (To : Stream; Item : TrustAlgorithmRequirements) is
   begin
      Write (To, "{""supported_mask"" : "); Write (To, Item.Supported_Mask); Write (To, "," & ASCII.LF);
      Write (To, " ""required_mask"" : "); Write (To, Item.Required_Mask); Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : ParticipantTrustSignatureAlgorithmInfo) is
   begin
      Write (To, "{""trust_chain"" : "); Write (To, Item.Trust_Chain); Write (To, "," & ASCII.LF);
      Write (To, " ""message_auth"" : "); Write (To, Item.Message_Auth); Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : ParticipantTrustKeyEstablishmentAlgorithmInfo) is
   begin
      Write (To, "{""shared_secret"" : "); Write (To, Item.Shared_Secret); Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : ParticipantTrustInterceptorAlgorithmInfo) is
   begin
      Write (To, "{""supported_mask"" : "); Write (To, Item.Supported_Mask); Write (To, "," & ASCII.LF);
      Write (To, " ""builtin_endpoints_required_mask"" : "); Write (To, Item.Builtin_Endpoints_Required_Mask); Write (To, "," & ASCII.LF);
      Write (To, " ""builtin_kx_endpoints_required_mask"" : "); Write (To, Item.Builtin_Kx_Endpoints_Required_Mask); Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : ParticipantTrustAlgorithmInfo) is
   begin
      Write (To, "{""signature"" : "); Write (To, Item.Signature); Write (To, "," & ASCII.LF);
      Write (To, " ""key_establishment"" : "); Write (To, Item.Key_Establishment); Write (To, "," & ASCII.LF);
      Write (To, " ""interceptor"" : "); Write (To, Item.Interceptor); Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : EndpointTrustInterceptorAlgorithmInfo) is
   begin
      Write (To, "{""required_mask"" : "); Write (To, Item.Required_Mask); Write (To, "," & ASCII.LF);
      Write (To, " ""supported_mask"" : "); Write (To, Item.Supported_Mask); Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : EndpointTrustAlgorithmInfo) is
   begin
      Write (To, "{""interceptor"" : "); Write (To, Item.Interceptor); Write (To, "}");
   end Write;

   --
   procedure Write (To : Stream; Item : GroupDataQosPolicy) is
   begin
      Write (To, Item.Value);
   end Write;

   procedure Write (To : Stream; Item : ParticipantTrustProtectionInfo) is
   begin
      Write (To, "{""bitmask"" : "); Write (To, Item.Bitmask); Write (To, "," & ASCII.LF);
      Write (To, " ""plugin_bitmask"" : "); Write (To, Item.Plugin_Bitmask); Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : ContentFilterProperty_T) is
   begin
      Write (To, "{");
      Write (To, """Content_Filter_Topic_Name"" : "); Write (To, Item.Content_Filter_Topic_Name); Write (To, "," & ASCII.LF);
      Write (To, """Related_Topic_Name"" : "); Write (To, Item.Related_Topic_Name); Write (To, "," & ASCII.LF);
      Write (To, """Filter_Class_Name"" : "); Write (To, Item.Filter_Class_Name); Write (To, "," & ASCII.LF);
      Write (To, """Filter_Expression"" : "); Write (To, Item.Filter_Expression); Write (To, "," & ASCII.LF);
      Write (To, """Expression_Parameters"" : "); Write (To, Item.Expression_Parameters);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : DDS.ParticipantBuiltinTopicData) is
   begin
      Write (To, "{");
      Write (To, """Key"" : "); Write (To, Item.Key); Write (To, "," & ASCII.LF);
      Write (To, """User_Data"" : "); Write (To, Item.User_Data); Write (To, "," & ASCII.LF);
      Write (To, """Property"" : "); Write (To, Item.Property); Write (To, "," & ASCII.LF);
      Write (To, """Rtps_Vendor_Id"" : "); Write (To, Item.Rtps_Vendor_Id); Write (To, "," & ASCII.LF);
      Write (To, """Dds_Builtin_Endpoints"" : "); Write (To, Item.Dds_Builtin_Endpoints); Write (To, "," & ASCII.LF);
      Write (To, """Metatraffic_Unicast_Locators"" : "); Write (To, Item.Metatraffic_Unicast_Locators); Write (To, "," & ASCII.LF);
      Write (To, """Metatraffic_Multicast_Locators"" : "); Write (To, Item.Metatraffic_Multicast_Locators); Write (To, "," & ASCII.LF);
      Write (To, """Default_Unicast_Locators"" : "); Write (To, Item.Default_Unicast_Locators); Write (To, "," & ASCII.LF);
      Write (To, """Lease_Duration"" : "); Write (To, Item.Lease_Duration); Write (To, "," & ASCII.LF);
      Write (To, """Participant_Name"" : "); Write (To, Item.Participant_Name); Write (To, "," & ASCII.LF);
      Write (To, """Domain_Id"" : "); Write (To, Item.Domain_Id); Write (To, "," & ASCII.LF);
      Write (To, """Transport_Info"" : "); Write (To, Item.Transport_Info); Write (To, "," & ASCII.LF);
      Write (To, """Reachability_Lease_Duration"" : "); Write (To, Item.Reachability_Lease_Duration); Write (To, "," & ASCII.LF);
      Write (To, """partition"" : "); Write (To, Item.Partition); Write (To, "," & ASCII.LF);
      Write (To, """trust_protection_info"" : "); Write (To, Item.Trust_Protection_Info); Write (To, "," & ASCII.LF);
      Write (To, """trust_algorithm_info"" : "); Write (To, Item.Trust_Algorithm_Info); Write (To, "," & ASCII.LF);
      Write (To, """partial_configuration"" : "); Write (To, Item.Partial_Configuration); Write (To, "," & ASCII.LF);
      Write (To, """vendor_builtin_endpoints"" : "); Write (To, Item.Vendor_Builtin_Endpoints); Write (To, "," & ASCII.LF);
      Write (To, """service"" : "); Write (To, Item.Service);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : DDS.PublicationBuiltinTopicData) is
   begin
      Write (To, "{");
      Write (To, """Key"" : "); Write (To, Item.Key); Write (To, "," & ASCII.LF);
      Write (To, """Participant_Key"" : "); Write (To, Item.Participant_Key); Write (To, "," & ASCII.LF);
      Write (To, """Topic_Name"" : "); Write (To, Item.Topic_Name); Write (To, "," & ASCII.LF);
      Write (To, """Type_Name"" : "); Write (To, Item.Type_Name); Write (To, "," & ASCII.LF);
      Write (To, """User_Data"" : "); Write (To, Item.User_Data); Write (To, "," & ASCII.LF);
      Write (To, """Ownership"" : "); Write (To, Item.Ownership); Write (To, "," & ASCII.LF);
      Write (To, """Ownership_Strength"" : "); Write (To, Item.Ownership_Strength); Write (To, "," & ASCII.LF);
      Write (To, """Destination_Order"" : "); Write (To, Item.Destination_Order); Write (To, "," & ASCII.LF);
      Write (To, """Presentation"" : "); Write (To, Item.Presentation); Write (To, "," & ASCII.LF);
      Write (To, """Partition"" : "); Write (To, Item.Partition); Write (To, "," & ASCII.LF);
      Write (To, """Topic_Data"" : "); Write (To, Item.Topic_Data); Write (To, "," & ASCII.LF);
      Write (To, """Group_Data"" : "); Write (To, Item.Group_Data); Write (To, "," & ASCII.LF);
      Write (To, """Data_Tags"" : "); Write (To, Item.Data_Tags); Write (To, "," & ASCII.LF);
      Write (To, """Publisher_Key"" : "); Write (To, Item.Publisher_Key); Write (To, "," & ASCII.LF);
      Write (To, """Property"" : "); Write (To, Item.Property); Write (To, "," & ASCII.LF);
      Write (To, """Unicast_Locators"" : "); Write (To, Item.Unicast_Locators); Write (To, "," & ASCII.LF);
      Write (To, """Virtual_Guid"" : "); Write (To, Item.Virtual_Guid); Write (To, "," & ASCII.LF);
      --  ...
      Write (To, """Publication_Name"" : "); Write (To, Item.Publication_Name);
      Write (To, "}");
   end Write;

   procedure Write (To : Stream; Item : DDS.SubscriptionBuiltinTopicData) is
   begin
      Write (To, "{");
      Write (To, """Key"" : "); Write (To, Item.Key); Write (To, "," & ASCII.LF);
      Write (To, """Participant_Key"" : "); Write (To, Item.Participant_Key); Write (To, "," & ASCII.LF);
      Write (To, """Topic_Name"" : "); Write (To, Item.Topic_Name); Write (To, "," & ASCII.LF);
      Write (To, """Type_Name"" : "); Write (To, Item.Type_Name); Write (To, "," & ASCII.LF);
      Write (To, """User_Data"" : "); Write (To, Item.User_Data); Write (To, "," & ASCII.LF);
      Write (To, """Durability"" : "); Write (To, Item.Durability); Write (To, "," & ASCII.LF);
      Write (To, """Deadline"" : "); Write (To, Item.Deadline); Write (To, "," & ASCII.LF);
      Write (To, """Latency_Budget"" : "); Write (To, Item.Latency_Budget); Write (To, "," & ASCII.LF);
      Write (To, """Liveliness"" : "); Write (To, Item.Liveliness); Write (To, "," & ASCII.LF);
      Write (To, """Ownership"" : "); Write (To, Item.Ownership); Write (To, "," & ASCII.LF);
      Write (To, """Destination_Order"" : "); Write (To, Item.Destination_Order); Write (To, "," & ASCII.LF);
      Write (To, """Partition"" : "); Write (To, Item.Partition); Write (To, "," & ASCII.LF);
      Write (To, """Topic_Data"" : "); Write (To, Item.Topic_Data); Write (To, "," & ASCII.LF);
      Write (To, """Representation"" : "); Write (To, Item.Representation); Write (To, "," & ASCII.LF);
      Write (To, """Data_Tags"" : "); Write (To, Item.Data_Tags); Write (To, "," & ASCII.LF);
      Write (To, """Subscriber_Key"" : "); Write (To, Item.Subscriber_Key); Write (To, "," & ASCII.LF);
      Write (To, """Unicast_Locators"" : "); Write (To, Item.Unicast_Locators); Write (To, "," & ASCII.LF);
      Write (To, """Multicast_Locators"" : "); Write (To, Item.Multicast_Locators); Write (To, "," & ASCII.LF);
      Write (To, """Content_Filter_Property"" : "); Write (To, Item.Content_Filter_Property); Write (To, "," & ASCII.LF);
      Write (To, """Virtual_Guid"" : "); Write (To, Item.Virtual_Guid); Write (To, "," & ASCII.LF);
      Write (To, """Service"" : "); Write (To, Item.Service); Write (To, "," & ASCII.LF);
      --  ...
      Write (To, """Subscription_Name"" : "); Write (To, Item.Subscription_Name);

      Write (To, "}");
   end Write;

end DDS.JSON_Out_Generic;
