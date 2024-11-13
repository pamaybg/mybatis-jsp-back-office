var frameworkUrl = "/resources/1.4/";

if (typeof ifv == "undefined") var ifv = new Object();

function getVersionOfIE() {

    var word;
    var version = "N/A";

    var agent = navigator.userAgent.toLowerCase();
    var name = navigator.appName;

    // IE old version ( IE 10 or Lower )
    if (name == "Microsoft Internet Explorer") {
        word = "msie ";
    } else {
        // IE 11
        if (agent.search("trident") > -1) {
            word = "trident/.*rv:";
        }
        // IE 12 ( Microsoft Edge )
        else if (agent.search("edge/") > -1) {
            word = "edge/";
        }
    }

    var reg = new RegExp(word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})");

    if (reg.exec(agent) != null) {
        version = RegExp.$1 + RegExp.$2;
    }

    return version;
}

function individualCase() {
    var verNum = parseInt(getVersionOfIE());
    if (isNaN(verNum) || verNum >= 9) {
        document.write("<script src='" + frameworkUrl + "ifvCommon/js/jquery-2.1.4.min.js' type='text/javascript'></script>");
        // jquery 1.9부터 삭제된 기능으로 인해 jquery-migrate-1.2.1.js 추가
        document.write("<script src='" + frameworkUrl + "ifvCommon/js/jquery-migrate-1.2.1.js' type='text/javascript'></script>");
    } else {
        document.write("<script src='" + frameworkUrl + "ifvCommon/js/jquery-1.8.3.js' type='text/javascript'></script>");
    }
}

function consoleInit() {
    if (!window.console) {
        window.console = {};
    }
    var m = [
        "log", "info", "warn", "error", "debug", "trace", "dir", "group",
        "groupCollapsed", "groupEnd", "time", "timeEnd", "profile", "profileEnd",
        "dirxml", "assert", "count", "markTimeline", "timeStamp", "clear"
    ];
    for (var i = 0; i < m.length; i++) {
        if (!window.console[m[i]]) {
            window.console[m[i]] = function () { };
        }
    }
};

function stringCFormat() {
    if (!String.prototype.cFormat) {
        String.prototype.cFormat = function (arr) {
            var al = arr.length;
            return this.replace(/{(\d+)}/g, function (match, al) {
                return typeof arr[al] != 'undefined' ? arr[al] : match;
            });
        };
    }
};

(function () {
    if (!window.console) {
        window.console = {};
    }
    var m = [
        "log", "info", "warn", "error", "debug", "trace", "dir", "group",
        "groupCollapsed", "groupEnd", "time", "timeEnd", "profile", "profileEnd",
        "dirxml", "assert", "count", "markTimeline", "timeStamp", "clear"
    ];
    for (var i = 0; i < m.length; i++) {
        if (!window.console[m[i]]) {
            window.console[m[i]] = function () { };
        }
    }
})();

if (!String.prototype.cFormat) {
    String.prototype.cFormat = function (arr) {
        var al = arr.length;
        return this.replace(/{(\d+)}/g, function (match, al) {
            return typeof arr[al] != 'undefined' ? arr[al] : match;
        });
    };
}

individualCase();
consoleInit();
stringCFormat();