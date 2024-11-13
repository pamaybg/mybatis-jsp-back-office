
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.icignal.common.util.CommonUtil" %>
<!DOCTYPE html>
<html lang="ko">
<head>

    <meta charset="utf-8">
    <!--  <meta charset="utf-8"> -->

    <title>DESCENTE KOREA CRM MOBILE</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <script data-pace-options='{ "restartOnRequestAfter": true }' src="${pageContext.request.contextPath}/resources/bootstrap/js/plugin/pace/pace.min.js"></script>

    <script type="text/javascript">var frameworkReadyUrl = '<%=CommonUtil.getInstance().getCDNServerUrl()%>/resources';</script>

    <jsp:include page="/WEB-INF/views/layouts/default/ifvFramework.jsp" />
    <jsp:include page="/WEB-INF/views/layouts/default/sessionScript.jsp" />

    <script src="${pageContext.request.contextPath}/resources/js/lib/util.js"></script>
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/mobile/style.css">
    <!-- jQuery Modal -->
    <script src="${pageContext.request.contextPath}/resources/js/lib/jquery.modal.min.js"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/mobile/jquery.modal.min.css">
    
</head>
<script>
    var pgmObject = [];

    <c:forEach items="${pgmChild}" var="info2">
    var json = new Object();
    json.pgmRid="${info2.pgmRid}";
    json.url="${info2.url}";
    json.labeNm="${info2.tabLabelNm}";
    pgmObject.push(json);
    </c:forEach>
    if(pgmObject.length>0) {
        var items = [];
    }
    for(var i=0;i<pgmObject.length;i++) {
        var arr = "/"+pgmObject[i].url.replace(".jsp","");
        var rowData = {
            label : pgmObject[i].labeNm,
            href : arr,
            tabid : arr,
        };
        items.push(rowData);
    }
    function fnLayoutAuth() {
        /* var nurl = '<tiles:getAsString name="content"/>';
	var uid = '<tiles:getAsString name="uid"/>';

	nurl = nurl.replace("/WEB-INF/views//", "");
	nurl = nurl.replace("/WEB-INF/views/", ""); */

        var authInfo = $.ifvmGetAuthInfo();

        $.each (authInfo.authObjList, function(index, obj) {
            //해당 페이지의 오브젝트의 표시 여부 설정
            if (nurl == obj.progPath) {
                //숨김
                if (obj.uiViewCd == "INVISIBLE") {
                    $("#" + uid + " [objCode=" + obj.objCd + "]").remove();
                }
                //비활성
                else if (obj.uiViewCd == "DISABLE") {
                    if(obj.objCd == "SRCH" || obj.objCd == "ADRESS" || obj.objCd == "SRCH_APP" || obj.objCd == "SRCH_DEVICE" || obj.objCd == "SRCH_COUPON" || obj.objCd == "SRCH_IMAGE" || obj.objCd == "SRCH_TEMPLATE" || obj.objCd == "SRCH_MAP" || obj.objCd == "SRCH_ASSIGN" || obj.objCd == "SRCH_STAMP" || obj.objCd == "SRCH_PATH" || obj.objCd == "SRCH_APPLY_STORE"){
                        if($("#" + uid + " [objCode=" + obj.objCd + "]>a") == undefined){
                            $("#" + uid + " [objCode=" + obj.objCd + "]").attr('disabled','disabled');
                        }
                        else{
                            $("#" + uid + " [objCode=" + obj.objCd + "]>a").attr('data-target','#');
                            $("#" + uid + " [objCode=" + obj.objCd + "]>a").removeAttr('href');
                            $("#" + uid + " [objCode=" + obj.objCd + "]").removeAttr('onCLick');

                            if(obj.objCd=="SRCH_IMAGE"){
                                $("#" + uid + " [objCode=" + obj.objCd + "]").removeAttr('type','#');
                            }
                        }
                    }
                    else{
                        $("#" + uid + " [objCode=" + obj.objCd + "]").attr('disabled','disabled');
                    }
                }
            }
        });
    }

    function fnLayoutAuthObject() {
        var authObject = [];
        <c:forEach items="${pgmObject}" var="info">
        var json = new Object();
        json.progRid="${info.progRid}";
        json.progPath="${info.progPath}";
        json.objCd="${info.objCd}";
        authObject.push(json);
        </c:forEach>

        for(var i=0; i<$('.btn').length; i++) {
            for(var j=0; j<authObject.length; j++) {
                if($($('.btn')[i]).attr('data-objauth') != "true") {
                    if($($('.btn')[i]).attr('objcode') == authObject[j].objCd) {
                        $($('.btn')[i]).attr('data-objauth', 'true')
                        break;
                    } else {
                        $($('.btn')[i]).attr('data-objauth', 'false')
                    }
                }
            }
        }



        for (var i=0; i<$('.tab-list li').length; i++) {
            for(var j=0; j<pgmObject.length; j++) {
                var arr = $($('.tab-list li')[i]).children('a').attr('href').split('/');
                var pageName = arr[arr.length-1]

                if(pgmObject[j].url.indexOf(pageName) > -1) {
                    $($('.tab-list li')[i]).show();
                }
            }
        }

        tabcheck();

        $('[data-objauth=false]').remove();
        $('[data-objauth=true]').show();
    }

    function tabcheck(){
        $(".tab-list").attr("visible","false");
        $(".tab-list li").each(function(){
            if($(this).is(":visible")){
                $(this).parent(".tab-list").attr("visible","true");
            }
        })


        $(".tab-list").each(function(){
            if($(this).attr("visible")=="false"){
                $(this).hide();
                $(this).parent().parent().siblings(".tab-contents").hide();
            }
        })
    }
    //컨텐츠페이지 화면 height변경시 호출
    function setParentIframeHeight() {

        if (window.top.document.getElementById('mainIframe') != null) {

            setTimeout(function(){

                var wrapper = document.getElementById('wrapper');
                var sideMenu = document.getElementById('sideMenu');
                // var leftMenu = document.getElementById('infavorMenu');
                var wrapperHeight = wrapper.scrollHeight;
                var sideMenuMinHeight = sideMenu.style.minHeight;
                sideMenu.style.minHeight = "auto";
                var sideMenuHeight = sideMenu.scrollHeight;
                var clientHeight = window.top.document.body.clientHeight;

                var setHeight = clientHeight;

                if (setHeight < sideMenuHeight) {
                    setHeight = sideMenuHeight;
                }

                if (setHeight < wrapperHeight) {
                    setHeight = wrapperHeight;
                }

                window.top.document.getElementById('mainIframe').height = setHeight + "px";
                sideMenu.style.minHeight = sideMenuMinHeight;
                window.top.document.getElementById('mainIframe').style.height = setHeight + "px";
            }, 200);
        }
    }
</script>

<body>
<!--[if IE 7]>
<h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
<![endif]-->
<div id="wrapper" class="mobile">
    <tiles:insertAttribute name="header" />
    <div id='<tiles:getAsString name="uid"/>'>
        <div id="main" role="main">
            <div id="content">
                <tiles:insertAttribute name="content" />
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/app.js"></script>
<script>
    $(document).ready(function(){
        fnLayoutAuth();
        fnLayoutAuthObject();
        setParentIframeHeight();
    });

    $(window).load(function(){
        setParentIframeHeight();
    });

    $(window).resize(function() {
        if (window.top.document.getElementById('mainIframe') != null) {
            window.top.document.getElementById('mainIframe').width = window.top.document.body.clientWidth > 1220 ? "100%" : '1220px';
        }
    });

    localStorage.clear();
</script>
<script src="${pageContext.request.contextPath}/resources/js/common/qtjs.js"></script>
</body>
</html>