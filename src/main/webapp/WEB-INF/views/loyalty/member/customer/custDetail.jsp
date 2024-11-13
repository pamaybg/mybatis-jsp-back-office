<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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

var cust_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var isNew = true;  //신규 여부. 신규: true, 수정 : false
var isMask = true;
var maskYN = '<%= cleanXss(request.getParameter("maskYN")) %>'; // 마스킹 된 상태
	if (maskYN != null && maskYN == "N")
		isMask = false;

	var validation;

	function dataLoad(cust_rid) {
		isNew = false; // 해당 함수는 수정모드일 경우에만 호출되므로, 신규 여부 플래그 값을 false로 세팅함.
		var action = isMask ? '<ifvm:action name="getCustDetail"/>'
				: '<ifvm:action name="clearMaskCust"/>';

		$.ifvSyncPostJSON(action, {
			rid : cust_rid
		}, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {

				$("#custNm").val(result.custNm); //고객명
				$("#custTypeCd").val(result.custTypeCd); //고객 유형 코드
				$("#identiTypeCd").val(result.identiTypeCd); //식별값유형
				$("#identiVal").val(result.identiVal); //식별값
				if (result.realnmCertiYn == "Y")
					$("#realnmCertiYn").attr("checked", true); //실명인증여부
				$("#realnmCertiDate").val(result.realnmCertiDate); //실명인증일자
				$("#birthDt").val(result.birthDt); //생년월일(인증)
				$("#genGbnCd").val(result.genGbnCd); //생년월일(인증)
				$("#realBirthDt").val(result.realBirthDt); //생년월일(실제)
				$("#lunarGbnCd").val(result.lunarGbnCd); //양/음력 구분

				//			if(action == false) isMask = false;
			}
		});
	}

	//저장
	function saveSubmit() {
		$.ifvSyncPostJSON(isNew ? '<ifvm:action name="addCust"/>'
				: '<ifvm:action name="editCust"/>', getObjForSubmit(),
				function(result) {
					alert('<spring:message code="L00127"/>');
					//location.href = '<ifvm:url name="custList"/>';
					qtjs.href('<ifvm:url name="custListNew"/>');

				}, function(result) {
					alert(result.message);
				}

		);
	}

	/*
	 submit을 위한 form 데이터 파라미터 세팅
	 */
	function getObjForSubmit() {
		var v_obj = {};
		//실명인증여부
		var v_realnmCertiYn = $.fn.ifvmIsNotEmpty($("#realnmCertiYn").attr(
				"checked")) ? "Y" : "N";

		if (isNew) {
			v_obj = {
				custNm : $("#custNm").val(),
				custTypeCd : $("#custTypeCd").val(),
				identiTypeCd : $("#identiTypeCd").val(),
				identiVal : $("#identiVal").val(),
				realnmCertiYn : v_realnmCertiYn,
				realnmCertiDate : $("#realnmCertiDate").val(),
//				birthDt : $("#birthDt").val(),
				birthDt : $("#birthDt").val().replaceAll("-",""),
				genGbnCd : $("#genGbnCd").val(),
//				realBirthDt : $("#realBirthDt").val(),
				realBirthDt : $("#realBirthDt").val().replaceAll("-",""),
				lunarGbnCd : $("#lunarGbnCd").val()
			};

		} else {
			v_obj = {
				rid : cust_rid,
				custNm : $("#custNm").val(),
				custTypeCd : $("#custTypeCd").val(),
				identiTypeCd : $("#identiTypeCd").val(),
				identiVal : $("#identiVal").val(),
				realnmCertiYn : v_realnmCertiYn,
				realnmCertiDate : $("#realnmCertiDate").val(),
				//birthDt : $("#birthDt").val(),
				birthDt : $("#birthDt").val().replaceAll("-",""),
				genGbnCd : $("#genGbnCd").val(),
//				realBirthDt : $("#realBirthDt").val(),
				realBirthDt : $("#realBirthDt").val().replaceAll("-",""),
				lunarGbnCd : $("#lunarGbnCd").val()
			};
		}

		return v_obj;

	}

	//저장 버튼클릭 시 동작
	function actionSave() {
		if (validation.confirm())
			saveSubmit();
	}

	function actionClearMask() {

	}

	$(function() {
		$.fn.ifvmSetSelectOptionCommCode("custTypeCd", "LOY_CUST_TYPE_CD", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("identiTypeCd", "LOY_IDENTI_TYPE_CD", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("lunarGbnCd", "LOY_LUNAR_GBN_CD", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("genGbnCd", "LOY_GEN_CD", null, null, false);

		//고객유형코드
		/* $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'LOY_CUST_TYPE_CD',
			enableNA : true
		}, function(result) {
			var temp = $("#custTypeCdTemp").tmpl(result.rows);
			$("#custTypeCd").append(temp);
		});

		//회원식별유형
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'LOY_IDENTI_TYPE_CD',
			enableNA : true
		}, function(result) {
			var temp = $("#identiTypeCdTemp").tmpl(result.rows);
			$("#identiTypeCd").append(temp);
		});

		//양음력 구분
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'LOY_LUNAR_GBN_CD',
			enableNA : true
		}, function(result) {
			var temp = $("#lunarGbnCdTemp").tmpl(result.rows);
			$("#lunarGbnCd").append(temp);
		});

		//성별
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'LOY_GEN_CD',
			enableNA : true
		}, function(result) {
			var temp = $("#genGbnCdTemp").tmpl(result.rows);
			$("#genGbnCd").append(temp);
		}); */

		if ($.fn.ifvmIsNotEmpty(cust_rid) && cust_rid != "null")
			dataLoad(cust_rid); //수정 시

	});

	function btnActive() {
		if (isNew) { //신규일 경우
			$('#btnMasking').prop('disabled', true); //마스킹해제 버튼 disable
		} else { // 수정모드 일경우
			if (isMask)
				$('#btnSave').prop('disabled', true); //마스킹 된 상태일때는 저장버턴 비활성화
			else
				$('#btnMasking').prop('disabled', true); //마스킹해제 버튼 disable
		}

	}

	function setCalendar() {
		var realnmCertiDate = $("#realnmCertiDate");
		var birthDt = $("#birthDt");
		var realBirthDt = $("#realBirthDt");

		realnmCertiDate.ifvDateChecker({});
		birthDt.ifvDateChecker({});
		realBirthDt.ifvDateChecker({});
	}

	function checkButtnAuth() {
		var isAuth = false;
		var authArr = $.ifvmGetAuthInfo().authList;
		for (var i = 0; i < authArr.length; i++) {
			var authObj = authArr[i];
			var authName = authObj.authName;
			if (authName == 'E10010')
				isAuth = true;
		}
		if (!isAuth) {
			$("#orangeCardUnmaskingBtn").remove();
		}

	}

	$(document)
			.ready(
					function() {
						//마스킹해제 권한 체크
						//checkButtnAuth();
						// 	btnActive();

						$.ifvmLnbSetting('custListNew'); //Left Menue 세팅

						// 	$("#btnMasking").click(function(){
						// 		actionSave();
						//     });

						$("#btnSave").click(function() {
							actionSave();
						});

						//달력세팅
						setCalendar();

						$("#birthDt").click(function() {
							if ($("#birthDt").val() == "") {
								var birthDt = $("#birthDt");
								birthDt.val($.ifvGetTodayDate());
								birthDt.ifvDateChecker({});
							}
						});

						$("#realnmCertiDate").click(function() {
							if ($("#realnmCertiDate").val() == "") {
								var realnmCertiDate = $("#realnmCertiDate");
								realnmCertiDate.val($.ifvGetTodayDate());
								realnmCertiDate.ifvDateChecker({});
							}
						});

						$("#realBirthDt").click(function() {
							if ($("#realBirthDt").val() == "") {
								var realBirthDt = $("#realBirthDt");
								realBirthDt.val($.ifvGetTodayDate());
								realBirthDt.ifvDateChecker({});
							}
						});

						$("#btnMasking")
								.click(
										function() {
											//actionClearMask();
// 											location.href = '<ifvm:url name="custDetail"/>'
// 													+ '?maskYN=N&rid='
// 													+ cust_rid;
											qtjs.href('<ifvm:url name="custDetail"/>' + '?maskYN=N&rid=' + cust_rid);
										});

						
						$("#btnList").click(function() {
							//location.href = '<ifvm:url name="custList"/>';
							qtjs.href('<ifvm:url name="custListNew"/>');
						});

						validation = $("#custForm").ifvValidation();

						setCalendar();
					});
</script>

<!-- 고객유형 -->
<script id="custTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!--식별 유형 코드  -->
<script id="identiTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- 성별 -->
<script id="genGbnCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<!-- 양/음력 구분  -->
<script id="lunarGbnCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>


<style>
.well {
	margin-bottom: 0;
}

.top_well {
	border-bottom: 0;
}
</style>

<div class="page-title">
	<h1>
		<spring:message code="L00431" />
		&gt; <spring:message code="L00316" />
	</h1>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-7">
		<span><spring:message code="L00317" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
<%-- 		<button class="btn btn-sm" id="btnSave" >
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="L00125" />
		</button> --%>
		<%-- 		<button class="btn btn-sm" id="btnMasking"><spring:message code="L00326"/></button> --%>
		<button class="btn btn-sm" id="btnList" objCode="custDetailbtnList_OBJ">
			<spring:message code="M00002" />
		</button>
	</div>
</div>


<div class="form-horizontal underline top_well" id="custForm">
	<div class="row  qt_border">
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>
		<spring:message code="L00320" /></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" required="true" id="custNm" />
		</div>

		<label class="col-xs-2 control-label"><span class="asterisk">*</span>
		<spring:message code="L00318" /></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" required="true" id="custTypeCd"  names="custTypeCd"/>
		</div>

	</div>
	<div class="row  qt_border">
		<label class="col-xs-1 control-label"><span class="asterisk">*</span>
		<spring:message code="L00343" /></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" required="true" id="identiTypeCd" names="identiTypeCd" />
		</div>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>
		<spring:message code="L00342" /></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" required="true" id="identiVal" />
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-1 control-label"><spring:message
				code="L00344" /></label>
		<div class="col-xs-4 control_content">
			<label class="checkbox-inline"> <ifvm:input type="checkbox"
					id="realnmCertiYn" />
			</label>
		</div>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>
		<spring:message code="L00345" /></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="date" required="true" id="realnmCertiDate" />
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-1 control-label"><spring:message
				code="L00339" /></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="date" id="birthDt" />
		</div>
		<label class="col-xs-2 control-label"><spring:message
				code="L00341" /></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" id="genGbnCd"  names="genGbnCd"/>
		</div>
	</div>

	<div class="row qt_border">
		<label class="col-xs-1 control-label"><spring:message
				code="L00338" /></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="date" id="realBirthDt" />
		</div>
		<label class="col-xs-2 control-label"><spring:message
				code="L00379" /></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="select" id="lunarGbnCd" names="lunarGbnCd" />
		</div>
	</div>

</div>

<div id="tabArea"></div>
<div id="custAddInfoDialog" class="popup_container"></div>
<script>
var custDetailTab = $('#tabArea').DrawTab({
	item: [
		{label: '<spring:message code="L00333"/>', href: '<ifvm:url name="custAddInfoListNew"/>'}, //부가정보
		{label: '<spring:message code="L00856"/>', href: '<ifvm:url name="memberListNew"/>'}, //멤버십 회원
	]
});
</script>
<%-- <div id="tabArea">
	<div class="btn-group btn-group-justified" style="z-index: 1;"
		id="tabType">
		<a href="javascript:;" class="btn btn-default btn-tab active"
			id="custAddInfoList"><spring:message code="L00333" /></a> <a
			href="javascript:;" class="btn btn-default btn-tab" id="memberList"><spring:message
				code="L00856" /></a>
	</div>
	<div>
		<div class="page_btn_area" id=''>
			<div class="col-xs-7">
				<span id="tabName"></span>
			</div>
			<div class="col-xs-5 searchbtn_r" id="custAddInfoBtnArea">
				<button class="btn btn-sm" id="addCustAddInfoBtn">
					<i class="fa fa-plus"></i>
					<spring:message code="L00078" />
				</button>
				<button class="btn btn-sm" id="removeCustAddInfoBtn">
					<i class="fa fa-minus"></i>
					<spring:message code="L00080" />
				</button>

			</div>

		</div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
		<div id="custAddInfoDialog" class="popup_container"></div>
	</div>

</div> --%>

<!-- <script>
	$('#tabArea .btn.btn-default.btn-tab').on('click', function() {
		changeContent($(this).attr('id'), 'tabContent');
	});

	function changeContent(type, tab) {
		var cUrl;

		switch (type) {

		case 'custAddInfoList':
			cUrl = '<ifvm:url name="custAddInfoList"/>';
			$('#tabName').text('<spring:message code="L00333"/>');
			$('#custAddInfoBtnArea').show();
			break;

		case 'memberList':
			cUrl = '<ifvm:url name="memberList"/>';
			$('#tabName').text('<spring:message code="L00856"/>');
			$('#custAddInfoBtnArea').hide();
			break;
		default:
			break;
		}

		$.ifvCachedHtml(cUrl).done(function(script, textStatus) {
			var cTab = $("#" + tab);

			$('#tabContent').empty();
			$('#tabArea .btn.btn-default.btn-tab').removeClass('active');
			$('#' + type).addClass('active');

			cTab.empty();
			cTab.html('');
			cTab.append(script);

			var fileName = cUrl.split('/').pop();

			if (window[fileName + '_init'] != null)
				window[fileName + '_init']();

		});
	}
</script>

<script>
	$(function() {
		changeContent('custAddInfoList', 'tabContent');
	});
</script> -->

