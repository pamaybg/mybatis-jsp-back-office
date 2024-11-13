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
        <spring:message code="이상거래정책"/>
        &gt;  <spring:message code="M00169"/>
    </h1>
</div>
<div>
	<div class="page_btn_area" id="headForm">
	    <div class="col-xs-7">
	    	<%-- 채널 상세 --%>
	        <span><spring:message code="기본정보"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	        <ifvm:inputNew type="button" id="goSave" btnFunc="blackRuleDetail.save" text="I00745" objCode="blackRuleDetailSave_OBJ"/>
			<ifvm:inputNew type="button" id="goTermsList" btnFunc="blackRuleDetail.goList" text="L00824" objCode="blackRuleDetailList_OBJ"/>
	    </div>
	</div>
	
	<div class="form-horizontal underline top_well" id="blackRuleDetailForm">
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><spring:message code="이상거래번호"/></label>
			<div class="col-xs-5 control_content">
				<ifvm:inputNew type="text" disabled="true" id="blCd" dto="blCd"/>
			</div>
			
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="이상거래명"/></label>
			<div class="col-xs-5 control_content">
				<ifvm:inputNew type="text" id="blNm" dto="blNm" required="true"/>
			</div>
			
		</div>
		
		<div class="row  qt_border">
			
		<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="유형"/></label>
			<div class="col-xs-5 control_content">
				<ifvm:inputNew type="select" id="fraudTypeCd" dto="fraudTypeCd" names="fraudTypeCd" required="true"/>
			</div>
			
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="세부유형"/></label>
			<div class="col-xs-5 control_content">
				<ifvm:inputNew type="select" id="fraudSubTypeCd" dto="fraudSubTypeCd" names="fraudSubTypeCd" required="true"/>
			</div>
	
		</div>
		
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="상태"/></label>
			<div class="col-xs-5 control_content">
				<ifvm:inputNew type="select" id="statCd" dto="statCd" names="statCd" required="true"/>
			</div>
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="로열티프로그램"/></label>
			<div class="col-xs-5 control_content">
			    <div class="input-group">
				<ifvm:input type="text" disabled="true" id="pgmNm" dto="pgmNm" required="true"/>
				<span class="input-group-addon" id="pgmPopBtn">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>
		<ifvm:inputNew type="hidden" id="loyPgmRid" conClass="1"  disabled="true"/>
	
		</div>
		
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><spring:message code="관리자알림 여부"/></label>
			<div class="col-xs-5 control_content">
				<ifvm:input type="checkbox"  id="mgtAlertYn" dto="mgtAlertYn"/>
			</div>
	
		</div>
		
		</div>
		<div class="page_btn_area">
				<div class="col-xs-2">
					<span><spring:message code="제한정책" /></span>
				</div>
			<div class="col-xs-10 searchbtn_r"></div>
		</div>
		<br>
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><spring:message code="제한일수 여부"/></label>
			<div class="col-xs-5 control_content">
				<ifvm:input type="checkbox"  id="dayLimitYn" dto="dayLimitYn"/>
			</div>
			<label class="col-xs-1 control-label"><spring:message code="유지개월수"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:input type="number"  id="periodMm" disabled="true" dto="periodMm"/>
			</div>
			<div style="float: left">월(등재일로부터N개월)</div>
		</div>
		
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><spring:message code="포인트사용제한"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:input type="checkbox"  id="pntRomLimitYn" dto="pntRomLimitYn" />
			</div>
			<label class="col-xs-1 control-label"><spring:message code="포인트적립제한"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:input type="checkbox"  id="pntAcrlLimitYn" dto="pntAcrlLimitYn"/>
			</div>
			<label class="col-xs-1 control-label"><spring:message code="쿠폰제한"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:input type="checkbox" id="coupUsedLimitYn" dto="coupUsedLimitYn"/>
			</div>
			<label class="col-xs-1 control-label"><spring:message code="할인적용제한"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:input type="checkbox" id="salesLimitYn" dto="salesLimitYn"/>
			</div>
		</div>
		
		<div class="row qt_border">
				<label class="col-xs-1 control-label"><spring:message code="설명"/></label>
				<div class="col-xs-10 control_content">
					<ifvm:inputNew type="textarea" maxLength="150" id="contents" dto="contents" labelClass="2" conClass="15" rows="5"/>
				</div>
			</div> 
</div>

<div id="blackRuleDetailTabArea"></div>

<div id="pgmPop" class="popup_container"></div>

