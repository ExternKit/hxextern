package hxextern.service;

import haxe.io.Bytes;
import sys.io.Process as HxProcess;

typedef ProcessOutput = {
    var output : Null<String>;
    var error : Null<String>;
    var valid : Bool;
    var code : Int;
};

class Process
{
    @inject
    public var console(default, null) : Console;

    public function new()
    {
        // Nothing to do
    }

    public function execute(command : String, ?args : Array<String>) : ProcessOutput
    {
        this.console.debug('Calling command "${command}' + (null != args && args.length > 0 ? ' ' + args.join(' ') : '') + '"');

        var process = new HxProcess(command, args);
        var output = process.stdout.readAll().toString();
        var error  = process.stderr.readAll().toString();
        var result = ('' != error && null != error ? {
            output: null,
            error: error,
            valid: false,
            code: process.exitCode(),
        } : {
            output: output,
            error: null,
            valid: true,
            code: process.exitCode(),
        });
        process.close();

        return result;
    }
}
