with DDS.DomainParticipant;
with DDS.Entity;
package DDSArchitectSpy.DDSExtra is
--  DDS.DomainParticipant

   --  function Lookup_Entity (Self : not null access DDS.DomainParticipant.Ref;
   function Lookup_Entity (Self : DDS.DomainParticipant.Ref_Access;
                           Key  : aliased Dds.BuiltinTopicKey_T)  return DDS.Entity.Ref_Access;

end DDSArchitectSpy.DDSExtra;
