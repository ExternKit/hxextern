package hxextern;

class Main
{
    public static function main() : Void
    {
        // Get arguments
        var args = Sys.args();
        args.pop();

        // Run
        var cli = new Cli();
        cli.run(args);
    }
}
