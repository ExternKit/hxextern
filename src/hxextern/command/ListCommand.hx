package hxextern.command;

import hxextern.service.Repository;

class ListCommand extends AbstractListCommand
{
    private var target : String;

    public function new(?target : String)
    {
        super();

        this.target = target;
    }

    public override function run() : Void
    {
        var target = (null == this.target ? null : Target.fromString(this.target));

        var infos = Repository.instance.list(target);
        this.printList(infos);
    }
}
