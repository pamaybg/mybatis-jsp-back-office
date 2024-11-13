<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var isNew = true;

getAccessInfoDetail = {
	init : function(){
		var rid = $.ifvGetParam('rid');
		if(typeof rid === 'undefined') isNew = true;
		else isNew = false;

		$.fn.ifvmSetSelectOptionCommCode("rscType", "QIM_RSC_TYPE", null, null, true);
		$.fn.ifvmSetSelectOptionCommCode("dbType", "QIM_DB_TYPE", null, null, true);

		if(!isNew){
			//리소스 상세 조회
			$.ifvSyncPostJSON('<ifvm:action name="getAccessInfoDetail"/>', {
				rid : rid
			}, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					$("#accessInfoDetailForm").dataSetting(result);

					if(result.useYn == "1"){
						$("#useYn").attr("checked",true);
					}

					if($("#rscType").val() == "DB"){
						$("#dbmsArea").dataSetting(result);
						$("#dbmsLoginId").val(result.dbLoginId);
						$("#dbmsLoginPw").val(result.dbLoginPw);
					}else if($("#rscType").val() == "FTP"){
						$("#ftpArea").dataSetting(result);
						//$("#ftpLocalDir").val(result.ftpLocalDir);
						//$("#ftpConnDir").val(result.ftpConnDir);
						$("#ftpLoginId").val(result.dbLoginId);
						$("#ftpLoginPw").val(result.dbLoginPw);
					}else if($("#rscType").val() == "META"){
						$("#dbmsArea").dataSetting(result);
						$("#dbmsLoginId").val(result.dbLoginId);
						$("#dbmsLoginPw").val(result.dbLoginPw);
					}else if($("#rscType").val() == "LOG"){
						$("#dbmsArea").dataSetting(result);
						$("#dbmsLoginId").val(result.dbLoginId);
						$("#dbmsLoginPw").val(result.dbLoginPw);
					}

					showInfo();
				}
			}, function(result) {
				alert(result.message);
			});
		} else {
			$("#dbmsArea").show();
			$("#ftpArea").hide();
		}
	},
	save : function(){
		if(getAccessInfoDetail.numberCheck()){

			var validation = $("#defaultArea").ifvValidation();

			//유효성 체크
			if(validation.confirm()){

				if($("#rscType").val() == "DB"){
					validation = $("#dbmsArea").ifvValidation();
				}else if($("#rscType").val() == "FTP"){
					validation = $("#ftpArea").ifvValidation();
				}else if($("#rscType").val() == "META"){
					validation = $("#dbmsArea").ifvValidation();
				}else if($("#rscType").val() == "LOG"){
					validation = $("#dbmsArea").ifvValidation();
				}

				//유효성 체크
				if(validation.confirm()){
					//port가 숫자일 경우에만 저장
					var tUrl = isNew? '<ifvm:action name="setAccessInfo"/>' : '<ifvm:action name="modifyAccessInfo"/>';
					var tData = null;
					tData = $("#accessInfoDetailForm").getSubmitData();

					if($("#rscType").val() == "DB"){
						tData.dbType = $("#dbType").val();
						tData.dbSchema = $("#dbSchema").val();
						tData.dbLoginId = $("#dbmsLoginId").val();
						tData.dbLoginPw = $("#dbmsLoginPw").val();
						tData.dbOption = $("#dbOption").val();
					}else if($("#rscType").val() == "FTP"){
						tData.dbType = '';
						tData.ftpLocalDir = $("#ftpLocalDir").val();
						tData.ftpConnDir = $("#ftpConnDir").val();
						tData.dbLoginId = $("#ftpLoginId").val();
						tData.dbLoginPw = $("#ftpLoginPw").val();
					}else if($("#rscType").val() == "META"){
						tData.dbType = $("#dbType").val();
						tData.dbSchema = $("#dbSchema").val();
						tData.dbLoginId = $("#dbmsLoginId").val();
						tData.dbLoginPw = $("#dbmsLoginPw").val();
						tData.dbOption = $("#dbOption").val();
					}else if($("#rscType").val() == "LOG"){
						tData.dbType = $("#dbType").val();
						tData.dbSchema = $("#dbSchema").val();
						tData.dbLoginId = $("#dbmsLoginId").val();
						tData.dbLoginPw = $("#dbmsLoginPw").val();
						tData.dbOption = $("#dbOption").val();
					}else{
						tData.dbType = '';
					}

					$.ifvSyncPostJSON(tUrl, tData
					, function(result) {
						if ($.fn.ifvmIsNotEmpty(result)) {
							alert('<spring:message code="V00219" />'); /* 완료되었습니다. */
							qtjs.href('<ifvm:url name="accessInfoList"/>');
						}
					}, function(result) {
						alert(result.message);
					});
				}
			}
		}
	},
	numberCheck : function(){
		var tNum = $("#port").val();
		var numFlag = false;

		if(isNaN(tNum)){
			alert('<spring:message code="Q00009" />'); /* 포트는 숫자만 입력할 수 있습니다. */
			numFlag = false;
		}else{
			numFlag = true;
		}

		return numFlag;
	}
}

