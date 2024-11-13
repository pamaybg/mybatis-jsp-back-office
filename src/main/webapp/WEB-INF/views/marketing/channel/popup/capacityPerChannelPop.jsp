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
var changeChk2= false;

function detailCheck(){
	if(chilId == "null"){
		childetail = false;
	}
	else initSetting();
}

function initSetting(){
	if(childetail){
		$.ifvSyncPostJSON('<ifvm:action name="getDetailCapa"/>', {
			  id : chilId
		}, function(result) {
			$("#termDivision").val(result.periodType);
		    $("#maxCapacity").val(result.maxVol);
		 	$("#reserveVol").val(result.reserveVol);
		    $("#description").val(result.description);
		    initPer = result.periodType;
		});
	}
}



$(document).ready(function(){
	
	
	//기간 구분
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_STAND_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#termDivisiontemp").tmpl(result.rows);
		$("#termDivision").append(temp);
	});
	
	detailCheck();
	
	$('#capacityChannelSelectBtn').on('click', function(){
		if(childetail){
			if(initPer == $("#termDivision").val()){
				changeChk2 = false;
				$("#termDivision").val(initPer);
			}else{
				changeChk2 = true
			}
			$.ifvSyncPostJSON('<ifvm:action name="editCapaChannel"/>', {
				   id : chilId
				 , mktChlId : rowid
				 , periodType : $("#termDivision").val()
				 , maxVol : $("#maxCapacity").val()
				 , reserveVol : ''
				 , description : $("#description").val()
				 , changeChk : changeChk2
			}, function(result) {
				alert('<spring:message code="M00429"/>');
// 				channelCapacityGrid.requestData( { mktChlId : rowid } );
				channelCapacityGrid.searchGrid();
				//idCheck();
				alert('<spring:message code="M00429"/>');
			},function(result) {   
				check = false;
				if(result.errorType == "900100") alert('<spring:message code="M01289"/>');
			});
		}
		else{
				$.ifvSyncPostJSON('<ifvm:action name="setChannelStore"/>', {
					   mktChlId : rowid
					 , periodType : $("#termDivision").val()
					 , maxVol : $("#maxCapacity").val()
					 , reserveVol : ''
					 , description : $("#description").val()
				}, function(result) {
					capaUse = true;
					capaid = result.message;
					alert('<spring:message code="M00152"/>');
					channelCapacityGrid.searchGrid();
// 					channelCapacityGrid.requestData( { mktChlId : rowid } );
				},function(result) {   
					check = false;
					if(result.errorType == "900100") alert('<spring:message code="M01289"/>');
				});
		}
		channelPopupClose();
		
	});
	$('#capacityChannelCancelBtn').on('click', function(){
		channelPopupClose();
	});
	
});
</script>

<script id="termDivisiontemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>


<div id="capacityWrap">
	<div class="pop_inner_wrap form-horizontal">
		<div class="row qt_border">
			<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M00475"/></label>
			<div class="col-xs-8 control_content">
				<ifvm:input type="select" required="true" id="termDivision"/>				
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M00476"/></label>
			<div class="col-xs-8 control_content">
				<ifvm:input type="text" required="true" id="maxCapacity" valiItem = "number"/>				
			</div>
		</div>
		<div class="row">
			<label class="col-xs-4 control-label"><spring:message code="M00472"/></label>
			<div class="col-xs-8 control_content">
				<ifvm:input type="textarea" className="text_description text_description_150" id="description" maxLength="200"/>				
			</div>
		</div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="capacityChannelSelectBtn">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00280"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="capacityChannelCancelBtn">         
			<spring:message code="M00284"/>
		</button> 
	</div>
</div>