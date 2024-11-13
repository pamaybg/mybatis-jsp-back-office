var popupComponetNum = 0;
var currentPopupComponent;
ik.PopupFullscreen = function(obj){
	
	this.bg = document.createElement('div');
	$(this.bg).attr('id','popupFullScreen' + popupComponetNum);
	this.bg.className = 'dark_alpha_pop';
	var body = document.getElementsByTagName('body')[0];
	body.appendChild( this.bg );
	
	this.closeBtn = document.createElement('div');
	this.closeBtn.className = 'btn_close';
	this.closeBtn.innerHTML = '<button><img src="' + obj.btnImg + '" /></button>';
	this.bg.appendChild(this.closeBtn);
	this.innerItem = $(obj.innerItem)[0];
	this.closeFunction = obj.closeFunction;
	this.bg.appendChild( this.innerItem );
	this.eventSetting();
	this.rePosition();
	
	$('body').css( 'overflow', 'hidden' );
	popupComponetNum++;
};

ik.PopupFullscreen.prototype = {
	bg : null,
	closeBtn : null,
	closeFunction : null,
	innerItem : null
};

ik.PopupFullscreen.prototype.eventSetting = function(){
	
	var _this = this;
	ik.lib.addEventListener( window, 'resize', function(e){
		_this.rePosition();
	});
	
	ik.lib.addEventListener( this.closeBtn, 'click', function(e){
		ik.lib.closeFullScreenPopup();
		
		if(_this.closeFunction != null ){
			_this.closeFunction();
		}
		
		/*_this.bg.parentNode.removeChild( _this.bg );
		popupComponetNum--;
		if( popupComponetNum == 0 ){
			ik.lib.getByTagName( document, 'body').style.overflow = 'auto';
		}*/
	});
	
	
	ik.lib.addEventListener(document, 'keydown', function(e){
		if(event.keyCode == 27) {
			$('.btn_close').trigger('click');
	    }
	});
};

ik.PopupFullscreen.prototype.rePosition = function(){
	var fullHeight = document.body.clientHeight;
	var fullWidth = document.body.clientWidth;
	var tarTop = fullHeight/2 - this.innerItem.clientHeight/2;
	if( tarTop < 20 ) tarTop = 20;
	var bottomGap = 0;
	if( this.innerItem.clientHeight > fullHeight ){
		bottomGap = 50;
	}
	this.innerItem.style.marginBottom = bottomGap + 'px'; 
	
	this.bg.style.height = fullHeight;
	this.bg.style.paddingTop = tarTop + 'px'; 
	this.closeBtn.style.left = (fullWidth/2 + this.innerItem.clientWidth/2 - 22) + 'px'; 	
	this.closeBtn.style.top = (tarTop -26) + 'px'; 	
};






ik.toastPop = function(obj){
	this.item = document.createElement('div');
	$(this.item).attr('id','toastPop');
	
	if( obj.isSuccess == null || obj.isSuccess ){
		this.item.className = 'toast_pop_success';
	}else{
		this.item.className = 'toast_pop_fail';
	}
	this.closeFunc = obj.closeFunc;
	
	this.item.innerHTML = obj.text;
	
	var body = document.getElementsByTagName('body')[0];
	body.appendChild( this.item );
	
	this.rePosition();
	
	var _this = this;
	setTimeout(function(){
		_this.item.parentNode.removeChild( _this.item );
		if( _this.closeFunc != null ) _this.closeFunc();
		_this = null;
	},1000);
	
};

ik.toastPop.prototype = {
	item : null,
	closeFunc : null
};

ik.toastPop.prototype.rePosition = function(){
	
	var fullHeight = document.body.clientHeight;
	var fullWidth = document.body.clientWidth;
	var tarTop = fullHeight/2 - this.item.clientHeight/2;
	this.item.style.left = (fullWidth/2 - this.item.clientWidth/2) + 'px'; 	
	this.item.style.top = (tarTop - 20) + 'px'; 	
	
	var ty = $(this.item).css('top');
	$(this.item).css( { top : (parseInt(ty)+20) + "px" });
	$(this.item).animate({ top : "-=20px" }, 200 );
};


ik.confirm = function( obj ){
	var html = "";
	html += "<div class='dark_alpha_pop'>";
		html += "<div id='toastPop'>";
			html += "<div class='txt_area'></div>";
			html += "<div class='img_area'><img src='' /></div>";
			html += "<div class='btn_area'>";
				html += "<button class='btn1'></button>";
				html += "<button class='btn2'></button>";
			html += "</div>";
		html += "</div>";
	html += "</div>";
	
	this.view = $(html);
	
	this.btnTxt1 = obj.btnTxt1;
	this.btnTxt2 = obj.btnTxt2;
	this.item = this.view;
	
	this.toastPop = this.item.find('#toastPop');
	
	this.txtArea = this.item.find('.txt_area');
	this.txtArea.text(obj.text);
	
	this.toastPop.addClass('toast_pop_fail');
	this.closeFunc = obj.closeFunc;
	var body = document.getElementsByTagName('body')[0];
	$(body).append( this.item );
	
	this.rePosition();
	var _this = this;
	
	this.btn1 = this.item.find('.btn1');
	this.btn1.text(this.btnTxt1);
	this.btn1.click(function(){
		_this.remove();
		if( obj.closeFunc != null ) obj.closeFunc(1);
		return false;
	});
	this.btn2 = this.item.find('.btn2');
	this.btn2.text(this.btnTxt2);
	this.btn2.click(function(){
		_this.remove();
		return false;
	});
	
	if( this.btnTxt1 == null ){
		this.btn1 = this.item.find('.btn1');
		this.btn1.css("display","none");
	}
	if( this.btnTxt2 == null ){
		this.btn2 = this.item.find('.btn2');
		this.btn2.css("display","none");
	}
	if( this.btnTxt1 == null && this.btnTxt2 == null ){
		this.item.find('.btn_area').css("display","none");
	}
	
	if( obj.img == null ){
		this.item.find('.img_area').css("display","none");
	}else{
		this.imgArea = this.item.find('.img_area').find('img');
		this.imgArea.attr('src', obj.img );
	}
		
	

	
	/*ik.lib.addEventListener( window, 'resize', function(e){
		_this.rePosition();
	});*/
};

