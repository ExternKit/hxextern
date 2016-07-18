package hxextern.command;

import haxe.io.Path;
import haxe.macro.Printer;
import hxextern.service.Console;
import hxextern.service.Haxelib;
import hxextern.step.IStep;
import hxextern.step.StepContext;
import minject.Injector;
import sys.FileSystem;
import sys.io.File;

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
        this.generateCode(context, data.output);
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

    private function generateCode(context : StepContext, output : String) : Void
    {
        this.console.info('Generating code');
        var basePath = Path.addTrailingSlash(FileSystem.absolutePath(output));
        var printer = new Printer();

        // Generate all files
        var done = false;
        for (definition in context.definitions) {
            done = true;

            // Ensure directory exists
            var directory = basePath + definition.pack.join('/');
            FileSystem.createDirectory(directory);

            var filename = '${directory}/${definition.name}.hx';
            var type = (definition.pack.length > 0 ? definition.pack.join('.') + '.' : '') + definition.name;

            // Preparing content
            this.console.debug('Preparing code for type "${type}"');
            var content = printer.printTypeDefinition(definition, true);

            // Writing file content
            this.console.debug('Writing content to "${filename}"');
            File.saveContent(filename, '${content}\n');

            this.console.success('Type "${type}" generated');
        }
        if (!done) {
            this.console.success('No types generated');
        }
    }
}
