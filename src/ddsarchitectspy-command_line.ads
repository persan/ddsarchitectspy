with Ada.Strings.Unbounded;
with DDS;
with GNATCOLL.Opt_Parse;

package Ddsarchitectspy.Command_Line is
   use Ada.Strings.Unbounded;
   use GNATCOLL.Opt_Parse;

   Parser : Argument_Parser := Create_Argument_Parser
     (Help =>
        "DDSArchitect spy (" & VERSION & ")captures the domain architecture to format dependin on filename suffix:" & ASCII.LF &
        "  .json   - JSON format (default)" & ASCII.LF &
        "  .xmi    - XMI  suited for modelling tools." & ASCII.LF &
        "  .xml    - DDS xml format suited for RTI System designer." & ASCII.LF &
        "  others  - An Ada inspired text format."
     );

   --  package Quiet is new Parse_Flag
   --    (Parser => Parser,
   --     Short  => "-q",
   --     Long   => "--quiet",
   --     Help   => "Whether the tool should be quiet or not");

   package Version is new Parse_Flag
     (Parser => Parser,
      Short  => "-v",
      Long   => "--version",
      Help   => "Prints version number and exits");

   function Convert (Arg : String) return DDS.DomainId_T is (DDS.DomainId_T'Value (Arg));

   Default_DomainId : constant DDS.DomainId_T := 0;

   package DomainId is new Parse_Option
     (Parser      => Parser,
      Long        => "--domainId",
      Arg_Type    => DDS.DomainId_T,
      Help        => "Sets the domainId (default " & Default_DomainId'Img & ").",
      Default_Val => Default_DomainId);

   function Convert (Arg : String) return Duration is
     (Duration'Value (Arg));

   package DiscoveryTime is new Parse_Option
     (Parser      => Parser,
      Short       => "-t",
      Long        => "--discoverytime",
      Arg_Type    => Duration,
      Help        => "Time to wait for discovery to complete (default 5.0 sec).",
      Default_Val => 5.0);

   Default_SaveTo  : constant String := "architechure.json";
   package SaveTo is new Parse_Option
     (Parser      => Parser,
      Short       => "-o",
      Long        => "--output",
      Arg_Type    => Ada.Strings.Unbounded.Unbounded_String,
      Help        => "File to save arhitecture file suffix will select format (default """ & Default_SaveTo & """).",
      Default_Val => To_Unbounded_String (Source => Default_SaveTo));

   --  package Verbosity is new Parse_Option
   --    (Parser      => Parser,
   --     Long        => "--verbosity",
   --     Arg_Type    => Natural,
   --     Help        => "Sets verbosity level (default 1 --> error) Possible values 0..5",
   --     Default_Val => 1);

end Ddsarchitectspy.Command_Line;
