document.write("<link href='"+ frameworkUrl + "ifvsfTextBoxes/css/ifvsfTextBoxes.css' rel='stylesheet' type='text/css'>");

(function($){
	/**
	 * 
	 * @class ifvsfTextBoxes
	 * 
	 */
	$.fn.ifvsfTextBoxes = function(options){
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			 
		}, options);
		
		this.init = function(){
			if(this.opt.textBoxType == 'percentage'){
				this.ejPercentageTextbox(this.opt);
				window[_this.attr('id')] = this.data("ejPercentageTextbox");
			}
			if(this.opt.textBoxType == 'currency'){
				this.ejCurrencyTextbox(this.opt);
				window[_this.attr('id')] = this.data("ejCurrencyTextbox");
			}
			if(this.opt.textBoxType == 'numeric'){
				this.ejNumericTextbox(this.opt);
				window[_this.attr('id')] = this.data("ejNumericTextbox");
			}
		};
		
		
		this.init();

		return this;
	};
})(jQuery);
