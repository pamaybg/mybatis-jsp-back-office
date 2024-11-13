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

var adjustValid;
var adjustRid = '<%= cleanXss(request.getParameter("adjustRid")) %>'
function setValidCalendar() {
	adjustInfoCommCodeSetting();
    var startDate = $("#dtlAplyStartDd");
    var endDate = $("#dtlAplyEndDd");
    //startDate.val($.ifvGetTodayDate());
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

function adjustInfoCommCodeSetting(){
	//회원구분
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'ADJUST_MEM_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlMbrDivCdTemp").tmpl(result.rows);
		$("#dtlMbrDivCd").append(temp);
	});
	
	//정산구분
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{  
		groupCode : 'ADJUST_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlAdjustDivCdTemp").tmpl(result.rows);
		$("#dtlAdjustDivCd").append(temp);
	});
	
	//정산비율
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{  
		groupCode : 'ADJUST_METHOD'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlAdjustMethCdTemp").tmpl(result.rows);
		$("#dtlAdjustMethCd").append(temp);
	});
}

function saveAdjustInfoPointFn(){
	adjustValid = $("#pointAdjustInfoPopForm").ifvValidation();
	
	if(adjustValid.confirm()==true){
		var rateCheck;
		rateCheck = $("#dtlE1ShrexpnsRate").val()*1 +$("#dtlPartnerShrexpnsRate").val()*1; 

		codeValid=true;
	/* 	for(var i=0; i<adjustArr.length; i++){
			if(adjustArr[i].mbrDivCdCode==$("#dtlMbrDivCd").val() && adjustArr[i].adjustDivCdCode==$("#dtlAdjustDivCd").val() ){
				alert('<spring:message code="L01677"/>');
				return;
				
			}
		} */
		if($("#dtlAdjustMethCd").val()=="RAT" && rateCheck!=100){
			alert('<spring:message code="L01675"/>');
			return ;
		}
		var submitData =$("#pointAdjustInfoPopForm").getSubmitData();
		submitData.itemType="ADJUST";
		submitData.pntBasRuleRid=testViewList_rid;
		var startDd = submitData.dtlAplyStartDd.split("-")[0]+ submitData.dtlAplyStartDd.split("-")[1]+  submitData.dtlAplyStartDd.split("-")[2];
		var endDd = submitData.dtlAplyEndDd.split("-")[0]+ submitData.dtlAplyEndDd.split("-")[1]+  submitData.dtlAplyEndDd.split("-")[2];
		submitData.dtlAplyStartDd = startDd
		submitData.dtlAplyEndDd = endDd
		
		if($("#dtlActiveYn").prop("checked")){
			submitData.dtlActiveYn="Y"	;	
		}else{
			submitData.dtlActiveYn="N";
		}
		if(adjustRid =="null"){
			submitData.rid =testViewList_rid;
			$.ifvSyncPostJSON('<ifvm:action name="insertPointItem"/>',submitData ,function(result) {
				alert('<spring:message code="L00127"/>');
				pointAdjustList.requestData();
				pointAdjustInfoPop.close();
			},function(result){
				alert(result.message);
			});
		}else{
			submitData.rid = adjustRid;
			submitData.pntBaseRuleId =  testViewList_rid
			$.ifvSyncPostJSON('<ifvm:action name="updatePointAdjustItem"/>',submitData ,function(result) {
				alert('<spring:message code="L00127"/>');
				pointAdjustList.requestData();
				pointAdjustInfoPop.close();
			},function(result){
				alert(result.message);
				
			});

		}
		
	}
}
function closePopAdjustPointPopFn(){
	pointAdjustInfoPop.close();
}

function adjustmentTypeValid(){
	if($("#ascStnYn").is(":checked")){
		var checkDivCd="P";
		$("#dtlMbrDivCd").change(function(){
			if($("#dtlMbrDivCd").val()!="P" && $("#dtlMbrDivCd").val()!="T" && $("#dtlMbrDivCd").val()!="C"){
				alert('<spring:message code="L01583" />');
				$("#dtlMbrDivCd").val(checkDivCd);
				return;
			}else{
				checkDivCd = $("#dtlMbrDivCd").val();
			}
		})
	}else{
		$("#dtlMbrDivCd").val("ALL");
		$("#dtlMbrDivCd").change(function(){
			if($("#dtlMbrDivCd").val()!="ALL"){
				alert('<spring:message code="L01582"/>');
				$("#dtlMbrDivCd").val("ALL");
			}		
		})
	}
}

