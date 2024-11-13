(function($){
	$.fn.ifvAddRemove = function(options){
		
		this.opt = $.extend({
			templete : null,
			temp : null,
		}, options);
		
		
		this.init = function(){
			this.makeRow();
		};
		
		this.makeRow = function(){
			var row = $( "<div class='ifv_add_remove_row'>" );
			this.append( row );
			
			row.append($("#"+this.opt.temp).text());
			
			var addBtn = $( '<a href="javascript:;" class="btn_style search lg" pushId="btnAdd">추가</a>');
			var deleteBtn = $( '<a href="javascript:;" class="btn_style search " pushId="btnDelete">삭제</a>');
			
			row.append( addBtn );
			row.append( deleteBtn );
			
			var _this = this;
			addBtn.click(function(){
				_this.makeRow();
			});
			
			deleteBtn.click(function(){
				if( _this.children().length > 1 ){
					row.remove();
				}
			});
		};
		
		this.init();
		
		return this;
	};
})(jQuery);