<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var validation;

getManageEncDetail = {
	init : function(){
		//암호화키 상세 조회
		$.ifvSyncPostJSON('<ifvm:action name="getManageEncDetail"/>', {

		}, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
				$("#manageEncDetailForm").dataSetting(result);
			}
		}, function(result) {
			alert(result.message);
		});
	}
}

/**
 * 리소스 팝업 호출
 */
function accessInfoPopOpen(rscType) {
	var title;

	if (rscType == "Meta"){
		title = "<spring:message code='Q00010'/>";
	} else {
		title = "<spring:message code='Q00011'/>";
	}

    $("#accessInfoPop").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="accessInfoPop"/>' + "?rscType=" + rscType,
        contentType: "ajax",
        title: title,
        width: '600',
        close : 'accessInfoPopClose'
    });
}

function popupClose() {
	accessInfoPop._destroy();
}

function metaAccessInfoPopBtn() {
	accessInfoPopOpen("Meta");
}

function logAccessInfoPopBtn() {
	accessInfoPopOpen("LOG");
}

//화면 조회 팝업 리스트 선택 결과
function accessInfoListModalSelected(obj){
	if (obj.rscType == "Meta"){
		$('#metaRscNm').val(obj.rscNm);
		$('#metaDBType').val(obj.dbType);
		$('#metaHostName').val(obj.hostAddr);
		$('#metaPort').val(obj.port);
		$('#metaDB').val(obj.dbSchema);
		$('#metaUserName').val(obj.userName);
		$('#metaPWD').val(obj.userPassWd);
		$('#metaOptions').val(obj.dbOption);
	} else {
		$('#logRscNm').val(obj.rscNm);
		$('#logDBType').val(obj.dbType);
		$('#logHostName').val(obj.hostAddr);
		$('#logPort').val(obj.port);
		$('#logDB').val(obj.dbSchema);
		$('#logUserName').val(obj.userName);
		$('#logPWD').val(obj.userPassWd);
		$('#logOptions').val(obj.dbOption);
	}
}

function qimEncode(){

	validation = $("#manageEncDetailForm").ifvValidation();

	//유효성 체크
	if(validation.confirm()){
		var metaInfo = new Object();
		metaInfo.DBType = $('#metaRscNm').val();
		metaInfo.HostName = $('#metaHostName').val();
		metaInfo.Port = $('#metaPort').val();
		metaInfo.DB = $('#metaDB').val();
		metaInfo.UserName = $('#metaUserName').val();
		metaInfo.PWD = $('#metaPWD').val();
		metaInfo.Options = $('#metaOptions').val();

		var logInfo = new Object();
		logInfo.DBType = $('#logRscNm').val();
		logInfo.HostName = $('#logHostName').val();
		logInfo.Port = $('#logPort').val();
		logInfo.DB = $('#logDB').val();
		logInfo.UserName = $('#logUserName').val();
		logInfo.PWD = $('#logPWD').val();
		logInfo.Options = $('#logOptions').val();

		var strArray = new Array();
		strArray.push(metaInfo);
		strArray.push('|');
		strArray.push(logInfo);

		//암호화키 상세 조회
	    $.ifvSyncPostJSON('<ifvm:action name="getQimEncode"/>', {
			str : JSON.stringify(strArray)
			, key : $('#qimKey').val()
	    }, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
				$('#qimRet').val(result.retValue);
			}
	    });
	}
}

$(document).ready(function(){
	/* 생성버튼 */
	$('#qimEncode').on('click', function(){
		qimEncode();
	});
});
</script>

<div class="page-title">
	<h1>
		<spring:message code="Q02835" /> <!-- 암화화키 -->
	</h1>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-2">
		<span><spring:message code="Q02835" /></span> <!-- 암호화키 -->
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" id="qimEncode" text="I02067" /> <!-- 생성 -->
	</div>
</div>
<div class="form-horizontal underline top_well" id="manageEncDetailForm">
	<div class="form-horizontal top_well underline">
		<div class="row">
			<ifvm:input type="hidden" id="metaDBType" 	names="metaDBType" />
			<ifvm:input type="hidden" id="metaHostName" names="metaHostName" />
			<ifvm:input type="hidden" id="metaPort" 	names="metaPort" />
			<ifvm:input type="hidden" id="metaDB" 		names="metaDB" />
			<ifvm:input type="hidden" id="metaUserName" names="metaUserName" />
			<ifvm:input type="hidden" id="metaPWD" 		names="metaPWD" />
			<ifvm:input type="hidden" id="metaOptions" 	names="metaOptions" />
			<ifvm:inputNew type="search" id="metaRscNm" btnFunc="metaAccessInfoPopBtn" label="Q02836" labelClass="1" conClass="4" required="true" /> <!-- 메타리소스 명 -->
		</div>
		<div class="row">
			<ifvm:input type="hidden" id="logDBType" 	names="logDBType" />
			<ifvm:input type="hidden" id="logHostName" 	names="logHostName" />
			<ifvm:input type="hidden" id="logPort" 		names="logPort" />
			<ifvm:input type="hidden" id="logDB" 		names="logDB" />
			<ifvm:input type="hidden" id="logUserName" 	names="logUserName" />
			<ifvm:input type="hidden" id="logPWD" 		names="logPWD" />
			<ifvm:input type="hidden" id="logOptions" 	names="logOptions" />
			<ifvm:inputNew type="search" id="logRscNm" btnFunc="logAccessInfoPopBtn" label="Q02837" labelClass="1" conClass="4" required="true" /> <!-- 로그리소스 명 -->
		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="qimKey" label="Q02835" labelClass="1" conClass="4" required="true" valiItem="alphanumeric" /> <!-- 암호화키 -->
		</div>
		<div class="row">
			<ifvm:inputNew type="textarea" id="qimRet" label="Q02838" labelClass="1" conClass="4" rows="12"/> <!-- 암호화 연결 스트링 -->
		</div>

	</div>
</div>

<div id="accessInfoPop" class="popup_container"></div>