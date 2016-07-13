package hxextern.step;

import haxe.DynamicAccess;
import hxextern.service.Process;
import hxextern.step.IStep;

using hxextern.Tools;
using StringTools;

@:step('command:npm')
class CommandNpmStep extends AbstractCommandStep
{
    private var module : String;
    private var version : String;

    public function new()
    {
        super();
    }

    public override function initialize(options : DynamicAccess<Dynamic>) : Void
    {
        super.initialize(options);

        this.module  = this.getOption(options, 'module', String);
        this.version = this.getOption(options, 'version', String, '');
    }

    public override function run(context : StepContext) : Void
    {
        super.run(context);
        
        // Prepare package name
        var packageName = this.module;
        if (this.version.length > 0) {
            packageName += '@${this.version}';
        }
        
        // Install module
        var result = this.exec('npm', ['install', packageName, '--silent']);
        if (0 == result.code) {
            this.console.success('NPM module "${packageName}" installed');

            // Extract installed npm module version
            var ereg = new EReg('${this.module.escapeEReg()}@([0-9.]+)', 'ig');
            if (ereg.match(result.output)) {
                context.registerVariable('npm', {
                    module: {
                        name: this.module,
                        version: ereg.matched(1),
                    },
                });
            }
        } else {
            this.console
                .error('NPM module "${this.module}" has not been installed')
                .error(result.error)
            ;
        }
    }
}
