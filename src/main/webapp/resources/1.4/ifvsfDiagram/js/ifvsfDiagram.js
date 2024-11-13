
(function($){
	/**
	 * 
	 * @class ifvsfDiagram
	 * 
	 */
	$.fn.ifvsfDiagram = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성

		this.opt = $.extend({
			constraints:DiagramConstraints.Default | DiagramConstraints.Bridging 
		}, options);
		
		this.init = function(){
			
			this.ejDiagram(this.opt);
			window[_this.attr('id')] = this.data("ejDiagram");
		};
		
		this.init();

		return this;
	};
})(jQuery);