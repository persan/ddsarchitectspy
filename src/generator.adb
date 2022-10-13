with Ada.Text_IO; use Ada.Text_IO;
with Libadalang.Common; use Libadalang.Common;

package body generator is

   procedure Process_Unit (Context : App_Job_Context; Unit : Analysis_Unit) is
      pragma Unreferenced (Context);

      function Visit (Node : Ada_Node'Class) return Visit_Status;

      function Visit_Ada_Record_Type_Def (Node : Ada_Node'Class) return Visit_Status;
      function Visit_Ada_Record_Type_Def (Node : Ada_Node'Class) return Visit_Status is
      begin
         case Node.Kind is
         when Ada_Defining_Name =>
            Put_Line ("      Found name : " & Node.Image);
            return Over;
         when others =>
            return Into;
         end case;
         return Over;
      end;

      function Visit_Type_def (Node : Ada_Node'Class) return Visit_Status;
      function Visit_Type_def (Node : Ada_Node'Class) return Visit_Status is
      begin
         case Node.Kind is
         when Ada_Record_Type_Def =>
            Put_Line ("   Found record : " & Node.Image);
            Node.Traverse (Visit_Ada_Record_Type_Def'Access);
            return Over;
         when others =>
            return Into;
         end case;
         return Over;
      end;

      function Visit (Node : Ada_Node'Class) return Visit_Status is
      begin
         case Node.Kind is
         when Ada_Type_Decl =>
            Put_Line ("Found Type : " & Node.Image);
            Node.Traverse (Visit_Type_def'Access);
            return Over;
         when others =>
            return Into;
         end case;
      end Visit;
   begin
      Unit.Root.Traverse (Visit'Access);
   end Process_Unit;
end generator;
