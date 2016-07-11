package hxextern;

import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.TypeTools;
import sys.FileSystem;

using StringTools;

class Macro
{
    private static inline var STEP_META : String = ':step';

    public static macro function listSteps(injector : Expr) : Expr
    {
        var injections = [];
        var modules = Macro.listTypes('hxextern.step');
        for (module in modules) {
            var type = switch (module) {
                case TInst(inst, _): inst.get();
                case _: null;
            }
            if (null == type) {
                continue;
            }

            if (type.isExtern || type.isInterface || !type.meta.has(Macro.STEP_META) || !Macro.doesImplement(type, 'hxextern.step.IStep')) {
                continue;
            }
            var step = switch (type.meta.extract(Macro.STEP_META)) {
                case [{ params: [{ expr: EConst(CString(name)) }] }]: name;
                case _: null;
            }
            if (null == step) {
                continue;
            }

            var moduleName = type.name;
            injections.push(macro $injector.mapClass(hxextern.step.IStep, hxextern.step.$moduleName, $v{step}));
        }
        return macro { $a{injections} };
    }

    public static macro function listCommands(injector : Expr) : Expr
    {
        var injections = [];
        var modules = Macro.listTypes('hxextern.step');
        for (module in modules) {
            var type = switch (module) {
                case TInst(inst, _): inst.get();
                case _: null;
            }
            if (null == type) {
                continue;
            }

            if (type.isExtern || type.isInterface || !Macro.doesImplement(type, 'hxextern.command.ICommand')) {
                continue;
            }

            var moduleName = type.name;
            injections.push(macro $injector.mapClass(hxextern.command.$moduleName, hxextern.command.$moduleName));
            injections.push(macro $injector.mapClass(hxextern.command.ICommand, hxextern.command.$moduleName, $v{moduleName}));
        }
        return macro { $a{injections} };
    }

#if macro
    private static function listTypes(pack : String) : Array<Type>
    {
        var types = [];
        for (cp in Context.getClassPath()) {
            var directory = Path.addTrailingSlash(cp) + pack.replace('.', '/');
            if (!FileSystem.exists(directory) || !FileSystem.isDirectory(directory)) {
                continue;
            }

            for (file in FileSystem.readDirectory(directory)) {
                if (!file.endsWith('.hx')) {
                    continue;
                }

                var moduleName = file.substr(0, -3);
                var module = try Context.getType('${pack}.${moduleName}') catch(e : String) null;
                if (null == module) {
                    continue;
                }
                types.push(module);
            }
        }
        return types;
    }

    private static function doesImplement(type : ClassType, interfaceType : String) : Bool
    {
        for (entry in type.interfaces) {
            if (entry.t.toString() == interfaceType || Macro.doesImplement(entry.t.get(), interfaceType)) {
                return true;
            }
        }

        return (null != type.superClass ? Macro.doesImplement(type.superClass.t.get(), interfaceType) : false);
    }
#end
}
