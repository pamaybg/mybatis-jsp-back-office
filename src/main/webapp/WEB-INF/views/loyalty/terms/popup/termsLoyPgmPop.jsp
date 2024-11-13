<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal underline top_well" id="termsLoyPgmDetail">
<br>
	<div class="row qt_border">
		<div class="form-horizontal">
			<div class="col-xs-6" >
				<ifvm:inputNew type="text" id="pgmNo" names="pgmNo" label="D10271" labelClass="3" conClass="8" required="true" disabled="true"/>
			</div>
			<div class="col-xs-6" >
				<ifvm:inputNew type="text" id="pgmNm" names="pgmNm" label="L00037" labelClass="3" conClass="8" required="true" disabled="true"/>	
				<span class="input-group-addon" style="padding: 4px;" id="loyPgmListBtn">
					<a><i class="fa fa-search"></i></a>
				</span>
			</div>
		</div>
	</div>
	<br>
	<div class="row qt_border">
		<div class="col-xs-6" >
			<ifvm:inputNew type="select" id="loyPgmUseYn" names="loyPgmUseYn" dto="loyPgmUseYn" label="M01139" labelClass="3" conClass="4" required="true" />
		</div>
		<ifvm:inputNew type="hidden" id="pgmTRid" label="pgmTRid" labelClass="3" conClass="2" disabled="true"/>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnSave" objCode="termsLoyPgmPopSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00164" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="termsLoyPgmPopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>
<div id="loyPgmListPopupContainer" class="popup_container"></div>

<script type="text/javascript">
var isNew;
var pgmRid;
var useYnCheK = null;
function initLoyPgmDetail() {
	
	if (typeof pgmRid === 'undefined' || pgmRid ==null){
		isNew = true;
		$("#pgmNo").val("");
		$("#pgmNm").val("");
		$("#pgmTRid").val("");
	}
	else	{
		isNew = false;
		getLoyPgmDetail();
	}
	
	$.fn.ifvmSetSelectOptionCommCode("loyPgmUseYn", "COM_STAT_TYPE_3_CD", useYnCheK , null, true);
}

function getLoyPgmDetail(){
	$.ifvSyncPostJSON('<ifvm:action name="getLoyPgmDetail"/>',{
		rid : pgmRid,
		parRid : parRid,
		verRid : verRid
	},function(result) {
		$("#pgmNo").val(result.pgmNo);
		$("#pgmNm").val(result.pgmNm);
		$("#pgmTRid").val(result.rid);
		useYnCheK = result.useYn;
	});
}

function saveLoyPgmDetail(){
		var validation = $("#termsLoyPgmDetail").ifvValidation();
		
		//유효성 체크
		if(validation.confirm()){
			var tUrl = isNew? '<ifvm:action name="saveTermsLoyPgm"/>' : '<ifvm:action name="modifyTermsLoyPgm"/>';
			var tData = null;
			tData = {
					rid : pgmRid,
					verRid : verRid,
					pgmRid : $("#pgmTRid").val(),
					pgmNo : $("#pgmNo").val(),
					pgmNm : $("#pgmNm").val(),
					useYn : $("#loyPgmUseYn").val()
			};
			
			$.ifvSyncPostJSON(tUrl, tData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
					}
				}, function(result) {
					if(result.message) alert(result.message);
					else alert("<spring:message code="M02248" />");
			});
			
			termsLoyPgmPopupClose();
			loyaltyProgramList._doAjax();
			isNew = false;
		}

}

function getLoyPgmList(){
	$("#loyPgmListPopupContainer").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyPgmTListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="L00325"/>',
        width: 900,
        close : 'loyPgmTPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	});
        }
    });
}

function loyPgmTPopupClose() {
	loyPgmListPopupContainer._destroy();
} 

$(document).ready(function(){

	initLoyPgmDetail();
	
	$("#btnSave").click(function(){
		saveLoyPgmDetail();
	});
	
	$("#btnCancel").click(function(){
		termsLoyPgmPopupClose();
	});
	
	//LOY_PGM POPUP
	$("#loyPgmListBtn").click(function(){
		if($("#statCd").val()=='A') {
			if(pgmRid == null) getLoyPgmList();
			else alert('<spring:message code="D10281"/>');
		} else getLoyPgmList();
	})
});

</script>