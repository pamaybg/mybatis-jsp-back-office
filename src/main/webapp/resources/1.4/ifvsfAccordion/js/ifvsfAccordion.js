
(function($){
	/**
	 * 
	 * @class ifvsfAccordion
	 * 
	 */
	$.fn.ifvsfAccordion = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejAccordion(this.opt);
			window[_this.attr('id')] = this.data("ejAccordion");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);