function showInfo() {
	if($("#rscType").val() == "DB"){
		$("#dbmsArea").show();
		$("#ftpArea").hide();
	}else if($("#rscType").val() == "FTP"){
		$("#ftpArea").show();
		$("#dbmsArea").hide();
	}else if($("#rscType").val() == "META"){
		$("#dbmsArea").show();
		$("#ftpArea").hide();
	}else if($("#rscType").val() == "LOG"){
		$("#dbmsArea").show();
		$("#ftpArea").hide();
	}else{
		$("#ftpArea").hide();
		$("#dbmsArea").hide();
	}
}

function goList() {
	qtjs.href('<ifvm:url name="accessInfoList"/>');
}

$(document).ready(function(){

	$.ifvmLnbSetting('accessInfoListNew');

	getAccessInfoDetail.init();

	$("#rscType").change(function(){
		showInfo();
	});

});

</script>

<div class="page-title">
	<h1>
		<spring:message code="Q02858" /> <!-- 리소스 관리 -->
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-2">
		<span><spring:message code="I00195" /></span> <!-- 상세 -->
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" id="" btnFunc="getAccessInfoDetail.save" text="I00745" /> <!-- 저장 -->
		<ifvm:inputNew type="button" id="" btnFunc="" text="Q02864" /> <!-- 연결테스트 -->
		<ifvm:inputNew type="button" id="goList" btnFunc="goList" text="L00824" /> <!-- 목록 -->
	</div>
</div>
<div class="form-horizontal underline top_well" id="accessInfoDetailForm">
	<div class="page_btn_area">
		<div class="col-xs-2">
			<span><spring:message code="Q02865" /></span> <!-- 기본정보 -->
		</div>
	</div>
	<div class="form-horizontal top_well underline" id="defaultArea">
		<div class="row">
			<ifvm:inputNew type="hidden" id="rid" dto="rid" /> <!-- rid -->
			<ifvm:inputNew type="text" id="rscNm" dto="rscNm" label="Q02846" labelClass="1" conClass="4" required="true" /> <!-- 리소스명 -->
			<ifvm:inputNew type="select" id="rscType" names="rscType" dto="rscType" label="I02046" labelClass="2" conClass="4" required="true" /> <!-- 유형 -->
		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="hostAddr" dto="hostAddr" label="Q02860" labelClass="1" conClass="4" required="true" /> <!-- 호스트 주소 -->
			<ifvm:inputNew type="text" id="port" dto="port" label="Q02866" labelClass="2" conClass="4" required="true" /> <!-- 포트 -->
		</div>
		<div class="row">
			<ifvm:inputNew type="textarea" id="comment" dto="comment" label="I00075" labelClass="1" conClass="10" rows="4" /> <!-- 설명 -->
		</div>
		<div class="row">
			<ifvm:inputNew type="singleCheckbox" id="useYn" dto="useYn" label="Q00014" values="" labelClass="1" conClass="1" checked="true" /> <!-- 활성 여부 -->
		</div>
	</div>

	<!-- DBMS 연결정보 -->
	<div id="dbmsArea">
		<div class="page_btn_area">
			<div class="col-xs-2">
				<span><spring:message code="Q02872" /></span> <!-- DBMS 연결정보 -->
			</div>
		</div>
		<div class="form-horizontal top_well underline">
			<div class="row">
				<ifvm:inputNew type="select" id="dbType" names="dbType" dto="dbType" label="Q02867" labelClass="1" conClass="4" required="true" /> <!-- DBMS유형 -->
				<ifvm:inputNew type="text" id="dbSchema" dto="dbSchema" label="Q00012" labelClass="2" conClass="4" required="true" /> <!-- 스키마 -->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="dbmsLoginId" label="Q02863" labelClass="1" conClass="4" required="true" /> <!-- User Name -->
				<ifvm:inputNew type="password" id="dbmsLoginPw" label="Q02868" labelClass="2" conClass="4" required="true"  /> <!-- Password -->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="dbOption" dto="dbOption" label="Q00013" labelClass="1" conClass="4" /> <!-- 옵션 -->
			</div>
		</div>
	</div>

	<!-- FTP 연결정보 -->
	<div id="ftpArea">
		<div class="page_btn_area">
			<div class="col-xs-2">
				<span><spring:message code="Q02869" /></span> <!-- FTP 연결정보 -->
			</div>
		</div>
		<div class="form-horizontal top_well underline">
			<div class="row">
				<ifvm:inputNew type="text" id="ftpLoginId" label="Q02863" labelClass="1" conClass="4" required="true" /> <!-- User Name -->
				<ifvm:inputNew type="password" id="ftpLoginPw" label="Q02868" labelClass="1" conClass="4" required="true" /> <!-- Password -->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="ftpLocalDir" dto="ftpLocalDir" label="Q02870" labelClass="1" conClass="4" /> <!-- 로컬폴더경로 -->
				<ifvm:inputNew type="text" id="ftpConnDir" dto="ftpConnDir" label="Q02871" labelClass="1" conClass="4" /> <!-- 대상시스템경로 -->
			</div>
		</div>
	</div>

</div>