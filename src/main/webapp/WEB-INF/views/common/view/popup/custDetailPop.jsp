<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>



<script>
var validation2;

//저장
function saveSubmit(){	
	
	var v_new_identiTypeCd = $("#new_identiTypeCd").val();
	var v_new_identiVal =  $("#new_identiVal").val();
	
	//전화번호(02),카드번호(03),법인번호(05)의 경우 숫자만 추출
	if(v_new_identiTypeCd != '02' || v_new_identiTypeCd != '03' ||  v_new_identiTypeCd != '05' ) {
		v_new_identiVal = v_new_identiVal.replace(/[^0-9]/g,'');
	}
		
	$.ifvSyncPostJSON( '<ifvm:action name="addCust"/>' 
		,{
	 	   custNm 			 :  $("#new_custNm").val()
		 , custTypeCd 		 :  $("#new_custTypeCd").val()
		 , identiTypeCd      :  $("#new_identiTypeCd").val()
		 , identiVal         :  v_new_identiVal
		 , birthDt        	 :  $("#new_birthDt").val()
		 , genGbnCd 		 :  $("#new_genGbnCd").val()
         }
			
	, function(result) {
		alert('<spring:message code="L00127"/>');
		$('#popupContainer1').ejDialog('destroy');
		grid.opt.grid.trigger("reloadGrid");
      
	}
	, function(result) {
		if(result.errorType == '900004') {
			alert('<spring:message code="L00441"/>');
		}else {
			alert("error!!!");
		}
	}
	
	);
}





/*
 submit을 위한 form 데이터 파라미터 세팅
 */
function getObjForSubmit(){
	var v_obj = {
			 	   custNm 			 :  $("#new_custNm").val()
				 , custTypeCd 		 :  $("#new_custTypeCd").val()
				 , identiTypeCd      :  $("#new_identiTypeCd").val()			 
				 , identiVal         :  v_new_identiVal
				 , birthDt        	 :  $("#new_birthDt").val()
				 , genGbnCd 		 :  $("#new_genGbnCd").val()
		};
	
	return v_obj;
	
}

//저장 버튼클릭 시 동작
function actionSave() {
	
 	if(validation2.confirm())  saveSubmit();
}


$(document).ready(function(){
	
	$("#btnSaveNew").click(function(){
		actionSave();
    });
	
	$("#cancelBtnNew").click(function(){
		$('#popupContainer1').ejDialog('destroy');
	});
	
	validation2 = $("#new_custForm").ifvValidation();

});

</script>

<!-- 고객유형 -->
<script id="custTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!--식별 유형 코드  -->
<script id="identiTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- 성별 -->
<script id="genGbnCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<div class="form-horizontal underline top_well" id="new_custForm" >
	<div class="row  qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00320"/></label>	
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" required="true" id="new_custNm"/>
		</div>
		
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00318"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="select" required="true" id="new_custTypeCd"/>
		</div>
	
	</div> 
	<div class="row  qt_border">	
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00343"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" required="true" id="new_identiTypeCd" />
		</div>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00342"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="text" required="true"  id="new_identiVal"/>
		</div>
	</div>	
		
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="L00339"/></label>
		<div class="col-xs-4 control_content">
				<ifvm:input type="text"  id="new_birthDt"/>
		</div>
		<label class="col-xs-2 control-label"><spring:message code="L00341"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="select" id="new_genGbnCd" />
		</div>
	</div>
</div>

<div class="pop_btn_area">
    <button class="btn btn-sm" id="btnSaveNew"><i class="glyphicon glyphicon-check"></i>
			<spring:message code="L00125"/>
	</button> 
    <button class="btn btn-sm btn_lightGray2" id="cancelBtnNew">
    <spring:message code="L00124"/>         
    </button> 
</div>


<script>



$(function(){
	
	//고객유형코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_CUST_TYPE_CD'		
		, enableNA : true
	},function(result) {
		var temp = $("#custTypeCdTemp").tmpl(result.rows);
		$("#new_custTypeCd").append(temp);
	});
	
	//회원식별유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_IDENTI_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#identiTypeCdTemp").tmpl(result.rows);
		$("#new_identiTypeCd").append(temp);
	});
	

	//성별
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_GEN_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#genGbnCdTemp").tmpl(result.rows);
		$("#new_genGbnCd").append(temp);
	});
	
	
	
});

</script>
