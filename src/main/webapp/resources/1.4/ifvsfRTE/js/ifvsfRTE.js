
(function($){
	/**
	 * 
	 * @class ifvsfRTE
	 * 
	 */
	$.fn.ifvsfRTE = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejRTE(this.opt);
			window[_this.attr('id')] = this.data("ejRTE");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);