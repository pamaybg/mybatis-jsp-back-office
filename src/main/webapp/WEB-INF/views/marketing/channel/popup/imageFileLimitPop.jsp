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
<script>
var rowid = '<%= cleanXss(request.getParameter("id")) %>';
var chilId = '<%= cleanXss(request.getParameter("chilId")) %>';
var childetail = true; 
var InfoValidation;
var ContentType;
var fileType =[];

function detailCheck(){
	if(chilId == "null"){
		childetail = false;
	}
	else initSetting();
}

function typeSettingCheck(){
	var width;
	
	if($("#maxVol").val().length == 0){
		alert('<spring:message code="M00500"/>')
		return false;
	}
	if($("#type").val() == 'IMAGE'){
		if($("#width").val().length == 0 || $("#height").val().length == 0){
			alert('<spring:message code="M00502"/>')
			return false;
		}else{
			width = $("#width").val() *1;
		}
		
		if(width <= 137){
			alert('<spring:message code="M00501"/>')	
			return false;
		}
	}
	return true;
}

function initSetting(){
	if(childetail){
		
		$.ifvSyncPostJSON('<ifvm:action name="getImgDetailOption"/>', {
			  mktChnlId : rowid
			  ,id : chilId
		}, function(result) {
			var size = $("#Division").children().length;
			var typeCehck = null;
			for(var i=0;i<size;i++){
				if($("#Division").children().eq(i).text() == result.upldEtsionCd){
					typeCehck = $("#Division").children().eq(i).val()
				}
			}
			$("#Division").val(typeCehck);
		    $("#maxVol").val(result.maxVol);
		 	$("#height").val(result.imgResolH);
		    $("#width").val(result.imgResolW);
		    $("#type").val(result.upldType);
		});
		initvalSetting();
	}
}

//image,file type에 따라 required 활성,비활성화
function initvalSetting(){
	if($("#Division option:selected").attr('attrib01') == 'IMAGE'){
		$("#height").attr('disabled',false);
		$("#width").attr('disabled',false);
		$("#height").attr('required',true);
		$("#width").attr('required',true); 
		
	}else{
		$("#height").attr('disabled',true);
		$("#width").attr('disabled',true);
		$("#height").attr('required',false);
		$("#width").attr('required',false); 
		$("#width").val("");
		$("#height").val("");
	}
	InfoValidation = $("#DefaultForm").ifvValidation();
}

$(document).ready(function(){
	detailCheck();
	InfoValidation = $("#DefaultForm").ifvValidation();
	
	$('#imageFileCancelBtn').on('click', function(){
		channelPopupClose();
	});

	$.ifvSyncPostJSON('<ifvm:action name="getContypeId"/>', {
		   id       : rowid
	}, function(result) {	
		ContentType = result.mktChnlId
	});

	$.ifvSyncPostJSON('<ifvm:action name="getImageOptionList"/>', {
		chnlId       : rowid,	    
	}, function(result) {	
		
		//이미지 옵션이 생성되어 있지 않을 댸 에러
		if(result.length != 0){
		    fileType = result
		}
	});

	//기간 구분
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'CHNL_UPLOAD_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#Divisiontemp").tmpl(result.rows);
		$("#Division").append(temp);
		$("#type").val($("#Division option:selected").attr('attrib01'));
	});
	
	
	$("#saveBtn").on('click',function(){
		
		if( InfoValidation.confirm() == false ) return;
		if(typeSettingCheck() == false) return;
		
		if(childetail){
			$.ifvSyncPostJSON('<ifvm:action name="editImgOption"/>',{
				  id : chilId
				, maxVol :  $("#maxVol").val()
				, imgResolH :  $("#height").val()
				, imgResolW :  $("#width").val()
				, upldEtsionCd : $("#Division option:selected").val()
				, upldType : $("#type").val()
			},function(result) {
				alert('<spring:message code="M00429"/>');
				imageFileLimitGrid.searchGrid();
// 				imageFileLimitGrid.requestData({ mktChlId : rowid });
				channelPopupClose();
			});
		}
		else{
			var size = fileType.length;
			
			for(var i=0;i<size;i++){
				if($("#Division option:selected").text() == fileType[i].name){
					alert('<spring:message code="M00816"/>');
					return;
				}
			}
			
			$.ifvSyncPostJSON('<ifvm:action name="setImgOption"/>',{
				  mktChnlId : rowid
				, maxVol 	   : $("#maxVol").val()
				, imgResolH    : $("#height").val()
				, imgResolW    : $("#width").val()
				, upldEtsionCd : $("#Division option:selected").val()
				, upldType     : $("#type").val()
			},function(result) {
				alert('<spring:message code="M00623"/>')
				//imageFileLimitGrid.requestData( { mktChlId : rowid } );
				imageFileLimitGrid.searchGrid();
				channelPopupClose();
			});
		}
		
	})
	initvalSetting();
	
	$("#Division").on('change',function(){
		$("#type").val($("#Division option:selected").attr('attrib01'));
		initvalSetting();
	})
	initSetting();
	
});
</script>

<script id="Divisiontemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}" attrib01="${'${'}attrib01}">${'${'}markName}</option>
</script>


<div id="DefaultForm"  class="pop_inner_wrap form-horizontal">
	<div class="row qt_border">
		<label class="col-xs-4 control-label"><spring:message code="M00490"/></label>
		<div class="col-xs-8 control_content">
			<ifvm:input type="text" disabled="disabled" id="type"/>				
		</div>
	</div>
	<div class="row qt_border">
		<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M00491"/></label>
		<div class="col-xs-8 control_content">
			<ifvm:input type="select" required="true" id="Division"/>				
		</div>
	</div>
	<div class="row qt_border">
		<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M00492"/></label>
		<div class="col-xs-8 control_content">
			<ifvm:input type="text" required="true" id="maxVol" valiItem="number" />				
		</div>
	</div>
	<div class="row qt_border">
		<label class="col-xs-4 control-label"><spring:message code="M00493"/></label>
		<div class="col-xs-8 control_content">
			<ifvm:input type="text" required="true" id="width" valiItem="number"/>				
		</div>
	</div>
	<div class="row">
		<label class="col-xs-4 control-label"><spring:message code="M00494"/></label>
		<div class="col-xs-8 control_content">
			<ifvm:input type="text" required="true" id="height" valiItem="number"/>				
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="saveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="imageFileCancelBtn">         
		<spring:message code="M00284"/>
	</button> 
</div>