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
<div class="page-title">
    <h1>
        <spring:message code="고객군"/>
        &gt;  <spring:message code="상세"/>
    </h1>
</div>
<div>
	<div class="page_btn_area" id="headForm">
	    <div class="col-xs-7">
	    	<%-- 채널 상세 --%>
	        <span><spring:message code="고객군 기본정보"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	        <ifvm:inputNew type="button" id="goSave" btnFunc="getTgtGrpDetail.save" text="I00745" objCode="tgtGrpDetailSave_OBJ"/>
			<ifvm:inputNew type="button" id="goTermsList" btnFunc="getTgtGrpDetail.goList" text="L00824" objCode="tgtGrpDetailList_OBJ"/>
	    </div>
	</div>
	
	<div class="form-horizontal underline top_well" id="tgtGrpDetailForm" >
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="고객군"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="text" disabled="true" id="tgtGrpNo" dto="tgtGrpNo"/>
			</div>
			<div class="col-xs-9 control_content">
				<ifvm:inputNew type="text"  required="true" id="tgtGrpNm" dto="tgtGrpNm"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="설명"/></label>
			<div class="col-xs-11 control_content">
				<ifvm:inputNew type="textarea"  id="descText" dto="descText" rows="4"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="유형"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="select" required="true" maxLength="15" id="tgtTypeCd" dto="tgtTypeCd" names="tgtTypeCd"/>
			</div>
			
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="상태"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="select" required="true" id="statCd" dto="statCd" names="statCd"/>
			</div>
		</div>
		
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="출처"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="select" maxLength="15" required="true" id="srcTypeCd" dto="srcTypeCd" names="srcTypeCd"/>
			</div>
			
			<label class="col-xs-3 control-label"><spring:message code="외부 관리번호"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="text" disabled="true" id="refVal" dto="refVal"/>
			</div>
		</div>
		
		<div class="row qt_border" id="conDiv">
			
			
		</div>
		
		</div>
</div>

<div id="tgtGrpDetailTabArea"></div>
<div id="datasetListPop" class="popup_container"></div>

<script id="conDivTmpl" type="text/x-jquery-tmpl">
	<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="조건 데이터 Set"/></label>
			<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" maxLength="15" id="conView" required="true" disabled="true" dto="conView" names="conView"/>
				<span class="input-group-addon" id="targetGroupPopBtn" onclick="targetGroupPopup()">
							<a><i class="fa fa-search"></i></a>
				</span>
			</div>
			</div>        			
</script>

<script>
var tgtGrpDetailTabArea = $('#tgtGrpDetailTabArea').DrawTab({
	item: items
	/* [
		{label: '고객목록', href: '<ifvm:url name="tgtGrpXmList"/>'},  
	] */
});

var tgtGrp_Rid = '<%= cleanXss(request.getParameter("rid")) %>';
tgtGrp_Rid = tgtGrp_Rid == 'null' ? null : tgtGrp_Rid;
var tgtGrpDetail_isNew = true;  //신규 여부. 신규: true, 수정 : false
var statCd=null;
var targetGroupRid=null;
var datasetRid=null;
var getTgtGrpDetail={
		init : function(){
			$.fn.ifvmSetSelectOptionCommCode("tgtTypeCd", "PROM_TG_TYPE", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("statCd", "COM_STAT_TYPE_2_CD", "W");
			$.fn.ifvmSetSelectOptionCommCode("srcTypeCd", "PROM_TG_SRC_TYPE", null, null, true);
			$("#conView").attr("disabled", true);
	    	if (tgtGrp_Rid === null){
	    		statCd = 'W';
	    		$("#statCd").attr("disabled", true);
	    		tgtGrpDetail_isNew = true;
	    		tgtGrpDetailTabArea.disabledTab([0]);
	    	}
			else
				tgtGrpDetail_isNew = false;
			if (!tgtGrpDetail_isNew) {
				$.ifvSyncPostJSON('<ifvm:action name="getTgtGrpDetail"/>', {
					rid : tgtGrp_Rid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#tgtGrpDetailForm").dataSetting(result);
						tgtGrpChange();
						$("#conView").val(result.conView);
						datasetRid = result.dsRid;
						statCd = result.statCd;
						if (result.statCd == "W") {
							$("#tgtTypeCd").attr("disabled", false);
						} else {
							$("#tgtTypeCd").attr("disabled", true);
						}
					}
				}, function(result) {
					alert(result.message);
				});
			}
		},//INIT END
		save : function(){
			var validation = $("#tgtGrpDetailForm").ifvValidation();
			
			if(statCd == 'A') {
			if($('#statCd').val()=='W') {
				alert("작성중으로 돌아갈수 없습니다.");
				return;
				}
			} else if(statCd == 'S') {
			if($('#statCd').val()=='W') {
				alert("작성중으로 돌아갈수 없습니다.");
				return;
				}
			} else if(statCd == 'W') {
			if($('#statCd').val()=='S') {
				alert("작성중에서 중지로 돌아갈수 없습니다.");
				return;
				}
			}
			
			//유효성 체크
			if(validation.confirm()){
				var url = tgtGrpDetail_isNew? '<ifvm:action name="saveTgtDetail"/>' : '<ifvm:action name="modifyTgtDetail"/>';
				var varData = null;
				varData = $("#tgtGrpDetailForm").getSubmitData();
				varData.rid = tgtGrp_Rid;
				varData.dsRid = datasetRid;
				
				$.ifvSyncPostJSON(url, varData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
						if(tgtGrpDetail_isNew) qtjs.href('<ifvm:url name="tgtGrpDetail"/>'+'?rid='+result.rid);
						qtjs.href('<ifvm:url name="tgtGrpDetail"/>'+'?rid='+tgtGrp_Rid);
					}
				}, function(result) {
					alert("<spring:message code="M02248" />");
				});
			 }
		},//SAVE END
		goList : function(){
			qtjs.href('<ifvm:url name="targetGrpList"/>');
		}
}
 
function targetGroupPopup() {
	$("#datasetListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="dsPop"/>',
        contentType: "ajax",
        title: '데이터셋 조회',
        width: 680,
        close : 'targetGroupClosePop'
	});
}

function targetGroupClosePop() {
	datasetListPop._destroy();
}

function tgtGrpChange() {
	if($("#tgtTypeCd").val()=='CON') {
		var temp = $("#conDivTmpl").tmpl();
	    $("#conDiv").append(temp);
	} else if($("#tgtTypeCd").val()=='FIX') {
		chnlDatasetRid=null;
		$("#conDiv").empty();
		
		
	} 
}

$(document).ready(function() {
	
	getTgtGrpDetail.init();

	
	$('#tgtTypeCd').change(function(){
		tgtGrpChange();

	});
	

});

</script>