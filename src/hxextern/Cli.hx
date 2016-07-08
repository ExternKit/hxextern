package hxextern;

import hxargs.Args;
import hxextern.command.*;
import hxextern.service.*;

typedef ArgsHandler = {
    function getDoc() : String;

    function parse(__args : Array<Dynamic>) : Void;
};

class Cli
{
    private var handler : ArgsHandler;

    public function new()
    {
        this.handler = Args.generate([
            @doc('List available externs')
            'list' => function(?target : String) : Void {
                this.runCommand(new ListCommand(target));
            },

            @doc('Search for an extern')
            'search' => function(name : String, ?target : String) : Void {
                this.runCommand(new SearchCommand(name, target));
            },

            @doc('Generate extern code')
            'generate' => function(?path : String) : Void {
                trace('Not implemented');
            },

            @doc('Show this help')
            'help' => function() : Void {
                this.runCommand(new HelpCommand(this.handler.getDoc()));
            },

            _ => function(arg : String) : Void {
                this.runCommand(new HelpCommand(this.handler.getDoc()));
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
            Console.instance.error(Std.string(e));
        }
    }

    private function runCommand(command : ICommand) : Void
    {
        try {
            command.run();
        } catch (e : Dynamic) {
            Console.instance.error(Std.string(e));
        }
    }
}
