with RTIDDS.Low_Level.ndds_dds_c_dds_c_domain_h;
with System;
with Ada.Unchecked_Conversion;
with RTIDDS.Low_Level.ndds_dds_c_dds_c_infrastructure_h;
with RTIDDS.Low_Level.ndds_dds_c_dds_c_infrastructure_impl_h;
with Ada.Strings.Hash;
package body DDSArchitectSpy.DDSExtra is
   use RTIDDS.Low_Level.Ndds_Dds_C_Dds_C_Domain_H;
   use RTIDDS.Low_Level.Ndds_Dds_C_Dds_C_Infrastructure_Impl_H;
   -------------------
   -- Lookup_Entity --
   -------------------

   function Lookup_Entity
     (Self : DDS.DomainParticipant.Ref_Access;
      Key  : aliased Dds.BuiltinTopicKey_T)
      return DDS.Entity.Ref_Access
   is
      type DDS_DomainParticipant_Access is access all RTIDDS.Low_Level.ndds_dds_c_dds_c_infrastructure_h.DDS_DomainParticipant with Storage_Size => 0;
      type DDS_BuiltinTopicKey_T_Access is access all RTIDDS.Low_Level.ndds_dds_c_dds_c_infrastructure_h.DDS_BuiltinTopicKey_t with Storage_Size => 0;

      function As_DDS_BuiltinTopicKey_T_Access is new Ada.Unchecked_Conversion (System.Address, DDS_BuiltinTopicKey_T_Access);
      function As_DDS_DomainParticipant_Access is new Ada.Unchecked_Conversion (System.Address, DDS_DomainParticipant_Access);
      function As_Entity_Ref_Access is new Ada.Unchecked_Conversion (System.Address, DDS.Entity.Ref_Access);
      E : access RTIDDS.Low_Level.ndds_dds_c_dds_c_infrastructure_h.DDS_Entity;
   begin
      E := DDS_DomainParticipant_Lookup_Entity
                (Self =>  As_DDS_DomainParticipant_Access (Self.GetInterface),
                 Key  =>  As_DDS_BuiltinTopicKey_T_Access (Key'Address));
      return (if E /= null then As_Entity_Ref_Access
              (DDS_Entity_Get_User_DataI
                 (Self => E)) else null);

   end Lookup_Entity;

   function Hash (Item : DDS.BuiltinTopicKey_T) return Ada.Containers.Hash_Type is
      S : String (1 .. Item'Size / Character'Size) with
        Import => True,
        Address => Item'Address;
   begin
      return Ada.Strings.Hash (S);
   end;

end DDSArchitectSpy.DDSExtra;
