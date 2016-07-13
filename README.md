# hxextern

**hxextern** is an extern manager.

It's currently a WIP project and is not suitable for production usage.

## Installation

```
haxelib --global git hxextern https://github.com/ExternKit/hxextern.git develop
```

## Usage

```
haxelib run hxextern <command> [options...]
```

### Supported targets

**hxextern** can hypothetically support all Haxe targets. When a reference to a target is asked the following can be used:
- `cpp` or `c++`: C++
- `cs` or `csharp`: C#
- `flash`: Flash
- `js` or `javascript`: Javascript
- `lua`: Lua
- `neko` or `n`: Neko
- `php`: PHP
- `py` or `python`: Python

### Finding externs

You can list all available externs with:
```
haxelib run hxextern list
```

Are for a specific target by specifying it after. eg:
```
haxelib run hxextern list js
```

You can also search an extern by its name. eg:
```
haxelib run hxextern search aws
```

You can also filter the search for a specific target. eg:
```
haxelib run hxextern search aws js
```

### Generating externs

**hxextern** provides some tools to make it easier for you to auto-generate your externs. The generation is made by defining one or multiple steps to be ran by **hxextern**.

The generation configuration should go on a JSON file. Using `haxelib.json` for this IS a good idea.

You can launch the generation with the `generate` command.

If you don't specify any path, it will search the first available `haxelib.json` file from the working directory to root directory.
```
haxelib run hxextern generate
```

You can also specify a direct path to an `haxelib.json` file
```
haxelib run hxextern generate /my/path/haxelib.json
```

#### Configuration

`TODO`

#### Steps

##### NPM

`TODO`

##### Script

`TODO`

##### Replace text

`TODO`

## TODO

- Adding more steps
- Adding generation through TypeDefinition
