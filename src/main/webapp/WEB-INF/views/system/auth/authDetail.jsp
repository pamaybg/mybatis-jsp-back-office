<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<link href="${pageContext.request.contextPath}/resources/js/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />

<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>
<script>

var validation = '<%= cleanXss(request.getParameter("validation")) %>';
var curr_date = getTimeStamp();
var authId = '<%= cleanXss(request.getParameter("authId")) %>';
if( authId == 'null' ) authId = null;


var authTab ;  //탭

/**
 * 탭 설정
 */
function initTab() {

    /* 탭 */
    authTab = $('#authTabDiv').DrawTab({
        item:  items
        /* [
            {label: '<spring:message code="I02094"/>', href: '<ifvm:url name="viewAuth"/>'},
            {label: '<spring:message code="I02110"/>', href: '<ifvm:url name="programViewAuth"/>'},
            {label: '<spring:message code="I02095"/>', href: '<ifvm:url name="objectAuthNew"/>'},
        ] */
    });
}

/**
 * 탭 선택시 화면 이동 (DrawTab 추가로 사용하지 않음)
 */
function tabClick(type, tab) {
	var url = '';
	switch (type) {
	case 'view' :
		url = '<ifvm:url name="viewAuth"/>';
		break;
	case 'data' :
		url = '<ifvm:url name="dataAuth"/>';
		break;
	case 'object' :
		url = '<ifvm:url name="objectAuth"/>';
		break;
	default :
		break;
	};
	var _this = this;
	var fileName = url.split('/').pop();
	$.ifvCachedHtml( url ).done( function(script, textStatus){
		//  필요시 작업 후 주석처리 요망.
		if( tab != null ){
			$("#authTabNav").find('a').removeClass('active');
			$(tab).addClass('active');
		}
		$("#tabContent").empty();
		$("#tabContent").html('');
		$("#tabContent").append( script );
		if( window[fileName + '_init'] != null ) window[fileName + '_init']();
	});
}

function getTimeStamp() {
	  var d = new Date();
	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2) + ' ' +

	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
}

function leadingZeros(n, digits) {
	  var zero = '';
	  n = n.toString();

	  if (n.length < digits) {
	    for (i = 0; i < digits - n.length; i++)
	      zero += '0';
	  }
	  return zero + n;
}


function authDetail(){

		$.ifvSyncPostJSON('<ifvm:action name="authDetail"/>',{
			authId : authId
		},
		function(result) {
			$('#authNo').val(result.authNo);
			$('#authName').val(result.authName);
			$('#authDesc').val(result.authDesc);
			$('#authCreater').val(result.authCreater);
			$('#authCreateDate').val(result.authCreateDate.substring(0,19));
			$('#authDataType').val(result.authDataType).attr("selected", "selected");
			$('#pgmObjType').val(result.pgmObjType).attr("selected", "selected");
		});
};

function btnSave(){
	$("#btnSave").click(function(){
		if(validation.confirm() == true){

			 var jsonData = {
						authName : $("#authName").val(),
						authDesc : $("#authDesc").val(),
						dataType : $("#authDataType").val(),
						pgmObjType : $("#pgmObjType").val()
					}

			 if( authId == null ){ //신규
					url = '<ifvm:action name="insertAuthDetail"/>';
					if(confirm('<spring:message code="I01881"/>') === false) return;
				}else{					//수정
					url = '<ifvm:action name="updateAuthDetail"/>';
					jsonData.authId = authId;
					if(confirm('<spring:message code="I01882"/>') === false) return;
				}
			 $.ifvSyncPostJSON( url, jsonData, function(result) {
					if(result.success == true){
						alert('<spring:message code="I00741"/>');
						if(result.message != null) authId = result.message;
						$("#authCreater").val(ifvmUserInfo.empName);
						$("#authCreateDate").val(getTimeStamp());
						if(authId != null) qtjs.href('<ifvm:url name="authDetail"/>'+'?authId='+authId);
					}
					else{
						alert('<spring:message code="I00742"/>');
						if(authId != null) qtjs.href('<ifvm:url name="authDetail"/>'+'?authId='+authId);
					}
				}/* , null, null, "#btnSave"  */);
			 }

	});
}
//목록 돌아가기
function goList() {
	qtjs.href('<ifvm:url name="authList"/>');
}



$(document).ready(function() {

	$.ifvmLnbSetting('authListNew');

	$.fn.ifvmSetSelectOptionCommCode("authDataType", "DATA_TYPE_CD", null, null, false);
	$.fn.ifvmSetSelectOptionCommCode("pgmObjType", "PGM_OBJ_TYPE_CD", null, null, true);
	if(authId != null){
		authDetail();
	}

	if( authId != null ){
		$("#titleDetailName").html('<spring:message code="I00195"/>');
	}


	validation = $("#formArea").ifvValidation();

	$("#viewTab").trigger('click');

	initTab();
	btnSave();

	$.ifvmAdminCheck(true,true,true);
});


</script>

<div class="page-title">
	<h1>
		<spring:message code="I02061" />
		 &gt; <span id="titleDetailName"><spring:message code="I00080" /></span>
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="I02063" /></span>
		</div>
		 <div class="col-sm-5 searchbtn_r">
			<ifvm:inputNew type="button" id="btnSave" className="authUpdateBtn" text="I02029" btnType="save" objCode="authDetilSave_OBJ"/>
			<ifvm:inputNew type="button" id="goAuthListNew" btnFunc="goList" text="L00824" objCode="goAuthListNew_OBJ"/>
		</div>
	</div>

	<div class="well" id="formArea">
		<div class="row qt_border">
				<div class="form-horizontal">
					<ifvm:inputNew type="text" id="authNo" disabled="true"  label="I02059" labelClass="1" conClass="4" />
					<ifvm:inputNew type="text" id="authName" required="true"  label="I02060" labelClass="2" conClass="4" />
				</div>
		</div>
		<div class="row qt_border">
				<div class="form-horizontal">
					<ifvm:inputNew type="text" id="authDesc" label="I00075" labelClass="1" conClass="4" />
					<ifvm:inputNew type="select" id="authDataType" names="authDataType" required="true" label="I02093" labelClass="2" conClass="4"/>
				</div>
		</div>
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="authCreater" disabled="true" label="I02055" labelClass="1" conClass="4" />
				<ifvm:inputNew type="text" id="authCreateDate" disabled="true" label="I02056" labelClass="2" conClass="4" />
			</div>
		</div>
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="select" id="pgmObjType" names="pgmObjType" label="L02671" labelClass="7" conClass="4"/>
			</div>
		</div>
	</div>
</div>
<div id="authTabDiv" ></div>
