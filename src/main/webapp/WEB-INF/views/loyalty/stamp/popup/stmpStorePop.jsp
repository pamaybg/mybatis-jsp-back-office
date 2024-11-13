<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var stmpStoreFormValidation;
var condChnlListPopup;

function condChnlListPopClose(){
	condChnlListPopup._destroy();
}

//채널 목록 팝업 닫기
function stmpStoreListPopClose() {
	condChnlListPopup._destroy();
}

//채널 목록 팝업 선택
function condChnlListPopupSelect() {
	if ($.fn.ifvmIsNotEmpty(condChnlListPopGrid.getCheckedList())) {
		var selData = condChnlListPopGrid.getCheckedList()[0];
		$("#stmpStoreForm #chnlNm").val(selData.chnlNm);	//채널명
		$("#stmpStoreForm #chnlId").val(selData.chnlNo);	//채널코드
		$("#stmpStoreForm #ridChnl").val(selData.rid);	    //rid

		//close popup
		stmpStoreListPopClose();
	} else {
		alert("<spring:message code='L00173'/>");

		return false;
	}
}

function saveStmpStore() {
	$.ifvPostJSON( '<ifvm:action name="setLoyStmpStore"/>', {
		ridStmp : ridStmp
		, ridChnl : $("#stmpStoreForm #ridChnl").val()
	}, function(result){
		alert("<spring:message code='L00076'/>");
		stmpStoreList.searchGrid({});
		stmpStoreNewPopClose();
	}, function(result) {
		if(result.message === '1') {
			alert('이미 등록된 적용채널입니다.');
		} else {
			$.errorChecker(result);
		}
	});
}

$(document).ready(function() {
	stmpStoreFormValidation = $("#stmpStoreForm").ifvValidation();

	//저장 클릭시
    $('#stmpStorePopSaveBtn').on('click', function(){
    	saveStmpStore();
    });

    //닫기 클릭시
    $('#stmpStorePopCancelBtn').on('click', function(){
    	stmpStoreNewPopClose();
    });

    $("#chnlSearchBtn").removeClass("hidden");
	$('#chnlSearchBtn').on('click', function(){
		$("#condChnlListPopup").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="condChnlListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="L00172"/>',
	        width: '600px',
	        close : 'stmpStoreListPopClose'
	    });
	});
});

</script>
	<div class="pop_inner_wrap form-horizontal" id="stmpStoreForm" >
		<div class="row qt_border">
	       <label class="col-xs-3 control-label"><spring:message code="L00279"/></label>
	        <div class="col-xs-9 control_content">
	            <div class="input-group">
		            <ifvm:input type="text" id="chnlId" readonly="true"/>
					<span class="input-group-addon" id="chnlSearchBtn">
					<a><i class="fa fa-search"></i></a>
					</span>
					<ifvm:inputNew type="hidden" id="ridChnl" maxLength="50"  dto="ridChnl"     labelClass="0" conClass="2" />
				</div>
	        </div>
		</div>
		<div class="row qt_border">
	       <label class="col-xs-3 control-label"><spring:message code="L00280"/></label>
	        <div class="col-xs-9 control_content">
	            <div class="input-group">
		            <ifvm:input type="text" id="chnlNm" readonly="true"/>
				</div>
	        </div>
		</div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm" id="stmpStorePopSaveBtn" objCode="stmpStorePopSaveBtn_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code='M01855'/>
	    </button>
	    <button class="btn btn-sm" id="stmpStorePopCancelBtn" objCode="stmpStorePopCancelBtn_OBJ">
	        <spring:message code="M00441"/>
	    </button>
	</div>

<div id="condChnlListPopup" class="popup_container"></div>
