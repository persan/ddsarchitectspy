import GPS
import libadalang


def ada2file(name: str) -> str:
    return name.lower().replace(".", "-")


specialSpec = {
        "Short": ["""procedure Write (To : Stream; Item : DDS.Short);""",
                  """procedure Write (To : Stream; Item : DDS.Short) is
begin
   Write(To, Item'Image);
end Write;
"""],

        "Long": ["""procedure Write (To : Stream; Item : DDS.Long);""",
                  """procedure Write (To : Stream; Item : DDS.Long) is
begin
   Write(To, Item'Image);
end Write;
"""],
        "Long_Long": ["""procedure Write (To : Stream; Item : DDS.Long_Long);""",
                  """procedure Write (To : Stream; Item : DDS.Long_Long) is
begin
   Write(To, Item'Image);
end Write;
"""],
        "Unsigned_Short": ["""procedure Write (To : Stream; Item : DDS.Unsigned_Short);""",
                  """procedure Write (To : Stream; Item : DDS.Unsigned_Short) is
begin
   Write(To, Item'Image);
end Write;
"""],
        "Unsigned_Long": ["""procedure Write (To : Stream; Item : DDS.Unsigned_Long);""",
                  """procedure Write (To : Stream; Item : DDS.Unsigned_Long) is
begin
   Write(To, Item'Image);
end Write;
"""],
        "Unsigned_Long_Long": ["""procedure Write (To : Stream; Item : DDS.Unsigned_Long_Long);""",
                  """procedure Write (To : Stream; Item : DDS.Unsigned_Long_Long) is
begin
   Write(To, Item'Image);
end Write;
"""],
        "Enum": ["""procedure Write (To : Stream; Item : DDS.Enum);""",
                  """procedure Write (To : Stream; Item : DDS.Enum) is
begin
   Write(To, Item'Image);
end Write;
"""],
        "Float": ["""procedure Write (To : Stream; Item : DDS.Float);""",
                  """procedure Write (To : Stream; Item : DDS.Float) is
begin
   Write(To, Item'Image);
end Write;
"""],
        "Double": ["""procedure Write (To : Stream; Item : DDS.Double);""",
                  """procedure Write (To : Stream; Item : DDS.Double) is
begin
   Write(To, Item'Image);
end Write;
"""],
        "Long_Double": ["""procedure Write (To : Stream; Item : DDS.Long_Double);""",
                  """procedure Write (To : Stream; Item : DDS.Long_Double) is
begin
   Write(To, Item'Image);
end Write;
"""],
        "DomainId_T": ["""procedure Write (To : Stream; Item : DDS.DomainId_T);""",
                  """procedure Write (To : Stream; Item : DDS.DomainId_T) is
begin
   Write(To, Item'Image);
end Write;
"""]
    }

class JSONGen:
    def __init__(self, filename):
        context = libadalang.AnalysisContext()
        unit = context.get_from_file(filename)
        for d in unit.diagnostics:
            print("{}: {}".format(filename, d))
            return
        self.spec = []
        self.body = []
        if unit.root:
            self.SrcName = unit.root.children[1].children[1].children[0].text
            self.targetName = self.SrcName + ".JSON"
            self.spec.append("DDS_Support.Sequences_Generic.Write_JSON_Generic\n")
            self.spec.append("generic\n")
            self.spec.append("   type Stream is private;\n")
            self.spec.append("   with procedure Write (To : Stream; Item : Standard.String);\n")
            self.spec.append("package %s is\n" % self.targetName)
            self.body.append("package body %s is\n" % self.targetName)

            for i in unit.root.children[1].children[1].children[2].children[0].children:
                if i.is_a(libadalang.GenericPackageInstantiation):
                    self.GenericPackageInstantiation(i)
                elif i.is_a(libadalang.ConcreteTypeDecl):
                    self.ConcreteTypeDecl(i)
            self.spec.append("end %s;\n" % self.targetName)
            self.body.append("end %s;\n" % self.targetName)
        with open(ada2file(self.targetName) + ".ads", "w") as outf:
            outf.write("".join(self.spec))
        with open(ada2file(self.targetName) + ".adb", "w") as outf:
            outf.write("".join(self.body))

    def GenericPackageInstantiation(self, node):
        print("")
        print("GenericPackageInstantiation %s" % str(node))

    def ConcreteTypeDecl(self, node):
        typeName = node.children[0].text
        if node.children[2].is_a(libadalang.RecordTypeDef):
            self.RecordTypeDef(typeName, node.children[2])
        elif node.children[2].is_a(libadalang.DerivedTypeDef):
            self.DerivedTypeDef(typeName, node.children[2])
        elif node.children[2].is_a(libadalang.TypeAccessDef):
            pass
        else:
            print("")
            print("ConcreteTypeDecl %s" % str(node))
            print(node.children)

    def RecordTypeDef(self, name, nodes):
        self.spec.append("   procedure Write (To : Stream; Item : %s);\n" % name)
        self.body.append("   procedure Write (To : Stream; Item : %s) is\n" % name)
        self.body.append("   begin\n")
        F = "{"
        L = ""
        for i in nodes.children[3].children[0].children[0].children:
            if i.is_a(libadalang.ComponentDecl):
                self.body.append(L)
                self.body.append('      Write (To, "%s""%s"" : ");' % (F, i.children[0].text.lower()))
                self.body.append(" Write (To, Item.%s);" % i.children[0].text)
                L = ' Write (To, "," & ASCII.LF);\n'
                F = " "
        self.body.append(' Write (To, "}");\n')
        self.body.append("   end Write;\n\n")


    def DerivedTypeDef(self, name, nodes):
        if name in specialSpec:
            self.body.append(specialSpec[name][0])
            self.body.append(specialSpec[name][1])
        else:
            print("DerivedTypeDef %s" % name)
            print(nodes.children)



JSONGen(GPS.File("dds.ads").name())
