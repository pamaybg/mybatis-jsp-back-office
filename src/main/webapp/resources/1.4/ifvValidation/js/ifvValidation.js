(function($){
    
    $.fn.ifvValidation = function(options){
    	
        this.opt = $.extend({
            itemArr : [],	//validation check item array
            requiredInputArr : [], //필수값 array 
            valiId : null,
        	valiTxtArr : [],
        	type : 'absolute'
        }, options);

        this.init = function(){
            this.addClass('ifv_validation');
            this.inputSetting();
        };

        this.inputSetting = function(){
            
            var arrInput = this.getArray(); 
            var _this = this;
            arrInput.each( function(index, item){
                _this.opt.itemArr.push( $(item).ifvValiItem({parentCheck : _this.allCheck, scope : _this, type : _this.opt.type }) );
            });
            
            this.keydownValiCheck();
        };
        
        this.keydownValiCheck = function(){
        	var inputArr = this.find('input[vali-type=number]');
        	inputArr.keydown(function (e) {
        		
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    (e.keyCode == 65 && e.ctrlKey === true) || 
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                         return;
                }
                
                if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                	e.preventDefault ? e.preventDefault() : (e.returnValue = false);
                }
            });
        	
        	inputArr.blur(function(e){
        		var num_check=/^[0-9]*$/;
        		if( num_check.test(this.value) == false ){
        			this.value = '';
        		}
        	});
        	
        	var floatArr = this.find('input[vali-type=float]');
        	floatArr.keydown(function (e) {
        		
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    (e.keyCode == 65 && e.ctrlKey === true) || 
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                         return;
                }
                if ((e.shiftKey || ((e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 190)) && ((e.keyCode < 96 || e.keyCode > 105) && e.keycode != 110)) {
                	e.preventDefault ? e.preventDefault() : (e.returnValue = false);
                }
            });
        	
        	floatArr.blur(function(e){
        		if(isNaN(this.value) || this.value % 1 === 0)
        			this.value = '';
        	});
        	
        	var latArr = this.find('input[vali-type=lat]');
        	latArr.keydown(function (e) {
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    (e.keyCode == 65 && e.ctrlKey === true) || 
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                         return;
                }
                if ((e.shiftKey || ((e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 190 && e.keyCode != 189)) && ((e.keyCode < 96 || e.keyCode > 105) && e.keycode != 110)) {
                	e.preventDefault ? e.preventDefault() : (e.returnValue = false);
                }
            });
        	
        	latArr.blur(function(e){
            	var reg = /^(-)?(?:90(?:(?:\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,15})?))$/;
            	
            	var check = !reg.test( this.value );
            	
                if( check ){
                	this.value = '';
                }
                	
        	});
        	
        	var lngArr = this.find('input[vali-type=lng]');
        	lngArr.keydown(function (e) {
        		
                if ($.inArray(e.keyCode, [46, 8, 9, 27, 13]) !== -1 ||
                    (e.keyCode == 65 && e.ctrlKey === true) || 
                    (e.keyCode >= 35 && e.keyCode <= 39)) {
                         return;
                }
                if ((e.shiftKey || ((e.keyCode < 48 || e.keyCode > 57) && e.keyCode != 190 && e.keyCode != 189)) && ((e.keyCode < 96 || e.keyCode > 105) && e.keycode != 110)) {
                	e.preventDefault ? e.preventDefault() : (e.returnValue = false);
                }
            });
        	
        	lngArr.blur(function(e){
            	var reg = /^(-)?(?:180(?:(?:\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,15})?))$/;
            	var check = !reg.test( this.value );
            	
                if( check ){
                	this.value = '';
                }
        	});
        };
          
        this.getArray = function(){
        	var inputArr = this.find('input[vali-type], textarea[vali-type], select[vali-type], input[required], textarea[required], select[required]');
        	var falseRequiredArr = this.find('input[required=false], textarea[required=false], select[required=false]');
        	
        	for( var i = inputArr.length-1; i > -1; i-- ){
        		for( var j = falseRequiredArr.length-1; j > -1; j-- ){
        			if( inputArr[i] == falseRequiredArr[j] ){
        				inputArr.splice( i, 1 );
        			}
        		}
        	}
        	return inputArr;
        };
        
        this.requiredCheck = function(){
        	
            for( var i = 0; i < this.opt.requiredInputArr.length; i++ ){
                if( this.opt.requiredInputArr[i].type == 'radio' || this.opt.requiredInputArr[i].type == 'checkbox' ){
                    
                    var arr = this.find('input[name=' + this.opt.requiredInputArr[i].name +']:checked');

                    if( arr.length == 0 ) return this.opt.requiredInputArr[i];

                }else if( this.opt.requiredInputArr[i].value.trim() == '' ){
                    return this.opt.requiredInputArr[i];
                }
            }
            
            return null;
        };
        
        this.allCheck = function(){
        	this.clear();
            var check = -1;
            for( var i = 0; i < this.opt.itemArr.length; i++ ){
                if( this.opt.itemArr[i].check() == false ){
                    check = i;
                    break;
                }
            }    

            return check;          
        };

        this.clear = function(){
        	
        	for( var i = 0; i < this.opt.requiredInputArr.length; i++ ){
        		$(this.opt.requiredInputArr[i]).removeClass('ifv_vali_wrong');
        	}
        	for( var i = 0; i < this.opt.itemArr.length; i++ ){
        		this.opt.itemArr[i].clear();
        		this.opt.itemArr[i].removeClass('ifv_vali_wrong');
        	}
        	for( var i = 0; i < this.opt.valiTxtArr.length; i++ ){
        		this.opt.valiTxtArr[i].remove();
        	}
        };

        this.confirm = function(){
        	
            var check = this.allCheck();

            if( check == -1 ){
                return true;
            }else{
                return false;
            }
        };
        
        this.valiShowAPI = function( _input, _valiItem ){
        	
        	var input = _input;
        	var valiItem = _valiItem;
        	
        	var offset = input.offset();
        	valiItem.show();
        	valiItem.css({ left : offset.left, top : offset.top + 15, opacity : 0 });
            $('body').append( valiItem );
            
    		valiItem.stop().animate({ top:offset.top, opacity : 1 }, 200, function(){
            	hidefailUI();
            });
            
            function hidefailUI(){
            	valiItem.delay( 500 ).animate({ opacity : 0 }, 50, function(){
            		valiItem.hide();
            	});
            };
        };

        this.init();
       
        return this;
    };


    /*
    *
    *   $.fn.ifvValiItem
    *
    */
    $.fn.ifvValiItem = function(options){

        this.opt = $.extend({
            valiItem : null,
            parentCheck : null,
            valiId : null,
            scope : null,
            type : null,
        }, options );

        this.init = function(){
            var _this = this;
            
            this.opt.valiId = this.attr('vali-id');
            
            this.keyup(function(){
            	if( _this.opt.type == 'absolute' ){
            		_this.clear();
            	}else{
            		_this.check();
            	}
            });
            this.change(function(){
            	if( _this.opt.type == 'absolute' ){
            		_this.clear();
            	}else{
            		_this.check();
            	}
            });
            
        };
        
        this.check = function(){
        	this.clear();
        	
        	var type = this.attr('required');
        	if( type != null && this.requiredCheck() == false ) return false;
        	
        	return this.validationCheck();
        };
        
        this.requiredCheck = function(){
        	
        	var str = ifv.validationMessage.required;
        		
            if( this.attr('type') == 'radio' || this.attr('type') == 'checkbox' ){
                
                var arr = $("body").find('input[name=' + this.attr('name') +']:checked');
                if( arr.length == 0 ){
                	this.failUi(str);
                	return false;
                }
            }else if( this.attr('multiple') == 'multiple' ){
            	if( this.val() == '' ){
            		this.failUi(str);
                	return false;
            	}	
            }else if( this.val().trim() == '' ){
            	this.failUi(str);
            	return false;
            	
            }
            
            return true;
        };

        this.validationCheck = function(){
        	if( this.val() == '' ) return true;
            var cheker = true;
            var str = '';
            var type = this.attr('vali-type');
            if( type == null ) return;
            switch( type ){
                case 'email' :
                    cheker = this.emailCheck();
                    str = ifv.validationMessage.email;
                    break;
                
                case 'password' :
                    cheker = this.passwordCheck();
                    str = ifv.validationMessage.password;
                    break;
                    
                case 'passwordConfirm' :
                    cheker = this.passwordConfirmCheck();
                    str = ifv.validationMessage.passwordConfirm;
                    break;
                    
                case 'phone' :
                    cheker = this.phoneCheck();
                    str = ifv.validationMessage.phone;
                    break;
                    
                case 'url' :
                    cheker = this.urlCheck();
                    str = ifv.validationMessage.url;
                    break;
                    
                case 'kor' :
                    cheker = this.hangleCheck();
                    str = ifv.validationMessage.kor;
                    break;
                    
                case 'eng' :
                    cheker = this.engCheck();
                    str = ifv.validationMessage.eng;
                    break;

                case 'number' :
                    cheker = this.numberCheck();
                    str = ifv.validationMessage.number;
                    break;
                    
                case 'exceptHangul' :
                    cheker = this.exceptHangulCheck();
                    str = ifv.validationMessage.exceptHangul;
                    break;
                    
                case 'float' :
                    cheker = this.floatCheck();
                    str = ifv.validationMessage.float;
                    break;

                case 'lat' :
                    cheker = this.latCheck();
                    str = ifv.validationMessage.lat;
                    break;

                case 'lng' :
                    cheker = this.lngCheck();
                    str = ifv.validationMessage.lng;
                    break;
                    
                case 'globalPhone' :
                    cheker = this.globalPhoneCheck();
                    str = ifv.validationMessage.globalPhone;
                    break;
                    
                case 'alphanumeric':
                    cheker = this.alphanumericCheck();
                    str = ifv.validationMessage.alphanumeric;
                    break;
                    
                default:
                	
                    break;
            }
            
            if( cheker == false ){
            	this.failUi(str);
            }

            return cheker;
        };
        
        this.failUi = function(str){
        	if( this.valiItem == null ){
        		
        		if( this.opt.valiId != null ){
        			this.valiItem = $("#" + this.opt.valiId);
        			this.valiItem.text(str);
        			this.makeFailUIShow();
        		}else{
        			this.addClass('ifv_vali_wrong');
        			if( this.opt.type == 'absolute' ){
        				this.makeFailUI2(str);
        			}else{
        				this.makeFailUI(str);
        			}
        		}
        	}
        };
        
        this.makeFailUI = function(str){
        	this.parent().css('position', 'relative');
            this.valiItem = $("<p class='valieTxt'>");
            this.valiItem.text(str);
            this.after( this.valiItem );
        };
        
        this.makeFailUI2 = function(str){
        	this.parent().css('position', 'relative');
            this.valiItem = $("<div class='vali_tooltip'>");
            
            var valiContent = $("<div class='vali_content'>");
            var valiArrow = $("<div class='vali_arrow'>");
            
            valiContent.text(str);
            
            this.valiItem.append(valiContent);
            this.valiItem.append(valiArrow);
            this.makeFailUIShow();
        };
        
        this.makeFailUIShow = function(){
        	if( this.opt.type == 'absolute' ){
        		this.focus();
        		var offset = this.offset();
        		
                this.valiItem.css({ left : offset.left, top : offset.top, opacity : 0 });
                $('body').append( this.valiItem );
                
                var vwidth = this.valiItem.outerWidth();
                var vheight = this.valiItem.outerHeight();
                
                this.valiItem.css({ left : offset.left, top:offset.top - vheight - 10, });
                
        		this.valiItem.stop().animate({ opacity : 1 }, 200, function(){
                	hidefailUI();
                });
                
                var _this = this;
                function hidefailUI(){
                	_this.valiItem.delay( 1000 ).animate({ opacity : 0 }, 50, function(){
                		_this.valiItem.remove();
                		//_this.removeClass('ifv_vali_wrong');
                	});
                };
			}else{
				this.valiItem.show();
			}
        };
        
        this.checkByte = function(value){
            var words_byte = 0; 
            for (var inx = 0; inx < value.length; inx++) { 
                var wd = escape(value.charAt(inx)); 
                if ( wd.length == 1 ) { 
                    words_byte ++; 
                } else if (wd.indexOf("%u") != -1) { 
                    words_byte += 2; 
                } else if (wd.indexOf("%") != -1) { 
                    words_byte += wd.length/3; 
                } 
            } 
            return words_byte;
         };
        
        this.hangleCheck = function(){
        	var reg = /^[가-힣]+$/i
        	return reg.test( this.val() );
        };
        
        this.engCheck = function(){
        	var reg = /^[A-Za-z]+$/i
        	return reg.test( this.val() );
        };
        
        this.numberCheck = function(){
        	var reg = /^[0-9]+$/i
        	return reg.test( this.val() );
        };
        
        this.exceptHangulCheck = function(){
        	var reg = /^[-A-Za-z0-9]+$/i
        	return reg.test( this.val() );
        };
        
        // http://docs.jquery.com/Plugins/Validation/Methods/number
        this.number = function(){
        	var reg = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/
			return reg.test( this.val() );
		};
	
		// http://docs.jquery.com/Plugins/Validation/Methods/numberDE
		this.numberDE = function(){
			var reg = /^-?(?:\d+|\d{1,3}(?:\.\d{3})+)(?:,\d+)?$/
			return reg.test( this.val() );
		},
		
		// http://docs.jquery.com/Plugins/Validation/Methods/digits
		this.digits = function(value, element) {
			var reg = /^\d+$/
			return reg.test( this.val() );
		},
         
        this.passwordStringCheck = function() {
            return true;
        };
        
        this.passwordConfirmCheck = function() {
            return true;  
        };
        
        this.passwordCheck = function() {
        	var v = this.val();
        	if(v.length < 8)
        		return false
    		else
    			return true;
        };
        
        this.emailCheck = function() {
            var reg = /^([0-9a-zA-Z!#\$%&'\*\+\-\/=\?\^_`{\|}~\.]+)@([0-9a-zA-Z_-]+)(\.[a-zA-Z]+){1,2}$/i
            var check = reg.test( this.val() );
            
            if( check ){
                return true;
            }else{
                return false;
            }
        };
        
        this.urlCheck = function() {
        	var reg = /^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/;
            var check = reg.test( this.val() );
            
            if( check ){
                return true;
            }else{
                return false;
            }
        };
        
        this.phoneCheck = function() {
            var reg = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
            var check = !reg.test( this.val() );

            if( !check ){
                return true;
            }else{
                return false;
            }
        };
        
        this.floatCheck = function() {
        	var v = this.val();
        	return !isNaN(v) && v % 1 !== 0 ? true : false;
        };

        this.latCheck = function() {
        	var reg = /^(-)?(?:90(?:(?:\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\.[0-9]{1,15})?))$/;
        	
        	var check = !reg.test( this.val() );
        	
            if( !check ){
                return true;
            }else{
                return false;
            }
        };
        
        this.lngCheck = function() {
        	var reg = /^(-)?(?:180(?:(?:\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\.[0-9]{1,15})?))$/;
        	
        	var check = !reg.test( this.val() );
        	
            if( !check ){
                return true;
            }else{
                return false;
            }
        };

        this.globalPhoneCheck = function() {
        	var reg = /^[\+\-0-9][\-0-9]+$/gm;
        	
        	var check = !reg.test( this.val() );
        	
            if( !check ){
                return true;
            }else{
                return false;
            }
        };
        
        this.alphanumericCheck = function() {
            var reg = /^[a-z0-9]+$/i;

            var check = !reg.test(this.val());

            if (!check) {
                return true;
            } else {
                return false;
            }
        };
        
        this.clear = function(){
        	if( this.valiItem != null ){
        		if( this.opt.valiId != null ){
        			this.valiItem.hide();
        		}else{
            		this.valiItem.remove();
        		}
        		this.removeClass('ifv_vali_wrong');
        		this.valiItem = null;
        	}
        };
        

        this.init();

        return this;
    };

})(jQuery);