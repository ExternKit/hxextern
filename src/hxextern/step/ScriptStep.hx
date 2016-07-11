package hxextern.step;

import haxe.macro.Compiler;
import haxe.macro.Context;
import hxextern.step.IStep;
import sys.FileSystem;
import haxe.macro.Expr;

@:step('script')
class ScriptStep extends AbstractStep
{
    public function new()
    {
        super('script');
    }

    public override function run(definitions : TypeDefinitionMap, options : Null<Dynamic>) : TypeDefinitionMap
    {
        var classPath = FileSystem.absolutePath(options.classPath);
        
        return definitions;
    }
}
