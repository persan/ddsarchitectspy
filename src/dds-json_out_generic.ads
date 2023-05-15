with DDS_Support.Sequences_Generic.Write_JSON_Generic;
generic
   type Stream is private;
   with procedure Write (To : Stream; Item : Standard.String);
package DDS.JSON_Out_Generic is
   procedure Write (To : Stream; Item : DDS.BuiltinTopicKey_T);
   procedure Write (To : Stream; Item : DDS.String);
   procedure Write (To : Stream; Item : DDS.EntityNameQosPolicy);
   procedure Write (To : Stream; Item : Natural);
   procedure Write (To : Stream; Item : Octet);
   procedure Write is new Octet_Seq.Write_JSON_Generic (Stream, Write, Write);
   procedure Write (To : Stream; Item : UserDataQosPolicy);
   procedure Write (To : Stream; Item : DDS.Boolean);
   procedure Write (To : Stream; Item : Property_T);
   procedure Write is new Property_T_Seq.Write_JSON_Generic (Stream, Write, Write);
   procedure Write (To : Stream; Item : PropertyQosPolicy);
   procedure Write (To : Stream; Item : VendorId_Array_T);
   procedure Write (To : Stream; Item : VendorId_T);
   procedure Write (To : Stream; Item : DomainId_T);
   procedure Write (To : Stream; Item : EncapsulationId_T);
   procedure Write (To : Stream; Item : Transport_ClassId_T);
   procedure Write (To : Stream; Item : Unsigned_Long);
   procedure Write is new EncapsulationId_Seq.Write_JSON_Generic (Stream, Write, Write);
   procedure Write (To : Stream; Item : Locator_Address_Array_T);
   procedure Write (To : Stream; Item : GUID_T_Value_Array);
   procedure Write (To : Stream; Item : Guid_T);
   procedure Write (To : Stream; Item : Duration_T);
   procedure Write (To : Stream; Item : Locator_T);
   procedure Write (To : Stream; Item : OwnershipQosPolicyKind);
   procedure Write (To : Stream; Item : OwnershipQosPolicy);
   procedure Write is new DDS.String_Seq.Write_JSON_Generic (Stream, Write, Write);
   procedure Write (To : Stream; Item : PartitionQosPolicy);
   procedure Write (To : Stream; Item : OwnershipStrengthQosPolicy);
   procedure Write (To : Stream; Item : TransportInfo_T);
   procedure Write (To : Stream; Item : DestinationOrderQosPolicyKind);
   procedure Write (To : Stream; Item : DestinationOrderQosPolicyScopeKind);
   procedure Write (To : Stream; Item : TopicDataQosPolicy);
   procedure Write (To : Stream; Item : Tags_T);
   procedure Write is new DDS.Tags_Seq.Write_JSON_Generic (Stream, Write, Write);
   procedure Write (To : Stream; Item : DataTagQosPolicy);
   procedure Write (To : Stream; Item : PresentationQosPolicyAccessScopeKind);
   procedure Write (To : Stream; Item : DestinationOrderQosPolicy);
   procedure Write (To : Stream; Item : PresentationQosPolicy);
   procedure Write (To : Stream; Item : DurabilityQosPolicyKind);
   procedure Write (To : Stream; Item : ServiceQosPolicy);
   procedure Write (To : Stream; Item : DurabilityQosPolicy);
   procedure Write (To : Stream; Item : LivelinessQosPolicyKind);
   procedure Write (To : Stream; Item : LivelinessQosPolicy);
   procedure Write (To : Stream; Item : DeadlineQosPolicy);
   procedure Write (To : Stream; Item : LatencyBudgetQosPolicy);
   procedure Write is new DDS.Locator_Seq.Write_JSON_Generic (Stream, Write, Write);
   procedure Write (To : Stream; Item : DataRepresentationId_T);
   procedure Write is new DDS.DataRepresentationId_Seq.Write_JSON_Generic (Stream, Write, Write);
   procedure Write (To : Stream; Item : CompressionSettings_T);
   procedure Write (To : Stream; Item : DataRepresentationQosPolicy);
   procedure Write (To : Stream; Item : ParticipantTrustAttributesMask);
   procedure Write (To : Stream; Item : PluginParticipantTrustAttributesMask);

   procedure Write (To : Stream; Item : EndpointTrustProtectionInfo);
   procedure Write (To : Stream; Item : TrustAlgorithmRequirements);
   procedure Write (To : Stream; Item : ParticipantTrustSignatureAlgorithmInfo);
   procedure Write (To : Stream; Item : ParticipantTrustKeyEstablishmentAlgorithmInfo);
   procedure Write (To : Stream; Item : ParticipantTrustInterceptorAlgorithmInfo);
   procedure Write (To : Stream; Item : ParticipantTrustAlgorithmInfo);
   procedure Write (To : Stream; Item : EndpointTrustInterceptorAlgorithmInfo);
   procedure Write (To : Stream; Item : EndpointTrustAlgorithmInfo);

   procedure Write (To : Stream; Item : GroupDataQosPolicy);
   --  procedure Write (To : Stream; Item : TrustKeyEstablishmentBit);
   --  procedure Write (To : Stream; Item : ParticipantTrustKeyEstablishmentAlgorithms);
   --  procedure Write (To : Stream; Item : ParticipantTrustAlgorithms);
   procedure Write (To : Stream; Item : ContentFilterProperty_T);
   procedure Write is new DDS.TransportInfo_Seq.Write_JSON_Generic (Stream, Write, Write);
   procedure Write (To : Stream; Item : DDS.ParticipantBuiltinTopicData);
   procedure Write (To : Stream; Item : DDS.PublicationBuiltinTopicData);
   procedure Write (To : Stream; Item : DDS.SubscriptionBuiltinTopicData);

   generic
      type Element_Type is private;
      type Index_Type is (<>);
      type Array_Type is array (Index_Type range <>) of Element_Type;
      with procedure Write (To : Stream; Item : Element_Type);
   procedure Write_Array_Generic (To : Stream; Item : Array_Type);

end DDS.JSON_Out_Generic;
