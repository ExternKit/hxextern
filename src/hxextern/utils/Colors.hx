package hxextern.utils;

@:enum
abstract AnsiColor(String) to String {
    var Black   = '\033[0;30m';
    var Red     = '\033[0;31m';
    var Green   = '\033[0;32m';
    var Yellow  = '\033[0;33m';
    var Blue    = '\033[0;34m';
    var Magenta = '\033[0;35m';
    var Cyan    = '\033[0;36m';
    var Gray    = '\033[0;37m';
    var White   = '\033[1;37m';
    var None    = '\033[0;0m';
}

class Colors {
    public static inline function red(input : String) : String {
        return Colors.color(input, Red);
    }

    public static inline function green(input : String) : String {
        return Colors.color(input, Green);
    }

    public static inline function yellow(input : String) : String {
        return Colors.color(input, Yellow);
    }

    public static inline function blue(input : String) : String {
        return Colors.color(input, Blue);
    }

    public static inline function magenta(input : String) : String {
        return Colors.color(input, Magenta);
    }

    public static inline function cyan(input : String) : String {
        return Colors.color(input, Cyan);
    }

    public static inline function gray(input : String) : String {
        return Colors.color(input, Gray);
    }

    public static inline function white(input : String) : String {
        return Colors.color(input, White);
    }

    public static inline function none(input : String) : String {
        return Colors.color(input, None);
    }

    public static inline function color(input : String, ansiColor : AnsiColor) : String {
        return '${ansiColor}$input${AnsiColor.None}';
    }
}
