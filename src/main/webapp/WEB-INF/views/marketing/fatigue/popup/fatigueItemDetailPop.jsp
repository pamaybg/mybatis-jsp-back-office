<%--
  Created by IntelliJ IDEA.
  User: hr.noh
  Date: 2022-01-24
  Time: 오전 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M01037"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r"></div>
    </div>
    <div class="well form-horizontal underline" id="fatigueItemDetailForm" >
        <div class="row  qt_border">
            <ifvm:inputNew type="select"  id="chnlTypeCd" dto="chnlTypeCd" names="chnlTypeCd" label="채널" labelClass="1" conClass="4" required="true"/>
            <ifvm:inputNew type="select" id="fatiItemState" names="fatiItemState" dto="fatiItemState" label="상태" labelClass="2" conClass="4"/>
        </div>
        <div class="row qt_border">
            <ifvm:inputNew type="text" id="fatiItemRestrictionDay" dto="fatiItemRestrictionDay" label="기한(일)" labelClass="1" conClass="3"/>
            <ifvm:inputNew type="text" id="fatiItemMaxRestrictionDayCnt" dto="fatiItemMaxRestrictionDayCnt" label="횟수(일)" labelClass="1" conClass="3"/>
            <ifvm:inputNew type="select" id="fatiItemRestrictionDayYn" names="fatiItemRestrictionDayYn" dto="fatiItemRestrictionDayYn" title="제한 일 사용 여부" label="사용여부" labelClass="1" conClass="2"/>
        </div>
        <div class="row qt_border">
            <ifvm:inputNew type="text" id="fatiItemRestrictionWeek" dto="fatiItemRestrictionWeek" label="기한(주)" labelClass="1" conClass="3"/>
            <ifvm:inputNew type="text" id="fatiItemMaxRestrictionWeekCnt" dto="fatiItemMaxRestrictionWeekCnt" label="횟수(주)" labelClass="1" conClass="3"/>
            <ifvm:inputNew type="select" id="fatiItemRestrictionWeekYn" names="fatiItemRestrictionWeekYn" dto="fatiItemRestrictionWeekYn" title="제한 주 사용 여부"  label="사용여부" labelClass="1" conClass="2"/>
        </div>
        <div class="row qt_border">
            <ifvm:inputNew type="text" id="fatiItemRestrictionMon" dto="fatiItemRestrictionMon" label="기한(월)" labelClass="1" conClass="3"/>
            <ifvm:inputNew type="text" id="fatiItemMaxRestrictionMonCnt" dto="fatiItemMaxRestrictionMonCnt" label="횟수(달)" labelClass="1" conClass="3"/>
            <ifvm:inputNew type="select" id="fatiItemRestrictionMonYn" names="fatiItemRestrictionMonYn" dto="fatiItemRestrictionMonYn" title="제한 달 사용 여부" label="사용여부" labelClass="1" conClass="2"/>
        </div>
        <div class="row qt_border">
            <ifvm:inputNew type="text" id="fatiItemRestrictionYear" dto="fatiItemRestrictionYear" label="기한(년)" labelClass="1" conClass="3"/>
            <ifvm:inputNew type="text" id="fatiItemMaxRestrictionYearCnt" dto="fatiItemMaxRestrictionYearCnt" label="횟수(년)" labelClass="1" conClass="3"/>
            <ifvm:inputNew type="select" id="fatiItemRestrictionYearYn" names="fatiItemRestrictionYearYn" dto="fatiItemRestrictionYearYn" title="제한 년 사용 여부" label="사용여부" labelClass="1" conClass="2"/>
        </div>
    </div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="saveBtn" objCode="fatiItemSaveBtn_OBJ">
        <i class="glyphicon glyphicon-check" ></i>
        <spring:message code="I00745"/>
    </button>
    <button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="fatiItemPopCancelBtn_OBJ">
        <spring:message code="O00115"/>
    </button>
