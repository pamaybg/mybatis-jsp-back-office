<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id='tierPopFormArea'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00236"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="select" dto="tierTypeCd" required="true" names="tierTypeCd" id="tierTypeCd"  maxLength="5"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00235"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="text" dto="tierCd" id="tierCd" required="true" disabled="true"/>
	            <ifvm:inputNew type="hidden" dto="tierNm" id="tierNm" required="true" disabled="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01972" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="text" dto="seqNo" id="seqNo" required="true" maxLength="2"/>
	        </div>

			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="유지 기간" /></label>
			<div class="col-xs-4 control_content">
	        <ifvm:inputNew type="number" id="tiersUpKeepMm" dto="tiersUpKeepMm"
							className="text-right" conClass="8" />
							<label class="control-label" style="margin-left:0px">개월
			</div>
	        
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="기본 등급" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="singleCheckbox" nuc="true" checked="false" dto="baseTierYn" id="baseTierYn" />
	        </div>
	    </div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="tierSaveBtn" objCode="addTierPopTierSaveBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tierPopCancel" objCode="addTierPopTierCancelBtn_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<script type="text/javascript">
	var isNew;

	function tierDetailInit() {
		if (typeof tierRid === 'undefined' || tierRid == null) {
			isNew = true;
		} else {
			isNew = false;
			getTierDetail();
		}
	}
	
	function getTierDetail() {
		$.ifvSyncPostJSON('<ifvm:action name="getTierDetail"/>', {
			rid : tierRid
		}, function(result) {
			 $("#tierNm").val(result.tierNm);
			 $("#tierTypeCd").val(result.tierTypeCd);
			 $("#seqNo").val(result.seqNo);
			 $("#tiersUpKeepMm").val(result.tiersUpKeepMm);
			 if(result.baseTierYn == 'Y') {
				 $("input:checkbox[id='baseTierYn']").attr("checked", true);
			 }
		});
	}

	function saveTier() {
		/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
			alert("작성중일때만 수정할수 있습니다.");
			return;
		} */
		
		var validation = $("#tierPopFormArea").ifvValidation();
		//유효성 체크
		if (validation.confirm()) {
			var url = isNew ? '<ifvm:action name="saveTier"/>'
					: '<ifvm:action name="modifyTier"/>';
			var varData = null;
			varData = {
				rid 		 : tierRid,
				tierGroupRid : tierGroupDetail_rid,
				tierNm 		 : $("#tierNm").val(),
				tierTypeCd   : $("#tierTypeCd").val(),
				seqNo 		 : $("#seqNo").val(),
				tiersUpKeepMm : $("#tiersUpKeepMm").val(),
				baseTierYn   : $('#baseTierYn').prop('checked') ? 'Y' : 'N'
			};
			$.ifvSyncPostJSON(url, varData, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="C00094" />");
					addTierClosePop();
					isNew = false;
					tierListGrid._doAjax();
				}
			}, function(result) {
				if (result.message != null)
					alert(result.message);
				else
					alert("<spring:message code="M02248" />");
			});
		}
	}

	$(document).ready(function() {
		$.fn.ifvmSetSelectOptionCommCodeSync("tierTypeCd", "LOY_MBR_TIER_TYPE_CD", null , "tiersGrpCd", false);
		tierDetailInit();
	

		$("#tierSaveBtn").click(function() {
			saveTier();
		});

		$("#tierPopCancel").click(function() {
			addTierClosePop();
		});

		//화면상 등급에 맞는 등급코드 변경해주기
		$("#tierTypeCd").change(function(){
			var target = $(this)[0];
			var name = target.options[target.selectedIndex].text;
			var code = $("#tierTypeCd").val();
			$("#tierNm").val(name)
			$("#tierCd").val(code)
		});
		$("#tierCd").val($("#tierTypeCd").val());
	});
</script>