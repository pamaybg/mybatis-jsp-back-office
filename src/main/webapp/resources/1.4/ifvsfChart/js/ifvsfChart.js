
(function($){
	/**
	 * 
	 * @class ifvsfChart
	 * 
	 */
	$.fn.ifvsfChart = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejChart(this.opt);
			window[_this.attr('id')] = this.data("ejChart");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);