ik.confirm.prototype = {
	item : null,
	closeFunc : null,
	btnTxt : null
};

ik.confirm.prototype.rePosition = function(){
	this.item.css( 'top', $('body').scrollTop() );
	
	var fullHeight = $(window).height();
	var fullWidth = document.body.clientWidth;
	var tarTop = fullHeight/2 - this.toastPop.height()/2;
	this.toastPop.css( 'left', (fullWidth/2 - this.toastPop[0].clientWidth/2) + 'px' ); 	
	this.toastPop.css( 'top', (tarTop - 20) + 'px'); 	
	var ty = $(this.txtArea).css('top');
	$(this.toastPop).css( { top : (parseInt(ty)+20) + "px" });
	$(this.toastPop).animate({ top : "-=20px" }, 200 );
	$("html").css({overflow:'hidden'});
	$("body").css({overflow:'hidden'}).bind('touchmove', function(e){e.preventDefault()});
};

ik.confirm.prototype.remove = function(){
	
	$("html").css({overflow:'auto'});
	$("body").unbind('touchmove');
	this.view.remove();
};




ik.confirmMoblie = function( obj ){
	var html = "";
	html += "<div class='dark_alpha_pop2'>";
		html += "<div id='toastPop'>";
			html += "<div class='txt_area'></div>";
			html += "<div class='img_area'><img src='' /></div>";
			html += "<div class='btn_area'>";
				html += "<button class='btn1'></button>";
				html += "<button class='btn2'></button>";
			html += "</div>";
		html += "</div>";
	html += "</div>";
	
	this.view = $(html);
	
	this.btnTxt1 = obj.btnTxt1;
	this.btnTxt2 = obj.btnTxt2;
	this.item = this.view;
	
	
	
	this.toastPop = this.item.find('#toastPop');
	
	this.txtArea = this.item.find('.txt_area');
	this.txtArea.text(obj.text);
	
	this.toastPop.addClass('toast_pop_fail');
	this.closeFunc = obj.closeFunc;
	//var body = document.getElementsByTagName('body')[0];
	$('body').append( this.item );
	
	this.rePosition();
	var _this = this;
	
	this.btn1 = this.item.find('.btn1');
	this.btn1.text(this.btnTxt1);
	this.btn1.click(function(){
		_this.remove();
		if( obj.closeFunc != null ) obj.closeFunc(1);
		return false;
	});
	this.btn2 = this.item.find('.btn2');
	this.btn2.text(this.btnTxt2);
	this.btn2.click(function(){
		_this.remove();
		return false;
	});
	
	if( this.btnTxt1 == null ){
		this.btn1 = this.item.find('.btn1');
		this.btn1.css("display","none");
	}
	if( this.btnTxt2 == null ){
		this.btn2 = this.item.find('.btn2');
		this.btn2.css("display","none");
	}
	if( this.btnTxt1 == null && this.btnTxt2 == null ){
		this.item.find('.btn_area').css("display","none");
	}
	
	if( obj.img == null ){
		this.item.find('.img_area').css("display","none");
	}else{
		this.imgArea = this.item.find('.img_area').find('img');
		this.imgArea.attr('src', obj.img );
	}
		
	

	
	/*ik.lib.addEventListener( window, 'resize', function(e){
		_this.rePosition();
	});*/
};

ik.confirmMoblie.prototype = {
	item : null,
	closeFunc : null,
	btnTxt : null
};

ik.confirmMoblie.prototype.rePosition = function(){
	//this.item.css( 'top', $('body').scrollTop() );
	
	var fullHeight = document.body.clientHeight;
	var fullWidth = document.body.clientWidth;
	
	$(".dark_alpha_pop2").height( fullHeight );
	
	var tarTop = fullHeight/2 - this.toastPop.height()/2;
	this.toastPop.css( 'left', (fullWidth/2 - this.toastPop[0].clientWidth/2) + 'px' ); 	
	this.toastPop.css( 'top', (tarTop - 20) + 'px'); 	
	var ty = $(this.txtArea).css('top');
	$(this.toastPop).css( { top : (parseInt(ty)+20) + "px" });
	$(this.toastPop).animate({ top : "-=20px" }, 200 );
	$("html").css({overflow:'hidden'});
	$("body").css({overflow:'hidden'}).bind('touchmove', function(e){e.preventDefault()});
};

ik.confirmMoblie.prototype.remove = function(){
	
	$("html").css({overflow:'auto'});
	$("body").unbind('touchmove');
	this.view.remove();
};






