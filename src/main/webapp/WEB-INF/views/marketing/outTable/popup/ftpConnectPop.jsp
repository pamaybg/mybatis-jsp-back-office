<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
var PwChk = false;

$(document).ready(function(){
	$("#ftp_con_pw").on("change", function(){
		PwChk= true;
	});
	
	$("#ftpConnectPopCancel").on("click", adminTargetingPopClose);
	
	$("#ftpConnectSaveBtn").on("click", function(){
		var obj = {};
		validation = $("#ftpConnectPopFormArea").ifvValidation();
		if(validation.confirm()){
			if(ftpConnectId != ""){
				// 수정
				obj.id = ftpConnectId;
				obj.ftp_prps_cd_id = $("#ftp_prps_cd_id").val();
				obj.ftp_prot_cd_id = $("#ftp_prot_cd_id").val();
				obj.con_id = $("#ftp_con_id").val();
				obj.con_pw = $("#ftp_con_pw").val();
				obj.con_ip = $("#ftp_con_ip").val();
				obj.con_port = $("#ftp_con_port").val();
				obj.con_foldr_path = $("#ftp_con_foldr_path").val();
				obj.ftp_desc = $("#ftp_desc").val();
				obj.pwChk = PwChk?"Y":"N";
				
				$.ifvSyncPostJSON('<ifvm:action name="editFtpConnect"/>',obj
				,function(result) {
					alert('<spring:message code="M00267"/>');
					$.fn.ifvmSubmitSearchCondition("ftpConnectList", ftpConnectListInit);
					adminTargetingPopClose();
					$.fn.ifvmPopupClose();
				});
			} else {
				// 입력
				obj.ftp_prps_cd_id = $("#ftp_prps_cd_id").val();
				obj.ftp_prot_cd_id = $("#ftp_prot_cd_id").val();
				obj.con_id = $("#ftp_con_id").val();
				obj.con_pw = $("#ftp_con_pw").val();
				obj.con_ip = $("#ftp_con_ip").val();
				obj.con_port = $("#ftp_con_port").val();
				obj.con_foldr_path = $("#ftp_con_foldr_path").val();
				obj.ftp_desc = $("#ftp_desc").val();
				
				$.ifvSyncPostJSON('<ifvm:action name="setFtpConnect"/>',obj
				,function(result) {
					alert('<spring:message code="M00267"/>');
					$.fn.ifvmSubmitSearchCondition("ftpConnectList", ftpConnectListInit);
					adminTargetingPopClose();
					$.fn.ifvmPopupClose();
				});
			}
		}
	});
});

/*로딩 시 세팅해주는 부분. 
* 선택구역,반경 등의 Data를 가져와 화면에 뿌려준다.
*/
$(function(){
	//FTP목적 값 코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_FTP_PURPOSE'
		, enableNA : true
	},function(result) {
		var temp = $("#commftpPurpose").tmpl(result.rows);
		$("#ftp_prps_cd_id").append(temp);
	});
	
	//FTP프로토콜 값 코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_FTP_PROTOCAL'
		, enableNA : true
	},function(result) {
		var temp = $("#commftpProtocal").tmpl(result.rows);
		$("#ftp_prot_cd_id").append(temp);
	});
	
	if(ftpConnectId != "") {
		//이벤트 조회
		$.ifvSyncPostJSON('<ifvm:action name="getFtpConnect"/>', {
			id : ftpConnectId,
			sidx : "FTP_DESC",
			sord : "desc"
		}, function(result) {
			$("#ftp_prps_cd_id").val(result.rows[0].ftp_prps_cd_id);
			$("#ftp_prot_cd_id").val(result.rows[0].ftp_prot_cd_id);
			$("#ftp_con_id").val(result.rows[0].con_id);
			$("#ftp_con_pw").val(result.rows[0].con_pw);
			$("#ftp_con_ip").val(result.rows[0].con_ip);
			$("#ftp_con_port").val(result.rows[0].con_port);
			$("#ftp_con_foldr_path").val(result.rows[0].con_foldr_path);
			$("#ftp_desc").val(result.rows[0].ftp_desc);
		});
	} else {
		$("#ftp_con_id").val("");
		$("#ftp_con_pw").val("");
		$("#ftp_con_ip").val("");
		$("#ftp_con_port").val("");
		$("#ftp_con_foldr_path").val("");
		$("#ftp_desc").val("");
	}
});
</script>

<script id="commftpPurpose" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="commftpProtocal" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>
<div id='ftpConnectPopFormArea'>
	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M01374'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" id="ftp_prps_cd_id" required="true"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M01375'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" id="ftp_prot_cd_id" required="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M01376'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="ftp_con_ip" required="true"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M01377'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="ftp_con_port" required="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M01378'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="ftp_con_id" required="true"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00584"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="password" id="ftp_con_pw" required="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code='M01379'/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="text" id="ftp_con_foldr_path"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code='M01380'/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="textarea" rows="3" id="ftp_desc"/>
	        </div>
	    </div>

	    <div class="row">
	        <label class="col-xs-2 control-label"><spring:message code='M00184'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" disabled="true"/>
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code='M00185'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="date" disabled="true"/>
	        </div>
	    </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="ftpConnectSaveBtn" objCode="ftpConnectionPopSave_OBJ">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="ftpConnectPopCancel" objCode="ftpConnectionPopCancel_OBJ">         
		<spring:message code="M00284"/>
	</button>  
</div>