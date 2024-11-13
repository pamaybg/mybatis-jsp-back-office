<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

    //저장
    function saveTemplateCheckPop(){

        if(storeCheckYn == "Y" && $("#storeBrand").val() == ''){
            alert("브랜드를 선택해주세요.");
            return;
        }

        saveTemplateCheck();

    }

    $(function () {

        $.fn.ifvmSetSelectOptionCommCode("storeBrand", "DIVISION_BRAND_CD", null, null, true);
        $("#storeBrand option[value='G']").remove();
        $("#storeBrand option[value='M']").remove();
        $("#storeBrand option[value='D']").remove();

        $("#storeBrand").attr("disabled",true);

        $("#storeCheckYn").click(function () {
            if($('#storeCheckYn').is(':checked') === true) {
                $("#storeBrand").attr("disabled",false);
                storeCheckYn = 'Y';
            } else {
                $("#storeBrand").attr("disabled",true);
                storeCheckYn = 'N';
            }
        });

        //저장 클릭
        $("#templateCheckSaveBtn").click(function () {
            saveTemplateCheckPop();
        });

        //닫기 클릭
        $('#templateCheckCancelBtn').on('click', function(){
            popupClose();
        });


    })

</script>


<div id="dialogPopupWrap">
    <div class="row qt_border">
        <br>
        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="매장 사용여부"/></label>
        <div class="col-xs-2 control_content">
            <ifvm:input type="checkbox" id="storeCheckYn" names="storeCheckYn" required="true" dataBind="checked: camDefaultInfo.storeCheckYn"/>
        </div>
    </div>

    <div class="row qt_border">
        <%-- 유형 --%>
        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="브랜드"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="storeBrand" names="storeBrand" required="true"/>
        </div>
    </div>

<br>
    <div class="pop_btn_area">
        <%-- 저장 --%>
        <button class="btn btn-sm btn_gray" id="templateCheckSaveBtn" objCode="templateCheckSaveBtn_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>
        <%-- 닫기 --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="templateCheckCancelBtn"
                objCode="templateCheckCancelBtn_OBJ">
            <spring:message code="M00441"/>
        </button>
    </div>

</div>