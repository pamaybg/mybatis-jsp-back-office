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
var dateFieldId = ['progStartDt', 'progEndDt', 'xRequestDate', 'xApproveDate', 'xRejectDt', 'cpnUseStrt', 'cpnUseEnd'];

function pastCamDtlSetting(){
	$.ifvSyncPostJSON('<ifvm:action name="getPastCamDtl"/>', {
		id : pastCamId
	}, function(result) {

		$("#pastCamDtlForm").dataSetting(result);

		$($('#pastCamDtlForm').find('input')).each(function(index, item){
			if($(this).attr('type')=="checkbox"){
				var _flg =result[$(item).attr('id')];
				if(_flg){
					if(_flg=='Y'){
	 	 				$(this).attr('checked', 'true');
	 	 			}
				}

			}
		});
		//데이트 타입 필드
		for(var pi = 0 ; pi < dateFieldId.length ; pi++){
			var _pval = $("#pastCamDtlForm [dtoparam='"+dateFieldId[pi]+"']").val();
			var _aval="";
			if(_pval){
				_aval = _pval.split(' ')[0];
			}
			$("#pastCamDtlForm [dtoparam='"+dateFieldId[pi]+"']").val(_aval);
		}
	});

}

$(document).ready(function() {
	pastCamDtlSetting();
})
</script>

