(function($){
	/**
	 * 
	 * @class ifvsfTab
	 * 
	 */
	$.fn.ifvsfTab = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			
		}, options);
		
		this.init = function(){
			this.addTab();
			
			this.ejTab(this.opt);
			window[_this.attr('id')] = this.data("ejTab");
		};
		
		this.addTab = function(){
			if( this.opt.tabId != null && this.opt.msgCode != null ){
				this.append('<ul>');
				for(var i=0; i<this.opt.tabId.length; i++){
					this.children('ul').append('<li><a href="#'+ this.opt.tabId[i] +'">'+ this.opt.msgCode[i] +'</a></li>');
					this.append('<div id="'+ this.opt.tabId[i] +'">');
				}
			}
		}
		
		this.init();

		return this;
	};
})(jQuery);