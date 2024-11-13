<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var multiStage_camId = diagram._selectedObject.actualTaskId; // 캠페인ID
var multiStageInfo = {
        camId : multiStage_camId,   // 캠페인ID
        bfCamId : null,             // 선행 캠페인ID
        changeCamId : false,        // 캠페인 교체 여부
        
        // 캠페인 정보
        campaignName : null,
        campaignTypeCode : null,
        campaignDate : null,
        campaignStatusCodeName : null,
        
        // 멀티스테이지 조건 
        condition : [], 
};


// I:추가, U:수정, D:삭제

/**
 * 팝업 설정
 */
function initMultiStagePopup() {

    //팝업설정
    cDialog.model.title = '<spring:message code="M02368"/>';
    $("#dialog_title").append('<spring:message code="M02368"/>');
    cDialog.model.width = "450";
    cDialog.model.close = "multiStagePopupClose";
}

/**
 * 멀티스테이지 조건 조회
 */
function getMultiStageData() {

    $.ifvSyncPostJSON('<ifvm:action name="getMultiStage"/>', {
        camId : multiStage_camId
    }, function(result) {
        
        multiStageInfo = {};
        multiStageInfo.camId = multiStage_camId;
        multiStageInfo.bfCamId = null;
        multiStageInfo.changeCamId = false;
        multiStageInfo.condition = [];
        multiStageInfo.campaignTypeCode = null;
        multiStageInfo.campaignDate = null;
        multiStageInfo.campaignStatusCodeName = null;
        multiStageInfo.campaignName = null;
        
        // 선행 캠페인 정보
        var camInfo = result.campaignInfo;
        
        if ($.fn.ifvmIsEmpty(camInfo) == false) {
            multiStageInfo.bfCamId                = camInfo.id;
            multiStageInfo.campaignTypeCode       = camInfo.campaignTypeCode;
            multiStageInfo.campaignDate           = camInfo.campaignStartDate + ' ~ ' + camInfo.campaignEndDate;
            multiStageInfo.campaignStatusCodeName = camInfo.campaignStatusCodeName;
            multiStageInfo.campaignName           = camInfo.campaignName;
        }
        
        // 멀티스테이지 조건 
        var multiStageList = result.multiStageList;
        
        if ($.fn.ifvmIsEmpty(multiStageList) == false) {

            multiStageList.forEach(function(data) {
                
                data.dataStatus = 'N'
                multiStageInfo.bfCamId = data.bfCamId;
                multiStageInfo.condition.push(data);
                
                var conditionData = {
                        id : data.id,
                        camRspnsCd : data.camRspnsCd,
                        camRspnsNm : data.camRspnsNm
                }
                
            });
        }
        
        setMultiStageData();
        
        var temp = $("#conditionItemTemp").tmpl(multiStageList);
        $("#conditionDiv").append(temp);
    });
}

/**
 * 선행 캠페인 데이터 셋팅 
 * 멀티스테이지 조건 셋팅 
 */
function setMultiStageData() {

    $("#preCampaignInfo #name").text(multiStageInfo.campaignName);
    $("#preCampaignInfo #typeCode").text(multiStageInfo.campaignTypeCode);
    $("#preCampaignInfo #campaignDate").text(multiStageInfo.campaignDate);
    $("#preCampaignInfo #statusCodeName").text(multiStageInfo.campaignStatusCodeName);
    
    $("#camRspnsCdSelect").html("");
    $("#conditionDiv").html("");
    
    if ($.fn.ifvmIsNotEmpty(multiStageInfo.bfCamId)) {
        $.ifvSyncPostJSON('<ifvm:action name="getMultiStageCondition"/>', {
            bfCamId : multiStageInfo.bfCamId
        }, function(result) {
            var temp = $("#conditionSelectBoxTemp").tmpl(result);
            $("#camRspnsCdSelect").append(temp);
        });
    }
}

/**
 * 멀티 스테이지 팝업 닫음.
 */
function multiStagePopupClose() {
    cDialog._destroy();
}

/**
 * 선행 캠페인 선택 팝업 호출
 */
function previousCampaignPopupOpen() {
    
    $("#previousCampaignPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="previousCampaignPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M02453'/>",
        width: 500,
        close : 'previousCampaignPopupClose'
    });
}

