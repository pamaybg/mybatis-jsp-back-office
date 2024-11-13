(function($){
	
	/*
	 * 
	 * ifvScrollPaging
	 * 
	 */
	$.fn.ifvScrollPaging = function(options){
		var _this = this;
		_this = $.extend({
			dataObj : {},
			container : null,
			isEnd : false,
			resultFunc : null,
			url : null,
			scope : null,
			active : true,
			isLoading : false,
			tempId : null
		}, options);
		
		
		this.init = function(url){

			_this.dataObj.lastCreateDate = null;
			_this.dataObj.filterKey = null;
			_this.dataObj.filterValue = null;

			_this.isEnd = false;
			if( url != null ) _this.url = url;
			
			this.requestData();
		};
		
		
		this.scrollSetting = function(){
			var that = this;
			
			
			this.scroll(function(){
				
				if( _this.isEnd == false && _this.active == true ){
					
					if( that[0] == window ){
						if( $(window).scrollTop() == $(document).height() - $(window).height()) {
							//that.requestData({pageIndex : _this.dataObj.pageIndex + 1});
							that.requestData();
					    }
						
						/*ifv.console.setText( "scrollTop : " + $(window).scrollTop() );
						ifv.console.setText( "height : " + $(document).height() );
						ifv.console.setText( "w height : " + $(window).height() );*/
						
					}else{
						if( that.scrollTop() + that[0].offsetHeight >= that[0].scrollHeight - 100 ){
							//that.requestData({pageIndex : _this.dataObj.pageIndex + 1});
							that.requestData();
						};
						
						/*ifv.console.setText( "scrollTop : " + that.scrollTop() );
						ifv.console.setText( "offsetHeight : " + that[0].offsetHeight );
						ifv.console.setText( "scrollHeight : " + that[0].scrollHeight );*/
					}
				}
			});
		};
		
		this.requestData = function( obj ){
			$.extend(_this.dataObj, obj);
			//ifv.lib.overrideObject( _this.dataObj, obj );
			this.request();
		};
		
		this.request = function(){

			var that = this;
			if( _this.isLoading == false ){
				_this.isLoading = true;

				this.btnProgressSetting();
				$.ifvPostJSON(_this.url, _this.dataObj, function(result){
					if(_this.progress != null)
						_this.progress.remove();
		            
					$.ifvRemoveRequestBtn(_this.btn);

					that.pageDataSetting(result);
					that.addData(result);
					if(result.remainCount < 1) _this.isEnd = true;
					_this.isLoading = false;
					if( _this.resultFunc != null ) _this.resultFunc.call(_this.scope, result);
				});
			};
		};
		
		this.addData = function(result){
			var arr = result.rows;
			
			for( var i=0; i<arr.length; i++ ){
				this.append( $.ifvSupplant( $("#" + _this.tempId).text(), arr[i] ));
			}
		};

		this.pageDataSetting = function(result){

			_this.dataObj.lastCreateDate = result.lastCreateDate;
			_this.dataObj.filterKey = result.filterKey;
			_this.dataObj.filterValue = result.filterValue;
			_this.dataObj.orderBy = result.orderBy;
			_this.dataObj.createDateColumn = result.createDateColumn;

			/*if( result.pageSize == result.pageIndex ){
				_this.isEnd = true;
			}
			_this.dataObj.pageIndex = result.pageIndex;*/
			
		};
		
		this.btnProgressSetting = function(){
			
		};
		
		this.active = function(){
			_this.active = true;
		};
		
		this.deactive = function(){
			_this.active = false;
		};
		
		this.remove = function(){
			this.empty();
		};
		
		this.init();
		this.scrollSetting();
		
		return this;
	};
	
	
	
	
	
	
	
	
	/*
	 * pageing
	 */
	$.fn.ifvPagingNavi = function(options){
		var _this = this;

		_this = $.extend({
			length : null,
			showNum : 5,
			lastNum : null,
			currentNum : 0,
			numItemArr : null,
			wrap : null,
			con : null,
			itemWidth : 31,
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
				rows : 10,
				searchType : '',
				searchWord : '',
				sidx : '',
				sord : ''
			};
			$.extend(_this.dataObj, obj );
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
			_this.con.style.width = ( _this.length * ( _this.itemWidth + 1) ) + "px";
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
				
				$(_this.firstBtn).addClass('disabled');
				$(_this.prevBtn).addClass('disabled');
			}else{
				$(_this.firstBtn).removeClass('disabled');
				$(_this.prevBtn).removeClass('disabled');
			}
			
			if( _this.currentNum == _this.length - 1 ){
				
				$(_this.nextBtn).addClass('disabled');
				$(_this.endBtn).addClass('disabled');
			}else{
				$(_this.nextBtn).removeClass('disabled');
				$(_this.endBtn).removeClass('disabled');
			}
		};


		this.makePrevBtn = function(){
			_this.firstBtn = this.makeBtn("&lt;&lt;", '처음페이지로 이동', "처음");
			_this.prevBtn = this.makeBtn("&lt;", '이전페이지로 이동', "이전");


			var that = this;
			$(_this.firstBtn).click(function(){
				_this.moveNum = 0;
				_this.currentNum = 0;
				that.moveCon();
			});

			$(_this.prevBtn).click(function(){
								
				if( _this.currentNum > 0 ){
					_this.currentNum--;
					var cMinN = _this.moveNum;
					if( cMinN > _this.currentNum ) _this.moveNum--;
					that.moveCon();
				}
				
			});
		};

		this.makeNextBtn = function(){
			_this.nextBtn = this.makeBtn("&gt;", '다음페이지로 이동', "다음");
			_this.endBtn = this.makeBtn("&gt;&gt;", '마지막페이지로 이동', "마지막");
			
			$(_this.nextBtn).addClass('nll');
			$(_this.endBtn).addClass('rl');

			var that = this;
			$(_this.nextBtn).click(function(){
			
				if( _this.currentNum < _this.length - 1 ){
					_this.currentNum++;
					
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

				

				/*//test
				var result = {};
				result.total = 10;
				result.rows = 10;
				result.tableList = []
				result.tableList[0] = {no: 0};
				result.tableList[1] = {no: 1};
				result.tableList[2] = {no: 2};
				result.tableList[3] = {no: 1};

				that.pageDataSetting(result);
				_this.isLoading = false;
				if( _this.progress != null ) _this.progress.remove();
			    $.ifvRemoveRequestBtn(_this.btn);

				_this.resultFunc.call(_this.scope, result);
				return;*/
				
				$.ifvPostJSON(_this.url, _this.dataObj, function(result){
					
					if( _this.btn != null ){
						if( _this.progress != null ) _this.progress.remove();
			            $.ifvRemoveRequestBtn(_this.btn);
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
			if( obj.rows == 0 ) obj.rows = 10;
			
			//_this.length = 100;
			
			if( _this.isMake == false ) this.makePage();
			
		};

		this.btnProgressSetting = function(){
			if( _this.btn == null || $.ifvRequestBtnSearch(_this.btn) > -1 ) return;

	        $.ifvAddRequestBtn(_this.btn);
	        var _btn = $(_this.btn);

	        _btn.css({'position': 'relative' });
	        _this.progress = $(document.createElement('div'));
	        _this.progress.addClass('progressRoll');
	        _this.progress.height(_btn[0].clientHeight);
	        _this.progress.width(_btn[0].clientWidth);

	        var table_cell = document.createElement('div');
	        $(table_cell).addClass('table_cell');

	        var img = document.createElement('img');
	        img.src = "./resources/images/loading.gif";

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

		this.defaultSetting();

		return this;
	};
	
	
})(jQuery);