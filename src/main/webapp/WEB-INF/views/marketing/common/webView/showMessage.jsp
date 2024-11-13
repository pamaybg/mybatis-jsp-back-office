<%@page import="com.icignal.common.util.CommonUtil"%>
<%@page trimDirectiveWhitespaces="true" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
<meta charset="utf-8">
<title>Show Message</title>

<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
<meta name="format-detection" content="telephone=no">

<script src='<%=CommonUtil.getInstance().getCDNServerUrl()%>/resources/ifv-Framework/1.4/ifvCommon/js/jquery-2.1.4.min.js' type="text/javascript"></script>
<script src='<%=CommonUtil.getInstance().getCDNServerUrl()%>/resources/ifv-Framework/1.4/ifvCommon/js/jquery.json-2.3.min.js' type="text/javascript"></script>
<script src='<%=CommonUtil.getInstance().getCDNServerUrl()%>/resources/ifv-Framework/1.4/ifvCommon/js/util.js' type="text/javascript"></script>
<script src='<%=CommonUtil.getInstance().getCDNServerUrl()%>/resources/ifv-Framework/1.4/ifvCommon/js/lib.js' type="text/javascript"></script>
<script>
var appUrlKey = '';
var appUrlType = '';
//메세지 조회
function getMessageSendLog() {
    var campaignId = '<%= cleanXss(request.getParameter("campaignId")) %>';	//캠페인아이디
    var memberId = '<%= cleanXss(request.getParameter("memberId")) %>';		//회원아이디
    
    var url = '<%=request.getContextPath()%>/marketing/common/getMessageSendLog2.do?campaignId=' + campaignId
    if (memberId != 'null' && memberId != '' && memberId != null) {
        url += '&memberId=' + memberId;
    }
    
    $.ajax({
        crossOrigin: true,
        url: url,
        success: function(result) {
            $("#showMessage").html(result.sendMessage);
            $("#showTitle").html(result.sendSubject);
            appUrlType = result.pushSubTypeCd;
            appUrlKey = result.pushSubTypeVal;
        },
        error: function(xhr) {
          console.log('실패 - ', xhr);
        }
    });
}

//쿠폰 다운로드 화면
function showMessageOk() {
    //NOTICE	단순 알림
    //COUPON	App. 쿠폰 도착 알림
    //STORE		스토어 알림
    //PRODUCT	상품(메뉴) 알림
    //FAVOR		채널 알림
    //POST		소식 알림
    //MEMBER	my 알림
    var url = "infavor://";
    switch (appUrlType) {
    	case "NOTICE" 	: url = "infavor://"; break;
    	case "COUPON" 	: url = "infavor://navigation?type=COUPON&id=" + appUrlKey; break;
    	case "STORE" 	: url = "infavor://navigation?type=STORE&id=" + appUrlKey; break;
    	case "PRODUCT" 	: url = "infavor://navigation?type=PRODUCT&id=" + appUrlKey; break;
    	case "FAVOR" 	: url = "infavor://navigation?type=FAVOR&id=" + appUrlKey; break;
    	case "POST" 	: url = "infavor://navigation?type=POST&id=" + appUrlKey; break;
    	case "MEMBER" 	: url = "infavor://navigation?type=MEMBERSHIP&id=" + appUrlKey; break;
    	default : "infavor://";
    }
    
    qtjs.href(url);
    setTimeout(function(){
        qtjs.href("infavor://closeWebView");
	}, 100);
}

//웹뷰 화면 닫기
function showMessageCouponClose() {
    var url = "infavor://closeWebView";
    qtjs.href(url);
}

$(document).ready(function() {
    //메세지 조회
    getMessageSendLog();
    
    //쿠폰 다운로드 화면 버튼
    $('#showMessageOkBtn').on('click', function(){
        showMessageOk();
    });
    
    //웹뷰 닫기 버튼
    $('#showMessageCancleBtn').on('click', function(){
        showMessageCouponClose();
    });
});
</script>

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

*{-webkit-text-size-adjust:none;}
html,body, a, div, ul,li, p{padding:0;margin:0;font-family:'Noto Sans KR',HelveticaNeue-Light,AppleSDGothicNeo-Light,sans-serif;}
html,body {width:100%;height:100%;}
a,a:hover,a:focus,a:active,a:visited{text-decoration:none;}

body{background:#c0c0c0;}
.wrap{position:relative;width:100%;height:100%;top:0;left:0;right:0;bottom:70px;padding:0;margin:0;text-align:center;}
.wrap:before{content:'';margin:0;padding:0;position:absolute;top:0;left:0;width:100%;height:120px;background:#696969;}

.contents{display:inline-block;position:relative;width:90%;min-height:90%;margin:40px 3% 0;background:#ffffff;text-align:left;}
.txt_title{padding:0 26px;font-size:29px;font-weight:400;color:#222222;line-height:1.2;}
.txt_detail{padding:0 26px;font-size:15px;color:#333333;line-height:1.6;margin-bottom:70px; white-space:pre-line;}
.txt_detail img {max-width:100%;}
.detail{border-top:3px solid #ffb007;}

.btn_box{position:fixed;z-index:999;bottom:0;left:0;width:100%;padding:10px 0;background:#ffffff;border-top:1px solid #d7d7d7;box-shadow:0px 0px 10px rgba(0,0,0,0.2);text-align:center;}

.btn_group {max-width:350px;margin:0 auto;}
.btn{display:inline-block;width:42%;height:40px;line-height:40px;text-align:center;border-radius:5px;margin-right:10px;font-weight:400;font-size:15px;}
.btn_cancle{border:1px solid #a0a0a0;color:#777777;}
.btn_cancle:hover,.btn_cancle:active,.btn_cancle:focus{background:#f3f3f3;}
.btn_ok{background:#333333;border:1px solid #333333;color:#ffffff;}
.btn_ok:hover,.btn_ok:active,.btn_ok:focus{background:#777777;border-color:#777777;}
.btn_group > a:last-child{margin-right:0;}

@media screen and (max-width:340px) {
	.txt_title,.txt_detail{padding:0 15px}
}
</style>

</head>
<body>
	<div class="wrap">
		<div class="contents">
			<div class="detail">
			<!--  Title  -->
				<h3 class="txt_title" id="showTitle"></h3>	
			<!--  Contents  -->				
				<div class="txt_detail" id="showMessage">		
				</div>
			</div>
		</div>
		<div class="btn_box">
			<div class="btn_group">
				<a href="#" title="cancle" class="btn btn_cancle" id="showMessageCancleBtn">취소</a>		
				<a href="#" title="ok" class="btn btn_ok" id="showMessageOkBtn">이동</a>
			</div>
		</div>
	</div>
</body>
</html>