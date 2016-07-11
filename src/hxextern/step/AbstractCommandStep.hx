package hxextern.step;

import hxextern.step.IStep;

@:skip
class AbstractCommandStep extends AbstractStep
{
    public function new(type : String)
    {
        super(type);
    }

    public override function run(definitions : TypeDefinitionMap, options : Null<Dynamic>) : TypeDefinitionMap
    {
        return definitions;
    }
}
