var qtjs = {
	href : function(url, hc) {
		//location.href = url;
		if(url.indexOf('#') != -1) return;
		var murl = url.split('?');
		
		if(!hc)
			history.pushState(null,null, murl.join('?')); // URL을 변경할뿐 페이지이동을 하지 않는다.

		$.ifvmLnbSetting(murl[0].split('/').pop());
		
		murl[0] += '.mkt';
		this._setContent(murl.join('?'));
	}
	, _setContent : function(url) {
		$("#content").empty();

		$.ifvProgressControl(false);

		this._resizeEvent();
		
		var cf = {
            url: null,
            type: "GET",
            data: null,
            async: true,
            dataType: null,
            contentType: "application/x-www-form-urlencoded",
            success: null
        };
        $.ajaxSetup(cf);
		
		$.ifvCachedHtml(url).done(function(script, status) {
			$("#content").append(script);
			$(window).scrollTop(0);
		});
		
		
		//$("#content").load(url);
	}
	, reload : function() {
		this._setContent(location.href + '.mkt');
	}
	, _resizeEvent : function() {
		$(window).off('resize');
	}
};

window.addEventListener('popstate', function(e) {
	$.ifvProgressControl(false);
	qtjs.href(e.target.location.href, true);
});