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
var dateFieldId = ['smsStartDt', 'smsEndDt', 'txnStartDt', 'txnEndDt'];
function channelSendDtlSetting(){
	$.ifvSyncPostJSON('<ifvm:action name="getPastCamChnlDtl"/>', {
		id : pastCamId
	}, function(result) {

		$("#channelSendDtlForm").dataSetting(result);

		$($('#channelSendDtlForm').find('input')).each(function(index, item){
			if($(this).attr('type')=="checkbox"){
				if(result[$(item).attr('id')]=='Y'){
 	 				$(this).attr('checked', 'true');
 	 			}
			}

		});

		//데이트 타입 필드
		for(var pi = 0 ; pi < dateFieldId.length ; pi++){
			var _pval = $("#channelSendDtlForm [dtoparam='"+dateFieldId[pi]+"']").val();
			var _aval="";
			if(_pval){
				_aval = _pval.split(' ')[0];
			}
			$("#channelSendDtlForm [dtoparam='"+dateFieldId[pi]+"']").val(_aval);
		}
	});

}

$(document).ready(function() {
	channelSendDtlSetting();

})
</script>

<div id ="channelSendDtlForm">

<div class="form-horizontal underline top_well">
	<div class="half_wrap top_well">
		<div class="half_content half_left" id="approvalServerForm">
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02664" /></span>
				</div>
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="cardNum" dto="cardNum" label="M02668" labelClass="3" conClass="9" disabled="true" />
			</div>


			<div class="row">
	    	    <ifvm:inputNew type="date" id="smsStartDt" dto="smsStartDt" maxLength="50" label="M02669" labelClass="3" conClass="3" required="true" disabled="true" />
   				<ifvm:inputNew type="text" id="smsSendTypeNm" dto="smsSendTypeNm" label="M02670" labelClass="3" conClass="3"  disabled="true"/>

			</div>

			<div class="row">
	    	    <ifvm:inputNew type="date" id="smsEndDt" dto="smsEndDt" maxLength="50" label="M02671" labelClass="3" conClass="3" required="true" disabled="true" />
   				<ifvm:inputNew type="text" id="telTchDiv" dto="telTchDiv" label="M02672" labelClass="3" conClass="3"  disabled="true"/>
			</div>


			<div class="row">
				<ifvm:inputNew type="singleCheckbox" id="ccAssocYn" label="M02673" values="1" labelClass="3" conClass="3" checked="false" disabled="true" />
				<ifvm:inputNew type="text" id="smsMaxStage" dto="smsMaxStage" label="M02674" labelClass="3" conClass="3" disabled="true" />
			</div>




			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02665" /></span>
				</div>
			</div>
			<div class="row">
   				<ifvm:inputNew type="text" id="txnAssocYn" dto="txnAssocYn" label="M02675" labelClass="3" conClass="3"  disabled="true"/>
   				<ifvm:inputNew type="text" id="txnSubTypeCdNm" dto="txnSubTypeCdNm" label="M02676" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
	    	    <ifvm:inputNew type="date" id="txnStartDt" dto="txnStartDt" maxLength="50" label="M02677" labelClass="3" conClass="3" required="true" disabled="true" />
   				<ifvm:inputNew type="text" id="txnListPriYn" dto="txnListPriYn" label="M02678" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
	    	    <ifvm:inputNew type="date" id="txnEndDt" dto="txnEndDt" maxLength="50" label="M02679" labelClass="3" conClass="3" required="true" disabled="true" />
    			<ifvm:inputNew type="text" id="txnListPriVal" dto="txnListPriVal" label="M02680" labelClass="3" conClass="3" disabled="true" />
			</div>


		</div>

		<div class="half_content half_right">
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02666" /></span>
				</div>
			</div>

				<div class="row">
    				<ifvm:inputNew type="text" id="cardMemberYn" dto="cardMemberYn" label="M02681" labelClass="3" conClass="3"  disabled="true"/>
    				<ifvm:inputNew type="text" id="memberCdNm" dto="memberCdNm" label="M02682" labelClass="3" conClass="3"  disabled="true"/>
				</div>

				<div class="row">
					<ifvm:inputNew type="singleCheckbox" id="exceptStaffYn" label="M02683" values="1" labelClass="3" conClass="3" checked="false" disabled="true" />
    				<ifvm:inputNew type="text" id="exceptStaffYn" dto="exceptStaffYn" label="M02684" labelClass="3" conClass="3"  disabled="true"/>
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="srcId" dto="srcId" label="M02685" labelClass="3" conClass="9" disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="srcFilterCd" dto="srcFilterCd" label="M02686" labelClass="3" conClass="9" disabled="true" />
				</div>

				<div class="row">
    				<ifvm:inputNew type="text" id="promId" dto="promId" label="M02687" labelClass="3" conClass="3"  disabled="true"/>
					<ifvm:inputNew type="singleCheckbox" id="promoActOnly" label="M02688" values="1" labelClass="5" conClass="1" checked="false" disabled="true" />
				</div>



			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02667" /></span>
				</div>
			</div>


			<div class="row">
    			<ifvm:inputNew type="text" id="sendAmtPer1time" dto="sendAmtPer1time" label="M02689" labelClass="3" conClass="3" disabled="true" />
   				<ifvm:inputNew type="text" id="jumpMaxStgTypeNm" dto="jumpMaxStgTypeNm" label="M02690" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
   				<ifvm:inputNew type="text" id="sendDelayCdNm" dto="sendDelayCdNm" label="M02691" labelClass="3" conClass="3"  disabled="true"/>
   				<ifvm:inputNew type="text" id="jumpMaxStgCdNm" dto="jumpMaxStgCdNm" label="M02692" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
    			<ifvm:inputNew type="text" id="sendDelayVal" dto="sendDelayVal" label="M02693" labelClass="3" conClass="3" disabled="true" />
			</div>
		</div>
	</div>
</div>
</div>



