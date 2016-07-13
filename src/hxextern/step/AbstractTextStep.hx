package hxextern.step;

import haxe.DynamicAccess;
import hxextern.step.IStep;
import sys.FileSystem;
import sys.io.File;

class AbstractTextStep extends AbstractStep
{
    private var file : String;

    public function new()
    {
        super();
    }

    public override function initialize(options : DynamicAccess<Dynamic>) : Void
    {
        super.initialize(options);

        this.file = FileSystem.absolutePath(this.getOption(options, 'file', String));
    }

    public override function run(context : StepContext) : Void
    {
        super.run(context);

        // Ensure that file exists
        if (!FileSystem.exists(this.file)) {
            throw 'Cannot find file "${this.file}"';
        }
    }

    private function getLines() : Array<String>
    {
        var input = File.read(this.file);
        var lines = [];
        try {
            while (true) {
                lines.push(input.readLine());
            }
        } catch (e : haxe.io.Eof) {}
        input.close();

        return lines;
    }

    private function setLines(lines : Array<String>) : Void
    {
        var output = File.write(this.file);
        for (line in lines) {
            output.writeString(line);
            output.writeString('\n');
        }
        output.flush();
        output.close();
    }
}
