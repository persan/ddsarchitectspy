with Ada.Text_IO.Text_Streams;
package body DDSArchitectSpy.XMI is

   -----------
   -- Write --
   -----------

   procedure Write
     (To : not null access  Ada.Streams.Root_Stream_Type'Class; Item : DDSArchitectSpy.Participant_Contianer)
   is
   begin
      pragma Compile_Time_Warning (Standard.True, "Write unimplemented");
      raise Program_Error with "Unimplemented procedure Write";
   end Write;

   -----------
   -- Write --
   -----------

   procedure Write (To_Path : String; Item : Participant_Contianer)
   is
      F : Ada.Text_IO.File_Type;
   begin
      F.Create (Ada.Text_Io.Out_File, To_Path);
      Write (Ada.Text_IO.Text_Streams.Stream (F), Item);
      F.close;
   end Write;

end DDSArchitectSpy.XMI;
