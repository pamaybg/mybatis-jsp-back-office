<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
	var ANALYSIS_EXTERNAL_URL_CONFIG = {};
	ANALYSIS_EXTERNAL_URL_CONFIG.TARGET_ID = null;
	ANALYSIS_EXTERNAL_URL_CONFIG.LANG_TYPE = "LANG_TYPE";
	ANALYSIS_EXTERNAL_URL_CONFIG.ANALYSIS_EBD_TYPE_CD = "DASHBRD_EBD_TYPE_CD";
	ANALYSIS_EXTERNAL_URL_CONFIG.ANALYSIS_TYPE = null;
	
	var getAnalysisExternalRequestBase = function( targetId, analysisType ) {
		ANALYSIS_EXTERNAL_URL_CONFIG.TARGET_ID = targetId;
		ANALYSIS_EXTERNAL_URL_CONFIG.ANALYSIS_TYPE = analysisType;

		$.ifvSyncPostJSON( "<ifv:action name='getAnalysisExtenalRequestBase' />", {
			langTypeCode: ANALYSIS_EXTERNAL_URL_CONFIG.LANG_TYPE
			, analysisEmbedTypeCode: ANALYSIS_EXTERNAL_URL_CONFIG.ANALYSIS_EBD_TYPE_CD
			, analysisType: analysisType
		}	
		, function( resData ) {
			var langTypeCodeList = resData.langTypeCodeList;
			var langTypeTmpl = $( "#analysisOptionTypeCodeTemplate" ).tmpl( langTypeCodeList );
			
			$( "#langTypeCodeList" ).append( langTypeTmpl );
			
			if( $.fn.ifvmIsNotEmpty( analysisType ) ) {
				var analysisEmbedTypeCodeListTmpl = $( "#analysisEmbedTypeCodeListTemplate" ).tmpl();
				$( "#analysisEmbedTypeCodeListArea" ).append( analysisEmbedTypeCodeListTmpl );
				
				var analysisEmbedTypeCodeList = resData.analysisEmbedTypeCodeList;
				var analysisEmbedTypeTmpl = $( "#analysisOptionTypeCodeTemplate" ).tmpl( analysisEmbedTypeCodeList );
				$( "#analysisEmbedTypeCodeList" ).append( analysisEmbedTypeTmpl );
			}
		});
	};
	
	$( document ).ready(function() {
		$( "#analysisExternalReqCreateBtn" ).click(function( evt ) {
			var targetUrl = window.location.origin;
			
			if( $.fn.ifvmIsNotEmpty( ANALYSIS_EXTERNAL_URL_CONFIG.ANALYSIS_TYPE ) ) {
				targetUrl += "<ifv:url name='externalRequestAnalysis' />" + "/" + ANALYSIS_EXTERNAL_URL_CONFIG.TARGET_ID + "?";
				targetUrl += "analysisType=" + $( "#analysisEmbedTypeCodeList" ).val() + "&";
			} else {
				targetUrl += "<ifv:url name='externalRequestDashboard' />" + "/" + ANALYSIS_EXTERNAL_URL_CONFIG.TARGET_ID + "?";
			}
			
			var langTypeCode = $( "#langTypeCodeList" ).val();
			targetUrl += "lang=" + langTypeCode;
			
			$( "#externalUrl" ).text( targetUrl );
		});
		
		$( "#analysisExternalReqConfirmBtn" ).click(function( evt ) {
			var externalUrl = $( "#externalUrl" ).text();
			
			if( $.fn.ifvmIsNotEmpty( externalUrl ) ) {
				$( "#externalUrl" ).select();
				document.execCommand( "copy" );
				
				alert( "<spring:message code='M01792' />" );
			}
			
			delete ANALYSIS_EXTERNAL_URL_CONFIG;
			$( "#analysisExternalRequestPop" ).data( "ejDialog" ).close();
		});
		
		$( "#analysisExternalReqCancelBtn" ).click(function( evt ) {
			delete ANALYSIS_EXTERNAL_URL_CONFIG;
			$( "#analysisExternalRequestPop" ).data( "ejDialog" ).close();
		});
	});
</script>

<div class="pop_inner_wrap">
	<div class="row qt_border">
		<div id="analysisEmbedTypeCodeListArea"></div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-3 control-label text-right"><spring:message code="M00237" /></label>
		
		<div class="col-xs-9 control_content">
			<ifv:input type="select" id="langTypeCodeList" />
		</div>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-3 control-label text-right"><spring:message code="M01793" /></label>
		
		<div class="col-xs-9 control_content">
			<ifv:input type="textarea" id="externalUrl" dto="externalUrl" rows="2" maxLength="1000" readonly="true" />
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisExternalReqCreateBtn" objCode="analysisExternalReqCreateBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i> <spring:message code="M01575" />
	</button>
	<button class="btn btn-sm btn_gray" id="analysisExternalReqConfirmBtn" objCode="analysisExternalReqConfirmBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i> <spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisExternalReqCancelBtn" objCode="analysisExternalReqCancelBtn_OBJ"><spring:message code="C00040" /></button>
</div>

<script id="analysisEmbedTypeCodeListTemplate" type="text/x-jquery-tmpl">
	<label class="col-xs-3 control-label text-right"><spring:message code="M00559" /></label>

	<div class="col-xs-9 control_content">
		<ifv:input type="select" id="analysisEmbedTypeCodeList" />
	</div>
</script>