package hxextern.command;

import hxextern.service.Repository;

class ListCommand extends AbstractListCommand
{
    public function new()
    {
        super();
    }

    public override function run(args : Array<Dynamic>) : Void
    {
        var target : Null<Target> = (null == args[0] ? null : Target.fromString(args[0]));

        var infos = this.repository.list(target);
        this.printList(infos);
    }
}
