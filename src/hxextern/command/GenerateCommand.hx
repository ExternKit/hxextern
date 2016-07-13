package hxextern.command;

import haxe.io.Path;
import hxextern.service.Console;
import hxextern.service.Haxelib;
import hxextern.step.IStep;
import hxextern.step.StepContext;
import minject.Injector;
import sys.FileSystem;

using StringTools;

class GenerateCommand implements ICommand
{
    @inject
    public var injector(default, null) : Injector;

    @inject
    public var haxelib(default, null) : Haxelib;
    
    @inject
    public var console(default, null) : Console;

    @inject('cwd')
    public var cwd(default, null) : String;

    public function new()
    {
        
    }

    public function run(args : Array<Dynamic>) : Void
    {
        var path : Null<String> = args[0];

        // Find haxelib file
        var file = (null != path ?
            this.haxelib.findFile(path) :
            this.haxelib.findFromPath(this.cwd)
        );

        // Extract datas
        var data = this.haxelib.extract(file);
        var context = new StepContext();

        // Update to haxelib.json file
        Sys.setCwd(Path.directory(file));

        // Run steps
        this.executeSteps(context, data.steps);
        this.generateCode(context);
    }

    private function executeSteps(context : StepContext, steps : Array<HaxelibHxExternStep>) : Void
    {
        // Run steps
        for (i in 0...steps.length) {
            var step = steps[i];

            // Get step name
            var name = step.type.trim().toLowerCase();

            // Get step
            var instance = try this.injector.getInstance(IStep, name) catch(e : Dynamic) null;
            if (null == instance) {
                throw 'Step ${step.type} has not been found';
            }

            // Prepare context
            context.setup(name);

            // Run step
            this.console.info('(${i + 1}) Running step "${name}"');
            instance.initialize(step.options);
            instance.run(context);
        }
    }

    private function generateCode(context : StepContext) : Void
    {

    }
}
