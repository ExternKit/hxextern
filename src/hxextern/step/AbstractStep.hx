package hxextern.step;

import hxextern.step.IStep;

@:skip
class AbstractStep implements IStep
{
    public var type(default, null) : String;

    public function new(type : String)
    {
        this.type = type;
    }

    public function run(definitions : TypeDefinitionMap, options : Null<Dynamic>) : TypeDefinitionMap
    {
        throw 'Must be overriden';

        return definitions;
    }
}
