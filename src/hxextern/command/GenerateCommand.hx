package hxextern.command;

import hxextern.service.Haxelib;
import hxextern.step.*;
import hxextern.step.IStep;
import sys.FileSystem;

using StringTools;

class GenerateCommand implements ICommand
{
    @inject
    public var haxelib(default, null) : Haxelib;

    public function new()
    {
        /*
        this.path  = path;
        this.steps = new Map();

        var types : Array<Class<IStep>> = [ScriptStep, NpmStep];
        for (type in types) {
            var instance = Type.createInstance(type, []);
            this.steps[instance.type] = instance;
        }
        */
    }

    public function run(args : Array<Dynamic>) : Void
    {
        var path : Null<String> = args[0];

        // Find haxelib file
        var file = (null != path ?
            this.haxelib.findFile(path) :
            this.haxelib.findFromPath(Sys.getCwd())
        );

        // Extract datas
        var data = this.haxelib.extract(file);
        this.executeSteps(data.steps);
    }

    private function executeSteps(steps : Array<HaxelibHxExternStep>) : Void
    {
        /*
        var definitions = new TypeDefinitionMap();
        for (step in steps) {
            // Get step name
            var name = step.type.trim().toLowerCase();
            if (!this.steps.exists(name)) {
                throw 'Step "${step.type}" has not been found';
            }

            // Run step
            var instance = this.steps[name];
            definitions = instance.run(definitions, step.options);
        }
        trace(definitions);
        */
    }
}
