package hxextern.step;

import haxe.macro.Expr;

typedef TypeDefinitionMap = Map<String, TypeDefinition>;

interface IStep
{
    public var type(default, null) : String;

    public function run(definitions : TypeDefinitionMap, options : Null<Dynamic>) : TypeDefinitionMap;
}
