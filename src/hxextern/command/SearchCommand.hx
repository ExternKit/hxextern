package hxextern.command;

import hxextern.service.Repository;

class SearchCommand extends AbstractListCommand
{
    private var name : String;
    private var target : String;

    public function new(name : String, ?target : String)
    {
        super();

        this.name   = name;
        this.target = target;
    }

    public override function run() : Void
    {
        var target = (null == this.target ? null : Target.fromString(this.target));

        var infos = Repository.instance.find(this.name, target);
        this.printList(infos);
    }
}
