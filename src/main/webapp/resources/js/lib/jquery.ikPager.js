(function($){
	/*
	 * pageing
	 */
	$.fn.ifvbPagingNavi = function(options){
		var _this = this;

		_this = $.extend({
			length : null,
			showNum : 5,
			lastNum : null,
			currentNum : 0,
			numItemArr : null,
			wrap : null,
			con : null,
			itemWidth : 30,
			firstBtn : null,
			prevBtn : null,
			nextBtn : null,
			endBtn : null,
			moveNum : null,
			callback : null,
			url : null,
			dataObj : {},
			isLoading : false,
			scope:null,
			btn:null,
			progress:null,
			resultFunc : null,
			isMake : false

		}, options);
		
		this.defaultSetting = function(){
			var obj = {
				page : 1,
				rows : 10
			};
			$.extend(_this.dataObj, obj );
			//ik.lib.overrideObject(_this.dataObj, obj);
		};

		this.init = function(){
			_this.currentNum = 0;
			_this.dataObj.page = 1;
			_this.dataObj.rows = 10;
			this.changeOn(0);
		};

		this.makePage = function(){
			
			_this.isMake = true;

			this.addClass('page_navi');

			this.makePrevBtn();

			_this.wrap = document.createElement('div');
			_this.wrap.className = "page_wrap";
			
			var lN = _this.showNum;
			if( lN > _this.length ) lN = _this.length;
			var tww = lN * _this.itemWidth;
			if( tww < 0 ) tww = 0;
			_this.wrap.style.width = tww + "px";
			this.append(_this.wrap);

			_this.con = document.createElement('div');
			_this.con.className = "con";
			_this.con.style.width = ( _this.length * _this.itemWidth ) + "px";
			_this.wrap.appendChild(_this.con);

			_this.numItemArr = [];
			for( var i = 0; i < _this.length; i++ ){
				var num = i;
				var a = document.createElement('a');
				a.href='javascript:;';
				a.innerHTML = String(num + 1);
				if( _this.currentNum == num ){
					a.className = 'on';
				}
				this.eventSetting(a, num);
				_this.con.appendChild(a);
				_this.numItemArr.push(a);
			}

			//if( _this.showNum < _this.length )
				this.makeNextBtn();

			
			_this.lastNum = _this.length - _this.showNum;
			if( _this.lastNum < 0 ) _this.lastNum = 0;
			_this.moveNum = 0;

			this.btnCheck();
		};

		this.moveCon = function(){
			this.changeOn(_this.currentNum);
			var tml = -(_this.moveNum * (_this.itemWidth ));
			_this.con.style.marginLeft = tml + "px";
			
			_this.dataObj.page = _this.currentNum+1;
			this.request();
				
			
		};
		
		this.btnCheck = function(){
			if( _this.currentNum == 0 ){
				/*_this.firstBtn.style.display = "none";
				_this.prevBtn.style.display = "none";*/
				$(_this.firstBtn).addClass('disabled');
				$(_this.prevBtn).addClass('disabled');
			}else{
				$(_this.firstBtn).removeClass('disabled');
				$(_this.prevBtn).removeClass('disabled');
			}
			
			if( _this.currentNum == _this.length - 1 ){
				/*_this.nextBtn.style.display = "none";
				_this.endBtn.style.display = "none";*/
				$(_this.nextBtn).addClass('disabled');
				$(_this.endBtn).addClass('disabled');
			}else{
				$(_this.nextBtn).removeClass('disabled');
				$(_this.endBtn).removeClass('disabled');
			}
		};


		this.makePrevBtn = function(){
			_this.firstBtn = this.makeBtn("&lt;&lt;", '', "");
			_this.prevBtn = this.makeBtn("&lt;", '', "");

			/*_this.firstBtn.style.display = "none";
			_this.prevBtn.style.display = "none";*/

			var that = this;
			$(_this.firstBtn).click(function(){
				_this.moveNum = 0;
				_this.currentNum = 0;
				that.moveCon();
			});

			$(_this.prevBtn).click(function(){
				/*if( _this.moveNum > 0 ){
					_this.moveNum--;
					that.moveCon();
				}*/
				
				if( _this.currentNum > 0 ){
					_this.currentNum--;
					/*_this.moveNum = Math.floor( _this.currentNum / _this.showNum ) + 1;
					if( _this.moveNum < 0 ) _this.moveNum = 0;*/
					var cMinN = _this.moveNum;
					if( cMinN > _this.currentNum ) _this.moveNum--;
					that.moveCon();
				}
				
			});
		};

		this.makeNextBtn = function(){
			_this.nextBtn = this.makeBtn("&gt;", MESSAGE.common.nextPageGo, "");
			_this.endBtn = this.makeBtn("&gt;&gt;", MESSAGE.common.lastPageGo, "");
			
			$(_this.nextBtn).addClass('nll');
			$(_this.endBtn).addClass('rl');

			var that = this;
			$(_this.nextBtn).click(function(){
				/*if( _this.moveNum < _this.lastNum ){
					_this.moveNum++;
					that.moveCon();
				}*/
				if( _this.currentNum < _this.length - 1 ){
					_this.currentNum++;
					/*_this.moveNum = _this.currentNum - _this.showNum + 1;
					if( _this.moveNum < 0 ) _this.moveNum = 0;*/
					var cMaxN = _this.moveNum + _this.showNum - 1;
					if( cMaxN < _this.currentNum ) _this.moveNum++;
					that.moveCon();
				}
				
			});

			$(_this.endBtn).click(function(){
				_this.moveNum = _this.lastNum;
				_this.currentNum = _this.length - 1;
				that.moveCon();
			});
		};

		this.makeBtn = function(txt, alt, title){
			var a = document.createElement('a');
			a.href='javascript:;';
			a.innerHTML = txt;

			this.append(a);

			return a;
		};

		this.eventSetting = function( a, i ){
			var that = this;
			$(a).click(function(){

				_this.dataObj.page = i+1;
				_this.currentNum = i;
				that.changeOn(i);
				if( _this.url != null ){
					that.request();
				}else{
					_this.callback(i+1);
				}
			});
		};
		
		this.setData = function( obj ){
			$.extend(_this.dataObj, obj)
		};

		this.requestData = function( obj ){
			$.extend(_this.dataObj, obj);
			_this.isMake = false;
			this.html('');
			_this.dataObj.page = 1;
			_this.moveNum = 0;
			this.changeOn(0);
			if( _this.con != null ) _this.con.style.marginLeft = 0;
			this.request();
		};

		this.request = function(){
			var that = this;
			if( _this.isLoading == false ){
				_this.isLoading = true;
				this.btnProgressSetting();
				
				$.ikPostJSON(_this.url, _this.dataObj, function(result){
					if( _this.btn != null ){
						if( _this.progress != null ) _this.progress.remove();
			            $.ikRemoveRequestBtn(_this.btn);
					}
					
					that.pageDataSetting(result);
					_this.isLoading = false;
					if( result.okFl == "E" ){
						alert( result.message );
					}else{
						_this.resultFunc.call(_this.scope, result);
					}
				});
			}
		};

		this.pageDataSetting = function( obj ){
			
			_this.length = obj.total;
			
			if( _this.isMake == false ) this.makePage();
			
		};

		this.btnProgressSetting = function(){
			if( _this.btn == null || $.ikRequestBtnSearch(_this.btn) > -1 ) return;

	        $.ikAddRequestBtn(_this.btn);
	        var _btn = $(_this.btn);

	        _btn.css({'position': 'relative' });
	        _this.progress = $(document.createElement('div'));
	        _this.progress.addClass('progressRoll');
	        _this.progress.height(_btn[0].clientHeight);
	        _this.progress.width(_btn[0].clientWidth);

	        var table_cell = document.createElement('div');
	        $(table_cell).addClass('table_cell');

	        var img = document.createElement('img');
	        img.src = PAGE_CONTEXT_PATH + "/resources/images/icon/loading.gif";

	        _this.progress.append(table_cell);
	        $(table_cell).append(img);

	        _btn.append(_this.progress[0]);
		};

		this.changeOn = function( n ){
			if( _this.numItemArr == null ) return;
			for( var i = 0; i<_this.numItemArr.length; i++ ){
				if( n == i ){
					_this.numItemArr[i].className = "on";
				}else{
					_this.numItemArr[i].className = "";
				}
			}
			
			this.btnCheck();
		};

		/*if( _this.url == null ){
			this.defaultSetting();
			_this.length = _this.dataObj.total;
			this.makePage();
		};*/
		
		this.defaultSetting();

		return this;
	};
	
	
	/*
	 * 
	 * ikScrollPaging
	 * 
	 */
	$.fn.ikScrollPaging = function(options){
		var _this = this;
		_this = $.extend({
			dataObj : {},
			container : null,
			isEnd : false,
			resultFunc : null,
			url : null,
			scope : null,
			active : true,
			isLoading : false
		}, options);
		
		
		this.init = function(url){
			var obj = {
				pageIndex : 1,
				pageUnit : 10
			};
			_this.isEnd = false;
			$.extend(_this.dataObj, obj)
			//ik.lib.overrideObject(_this.dataObj, obj);
			
			if( url != null ) _this.url = url;
		};
		
		
		this.scrollSetting = function(){
			var that = this;
			
			
			this.scroll(function(){
				
				if( _this.isEnd == false && _this.active == true ){
					
					if( that[0] == window ){
						if( $(window).scrollTop() == $(document).height() - $(window).height()) {
							that.requestData({pageIndex : _this.dataObj.pageIndex + 1});
					    }
						
						/*ik.console.setText( "scrollTop : " + $(window).scrollTop() );
						ik.console.setText( "height : " + $(document).height() );
						ik.console.setText( "w height : " + $(window).height() );*/
						
					}else{
						if( that.scrollTop() + that[0].offsetHeight >= that[0].scrollHeight - 100 ){
							that.requestData({pageIndex : _this.dataObj.pageIndex + 1});
						};
						
						/*ik.console.setText( "scrollTop : " + that.scrollTop() );
						ik.console.setText( "offsetHeight : " + that[0].offsetHeight );
						ik.console.setText( "scrollHeight : " + that[0].scrollHeight );*/
					}
				}
			});
		};
		
		this.requestData = function( obj ){
			$.extend(_this.dataObj, obj)
			//ik.lib.overrideObject( _this.dataObj, obj );
			this.request();
		};
		
		this.request = function(){

			var that = this;
			if( _this.isLoading == false ){
				_this.isLoading = true;

				this.btnProgressSetting();
				$.ikPostJSON(_this.url, _this.dataObj, function(result){
					if(_this.progress != null)
						_this.progress.remove();
		            
					$.ikRemoveRequestBtn(_this.btn);

					that.pageDataSetting(result);
					_this.isLoading = false;
					_this.resultFunc.call(_this.scope, result);
				});
			};
		};
		
		this.pageDataSetting = function(result){
			if( result.pageSize == result.pageIndex ){
				_this.isEnd = true;
			}
			_this.dataObj.pageIndex = result.pageIndex;
			
		};
		
		this.btnProgressSetting = function(){
			if( $.ikRequestBtnSearch(_this.btn) > -1 ) return;

			var _btn;
			if( _this.btn == null ){
				_this._btn = 'body';
				_btn = $('body');
			}else{
				_btn = $(_this.btn);
			}
	        $.ikAddRequestBtn(_this.btn);

	        _btn.css('position', 'relative');
	        _this.progress = $(document.createElement('div'));
	        _this.progress.addClass('progressRoll');
	        _this.progress.height($('body').height());
	        _this.progress.width(_btn[0].clientWidth);

	        var table_cell = document.createElement('div');
	        $(table_cell).addClass('table_cell');

	        var img = document.createElement('img');
	        img.src = PAGE_CONTEXT_PATH + "/resources/images/icon/loading.gif";

	        _this.progress.append(table_cell);
	        $(table_cell).append(img);

	        _btn.append(_this.progress[0]);
		};
		
		this.active = function(){
			_this.active = true;
		};
		
		this.deactive = function(){
			_this.active = false;
		};
		
		this.remove = function(){
			
		};
		
		this.init();
		this.scrollSetting();
		
		return this;
	};
	
})(jQuery);