(function($){
	/**
	 * 
	 * @class ifvsfColorPicker
	 * 
	 */
	$.fn.ifvsfColorPicker = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejColorPicker(this.opt);
			window[_this.attr('id')] = this.data("ejColorPicker");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);
