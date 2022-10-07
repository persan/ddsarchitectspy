with Ada.Strings.Unbounded;
with DDS;
with GNATCOLL.Opt_Parse;

package ddsarchitectspy.Command_Line is
   use Ada.Strings.Unbounded;
   use GNATCOLL.Opt_Parse;

   Parser : Argument_Parser := Create_Argument_Parser
     (Help => "DDSArchitect spy captures the domain architecture to a json format");

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

   function Convert (Arg : String) return Duration is
     (Duration'Value (Arg));

   package DiscoveryTime is new Parse_Option
     (Parser      => Parser,
      Short       => "-t",
      Long        => "--discoverytime",
      Arg_Type    => Duration,
      Help        => "Time to wait for discovery to complete (default 10.0).",
      Default_Val => 10.0);

   package SaveTo is new Parse_Option
     (Parser      => Parser,
      Short       => "-o",
      Long        => "--output",
      Arg_Type    => Ada.Strings.Unbounded.Unbounded_String,
      Help        => "File to save arhitecture (default ""architechure.json"").",
      Default_Val => To_Unbounded_String (Source => "architechure.json"));

   package Verbosity is new Parse_Option
     (Parser      => Parser,
      Long        => "--verbosity",
      Arg_Type    => Natural,
      Help        => "Sets verbosity level (default 1 --> error) Possible values 0..5",
      Default_Val => 1);

end ddsarchitectspy.Command_Line;
