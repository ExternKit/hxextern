package hxextern.step;

import hxextern.service.Process;
import hxextern.step.IStep;

class AbstractCommandStep extends AbstractStep
{
    @inject
    public var process(default, null) : Process;

    public function new()
    {
        super();
    }

    public override function run(context : StepContext) : Void
    {
        super.run(context);
    }

    private function exec(command : String, ?args : Array<String>) : ProcessOutput
    {
        this.process.checkCommand(command);
        return this.process.execute(command, args);
    }
}
