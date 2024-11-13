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
<link rel="stylesheet" type="text/css" media="screen" href="http://devmkt.icignal.com/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" media="screen" href="http://devmkt.icignal.com/resources/bootstrap/css/font-awesome.min.css">
<script src='<%=CommonUtil.getInstance().getCDNServerUrl()%>/resources/ifv-Framework/1.4/ifvCommon/js/jquery-2.1.4.min.js' type="text/javascript"></script>
<script src='<%=CommonUtil.getInstance().getCDNServerUrl()%>/resources/ifv-Framework/1.4/ifvCommon/js/jquery.json-2.3.min.js' type="text/javascript"></script>
<script src='<%=CommonUtil.getInstance().getCDNServerUrl()%>/resources/ifv-Framework/1.4/ifvCommon/js/util.js' type="text/javascript"></script>
<script src='<%=CommonUtil.getInstance().getCDNServerUrl()%>/resources/ifv-Framework/1.4/ifvCommon/js/lib.js' type="text/javascript"></script>
<script>
var couponId = '';
//메세지 조회
function getMessageSendLog() {
    var campaignId = '<%= cleanXss(request.getParameter("campaignId")) %>';
    var memberId = '<%= cleanXss(request.getParameter("memberId")) %>';
    couponId = '<%= cleanXss(request.getParameter("couponId")) %>';
    if (memberId == 'null' || memberId == '') memberId = null;
    
    var url = 'http://devmkt.icignal.com/marketing/common/getMessageSendLog2.do?campaignId=' + campaignId + '&memberId=' + memberId;
    
    $.ajax({
        crossOrigin: true,
        url: url,
        success: function(result) {
            $("#showMessage").html(result.sendMessage);
        },
        error: function(xhr) {
          console.log('실패 - ', xhr);
        }
    });
}

//쿠폰 다운로드 화면
function couponDownloadView() {
    var url = "infavor://navigation?type=coupon&id=" + couponId;
    qtjs.href(url);
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
    $('#couponDownloadViewBtn').on('click', function(){
        couponDownloadView();
    });
    
    //웹뷰 닫기 버튼
    $('#showMessageCouponCloseBtn').on('click', function(){
        showMessageCouponClose();
    });
});
</script>

<style>
.phoneImage {width: 250px; min-height: 350px; margin-right: 20px; border: 1px solid #55a9d0; border-radius: 45px; padding: 28px 20px 50px; float: left;}
.sms_kinds{text-align: center; margin: 0 auto 15px; width: 50%; background: #fff; color:#999999; font-weight:bold;}
.sms_kinds .sms_mms {color: #3198c8; vertical-align: top;}
.phoneWrap {border: 1px solid #55a9d0;}
.phoneWrap #showMessage {height: 350px;}
</style>

</head> 
<body>
	<div class="well form-horizontal content_textImage_con">
		<div class="phoneImage">
			<div class="sms_kinds"><span>Show Message</span></div><!-- 단문SMS/ 장문SMS /이미지MMS /PUSH -->
			<div class="phoneWrap">
                <div class="sms_phone_area" id="showMessage"></div>
			</div>
            <div class="pop_btn_area" style="height:60px;">
            <button class="btn btn-sm btn_gray" id="couponDownloadViewBtn">
                <i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00804"/>
            </button> 
            <button class="btn btn-sm btn_lightGray2" id="showMessageCouponCloseBtn">         
                <spring:message code="M00441"/>
            </button>
            </div>
		</div>
    </div>
</body>
</html>