<div id ="pastCamDtlForm">
<div class="form-horizontal underline top_well">
	<div class="half_wrap top_well">
		<div class="half_content half_left" id="approvalServerForm">
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02520" /></span>
				</div>
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="name" dto="name" label="M02530" labelClass="3" conClass="9" disabled="true" />
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="objective" dto="objective" label="M02531" labelClass="3" conClass="9" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="srcNum" dto="srcNum" label="M02532" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="smplngTypeCdNm" dto="smplngTypeCdNm" label="M02533" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
	    	    <ifvm:inputNew type="date" id="progStartDt" dto="progStartDt" maxLength="50" label="M02534" labelClass="3" conClass="3"  disabled="true" />
	    	    <ifvm:inputNew type="date" id="progEndDt" dto="progEndDt" maxLength="50" label="M02535" labelClass="3" conClass="3"  disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="custTrgtTypeCdNm" dto="custTrgtTypeCdNm" label="M02536" labelClass="3" conClass="3"  disabled="true"/>
				<ifvm:inputNew type="text" id="xTmTypeNm" dto="xTmTypeNm" label="M02537" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="xCampCreOrgCdNm" dto="xCampCreOrgCdNm" label="M02538" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02522" /></span>
				</div>
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="xCoupNo" dto="xCoupNo" label="M02539" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="issueAliasName" dto="issueAliasName" label="M02546" labelClass="3" conClass="3" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="cpnAliasName" dto="cpnAliasName" label="M02542" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="xCoupTypeNm" dto="xCoupTypeNm" label="M02543" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="useAliasName" dto="useAliasName" label="M02544" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="cpnAliCdNm" dto="cpnAliCdNm" label="M02545" labelClass="3" conClass="3"  disabled="true"/>
			</div>

			<div class="row">
				<ifvm:inputNew type="textarea" id="cpnHhedGuide" maxLength="50" dto="cpnHhedGuide" label="M02548" labelClass="3" conClass="3" disabled="true"  />
				<ifvm:inputNew type="textarea" id="xCpGuide" maxLength="50" dto="xCpGuide" label="M02549" labelClass="3" conClass="3" disabled="true"  />
			</div>

			<div class="row">
				<ifvm:inputNew type="textarea" id="xCpDesc" maxLength="50" dto="xCpDesc" label="M02550" labelClass="3" conClass="3" disabled="true"  />
				<ifvm:inputNew type="text" id="xDiscountPoint" dto="xDiscountPoint" label="M02553" labelClass="3" conClass="3" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="entryPsblStrt" dto="entryPsblStrt" label="M02551" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="entryPsblEnd" dto="entryPsblEnd" label="M02552" labelClass="3" conClass="3" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="singleCheckbox" id="xCoupActFlg" label="M02540" values="1" labelClass="3" conClass="3" checked="false" disabled="true" />
				<ifvm:inputNew type="singleCheckbox" id="xCpTotMemFlg" label="M02541" values="1" labelClass="4" conClass="1" checked="false" disabled="true" />

			</div>
			<div class="row">
				<ifvm:inputNew type="singleCheckbox" id="xNewCommerFlg" label="M02547" values="1" labelClass="10" conClass="1" checked="false" disabled="true" />
			</div>

			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02526" /></span>
				</div>
			</div>

			<div class="row">
				<ifvm:inputNew type="singleCheckbox" id="payPsblFlg" label="M02554" values="1" labelClass="4" conClass="3" checked="false" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="dcAmt" dto="dcAmt" label="M02555" labelClass="3" conClass="3" disabled="true" />
				<ifvm:inputNew type="text" id="minPayAmt" dto="minPayAmt" label="M02556" labelClass="3" conClass="3" disabled="true" />
			</div>

			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="M02527" /></span>
				</div>
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="hheldNotiMsg" dto="hheldNotiMsg" label="M02557" labelClass="3" conClass="9" disabled="true" />
			</div>

			<div class="row">
				<ifvm:inputNew type="text" id="appNotiMsg" dto="appNotiMsg" label="M02558" labelClass="3" conClass="9" disabled="true" />
			</div>

		</div>

		<div class="half_content half_right">
				<div class="page_btn_area">
					<div class="col-xs-12">
						<span><spring:message code="M02521" /></span>
					</div>
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="prefUomCdNm" dto="prefUomCdNm" label="M02559" labelClass="3" conClass="3" disabled="true" />
		    	    <ifvm:inputNew type="date" id="xRequestDate" dto="xRequestDate" maxLength="50" label="M02560" labelClass="3" conClass="3"  disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="reqFstName" dto="reqFstName" label="M02561" labelClass="3" conClass="3" disabled="true" />
		    	    <ifvm:inputNew type="date" id="xApproveDate" dto="xApproveDate" maxLength="50" label="M02562" labelClass="3" conClass="3"  disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="telTchDt" dto="telTchDt" label="M02563" labelClass="3" conClass="3" disabled="true" />
	    	    	<ifvm:inputNew type="date" id="xRejectDt" dto="xRejectDt" maxLength="50" label="M02564" labelClass="3" conClass="3"  disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="textarea" id="xRejectReason" maxLength="50" dto="xRejectReason" label="M02566" labelClass="3" conClass="3" disabled="true"  />
					<ifvm:inputNew type="text" id="aprvFstName" dto="aprvFstName" label="M02565" labelClass="3" conClass="3" disabled="true" />

					<ifvm:inputNew type="text" id="telTchDt" dto="telTchDt" label="M02567" labelClass="3" conClass="3" disabled="true" />
				</div>

				<div class="page_btn_area">
					<div class="col-xs-12">
						<span><spring:message code="M02523" /></span>
					</div>
				</div>
				<div class="row">
					<ifvm:inputNew type="text" id="xNorDeductPoint" dto="xNorDeductPoint" label="M02568" labelClass="3" conClass="3" disabled="true" />
					<ifvm:inputNew type="text" id="xExcDeductPoint" dto="xExcDeductPoint" label="M02570" labelClass="3" conClass="3" disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="xVipDeductPoint" dto="xVipDeductPoint" label="M02572" labelClass="3" conClass="3" disabled="true" />
				</div>


				<div class="page_btn_area">
					<div class="col-xs-12">
						<span><spring:message code="M02524" /></span>
					</div>
				</div>
				<div class="row">
					<ifvm:inputNew type="text" id="xNorDeductStamp" dto="xNorDeductStamp" label="M02569" labelClass="3" conClass="3" disabled="true" />
					<ifvm:inputNew type="text" id="xExcDeductStamp" dto="xExcDeductStamp" label="M02571" labelClass="3" conClass="3" disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="xVipDeductStamp" dto="xVipDeductStamp" label="M02573" labelClass="3" conClass="3" disabled="true" />
				</div>


				<div class="page_btn_area">
					<div class="col-xs-12">
						<span><spring:message code="M02525" /></span>
					</div>
				</div>

				<div class="row">
					<ifvm:inputNew type="singleCheckbox" id="xOnlyYouFlg" label="M02574" values="1" labelClass="3" conClass="1" checked="false" disabled="true" />
					<ifvm:inputNew type="singleCheckbox" id="xHotFlg" label="M02575" values="1" labelClass="3" conClass="1" checked="false" disabled="true" />
					<ifvm:inputNew type="singleCheckbox" id="xHighlightFlg" label="M02576" values="1" labelClass="3" conClass="1 " checked="false" disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="xHomepage" dto="xHomepage" label="M02577" labelClass="3" conClass="3" disabled="true" />
					<ifvm:inputNew type="singleCheckbox" id="xPromoFlg" label="M02578" values="1" labelClass="3" conClass="1 " checked="false" disabled="true" />
				</div>


				<div class="row">
					<ifvm:inputNew type="text" id="xCpTelNum" dto="xCpTelNum" label="M02579" labelClass="3" conClass="3" disabled="true" />
					<ifvm:inputNew type="text" id="cpnEntryPsblCnt" dto="cpnEntryPsblCnt" label="M02580" labelClass="3" conClass="3" disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="xCpSlogan" dto="xCpSlogan" label="M02581" labelClass="3" conClass="3" disabled="true" />
					<ifvm:inputNew type="text" id="xEvtNum" dto="xEvtNum" label="M02582" labelClass="3" conClass="3" disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="cpnTitleApp" dto="cpnTitleApp" label="M02583" labelClass="3" conClass="3" disabled="true" />
					<ifvm:inputNew type="text" id="newFlgEndDt" dto="newFlgEndDt" label="M02584" labelClass="3" conClass="3" disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="cpnTitleWeb" dto="cpnTitleWeb" label="M02585" labelClass="3" conClass="3" disabled="true" />
					<ifvm:inputNew type="text" id="cpnOrder" dto="cpnOrder" label="M02586" labelClass="3" conClass="3" disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="cpnTitlePad" dto="cpnTitlePad" label="M02587" labelClass="3" conClass="3" disabled="true" />
					<ifvm:inputNew type="text" id="xLocSubSeq" dto="xLocSubSeq" label="M02588" labelClass="3" conClass="3" disabled="true" />
				</div>

				<div class="row">
		    	    <ifvm:inputNew type="date" id="cpnUseStrt" dto="cpnUseStrt" maxLength="50" label="M02589" labelClass="3" conClass="3"  disabled="true" />
		    	    <ifvm:inputNew type="date" id="cpnUseEnd" dto="cpnUseEnd" maxLength="50" label="M02590" labelClass="3" conClass="3"  disabled="true" />
				</div>


				<div class="page_btn_area">
					<div class="col-xs-12">
						<span><spring:message code="M02528" /></span>
					</div>
				</div>

				<div class="row">
					<ifvm:inputNew type="textarea" id="actcSbst" maxLength="50" dto="actcSbst" label="M02528" labelClass="3" conClass="9" disabled="true"  />
				</div>

		</div>
	</div>

