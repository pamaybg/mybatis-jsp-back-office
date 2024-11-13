
(function($){
	/**
	 * 
	 * @class ifvsfCircularGauge
	 * 
	 */
	$.fn.ifvsfCircularGauge = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejCircularGauge(this.opt);
			window[_this.attr('id')] = this.data("ejCircularGauge");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);