package hxextern.command;

import hxextern.service.Console;

class HelpCommand implements ICommand
{
    @inject
    public var console(default, null) : Console;

    public function new()
    {

    }

    public function run(args : Array<Dynamic>) : Void
    {
        var doc : String = args[0];

        this.console
            .info('HxExtern Manager 1.0.0')
            .message('  Usage: hxextern [command] <arguments>')
            .message('    ' + doc.split('\n').join('\n    '))
        ;
    }
}
