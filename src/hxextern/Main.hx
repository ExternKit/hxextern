package hxextern;

import hxextern.service.*;
import minject.Injector;

class Main
{
    public static function main() : Void
    {
        // Get arguments
        var args = Sys.args();
        var cwd = args.pop();

        // Prepare injector
        var injector = new Injector();
        injector.mapValue(Injector, injector);
        injector.mapSingleton(Console);
        injector.mapSingleton(Haxelib);
        injector.mapSingleton(Process);
        injector.mapSingleton(Repository);
        Macro.listSteps(injector);

        // Update cwd
        Sys.setCwd(cwd);

        // Run
        var cli = injector.instantiate(Cli);
        cli.run(args);
    }
}
