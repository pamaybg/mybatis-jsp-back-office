<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

/* 제어관련 플래그 */
var isNew 			= true;		// 현재 팝업창이 신규인지 확인하는 값. 기본값 :: 신규
var isGroupCode 	= false;	// 현재 팝업창이 그룹코드를 등록하는지 확인하는 값. 기본값 :: 그룹코드 아님
var isContinue		= false;	// 계속할지 여보 값. 코드 등록에만 사용 (그룹코드 X) 기본값 :: 계속하지 않음

/* 팝업창 내에서 사용될 변수 */
var userInfo = $.ifvmGetUserInfo();	// 유저 정보

var objCommCodeExParPopup;

$(document).ready(function() {
	
    $('#btnSave').on('click', function(){
    	isContinue = false;
    	commCodeExSave();
    });    
    $('#btnSaveAndContinue').on('click', function(){
    	isContinue = true;
    	commCodeExSave();
    });   
    $('#btnClosePop').on('click', function(){
    	commCodeExDetailPopupClose(false);
    }); 
    $('#findParCode').on('click', function(){
    	commCodeExParPopupOpen();
    }); 
    $("#btnSaveAndContinue").hide();
    
    $("#validationArea #groupCode").on('blur', function() {
    	var varMarkCode = $("#validationArea #groupCode").val() + "_" + $("#validationArea #codeName").val()
    	$("#validationArea #markCode").val(varMarkCode);
    });
	$("#validationArea #codeName").on('blur', function() {
		var varMarkCode = $("#validationArea #groupCode").val() + "_" + $("#validationArea #codeName").val()
    	$("#validationArea #markCode").val(varMarkCode);
    });
	
	init(editOperatingFlag);
});

/* 초기화면 구성 함수 */
function init(editOperatingFlag) {
	getCommonCodeForLang();						// 언어 콤보박스를 만드는 함수
	getCommonCodeForCountry();					// 국가 콤보박스를 만드는 함수
	initCommCodeExData(editOperatingFlag);		// 초기 화면 구성 및 데이터를 세팅해주는 함수
}

/* 초기 데이터를 세팅하는 함수 */
function initCommCodeExData(editOperatingFlag) {
	if($.fn.ifvmIsNotEmpty(currentRowData)) {
		currentRowData.selectLang = currentRowData.lang;
		currentRowData.selectCountry = currentRowData.country;
	}
	if(editOperatingFlag == "MODIFY_CODE") { // 코드 수정일 경우
		isNew = false;	// 신규가 아님을 확인 (업데이트 사용)
		
		$("#validationArea").dataSetting(currentRowData, null, true, ['seq', 'markName', 'attrib01', 'selectCountry', 'attrib02', 'attrib03', 'attrib04', 'attrib05','type', 'parCodeNm']);
	} else if(editOperatingFlag == "NEW_CODE") { // 코드 신규일 경우
		$("#btnSaveAndContinue").show();		 // 저장 후 계속하기 버튼을 활성화 
		$("#validationArea").dataSetting(currentGroupCodeData, null, true, ['seq', 'markName', 'attrib01', 'selectCountry', 'attrib02', 'attrib03', 'attrib04', 'attrib05', 'codeName','type']);
	} else {
		// 그룹코드 등록일 경우, 화면의 기본값을 보여줌
		isGroupCode = true;
	}
}

/* 저장함수 */
function commCodeExSave() {
	var validation = $("#validationArea").ifvValidation();
	
	if( validation.confirm() == false ) return;		// 유효성 검사
	
	var obj = $('#validationArea').getSubmitData();	// 입력된 값을 obj에 저장
	
	// isNew - 신규여부 확인. 신규일 경우 그룹코드 확인 
	$.ifvPostHeaderJSON(isNew ? (isGroupCode ? '<ifvm:action name="addCommCodeExGroupCode"/>' : '<ifvm:action name="addCommCodeExCodeName"/>') : '<ifvm:action name="editCommCodeExCodeProperty"/>', obj, {
		// 추가적인 파라미터 없음
	}, function(result) {
		alert('<spring:message code="M00267" />');
		if(isContinue) {
			clearCommCodeArea(); // 저장 후 계속하기라면, 인풋박스를 클리어 시킴
			commCodeExCodeList._doAjax();
			commCodeExCodeList._doAjax();
			//reflashCommCodeExList();
		} else {
			// 계속하는게 아니라면
			$.fn.ifvmPopupClose();
			commCodeExGroupList._doAjax();
			commCodeExCodeList._doAjax();
			//commCodeExDetailPopupClose(true); // 부모창에 선언된 닫기 함수 호출
		}
	}, function(result) {
		if(result.message == "DUPLICATE_GROUP") {					// 같은 그룹코드가 같은 언어 내에 존재할 경우
			alert('<spring:message code="M01706" />');
			commCodeExGroupList._doAjax();
			commCodeExCodeList._doAjax();
		} else if(result.message == "DUPLICATE_CODE") {				// 같은 코드가 같은 언어내에 존재할 경우
			alert('<spring:message code="M01707" />');
			commCodeExGroupList._doAjax();
			commCodeExCodeList._doAjax();
		}
	});
}