<script>
var statCd = null;
var periodMm = null;
var blackRuleDetailTabArea = $('#blackRuleDetailTabArea').DrawTab({
	item: items
	/* [
		{label: '<spring:message code="이상거래룰"/> ', href: '<ifvm:url name="blackRuleList"/>'},  
		{label: '<spring:message code="이상거래대상자"/> ', href: '<ifvm:url name="blackMbrList"/>'},  
	] */
});
var blackRuleDetail_rid = '<%= cleanXss(request.getParameter("rid")) %>';
blackRuleDetail_rid = blackRuleDetail_rid == 'null' ? null : blackRuleDetail_rid;
var blackRuleDetail_isNew = true;  //신규 여부. 신규: true, 수정 : false
var pgmRid = null;
var blackRuleDetail={
		init : function(){
			$.fn.ifvmSetSelectOptionCommCode("statCd", "LOY_ACTIVE_CD", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("fraudTypeCd", "LOY_FRAUD_TYPE_CD", null, null, false);
			$.fn.ifvmSetSelectOptionCommCodeSync("fraudSubTypeCd", "LOY_FRAUD_SUB_TYPE_CD", null, "fraudTypeCd", false);
	    	if (blackRuleDetail_rid === null){
	    		blackRuleDetail_isNew = true;
	    		blackRuleDetailTabArea.disabledTab([0,1]);
	    	}
			else
				blackRuleDetail_isNew = false;
			if (!blackRuleDetail_isNew) {
				$.ifvSyncPostJSON('<ifvm:action name="getBlackRuleMstDetail"/>', {
					rid : blackRuleDetail_rid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#blackRuleDetailForm").dataSetting(result);
						$("#contents").val(result.contents);
						$("#periodMm").val(result.periodMm);
						$("#loyPgmRid").val(result.pgmRid);
                        $.fn.ifvmSetSelectOptionCommCodeSync("fraudSubTypeCd", "LOY_FRAUD_SUB_TYPE_CD", $("#fraudSubTypeCd").val(), "fraudTypeCd", false);
                        $("#fraudSubTypeCd").val(result.fraudSubTypeCd);
						periodMm = result.periodMm;
						statCd = result.statCd;
						
						if(result.dayLimitYn=='Y'){
							 $("#periodMm").attr("disabled",false);
					     }else{
					        $("#periodMm").attr("disabled",true);
					        $("#periodMm").val('');
					     }
						
						if(result.dayLimitYn=='Y')
			        		$("input:checkbox[id='dayLimitYn']").attr("checked", true);
			        	if(result.pntRdmLimitYn == 'Y')
			        		$("input:checkbox[id='pntRomLimitYn']").attr("checked", true);
			        	if(result.pntAcrlLimitYn == 'Y') 
			        		$("input:checkbox[id='pntAcrlLimitYn']").attr("checked", true);
			        	if(result.coupUsedLimitYn == 'Y') 
			        		$("input:checkbox[id='coupUsedLimitYn']").attr("checked", true);
			        	if(result.salesLimitYn == 'Y') 
			        		$("input:checkbox[id='salesLimitYn']").attr("checked", true);
			        	if(result.mgtAlertYn == 'Y') 
			        		$("input:checkbox[id='mgtAlertYn']").attr("checked", true);
					}
				}, function(result) {
					alert(result.message);
				});
			}
		},//INIT END
		save : function(){
			var validation = $("#blackRuleDetailForm").ifvValidation();
			
			//유효성 체크
			if(validation.confirm()){
				var url = blackRuleDetail_isNew? '<ifvm:action name="saveBlackRuleDetail"/>' : '<ifvm:action name="modifyBlackRuleDetail"/>';
				var varData = null;
				
				if($('input:checkbox[id="dayLimitYn"]').is(":checked") == true){
					dayLimitYn = 'Y'
				}else{
					dayLimitYn = 'N'
				}
				
				if($('input:checkbox[id="pntRomLimitYn"]').is(":checked") == true){
					pntRomLimitYn = 'Y'
				}else{
					pntRomLimitYn = 'N'
				}
				
				if($('input:checkbox[id="pntAcrlLimitYn"]').is(":checked") == true){
					pntAcrlLimitYn = 'Y'
				}else{
					pntAcrlLimitYn = 'N'
				}
				
				if($('input:checkbox[id="coupUsedLimitYn"]').is(":checked") == true){
					coupUsedLimitYn = 'Y'
				}else{
					coupUsedLimitYn = 'N'
				}
				
				if($('input:checkbox[id="salesLimitYn"]').is(":checked") == true){
					salesLimitYn = 'Y'
				}else{
					salesLimitYn = 'N'
				}
				if($('input:checkbox[id="mgtAlertYn"]').is(":checked") == true){
					mgtAlertYn = 'Y'
				}else{
					mgtAlertYn = 'N'
				}
				
				varData = $("#blackRuleDetailForm").getSubmitData();
				varData.rid = blackRuleDetail_rid;
				varData.pgmRid = $("#loyPgmRid").val();
				varData.pntRdmLimitYn = pntRomLimitYn;
				varData.pntAcrlLimitYn = pntAcrlLimitYn;
				varData.coupUsedLimitYn = coupUsedLimitYn;
				varData.dayLimitYn = dayLimitYn;
				varData.periodMm   = $("#periodMm").val();
				varData.contents   = $("#contents").val();
				varData.salesLimitYn = salesLimitYn;
				varData.mgtAlertYn = mgtAlertYn;
				varData.fraudTypeCd = $("#fraudTypeCd").val();
				varData.fraudSubTypeCd = $("#fraudSubTypeCd").val();

				$.ifvSyncPostJSON(url, varData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
						qtjs.href('<ifvm:url name="loyBlackTxnRuleList"/>');
					}
				}, function(result) {
					alert("<spring:message code="M02248" />");
				});
			 }
		},//SAVE END
		goList : function(){
			qtjs.href('<ifvm:url name="loyBlackTxnRuleList"/>');
		}
	}


function pgmPopup() {
	$("#pgmPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="programPgmPop"/>',
        contentType: "ajax",
        title: '로열티 프로그램 조회',
        width: 800,
        close : 'pgmClosePop'
	});
}
function pgmClosePop() {
	pgmPop._destroy();
}

$(document).ready(function() {
	
	blackRuleDetail.init();
	
	$('#pgmPopBtn').on('click', function(){
		pgmPopup();
	});
	
	 $("#dayLimitYn").change(function(){
		 if($("#dayLimitYn").is(":checked")){
			 $("#periodMm").attr("disabled",false);
	     }else{
	        $("#periodMm").attr("disabled",true);
	        $("#periodMm").val('');
	     }
	 });  
});

</script>

