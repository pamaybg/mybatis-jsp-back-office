(function($){

	
	/*
	 * ifvSelectBox
	 */
	$.fn.ifvSelectBox = function(options){

		var _this = $.extend({
			data : null,
			input : null,
			selectList : null,
			isShow : false,
			func:null,
			span : null,
			scope : null,
			outTimer : null,
			width : null,
			isUp : false,
			isDisable : false

		}, options);

		var that = this;

		this.init = function(){

			_this.input = this;
			_this.input.css('position', 'relative');
			_this.input.attr('readonly', true );
			if( _this.width != null ) _this.input.width( _this.width );
			_this.span = document.createElement('span');
			_this.span.className = 'selectbox_type1';
			this.before(_this.span);

			$(this).appendTo(_this.span);
			var a = document.createElement('a');
			a.href = "javascript:;";
			a.className = 'select_btn';
			_this.span.appendChild(a);

			var selectList = document.createElement('div');
			_this.selectList = $(selectList);
			_this.selectList.addClass("select_list");
			if( _this.isUp == true ) _this.selectList.addClass("up");
			_this.span.appendChild(selectList);

			_this.input.click(function(){
				that.selectListShow();
			});

			$(a).click(function(){
				that.selectListShow();
			});

			_this.selectList.mouseout(function(){
				if( _this.outTimer != null ) clearInterval(_this.outTimer);
				_this.outTimer = setInterval(function () {
					that.selectListHide();

			        clearInterval(_this.MoveTumTimer);
			    }, 150);
			});

			$(_this.span).mouseover(function(){
				if( _this.isShow ){
					that.selectListShow();
				}
			});
		};

		this.selectListHide = function(){
			_this.selectList.hide();
			_this.isShow = false;
		};

		this.selectListShow = function(){
			
			if( _this.isDisable == true || _this.input.attr('disabled') != null ) return;
			
			if( _this.data != null && _this.data.length > 0 ){
				if( _this.outTimer != null ) clearInterval(_this.outTimer);
				_this.selectList.show();
				_this.input.focusout();
				//_this.selectList.scrollTop(0);
				_this.isShow = true;
			}
		};
		
		this.disabled = function(){
			_this.isDisable = true;
			_this.input.attr('disabled', true );
		};
		
		this.enabled = function(){
			_this.isDisable = false; 
			_this.input.attr('disabled', false );
		};

		this.getSpan = function(){
			return _this.span;
		};

		this.setData = function(data, func){
			_this.func = func;
			_this.selectList.html('');
			_this.data = data;
			for( var i = 0; i<data.length; i++ ){
				if( data[i] != null ){
					var div = document.createElement('div');
					div.title = data[i].value;
					div.innerHTML = data[i].value;
					_this.selectList.append(div);
					
					if(_this.data[i].key2 != undefined){
						_this.input.attr('key2', _this.data[i].key2 );
					}
					this.eventsetting(div, i);
					if(!!data[i].selected && data[i].selected == true) {
						_this.input.val( _this.data[i].value );
						_this.input.attr('key', _this.data[i].key );
					}
				}
			}
		};

		this.eventsetting = function(item, i ){

			$(item).click(function(){
				_this.input.val( _this.data[i].value );
				_this.input.attr('key', _this.data[i].key );
				_this.input.attr('key2', _this.data[i].key2 );
				that.selectListHide();
				if( _this.func != null ){
					if( _this.scope != null ){
						_this.func.call(this.scope, _this.data[i]);
					}else{
						_this.func(_this.data[i]);
					}

				}
			});

			$(item).mouseover(function(){
				//if( _this.outTimer != null ) clearInterval(_this.outTimer);
				_this.selectList.show();
			});
		};

		this.setValue = function(value){

			_this.input.val( value );

			if( _this.data != null ){
				for( var i = 0; i<_this.data.length; i++ ){
					if( _this.data[i].value == value ){
						_this.input.attr('key', _this.data[i].key );
					}
				}
			}
		};

		this.setKey = function(key){
			_this.input.attr('key', key );

			if( _this.data != null ){
				for( var i = 0; i<_this.data.length; i++ ){
					if( _this.data[i].key == key ){
						_this.input.val( _this.data[i].value );
					}
				}
			}
		};

		this.setObj = function(obj){
			_this.input.val( obj.value );
			_this.input.attr('key', obj.key );
		};

		this.getObj = function(){
			var obj = {
				value :_this.input.val(),
				key : _this.input.attr('key'),
				key2: _this.input.attr('key2')
			};
			return obj;
		};

		this.show = function(){
			$(_this.span).show();
		};

		this.hide = function(){
			$(_this.span).hide();
		};

		this.init();

		return this;
	};



	/*
	 * ikSelectBoxPlus
	 */
	$.fn.ikSelectBoxPlus = function(options){
		var _this = $.extend({
			data : null,
			func : null,
			selectbox : null,
			selectArr : null,
			selectValue : null
		}, options);

		this.init = function(){

			_this.selectArr = [];

			this.makeSelectbox(true);
		};

		this.makeSelectbox = function(isPlus){

			var div = document.createElement("div");
			div.className = 'plusBox';
			var item = $(div).ikSelectBoxItem({
				scope : this,
				data : _this.data,
				isPlus : isPlus,
				plusFunc : this.plusItem,
				removeSelectbox : this.removeSelectbox,
				returnFunc : this.returnFunc
			});
			item.attr('key', _this.selectArr.length );
			if( !isPlus ) item.css('marginTop','2px');

			this.append(div);
			_this.selectArr.push($(div));
		};

		this.plusItem = function(){
			this.makeSelectbox(false);
		};

		this.removeSelectbox = function(index){
			_this.selectArr[index].remove();
			_this.data.callback.call( _this.data.scope );
			//if( _this.func != null ) _this.func(false, index);
		};

		this.returnFunc = function(obj){
			if( obj != null ){
				obj.id = this.parent().parent().attr('id');
			}
			_this.data.callback.call( _this.data.scope, obj );
		};

		this.init();
	};



	$.fn.ikSelectBoxItem = function(options){

		var _this = $.extend({
			scope : null,
			plusFunc : null,
			removeSelectbox : null,
			returnFunc : null,
			selectboxCon : null,
			selectbox : null,
			input : null,
			isPlus : null,
			btn : null,
			data : null,
			selectValue : null
		}, options);


		this.init = function(){

			this.makeItem();
		};


		this.makeItem = function(){
			_this.selectboxCon = this.makeSelectBox();
			_this.btn = this.makeBtn();
			_this.input = this.makeInput();
			this.append(_this.selectboxCon);
			this.append(_this.btn);
			this.append(_this.input);
		};

		this.makeSelectBox= function(){
			
			var that = this;
			
			var input = document.createElement("input");
			input.type="text";
			_this.selectbox =  $(input).ikSelectBox();
			_this.selectbox.setData(_this.data.selectDataArr, function(obj){
				
				_this.input.value = 0;
				
				_this.selectValue = obj.value;
				_this.returnFunc.call( _this.scope );
				//_this.selectbox.setKey( _this.data.selectDataArr[0].value );
				
			});

			if( _this.data.selectWidth != null ) $(input).css('width', _this.data.selectWidth + 'px');

			return _this.selectbox.getSpan();
		};
		

		this.makeBtn = function(){

			var btn = document.createElement("a");
			btn.style.display = 'inline';
			btn.href='javascript:;';
			var img = document.createElement("img");
			$(btn).append(img);
			if( _this.isPlus ){
				img.src = '../../resources/images/btn/btn_plus.gif';
			}else{
				img.src = '../../resources/images/btn/btn_minus.gif';
			}

			this.btnEventSetting(btn);
			if( _this.data.btnLeftGap != null ) $(btn).css('marginLeft' , _this.data.btnLeftGap + 'px');

			return btn;
		};

		this.btnEventSetting = function(btn){

			var that = this;
			if( _this.isPlus ){
				$(btn).click(function(){
					//that.makeSelectbox(false);
					_this.plusFunc.call(_this.scope, false);
					var index = $(this).parent().attr('key');
					if( _this.func != null ) _this.func(true, index);
				});
			}else{
				$(btn).click( function(){
					var index = $(this).parent().attr('key');
					that.removeSelectbox.call(_this.scope, index );
				});
			}
		};

		this.makeInput = function(){
			var input = document.createElement("input");
			input.type="text";
			if( _this.data.inputWidth != null ) $(input).css('width', _this.data.inputWidth + 'px');
			if( _this.data.inputLeftGap != null ) $(input).css('marginLeft' , _this.data.inputLeftGap + 'px');
			var that = this;
			$(input).focusout(function(){
				var obj = _this.selectbox.getObj();
				obj.input = this;
				obj.num = $(this).val();
				_this.returnFunc.call( _this.scope, obj );
			});
			
			$(input).onlyNumber();

			return input;
		};

		this.removeSelectbox = function(index){
			_this.removeSelectbox.call( _this.scope, index);
			/*_this.selectArr[index].remove();
			if( _this.func != null ) _this.func(false, index);*/
		};

		this.init();

		return this;
	};


})(jQuery);




