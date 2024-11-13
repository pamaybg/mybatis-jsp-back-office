(function($){
	/*
	 * ifvSimplePager
	 */
	$.fn.ifvSimplePager = function(options){

		this.pageCon = null;
		this.currentNum = 1;
		this.totalNum = 1;
		
		this.opt = $.extend({
			url : null,
			dataObj : { page : 1, rows : 10, sidx: '', sord : 'DESC', searchType : '', searchWord : '', nd : '', searchText : '' },
			size : 5,
			maxSizeNum : 0,
			tempId : null,
			containerId : null,
			container : null,
			templete : null,
			complete : null,
			callback : null,
			func : {}
		}, options );
		
		this.init = function(){
			
			$.extend( this.opt.dataObj, {sidx : this.opt.sidx, sord : this.opt.sord } );
			
			this.opt.templete = $( "#" + this.opt.tempId );
			this.opt.container = $( "#" + this.opt.containerId );
			
			this.addClass('ifv_simple_pager');
			this.pageCon = $("<ul>");
			
			this.leftArea = $("<li>");
			this.numArea = $("<li>");
			this.rightArea = $("<li>");
			
			this.pageCon.append( this.leftArea );
			this.pageCon.append( this.numArea );
			this.pageCon.append( this.rightArea );
			
			this.makeLeft();
			this.makeRight();
			
			this.append( this.pageCon );
			if( this.opt.url != null ){
				this.requestData();
			}
		};
		
		
		this.makeLeft = function(data){
			this.firstBtn = $("<a href='javascript:;' class='first_btn'>");
			this.prevBtn = $("<a href='javascript:;' class='prev_btn'>");
			/*this.firstBtn.text('<<');
			this.prevBtn.text('<');*/
			
			this.leftArea.append( this.firstBtn );
			this.leftArea.append( this.prevBtn );
			
			
		};
		
		this.makeRight = function(data){
			this.lastBtn = $("<a href='javascript:;' class='last_btn'>");
			this.nextBtn = $("<a href='javascript:;' class='next_btn'>");
			/*this.nextBtn.text('>');
			this.lastBtn.text('>>');*/
			
			this.rightArea.append( this.nextBtn );
			this.rightArea.append( this.lastBtn );
		};
		

		this.change = function(data){
			if( data.records == null ) data.records = this.opt.records;
			this.opt.records = data.records;
			this.opt.maxSizeNum = Math.ceil( data.records / this.opt.dataObj.rows );
			this.currentNum = data.page;
			
			this.numArea.empty();
			
			var startNum = Math.floor( (data.page -1) / this.opt.size ) * this.opt.size + 1;
			var max = Math.ceil( data.records / this.opt.dataObj.rows ) + 1;
			var lenth = startNum + this.opt.size;
			if( lenth > max ) lenth = max;
			if( lenth == 1 ) lenth = 2;
			for( var i = startNum; i < lenth; i++ ){
				var num = $("<a href='javascript:;'>");
				num.text(i);
				if( data.page == i ){
					num.addClass('on');
				}
				this.numArea.append(num);
				
				var _this = this;
				(function(n){
					num.click(function(){
						_this.currentNum = n; 
						_this.moveClick(n);
					});
				})(i);
			}
			
			this.btnCheck(data);
		};
		
		this.moveClick = function( n ){
			if( this.opt.url != null ){
				this.requestData({ page:n });
			}else{
				this.change({ page:n, records : this.opt.records });
				this.opt.callback(n);
			};
		};
		
		this.requestData = function( data ){
			$.extend( this.opt.dataObj, data );

			var _this = this;
			$.ifvPostJSON(_this.opt.url, this.opt.dataObj, function(result){
				
				_this.dataSetting(result);
				_this.change({ page : result.page, records : result.records });
				if( _this.opt.complete != null ) _this.opt.complete( result );
			});
		};
		
		this.dataSetting = function( result ){
			this.opt.container.html('');
			var list = this.opt.templete.tmpl( result.rows, this.opt.func );
			this.opt.container.append( list );
		};
		
		this.btnCheck = function(data){
			
			var _this = this;
			
			this.firstBtn.unbind();
			this.prevBtn.unbind();
			this.nextBtn.unbind();
			this.lastBtn.unbind();
			if( data.page == 1 ){
				this.firstBtn.addClass('disabled');
				this.prevBtn.addClass('disabled');
				
			}else{
				this.firstBtn.removeClass('disabled');
				this.prevBtn.removeClass('disabled');
				
				this.firstBtn.click(function(){
					_this.moveClick(1);
				});
				this.prevBtn.click(function(){
					var n = _this.currentNum-1;
					if( n < 1 ) n = 1;
					_this.moveClick( n );
				});
			}
			if( data.page >= _this.opt.maxSizeNum ){
				this.nextBtn.addClass('disabled');
				this.lastBtn.addClass('disabled');
			}else{
				this.nextBtn.removeClass('disabled');
				this.lastBtn.removeClass('disabled');
				
				this.nextBtn.click(function(){
					var n = _this.currentNum+1;
					if( n > _this.opt.maxSizeNum ) n = data.size;
					_this.moveClick( n );
				});
				this.lastBtn.click(function(){
					_this.moveClick( _this.opt.maxSizeNum );
				});
			}
		};

		this.init();
		
		return this;
	};
	
	
})(jQuery);