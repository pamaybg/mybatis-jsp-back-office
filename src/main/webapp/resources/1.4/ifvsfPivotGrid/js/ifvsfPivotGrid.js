
(function($){
	/**
	 * 
	 * @class ifvsfPivotGrid
	 * 
	 */
	$.fn.ifvsfPivotGrid = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejPivotGrid(this.opt);
			window[_this.attr('id')] = this.data("ejPivotGrid");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);