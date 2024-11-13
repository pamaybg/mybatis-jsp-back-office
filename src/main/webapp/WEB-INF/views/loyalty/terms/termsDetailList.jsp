<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
    <h1>
    	<spring:message code="L02319" />
        &gt; <spring:message code="M00169" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-2">
	        <span><spring:message code="L02320"/></span>
	    </div>
	    <div class="col-xs-10 searchbtn_r">
	        <ifvm:inputNew type="button" btnType="check" id="goSave" btnFunc="getTermsDetail.save" text="I00745" objCode="termsDetailListSave_OBJ"/>
			<ifvm:inputNew type="button" id="goTermsList" btnFunc="getTermsDetail.goList" text="L00824" objCode="goTermsList_OBJ"/>
	    </div>
	</div>
	<div class="form-horizontal underline top_well" id="termsDetailForm">
		<div class="form-horizontal top_well underline" id="termsDetail">
			<br>
			<div class="row">
				<ifvm:inputNew type="select" id="termsType" names="termsType" dto="termsType" label="L02323" labelClass="1" conClass="2" required="true"/>
				<ifvm:inputNew type="select" id="termsTypeSub" names="termsTypeSub" dto="termsTypeSub" label="L02324" labelClass="1" conClass="3" required="true" />
				 <ifvm:inputNew type="text" id="termsNo" label="표시순서" labelClass="1" maxLength="1"  conClass="1" required="true" />
				
				<ifvm:inputNew type="select" id="statCd" names="statCd" dto="statCd" label="C00125" labelClass="1" conClass="1" required="true" />
				<ifvm:inputNew type="hidden" id="rid" names="rid" labelClass="1" conClass="1" />
				<a><i class="helpBtn" style="vertical-align: middle;">
		             <div class="helptxt" style="display:none;">
		             	<spring:message code="D10283"/>
		             </div>
	        </i></a>
	              	</div>
		</div>
		<br>
	</div>
</div>
<div id="termsDetailTabArea"></div>

<style>
   .helpBtn {
      background-image: url("/resources/images/icons/btn_help.png");
      background-repeat:no-repeat;
       background-position:center center;
       padding-left: 30px;
       vertical-align: middle;
       width: 17px;
       height: 17px;
       line-height: 17px;
   }
</style>

<script type="text/javascript">
var isNew = true;
var termsDetailTab;
var rid;
var realStatCd = null;
//var termsTypeOptionList = ["A","B","C","D"]
var getTermsDetail={
		init : function(){
			initTab();
			rid = $.ifvGetParam('rid');
			if (typeof rid === 'undefined'){
				isNew = true;
				//termsDetailTab.disabledTab([1]);	
				$.fn.ifvmSetSelectOptionCommCode("termsType", "LOY_TERMS_TYPE_CD", null, null, true);
				$.fn.ifvmSetSelectOptionNullParCodeId("termsTypeSub", "LOY_CUST_AGRE_TYPE_CD", null, null, true);
				$.fn.ifvmSetSelectOptionCommCode("statCd", "COM_STAT_TYPE_2_CD", 'W', null, true);
				$("#statCd").attr('disabled', true);				
			}
			else
				isNew = false;

			if (!isNew) {
				$.ifvSyncPostJSON('<ifvm:action name="getTermsDetail"/>', {
					rid : rid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#termsDetailForm").dataSetting(result);
						realStatCd = result.statCd;

						if(result.termsTypeSub != "C1"){
							termsDetailTab.disabledTab([1]);
						}
						if (result.statCd == "W") {
							$("#termsType").attr("disabled", false);
							$("#termsTypeSub").attr("disabled", false);
						} else {
							$("#termsType").attr("disabled", true);
							$("#termsTypeSub").attr("disabled", true);
						} 
						$.fn.ifvmSetSelectOptionCommCode("termsType", "LOY_TERMS_TYPE_CD", null, null, true);
						$("#termsType").val(result.termsType);
						$.fn.ifvmSetSelectOptionNullParCodeId("termsTypeSub", "LOY_CUST_AGRE_TYPE_CD", null, null, true);
						$("#termsTypeSub").val(result.termsTypeSub);
						$.fn.ifvmSetSelectOptionCommCode("statCd", "COM_STAT_TYPE_2_CD", null, null, true);
						$("#statCd").val(result.statCd);
						$("#termsNo").val(result.termsNo);
						$("#rid").val(rid);
					}
				}, function(result) {
					alert(result.message);
				});
			}
		},
		save : function(){
			var chekLoyPgmCnt = 0;
			rid = $.ifvGetParam('rid');
			if (typeof rid === 'undefined') isNew = true;
			else isNew = false;
			var tUrl = isNew? '<ifvm:action name="saveTermsList"/>' : '<ifvm:action name="modifyTermsList"/>';
			var tData = null;
			tData = {
					rid : $("#rid").val(),
					termsType : $("#termsType").val(),
					termsTypeSub : $("#termsTypeSub").val(),
					statCd : $("#statCd").val(),
					termsNo : $("#termsNo").val()
			};
			var validation = $("#termsDetail").ifvValidation();
			
			//수정
			if (!isNew){
				//작성중(약관 상태 확인)
				if($("#statCd").val() == 'W'){
					$.ifvSyncPostJSON('<ifvm:action name="validTermsStatCheck"/>', {
						rid : rid
					}, function(result) {
							saveTermsDetail(tUrl, tData,rid);
					}, function(result) {
						if(result.message != null) alert(result.message);
					});
				}
				//활성(프로그램 유무 확인)
				else if ($("#statCd").val() == 'A'){
					//최상위 버전 - 프로그램 유무 확인
					$.ifvSyncPostJSON('<ifvm:action name="validLoyaltyPgm"/>', {
						rid :$.ifvGetParam('rid')
					}, function(result) {
						if(result.cnt > 0){
							saveTermsDetail(tUrl, tData,rid);
						}else{
							alert('<spring:message code="D10280"/>');
						}
					}, function(result) {
						if(result.message != null) alert(result.message);
					});
				}
				//중지(프로그램 유무 확인X)
				else{
					saveTermsDetail(tUrl, tData,rid);
				}
			}
			//신규
			else{
					saveTermsDetail(tUrl, tData, rid);
			}
		},
		goList : function(){
			qtjs.href('<ifvm:url name="termsList"/>');
		}
}

function saveTermsDetail(tUrl, tData, rid){
	$.ifvSyncPostJSON(tUrl, tData
		, function(result) {
			if(result.rid != null) rid = result.rid;
			
			if ($.fn.ifvmIsNotEmpty(result)) {
				if(result.message =="dupSeq"){
					alert("동일한 표시순서가 존재합니다.");
				}else{
					if(result.message != null) alert(result.message);
					else alert("<spring:message code="L00076" />");
					qtjs.href('<ifvm:url name="termsDetailList"/>'+'?rid='+rid);
				}
			}
		}, function(result) {
			if(result.message != null) alert(result.message);
			else alert("<spring:message code="M02248" />");
	});
}

function initTab() {
	$("#termsDetailTabArea").empty();

	termsDetailTab = $("#termsDetailTabArea").DrawTab(
    {
    	 item: items
    	/* [
			{
               label: '<spring:message code="L02325"/>',
               href: '<ifvm:url name="termsVerList"/>'
			},
    		{
               label: '<spring:message code="L02687"/>',
               href: '<ifvm:url name="receiveChannelList"/>'
           }
        ] */
    });
}
 
$(document).ready(function() {
	
	getTermsDetail.init();
	
	$('.helpBtn').setupHelpMessage();
});
</script>
