package hxextern.step;

import haxe.DynamicAccess;
import haxe.io.Path;
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import hscript.Interp;
import hscript.Parser;
import hxextern.step.IStep;
import sys.FileSystem;
import sys.io.File;

@:step('script')
class ScriptStep extends AbstractStep
{
    private var script : String;
    private var classPath : String;

    public function new()
    {
        super();
    }

    public override function initialize(options : DynamicAccess<Dynamic>) : Void
    {
        super.initialize(options);
        
        this.script    = this.getOption(options, 'script', String);
        this.classPath = Path.addTrailingSlash(FileSystem.absolutePath(this.getOption(options, 'classPath', String, './')));
    }

    public override function run(context : StepContext) : Void
    {
        // Setup interpreter
        var interpreter = this.createInterpreter(context);

        // Run main script
        var result = this.loadScript(interpreter, this.script);
        trace(result);
    }

    private function createInterpreter(context : StepContext) : Interp
    {
        // Set default interpreter
        var interpreter = new Interp();
        interpreter.variables.set('context', context);
        interpreter.variables.set('import', function(script : String) : Dynamic {
            return this.loadScript(interpreter, script); // TODO: more security on files loading
        });

        // Bind Haxe types
        var types : Array<Dynamic> = [
            // root level
            Array, Date, DateTools, EReg, Lambda, List, Math, Reflect, Std, StringBuf, StringTools, Sys, Type, Xml,
        ];
        for (type in types) {
            interpreter.variables.set(Type.getClassName(type), type);
        }

        return interpreter;
    }

    private function loadScript(interpreter : Interp, script : String) : Dynamic
    {
        var scriptPath = this.classPath + script;
        if (!FileSystem.exists(scriptPath)) {
            throw 'Cannot find script "${script}"';
        }

        var parser = new Parser();
        parser.allowTypes = true;
        var program = parser.parse(File.read(scriptPath));

        this.console.debug('Running script "${script}"');
        return interpreter.execute(program);
    }
}
