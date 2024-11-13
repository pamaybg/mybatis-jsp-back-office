<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>

var intactRid = '<%= cleanXss(request.getParameter("intactRid")) %>';

/**
 * 화면 조회 
 * 
 * 1. 수정 화면일 경우
 *  - 상세 내용 조회
 */
function detailPop_getIntactDtl() {
    if ($.fn.ifvmIsNotEmpty(intactRid)) {

        // 상세 조회 
        $.ifvSyncPostJSON('<ifvm:action name="getIntactItem"/>', {
            rid : intactRid
        }, function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                
                $("#intactType1Cd").val(result.intactType1Cd); // 유형 코드
                $("#intactType1Cd").change();
                $("#intactType2Cd").val(result.intactType2Cd);  // 유형 상세 코드

                $("#saveTblNm").val(result.saveTblNm);        // 저장 테이블명
            }
        });
    }
}

/**
 * 작성한 상세 데이터 가져오기
 */
function detailPop_getDetailData() {

    var objData = {
        intactType1Cd : $("#intactType1Cd").val(), // 유형 코드
        intactType2Cd : $("#intactType2Cd").val(), // 하위 유형 코드
        saveTblNm : $("#saveTblNm").val()
    // 설명
    };

    return objData;
}

/**
 * 수정
 * 
 * 1. class명, function명 중복체크 
 * 2. 수정
 */
function detailPop_setIntact() {

    // validation 체크 
    var validation = $("#intactDetailPop").ifvValidation();

    if (validation.confirm() == true) {

        var objData = detailPop_getDetailData();
        objData.rid = intactRid;
        
        var checkCampaignsUsingIntectFlag = checkCampaignsUsingIntect(objData);
        
        // 사용중인 캠페인 체크 > 사용중인 캠페인이 없을 경우 
        if (checkCampaignsUsingIntectFlag == false) {
            
            // 중복체크
            $.ifvPostJSON('<ifvm:action name="checkDuplicationIntactType"/>', objData, function(chkResult) {

                // 중복 데이터 존재
                if (chkResult.chkCount > 0) {
                    alert("<spring:message code='M01289'/>");
                    return;
                }
                // 수정
                else {
                    $.ifvPostJSON('<ifvm:action name="editIntactItem"/>', objData, function(editResult) {
                        if (editResult.success == true) {
                            alert("<spring:message code='M00106'/>");
                            setIntactListGrid();    // 목록 조회
                            intactDetailPopClose(); // 팝업 닫기
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
function detailPop_addIntact() {

    // validation 체크 
    var validation = $("#intactDetailPop").ifvValidation();

    if (validation.confirm()) {

        var objData = detailPop_getDetailData();
        
        // 중복체크
        $.ifvPostJSON('<ifvm:action name="checkDuplicationIntactType"/>', objData, function(chkResult) {

            // 중복 데이터 존재
            if (chkResult.chkCount > 0) {
                alert("<spring:message code='M01289'/>");
                return;
            }
            // 등록
            else {
                $.ifvPostJSON('<ifvm:action name="addIntactItem"/>', objData, function(addResult) {
                    if (addResult.success == true) {
                        alert("<spring:message code='M00010'/>");
                        setIntactListGrid();    // 목록 조회
                        intactDetailPopClose(); // 팝업 닫기
                    }
                });
            }
        });
    }
}

$(document).ready(function() {

    // 콤보박스 호출 ( 유형 ) 
    $.fn.ifvmSetSelectOptionCommCode("intactType1Cd", "MKT_INTACT_TYPE", null, null, true);
    $.fn.ifvmSetSelectOptionCommCodeSync("intactType2Cd", "MKT_INTACT_DTL_TYPE", null, "intactType1Cd", true);
    
    // 저장 클릭시
    $('#intactDetailPopAddBtn').on('click', function() {
        
        // 등록
        if ($.fn.ifvmIsEmpty(intactRid)) {
            detailPop_addIntact();
        }
        // 수정
        else {
            detailPop_setIntact();
        }
    });

    // 닫기 클릭시
    $('#intactDetailPopCloseBtn').on('click', function() {
        intactDetailPopClose();
    });

    // 상세 데이터 셋팅
    detailPop_getIntactDtl();

});

</script>

<div id="dialogProgPopupWrap">
    <div class="pop_inner_wrap form-horizontal" id="intactDetailPop" >
        <div class="row qt_border">
            <label class="control-label col-xs-2">
                <span class="asterisk">*</span>
                <spring:message code="M00755"/>
            </label>
            <div class="control_content col-xs-4">
                <ifvm:input type="select" names="intactType1Cd" id="intactType1Cd" required="true" />
            </div>
            <label class="control-label col-xs-2">
                <span class="asterisk">*</span>
                <spring:message code="M00755"/>
            </label>
            <div class="control_content col-xs-4">
                <ifvm:input type="select" names="intactType2Cd" id="intactType2Cd" required="true" />
            </div>
        </div>
        
        <!-- 저장 테이블명 -->
        <div class="row qt_border">
            <label class="control-label col-xs-2">
                <spring:message code="M02181"/>
            </label>
            <div class="control_content col-xs-10">
                <ifvm:input type="text" maxLength="25" id="saveTblNm" />
            </div>
        </div>
        
    </div>
    <br>
    <div class="pop_btn_area" style="height:60px;">
        <!-- 저장버튼 -->
        <button class="btn btn-sm btn_gray" id="intactDetailPopAddBtn" objCode="interactDetailPopAdd_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button>
        <!-- 닫기 버튼 -->
        <button class="btn btn-sm btn_lightGray2" id="intactDetailPopCloseBtn" objCode="interactDetailPopClose_OBJ">         
            <spring:message code="M00441"/>
        </button>
    </div>
</div>