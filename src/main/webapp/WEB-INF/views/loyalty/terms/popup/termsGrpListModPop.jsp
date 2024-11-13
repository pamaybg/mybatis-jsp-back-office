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
            <ifvm:inputNew type="hidden" id="termsTypeSubCd" hidId="termsTypeSubCd" hidDto="termsTypeSubCd"  dto="termsTypeSubCd" names="termsTypeSubCd" label="약관코드" labelClass="3" conClass="7" required="true"/>
        </div>
        <div class="row">
            <ifvm:inputNew type="number" id="seqNo" nuc="true" label="약관순서" labelClass="3"  conClass="7" required="true"/>
        </div>
</div>


<div id="contsListPopWrap">
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray"  id="grpSave" objCode="termsGrpListModPopSave_OBJ">
            <spring:message code="L00074" />
        </button> 
        <button class="btn btn-sm btn_lightGray2" id="grpSaveCancel" objCode="termsGrpListModPopCancel_OBJ">
            <spring:message code="L00073" />
        </button>
    </div>
</div>
<div id="termsGrpTermsListPopupContainer" class="popup_container"></div>


<script type="text/javascript">
var termsGrpCd;
var termsRid = null;
var termsTypeSubCd;
function grpDetailInit(){
        $('#termsPop').val(termsListGrid.opt.gridControl.getSelectedRecords()[0].termsNm);
        $('#seqNo').val(termsListGrid.opt.gridControl.getSelectedRecords()[0].termsNo);
        $('#termsTypeSubCd').val(termsListGrid.opt.gridControl.getSelectedRecords()[0].termsTypeSubCd);
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
    $.ifvSyncPostJSON('<ifvm:action name="updateTermsListGrp"/>', {
        ridTermsChangeVal : termsRid != null ? termsRid : termsListGrid.opt.gridControl.getSelectedRecords()[0].rid
        ,termsGrpCd    :      termsGrpCd
        ,ridTerms  :   termsListGrid.opt.gridControl.getSelectedRecords()[0].termRid
        ,seqNo  :   $('#seqNo').val()
    }, function(result) {
    	alert("저장되었습니다.");
        termsGrpModiListPopupClose();
        termsRid = null;
        getTermsList(termsGrpCd);
        termsListGrid.opt.gridControl.selectRows(0);
    }, function(result) {
        alert('<spring:message code="이미 약관 그룹이 존재 합니다."/>');
    }
    );
}

$(document).ready(function() {
    $.fn.ifvmSetSelectOptionCommCode("termsGrpCd", "LOY_TERMS_GRP_CD", termsGrpListGrid.opt.gridControl.getSelectedRecords()[0].termsGrpCd, null, true);
    $("#termsGrpCd").attr("disabled",true);

    grpDetailInit();
    
    $("#grpSave").on('click', function(){
        grpUpdate();
    }); 

   $("#grpSaveCancel").on('click', function(){
       termsGrpModiListPopupClose();
    }); 
});

</script>
