<%@ page trimDirectiveWhitespaces="true" %>
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
<script type="text/javascript">
var savePointValid;
var baseRid =  '<%= cleanXss(request.getParameter("baseRid")) %>';

function setValidCalendar() {
	saveInfoCommCodeSetting();
    var startDate = $("#dtlAplyStartDd");
    var endDate = $("#dtlAplyEndDd");
    startDate.val($.ifvGetNewDate('d', +1).newDateS);
	endDate.val($.ifvGetNewDate('m', +1).newDateS);
	
	 startDate.ifvDateChecker({
		  minDate : $.ifvGetNewDate('d', +1).newDateS,
		  maxDate : endDate
		 });
	 endDate.ifvDateChecker({
		  minDate : startDate
		 });
}

function pointSaveInfoDtl(){
	if(baseRid !="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getPntSaveDtl"/>',{rid : baseRid} ,function(result) {
			
			$("#pointSaveInfoPopForm").dataSetting(result);
			
			
	 		numberFormatterSetting();
		});
	}
}

function numberFormatterSetting (){
	var numFormatVal=$("#dtlAcrlPnt").val();
	$("#dtlAcrlPnt").ifvNumberOnly();
	$("#dtlAcrlPnt").val(numberWithCommas(numFormatVal));
	numFormatVal=$("#dtlAcrlPntLmt").val();
	$("#dtlAcrlPntLmt").ifvNumberOnly();
	$("#dtlAcrlPntLmt").val(numberWithCommas(numFormatVal));
	
}
function saveInfoCommCodeSetting(){
	//회원구분
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{  
		groupCode : 'ACC_MEM_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlMbrDivCdTemp").tmpl(result.rows);
		$("#dtlMbrDivCd").append(temp);
	});
	
	//회원등급
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{  
		groupCode : 'MEMBER_GRADE'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlTierCdTemp").tmpl(result.rows);
		$("#dtlTierCd").append(temp);
	});
	
	//적립단위
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{  
		groupCode : 'POINT_UNIT'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlAcrlUnitTemp").tmpl(result.rows);
		$("#dtlAcrlUnit").append(temp);
	});
}

function saveInfoPointFn(){
	savePointValid = $("#pointSaveInfoPopForm").ifvValidation();
	if(savePointValid.confirm()==true){
		var submitData =$("#pointSaveInfoPopForm").getSubmitData();
		submitData.itemType="SAVE";
		submitData.pntBasRuleRid=testViewList_rid;
		var startDd = submitData.dtlAplyStartDd.split("-")[0]+ submitData.dtlAplyStartDd.split("-")[1]+  submitData.dtlAplyStartDd.split("-")[2];
		var endDd = submitData.dtlAplyEndDd.split("-")[0]+ submitData.dtlAplyEndDd.split("-")[1]+  submitData.dtlAplyEndDd.split("-")[2];
		submitData.dtlAplyStartDd = startDd
		submitData.dtlAplyEndDd = endDd
		
		var codeValid=true;
		for(var i=0; i< savePntArr.length ;i++){
	/* 		if(savePntArr[i].tierCdCode == $("#dtlTierCd").val() &&  savePntArr[i].mbrDivCdCode ==$("#dtlMbrDivCd").val() ){
					codeValid=false;
			} */
		}
		if(!codeValid){
			alert('<spring:message code="L01676"/>');
			return;
		}
		if($("#dtlActiveYn").prop("checked")){
			submitData.dtlActiveYn="Y"	;
		}else{
			submitData.dtlActiveYn="N";
		}
		
		if(baseRid=="null"){
			submitData.rid =testViewList_rid
			$.ifvSyncPostJSON('<ifvm:action name="insertPointItem"/>',submitData ,function(result) {
				alert('<spring:message code="L00127"/>');
				pointSaveList.requestData();
				pointSaveInfoPop.close();
			},function(result){
				alert(result.message);
			});
		}else{
			submitData.rid = baseRid;
			submitData.pntBaseRuleId =  testViewList_rid
			$.ifvSyncPostJSON('<ifvm:action name="updatePointItem"/>',submitData ,function(result) {
				alert('<spring:message code="L00127"/>');
				pointSaveList.requestData();
				pointSaveInfoPop.close();
			},function(result){
				alert(result.message);
			});
		}
	}
}


