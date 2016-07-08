package hxextern.command;

class HelpCommand implements ICommand
{
    private var doc : String;

    public function new(doc : String)
    {
        this.doc = doc;
    }

    public function run() : Void
    {
        Sys.println(this.doc);
    }
}
