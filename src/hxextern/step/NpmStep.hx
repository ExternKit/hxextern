package hxextern.step;

import hxextern.service.Console;
import hxextern.service.Process;
import hxextern.step.IStep;

@:step('npm')
class NpmStep extends AbstractCommandStep
{
    @inject
    var console(default, null) : Console;

    @inject
    var process(default, null) : Process;

    public function new()
    {
        super('npm');
    }

    public override function run(definitions : TypeDefinitionMap, options : Null<Dynamic>) : TypeDefinitionMap
    {
        var module = options.module;

        var result = this.process.execute('npm', ['install', module, '--silent']);
        if (0 == result.code) {
            this.console.success('NPM module "${module}" installed');
        } else {
            this.console
                .error('NPM module "${module}" has not been installed')
                .error(result.error)
            ;
        }

        return definitions;
    }
}
