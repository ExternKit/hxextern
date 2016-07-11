package hxextern.service;

import haxe.DynamicAccess;
import haxe.io.Path;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

typedef HaxelibHxExternStep = {
    var type : String;
    var options : Null<Dynamic>;
};

typedef HaxelibHxExtern = {
    var steps : Array<HaxelibHxExternStep>;
};

class Haxelib
{
    private static inline var FILENAME : String = 'haxelib.json';

    public function new()
    {
        // Nothing to do
    }

    public function findFile(file : String) : String
    {
        if (!FileSystem.exists(file) || FileSystem.isDirectory(file)) {
            throw 'File not found "${file}"';
        }

        return FileSystem.absolutePath(file);
    }

    public function findFromPath(path : String) : String
    {
        var directory = Path.removeTrailingSlashes(FileSystem.absolutePath(path));
        while (FileSystem.exists(directory) && FileSystem.isDirectory(directory)) {
            var filename = '${directory}/${Haxelib.FILENAME}';
            if (FileSystem.exists(filename)) {
                return filename;
            }

            // Go in upper directory
            directory = Path.directory(directory);
        }

        throw 'Cannot find "${Haxelib.FILENAME}" file from path "${path}"';
        return null;
    }

    public function extract(file : String) : HaxelibHxExtern
    {
        // Get file
        var filename = this.findFile(file);
        var content = File.getContent(filename);

        // Get json
        var json     = Json.parse(content);
        var hxextern = this.extractField(json, 'hxextern');
        var steps    = this.extractField(hxextern, 'steps');
        if (!Std.is(steps, Array)) {
            throw 'Field "steps" should be an array';
        }

        // Return validated object
        return {
            steps: [ for (step in (steps : Array<DynamicAccess<Dynamic>>)) {
                type: this.extractField(step, 'type'),
                options: (step.exists('options') ? step['options'] : null),
            } ],
        };
    }

    private function extractField(object : DynamicAccess<Dynamic>, field : String) : Dynamic
    {
        if (!object.exists(field)) {
            throw 'Required "${field}" field not found';
        }
        return object[field];
    }
}
