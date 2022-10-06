with GNATCOLL.Opt_Parse;
with DDS;
package ddsarchitectspy.Command_Line is
   use GNATCOLL.Opt_Parse;
   Parser : Argument_Parser := Create_Argument_Parser
     (Help => "Help string for the parser");

   package Quiet is new Parse_Flag
     (Parser => Parser,
      Short  => "-q",
      Long   => "--quiet",
      Help   => "Whether the tool should be quiet or not");

   package Version is new Parse_Flag
     (Parser => Parser,
      Short  => "-v",
      Long   => "--version",
      Help   => "Prints version number and exits");

   function Convert (Arg : String) return DDS.DomainId_T is
     (DDS.DomainId_T'Value (Arg));

   package domainId is new Parse_Option
     (Parser      => Parser,
      Long        => "--domainId",
      Arg_Type    => DDS.DomainId_T,
      Help        => "Sets the domainId (default 0).",
      Default_Val => 0);

   package verbosity is new Parse_Option
     (Parser      => Parser,
      Long        => "--verbosity",
      Arg_Type    => Natural,
      Help        => "Sets verbosity level (default 1 --> error) Possible values 0..5",
      Default_Val => 1);

end ddsarchitectspy.Command_Line;
