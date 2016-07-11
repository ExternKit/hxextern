package hxextern.service;

import haxe.io.Output;
import hxextern.utils.Colors;

class Console
{
    private var stdout : Output;
    private var stderr : Output;

    public function new()
    {
        this.stdout = Sys.stdout();
        this.stderr = Sys.stderr();
    }

    public function message(message : String, newline : Bool = true) : Console
    {
        return this.print(this.stdout, message, newline);
    }

    public function debug(message : String, newline : Bool = true) : Console
    {
        return this.print(this.stdout, Colors.magenta(message), newline);
    }

    public function info(message : String, newline : Bool = true) : Console
    {
        return this.print(this.stdout, Colors.cyan(message), newline);
    }

    public function success(message : String, newline : Bool = true) : Console
    {
        return this.print(this.stdout, Colors.green(message), newline);
    }

    public function warning(message : String, newline : Bool = true) : Console
    {
       return  this.print(this.stderr, Colors.yellow(message), newline);
    }

    public function error(message : String, newline : Bool = true) : Console
    {
        return this.print(this.stderr, Colors.red(message), newline);
    }

    private function print(output : Output, message : String, newline : Bool = true) : Console
    {
        output.writeString(message);
        if (newline) {
            output.writeString('\n');
        }
        output.flush();

        return this;
    }
}
