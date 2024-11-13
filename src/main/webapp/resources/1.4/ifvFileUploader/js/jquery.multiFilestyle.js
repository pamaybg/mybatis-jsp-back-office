/*
 * Style File - jQuery plugin for styling file input elements
 *  
 * Copyright (c) 2007-2008 Mika Tuupola
 *
 * Licensed under the MIT license:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Based on work by Shaun Inman
 *   http://www.shauninman.com/archive/2007/09/10/styling_file_inputs_with_css_and_the_dom
 *
 * Revision: $Id: jquery.filestyle.js 303 2008-01-30 13:53:24Z tuupola $
 *
 */

(function($) {
    
    $.fn.multiFilestyle = function(options) {
                
        var settings = {
            width : 250,
            height : 30,
            imagewidth : 17,
            imageheight : 30,
            icon : false
        };
        
        this.opts = {};
		this.opts = $.extend({}, settings, options);
		
                
        if(options) {
            $.extend(settings, options);
        };
                        
        return this.each(function() {
            var self = this;
            var wrapper = null;
            if(!settings.icon){
	            wrapper = $("<div id='"+settings.id+"' class='mt5'>")
	                            .css({
	                                "width": settings.imagewidth + "px",
	                                "height": settings.imageheight + "px",
	                                /*"background": "url(" + settings.image + ") no-repeat",*/
	            	                /*"background-size": "cover",*/
	            	                //"-ms-behavior" : 'url(\'<ifvb:image name="backgroundsize"/>\')',
	            	                "display": "block",
	            	                "overflow": "hidden",
	            					"margin-left":"0px",
	            					"margin-top":"0px",
	            					"margin-bottom":"0px",
	            					//"border" : "1px #d7d7d7  dashed",
	            					"position": "relative"
	                            });
            }
            else{
            	 wrapper = $("<div id='img"+settings.id+"' class='mt5'>").css({
            		 "width": settings.imagewidth + "px",
                     "height": settings.imageheight + "px",
                     /*"background": "url(" + settings.image + ") no-repeat",*/
                     "display" : "block",
             		 "position" : "absolute",
             		 //"right" : "22px",
                     "cursor": "pointer",
             		 "top" : "2px",
             		 //"z-index" : "2108"
                 });
            }
            
            if( settings.image != null ) wrapper.css({ "background": "url(" + settings.image + ") no-repeat" });
            
            var filename = $("<input class='file'>")
                             .addClass($(self).attr("class"))
                             .css({
                                 "display": "none",
                                 "width": settings.width + "px",
                                 "height": settings.height + "px"
                             });

            
            $(self).before(filename);
            $(self).wrap(wrapper);
            
            $(self).css({
                        "position": "relative",
                        "height": settings.height + "px",
                        "width": settings.width + "px",
                        "display": "inline",
                        "cursor": "pointer",
                        "opacity": "0.0",
                      	//"z-index" : "2120"
                    });

            if ($.browser.mozilla) {
                if (/Win/.test(navigator.platform)) {
                    //$(self).css("margin-left", "-142px");                    
                } else {
                    $(self).css("margin-left", "-168px");                    
                };
            } else {
                $(self).css("margin-left", settings.imagewidth - settings.width + "px");                
            };

            $(self).bind("change", function() {
                filename.val($(self).val());
            });
      
        });
        

    };
    
})(jQuery);
