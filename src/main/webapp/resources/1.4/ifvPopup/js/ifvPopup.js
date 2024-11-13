ifv.isConfirm = false; //얼럿창 중복안뜨게 하기 위한 플레그
ifv.popNum = 0;
ifv.cPop = null;
ifvPopup = function(){};
ifvPopup.prototype = {
	closeFullScreenPopup : function(obj){
		ifv.popNum--;
		if( ifv.popNum < 0 ) {
			ifv.popNum = 0;
			return;
		}
		var modal = ifv.popup.modalPopArr[ifv.popNum];
		if( modal == null ) return;
		modal.remove();
		if( modal.close != null ) modal.close.call( modal.scope, obj );
		
		ifv.popup.modalPopArr.splice( ifv.popNum, 1 );
		
	    //$( '#ifvPopupFullScreen' + ifv.popNum ).remove();
	    if( ifv.popNum == 0 ){
	        $('body')[0].style.overflow = 'auto';
	    }
	},

	closeFullScreenAllPopup : function(){
	    for( var i= 0; i<ifv.popNum; i++ ){
	        this.closeFullScreenPopup();
	    }
	},

	fullScreenPopRelocation : function(){
		ifv.cPop.rePosition();
	},
	
	modalPopArr : []
};
ifv.popup = new ifvPopup();

ifvPopupFullscreen = function(obj){
	//brower 분기(ie에서 activeElement.blur() 오류 수정)
	var uua = navigator.userAgent;
	var napn = navigator.appName; 
	var nua = uua.toLowerCase();
	//ie 11버전은 msie 텍스트를 갖고 있지 않으므로 Appname과 Trident로 구분
	if ( (napn == 'Netscape' && uua.search('Trident') != -1) || (nua.indexOf("msie") != -1)) {
		if ( document.activeElement && document.activeElement.nodeName.toLowerCase() !== "body" ) {
	        document.body.focus();
		}
	} else {
		if (document.activeElement != document.body) document.activeElement.blur();
	}
	this.bg = $("<div class='dark_alpha_pop'>");
	this.bg.attr('id', 'ifvPopupFullScreen' + ifv.popNum );
	
	this.bg.close = obj.close; 	//팝업닫을때 close func 호출하기 위해 객체에 저장
	this.bg.scope = obj.scope; 	//팝업닫을때 close func 호출하기 위해 객체에 저장
	ifv.popup.modalPopArr.push(this.bg);
	
	//변수 초기화
	if( obj.valign != null ) this.valign = obj.valign;
	if( obj.tGap != null ) this.tGap = obj.tGap;
	
	this.init( obj );
};

ifvPopupFullscreen.prototype = {
	bg : null,
	closeBtn : null,
	contentCon : null,
	valign : 'middle', 
	tGap : 30,
};

ifvPopupFullscreen.prototype.init = function( obj ){
	
	$('body').append(this.bg);
	$('body').css( 'overflow', 'hidden' );
	
	this.contentCon = $("<div class='ifv_content_con'>");
	this.contentCon.append( obj.content );
	this.bg.append( this.contentCon );
	
	this.closeBtn = $("<a href='javascript:;' class='btn_close'>");
	this.contentCon.children().append( this.closeBtn );

	this.eventSetting();
	this.rePosition();

	ifv.popNum++;
};

ifvPopupFullscreen.prototype.eventSetting = function(){

	var _this = this;
	$(window).resize( function(e){
		_this.rePosition();
	});

	this.closeBtn.click( function(e){
		ifv.popup.closeFullScreenPopup();
	});

	$(document).one('keydown', function(e){
		if(event.keyCode == 27) {
			ifv.popup.closeFullScreenPopup();
	    }
	});
};

ifvPopupFullscreen.prototype.rePosition = function(){
	var fullHeight = $(window).height();
	
	this.bg.height( fullHeight );
	
	var pos = this.getTarPos(fullHeight);
	
	this.contentCon.css('marginTop', ( pos.tarTop ) + 'px' );
	
	this.bg.css('paddingBottom', pos.bottomGap + 'px' );
};

