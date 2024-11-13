<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
$(document).ready(function() {
    $('#groupNameSaveBtn').on('click', function(){
    	saveGroupName();
    });
    $('#groupNameCloseBtn').on('click', function(){
    	commCodeExGroupNamePopupClose(false);
    });
    init();
});

// 초기 화면 실행 시, 선택한 영역의 그룹명을 기본 값으로 보여준다.
function init() {
	$("#modifyGroupName").val(currentGroupCodeData.groupName);
}

// 그룹명 저장 함수
function saveGroupName() {
	$.ifvSyncPostJSON('<ifvm:action name="editCommCodeExGroupName"/>', {
		groupName: $("#modifyGroupName").val()
		, groupCode: currentGroupCodeData.groupCode
		, selectLang: currentGroupCodeData.lang
		, strSchema: $("#strSchema").val()
	}, function(result) {
		alert('<spring:message code="M00267" />');
		commCodeExGroupNamePopupClose(true);
	});
}
</script>

<div class="pop_inner_wrap">
	<div class="form-horizontal">
		<label class="col-xs-2 control-label two_line"><spring:message code="M00238" /></label>
		<div class="col-xs-9">
			<ifvm:input type="text" id="modifyGroupName" maxLength="50" />
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="groupNameSaveBtn" objCode="groupNameSaveBtn_OBJ"><spring:message code="M00280" /></button>
	<button class="btn btn-sm btn_lightGray2" id="groupNameCloseBtn" objCode="groupNameCloseBtn_OBJ"><spring:message code="M00441" /></button>
</div>