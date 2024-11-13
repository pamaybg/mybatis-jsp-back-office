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

var useInfoValid;
var pntUseRid =  '<%= cleanXss(request.getParameter("pntUseRid")) %>';
function setValidCalendar() {
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

function pntUseInfoDtlSetting(){
	if(pntUseRid!="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getPntUseInfo"/>',{rid : pntUseRid} ,function(result) {
			$("#pointUseInfoPopForm").dataSetting(result);
			if(result.dtlActiveYn=="Y"){
				$("#dtlActiveYn").attr("checked",true);
			}
	 		numberFormatterSetting();
		});
	}
}

function numberFormatterSetting (){
	var numFormatVal=$("#dtlGrntMinAmt").val();
	$("#dtlGrntMinAmt").ifvNumberOnly();
	$("#dtlGrntMinAmt").val(numberWithCommas(numFormatVal));
	
}
function saveUsePointInfoFn(){
	useInfoValid = $("#pointUseInfoPopForm").ifvValidation();
	if(useInfoValid.confirm()==true){
		var submitData =$("#pointUseInfoPopForm").getSubmitData();
		submitData.itemType="USE";
		submitData.pntBasRuleRid=testViewList_rid;
		var startDd = submitData.dtlAplyStartDd.split("-")[0]+ submitData.dtlAplyStartDd.split("-")[1]+  submitData.dtlAplyStartDd.split("-")[2];
		var endDd = submitData.dtlAplyEndDd.split("-")[0]+ submitData.dtlAplyEndDd.split("-")[1]+  submitData.dtlAplyEndDd.split("-")[2];
		submitData.dtlAplyStartDd = startDd
		submitData.dtlAplyEndDdDd = endDd
		
		if($("#dtlActiveYn").prop("checked")){
			submitData.dtlActiveYn="Y"	;	
		}else{
			submitData.dtlActiveYn="N";
		}
		if(pntUseRid =="null"){
		 	$.ifvSyncPostJSON('<ifvm:action name="insertPointItem"/>',submitData ,function(result) {
				alert('<spring:message code="L00127"/>');
				pointUseList.requestData();
				pointUseInfoPop.close();
			},function(result){
				alert(result.message);
			});
		}else{
			submitData.rid = pntUseRid;
			submitData.pntBaseRuleId =  testViewList_rid
		 	$.ifvSyncPostJSON('<ifvm:action name="updatePointUseItem"/>',submitData ,function(result) {
				alert('<spring:message code="L00127"/>');
				pointUseList.requestData();
				pointUseInfoPop.close();
			},function(result){
				alert(result.message);
			});
			submitData.rid =  pntUseRid;
		}
	
	}
	 
}
function closeUsePointInfoFn(){
	pointUseInfoPop.close();
}

$(document).ready(function() {
	numberFormatterSetting();
	setValidCalendar();
	pntUseInfoDtlSetting();
	
});

</script>





<div id="pointUseInfoPopForm" >
	<div class="form-horizontal underline top_well" >

		 	<div class="row  qt_border">
		    <ifvm:inputNew type="text" id="dtlGrntMinAmt"   dto="dtlGrntMinAmt"   label="L00915" labelClass="2" conClass="3"  required="true" />
		    <label class="col-xs-2 control-label"><spring:message code="L00906"/></label>
  			<div class="col-xs-2 control_content">
				<input type="checkbox"  id="dtlActiveYn" />
  			</div> 
	 	</div>
	 	
	 	<div class="row  qt_border">
	    <ifvm:inputNew type="date" id="dtlAplyStartDd" dto="dtlAplyStartDd" maxLength="50" label="L00907" labelClass="2" conClass="3" required="true"  />
    	    <ifvm:inputNew type="date" id="dtlAplyEndDd" dto="dtlAplyEndDd" maxLength="50" label="L00908" labelClass="2" conClass="3" />
	 	</div>
	</div>
</div>

<div class="pop_btn_area">
 	<ifvm:inputNew type="button" btnType="save"  text="L00074"  id="saveUsePointInfoBtn" btnFunc="saveUsePointInfoFn"/>
 	<ifvm:inputNew type="button"   text="L00913"  id="closeUsePointInfoBtn" btnFunc="closeUsePointInfoFn"/>
</div>
