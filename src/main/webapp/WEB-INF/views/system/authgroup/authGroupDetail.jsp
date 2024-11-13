<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<%-- <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/beacon/store/storeManage.css" /> --%>

<script>
var groupId = '<%= cleanXss(request.getParameter("groupId")) %>';
if( groupId == 'null' ) groupId = null;
//var storeId = ifvmStoreInfo.storeId;
var tabType = null;
var validation = null;

var authDetailTab ;  //권한상세관련탭

/**
 * 탭 설정
 */
function initTab() {

    /* 탭 */
    authDetailTab = $('#authDetailTabDiv').DrawTab({
        item: items
        /* [
            {label: '<spring:message code="I02073"/>', href: '/system/authgroup/include/editUserListTabNew'},	
            {label: '<spring:message code="I02075"/>', href: '/system/authgroup/include/editAuthListTabNew'},	
        ] */
    });
}

function groupDetailInfo() {
	if (groupId != null && groupId != 'null' ) {
		$.ifvSyncPostJSON('<ifvm:action name="getAuthGroupDetailNew"/>', {
			groupId : groupId
		},
		function(result) {
			$("#groupName").val(result.groupName);
			$("#groupType").val(result.groupType).attr("selected", "selected");
			$("#groupDesc").val(result.groupDesc);
			$("#groupCreater").val(result.groupCreater);
			$("#groupCreateDate").val(result.groupCreateDate.substring(0,19));

		});
	}
}

function getCommonCode() {

	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'AUTH_GROUP_ACTIVATION_TYPE'
	}, function(result) {
		var temp = $("#categoryCodeListTemplate").tmpl(result.rows);
		$("#groupType").append(temp);
	});
}

function saveData(){

	if( validation.confirm() == true ){

	    var jsonData = {
			groupId : groupId,
			groupName : $("#groupName").val(),
			groupType : $("#groupType").val(),
			groupDesc : $("#groupDesc").val(),
			//accountId : storeId
		}
		if( groupId == null ){ //신규
			url = '<ifvm:action name="insertGroupDetail"/>';
			if(confirm('<spring:message code="I01881"/>') === false) return;
		}else{					//수정
			url = '<ifvm:action name="updateGroupDetail"/>';
			if(confirm('<spring:message code="I01882"/>') === false) return;
		}

		$.ifvSyncPostJSON( url, jsonData, function(result) {
			if(result.success == true){
				alert('<spring:message code="I00741"/>');
				groupId = result.groupId;
				//location.href = '<ifvm:url name="authGroupDetail"/>' + '?groupId=' + groupId;
				qtjs.href('<ifvm:url name="authGroupDetail"/>' + '?groupId=' + groupId);
			}
			else{
				alert('<spring:message code="I00742"/>');
			}
		}, null, null, "#btnSave" );
	}
}

//목록 돌아가기
function goList() {
	//location.href = '<ifvm:url name="authGroup"/>';
	qtjs.href('<ifvm:url name="authGroupNew"/>');
}

$(document).ready(function() {

	$.ifvmLnbSetting('authGroupNew');

	if (groupId != null) {
		$("#titleName").html('<spring:message code="I00195"/>');
	}

	// 공통코드 설정
	getCommonCode();

	// 상세 정보 조회
	groupDetailInfo();

	// 탭 초기화
	initTab();

	$.ifvmAdminCheck(true, true, true);
	validation = $("#formArea").ifvValidation();
});

</script>

<script id="categoryCodeListTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
	#navTab a{font-size:14px; font-weight:bold;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="I02084"/>
		&gt; <span id="titleName"><spring:message code="I00247" /></span>
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-sm-7">
			<span><spring:message code="I02076"/></span>
		</div>
		<div class="col-sm-5 searchbtn_r">
			<ifvm:inputNew id="btnSave" type="button" className="authUpdateBtn" btnFunc="saveData" text="I00745" btnType="save" objCode="authGroupNewSave_OBJ"/>
			<ifvm:inputNew type="button" id="goAuthGroupNew" btnFunc="goList" text="L00824" objCode="goAuthGroupNew_OBJ" /> <!-- 목록 -->
		</div>
	</div>
	
	<div class="well" id="formArea">
		<div class="row  qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="groupName" maxLength="100" required="true" label="I02071" labelClass="1" conClass="4"/>
				<ifvm:inputNew type="select" id="groupType" dto="groupType" names="groupType" required="true" label="I02072" labelClass="2" conClass="4"/>
			</div>
		</div>
	
		<div class="row  qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="groupDesc" maxLength="1500" label="I00075" labelClass="1" conClass="10"/>
			</div>
		</div>
		<div class="row  qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="groupCreater" disabled="true" label="I02055" labelClass="1" conClass="4"/>
				<ifvm:inputNew type="text" id="groupCreateDate" disabled="true" label="I02056" labelClass="2" conClass="4"/>
			</div>
		</div>
	</div>
</div>
<div id="authDetailTabDiv"></div>

<div id="empAddListModal"></div>
<div id="authAddListModal"></div>