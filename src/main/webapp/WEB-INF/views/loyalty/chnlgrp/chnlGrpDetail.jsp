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
        <spring:message code="채널군"/>
        &gt;  <spring:message code="상세"/>
    </h1>
</div>
<div>
	<div class="page_btn_area" id="headForm">
	    <div class="col-xs-7">
	    	<!-- 채널군 기본정보 -->
	        <span><spring:message code="채널군 기본정보"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	    	<!-- 저장버튼 -->
	        <ifvm:inputNew type="button" id="goSave" btnFunc="getChnlGrpDetail.save" text="I00745" objCode="chnlGrpDetailSave_OBJ"/>
	        <!-- 목록 버튼 -->
			<ifvm:inputNew type="button" id="goTermsList" btnFunc="getChnlGrpDetail.goList" text="L00824" objCode="chnlGrpDetailList_OBJ"/>
	    </div>
	</div>
	
	<div class="form-horizontal underline top_well" id="ChnlDetailForm" >
		<!-- 채널군  -->
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="채널군"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="text" disabled="true" id="tgtGrpNo" dto="tgtGrpNo"/>
			</div>
			<div class="col-xs-9 control_content">
				<ifvm:inputNew type="text"  required="true" id="tgtGrpNm" dto="tgtGrpNm"/>
			</div>
		</div>
		<!-- 설명 -->
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="설명"/></label>
			<div class="col-xs-11 control_content">
				<ifvm:inputNew type="textarea"  id="descText" dto="descText" rows="4"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<!-- 유형 -->
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="유형"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="select" required="true" id="tgtTypeCd" dto="tgtTypeCd" names="tgtTypeCd"/>
			</div>
			<!-- 상태 -->
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="상태"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="select" required="true" id="statCd" dto="statCd" names="statCd"/>
			</div>
		</div>
		<!-- 조건 데이터 set -->
		<div class="row qt_border" id="conDiv">
			
			
		</div>
		
		</div>
</div>

<div id="chnlGrpDetailTabArea"></div>
<div id="datasetListPop" class="popup_container"></div>

<script id="conDivTmpl" type="text/x-jquery-tmpl">
	<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="조건 데이터 Set"/></label>
			<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" maxLength="15" id="dsNm" disabled="true" required="true" dto="dsNm" names="dsNm"/>
				<span class="input-group-addon" id="targetGroupPopBtn" onclick="targetGroupPopup()">
							<a><i class="fa fa-search"></i></a>
				</span>
			</div>
			</div>         			
</script>



<script>
var chnlGrpDetailTabArea = $('#chnlGrpDetailTabArea').DrawTab({
	item: items
	/* [
		{label: '채널', href: '<ifvm:url name="chnlGrpItemList"/>'}, 
		{label: '제외채널', href: '<ifvm:url name="chnlGrpExcList"/>'},  
	] */
});

var chnlGrp_Rid = '<%= cleanXss(request.getParameter("rid")) %>';
chnlGrp_Rid = chnlGrp_Rid == 'null' ? null : chnlGrp_Rid;
var chnlGrpDetail_isNew = true;  //신규 여부. 신규: true, 수정 : false
var statCd=null;
var chnlDatasetRid = null;
var getChnlGrpDetail={
		init : function(){
			$.fn.ifvmSetSelectOptionCommCode("tgtTypeCd", "PROM_TG_TYPE", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("statCd", "COM_STAT_TYPE_2_CD", "W");
			$.fn.ifvmSetSelectOptionCommCode("conFld", "PROM_CHNL_COND_TYPE", null,null,true);
	    	if (chnlGrp_Rid === null){
	    		statCd = 'W';
	    		$("#statCd").attr("disabled", true);
	    		chnlGrpDetail_isNew = true;
	    		chnlGrpDetailTabArea.disabledTab([0]);
	    	}
			else
				chnlGrpDetail_isNew = false;
			if (!chnlGrpDetail_isNew) {
				$.ifvSyncPostJSON('<ifvm:action name="getChnlGrpDetail"/>', {
					rid : chnlGrp_Rid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#ChnlDetailForm").dataSetting(result);
						chnlGrpChange();
						$("#dsNm").val(result.dsNm);
						chnlDatasetRid = result.dsRid;
						statCd = result.statCd;
						if (result.statCd == "W") {
							$("#tgtGrpNm").attr("disabled", false);
							$("#descText").attr("disabled", false);
							$("#tgtTypeCd").attr("disabled", false);
							$("#statCd").attr("disabled", false);
							$("#conFld").attr("disabled", false);
							$("#conVal").attr("disabled", false);
						} else {
							$("#tgtGrpNm").attr("disabled", true);
							$("#descText").attr("disabled", true);
							$("#tgtTypeCd").attr("disabled", true);
							$("#statCd").attr("disabled", false);
							$("#conFld").attr("disabled", false);
							$("#conVal").attr("disabled", false);
						}
						
					}
				}, function(result) {
					alert(result.message);
				});
			}
		},//INIT END
		save : function(){
			var validation = $("#ChnlDetailForm").ifvValidation();
			
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
				var url = chnlGrpDetail_isNew? '<ifvm:action name="saveChnlGrpDetail"/>' : '<ifvm:action name="modifyChnlGrpDetail"/>';
				var varData = null;
				varData = $("#ChnlDetailForm").getSubmitData();
				varData.rid = chnlGrp_Rid;
				varData.dsRid = chnlDatasetRid;
				$.ifvSyncPostJSON(url, varData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
						if(chnlGrpDetail_isNew) qtjs.href('<ifvm:url name="chnlGrpDetail"/>'+'?rid='+result.rid);
						qtjs.href('<ifvm:url name="chnlGrpDetail"/>'+'?rid='+chnlGrp_Rid);
					}
				}, function(result) {
					alert("<spring:message code="M02248" />");
				});
			 }
		},//SAVE END
		goList : function(){
			qtjs.href('<ifvm:url name="chnlGrpList"/>');
		}
}

function targetGroupPopup() {
	$("#datasetListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="dsPop"/>',
        contentType: "ajax",
        title: '데이터셋 조회',
        width: 1000,
        close : 'targetGroupClosePop'
	});
}

function targetGroupClosePop() {
	targetGroupPop._destroy();
}

function chnlGrpChange() {
	if($("#tgtTypeCd").val()=='CON') {
		var temp = $("#conDivTmpl").tmpl();
	    $("#conDiv").append(temp);
	} else if($("#tgtTypeCd").val()=='FIX') {
		chnlDatasetRid=null;
		$("#conDiv").empty();
		
		
	} 
}


$(document).ready(function() {
	
	getChnlGrpDetail.init();	
	
	
	$('#tgtTypeCd').change(function(){
		chnlGrpChange();

	});

});

</script>