/**
 * 선행 캠페인 선택 팝업 닫음.
 */
function previousCampaignPopupClose() {
    previousCampaignPopup._destroy();
}

/**
 * 멀티스테이지 조건 추가 
 */
function addCondition() {
    
    var selectCode = $("#camRspnsCdSelect").val();
    var selectName = $("#camRspnsCdSelect option:selected").text();
    
    // 추가할 데이터가 없을때 
    if ($.fn.ifvmIsEmpty(selectCode)) {
        alert('<spring:message code="M02377"/>');
    }
    // 멀티스테이지 조건 추가 
    else {
        // 없었던 데이터인 경우 신규  

        // 현재 데이터가 등록되어있고, 삭제 상태가 아닌 경우 -> 중복으로 등록이 불가 
        var getData = conditionGet(selectCode);
        if ( $.fn.ifvmIsEmpty(getData) == false && getData.dataStatus != 'D' ) {
            alert('<spring:message code="M00258"/>');
            return;
        }

        var data = {
                id: null,
                camRspnsCd: selectCode,
                camRspnsNm: selectName,
        };        
        conditionAdd(data);
        
        var temp = $("#conditionItemTemp").tmpl(data);
        $("#conditionDiv").append(temp);
    }
}

/**
 * 멀티 스테이지 조건 삭제
 */
function removeCondition(code) {
    
    // 목록에서 코드 상태 삭제로 변경
    conditionRemove(code);
    
    // 화면에서 삭제
    $("#conditionDiv [data-camRspnsCd=" + code + "]").parent().remove();
}

/**
 * 멀티 스테이지 저장
 */
function saveMultiStage() {

    var len = 0;
    multiStageInfo.condition.forEach(function(data) {
        if (data.dataStatus != 'D') {
            len++;
        }
    });
    
    if (len > 0 
            || (len == 0 && confirm('<spring:message code="M02391"/>') )) {
        $.ifvSyncPostJSON('<ifvm:action name="saveMultiStage"/>', multiStageInfo,
        function(result) {
            if (result.success == true) {
                alert('<spring:message code="L01822"/>');
                getMultiStageData();
                multiStagePopupClose();
            }
        });
    }
}

$(document).ready(function() {
    
    initMultiStagePopup();

    getMultiStageData();
    
    // 선행캠페인 조회 버튼
    $('#previousCampaignPopOpenBtn').on('click', function() {
        previousCampaignPopupOpen();
    });

    // 초기화 버튼
    $('#previousCampaignResetBtn').on('click', function() {
        
        multiStageInfo.bfCamId = null;
        
        multiStageInfo.campaignName = null;
        multiStageInfo.campaignTypeCode = null;
        multiStageInfo.campaignDate = null;
        multiStageInfo.campaignStatusCodeName = null;
        
        multiStageInfo.condition = [];
        multiStageInfo.changeCamId = true;
        
        // 화면 셋팅
        setMultiStageData();
    });

    // 멀티 스테이지 조건 추가 버튼
    $('#ConditionAddBtn').on('click', function() {
        addCondition();
    });

    // 저장 버튼
    $('#multiStageSaveBtn').on('click', function() {
        saveMultiStage();
    });
    
    // 닫기 버튼
    $('#multiStagePopupCloseBtn').on('click', function() {
        multiStagePopupClose();
    });
    
});

function conditionGet(_camRspnsCd) {
    
    var rtnData = null;
    
    multiStageInfo.condition.forEach(function(data) {
        if (data.camRspnsCd == _camRspnsCd) {
            rtnData = data;
        }
    });
    return rtnData;
}

function conditionAdd(_condition) {
    var edit = false;
    
    multiStageInfo.condition.forEach(function(data) {
        if (data.camRspnsCd == _condition.camRspnsCd) {
            data.dataStatus = 'U';
            edit = true;
        }
    });

    //등록
    if (edit == false) {
        _condition.id = null;
        _condition.dataStatus = 'I';
        multiStageInfo.condition.push(_condition);
    }
}

function conditionRemove(_camRspnsCd) {
    
    multiStageInfo.condition.forEach(function(data) {
        if (data.camRspnsCd == _camRspnsCd) {
            data.dataStatus = 'D'
        }
    });
    
}

