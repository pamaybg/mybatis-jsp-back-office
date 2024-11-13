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
        <spring:message code="프로모션 반응"/>
        &gt;  <spring:message code="상세"/>
    </h1>
</div>
<div>
	<div class="page_btn_area" id="headForm">
	    <div class="col-xs-7">
	    	<%-- 채널 상세 --%>
	        <span><spring:message code="프로모션 반응 상세"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="goTermsList" btnFunc="getPromReactDetail.goList" text="L00824" objCode="promReactDetailList_OBJ"/>
	    </div>
	</div>
	
	<div class="form-horizontal underline top_well" id="promReactDetailForm" >
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><spring:message code="프로모션"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="text" disabled="true" id="promNo" dto="promNo"/>
			</div>
			<div class="col-xs-8 control_content">
				<ifvm:inputNew type="text"  disabled="true" id="promNm" dto="promNm"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="설명"/></label>
			<div class="col-xs-10 control_content">
				<ifvm:inputNew type="textarea" disabled="true"  id="descText" dto="descText" rows="4"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="대유형"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:inputNew type="select" disabled="true" id="promTypeLv1Cd" dto="promTypeLv1Cd" names="promTypeLv1Cd"/>
			</div>
			
			<label class="col-xs-2 control-label"><spring:message code="소유형"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:inputNew type="select" disabled="true" id="promTypeLv2Cd" dto="promTypeLv2Cd" names="promTypeLv2Cd"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="기간"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="text" disabled="true" id="validStartDate" dto="validStartDate"/>
			</div>
			<div style="float: left">~</div>
			<ifvm:inputNew type="text" disabled="true" id="validEndDate" conClass="2" dto="validEndDate"/>
			
			<label class="col-xs-2 control-label"><spring:message code="오퍼"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="text" disabled="true" id="ofrNo" dto="ofrNo"/>
			</div>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="text"  disabled="true" id="ofrNm" dto="ofrNm"/>
			</div>
		</div>
		
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="KPI유형"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:inputNew type="select" id="kpiDateTypeCd" disabled="true" dto="kpiDateTypeCd" names="kpiDateTypeCd"/>
			</div>
			
			<label class="col-xs-2 control-label"><spring:message code="KPI 측정 결과"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:inputNew type="text" className="text-right"  id="respAmt" disabled="true" dto="respAmt" names="respAmt"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="측정일시"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:inputNew type="text" id="respLastDate" className="text-right" disabled="true" dto="respLastDate" names="respLastDate"/>
			</div>
			
			<label class="col-xs-2 control-label"><spring:message code="대조군 값"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:inputNew type="text" className="text-right"  id="respCtrlAmt" disabled="true" dto="respCtrlAmt" names="respCtrlAmt"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="총비용"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:inputNew type="text" id="respTotCost" className="text-right" disabled="true" dto="respTotCost" names="respTotCost"/>
			</div>
			
			<label class="col-xs-2 control-label"><spring:message code="총매출액"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:inputNew type="text" className="text-right"  id="respTotSales" disabled="true" dto="respTotSales" names="respTotSales"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="대상고객수"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:inputNew type="text" id="respTotTgt" className="text-right" disabled="true" dto="respTotTgt" names="respTotTgt"/>
			</div>
			
			<label class="col-xs-2 control-label"><spring:message code="반응고객수"/></label>
			<div class="col-xs-4 control_content">
				<ifvm:inputNew type="text" className="text-right"  id="respTotResp" disabled="true" dto="respTotResp" names="respTotResp"/>
			</div>
		</div>
		
		</div>
</div>

<div id="promReactionDetailTabArea"></div>
<div id="targetGroupPop" class="popup_container"></div>
<script>
var promReactionDetailTabArea = $('#promReactionDetailTabArea').DrawTab({
	item: items
	/* [
		{label: '반응 고객', href: '<ifvm:url name="promMbrCalc"/>'},
	] */
});

var promRea_Rid = '<%= cleanXss(request.getParameter("rid")) %>';
var ridProm = '<%= cleanXss(request.getParameter("ridProm")) %>';
promRea_Rid = promRea_Rid == 'null' ? null : promRea_Rid;
var amtFieldId = new Array(); //배열선언
var promRid = null;
amtFieldId = [ 'respTotCost', 'respTotSales', 'respTotTgt', 'respTotResp'];
var getPromReactDetail={
		init : function(){
			 //캠페인상태
		    $.fn.ifvmSetSelectOptionCommCode("promTypeLv1Cd", "PROM_TYPE_LV1",null,null,true);

		    //조직
		    $.fn.ifvmSetSelectOptionCommCodeSync("promTypeLv2Cd", "PROM_TYPE_LV2", null, "promTypeLv1Cd", true);
		    
		    $.fn.ifvmSetSelectOptionCommCode("kpiDateTypeCd", "PROM_KPI_TYPE",null,null,true);

			
				$.ifvSyncPostJSON('<ifvm:action name="getPromReactDetail"/>', {
					rid : promRea_Rid,
					promRid : ridProm
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#promReactDetailForm").dataSetting(result);
						
						$.fn.ifvmSetSelectOptionCommCode("promTypeLv1Cd", "PROM_TYPE_LV1",null,null,true);
						$("#promTypeLv1Cd").val(result.promTypeLv1Cd);
						
						$.fn.ifvmSetSelectOptionCommCodeSync("promTypeLv2Cd", "PROM_TYPE_LV2", $("#promTypeLv1Cd").val(), "promTypeLv1Cd", false);
						$("#promTypeLv2Cd").val(result.promTypeLv2Cd);
						$("#kpiDateTypeCd").val(result.kpiDateTypeCd);
					    $.fn.ifvmSetSelectOptionCommCode("kpiDateTypeCd", "PROM_KPI_TYPE",$("#kpiDateTypeCd").val(),null,true);
						promRid = result.promRid;
					    pointComma();
					    
					    if(result.respAmt!=null) {
							$("#respAmt").val(result.respAmt+"%");
						}
					    if(result.respCtrlAmt!=null) {
							$("#respCtrlAmt").val(result.respCtrlAmt+"%");
						}
					    
					}
				}, function(result) {
					alert(result.message);
				});
		},//INIT END
		goList : function(){
			qtjs.href('<ifvm:url name="promReactionList"/>');
		}
}

function pointComma() {

	for (var pi = 0; pi < amtFieldId.length; pi++) {
		var _pval = $("#" + amtFieldId[pi]).val();
		var _aval = "";
		if (_pval) {
			_aval = (_pval.split(".")[0]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		$("#" + amtFieldId[pi]).val(_aval);
	}
}

$(document).ready(function() {
	
	getPromReactDetail.init();

});

</script>