
(function($){
	/**
	 * 
	 * @class ifvsfSymbolPalette
	 * 
	 */
	$.fn.ifvsfSymbolPalette = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			
			this.ejSymbolPalette(this.opt);
			window[_this.attr('id')] = this.data("ejSymbolPalette");
		};
		
		
		this.init();

		return this;
	};
})(jQuery);