<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style type="text/css">
#initRequestBtn {background-color: #7486A4; font-weight: 300; border-radius: 2px; border:0 none; min-width: 70px; min-height: 25px; line-height: unset;}
#closeInitRequestPopBtn {background-color: #7486A4; font-weight: 300; border-radius: 2px; border:0 none; min-width: 70px; min-height: 25px; line-height: unset;}
#title-pop {font-size: 16px; color:#000000; font-weight: 300; max-width: 740px; line-height: 32px;}

</style>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <h1 class="modal-title" id="title-pop"><spring:message code="C00188" /></h1>
            <div class="modal-body">
                <div class="form-horizontal top_well underline" id="areaPasswordInit">
                    <div class="row qt_border">
                        <ifvm:inputNew type="text" id="userId" names="userId" dto="userId" required="true" label="사용자 ID" labelClass="2" conClass="8"/>
                    </div>
                    <div class="row qt_border">
                        <ifvm:inputNew type="text" id="userPhone" names="userPhone" dto="userPhone" required="true" label="휴대전화번호" labelClass="2" conClass="8" maxLength="13"/>
                    </div>
                </div>

                <div class="pop_btn_area">
                    <button class="btn btn-sm" id="initRequestBtn" onclick="pageObjectPasswordInitRequestPop.requestInitPassword();">
                        <spring:message code="C00191" />
                    </button>
                    <button class="btn btn-sm" id="closeInitRequestPopBtn" onClick="appClose()">
                        <spring:message code="C00192"/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    function appClose() {
        javascript:$.modalClose();
    }

    function autoHypen(obj) {
        obj.value = obj.value
            .replace(/[^0-9]/g, "");

    }


    var pageObjectPasswordInitRequestPop = {
        requestInitPassword: function () {
            if($('#userId').val() == '' || $('#userPhone').val() == ''){
                alert('<spring:message code="C00194" />');
            }
           else {
                if (confirm('<spring:message code="C00189" />')) {
                    var targetUrl = '<ifvm:action name="initPassword"/>'

                    $.ifvSyncPostJSON(targetUrl, {
                        userId :$('#userId').val() ,
                        receiveMobileNo :$('#userPhone').val()
                    }, function (result) {
                        if(result.success){
                            alert('<spring:message code="C00190"/>')
                        }
                        appClose();
                    }, function(result){
                        if(result.errorType === 1) alert('<spring:message code="C00193"/>');
                        else if(result.errorType === 2) alert('<spring:message code="C00195"/>');
                        else if(result.errorType === 3) alert('<spring:message code="C00198"/>');
                        else if(result.errorType === 4) alert('<spring:message code="C00199"/>');
                        else if(result.errorType === 5) alert('<spring:message code="C00200"/>');
                        else alert('<spring:message code="C00185"/>')
                    });
                }
            }
        },
        close: function () {
            appClose();
        }
    };

    $(document).ready(function () {
        $("#userPhone").attr("onKEYUP", "autoHypen(this);");
    });
</script>