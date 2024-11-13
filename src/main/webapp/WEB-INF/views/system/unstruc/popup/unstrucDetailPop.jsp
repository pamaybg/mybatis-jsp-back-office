<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var isNew = true; // 현재 팝업창이 신규인지 확인하는 값. 기본값 :: 신규

/**
 * 화면 조회 
 * 
 * 1. 수정 화면일 경우
 *  - 상세 내용 조회
 */
function getUnstrucDtl() {

    if (isNew == false) {

        // 상세 조회 
        $.ifvSyncPostJSON('<ifvm:action name="getUnstrucItem"/>', {
            rid : unstrucRId
        }, function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {

                // 화면에 setting 
                
                $("#nodeTypeCd").val(result.nodeTypeCd); // 유형 코드
                $("#nodeTypeCd").change();
                $("#subTypeCd").val(result.subTypeCd);   // 하위유형 코드

                $("#execCls").val(result.execCls);       // class명
                $("#execMthd").val(result.execMthd);     // function 명
                $("#inputScrn").val(result.inputScrn);   // 이름
                $("#desctxt").text(result.desctxt);      // 설명
            }
        });
    }
}

/**
 * 작성한 상세 데이터 가져오기
 */
function getDetailData() {
    
    var data = {
        nodeTypeCd : $("#nodeTypeCd").val(), // 유형 코드
        subTypeCd : $("#subTypeCd").val(),   // 하위 유형 코드
        execCls : $("#execCls").val(),       // class명
        execMthd : $("#execMthd").val(),     // function명
        inputScrn : $("#inputScrn").val(),   // 이름
        desctxt : $("#desctxt").val()        // 설명
    };
    
    return data;
}

/**
 * 수정
 * 
 * 1. class명, function명 중복체크 
 * 2. 수정
 */
function setUnstruc() {

    // validation 체크 
    var validation = $("#unstrucDetailPop").ifvValidation();

    if (validation.confirm()) {

        var data = getDetailData();
        data.rid = unstrucRId;
        
        var isUsingByCampaignFlag = isUsingByCampaign(data);
        
        // 사용중인 캠페인 체크 > 사용중인 캠페인이 없을 경우 
        if (isUsingByCampaignFlag == false) {
            
            // 중복체크
            $.ifvPostJSON('<ifvm:action name="getUnstrucChk"/>', data, function(chkResult) {

                // 중복 데이터 존재
                if (chkResult.chkCount > 0) {
                    alert("<spring:message code='M01289'/>");
                    return;
                }
                // 수정
                else {
                    $.ifvPostJSON('<ifvm:action name="editUnstrucItem"/>', data, function(editResult) {
                        if (editResult.success == true) {
                            alert("<spring:message code='M00106'/>");
                            setUnstrucListGrid();    // 목록 조회
                            unstrucDetailPopClose(); // 팝업 닫기
                        }
                    });
                }
            });
        }
    }
}

/**
 * 등록
 * 
 * 1. class명, function명 중복체크 
 * 2. 등록
 */
function addUnstruc() {

    // validation 체크 
    var validation = $("#unstrucDetailPop").ifvValidation();

    if (validation.confirm()) {

        var data = getDetailData();
        
        // 중복체크
        $.ifvPostJSON('<ifvm:action name="getUnstrucChk"/>', data, function(chkResult) {

            // 중복 데이터 존재
            if (chkResult.chkCount > 0) {
                alert("<spring:message code='M01289'/>");
                return;
            }
            // 등록
            else {
                $.ifvPostJSON('<ifvm:action name="addUnstrucItem"/>', data, function(addResult) {
                    if (addResult.success == true) {
                        alert("<spring:message code='M00010'/>");
                        setUnstrucListGrid();    // 목록 조회
                        unstrucDetailPopClose(); // 팝업 닫기
                    }
                });
            }
        });
    }
}

$(document).ready(function() {

    if (editOperatingFlag == "NEW_ITEM")
        isNew = true;
    else
        isNew = false;
    
    // 저장 클릭시
    $('#unstrucDetailPopAddBtn').on('click', function() {
        
        // 등록
        if (isNew == true) {
            addUnstruc();
        }
        // 수정
        else {
            setUnstruc();
        }
    });

    // 닫기 클릭시
    $('#unstrucDetailPopCloseBtn').on('click', function() {
        unstrucDetailPopClose();
    });

    // 콤보박스 호출 ( 유형, 하위유형 ) 
    $.fn.ifvmSetSelectOptionCommCode("nodeTypeCd", "MKT_NODE_TYPE_CD", null, null, true);
    $.fn.ifvmSetSelectOptionCommCodeSync("subTypeCd", "MKT_CAM_NODE_TYPE", null, "nodeTypeCd", true);

    // 상세 데이터 셋팅
    getUnstrucDtl();

});

</script>

<div id="dialogProgPopupWrap">
    <div class="pop_inner_wrap form-horizontal" id="unstrucDetailPop" >
        <div class="row qt_border">
            <label class="control-label col-xs-2">
                <span class="asterisk">*</span>
                <spring:message code="M00755"/>
            </label>
            <div class="control_content col-xs-4">
                <ifvm:input type="select" names="nodeTypeCd" id="nodeTypeCd" required="true" />
            </div>
            <label class="control-label col-xs-2">
                <span class="asterisk">*</span>
                <spring:message code="M02176"/>
            </label>
            <div class="control_content col-xs-4">
                <ifvm:input type="text" required="true" maxLength="25" id="execCls" />
            </div>
        </div>
        <div class="row qt_border">
            <label class="control-label col-xs-2">
                <span class="asterisk">*</span>
                <spring:message code="M02174"/>
            </label>
            <div class="control_content col-xs-4">
                <ifvm:input type="select" names="subTypeCd" id="subTypeCd" required="true" />
            </div>
            <label class="control-label col-xs-2">
                <span class="asterisk">*</span>
                <spring:message code="M02177"/>
            </label>
            <div class="control_content col-xs-4">
                <ifvm:input type="text" required="true" maxLength="25" id="execMthd" />
            </div>
        </div>
        
        <div class="row qt_border">
            <label class="control-label col-xs-2">
                <span class="asterisk">*</span>
                <spring:message code="M02175"/>
            </label>
            <div class="control_content col-xs-10">
                <ifvm:input type="text" required="true" maxLength="25" id="inputScrn" />
            </div>
        </div>
        <div class="row">
            <label class="control-label col-xs-2">
                <spring:message code="L00340"/>
            </label>
            <div class="control_content col-xs-10">
                <ifvm:input type="textarea" rows="4" id="desctxt" maxLength="200"/>
            </div>
        </div>
        
    </div>
    <div class="pop_btn_area" style="height:60px;">
        <!-- 저장버튼 -->
        <button class="btn btn-sm btn_gray" id="unstrucDetailPopAddBtn" objCode="unstrucDetailPopAdd_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button>
        <!-- 닫기 버튼 -->
        <button class="btn btn-sm btn_lightGray2" id="unstrucDetailPopCloseBtn" objCode="unstrucDetailPopClose_OBJ">         
            <spring:message code="M00441"/>
        </button>
    </div>
</div>