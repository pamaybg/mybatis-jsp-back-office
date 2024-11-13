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
<script>
var rid = '<%= cleanXss(request.getParameter("rid")) %>';
var statSeq = '<%= cleanXss(request.getParameter("statSeq")) %>';

//저장 버튼클릭 시 동작
function actionSave() {
	
	
//	var _statCd = $("#mbrCardStatCd").val();
	
	
	$.ifvSyncPostJSON( '<ifvm:action name="editMbrCardStat"/>', 
			{
		   	   rid 	  :  rid
			  ,stat   :  $("#mbrCardStatCd").val()
	        }
			, function(result) {
				alert('<spring:message code="L00127"/>');
				mbrCardStatEditPopClose(true);
		    
	});
}


$(document).ready(function(){
	
	$("#btnConfirm").click(function(){
		actionSave();
    });
	
	$("#btnClosePop").click(function(){
		popupClose();
    });
	
});

</script>

<!-- 값 -->
<script id="mbrCardStatCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="well underline form-horizontal" id="validationArea" >			
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="L00090"/></label>
		<div class="col-xs-9 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="mbrCardStatCd" dto="mbrCardStatCd"  />
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button id="btnConfirm" class="btn btn-sm btn_gray">
		<spring:message code="L00437"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnClosePop"><spring:message code="L00124"/></button>
</div>

<script>

$(function(){
	
	//유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'LOY_CARD_MBR_STAT_CD'		
	    ,overSeq  : statSeq
		,enableNA : true
	},function(result) {
		var temp = $("#mbrCardStatCdTemp").tmpl(result.rows);
		$("#mbrCardStatCd").append(temp);
	});
	
	
});

</script>