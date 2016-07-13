package hxextern;

class Tools
{
    public static function escapeEReg(value : String) : String
    {
        return ~/([-[\]{}()*+?.,\\^$|#\s])/g.replace(value, '\\$1');
    }
}
