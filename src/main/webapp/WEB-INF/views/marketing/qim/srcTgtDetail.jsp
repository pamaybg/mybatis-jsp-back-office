<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
var isNew = true;


getSrcTgtDetail = {
	init : function(){
		var rid = $.ifvGetParam('rid');
		if(typeof rid === 'undefined') isNew = true;
		else isNew = false;

		if(!isNew){
			//소스/타겟 상세 조회
			$.ifvSyncPostJSON('<ifvm:action name="getSrcTgtDetail"/>', {
				rid : rid
			}, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					$("#srcTgtDetailForm").dataSetting(result);
					if(result.useYn == "1"){
						$("#useYn").attr("checked",true);
					}
				}
			}, function(result) {
				alert(result.message);
			});
		}
	},
	save : function(){

		var validation = $("#srcTgtDetailForm").ifvValidation();

		//유효성 체크
		if(validation.confirm()){
			var tUrl = isNew? '<ifvm:action name="setSrcTgt"/>' : '<ifvm:action name="modifySrcTgt"/>';
			var tData = null;
			tData = $("#srcTgtDetailForm").getSubmitData();

			//약어 중복 체크
			$.ifvSyncPostJSON('<ifvm:action name="srcTgtAliasChk"/>', tData
			, function(result) {
				//중복이 없을시 save 진행
				$.ifvSyncPostJSON(tUrl, tData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert('<spring:message code="V00219" />'); /* 완료되었습니다. */
						//location.href = '<ifvm:url name="srcTgtDetail"/>' + '?rid=' + result.message;
						qtjs.href('<ifvm:url name="srcTgtDetail"/>' + '?rid=' + result.message);
					}
				}, function(result) {
					alert(result.message);
				});
			}, function(result) {
				alert('<spring:message code="Q00017" />'); /* 중복된 약어가 존재 합니다. */
			});
		}

	},
	goList : function(){
		//location.href = '<ifvm:url name="srcTgtList"/>';
		qtjs.href('<ifvm:url name="srcTgtList"/>');
	}
}

$(document).ready(function(){
	$.ifvmLnbSetting('srcTgtList');

	getSrcTgtDetail.init();
});
</script>

<div class="page-title">
	<h1>
		<spring:message code="Q02839" /> <!-- 소스/타겟 관리 -->
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-2">
		<span><spring:message code="Q02827" /></span> <!-- 소스/타겟 명 -->
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" id="" btnFunc="getSrcTgtDetail.save" text="I00745" /> <!-- 저장 -->
		<ifvm:inputNew type="button" id="" btnFunc="getSrcTgtDetail.goList" text="L00824" /> <!-- 목록 -->
	</div>
</div>
<div class="form-horizontal underline top_well" id="srcTgtDetailForm">
	<div class="form-horizontal top_well underline">
		<div class="row">
			<ifvm:inputNew type="hidden" id="rid" dto="rid" /> <!-- rid -->
			<ifvm:inputNew type="text" id="srcTgtNm" dto="srcTgtNm" label="Q02827" labelClass="1" conClass="4" required="true" /> <!-- 소스/타겟 명 -->
		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="srcTgtAlias" dto="srcTgtAlias" label="Q02828" labelClass="1" conClass="4" required="true" maxLength="10" /> <!-- 약어 -->
			 <label class="col-xs-2 control-label">(<spring:message code="Q00019"/>)</label>
		</div>

		<div class="row">
			<ifvm:inputNew type="textarea" id="comment" dto="comment" label="I00075" labelClass="1" conClass="10" rows="4" /> <!-- 설명 -->
		</div>
		<div class="row">
			<ifvm:inputNew type="singleCheckbox" id="useYn" dto="useYn" label="Q02830" values="" labelClass="1" conClass="1" checked="true" /> <!-- 활성여부 -->
		</div>
	</div>
</div>