/* 입력 영역을 클리어 시킴 */
function clearCommCodeArea() {
	//저장후 계속할시 기존에 가지고 있던 type을 가지고 있어야한다.
	//$.fn.ifvmSetSelectOptionCommCode("type", "COM_CATEGORY_TYPE_CD", null, null, false);
	$("#validationArea #seq").val("");
	$("#validationArea #codeName").val("");
	$("#validationArea #markName").val("");
	$("#validationArea #markCode").val("");
	$("#validationArea #parCodeId").val("");
	$("#validationArea #attrib01").val("");
	$("#validationArea #attrib02").val("");
	$("#validationArea #attrib03").val("");
	$("#validationArea #attrib04").val("");
	$("#validationArea #attrib05").val("");
}

//조건에 따라 화면을 갱신시키는 함수
function reflashCommCodeExList() {
	commCodeExGroupSearch();
}

/* 국가 콤보박스를 세팅하는 함수 */
function getCommonCodeForCountry() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeExCountryCode"/>', {
	}, function(result) {
		var temp = $("#selectLangPopTemplate").tmpl(result.items);
		$("#validationArea #selectCountry").append(temp);
		if(isNew){
			$("#validationArea #selectCountry").val(countryType);	
		}
		
	});
}

/* 언어 콤보박스를 세팅하는 함수 */
function getCommonCodeForLang() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'LANG_TYPE'
		,schemas : 'com'
		, enableNA : false
	}, function(result) {
		for (var i=0; i<result.rows.length; i++) {
			if (result.rows[i].codeName != "NA") {
				result.rows[i].codeName = result.rows[i].codeName.toLowerCase();
			}
		}

		var temp = $("#selectLangPopTemplate").tmpl(result.rows);
		$.fn.ifvmSetSelectOptionCommCode("type", "COM_CATEGORY_TYPE_CD", null, null, false);
		$("#validationArea #selectLang").append(temp);
		if(isNew){
			$("#validationArea #selectLang").val(langType);	
		}
	});
}

function commCodeExParPopupOpen() {
	currentParCodeId = null;
	objCommCodeExParPopup = $("#commCodeExParDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="commCodeExParCodePop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01708" />',
        width: 720,
        close : 'commCodeExParPopupClose'
    });
}

function commCodeExParPopupClose() {
	objCommCodeExParPopup.ejDialog('destroy');
}
</script>

<script id="selectLangPopTemplate" type="text/x-jquery-tmpl">
	<option value="${'${'}codeName}">${'${'}codeName}</option>
</script>

<div class="well underline form-horizontal" id="validationArea" >			

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="LO2683" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="type" names="type" dto="type"  required="true"/>
			</div>
		</div>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00236" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="schema" dto="strSchema" text="M00252" values="com" checkIndex="1" disabled="true"/>
			</div>
		</div>
		<label class="col-xs-3 control-label"><span class="asterisk">*</span>ID</label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="id" dto="id" disabled="true" />
			</div>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00241" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="groupCode" dto="groupCode" maxLength="50" required="true" autoCompleted="true"/>
			</div>
		</div>
		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00238" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="groupName" dto="groupName" maxLength="50" required="true" />
			</div>
		</div>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00240" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="seq" dto="seq" maxLength="11" required="true" valiItem="number" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><spring:message code="M00245" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="flag" dto="flag" text="M00253|M00165" values="1|0" checkIndex="1"  />
			</div>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00244" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="codeName" dto="codeName" maxLength="50" required="true" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00243" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="markName" dto="markName" maxLength="50" required="true" />
			</div>
		</div>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00242" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="markCode" dto="markCode" maxLength="100" required="true" disabled="true" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><spring:message code="M00260" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="parCodeNm" dto="parCodeNm" disabled="true" />
				<ifvm:input type="hidden" id="parCodeId" dto="parCodeId" disabled="true" />
				<span style="cursor:pointer" class="input-group-addon manageHideItem" id="findParCode"><a><i class="fa fa-search"></i></a></span>
			</div>
		</div>		
	</div>

	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00237" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="selectLang" dto="selectLang" />
			</div>
		</div>
		<%-- <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00246" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="select" id="selectCountry" dto="selectCountry" />
			</div>
		</div> --%>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="M00261" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="attrib01" dto="attrib01" maxLength="100"/>
			</div>
		</div>
		<label class="col-xs-3 control-label"><spring:message code="M00262" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="attrib02" dto="attrib02" maxLength="100"/>
			</div>
		</div>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="M00263" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="attrib03" dto="attrib03" maxLength="100" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><spring:message code="M00264" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="attrib04" dto="attrib04" maxLength="100" />
			</div>
		</div>
	</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="M00265" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="attrib05" dto="attrib05" maxLength="100"/>
			</div>
		</div>
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><spring:message code="M00248" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="createBy" dto="createBy" disabled="true" />
			</div>
		</div>	
		<label class="col-xs-3 control-label"><spring:message code="M00249" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="createDate" dto="createDate" disabled="true" />
			</div>
		</div>
	</div>

	<div class="row">
		<label class="col-xs-2 control-label"><spring:message code="M00250" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="modifyBy" dto="modifyBy" disabled="true" />
			</div>
		</div>
		<label class="col-xs-3 control-label"><spring:message code="M00251" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="modifyDate" dto="modifyDate" disabled="true" />
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button id="btnSaveAndContinue" class="btn btn-sm btn_gray" objCode="commonCodeExDetailPopContinue_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M01709" />
	</button> 
	<button id="btnSave" class="btn btn-sm btn_gray" objCode="commonCodeExDetailPopSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00170" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnClosePop" objCode="commonCodeExDetailPopClose_OBJ">
		<spring:message code="M00441" />
		</button>
</div>

<div id="commCodeExParDialog" class="popup_container"></div>