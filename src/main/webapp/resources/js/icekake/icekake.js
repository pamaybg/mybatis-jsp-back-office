
$.extend({
	ikNewUUID : function(){
		return UUID.generate().replace(/-/g,'').substring(0, 24);
	},
	ikSetParentReload : function (flag){
		$.smartPop.parentReload(true);
	},
	/**
	 * 모든 파라미터를 배열 형태로 추출
	 * @returns {Array}
	 */
	ikGetParams: function(){
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
      hash = hashes[i].split('=');
      vars.push(hash[0]);
      vars[hash[0]] = hash[1];
    }
    return vars;
  },
  /**
   * URL 마지막 경로를 추출
   * @returns 
   */
	ikGetLastUrl: function(){
		var hashes = window.location.href.split('/');
		
		return hashes[hashes.length - 1];
	},
  /**
   * 파라미터 Value 를 추출
   * @param name 파라미터 명
   * @returns
   */
  ikGetParam: function(name){
    return $.ikGetParams()[name];
  },
  
  /**
   * 지역정보 체크
   * 1. 접속시 사용자의 위/경도 정보를 쿠키에 저장
   * 2. 쿠키 만료시간을 하루로 하여 하루에 한번만 저장 가능
   * @author jskim
   * @param LOCATION_LATITUDE_PROP
   * @param LOCATION_LONGITUDE_PROP
   */
  ikGeolocationInit : function(LOCATION_LATITUDE_PROP, LOCATION_LONGITUDE_PROP){
	  if (navigator.geolocation) {
	        var geo = navigator.geolocation;
	        geo.getCurrentPosition(function (pos) {
	            // 위도
	            //alert(pos.coords.latitude);
	            // 경도
	            //alert(pos.coords.longitude);
	            // 정확도
	            //alert(pos.coords.accuracy);
	            // 마지막 업데이트 시간(초)
	            //alert(pos.timestamp);
	            
				$.cookie(LOCATION_LATITUDE_PROP, pos.coords.latitude,  { expires: 1 });
				$.cookie(LOCATION_LONGITUDE_PROP, pos.coords.longitude, { expires: 1 });
	        }, function (e) {

	        }, {
	            enableHeighAccuracy: false,
	            timeout: 10000,
	            maximumAge: 0
	        });
	    }
	    else {
	        alert('HTML 5 지오로케이션을 지원하지 않는 브라우저입니다.');
	    }
  },
  /**
   * 페이지 스크롤이 화면 최하단에 도달했을때 요청한 이벤트 발생.
   * @param evt 요청 이벤트
   */
  ikScroll : function(evt){
  	
	  $(window).scroll(function(){
		 
		/* ik.console.setText('scrollTop : ' + $(window).scrollTop() + '<br/>' );
		 ik.console.setText('height() - height() : ' + ( $(document).height() - $(window).height() ) + '<br/>' );*/
		  
			if( $(window).scrollTop() > $(document).height() - $(window).height() - 400 ){
				
				$( "#txtAutoCompSearch").autocomplete( "close" );
				
				evt();
			}
		});
  },
  ikSmartScroll : function(evt){
	  parent.$('#smartPop').scroll(function(){
			if (parent.$('#smartPop').scrollTop() > $(document).height() - parent.$('#smartPop').height()){
				evt();
			}
		});
  },
  /**
   * 비동기 서버 호출(Post방식)
   * @param url	호출 Url
   * @param jsonData	파라미터 Data
   * @param callback Return메서드
   */
  ikPostJSON : function(url, jsonData, callback){
	  var config = {
              url: url,
              type: "POST",
              data: jsonData ? $.toJSON(jsonData) : null,
              dataType: "json",
              contentType: "application/json; charset=utf-8",
              success: callback,
              async:true
          };
          
      $.ajaxSetup(config); 
      $.ajax();
      
      config = {
              url: null,
              type: "GET",
              data: null,
              dataType: null,
              contentType: "application/x-www-form-urlencoded",
              success: null
          };
      $.ajaxSetup(config);
  },
  ikPostHeaderJSON : function(url, jsonData, jsonHeaderData, callback){
	  var config = {
              url: url,
              type: "POST",
              data: jsonData ? $.toJSON(jsonData) : null,
              dataType: "json",
              contentType: "application/json; charset=utf-8",
              success: callback,
              async:true,
              headers : jsonHeaderData
          };
          
      $.ajaxSetup(config); 
      $.ajax();
      
      config = {
              url: null,
              type: "GET",
              data: null,
              dataType: null,
              contentType: "application/x-www-form-urlencoded",
              success: null
          };
      $.ajaxSetup(config);
  },
  ikLoadingPostJSON : function(url, jsonData, callback, rootElement){
	  var config = {
              url: url,
              type: "POST",
              data: jsonData ? JSON.stringify(jsonData) : null,
              dataType: "json",
              contentType: "application/json; charset=utf-8",
              success: callback,
              async:true,
              beforeSend : function(xhr){
            	  $(rootElement).block({ message: null, css: { background:'white', background:'#fff'} }); 
              },
              complete : function(xhr,status){
            	  $(rootElement).unblock(); 
             }
          };
          
      $.ajaxSetup(config); 
      $.ajax();
      
      config = {
              url: null,
              type: "GET",
              data: null,
              dataType: null,
              contentType: "application/x-www-form-urlencoded",
              success: null
          };
      $.ajaxSetup(config);
  },
  /**
   * 동기 서버 호출(Post방식)
   * @param url	호출 Url
   * @param jsonData	파라미터 Data
   * @param callback Return메서드
   */
  ikSyncPostJSON : function(url, jsonData, callback){
	  var config = {
              url: url,
              async:false,
              type: "POST",
              data: jsonData ? JSON.stringify(jsonData) : null,
              dataType: "json",
              contentType: "application/json; charset=utf-8",
              success: callback
          };
          
      $.ajaxSetup(config); 
      $.ajax();
      
      config = {
              url: null,
              type: "GET",
              data: null,
              async : true,
              dataType: null,
              contentType: "application/x-www-form-urlencoded",
              success: null
          };
      $.ajaxSetup(config);
  },
  /**
   * 비동기 서버 호출(Get방식)
   * @param url	호출 Url
   * @param jsonData	파라미터 Data
   * @param callback Return메서드
   */
  ikGetJSON : function( url, jsonData, callback ) {
	  if ( jQuery.isFunction( jsonData ) ) {
			type = "json" || callback;
			callback = jsonData;
			data = undefined;
		}

		return jQuery.ajax({
			type: "get",
			url: url,
			async:true,
			data: jsonData,
			success: callback,
			dataType: "json"
		});
  },
  /**
   * 비동기 서버 호출(Get방식)
   * @param url	호출 Url
   * @param jsonData	파라미터 Data
   * @param callback Return메서드
   */
  ikLoadingGetJSON : function( url, jsonData, callback, rootElement ) {
	  if ( jQuery.isFunction( jsonData ) ) {
			type = "json" || callback;
			callback = jsonData;
			data = undefined;
		}

		return jQuery.ajax({
			type: "get",
			url: url,
			async:true,
			data: jsonData,
			success: callback,
			dataType: "json",
			 beforeSend : function(xhr){
            	  $(rootElement).block({ message: null, css: { background:'white', background:'#fff'} }); 
              },
              complete : function(xhr,status){
            	  $(rootElement).unblock(); 
             }
		});
  },
  /**
   * 동기 서버 호출(Get방식) 버그 사용하지 않음.
   * @param url	호출 Url
   * @param jsonData	파라미터 Data
   * @param callback Return메서드
   */
  ikSyncGetJSON : function( url, jsonData, callback ) {
	  if ( jQuery.isFunction( jsonData ) ) {
			type = "json" || callback;
			callback = jsonData;
			data = undefined;
		}
	  
	  var config = {
			type: "get",
			url: url,
            async:false,
			data: jsonData,
			success: callback,
			dataType: "json"
		};
	  
	  $.ajaxSetup(config); 
      $.ajax();
      
      config = {
              url: null,
              type: "GET",
              data: null,
              dataType: null,
              contentType: "application/x-www-form-urlencoded",
              success: null
          };
      $.ajaxSetup(config);
      
  },
  ikGetRSSXML : function( url, jsonData, callback ) {
	  if ( jQuery.isFunction( jsonData ) ) {
			type = "json" || callback;
			callback = jsonData;
			data = undefined;
		}

		return jQuery.ajax({
			type: "get",
			url: url,
			data: jsonData,
			success: callback,
			dataType: "application/rss+xml"
		});
  },
  /**
   * onkeypress 이벤트 발생시 특수문자 입력 방지
   * @param e 이벤트
   */
  ikCheckSpecialCharacter : function (e) {
	     if(/\W/.test(String.fromCharCode(e.keyCode)) && e.keyCode != 46) e.returnValue = false;
  },
  /**
   * host 정보 리턴
   * @returns
   */
  ikHost : function (){
		 var Dns;
		 Dns=location.href;
		 Dns=Dns.split("//");
		 Dns="http://"+Dns[1].substr(0,Dns[1].indexOf("/"));
		 return Dns;
  },
  /**
   * 현재 페이지를 이동한다.
   * @param url 페이지 경로
   */
  ikNavigate : function(url){
	  location.href = url;
  },
  ikCachedScript : function(url, options) {

	  // allow user to set any option except for dataType, cache, and url
	  options = $.extend(options || {}, {
	    dataType: "script",
	    cache: true,
	    url: url
	  });

	  // Use $.ajax() since it is more flexible than $.getScript
	  // Return the jqXHR object so we can chain callbacks
	  return jQuery.ajax(options);
	},
	ikCachedHtml : function(url, options) {

	  // allow user to set any option except for dataType, cache, and url
	  options = $.extend(options || {}, {
	    dataType: "html",
	    cache: true,
	    async:false, 
	    url: url
	  });

	  // Use $.ajax() since it is more flexible than $.getScript
	  // Return the jqXHR object so we can chain callbacks
	  return jQuery.ajax(options);
	},
  /**
   * 해당 페이지를 레이어 팝업으로 띄운다.
   * @param url
   */
  ikSmartPopup : function(url, title, width, height, type, isconfirm){
	  $( "#txtAutoCompSearch").autocomplete( "close" );
	  //$.ikCachedScript("resources/js/jquery.smartPop.js").done(function(script, textStatus) {
	  var confirm = false;
	  if(isconfirm != undefined)
		  confirm = isconfirm;
	  
	  $.smartPop.open({background:"black", title: title, width: width, revise: 0, height: 100, url: url, type : type, confirm : confirm});
	  //});
  },
  ikParentSmartPopup : function(pop, url, title, width, height, type){
	  pop.close();
	  //$.ikCachedScript("resources/js/jquery.smartPop.js").done(function(script, textStatus) {
	  pop.open({background:"black", title: title, width: width, revise: 0, height: 100, url: url, type : type });
	  //});
  },
  /**
   * 바이트 수를 리턴한다.
   * @param value
   * @returns {Number}
   */
  ikCheckByte : function(value){
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
  },
  ikGetAESKey : function(){
	  return "abcdefghijklmnopqrstuvwxyz123456";
  },
  ikAESEncode : function(encodeText){
		GibberishAES.size(256);	
		return GibberishAES.aesEncrypt(encodeText, $.ikGetAESKey());
  },
  ikAESDecode : function(decodeText){
		GibberishAES.size(256);	
		return GibberishAES.aesDecrypt(decodeText, $.ikGetAESKey());
  },
  ikCookieList : function(cookieName) {
	  var cookie = $.cookie(cookieName);
	  
	  var items = cookie ? cookie.split(/,/) : new Array();
	  
	  return {    
		  "add" : function(val) {
			  items.push(val);

			  $.cookie(cookieName, items.join(','));
		  },    
		  "clear" : function() {
			  items = null;        
			  
			  $.cookie(cookieName, null);    
		  },
		  "items" : function() {
			  return items;    
		  }
	  }  
  },
  ikShareFacebook : function (url , image, title, summary) {
	  var linkUrl = "http://www.facebook.com/sharer.php?s=100&p[url]=" + url 
	  + "&p[images][0]=" + image
	  + "&p[title]=" + encodeURIComponent(title) 
	  + "&p[summary]=" + encodeURIComponent(summary);
	  linkUrl = linkUrl.split("#").join("%23");
	  window.open(linkUrl);	
	
//	  $.ikGetJSON('https://developers.facebook.com/tools/debug/og/object', {
//		  q : image
//	  }, function(result) {
//		  
//		  var linkUrl = "http://www.facebook.com/sharer.php?s=100&p[url]=" + url 
//		  + "&p[images][0]=" + image
//		  + "&p[title]=" + encodeURIComponent(title) 
//		  + "&p[summary]=" + encodeURIComponent(summary);
//		  linkUrl = linkUrl.split("#").join("%23");
//		  window.open(linkUrl);	
//			  
//	  });
        
	  //window.showModalDialog(linkUrl, window);
	},
	ikShareTwitter : function(url, text){
		  var txt = encodeURIComponent(text);
		  var linkUrl = "https://twitter.com/share?url="+url+'&text='+txt;
		  window.open(linkUrl);
		  //window.showModalDialog(linkUrl, window);
	},
	ikTextEnter : function(txtId, btnId){
		$(txtId).keypress(function(e){
			if(e.keyCode==13) {
	        	$(btnId).trigger('click');
	        };
	        
		});
	},
	ikSortTabIndex : function(arr){
		for(i=0;i<arr.length;i++){
			
		}
	},
	ikSortTabIndex : function(){
		var tabindex = 1;
		
		$('input,select').each(function() {
			if (this.type != "hidden") {
				var $input = $(this);
				$input.attr("tabindex", tabindex);
				tabindex++;
			}
		});
	},
	
	ikSmartEditor : function(fn, skinUrl, elem){
		var oEditors = [];
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: elem,
			sSkinURI: skinUrl,
			fCreator: "createSEditor2",
			fOnAppLoad : fn
		});
		
		return oEditors;
	},
	ikUserAgent : function(){
		var b = navigator.userAgent.toLowerCase(),
	    c = window.opera,
	    a = {
		        ie: eval("/*@cc_on!@*/false"),
		        opera: !! c && c.version,
		        webkit: b.indexOf(" applewebkit/") > -1,
		        air: b.indexOf(" adobeair/") > -1,
		        mac: b.indexOf("macintosh") > -1,
		        quirks: document.compatMode == "BackCompat",
		        mobile: b.indexOf("mobile") > -1,
		        iOS: /(ipad|iphone|ipod)/.test(b),
		        isCustomDomain: function () {
		            if (!this.ie) return false;
		            var a = document.domain,
		                b = window.location.hostname;
		            return a != b && a != "[" + b + "]"
		        },
		        secure: location.protocol == "https:"
		    };
		a.gecko = navigator.product == "Gecko" && !a.webkit && !a.opera;
		if (a.webkit) b.indexOf("chrome") > -1 ? a.chrome = true : a.safari = true;
		var f = 0;
		if (a.ie) {
		    f = a.quirks || !document.documentMode ? parseFloat(b.match(/msie (\d+)/)[1]) : document.documentMode;
		    a.ie10Compat = f == 10;
		    a.ie9Compat = f == 9;
		    a.ie8Compat = f == 8;
		    a.ie7Compat = f == 7;
		    a.ie6Compat = f < 7 || a.quirks
		}
		if (a.gecko) {
		    var e = b.match(/rv:([\d\.]+)/);
		    if (e) {
		        e = e[1].split(".");
		        f = e[0] * 1E4 + (e[1] || 0) * 100 + (e[2] || 0) * 1
		    }
		}
		a.opera && (f = parseFloat(c.version()));
		a.air && (f = parseFloat(b.match(/ adobeair\/(\d+)/)[1]));
		a.webkit && (f = parseFloat(b.match(/ applewebkit\/(\d+)/)[1]));
		a.version = f;
		a.isCompatible = a.iOS && f >= 534 || !a.mobile && (a.ie && f > 6 || a.gecko && f >= 10801 || a.opera && f >= 9.5 || a.air && f >= 1 || a.webkit && f >= 522 || false);
		a.cssClass = "cke_browser_" + (a.ie ? "ie" : a.gecko ? "gecko" : a.opera ? "opera" : a.webkit ? "webkit" : "unknown");
		if (a.quirks) a.cssClass = a.cssClass + " cke_browser_quirks";
		if (a.ie) {
		    a.cssClass = a.cssClass + (" cke_browser_ie" + (a.quirks || a.version < 7 ? "6" : a.version));
		    if (a.quirks) a.cssClass = a.cssClass + " cke_browser_iequirks"
		}
		if (a.gecko && f < 10900) a.cssClass = a.cssClass + " cke_browser_gecko18";
		if (a.air) a.cssClass = a.cssClass + " cke_browser_air";
		return a;
	},
    
    ikIsDevice : function(){
    	
    	var device= $.getDeviceInfoStr();
    	
    	if(device==''){
    	    return false;
    	}else{
    		if( device=='LG' &&  jarvis.lib.getOSInfoStr()=="Windows NT"){
    		     return false;
    		}
    	    return true;
    	}
    },
    
    getDeviceInfoStr : function ()
	{    
		var mobileKeyWords = new Array('iPhone', 'iPad','iPod', 'BlackBerry', 'Android', 'Windows CE', 'LG', 'MOT', 'SAMSUNG', 'SonyEricsson');    
		var device_name = '';    
		for (var i=0;i<mobileKeyWords.length;++i){        
			if (navigator.userAgent.match(mobileKeyWords[i]) != null)
				{            
				    device_name = mobileKeyWords[i];            
					break;        
				}    
		}
		return device_name;
	},
	
	//데이타 리스트에서 이미지가 null인경우 디폴트 이미지를 넣어줌
	recieveImgCheck : function( _dataList, imgObjName, defaultImg, type ){
		if( _dataList == null ) return;
		var dataList = [];
		if( _dataList.length == null ){
			dataList[0] = _dataList;
		}else{
			dataList = _dataList;
		}
		
		for( var i = 0; i<dataList.length; i++ ){
			if( dataList[i][imgObjName] == null ){	//MUrl이 null이면 사용할 type에 대한이미지를 기본이미지로 넣어준다
				dataList[i][imgObjName] = {};
				dataList[i][imgObjName]["imgWeb" + type + "Url" ] = defaultImg;
			}
			//imgObj["imgWeb" + type + "Url" ] = $.recieveImgItemCheck( dataList[i][imgObjName], defaultImg, type );
		}
	},
	
	//뎁스가 있는 데이타 리스트에서 이미지가 null인경우 디폴트 이미지를 넣어줌
	recieveImgCheckDepth : function( dataList, imgObjName, defaultImg, type, depthName ){
		for( var i = 0; i<dataList.length; i++ ){
			if( dataList[i][depthName][imgObjName] == null ){	//MUrl이 null이면 사용할 type에 대한이미지를 기본이미지로 넣어준다
				dataList[i][depthName][imgObjName] = {};
				dataList[i][depthName][imgObjName]["imgWeb" + type + "Url" ] = defaultImg;
			}
			//imgObj["imgWeb" + type + "Url" ] = $.recieveImgItemCheck( dataList[i][imgObjName], defaultImg, type );
		}
	},
	
	recieveImgItemCheck : function(imgObj, defaultImg, type ){
		var imgUrl;
		if( imgObj == null ){
			imgUrl = defaultImg;
		}else{
			imgUrl = imgObj["imgWeb" + type + "Url" ];
		}
		
		return imgUrl;
	},
	
	//데이타 통으로 넘기기 위해 파라미터에 넣기
	addParentData : function( dataList, paramName ){
		for( var i = 0; i<dataList.length; i++ ){
			dataList[i][paramName] = dataList[i]; 
		}
	},
	
	ikReplaceShortStr : function(str, replaceSize){
		if(str == null && str == undefined){
			str = '';
		}
		else if(str.length > replaceSize){
	    	if($.ikCheckByte(str) > replaceSize){
	    		str = str.substring(0, str.bytesPos(replaceSize)) + '...';
	    	}
		}
    	return str;
    },
    
    ikFormat_Date : function (format, time){
  	  var dt = new Date(time);
  	  return result =  format.replace(/(yyyy|yy|mm|dd|hh|HH|mi|ss|am|pm)/gi,
  		        function($1){
  		            switch ($1){
  		                case 'yyyy': return dt.getFullYear();
  		                case 'yy':   return dt.getFullYear().toString().substr(2);
  		                case 'mm':   return dt.getMonth() + 1 < 10 ? '0' + (dt.getMonth() + 1) : dt.getMonth() + 1;
  		                case 'dd':   return dt.getDate() < 10 ? '0' + dt.getDate() : dt.getDate();
  		                case 'hh':   return (h = dt.getHours() % 12) ? h : 12;
  		                case 'HH': return dt.getHours();
  		                case 'mi':   return dt.getMinutes();
  		                case 'ss':   return dt.getSeconds();
  		                case 'am':   return dt.getHours() < 12 ? 'am' : 'pm';
  		                case 'pm':   return dt.getHours() < 12 ? 'am' : 'pm';
  		            }
  		        } 
  		    );
    },
    
    ikReplaceStr : function(str, replaceSize){
    	if(str == null && str == undefined){
			str = '';
		}
		else if(str.length > replaceSize){
	    	if(str.length > replaceSize){
	    		str = str.substring(0, replaceSize ) + '...';
	    	}
		}
    	return str;
    },
	
	ikGetTodayDate : function (){
		var _date = new Date();
		var _year = _date.getFullYear()
		var _month = "" + (_date.getMonth() + 1);
		var _day = "" + _date.getDate();
		if( _month.length == 1 ) _month = "0" + _month;
		if( ( _day.length ) == 1 ) _day = "0" + _day;
		var hour = _date.getHours();
		var minutes = _date.getMinutes();
		var seconds = _date.getSeconds();
		var tmp = "" + _year + _month + _day + hour + minutes + seconds;
		return tmp;
	},
	ikNumber_format : function(num){
		var num_str = num.toString();
        var result = "";
     
        for(var i=0; i<num_str.length; i++){
            var tmp = num_str.length - (i+1);
     
            if(((i%3)==0) && (i!=0))    result = ',' + result;
            result = num_str.charAt(tmp) + result;
        }
     
        return result;
	},
	//데이타 리스트에서 필요한 데이타 추가
	sumDataObj : function( dataList, objName, addParams ){
		if( dataList == null ) return;
		var paramName;
		for( var i = 0; i<dataList.length; i++ ){
			dataList[i][objName] = {};
			for( var j = 0; j<addParams.length; j++ ){
				paramName = addParams[j];
				dataList[i][objName][paramName] = dataList[i][paramName];
			}
		}
	},
	
	dataListAddParam : function( dataList, paramName, value ){
		for( var i = 0; i<dataList.length; i++ ){
			dataList[i][paramName] = value;
		}
	},
	
	ikDeleteBrEtc : function( str ){

		var newStr = str.replace(/<br>|<br\/>|<div>|<\/div>|<p>|<\/p>/g,"");
		
		return newStr;
	},
	
	ikfullscreenLoadingShow : function(){
		$("#fullscreenLoading").show();
		$('body').css( 'overflow', 'hidden' );
	},
	
	ikfullscreenLoadingHide : function(){
		$("#fullscreenLoading").hide();
		if( popupComponetNum == 0 ){
			$('body').css( 'overflow', 'auto' );
		}
	},
	
	
	ikReplyConvting : function( str ){
		if( str == null) return "";
		var regExp = /\@\{"([^\s][A-Za-z0-9.;_?!\-ㄱ-ㅎ|ㅏ-ㅣ|가-힣.]*)"\:"([\sA-Za-z0-9.;\(\)_?#\$\^@!\-ㄱ-ㅎ|ㅏ-ㅣ|가-힣.]*)"\}([\sA-Za-z0-9.;_?#\$\^@\-ㄱ-ㅎ|ㅏ-ㅣ|가-힣.]*)/igm
		//var regExp = /\@\{"([^\s][A-Za-z0-9.;_?!\-ㄱ-ㅎ|ㅏ-ㅣ|가-힣.]*)"\:"([^]*)"\}([^]*)/igm
		var newStr = str.replace(regExp, function($0, $1, $2, $3 ){
			
			var s = '<button contenteditable="false" class="tag_highlight" rel="external" memid="' + $1 + '" onclick="$.ikNaviMyPage(\''+$1+'\');" >' + $2 +'</button> ' + $3;
			//var s = "<button class='tag_highlight' contenteditable='false' memid='" + $1 + "' rel='external' onclick='$.ikNaviMyPage('"+$1+"');'>" + $2 + "</button>" + $3;
			//var s = $2 +'' + $3;
			return s;
		});
		
		return $.ikDeleteBrEtc(newStr);
	},
	
	ikReplyWriteConverting : function( writeStr ){
		var str = writeStr.replace(/\&nbsp?;/g,"");
		str = str.replace(/"/g,"'");
		str = str.replace(/'/g,"");
		str = str.replace(/type=submit/g,"");
		str = str.replace( /[\s]+/gi, " " );
		str = str.replace( /&nbsp;/gi, " " );
//		var regExp = /.?<button contenteditable="false" class="tag_highlight" rel="external" memid="([^\s][A-Za-z0-9.;_?!\-ㄱ-ㅎ|ㅏ-ㅣ|가-힣.]*)">([^\s][A-Za-z0-9.;_?!\-ㄱ-ㅎ|ㅏ-ㅣ|가-힣.]*)<\/button>([^\s][A-Za-z0-9.;_?!\-ㄱ-ㅎ|ㅏ-ㅣ|가-힣.]*)/igm;
		var regExp = /.?<button class=tag_highlight contenteditable=false memid=([^\s][A-Za-z0-9.;_?!\-ㄱ-ㅎ|ㅏ-ㅣ|가-힣.]*) rel=external>([\sA-Za-z0-9\(\).;_?#\$\^@!\-ㄱ-ㅎ|ㅏ-ㅣ|가-힣.]*)<\/button>([\sA-Za-z0-9.;_?#\$\^@\-ㄱ-ㅎ|ㅏ-ㅣ|가-힣.]*)/igm;
//		var regExp = /.?<button class=tag_highlight contenteditable=false memid=([^\s][A-Za-z0-9.;_?!\-ㄱ-ㅎ|ㅏ-ㅣ|가-힣.]*) rel=external>([^]*)<\/button>([^]*)/igm;
		
		var newStr = str.toLowerCase().replace(regExp, function($0, $1, $2, $3 ){
			var s = '@{"' + $1 + '":"' + $2 + '"}' + $3;
			return s;
		});
		
		return $.ikDeleteBrEtc(newStr);
	},
	
	ikInputLengthCheck : function( input, numTxt, length, func ){
		
		if( numTxt != null ) numTxt.text( length );
		input.attr( 'maxlength', length );
		
		input.keyup(function() {
	      var inputLength = $(this).val().length;
	      var remain = length-inputLength;
	      if(remain<0) {
	         this.blur();
	         $(this).val($(this).val().substr(0, length));
	         this.focus();
	         if( numTxt != null ) numTxt.text(0);
	      }
	      else {
	    	 if( numTxt != null ) numTxt.text(remain);
	      }
	      
	      if( func != null ) func();
	   });
		
		input.trigger('keyup');
	},
	
	ikUtubeThumnailParsing : function( utubeUrl ){
		var thumnailUrl = null;
		var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
	    var match = utubeUrl.match(regExp);
	    if (match&&match[7].length==11){
	    	var video_id = match[7];
	    	thumnailUrl = 'http://img.youtube.com/vi/' + video_id + '/default.jpg';
	    }
	    return thumnailUrl;
	},
	
	ikUtubeIframUrl : function( utubeUrl ){
		var thumnailUrl = null;
		var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
	    var match = utubeUrl.match(regExp);
	    if (match&&match[7].length==11){
	    	var video_id = match[7];
	    	thumnailUrl = '//www.youtube.com/embed/' + video_id;
	    }
	    return thumnailUrl;
	},
	
	
	
});


String.prototype.bytes = function()
{
    var str = this;
    var l = 0;
    for (var i=0; i<str.length; i++) l += (str.charCodeAt(i) > 115) ? 2 : 1;
    return l;
};

String.prototype.bytesPos = function(sz)
{
    var str = this;
    var l   = 0;
    var pos = 0;
    var flg = true;

    for (var i=0; i<str.length; i++)
    {
        flg= (str.charCodeAt(i) > 128) ? true : false;
        l += (str.charCodeAt(i) > 128) ? 2 : 1;
        if(l>sz + 1)
        {
            if(flg) pos--;
            break;
        }
        else pos++;
    }
    return pos;
};

String.prototype.linkify=function(){
	return this.replace(/[A-Za-z]+:\/\/[A-Za-z0-9-_]+\.[A-Za-z0-9-_:%&;\?\/.=]+/g,function(m){
		return m.link(m);
	});
};
String.prototype.linkuser=function(){
	return this.replace(/[@]+[A-Za-z0-9-_]+/g,function(u){
		return u.link("http://twitter.com/"+u.replace("@",""));
	});
};
String.prototype.linktag=function(){
	return this.replace(/[]+[A-Za-z0-9-_]+/,function(t){
		return t;
	});
};
String.prototype.trim = function() {
	return this.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
};

Array.prototype.remove = function(idx) {
    return (idx<0 || idx>this.length) ? this : this.slice(0, idx).concat(this.slice(idx+1, this.length));
};

Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};

String.prototype.allPriceComma = function() {
    var tmp = this.split('.');
    var minus = false;
    var str = new Array();

    if(tmp[0].indexOf('-') >= 0) {
        minus = true;
        tmp[0] = tmp[0].substring(1, tmp[0].length); 
    }
    
    var v = tmp[0].replace(/,/gi,'');
    for(var i=0; i<=v.length; i++) {
        str[str.length] = v.charAt(v.length-i);
        if(i%3==0 && i!=0 && i!=v.length) {
            str[str.length] = '.';
        }
    }
    
    str = str.reverse().join('').replace(/\./gi,',');
    if(minus) str = '-' + str;

    return (tmp.length==2) ? str + '.' + tmp[1] : str;
};

if (!Array.prototype.indexOf)
{
  Array.prototype.indexOf = function(elt /*, from*/)
  {
    var len = this.length >>> 0;

    var from = Number(arguments[1]) || 0;
    from = (from < 0)
         ? Math.ceil(from)
         : Math.floor(from);
    if (from < 0)
      from += len;

    for (; from < len; from++)
    {
      if (from in this &&
          this[from] === elt)
        return from;
    }
    return -1;
  };
}