</div>
	<div class="form-horizontal underline top_well">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="M02529" /></span>
			</div>
		</div>

		<div class="row">
			<ifvm:inputNew type="text" id="xPosProdQty" maxLength="50" dto="xPosProdQty" label="M02591" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosProdCd" maxLength="50" dto="xPosProdCd" label="M02592" labelClass="2" conClass="2" disabled="true" />
		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="xPosProdCd2" maxLength="50" dto="xPosProdCd2" label="M02593" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosProdCd3" maxLength="50" dto="xPosProdCd3" label="M02594" labelClass="2" conClass="2" disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="text" id="xPosProdBarCd" maxLength="50" dto="xPosProdBarCd" label="M02595" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosProdBarCd2" maxLength="50" dto="xPosProdBarCd2" label="M02596" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosProdBarCd3" maxLength="50" dto="xPosProdBarCd3" label="M02597" labelClass="2" conClass="2" disabled="true" />
		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="xPosVenderCd" maxLength="50" dto="xPosVenderCd" label="M02598" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosVenderCd2" maxLength="50" dto="xPosVenderCd2" label="M02699" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosVenderCd3" maxLength="50" dto="xPosVenderCd3" label="M02600" labelClass="2" conClass="2" disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="text" id="xPosProdICnt" maxLength="50" dto="xPosProdICnt" label="M02601" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosProdICnt2" maxLength="50" dto="xPosProdICnt2" label="M02602" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosProdICnt3" maxLength="50" dto="xPosProdICnt3" label="M02603" labelClass="2" conClass="2" disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="text" id="xPosCostPrice" maxLength="50" dto="xPosCostPrice" label="M02604" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosCostPrice2" maxLength="50" dto="xPosCostPrice2" label="M02605" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosCostPrice3" maxLength="50" dto="xPosCostPrice3" label="M02606" labelClass="2" conClass="2" disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="text" id="xPosVenderCharge" maxLength="50" dto="xPosVenderCharge" label="M02607" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosVenderCharge2" maxLength="50" dto="xPosVenderCharge2" label="M02608" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosVenderCharge3" maxLength="50" dto="xPosVenderCharge3" label="M02609" labelClass="2" conClass="2" disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="text" id="xPosCooperCharge" maxLength="50" dto="xPosCooperCharge" label="M02610" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosCooperCharge2" maxLength="50" dto="xPosCooperCharge2" label="M02611" labelClass="2" conClass="2" disabled="true" />
			<ifvm:inputNew type="text" id="xPosCooperCharge3" maxLength="50" dto="xPosCooperCharge3" label="M02612" labelClass="2" conClass="2" disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="hidden" id="hndopAcuStblDesc" maxLength="50"/>
		</div>
	</div>
</div>


