<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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

var pastCamId = '<%=cleanXss(request.getParameter("id"))%>';
var dateFieldId = ['xRequestDt', 'xApproveDt', 'startDt', 'endDt', 'finalExecDt'];
function promotionDtlPopSetting(){
	$.ifvSyncPostJSON('<ifvm:action name="getPastCamPromoDtl"/>', {
		id : pastCamId
	}, function(result) {

		$("#promoDtlForm").dataSetting(result);
		var date  =  $("#xTrStartHour").val() + "~" +$("#xTrEndHour").val();
		$("#xTrHour").val(date);
		$($('#promoDtlForm').find('input')).each(function(index, item){
			if($(this).attr('type')=="checkbox"){
				if(result[$(item).attr('id')]=='Y'){
 	 				$(this).attr('checked', 'true');
 	 			}
			}
		});
		//데이트 타입 필드
		for(var pi = 0 ; pi < dateFieldId.length ; pi++){
			var _pval = $("#promoDtlForm [dtoparam='"+dateFieldId[pi]+"']").val();
			var _aval="";
			if(_pval){
				_aval = _pval.split(' ')[0];
			}
			$("#promoDtlForm [dtoparam='"+dateFieldId[pi]+"']").val(_aval);
		}
	});
}

$(document).ready(function() {
	promotionDtlPopSetting();
})
</script>


<div id="promoDtlForm">


