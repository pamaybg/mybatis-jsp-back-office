if( typeof ik == "undefined" ) var ik = new Object();

ik.Lib = function(){
	this.VS=1.0;
};

ik.Lib.prototype =
{
		
	onBtn:function(btn){
		if( btn== null ) return;
		btn.src = btn.getAttribute('src').replace('_off', '_on');
	},
	
	offBtn:function(btn){
		if( btn== null ) return;
		btn.src = btn.getAttribute('src').replace('_on', '_off');
	},
	
	j_onBtn:function(btn){
		if( btn.length == 0 ) return;
		btn.attr( 'src', btn.attr('src').replace('_off', '_on') );
	},
	
	j_offBtn:function(btn){
		if( btn.length == 0 ) return;
		btn.attr( 'src', btn.attr('src').replace('_on', '_off') );
	},
	
	addEventListener: function(element,event,fn){
       if (document.createEventObject){
          element.attachEvent("on"+event,fn);
       }
       else{
          element.addEventListener(event,fn);
       }
    },

    dispatchEvent : function(element,event){
       if (document.createEventObject){
          var evt = document.createEventObject();
          return element.fireEvent("on"+event,evt);
       }
       else{
          var evt = document.createEvent("HTMLEvents");
          evt.initEvent(event, true, true ); 
          return !element.dispatchEvent(evt);
       }
    },
    
    getById : function(name){
    	return document.getElementById(name);
    },
    
    getByClassName : function(con, name){
    	return ik.lib.getElementsByClassName(con,name)[0];
    },
    
    getByClassNameArr : function(con, name){
    	return ik.lib.getElementsByClassName(con,name);
    },
    
    getByTagName :function( con, name ){
    	return con.getElementsByTagName(name)[0];
    },
    
    getElementsByClassName : function(con, className){
        if(con.getElementsByClassName)
            return con.getElementsByClassName(className);
        else if(con.querySelectorAll) // IE8 
             return con.querySelectorAll('.' + className);
        else{ // IE7
            var arr = new Array();
            var e = con.getElementsByTagName("*");
            for(var i=0;i<e.length;i++){
                if(e[i].className == className)
                    arr.push(e[i]);
            }
            return arr;
        }
    },
    
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
    	
    	popupComponetNum--;
    	$( '#popupFullScreen' + popupComponetNum ).remove();
		if( popupComponetNum == 0 ){
			ik.lib.getByTagName( document, 'body').style.overflow = 'auto';
		}
    	
    },
    
    closeFullScreenAllPopup : function(){
    	for( var i= 0; i<popupComponetNum; i++ ){
    		$.closeFullScreenPopup();
    	}
    },
    
    fullScreenPopRelocation : function(){
    	currentPopupComponent.rePosition();
    }
    
   
};

ik.Console.prototype.setText = function(str){
	
	if( this.view == null ){
		this.view = document.createElement('div');
		this.view.style.position = 'fixed';
		this.view.style.zIndex = '30000000000000';
		this.view.style.left='0px';
		this.view.style.top='0px';
		this.view.style.width='300px';
		this.view.style.height='100px';
		this.view.style.overflow='auto';
		this.view.style.background='#ffffff';
		document.body.appendChild( this.view );
	}
	this.view.innerHTML = this.view.innerHTML + '<br/>' + str; 
};
ik.Console.prototype.view = null;

ik.lib = new ik.Lib();
ik.console = new ik.Console();

ik.RequestPager = function(obj){
	this.url = obj.url;
	this.callback = obj.callback;
	this.container = obj.container;
	this.btn = obj.btn;
	this.isTwitter = obj.isTwitter;
	this.isEnd  = 0;
	if( obj.dataObj == null ){
		this.dataObj = {};
	}else{
		this.dataObj = obj.dataObj;
	}
	
	if( this.container != null ){
		this.scrollSetting();
	}
	
	if( this.btn != null ){
		this.eventSetting();
	}
	
	
	this.init(true);
};

ik.RequestPager.prototype = {
	url : null,
	isLoading : null,
	isFirst : 1,
	totalNum : null,
	isTwitter : null,
	btn : null,
	index : null,
	dataObj : null
};

ik.RequestPager.prototype.eventSetting = function(){
	var _this = this;
	this.btn.click(function(){
		_this.requestData();
	});
};

ik.RequestPager.prototype.scrollSetting = function(){
	
	var _this = this;
	
	this.container.scroll(function(){
		if( _this.isEnd == 0 ){
			if( _this.container.scrollTop() + _this.container[0].offsetHeight >= _this.container[0].scrollHeight - 100 ){
				_this.requestData();
			};
		}
	});
};