ifvPopupFullscreen.prototype.getTarPos = function(fullHeight){
	
	var bottomGap = 0;
	if( this.contentCon.height() > fullHeight ){
		bottomGap = 50;
	};
	var tarTop = 0;
	switch( this.valign ){
		case 'top' :
			tarTop = this.tGap;
			break;
			
		case 'middle' :
			tarTop = fullHeight/2 - this.contentCon.height()/2;
			if( tarTop < this.tGap ) tarTop = this.tGap;
			break;
	};
	
	return {
		bottomGap : bottomGap,
		tarTop : tarTop
	};
};


/*
 * BasePopup
 */
BasePopup = function(){
	$.ifvLoadEndPop( this.init );
	
};

BasePopup.prototype.init = function(data){
	
};

BasePopup.prototype.close = function(){
    ifv.popup.closeFullScreenPopup();
};

BasePopup.prototype.reload = function(){
    window.location.reload();
};

BasePopup.prototype.reLocation = function(){
    ifv.popup.fullScreenPopRelocation();
};




/*
 * ifvConfirm 
 */
ifvConfirm = function( obj ){

	if( ifv.isConfirm == true ){
		return;
	}
	ifv.isConfirm = true;
	
	this.uiSetting();
	
	if( obj.btnTxt1 != null ) this.btnTxt1 = obj.btnTxt1;
	if( obj.btnTxt2 != null ) this.btnTxt2 = obj.btnTxt2;
	
	this.toastPop = this.item.find('#toastPop');
	if( this.toastPop == null || this.toastPop.length == 0 ) return;
	
	this.txtArea = this.item.find('.txt_area');
	this.txtArea.html(obj.text);
	
	this.toastPop.addClass('toast_pop_fail');
	this.closeFunc = obj.closeFunc;
	
	$('body').append( this.item );
	
	this.rePosition();
	var _this = this;
	
	this.btn1 = this.item.find('.btn1');
	this.btn1.text(this.btnTxt1);
	this.btn1.click(function(){
		_this.remove();
		$('body').css({'overflow':''});
		if( obj.closeFunc != null ) obj.closeFunc(1);
		return false;
	});
	
	this.btn2 = this.item.find('.btn2');
	this.btn2.text(this.btnTxt2);
	this.btn2.click(function(){
		_this.remove();
		return false;
	});
	
	if( this.btnTxt1 == false ){
		this.btn1 = this.item.find('.btn1');
		this.btn1.css("display","none");
	}
	if( this.btnTxt2 == false ){
		this.btn2 = this.item.find('.btn2');
		this.btn2.css("display","none");
	}
	
	if( this.btnTxt1 == false && this.btnTxt2 == false ){
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

ifvConfirm.prototype = {
	item : null,
	closeFunc : null,
	btnTxt : null,
	btnTxt1 : ifv.commonMessage.ok,
	btnTxt2 : ifv.commonMessage.cancel
};

ifvConfirm.prototype.uiSetting = function(){
	var html = $("#ifvConfirmTemplete").text();
	//brower 분기(ie에서 activeElement.blur() 오류 수정)
	var uua = navigator.userAgent;
	var napn = navigator.appName; 
	var nua = uua.toLowerCase();
	//ie 11버전은 msie 텍스트를 갖고 있지 않으므로 Appname과 Trident로 구분
	if ( (napn == 'Netscape' && uua.search('Trident') != -1) || (nua.indexOf("msie") != -1)) {
		if ( document.activeElement && document.activeElement.nodeName.toLowerCase() !== "body" ) {
	        document.body.focus();
		}
	} else {
		if (document.activeElement != document.body) document.activeElement.blur();
	}
	
	html = html.replace('{txt_area}', "<div class='txt_area'></div>");
	html = html.replace('{img_area}', "<div class='img_area'><img src='' /></div>");
	html = html.replace('{btn1}', "<a href='javascript:;' class='btn1 btn_style'></a>");
	html = html.replace('{btn2}', "<a href='javascript:;' class='btn2 btn_style'></a>");
	
	this.item = $(html);
};

ifvConfirm.prototype.rePosition = function(){
	
	if( this.toastPop == null || this.toastPop.length == 0 ) return;
	
	//this.item.css( 'top', $('body').scrollTop() );
	
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

ifvConfirm.prototype.remove = function(){
	ifv.isConfirm = false;
	$("html").css({overflow:'auto'});
	$("body").css({overflow:'auto'}).unbind('touchmove');
	this.item.remove();
};
