package hxextern.service;

import haxe.Json;
import hxextern.service.Process;
import hxextern.Target;

typedef RepositoryInfo = {
    var name : String;
    var target : Target;
    var description : String;
    var url : String;
};

class Repository
{
    private static inline var REPOS_URL : String = 'https://api.github.com/orgs/ExternKit/repos';

    private static var REPO_PATTERN : EReg = ~/extern-([a-z]+)-([a-z0-9_-]+)/ig;

    @inject
    public var process(default, null) : Process;

    private var repositories : Array<RepositoryInfo>;

    public function new()
    {
        this.repositories = null;
    }

    private function preload() : Void
    {
        if (null != this.repositories) {
            return;
        }

        this.repositories = [];

        // Get json from Github
        var result = this.process.execute('curl', ['-sSf', Repository.REPOS_URL]);
        if (!result.valid) {
            throw result.error;
        }
        var json = Json.parse(result.output);

        // Extract informations from json
        for (entry in (json : Array<Dynamic>)) {
            if (Repository.REPO_PATTERN.match(entry.name)) {
                // Check if target is supported
                var target = Target.fromString(Repository.REPO_PATTERN.matched(1));
                if (null == target) {
                    continue;
                }

                // Extract informations
                this.repositories.push({
                    name: Repository.REPO_PATTERN.matched(2).toLowerCase(),
                    target: target,
                    description: entry.description,
                    url: entry.url
                });
            }
        }

        this.repositories.sort(function(info1 : RepositoryInfo, info2 : RepositoryInfo) : Int {
            if (info1.target != info2.target) {
                return Reflect.compare(info1.target, info2.target);
            }

            return Reflect.compare(info1.name, info2.name);
        });
    }

    public function list(?target : Target) : Array<RepositoryInfo>
    {
        this.preload();

        if (null == target) {
            return this.repositories.copy();
        }

        return [
            for (info in this.repositories)
                if (info.target == target)
                    info
        ];
    }

    public function find(name : String, ?target : Target) : Array<RepositoryInfo>
    {
        this.preload();

        var escapedName = ~/([-[\]{}()*+?.,\\^$|#\s])/g.replace(name, '\\$1');
        var ereg        = new EReg(escapedName, 'ig');
        
        return [
            for (info in this.repositories)
                if (ereg.match(info.name) && (null == target || info.target == target))
                    info
        ];
    }
}
