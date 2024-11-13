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
function mbrPwdDetail_savePassword() {

    if (mbrPwdDetail_chkPassword() == false) {
        return;
    }

    $.ifvSyncPostJSON('<ifvm:action name="editMbrPwd"/>', {
        rid : mbr_rid,
        pntUsePw : $('#pntUsePw').val(),
        mbrNo	: $('#mbrNo').val(),
        rmark   : $('#rmark').val()

    }, function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            if (result.success == true) {
                alert('<spring:message code="M00624"/>');
                gMbrDetail.loadData();
                editMbrUsePwPop.close();
            }
        }
    });
}

/**
 * 비밀번호 등록 가능 상태인지 체크
 *
 * @returns
 */
function mbrPwdDetail_chkPassword() {
    var rtnFlag = true;
    var getPassword = $('#pntUsePw').val();
    var getConfirmPassword = $('#confirmPntUsePw').val();
	var getRmark = $("#rmark").val();
    if ($.fn.ifvmIsEmpty(getPassword)) {
        alert('<spring:message code="M02233"/>');
        rtnFlag = false;
    }
    else if ($.fn.ifvmIsEmpty(getConfirmPassword)) {
        alert('<spring:message code="M02235"/>');
        rtnFlag = false;
    }
    else if ($.fn.ifvmIsEmpty(getRmark)) {
        alert('변경사유를 입력해주세요.');
        rtnFlag = false;
    }
    else if (getPassword.length < 8 ) {
        alert('비밀번호는 8자이상 입력해주세요.');
        rtnFlag = false;
    }
    else if (getPassword != getConfirmPassword) {
        alert('<spring:message code="M02236"/>');
        rtnFlag = false;
    }
    return rtnFlag;
}

$(document).ready(function() {

    // 저장
    $('#mbrPwdPopAddBtn').on('click', function() {
        mbrPwdDetail_savePassword();
    });

    // 닫기
    $('#mbrPwdPopCloseBtn').on('click', function() {
    	editMbrUsePwPop.close();
    });
});

</script>

<div id="dialogProgPopupWrap">
    <div class="pop_inner_wrap form-horizontal" id="unstrucDetailPop" >
    <div class="page_btn_area">
			<div class="col-xs-7">
				<span>회원  로그인 비밀번호 변경</span>
			</div>
		</div>
        <div class="row qt_border">
            <label class="control-label col-xs-4">
                <span class="asterisk">*</span>
                <spring:message code="M00584"/>
            </label>
            <div class="control_content col-xs-8">
                <ifvm:input type="password" names="pntUsePw" id="pntUsePw" required="true" />
            </div>
        </div>
        <div class="row qt_border">
            <label class="control-label col-xs-4">
                <span class="asterisk">*</span>
                <spring:message code="M02229"/>
            </label>
            <div class="control_content col-xs-8">
                <ifvm:input type="password" names="confirmPntUsePw" id="confirmPntUsePw" required="true" />
            </div>
        </div>
       	<div class="row qt_border">
        	 <ifvm:inputNew type="textarea" id="rmark" dto="rmark" label="변경사유" labelClass="4" conClass="8"  nuc="true" rows="3" required="true"/>
        </div>

    </div>
    <div class="pop_btn_area" style="height:60px;">
        <%-- 저장버튼 --%>
        <button class="btn btn-sm btn_gray" id="mbrPwdPopAddBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button>
        <%-- 닫기버튼 --%>
        <button class="btn btn-sm btn_lightGray2" id="mbrPwdPopCloseBtn">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>