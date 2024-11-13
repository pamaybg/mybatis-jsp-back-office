<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function dataSetFun(){
    $.ifvSyncPostJSON('<ifvm:action name="getTProdListYnPop"/>', {
        prodId : prodidG
    }, function(result) {
        $('#prodIdP').val(result.prodId);
        $('#prodNmP').val(result.prodNm);
        $('#cpnAvlYnOrigin').val(result.cpnAvlYn);
    });
}
function dataSetSaveFun(){
    //console.log($('#cpnAvlYnChange').val());
    $.ifvSyncPostJSON('<ifvm:action name="saveTProdListYnPop"/>', {
        prodId : prodidG
        , cpnAvlYn : $('#cpnAvlYnOrigin').val()
    }, function(result) {
        alert('<spring:message code="L00127" />');
    }, function(result) {
        alert('<spring:message code="M01017" />');
    });
}

$(document).ready(function() {
	//$.fn.ifvmSetSelectOptionCommCode("cpnAvlYnChange", "REQUIRED_YN", null, null, true);
    $.fn.ifvmSetSelectOptionCommCode("cpnAvlYnOrigin", "REQUIRED_YN", null, null, true);
    
    dataSetFun();

    $("#selectBtn").click(function(){
            dataSetSaveFun();
            $.fn.ifvmPopupClose();
            window.location.reload()
    });
    $("#cancelBtn").click(function(){
        $.fn.ifvmPopupClose();
    });
});

</script>
</br>
<div class="row ">
        <div class="col-xs-12">
                    <ifvm:inputNew type="text" id="prodIdP" label="E00105" labelClass="2" conClass="8" disabled="true" />
        </div>
</div>
</br>
<div class="row ">
        <div class="col-xs-12">
                    <ifvm:inputNew type="text" id="prodNmP" label="E00091" labelClass="2" conClass="8" disabled="true" />
        </div>
</div>
</br>
<div class="row ">
        <div class="col-xs-12">
                    <ifvm:inputNew type="select" id="cpnAvlYnOrigin" names="cpnAvlYnOrigin" label="O00176" labelClass="2" conClass="8"/>
                    <%-- <ifvm:inputNew type="select" id="cpnAvlYnChange" names="cpnAvlYnChange" conClass="4" /> --%>
        </div>
</div>
</br>


<!-- End -->
<div id="contsListPopWrap">
    <div class="pop_btn_area">
        <!-- 선택 -->
        <button class="btn btn-sm btn_gray" id="selectBtn" objCode="prodCpnAvlPopSelectBtn_OBJ">
            <spring:message code="C00164"/>
        </button>
        <!-- 닫기 --> 
        <button class="btn btn-sm btn_lightGray2" id="cancelBtn" objCode="prodCpnAvlPopCancelBtn_OBJ">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>