function closePopSavePointPopFn(){
	pointSaveInfoPop.close();
}

$(document).ready(function() {
	setValidCalendar();
	numberFormatterSetting();
	pointSaveInfoDtl();
	memDivValid();
});


function memDivValid(){
	if($("#typeCd").val()=="A" && !($("#ascStnYn").is(":checked"))){
		$("#dtlMbrDivCd").val("ALL");

		
		$("#dtlMbrDivCd").change(function(){
			if($(this).val()!="ALL"){
				alert('<spring:message code="L01582"/>' );
				$("#dtlMbrDivCd").val("ALL");
				return;
			}
		}); 
	} else if($("#typeCd").val()=="A" && ($("#ascStnYn").is(":checked"))){
		var divCd ="P";
		$("#dtlMbrDivCd").change(function(){
			if($(this).val()!="P" && $(this).val()!="T" && $(this).val()!="C" ){
				alert('<spring:message code="L01583"/>' );
				$("#dtlMbrDivCd").val(divCd);
				return;
			}else{
				divCd = $("#dtlMbrDivCd").val();
			} 
		});
	}else if($("#typeCd").val()=="G"){
		$("#dtlMbrDivCd").val("G");
		$("#dtlMbrDivCd").change(function(){
			if($(this).val()!="G"){
				alert('<spring:message code="L01584"/>'  );
				$("#dtlMbrDivCd").val("G");
				return;
			}
		});
	} 
	 
}

</script>


<script id="dtlMbrDivCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlTierCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlAcrlUnitTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>


<div id="pointSaveInfoPopForm" >
	<div class="form-horizontal underline top_well" >
	 	<div class="row  qt_border">
	    	<ifvm:inputNew type="select" id="dtlMbrDivCd"   dto="dtlMbrDivCd"   label="L00837" labelClass="2" conClass="2"  required="true" /> 
		    <ifvm:inputNew type="select" id="dtlTierCd"  dto="dtlTierCd"   label="L00838" labelClass="2" conClass="2"  required="true" />
		    <ifvm:inputNew type="select" id="dtlAcrlUnit"  dto="dtlAcrlUnit"   label="L00903" labelClass="2" conClass="2"  required="true"  />  
	 	</div>
	 	
		 	<div class="row  qt_border">
	    	<ifvm:inputNew type="text" id="dtlAcrlPnt"   dto="dtlAcrlPnt"   label="L00904" labelClass="2" conClass="2"  required="true" /> 
		    <ifvm:inputNew type="text" id="dtlAcrlPntLmt"   dto="dtlAcrlPntLmt"   label="L00905" labelClass="2" conClass="2"  />
		    <label class="col-xs-2 control-label"><spring:message code="L00906"/></label>
  			<div class="col-xs-2 control_content">
				<input type="checkbox"  id="dtlActiveYn" />
  			</div> 
	 	</div>
	 	
	 	<div class="row  qt_border">
	    	<ifvm:inputNew type="date" id="dtlAplyStartDd" dto="dtlAplyStartDd" maxLength="50" label="L00907" labelClass="2" conClass="3"   required="true" />
    	    <ifvm:inputNew type="date" id="dtlAplyEndDd" dto="dtlAplyEndDd" maxLength="50" label="L00908" labelClass="2" conClass="3"   required="true"/>
	 	</div>
	</div>
</div>

<div class="pop_btn_area">
 	<ifvm:inputNew type="button" btnType="save"  text="L00074"  id="saveInfoPointBtn" btnFunc="saveInfoPointFn" objCode="pointSavesaveInfoPointBtn_OBJ"/>
 	<ifvm:inputNew type="button"   text="L00913"  id="closePopSavePointPopBtn" btnFunc="closePopSavePointPopFn" objCode="pointsaveclosePopSavePointPopBtn_OBJ"/>
</div>
