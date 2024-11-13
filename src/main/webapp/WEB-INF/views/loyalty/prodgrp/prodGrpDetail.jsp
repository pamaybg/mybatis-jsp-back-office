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
        <spring:message code="상품군"/>
        &gt;  <spring:message code="상세"/>
    </h1>
</div>
<div>
	<div class="page_btn_area" id="headForm">
	    <div class="col-xs-7">
	    	<%-- 채널 상세 --%>
	        <span><spring:message code="상품군 기본정보"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	        <ifvm:inputNew type="button" id="goSave" btnFunc="getProdGrpDetail.save" text="I00745" objCode="prodGrpDetailSave_OBJ"/>
			<ifvm:inputNew type="button" id="goTermsList" btnFunc="getProdGrpDetail.goList" text="L00824" objCode="prodGrpDetailList_OBJ"/>
	    </div>
	</div>
	
	<div class="form-horizontal underline top_well" id="tgtProdDetailForm" >
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="상품군"/></label>
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
				<ifvm:inputNew type="textarea" id="descText" dto="descText" rows="4"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="유형"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="select" required="true" maxLength="15" id="tgtTypeCd" dto="tgtTypeCd" names="tgtTypeCd"/>
			</div>
			
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="상태"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="select" required="true" maxLength="15" id="statCd" dto="statCd" names="statCd"/>
			</div>
		</div>
		
		</div>
</div>

<div id="prodGrpDetailTabArea"></div>

<script>
var prodGrpDetailTabArea = $('#prodGrpDetailTabArea').DrawTab({
	item: items
	/* [
		{label: '상품', href: '<ifvm:url name="prodGrpItemList"/>'},  
		{label: '카테고리', href: '<ifvm:url name="prodGrpCategoryList"/>'},  
	] */
});

var prodGrp_Rid = '<%= cleanXss(request.getParameter("rid")) %>';
prodGrp_Rid = prodGrp_Rid == 'null' ? null : prodGrp_Rid;
var prodGrpDetail_isNew = true;  //신규 여부. 신규: true, 수정 : false
var statCd=null;
var tgtTypeCd = null;
var getProdGrpDetail={
		init : function(){
			$.fn.ifvmSetSelectOptionCommCode("tgtTypeCd", "PROM_PROD_GRP_TYPE", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("statCd", "COM_STAT_TYPE_2_CD", "W");
	    	if (prodGrp_Rid === null){
	    		statCd = 'W';
	    		$("#statCd").attr("disabled", true);
	    		prodGrpDetail_isNew = true;
	    		prodGrpDetailTabArea.disabledTab([0,1]);
	    	}
			else
				prodGrpDetail_isNew = false;
			if (!prodGrpDetail_isNew) {
				$.ifvSyncPostJSON('<ifvm:action name="getProdGrpDetail"/>', {
					rid : prodGrp_Rid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#tgtProdDetailForm").dataSetting(result);
						tgtTypeCd = result.tgtTypeCd;
						statCd = result.statCd;
						if(result.tgtTypeCd == 'P') {
							prodGrpDetailTabArea.disabledTab([1]);
							//prodGrpDetailTabArea.moveTabIndex(0);
						} else if (result.tgtTypeCd == 'C') {
							prodGrpDetailTabArea.disabledTab([0]);
							//prodGrpDetailTabArea.moveTabIndex(1);
						}
						
						if (result.statCd == "W") {
							$("#tgtGrpNm").attr("disabled", false);
							$("#descText").attr("disabled", false);
							$("#tgtTypeCd").attr("disabled", false);
							$("#statCd").attr("disabled", false);
						} else {
							$("#tgtGrpNm").attr("disabled", true);
							$("#descText").attr("disabled", true);
							$("#tgtTypeCd").attr("disabled", true);
							$("#statCd").attr("disabled", false);
						}
					}
				}, function(result) {
					alert(result.message);
				});
			}
		},//INIT END
		save : function(){
			var validation = $("#tgtProdDetailForm").ifvValidation();
			
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
				var url = prodGrpDetail_isNew? '<ifvm:action name="saveProdGrpDetail"/>' : '<ifvm:action name="modifyProdGrpDetail"/>';
				var varData = null;
				varData = $("#tgtProdDetailForm").getSubmitData();
				varData.rid = prodGrp_Rid;

				$.ifvSyncPostJSON(url, varData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
						if(prodGrpDetail_isNew) qtjs.href('<ifvm:url name="prodGrpDetail"/>'+'?rid='+result.rid);
						qtjs.href('<ifvm:url name="prodGrpDetail"/>'+'?rid='+prodGrp_Rid);
					}
				}, function(result) {
					alert("<spring:message code="M02248" />");
				});
			 }
		},//SAVE END
		goList : function(){
			qtjs.href('<ifvm:url name="prodGrpList"/>');
		}
}


$(document).ready(function() {
	
	getProdGrpDetail.init();
	
	$("#tgtTypeCd").change(function(){
		if($("#sellAmtOfrYn").val() == "CON") {
			$("#conView").attr("disabled",true);
		}
	});
	
	

});

</script>