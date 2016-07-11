package hxextern;

import hxargs.Args;
import hxextern.command.*;
import hxextern.service.Console;
import minject.Injector;

typedef ArgsHandler = {
    function getDoc() : String;

    function parse(__args : Array<Dynamic>) : Void;
};

class Cli
{
    @inject
    public var injector(default, null) : Injector;

    @inject
    public var console(default, null) : Console;

    private var handler : ArgsHandler;

    public function new()
    {
        this.handler = Args.generate([
            @doc('Generate extern code')
            'generate' => function(?path : String) : Void {
                this.runCommand(GenerateCommand, [path]);
            },

            @doc('List available externs')
            'list' => function(?target : String) : Void {
                this.runCommand(ListCommand, [target]);
            },

            @doc('Search for an extern')
            'search' => function(name : String, ?target : String) : Void {
                this.runCommand(SearchCommand, [name, target]);
            },

            @doc('Show this help')
            'help' => function() : Void {
                this.runCommand(HelpCommand, [this.handler.getDoc()]);
            },

            _ => function(arg : String) : Void {
                this.runCommand(HelpCommand, [this.handler.getDoc()]);
            },
        ]);
    }

    public function run(args : Array<String>) : Void
    {
        if (args.length == 0) {
            args.push('help');
        }
        try {
            this.handler.parse(args);
        } catch (e : Dynamic) {
            this.console.error(Std.string(e));
        }
    }

    private function runCommand(commandType : Class<ICommand>, ?args : Array<Dynamic>) : Void
    {
        try {
            var command = this.injector.instantiate(commandType);
            command.run(null == args ? [] : args);
        } catch (e : Dynamic) {
            this.console.error(Std.string(e));
        }
    }
}
