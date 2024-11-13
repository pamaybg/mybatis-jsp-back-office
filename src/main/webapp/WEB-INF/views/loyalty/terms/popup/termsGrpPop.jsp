<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal top_well underline" id="TermsGrpNew">
        <div class="row">
           <ifvm:inputNew type="select" id="termsGrpCd" names="termsGrpCd" dto="termsGrpCd" label="약관 그룹명 " nuc="true" labelClass="3" conClass="7" required="true"/>
        </div>
        <div class="row">
            <ifvm:inputNew type="search" id="termsPop" hidId="ridTerms" hidDto="ridTerms" btnFunc="btnTermsPop" dto="termsPop" names="termsPop" label="약관명" labelClass="3" conClass="7" required="true"/>
        </div>
        <div class="row">
            <ifvm:inputNew type="number" id="seqNo" nuc="true" label="약관순서" labelClass="3"  conClass="7" required="true"/>
        </div>
</div>


<div id="contsListPopWrap">
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray"  id="grpSave" objCode="termsGrpPopSave_OBJ">
            <i class="glyphicon glyphicon-check"></i>
			<spring:message code="L00074" />
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="grpSaveCancel" objCode="termsGrpPopCancel_OBJ">
			<spring:message code="L00073" />
		</button>
	</div>
</div>
<div id="termsGrpTermsListPopupContainer" class="popup_container"></div>


<script type="text/javascript">
var termsRid;
function btnTermsPop(){
    $("#termsGrpTermsListPopupContainer").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="termsGrpTermsPop"/>',
        contentType: "ajax",
        title: '<spring:message code="L02919"/>',
        width: 1000,
        close : 'btnTermsPopupClose',
        open : function(){
            new ifvm.PopupCenter({
                popupDivId : 'popupContainer'
            })
        }
    });
}

function btnTermsPopupClose() {
    termsGrpTermsListPopupContainer._destroy();
} 

function grpSave(){
    var validation = $("#TermsGrpNew").ifvValidation();
    if(validation.confirm()){

	    $.ifvSyncPostJSON('<ifvm:action name="insertTermsGrp"/>', {
	        termsGrpCd  :   $("#termsGrpCd").val()
	        ,seqNo           :   $("#seqNo").val()          
	        ,ridTerms       :   termsRid                     
	    }, function(result) {
	        termsGrpPopupClose();
	        termsRid = null;
	        getTermsGrpList();
            termsGrpListGrid.opt.gridControl.selectRows(0);
            termsListGrid.opt.gridControl.selectRows(0);
	    }, function(result) {
	        alert('<spring:message code="이미 약관 그룹이 존재 합니다."/>');
	    });
    }
}

$(document).ready(function() {
    $.fn.ifvmSetSelectOptionCommCode("termsGrpCd", "LOY_TERMS_GRP_CD", null, null, true);

	$("#grpSave").on('click', function(){
	    grpSave();
	}); 

   $("#grpSaveCancel").on('click', function(){
        termsGrpPopupClose();
    }); 
});

</script>