<div class="form-horizontal underline top_well">
	<div class="half_wrap top_well">
		<div class="half_content half_left" id="approvalServerForm">
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02613" /></span>
				</div>
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="name" dto="name" label="M02619" labelClass="3" conClass="9" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="descText" dto="descText" label="M02620" labelClass="3" conClass="9" disabled="true" />
			</div>

			<div class="row">
	    	    <ifvm:inputNew type="date" id="startDt" dto="startDt" maxLength="50" label="M02621" labelClass="3" conClass="3" required="true" disabled="true" />
	    	    <ifvm:inputNew type="date" id="endDt" dto="endDt" maxLength="50" label="M02622" labelClass="3" conClass="3" required="true" disabled="true" />
			</div>


			<div class="row">
				<ifvm:inputNew type="text" id="xPriorityCdNm" dto="xPriorityCdNm" label="M02623" labelClass="3" conClass="3"  disabled="true"/>
	    	    <ifvm:inputNew type="date" id="finalExecDt" dto="finalExecDt" maxLength="50" label="M02624" labelClass="3" conClass="3" required="true" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="typeCdNm" dto="typeCdNm" label="M02625" labelClass="3" conClass="3"  disabled="true"/>
				<ifvm:inputNew type="text" id="alwaysApplyFlgNm" dto="alwaysApplyFlgNm" label="M02626" labelClass="3" conClass="3"  disabled="true"/>
			</div>


			<div class="row">
				<ifvm:inputNew type="text" id="xPromotionOwnerNm" dto="xPromotionOwnerNm" label="M02627" labelClass="3" conClass="3"  disabled="true"/>
				<ifvm:inputNew type="singleCheckbox" id="activeFlg" label="M02628" values="1" labelClass="1" conClass="1" checked="false" disabled="true" />
				<ifvm:inputNew type="singleCheckbox" id="xSegFlg" label="M02629" values="1" labelClass="3" conClass="1" checked="false" disabled="true" />
			</div>


			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02614" /></span>
				</div>
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="xCustTypeCdNm" dto="xCustTypeCdNm" label="M02630" labelClass="3" conClass="3"  disabled="true"/>
				<ifvm:inputNew type="text" id="xCustomerTierNm" dto="xCustomerTierNm" label="M02631" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="xCustSexCdNm" dto="xCustSexCdNm" label="M02632" labelClass="3" conClass="3"  disabled="true"/>
				<ifvm:inputNew type="text" id="xCustomerVipFlgNm" dto="xCustomerVipFlgNm" label="M02633" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="xAccumulationPoint" dto="xAccumulationPoint" label="M02634" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="xPointOperationNm" dto="xPointOperationNm" label="M02635" labelClass="3" conClass="3"  disabled="true"/>
			</div>




			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02615" /></span>
				</div>
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="xCustomerAnniversaryNm" dto="xCustomerAnniversaryNm" label="M02636" labelClass="3" conClass="3"  disabled="true"/>
				<ifvm:inputNew type="text" id="xAnniversaryOperationNm" dto="xAnniversaryOperationNm" label="M02637" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
	    	    <ifvm:inputNew type="date" id="xTransactionDate" dto="xTransactionDate" maxLength="50" label="M02638" labelClass="3" conClass="3" required="true" disabled="true" />
			</div>

		</div>

		<div class="half_content half_right">
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02616" /></span>
				</div>
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="txnSubTypeCdNm" dto="txnSubTypeCdNm" label="M02639" labelClass="3" conClass="3"  disabled="true"/>
	    	    <ifvm:inputNew type="date" id="xRequestDt" dto="xRequestDt" maxLength="50" label="M02640" labelClass="3" conClass="3" required="true" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="fstNameReq" dto="fstNameReq" label="M02641" labelClass="3" conClass="3" disabled="true" />
	    	    <ifvm:inputNew type="date" id="xApproveDt" dto="xApproveDt" maxLength="50" label="M02642" labelClass="3" conClass="3" required="true" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="recvEmail" dto="recvEmail" label="M02643" labelClass="3" conClass="3" disabled="true" />
	    	    <ifvm:inputNew type="date" id="xRejectDt" dto="xRejectDt" maxLength="50" label="M02644" labelClass="3" conClass="3" required="true" disabled="true" />
			</div>


			<div class="row">
				<ifvm:inputNew type="textarea" id="xRejectReason" maxLength="50" dto="xRejectReason" label="M02646" labelClass="3" conClass="3" disabled="true"  />
				<ifvm:inputNew type="text" id="fstNameReq" dto="fstNameReq" label="M02645" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="recvEmail" dto="recvEmail" label="M02647" labelClass="3" conClass="3" disabled="true" />
			</div>



			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02617" /></span>
				</div>
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="aliasName" dto="aliasName" label="M02648" labelClass="3" conClass="9" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="xPayAmount" dto="xPayAmount" label="M02649" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="xPayOperationNm" dto="xPayOperationNm" label="M02650" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="xTransactionTimes" dto="xTransactionTimes" label="M02651" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="xTrTimesOperationNm" dto="xTrTimesOperationNm" label="M02650" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
				<ifvm:inputNew type="hidden" id="xTrStartHour" dto="xTrStartHour" />
				<ifvm:inputNew type="hidden" id="xTrEndHour" dto="xTrEndHour"  />
				<ifvm:inputNew type="text" id="xTrHour" dto="xTrHour" label="M02652" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="xTransactionDayNm" dto="xTransactionDayNm" label="M02653" labelClass="3" conClass="3"  disabled="true"/>
			</div>



			<div class="row">
				<ifvm:inputNew type="text" id="xDayTypeCdNm" dto="xDayTypeCdNm" label="M02654" labelClass="3" conClass="3"  disabled="true"/>
				<ifvm:inputNew type="text" id="xDayNums" dto="xDayNums" label="M02655" labelClass="3" conClass="3"  disabled="true"/>
			</div>



			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02618" /></span>
				</div>
			</div>


			<div class="row">
				<ifvm:inputNew type="text" id="xOperationObjectNm" dto="xOperationObjectNm" label="M02656" labelClass="3" conClass="3"  disabled="true"/>
				<ifvm:inputNew type="text" id="xOperationMeasure" dto="xOperationMeasure" label="M02657" labelClass="3" conClass="3" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="xAliCompCdNm" dto="xAliCompCdNm" label="M02658" labelClass="3" conClass="3"  disabled="true"/>
				<ifvm:inputNew type="text" id="xLimitPoints" dto="xLimitPoints" label="M02659" labelClass="3" conClass="3" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="xWinFirstCnt" dto="xWinFirstCnt" label="M02660" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="xWinCycleCnt" dto="xWinCycleCnt" label="M02661" labelClass="3" conClass="3" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="xCommonDifferenceAmt" dto="xCommonDifferenceAmt" label="M02662" labelClass="3" conClass="3" disabled="true" />
			</div>
		</div>
	</div>
</div>
</div>

<!--  -->
