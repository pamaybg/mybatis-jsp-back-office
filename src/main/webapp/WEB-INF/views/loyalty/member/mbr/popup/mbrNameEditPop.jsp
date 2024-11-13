<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

/**
 * 비밀번호 수정
 *
 * @returns
 */

function mbrNameDetail_saveName() {

    if (mbrNameDetail_chkValidtaion() == false) {
        return;
    }

    $.ifvSyncPostJSON('<ifvm:action name="editCustName"/>', {
        rid : mbr_rid,
        prevCustNm : $("#prevMbrName").val(),
        newName : $('#mbrName').val(),
        mbrNo	: $('#mbrNo').val(),
        rmark   : $('#rmark').val()

    }, function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            if (result.success == true) {
                alert('<spring:message code="M00624"/>');
                gMbrDetail.loadData();
                editMbrNamePop.close();
            }
        }
    });
}

/**
 * 비밀번호 등록 가능 상태인지 체크
 *
 * @returns
 */
function mbrNameDetail_chkValidtaion() {
    var rtnFlag = true;
    var getMbrName = $('#mbrName').val();
	var getRmark = $("#rmark").val();

    if ($.fn.ifvmIsEmpty(getMbrName)) {
        alert('변경할 이름을 입력 해주세요.');
        rtnFlag = false;
    }
    else if ($.fn.ifvmIsEmpty(getRmark)) {
        alert('변경사유를 입력해주세요.');
        rtnFlag = false;
    }
    return rtnFlag;
}

$(document).ready(function() {

	$("#prevMbrName").val($("#mbrForm #custNm").val());
    $('#mbrNamePopAddBtn').on('click', function() {
    	mbrNameDetail_saveName();
    });

    // 닫기
    $('#mbrNamePopCloseBtn').on('click', function() {
    	editMbrUsePwPop.close();
    });
});

</script>

<div id="dialogProgPopupWrap">
    <div class="pop_inner_wrap form-horizontal" id="mbrNameEditPop" >
    <div class="page_btn_area">
			<div class="col-xs-7">
				<span>회원 이름 변경</span>
			</div>
		</div>
        <div class="row qt_border">
            <label class="control-label col-xs-4">
                <span class="asterisk">*</span>
           			기존 이름
            </label>
            <div class="control_content col-xs-8">
                <ifvm:input type="text" names="prevMbrName" id="prevMbrName" required="true"  disabled="true"/>
            </div>
        </div>
        <div class="row qt_border">
            <label class="control-label col-xs-4">
                <span class="asterisk">*</span>
               	변경 할 이름
            </label>
            <div class="control_content col-xs-8">
                <ifvm:input type="text" names="mbrName" id="mbrName" required="true" />
            </div>
        </div>
       	<div class="row qt_border">
        	 <ifvm:inputNew type="textarea" id="rmark" dto="rmark" label="변경사유" labelClass="4" conClass="8"  nuc="true" rows="3" required="true"/>
        </div>

    </div>
    <div class="pop_btn_area" style="height:60px;">
        <%-- 저장버튼 --%>
        <button class="btn btn-sm btn_gray" id="mbrNamePopAddBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button>
        <%-- 닫기버튼 --%>
        <button class="btn btn-sm btn_lightGray2" id="mbrNamePopCloseBtn">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>