</script>

<script id="conditionSelectBoxTemp" type="text/x-jquery-tmpl">
<option value="${'${'}camRspnsCd}">${'${'}camRspnsNm}</option>
</script>

<script id="conditionItemTemp" type="text/x-jquery-tmpl">

<div class="row qt_border condition_div">
    <div class="col-xs-9 control_content condition_item" data-camRspnsCd="${'${'}camRspnsCd}">${'${'}camRspnsNm}</div>
    <button class="btn btn-sm" id="ConditionDeleteBtn" onclick="removeCondition('${'${'}camRspnsCd}')">
        <spring:message code="L00080"/>
    </button>
</div>

</script>

<style>

#previousCampaign .control-label.label_txt {
    text-align: left;
}

#multiStageConditionBody {
    text-align: center;
}
    
#multiStageConditionBody .condition_div {
    margin-top: 10px;
    padding-left: 5px;
}

#multiStageConditionBody .condition_item {
    height: 22PX;
    text-align: left;
    background: lightgrey;
    border-radius: 4px;
    padding: 4px 10px;
}

</style>

<%-- 선행 캠페인 --%>
<div id="previousCampaign">
    <div class="page_btn_area" style="padding-right: 0px">
        <div class="col-xs-7">
            <span class="asterisk">*</span><span><spring:message code="M02370"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <%-- 조회 --%>
            <button class="btn btn-sm" id="previousCampaignPopOpenBtn">
                <spring:message code="M00135"/>
            </button>
            <%-- 초기화 --%>
            <button class="btn btn-sm" id='previousCampaignResetBtn'>
                <spring:message code="M00278"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal underline top_well" id="preCampaignInfo">
        
        <div class="row qt_border">
        
            <%-- 캠페인명 --%>
            <label class="col-xs-3 control-label"><spring:message code="M01056"/></label>
            <label class="col-xs-7 control-label label_txt" id="name"></label>
        </div>
    
        <div class="row qt_border">
        
            <%-- 캠페인 유형 --%>
            <label class="col-xs-3 control-label"><spring:message code="M01058"/></label>
            <label class="col-xs-7 control-label label_txt" id="typeCode"></label>
        </div>
    
        <div class="row qt_border">
        
            <%-- 캠페인 기간 --%>
            <label class="col-xs-3 control-label"><spring:message code="M00969"/></label>
            <label class="col-xs-7 control-label label_txt" id="campaignDate"></label>
        </div>
    
        <div class="row qt_border">
        
            <%-- 캠페인 상태 --%>
            <label class="col-xs-3 control-label"><spring:message code="L00418"/></label>
            <label class="col-xs-7 control-label label_txt" id="statusCodeName"></label>
        </div>
    </div>
</div>

<%-- 멀티 스테이지 조건 --%>
<div id="multiStageCondition">
    
    <div class="page_btn_area" style="padding-right: 0px">
        <div class="col-xs-7">
            <span><spring:message code="M02369"/></span>
        </div>
    </div>
    
    <div id="multiStageConditionBody" >
    
        <div class="well form-horizontal underline top_well" style="width: 320px; display: inline-block;">
            <div class="row qt_border">
                <div class="col-xs-9 control_content">
                    <ifvm:input type="select" id="camRspnsCdSelect" names="camRspnsCdSelect" />
                </div>
                <button class="btn btn-sm" id="ConditionAddBtn">
                    <spring:message code="V00066"/>
                </button>
            </div><%-- 
            <div class="row qt_border condition_div">
                <div class="col-xs-9 control_content condition_item" >MMS 전송</div>
                <button class="btn btn-sm" id="ConditionDeleteBtn">
                    <spring:message code="L00080"/>
                </button>
            </div> --%>
            
            <div id="conditionDiv"></div>
        </div>
    </div>
</div>

<div class="pop_btn_area">
    <button class="btn btn-sm btn_lightGray2" id="multiStageSaveBtn">         
        <spring:message code="V00003"/>
    </button>
    <button class="btn btn-sm btn_lightGray2" id="multiStagePopupCloseBtn">         
        <spring:message code="M00441"/>
    </button> 
</div>

<div id="previousCampaignPopup"></div>