package hxextern.step;

import haxe.DynamicAccess;

interface IStep
{
    public function initialize(options : DynamicAccess<Dynamic>) : Void;

    public function run(context : StepContext) : Void;
}