ik.RequestPager.prototype.init = function(grid){
	
	if( grid == null ){	//grid방식일때는 이값을 넣어주면 안된다
		this.dataObj.lastCreateDate = null;
		this.dataObj.filterKey = null;
		this.dataObj.filterValue = null;
	}
	
	this.isEnd = 0;
	this.index = 0;
	this.isFirst = 1;
	this.loadTotalNum = 0;
};

ik.RequestPager.prototype.requestData = function(obj){
	var _this = this;
	if( this.isLoading == 0 || this.isEnd == 1 ) return; 
	this.isLoading = 0;
	if( obj != null ) ik.lib.overrideObject( this.dataObj, obj );
	$.ikPostJSON(
		_this.url, 
		_this.dataObj,
		function(result) {
			
			if( result.expandObj != null && result.expandObj.pageSize != null ){
				_this.dataObj.pageSize = result.expandObj.nextPageSize;
				_this.dataObj.pageNum = result.expandObj.nextPageNum;
			}
			
			if( _this.isTwitter ){
				_this.dataObj.maxId = result.expandObj;
			}
			
			if( _this.isFirst == 1 ){
				_this.totalNum = result.remainCount;
			}
			result._totalNum = _this.totalNum;
			result._isFirst = _this.isFirst;
			
			if( result.rows.length == 0 ){
				_this.isEnd = 1;
			}
			
			_this.loadTotalNum += result.rows.length;
			
			if( _this.btn != null ){
				if( result.remainCount == result.rows.length ){
					_this.btn.hide();
				}else{
					_this.btn.show();
				}
			}
			
			
			for( var i = 0; i<result.rows.length; i++ ){
				result.rows[i].index = _this.index;
				_this.index++;
			}
			
			if( _this.isFirst == 1 || result.rows.length > 0 ){
				_this.dataObj.lastCreateDate = result.lastCreateDate;
				_this.dataObj.filterKey = result.filterKey;
				_this.dataObj.filterValue = result.filterValue;
				_this.dataObj.orderBy = result.orderBy;
				_this.dataObj.createDateColumn = result.createDateColumn;
				
				_this.callback(result);
			}
			
			_this.isFirst = 0;
			
			_this.isLoading = 1;
		}
	);
};

/*
 * 
 * popularFavorItem
 * 
 */
ik.PopularFavorItem = function(obj){
	this.item = obj.item;
	this.isCheck = obj.isCheck;
	this.dataObj = obj.dataObj;
	this.url = obj.url;
	this.success = obj.success;
	if( obj.isToggleShow != null ) this.isToggleShow = obj.isToggleShow;
	this.btnChange();
	this.isEvent = 1;
	this.toggleImgSetting();
	this.eventSetting();
};

ik.PopularFavorItem.prototype = {
	item : null,
	isCheck : null,
	isEvent : null,
	isToggleShow : 0,
	url : null
};

ik.PopularFavorItem.prototype.toggleImgSetting = function(){
	var _this = this;
	if( this.isToggleShow == 0 ){
		$(this.item).find('.toggle').hide();
		
		$(this.item).mouseover(function(){
			$(_this.item).find('.toggle').show();
		});
		
		$(this.item).mouseout(function(){
			$(_this.item).find('.toggle').hide();
		});
	}
};

ik.PopularFavorItem.prototype.btnChange = function(){
	
	if( this.item == null ) return;
	
	if( this.isCheck ){
		ik.lib.j_onBtn( $(this.item).find('.toggle') );
	}else{
		ik.lib.j_offBtn( $(this.item).find('.toggle') );
	}
};

ik.PopularFavorItem.prototype.toggle = function(){
	if( this.isCheck ){
		this.isCheck = false;
	}else{
		this.isCheck = true;
	}
	this.btnChange();
};

ik.PopularFavorItem.prototype.eventSetting = function(){
	
	var _this = this;
	
	var check;
	if( this.isCheck ){
		check = false;
	}else{
		check = true;
	}
	
	if( $(this.item).find('.toggle') != null && this.url != null ){
	
		$(this.item).find('.toggle').click( function(){
			
			if( _this.isCheck ){
				check = false;
			}else{
				check = true;
			}
			
			if( $.ikLoginCheck() == false ) return;
			
			if( _this.isEvent == 0 ) return;
			
			_this.isEvent = 0;
			var sendObj = _this.dataObj;
			sendObj.isCheck = check; 
			$.ikPostJSON(_this.url, sendObj,
			function(result) {
				
				_this.isEvent = 1;
				_this.isCheck = check;
				_this.btnChange();
				if( _this.success != null ) _this.success(check, _this.item);
			});
		});
	}
};