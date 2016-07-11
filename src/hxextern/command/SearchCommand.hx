package hxextern.command;

import hxextern.service.Repository;

class SearchCommand extends AbstractListCommand
{
    public function new()
    {
        super();
    }

    public override function run(args : Array<Dynamic>) : Void
    {
        var name : String         = args[0];
        var target : Null<Target> = (null == args[1] ? null : Target.fromString(args[1]));

        var infos = this.repository.find(name, target);
        this.printList(infos);
    }
}
