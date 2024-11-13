<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal top_well underline" id="TermsGrpNew">
        <div class="row">
           <ifvm:inputNew type="select" id="termsGrpCd" names="termsGrpCd" dto="termsGrpCd" label="약관 그룹명 " nuc="true" labelClass="3" conClass="7" />
        </div>
</div>


<div id="contsListPopWrap">
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray"  id="grpSave" objCode="termsGrpModPopSave_OBJ">
            <spring:message code="L00074" />
        </button> 
        <button class="btn btn-sm btn_lightGray2" id="grpSaveCancel" objCode="termsGrpModPopCancel_OBJ">
            <spring:message code="L00073" />
        </button>
    </div>
</div>
<div id="termsGrpTermsListPopupContainer" class="popup_container"></div>


<script type="text/javascript">
function grpDetailInit(){
    $.ifvSyncPostJSON('<ifvm:action name="getAlreadyTermsGrp"/>', {
        termsGrpCdChangeVal       :   termsGrpListGrid.opt.gridControl.getSelectedRecords()[0].termsGrpCd                     
    }, function(result) {
        $.fn.ifvmSetSelectOptionCommCode("termsGrpCd", "LOY_TERMS_GRP_CD", result.termsGrpCd, null, true);
    });
}

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

function grpUpdate(){
    $.ifvSyncPostJSON('<ifvm:action name="updateTermsGrp"/>', {
        termsGrpCd  :   termsGrpCd
        ,termsGrpCdChangeVal : $("#termsGrpCd").val()
        , ridTerms : ridTerms
    }, function(result) {
        termsModGrpPopupClose();
        getTermsGrpList();
        termsGrpListGrid.opt.gridControl.selectRows(0);

    }, function(result) {
        alert('<spring:message code="이미 약관 그룹이 존재 합니다."/>');
    }
    );
}

$(document).ready(function() {
    $.fn.ifvmSetSelectOptionCommCode("termsGrpCd", "LOY_TERMS_GRP_CD", null, null, true);
    
    grpDetailInit();
    
    $("#grpSave").on('click', function(){
        grpUpdate();
    }); 

   $("#grpSaveCancel").on('click', function(){
       termsModGrpPopupClose();
    }); 
});

</script>
