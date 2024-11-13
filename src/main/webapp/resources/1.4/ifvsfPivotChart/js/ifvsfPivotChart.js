
(function($){
	/**
	 * 
	 * @class ifvsfPivotChart
	 * 
	 */
	$.fn.ifvsfPivotChart = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejPivotChart(this.opt);
			window[_this.attr('id')] = this.data("ejPivotChart");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);