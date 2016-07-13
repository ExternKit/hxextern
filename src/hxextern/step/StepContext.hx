package hxextern.step;

import haxe.DynamicAccess;
import haxe.macro.Expr;

class StepContext
{
    public var currentStep(default, null) : String;

    public var options(default, null) : Dynamic;

    public var definitions(default, null) : Map<String, TypeDefinition>;

    public var variables(default, null) : DynamicAccess<Dynamic>;

    public function new(?options : Dynamic)
    {
        this.options     = options;
        this.definitions = new Map();
        this.variables   = {};
    }

    public function setup(step : String) : Void
    {
        this.currentStep = step;
    }

    public function registerVariable(name : String, value : Dynamic) : StepContext
    {
        this.variables[name] = value;
        return this;
    }

    public function applyVariables(text : String) : String
    {
        return ~/\${([a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)*)}/ig.map(text, function(ereg : EReg) : String {
            return this.resolveVariable(ereg.matched(1));
        });
    }

    public function resolveVariable(field : String) : Dynamic
    {
        var parts = field.split('.');
        var data : Dynamic  = this.variables;
        while (parts.length > 0) {
            var part = parts.shift();
            if (!Reflect.hasField(data, part)) {
                throw 'Field "${part}" not found';
            }
            data = Reflect.field(data, part);
        }
        return data;
    }
}
