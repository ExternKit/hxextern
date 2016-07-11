package hxextern.command;

import hxextern.service.Console;
import hxextern.service.Repository;

class AbstractListCommand implements ICommand
{
    @inject
    public var console(default, null) : Console;

    @inject
    public var repository(default, null) : Repository;

    public function new()
    {
        // Nothing to do
    }

    public function run(args : Array<Dynamic>) : Void
    {
        throw 'Must be overriden';
    }

    private function printList(infos : Array<RepositoryInfo>) : Void
    {
        if (0 == infos.length) {
            this.console.info('No results found');
            return;
        }

        this.console.success('Found ${infos.length} result(s)');
        for (info in infos) {
            this.console
                .message('  * ', false)
                .info('${info.name} (${info.target})', false)
                .message(' : ${info.description}')
            ;
        }
    }
}
