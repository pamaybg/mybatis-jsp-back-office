<%--
  Created by IntelliJ IDEA.
  User: hr.noh
  Date: 2022-01-04
  Time: 오전 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal  top_well " id="brdDtlPopForm">
    <div class="row qt_border" >
        <ifvm:inputNew type="search" id="pgmNm" dto="pgmNm"  btnFunc="getPgmList" label="로열티 프로그램" labelClass="2" conClass="4" />
        <ifvm:inputNew type="hidden" id="pgmRid" dto="pgmRid" conClass="1" disabled="true" />
    </div>
    <div class="row qt_border">
        <ifvm:inputNew type="text" id="brdId" names="brdId" dto="brdId"  label="브랜드코드" labelClass="2" conClass="4" required="true" />
        <ifvm:inputNew type="text" id="brdNm" names="brdNm" dto="brdNm" label="브랜드명" labelClass="2" conClass="4" required="true" />
    </div>
    <div class="row qt_border">
        <ifvm:inputNew type="textarea" id="brdDescTxt" names="brdDescTxt" dto="brdDescTxt" label="브랜드 설명" labelClass="2" conClass="10" rows="10" />
    </div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray"  id="addBrdDtlBtn" objCode="addBrdDtlPopBtn_OBJ">
        <spring:message code="M00170" />
    </button>
    <button class="btn btn-sm btn_gray"  id="closePopBtn" objCode="closeBrdDtlPopBtn_OBJ">
        <spring:message code="L00941" />
    </button>
</div>
<div id="pgmPopupContainer" class="popup_container"></div>

<script type="text/javascript">
var brandDtlPop;

var brdDtlPop = function(){
    var _rid = ifvGlobal["brdRid"];
    // var _pgmRid = ifvGlobal["pgmRid"];
    // var _pgmNm = ifvGlobal["pgmNm"];
    var _formId = "brdDtlPopForm";
    var _loadedData = {};
    var _updatedData = {};

    this.setRid = function (rid) {
        _rid = rid;
    },
    this.getRid = function () {
        return _rid;
    },
    this.isNew = !$.fn.ifvmIsNotEmpty(this.getRid()) || this.getRid() === 'null',
    this.validation = $("#" + _formId).ifvValidation(),
    this.fields = $.ifvGetFields(_formId),
    this.optionFields =[], // select 필드값
    this.init = function(){
        if (!this.isNew) {
            this.loadBrandDetail();
        }
        this.action();
    },
    this.loadBrandDetail = function(){

        var _callback = function (result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                // 필드의 데이터 로드
                _loadedData = $.extend(true, {}, result);
                $.ifvLoadFormData(result, this.fields, this.optionFields);
            }
        }
        $.ifvSyncPostJSON('<ifvm:action name="getBrandDetail"/>', { rid: this.getRid() }, _callback.bind(this));
    },
    this.onSubmit = function () {
        if(this.validation.confirm()) {
            var _submitUrl = this.isNew ? '<ifvm:action name="addBrand"/>' : '<ifvm:action name="editBrand"/>';

            /* submit을 위한 Form 데이터 파라미터 세팅 */
            var _setSubmitParams = function () {

                var vObj = $.ifvGetFieldData(this.fields, this.optionFields);

                _updatedData = $.extend(true, {}, vObj);

                if (!this.isNew) {
                    vObj['rid'] = this.getRid();
                }

                return vObj;
            }

            /* 제출 후 알럿창 */
            var _afterSubmit = function () {
                alert('<spring:message code="L00127"/>');
                this.close();
                brandList = new getBrandList();
                brandList.bandListGrid();
            };

            $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));
        }

    },
    this.close = function(){  //닫기
        popupContainer._destroy();
    },
    this.action = function(){

        $("#addBrdDtlBtn").click(function(){
            this.onSubmit();
        }.bind(this));

        $("#closePopBtn").click(function(){
            this.close();
        }.bind(this));

    }

}

function getPgmList(){
    openPop('<ifvm:url name="pgmListPop"/>', '<spring:message code="L02716"/>', 'pgmPopupContainer');
}

//팝업
function openPop(url, title, id){
    $("#"+id).ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : url,
        contentType : "ajax",
        title : title,
        width : '900px',
        close : 'closePop',
    });
}
function closePop(){
    $.fn.ifvmPopupClose();
}

$(document).ready(function(){
    brandDtlPop = new brdDtlPop();
    brandDtlPop.init();
});

</script>
