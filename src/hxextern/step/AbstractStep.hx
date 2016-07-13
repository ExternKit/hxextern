package hxextern.step;

import haxe.DynamicAccess;
import hxextern.service.Console;
import hxextern.step.IStep;

class AbstractStep implements IStep
{
    @inject
    public var console(default, null) : Console;

    public function new()
    {
        // ...
    }

    public function initialize(options : DynamicAccess<Dynamic>) : Void
    {
        // ...
    }

    public function run(context : StepContext) : Void
    {
        // ...
    }

    private function getOption(options : DynamicAccess<Dynamic>, field : String, type : Dynamic, ?defaultValue : Dynamic) : Dynamic
    {
        if (!options.exists(field)) {
            if (null != defaultValue) {
                return defaultValue;
            }
            throw 'Missing field "${field}" in step options';
        }

        var value = options[field];
        if (!Std.is(value, type)) {
            throw 'Invalid type for field "${field}". Expected ${type}, but got ${Type.typeof(value)}';
        }
        return value;
    }
}
