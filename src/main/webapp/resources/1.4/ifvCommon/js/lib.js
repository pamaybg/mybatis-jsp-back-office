if( typeof ifv == "undefined" ) var ifv = new Object();

//글로벌 변수 담는 객체
var ifvGlobal = {};	

ifv.Lib = function(){
    this.VS=1.0;
};

ifv.Lib.prototype =
{
    overrideObject : function (defaultObj,updateObj)
    {
        
        if (updateObj == null)
        {
            return defaultObj;
        }
        
        for (var key in updateObj)
        {
            defaultObj[key] = updateObj[key];
        }
        return defaultObj;
    },
    
    updateObject : function (defaultObj,updateObj)
    {
            if (updateObj == null)
            {
                return defaultObj;
            }
            for (var key in defaultObj)
            {
                if (updateObj[key] == undefined)
                {
                    updateObj[key] = defaultObj[key];
                }
            }
            return updateObj;
    },
    
    indexSetting : function(result){
        if( result == null ) return;
        for( var i = 0; i<result.length; i++ ){
            result[i].index = i;
        }
    },
    
    closeFullScreenPopup : function(){
        ifvGlobal.popupComponetNum--;
        $( '#popupFullScreen' + ifvGlobal.popupComponetNum ).remove();
        if( ifvGlobal.popupComponetNum == 0 ){
            $('body')[0].style.overflow = 'auto';
        }
    },
    
    closeFullScreenAllPopup : function(){
        for( var i= 0; i<ifvGlobal.popupComponetNum; i++ ){
            $.closeFullScreenPopup();
        }
    },
    
    fullScreenPopRelocation : function(){
        currentPopupComponent.rePosition();
    }
};

ifv.commonMessage = {
    search : '검색',
    noData : '데이타가 없습니다.',
    gun : '건',
    total : '전체',
    select : '선택',
    ok : '확인',
    cancel : '취소',
    minDateTxt : '기준일 이전입니다.',
    maxDateTxt : '기준일 이후입니다.',
    yes : '예',
    no : '아니오'
};

ifv.Console = function() {};
ifv.Console.prototype.setText = function(str){
    
    if( this.view == null ){
        this.view = document.createElement('div');
        this.view.style.position = 'fixed';
        this.view.style.zIndex = '30000000000000';
        this.view.style.left='0px';
        this.view.style.top='0px';
        this.view.style.width='300px';
        this.view.style.height='300px';
        this.view.style.overflow='auto';
        this.view.style.background='#ffffff';
        document.body.appendChild( this.view );
    }
    this.view.innerHTML = this.view.innerHTML + '<br/>' + str; 
};
ifv.Console.prototype.view = null;


ifv.lib = new ifv.Lib();
ifv.console = new ifv.Console();

String.prototype.trim = function() {
    return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
};

String.prototype.replaceAll = function(searchStr, replaceStr) {
    return this.split(searchStr).join(replaceStr);
};

Array.prototype.remove = function(idx) {
    return (idx<0 || idx>this.length) ? this : this.slice(0, idx).concat(this.slice(idx+1, this.length));
};

Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};


if (!Array.prototype.indexOf)
{
  Array.prototype.indexOf = function(elt /*, from*/)
  {
    var len = this.length >>> 0;

    var from = Number(arguments[1]) || 0;
    from = (from < 0)
         ? Math.ceil(from)
         : Math.floor(from);
    if (from < 0)
      from += len;

    for (; from < len; from++)
    {
      if (from in this &&
          this[from] === elt)
        return from;
    }
    return -1;
  };
}

if(!Array.sortOn){
    Array.prototype.sortOn = function($key){
    	var dup = this.slice();
		if(!arguments.length) return dup.sort();
		var args = Array.prototype.slice.call(arguments);
		return dup.sort(function(a,b){
			var props = args.slice();
			var prop = props.shift();
			while(a[prop] == b[prop] && props.length) prop = props.shift();
			return a[prop] == b[prop] ? 0 : a[prop] > b[prop] ? 1 : -1;
		});
    };
};

if (!Object.create) {
    Object.create = (function(){
        function F(){}

        return function(o){
            if (arguments.length != 1) {
                throw new Error('Object.create implementation only accepts one parameter.');
            }
            F.prototype = o;
            return new F();
        };
    })();
};