</div>

<script type="text/javascript">
var fatigueItemDetailPop;

var getFatigueItemDetailPop = function(){

    var _rid = ifvGlobal["fatigueChnlItemRid"] ? ifvGlobal["fatigueChnlItemRid"] : null;
    var _loadedData = {};
    var _updatedData = {};
    var _formId = "fatigueItemDetailForm";

    this.isNew = (!$.fn.ifvmIsNotEmpty(ifvGlobal["fatigueChnlItemRid"])) ? true : false,
    this.validation = $("#" + _formId).ifvValidation(),
    this.fields = $.ifvGetFields(_formId),
    this.optionFields = [
        { fieldName: "chnlTypeCd", commCode: "MKT_CAM_CHNL_TYPE_CD" },
        { fieldName: "fatiItemState", commCode: "MKT_FATI_STAT" },
        { fieldName: "fatiItemRestrictionDayYn", commCode: "COM_STAT_TYPE_3_CD" , option: "N"},
        { fieldName: "fatiItemRestrictionWeekYn", commCode: "COM_STAT_TYPE_3_CD", option: "N" },
        { fieldName: "fatiItemRestrictionMonYn", commCode: "COM_STAT_TYPE_3_CD" , option: "N"},
        { fieldName: "fatiItemRestrictionYearYn", commCode: "COM_STAT_TYPE_3_CD" , option: "N"}
    ],
    this.setRid = function(rid){
        _rid = rid;
    }
    this.getRid = function () {
        return _rid;
    },
    this.init = function(){
        var numArr = ['fatiItemMaxRestrictionDayCnt', 'fatiItemRestrictionDay'
            , 'fatiItemMaxRestrictionWeekCnt', 'fatiItemRestrictionWeek'
            , 'fatiItemMaxRestrictionMonCnt', 'fatiItemRestrictionMon'
            , 'fatiItemMaxRestrictionYearCnt', 'fatiItemRestrictionYear'
        ];
        this.NumberOnly(numArr);


        if(!this.isNew){
            this.formDataLoad();
        }else{
            $.ifvSetSelectOptions(this.optionFields);
            this.disabledTf(numArr, true)
        }
        //
        this.fatiMstValidCheck();
        this.action();
        $("#chnlTypeCd option[value='KAKAONOTI']").remove();

    },
    this.formDataLoad = function () {

        var _callback = function (result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                // 필드의 데이터 로드
                _loadedData = $.extend(true, {}, result);
                $.ifvLoadFormData(result, this.fields, this.optionFields);
                if(result.fatiItemRestrictionDayYn == "N"){
                    var arr = ["fatiItemRestrictionDay", "fatiItemMaxRestrictionDayCnt"];
                    this.disabledTf(arr, true);
                }
                if(result.fatiItemRestrictionWeekYn == "N"){
                    var arr = ["fatiItemRestrictionWeek", "fatiItemMaxRestrictionWeekCnt"];
                    this.disabledTf(arr, true);
                }
                if(result.fatiItemRestrictionMonYn == "N"){
                    var arr = ["fatiItemRestrictionMon", "fatiItemMaxRestrictionMonCnt"];
                    this.disabledTf(arr, true);
                }
                if(result.fatiItemRestrictionDayYn == "N"){
                    var arr = ["fatiItemRestrictionYear", "fatiItemMaxRestrictionYearCnt"];
                    this.disabledTf(arr, true);
                }
            }
        }
        $.ifvSyncPostJSON('<ifvm:action name="getFatigueItemDetail"/>', { id: this.getRid() }, _callback.bind(this));
    },
    //mst 데이터랑 비교하여 input값에 넣기
    this.fatiMstValidCheck = function(){
        var mstField = ["Day", "Week", "Mon", "Year"];
        mstField.forEach(function(e){
            if(ifvGlobal["fatiDetailInfo"]["fatiRestriction"+e+"Yn"] == 'Y'){
                var arr = ["fatiItemRestriction"+e+"Yn", "fatiItemRestriction"+e, "fatiItemMaxRestriction"+e+"Cnt"];
                this.disabledTf(arr, true);
                $("#fatiItemRestriction"+e).val(ifvGlobal["fatiDetailInfo"]["fatiRestriction"+e]);
                $("#fatiItemMaxRestriction"+e+"Cnt").val(ifvGlobal["fatiDetailInfo"]["fatiMaxRestriction"+e+"Cnt"]);
                $("#fatiItemRestriction"+e+"Yn").val(ifvGlobal["fatiDetailInfo"]["fatiRestriction"+e+"Yn"]);
            }
        }.bind(this))
    },
    this.onSubmit = function () {
        var _submitUrl = this.isNew ? '<ifvm:action name="addFatiItem"/>' : '<ifvm:action name="editFatiItem"/>';

        /* submit을 위한 Form 데이터 파라미터 세팅 */
        var _setSubmitParams = function () {

            var vObj = $.ifvGetFieldData(this.fields, this.optionFields);

            _updatedData = $.extend(true, {}, vObj);

            if (!this.isNew) {
                vObj['id'] = this.getRid();
            }
            vObj.ridFati = fatigueid;
            return vObj;
        }

        /* 제출 후 알럿창 */
        var _afterSubmit = function () {
            alert('<spring:message code="L00127"/>');
            var fatigueItemListForm = new getFatigueItemList();
            fatigueItemListForm.fatigueItemList();
            $.fn.ifvmPopupClose();
        };

        $.ifvSyncPostJSON(_submitUrl, _setSubmitParams.call(this), _afterSubmit.bind(this));

    },
    this.disabledTf = function(array, check){ //disabled 처리
        for(var i = 0; i<array.length; i++) $("#"+array[i]).prop("disabled", check);
    },
    this.setRequired = function(array, check){ // required 처리
        for(var i =0; i<array.length; i++) $("#"+array[i]).attr("required", check);
    },
    this.NumberOnly = function(array){	//콤마 없이 숫자만
        for(var i = 0; i<array.length; i++) $("#"+array[i]).onlyNumber();
    },
    //사용여부 체크
    this.isChecked = function(id, value){ //id : checkBox ID, vale : 제어해줄 inputBox
        if($("#"+ id).val() == "Y"){
            this.disabledTf(value, false);
            return true;
        }else{
            this.disabledTf(value, true);
            value.forEach(function(e){ $("#"+e).val("") })
            return false;
        }
    },
    this.action = function() {

        $("#saveBtn").on('click', function(){
            this.onSubmit();
        }.bind(this));

        $("#btnCancel").on('click', function(){
            $.fn.ifvmPopupClose();
        });

        $("#fatiItemRestrictionDayYn").change(function(){
            this.isChecked("fatiItemRestrictionDayYn",["fatiItemRestrictionDay","fatiItemMaxRestrictionDayCnt"]);
        }.bind(this));

        $("#fatiItemRestrictionWeekYn").change(function(){
            this.isChecked("fatiItemRestrictionWeekYn",["fatiItemRestrictionWeek","fatiItemMaxRestrictionWeekCnt"])
        }.bind(this));

        $("#fatiItemRestrictionMonYn").change(function(){
            this.isChecked("fatiItemRestrictionMonYn",["fatiItemRestrictionMon","fatiItemMaxRestrictionMonCnt"])
        }.bind(this));

        $("#fatiItemRestrictionYearYn").change(function(){
            this.isChecked("fatiItemRestrictionYearYn",["fatiItemRestrictionYear","fatiItemMaxRestrictionYearCnt"])
        }.bind(this));
    }
}

$(document).ready(function(){
    fatigueItemDetailPop = new getFatigueItemDetailPop();
    fatigueItemDetailPop.init();
});

</script>