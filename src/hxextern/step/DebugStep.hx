package hxextern.step;

import haxe.DynamicAccess;
import hxextern.step.IStep;
import sys.FileSystem;
import sys.io.File;

@:step('debug')
class DebugStep extends AbstractStep
{
    public function new()
    {
        super();
    }

    public override function run(context : StepContext) : Void
    {
        super.run(context);

        this.console
            .debug(Std.string(context.variables))
        ;
    }
}
