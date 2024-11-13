(function($){
	/**
	 * 
	 * @class ifvsfDateTimePicker
	 * 
	 */
	$.fn.ifvsfDateTimePicker = function(options){
		var locale = (window.lang && window.country) ? (window.lang + "-" + window.country) : "ko-KR";
		var localeScript = document.createElement('script');
		localeScript.type = "text/javascript";
		localeScript.src = '/resources/1.4/syncfusion/scripts/i18n/ej.culture.' + locale + '.min.js';
		$('head').append(localeScript);
		
		var texts = {
			today: MESSAGE.datetimepicker.today
			, timeNow: ""
			, done: MESSAGE.datetimepicker.done
			, timeTitle: MESSAGE.datetimepicker.time
		};
		
		var _this = this;
		window[this.attr('id')];	//전역변수 생성
		
		this.opt = $.extend({
			dateTimeFormat :"yyyy-MM-dd HH:mm:ss" 
			, locale: locale
			, watermarkText : ifv.commonMessage.select || "선택"
		}, options);
		
		this.init = function(){
			this.ejDateTimePicker(this.opt);
			window[_this.attr('id')] = this.data("ejDateTimePicker");
			window[_this.attr('id')].setModel({ "locale": locale, buttonText: texts, watermarkText: MESSAGE.datetimepicker.placeholder });
			window[_this.attr('id')].setValue = function(date) {
				this.setModel({value : date});
			}
		};
		
		this.init();

		return this;
	};
})(jQuery);