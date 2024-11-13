
(function($){
	/**
	 * 
	 * @class ifvsfPopup
	 * 
	 */
	$.fn.ifvsfPopup = function(options){
        var _this = this;

        var attrId = _this.attr('id');

		// 팝업 close 용 popup stack 생성
		window["popups"] = (typeof window["popups"] === "undefined") ? [] : window["popups"];
		window["popups"].push(attrId);

        window[this.attr('id')]; //전역변수 생성
        var pwid = options.width ? typeof options.width != "number" ? Number(options.width.replace('px', '')) : options.width : 600;
        var posx = Math.ceil((window.innerWidth - pwid)/2);
        var openCallback = function(args) {
        	if( window[attrId + '_init'] != null ) window[attrId + '_init'](_this.opt.params);
        	if(options.open) {
        		typeof options.open == "string" ? window[options.open](args) : options.open(args); 
        	}
        }
        this.opt = $.extend({
        	enableModal : true,
            enableResize: false,
            contentType: "ajax",
            width: 600,
            maxWidth: 1024,
            position : {X: posx, Y:50},
            close: function() {
				window["popups"].pop();
				window[attrId].destroy();
				delete window[attrId];
            }
        }, options);
        this.opt.open = openCallback;
        
        this.init = function() {
            this.ejDialog(this.opt);
            window[attrId] = this.data("ejDialog");
        };

        this.init();

        return this;
	};
})(jQuery);