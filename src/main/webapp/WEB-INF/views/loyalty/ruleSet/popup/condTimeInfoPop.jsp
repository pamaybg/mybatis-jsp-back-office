<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
/**
 * 거래시간 초기 세팅 00-24(h)
 */
function initCondTimeInfoPop() {
	var _obj = [];
	var _i = ""
	for(var i=0; i<25; i++) {
		_i = i.toString().length < 2 ? "0"+i : i.toString();
		_obj.push({code : _i, name : '<spring:message code="L02272" arguments="' + _i + '"/>'})
	}
	
	$("#condTimePopDiv #startTime").append($("#CommonListTemp").tmpl(_obj));
	$("#condTimePopDiv #endTime").append($("#CommonListTemp").tmpl(_obj));
	
	$('#condTimePopDiv #endTime').val(24);
}

/**
 * 거래시간 수정할 데이터 세팅
 */
function initCondTimeInfoPopData(data) {
	$("#condTimePopDiv #startTime").val(data.startTime);
	$("#condTimePopDiv #endTime").val(data.endTime);
}

$(document).ready(function() {
	initCondTimeInfoPop();

	//저장
	$('#condTimeInfoPopSaveBtn').on('click', function() {
		condTimeInfoPopupSave();
	});

	//닫기
	$('#condTimeInfoPopCancelBtn').on('click', function() {
		condTimeInfoPopupClose();
	});
	
	if(condTimePopupOpenType=="E"){
		initCondTimeInfoPopData(selCondTimeData);
	}
});
</script>

<script id="CommonListTemp" type="text/x-jquery-tmpl">
	<option value=${'${'}code}>${'${'}name}</option>
</script>

<div class="pop_inner_wrap form-horizontal" id="condTimePopDiv">
	<div class="row qt_border">
		<label class="col-xs-3 span control-label"><span class="asterisk">*</span><spring:message code='L00352'/></label>
		<div class="col-xs-3" style="padding-right:13px;">
			<ifvm:input type="select" id="startTime" names="startTime"/>
		</div>
		<div class="col-xs-1 swung_dash">~</div>
		<div class="col-xs-3" style="padding-left:13px;">
			<ifvm:input type="select" id="endTime" names="endTime"/>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm" id="condTimeInfoPopSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code='M01855' />
	</button>
	<button class="btn btn-sm" id="condTimeInfoPopCancelBtn">
		<spring:message code="M00441" />
	</button>
</div>