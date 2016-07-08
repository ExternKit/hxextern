package hxextern;

@:enum
abstract Target(String) to String
{
    var Cpp : Target        = 'cpp';
    var Cs : Target         = 'cs';
    var Flash : Target      = 'flash';
    var Java : Target       = 'java';
    var Js : Target         = 'js';
    var Lua : Target        = 'lua';
    var Neko : Target       = 'neko';
    var Php : Target        = 'php';
    var Python : Target     = 'python';

    public static function fromString(target : String) : Null<Target>
    {
        return switch (target.toLowerCase()) {
            case 'cpp' | 'c++':         Cpp;
            case 'cs' | 'csharp':       Cs;
            case 'flash':               Flash;
            case 'js' | 'javascript':   Js;
            case 'lua':                 Lua;
            case 'neko' | 'n':          Neko;
            case 'php':                 Php;
            case 'py' | 'python':       Python;
            case _:                     throw 'Unsupported target "${target}"';
        }
    }
}
