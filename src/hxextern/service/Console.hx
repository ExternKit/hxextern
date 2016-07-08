package hxextern.service;

import haxe.io.Output;
import hxextern.utils.Colors;

class Console
{
    @:isVar
    public static var instance(get, null) : Console;
    private static function get_instance() : Console
    {
        if (null == Console.instance) {
            Console.instance = new Console();
        }
        return Console.instance;
    }

    private var stdout : Output;
    private var stderr : Output;

    private function new()
    {
        this.stdout = Sys.stdout();
        this.stderr = Sys.stderr();
    }

    public function message(message : String, newline : Bool = true) : Void
    {
        this.print(this.stdout, message, newline);
    }

    public function debug(message : String, newline : Bool = true) : Void
    {
        this.print(this.stdout, Colors.magenta('${message}'), newline);
    }

    public function info(message : String, newline : Bool = true) : Void
    {
        this.print(this.stdout, Colors.cyan('${message}'), newline);
    }

    public function success(message : String, newline : Bool = true) : Void
    {
        this.print(this.stdout, Colors.green('${message}'), newline);
    }

    public function warning(message : String, newline : Bool = true) : Void
    {
        this.print(this.stderr, Colors.yellow('${message}'), newline);
    }

    public function error(message : String, newline : Bool = true) : Void
    {
        this.print(this.stderr, Colors.red('${message}'), newline);
    }

    private function print(output : Output, message : String, newline : Bool = true) : Void
    {
        output.writeString(message);
        if (newline) {
            output.writeString('\n');
        }
        output.flush();
    }
}
