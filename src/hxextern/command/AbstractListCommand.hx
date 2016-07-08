package hxextern.command;

import hxextern.service.Console;
import hxextern.service.Repository;

class AbstractListCommand implements ICommand
{
    public function new()
    {
        // Nothing to do
    }

    public function run() : Void
    {
        throw 'Must be overriden';
    }

    private function printList(infos : Array<RepositoryInfo>) : Void
    {
        if (0 == infos.length) {
            Console.instance.info('No results found');
            return;
        }

        Console.instance.success('Found ${infos.length} result(s)');
        for (info in infos) {
            Console.instance.message('  * ', false);
            Console.instance.info('${info.name} (${info.target})', false);
            Console.instance.message(' : ${info.description}');
        }
    }
}
