package hxextern.step;

import haxe.DynamicAccess;
import hxextern.step.IStep;
import sys.FileSystem;

@:step('text:replace')
class TextReplaceStep extends AbstractTextStep
{
    private var from : String;
    private var to : String;
    private var regex : Bool;

    public function new()
    {
        super();
    }

    public override function initialize(options : DynamicAccess<Dynamic>) : Void
    {
        super.initialize(options);

        this.from  = this.getOption(options, 'from', String);
        this.to    = this.getOption(options, 'to', String);
        this.regex = this.getOption(options, 'regex', Bool, true);
    }

    public override function run(context : StepContext) : Void
    {
        super.run(context);

        // Prepare matcher
        var matcher = (this.regex ?
            function (line : String) : Bool {
                return new EReg(this.from, 'g').match(line);
            } :
            function (line : String) : Bool {
                return (line.indexOf(this.from) > -1);
            }
        );

        // Works on lines
        var lines = this.getLines();
        var matched = false;
        for (i in 0...lines.length) {
            var line = lines[i];

            if (matcher(line)) {
                var newLine = context.applyVariables(this.to);
                if (line == newLine) {
                    continue;
                }

                // Update content
                matched = true;
                lines[i] = newLine;

                this.console
                    .message('Replaced line')
                    .success(' ${line}')
                    .message('with line')
                    .success(' ${newLine}')
                ;
            }
        }

        // Dump updates lines
        if (matched) {
            this.setLines(lines);
        } else {
            this.console.success('No changes done');
        }
    }
}
