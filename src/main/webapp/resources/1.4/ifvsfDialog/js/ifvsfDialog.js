
(function($){
	/**
	 * 
	 * @class ifvsfDialog
	 * 
	 */
	$.fn.ifvsfDialog = function(options){
        var _this = this;
        window[this.attr('id')]; //전역변수 생성
        var pwid = options.width ? typeof options.width != "number" ? Number(options.width.replace('px', '')) : options.width : 600;
        var posx = Math.ceil((window.innerWidth - pwid)/2);

        this.opt = $.extend({
            enableModal: true,
            enableResize: false,
            contentType: "ajax",
            width: 600,
            maxWidth: 1024,
            maxHeight: 700,
            position : {X: posx, Y:50},
            close: function() {
                window[_this.attr('id')]._destroy();
            }
        }, options);

        this.init = function() {
            this.ejDialog(this.opt);
            window[_this.attr('id')] = this.data("ejDialog");
            window.currentPopupId = _this.attr('id') 
        };
		
		this.init();

		return this;
	};
})(jQuery);