with dds.DomainParticipant;
with DDS.Entity;
with Ada.Containers;

package DDSArchitectSpy_DDS is
   function Lookup_Entity
     (Self : DDS.DomainParticipant.Ref_Access;
      Key  : aliased Dds.BuiltinTopicKey_T)
      return DDS.Entity.Ref_Access;

   function Hash (Item : DDS.BuiltinTopicKey_T) return Ada.Containers.Hash_Type;

   function Hash (Item : DDS.ParticipantBuiltinTopicData) return Ada.Containers.Hash_Type;
   function Hash (Item : DDS.PublicationBuiltinTopicData) return Ada.Containers.Hash_Type;
   function Hash (Item : DDS.SubscriptionBuiltinTopicData) return Ada.Containers.Hash_Type;
end DDSArchitectSpy_DDS;
