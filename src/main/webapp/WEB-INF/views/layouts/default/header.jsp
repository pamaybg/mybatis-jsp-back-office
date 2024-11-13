<%@page import="com.icignal.common.util.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<header id="header">
	<div class="pull-right">
		<div class="btn-header pull-left userProfileNameArea">
			<span id="userProfileName" class="userProfileName"></span>
		</div>
	
		<%-- <div class="btn-header pull-left">
			<a href="javascript:void(0);" onclick='getHeadDetail()'>
				<img src="<ifvm:image name='header_mms'/>" alt="me" class="" id="profilebtn"/>
			</a>
		</div> --%>

		<div class="btn-header pull-left">
			<a onclick='getHeadDetail()' href="javascript:void(0);" id="show-shortcut">
				<img src="<ifvm:image name='header_pw'/>" alt="me" class="" id="changePwdBtn"/>
			</a>
		</div>

		<div class="btn-header pull-left">
			<a href="javascript:$.ifvmMarketingLogOut();" title="Sign Out" class="logout">
				<img src="<ifvm:image name='header_logout'/>" alt="me" class="" id=""/>
			</a>
		</div>
	</div>


<%-- 	<div class="pull-right">
		<div class="btn-header transparent pull-left" style="margin-right:10px;">
			<span>
				<a href="javascript:void(0);">
					<span class="">
						<img src="<ifvm:image name='header_logout'/>" alt="me" class="" id="changePwdBtn"/>
					</span>
				</a>
			</span>
		</div>

		<div class="btn-header pull-left">
			<span onclick='getHeadDetail()'>
				<a href="javascript:void(0);" id="show-shortcut">
					<span class="userImg">
						<img src="<ifvm:image name='header_profile'/>" alt="me" class="" id="profilebtn"/>
					</span>
				</a>
				<span id="userProfileName" class="userProfileName">
					Name
				</span>
			</span>
		</div>

		<div class="btn-header transparent pull-right">
			<span><a href="javascript:$.ifvmMarketingLogOut();" title="Sign Out" class="logout"></a></span>
		</div>
	</div> --%>
</header>

<!-- 비밀번호 변경 -->
<div id="modifyUserPwdPop"></div>
<!-- 치널전송 -->
<div id="transChnlPopCon"></div>
<!--  본인인증 -->
<div id="certiPopupCon"></div>
<!-- SNS 인증키 등록 팝업 -->
<div id="snsAuthKeyPop"></div>

<script>
var pwChangeExp = false;
pwChangeExp = <%= cleanXss(request.getParameter("pwChangeExp")) %>;
var ifvmUserInfo = $.ifvmGetUserInfo();

/* var ifvmStoreInfo = $.ifvmStoreInfo();
var ifvmDivisionInfo = $.ifvmDivisionInfo(); */

var checkClickBtn = 0;

function checkClickBtnFunc(){
	if (checkClickBtn == 0) {
		checkClickBtn = 1;
	    return true;
	}
	else {
	    return false;
	}
};

function sessionEndFunc(){
	setTimeout(function(){
		window.top.location.href = '<ifvm:url name="MKTLogin"/>';
	},2000 );
};

function permissionCheckRedirectFunc(){
	setTimeout(function(){
		window.top.location.href = '<ifvm:url name="MKTLogin"/>';
	},2000 );
};

function getHeadDetail(){
	if( ifvmUserInfo.id != null ){
		$('#aClick').trigger('click');
	}
}

function userInfoSetting(){
	$('#userProfileName').unbind("click");
	if( ifvmUserInfo.id != null ){
		if( ifvmUserInfo.id != null ){
			if( ifvmUserInfo.imageUrl != null && ifvmUserInfo.imageUrl != "" && typeof ifvmUserInfo.imageUrl != "undefined" ) {
				$('#profilebtn').attr('src', ifvmUserInfo.imageUrl  );
			}
		}
		// Entity 변환오류 수정. text함수를 html함수로 변환. #20150413 IH.
        if ( ifvmUserInfo.empName != null && typeof ifvmUserInfo.empName != "undefied") {
        	//var lastLogin = ifvmUserInfo.lastLoginDate.substr(0,4)+"."+ifvmUserInfo.lastLoginDate.substr(4,2)+"."+ifvmUserInfo.lastLoginDate.substr(6)
        	  $('#userProfileName').html(/* "마지막 접속일 : " + lastLogin + "\n" +  */$.ifvReplaceStr( ifvmUserInfo.empName, 15 ));
        }$

	}
}

function showModifyUserPwdPop(){
	$("#modifyUserPwdPop").ifvsfPopup({
	 	   enableModal : true,
		   enableResize: false,
		   contentUrl: '<ifvm:url name="modifyUserPwdPop"/>',
		   contentType: "ajax",
		   title: "<spring:message code='V00168'/>",
		   width: 450,
		   maxWidth  : '100%',
		   close : 'popupContainerClose'
	});
}

function popupContainerClose(){
	$.fn.ifvmPopupClose();
}

<%--function snsAuthKeyPopup() {
	$("#snsAuthKeyPop").ifvsfPopup({
	 	   enableModal : true,
		   enableResize: false,
		   contentUrl: '<ifvm:url name="snsAuthKeyPop"/>',
		   contentType: "ajax",
		   title: "<spring:message code='L02675'/>",
		   width: 370,
		   close : 'snsPopupClose'
	});
}--%>

$(document).ready(function(){
	userInfoSetting();
	$('#userProfileName').remove('click');
	$('#profilebtn').remove('click');

	//비밀번호 변경 - 로그인 시
	if(pwChangeExp){
		alert('<spring:message code="V00173"/>');
		showModifyUserPwdPop();

		setTimeout(function(){
			$("#modifyUserPwdPop_closebutton, #closeBtn").hide();
		},500);

		$(document).keyup(function(e) {
		     if (e.keyCode == 27) {
		    	 var urlLoof = location.href;
		    	 qtjs.href(urlLoof);
		    }
		});
	}

	//비밀번호 변경
	$("#changePwdBtn").click(function(){
		showModifyUserPwdPop();
	});
	
	
	<%--//SNS인증키 등록 팝업
	$("#profilebtn").click(function(){
		snsAuthKeyPopup();
	});--%>

    <%--$("#eastarDemoBtn").click(function(){--%>
        <%--var url = '<ifvm:url name="eastarDemoPop"/>';--%>
        <%--window.open(url, 'eastarDemoPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=398,height=740')--%>
    <%--});--%>

	$("#channelBtn").click(function(){
/*  		$("#transChnlPopCon").ifvsfPopup({
 		 	   enableModal : true,
 			   enableResize: false,
 			   contentUrl: '<ifvm:url name="transChnlPop"/>',
 			   contentType: "ajax",
 			   title: "<spring:message code='L01791'/>",
 			   width: "1000px",
 			   maxHeight: "1024px"
 		}); */


 		var url = '<ifvm:url name="transChnlPop"/>';
 		if(typeof(gMbrDetail) != 'undefined'){
 			url += '?ridMbr='+gMbrDetail.data.rid
 		}

 		window.open(url, 'transChnlPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=830,height=740')
	});

	$("a[href='avascript:$.ifvmMarketingLogOut();']").click(function(){
		if(window.parent.document.getElementById("TSPhone")){
			TSPhone.AgentLogOut();
       	}
	});
});
</script>