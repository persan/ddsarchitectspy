with DDS.DomainParticipant;
with DDS.Entity;
with Ada.Containers;
package DDSArchitectSpy.DDSExtra is
--  DDS.DomainParticipant

   --  DDS
   function Hash (Item : DDS.BuiltinTopicKey_T) return Ada.Containers.Hash_Type;

   --  function Lookup_Entity (Self : not null access DDS.DomainParticipant.Ref;
   function Lookup_Entity (Self : DDS.DomainParticipant.Ref_Access;
                           Key  : aliased Dds.BuiltinTopicKey_T)  return DDS.Entity.Ref_Access;

end DDSArchitectSpy.DDSExtra;