function pointAdjustDtlSetting(){
	if(adjustRid!="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getPntAdustInfo"/>',{rid : adjustRid} ,function(result) {
			$("#pointAdjustInfoPopForm").dataSetting(result);
			if(result.dtlActiveYn=="Y"){
				$("#dtlActiveYn").attr("checked",true);
			}
		});
	}
	numberFormatterSetting();
}

function numberFormatterSetting (){
	var numFormatVal=$("#dtlE1ShrexpnsRate").val();
	$("#dtlE1ShrexpnsRate").ifvNumberOnly();
	$("#dtlE1ShrexpnsRate").val(numberWithCommas(numFormatVal));
	numFormatVal=$("#dtlPartnerShrexpnsRate").val();
	$("#dtlPartnerShrexpnsRate").ifvNumberOnly();
	$("#dtlPartnerShrexpnsRate").val(numberWithCommas(numFormatVal));
	
	numFormatVal=$("#dtlGrntMinAmt").val();
	$("#dtlGrntMinAmt").ifvNumberOnly();
	$("#dtlGrntMinAmt").val(numberWithCommas(numFormatVal));
}

$(document).ready(function() {
	numberFormatterSetting();
	
	setValidCalendar();
	pointAdjustDtlSetting();
	adjustmentTypeValid();
});



</script>



<script id="dtlMbrDivCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlAdjustDivCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlAdjustMethCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>


<div id="pointAdjustInfoPopForm" >
	<div class="form-horizontal underline top_well" >
	 	<div class="row  qt_border">
	    	<ifvm:inputNew type="select" id="dtlMbrDivCd"   dto="dtlMbrDivCd"   label="L00837" labelClass="2" conClass="2"  required="true" /> 
		    <ifvm:inputNew type="select" id="dtlAdjustDivCd"  dto="dtlAdjustDivCd"   label="L00745" labelClass="2" conClass="2"  required="true" />
		    <ifvm:inputNew type="select" id="dtlAdjustMethCd"  dto="dtlAdjustMethCd"   label="L00746" labelClass="2" conClass="2"  required="true" />  
	 	</div>
	 	
		 	<div class="row  qt_border">
	    	<ifvm:inputNew type="text" id="dtlE1ShrexpnsRate"   dto="dtlE1ShrexpnsRate"   label="L00747" labelClass="2" conClass="2" required="true" /> 
		    <ifvm:inputNew type="text" id="dtlPartnerShrexpnsRate"   dto="dtlPartnerShrexpnsRate"   label="L00748" labelClass="2" conClass="2"  required="true" />
		    <ifvm:inputNew type="text" id="dtlGrntMinAmt"   dto="dtlGrntMinAmt"   label="L00749" labelClass="2" conClass="2"  />
	 	</div>
	 	
	 	<div class="row  qt_border">
	 	
	 	<ifvm:inputNew type="singleCheckbox" id="dtlActiveYn" label="L00906" values="Y" labelClass="2" conClass="1" checked="false" />
	 <%-- 			    <label class="col-xs-2 control-label"><spring:message code="L00906"/></label>
  			<div class="col-xs-1 control_content">
				<input type="checkbox"  id="dtlActiveYn" />
  			</div>  --%>
	 	
	  	 	<ifvm:inputNew type="date" id="dtlAplyStartDd" dto="dtlAplyStartDd" maxLength="50" label="L00907" labelClass="2" conClass="3" required="true"  />
    	    <ifvm:inputNew type="date" id="dtlAplyEndDd" dto="dtlAplyEndDd" maxLength="50" label="L00908" labelClass="1" conClass="3" required="true"/>
	 	</div>
	</div>
</div>

<div class="pop_btn_area">
 	<ifvm:inputNew type="button" btnType="save"  text="L00074"  id="adjustInfoPointBtn" btnFunc="saveAdjustInfoPointFn"/>
 	<ifvm:inputNew type="button"   text="L00913"  id="closePopAdjustPointPopBtn" btnFunc="closePopAdjustPointPopFn"/>
</div>
