<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/resources/1.4/ifvCommon/js/jquery-2.1.4.min.js" type="text/javascript"></script>
<title>Insert title here</title>
<script>

var contsId = '<%= cleanXss(request.getParameter("id")) %>';

$.extend({
    ifvSyncPostJSON : function(url, jsonData, callback, errorCallback, btn, progressClass, fallback) {
        var progress;
        if (btn != null) {
            // 이미 서비스 요청중일때( progress가 돌고있을때 )리턴
            var index = $.ifvRequestBtnSearch(btn);
            if (index > -1) return;
            progress = $.ifvLoading(btn, progressClass);
        }
        /* 2015.05.10 CIH. update - data 값에 설정정보 추가. */
        var jsonData = jsonData ? jsonData : {};
        $.extend(jsonData, {
            appServiceId : window.appServiceId,
            country : window.country,
            lang : window.lang
        });
        var config = {
            url : url,
            async : false,
            type : "POST",
            data : JSON.stringify(jsonData),
            dataType : "json",
            contentType : "application/json; charset=utf-8",
            success : function(result) {
                if ($.errorChecker(result, errorCallback) == false) { return; }
                callback(result);
            },
            complete : function(xhr, status) {
                if (progress != null) $(progress).remove();
            },
            error : fallback
        };
        $.ajaxSetup(config);
        $.ajax();
        config = {
            url : null,
            type : "GET",
            data : null,
            async : true,
            dataType : null,
            contentType : "application/x-www-form-urlencoded",
            success : null
        };
        $.ajaxSetup(config);
    },
    errorChecker : function(data, errorCallback) {
        if (data == null) return true;
        var boolean = true;
        if (data.success == false || (data.errorType != null && data.errorType != 0)) {
            boolean = false;
            var str = '';
            switch (data.errorType) {
            case 100400:
                str = ifv.errorMessage.e_100400;
                break;
            case 100500:
                str = ifv.errorMessage.e_100500;
                break;
            case 100410:
                str = ifv.errorMessage.e_100410;
                break;
            case 200300:
                str = ifv.errorMessage.e_200300;
                break;
            case 200310:
                str = ifv.errorMessage.e_200310;
                break;
            case 200400:
                str = ifv.errorMessage.e_200400;
                break;
            case 200410:
                str = ifv.errorMessage.e_200410;
                if (typeof sessionEndFunc != "undefined" && sessionEndFunc != null) {
                    sessionEndFunc();
                }
                break;
            case 200420:
                str = ifv.errorMessage.e_200420;
                break;
            case 200430:
                str = ifv.errorMessage.e_200430;
                break;
            case 200440:
                str = ifv.errorMessage.e_200440;
                break;
            case 200450:
                str = ifv.errorMessage.e_200450;
                break;
            case 200460:
                str = ifv.errorMessage.e_200460;
                if (typeof permissionCheckRedirectFunc != "undefined" && permissionCheckRedirectFunc != null) {
                    permissionCheckRedirectFunc();
                }
                break;
            case 200500:
                if (errorCallback == null) {
                    $.messageCheckr(data.message);
                }
                break;

            }// switch
            if (errorCallback != null) {
                errorCallback(data);
                return boolean;
            }
            else if (boolean == false && str != '') {
                $.ifvErrorPop(str);
            }
        }// if
        return boolean;
    },
});

$(document).ready(function() {
    $.ifvSyncPostJSON('<ifvm:action name="getEmailDtlList"/>', {
        id : contsId
    },
    function(result) {
        $('#htmlContent').html(result.html);
    });
});

</script>

</head>
<body>

<div id="htmlContent"></div>

</body>
</html>