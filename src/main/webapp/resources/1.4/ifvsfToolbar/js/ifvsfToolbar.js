
(function($){
	/**
	 * 
	 * @class ifvsfToolbar
	 * 
	 */
	$.fn.ifvsfToolbar = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejToolbar(this.opt);
			window[_this.attr('id')] = this.data("ejToolbar");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);