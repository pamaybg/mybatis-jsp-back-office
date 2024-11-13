<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.*, java.text.*"%>
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
var testViewList_rid = '<%= cleanXss(request.getParameter("rid")) %>';
	var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID
	var manualDtlValid;
	var chnlObj = null;
	var tempObj = {};
	var doubleSubmitFlag = false;
	var reloadCheck = false;
	function manualDetailDataLoad(testViewList_rid) {
		if (testViewList_rid != "null") {
			$.ifvSyncPostJSON('<ifvm:action name="getManualDetail"/>', {
				rid : testViewList_rid
			}, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {

					$($('#manualDetailForm').find('input')).each(function(index, item){
				 			$(item).val(result.rows[0][$(item).attr('id')]);
			 		});

					$($('#manualDetailForm').find('select')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);
			 		});

					$($('#manualDetailForm').find('textarea')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);
			 		});

					//내가 요청한 건만 결재 요청 취소 가능
					 if(result.rows[0].createBy != $.ifvmGetUserInfo().empId){
						 $("#cancelInsBtn").prop('disabled',true);
					 }


				}

				if ($("#dtlTrtStatus").val() != "00" ) {
					$("#inspectionReqBtn").attr("disabled", true);
				}
				if ($("#dtlTrtStatus").val() != "50" ) {
					$("#cancelInsBtn").attr("disabled", true);
				}

				if ($("#dtlTrtStatus").val() != "00" && $("#dtlTrtStatus").val() != "40")  {
					$("#inspectionReqBtn").attr("disabled", true);
					$("#vanImmediateApprovalBtn").attr("disabled", true);
				}

				if (  ($("#dtlTrtStatus").val() != "20"  && $("#dtlTrtStatus").val() != "40")
						|| $.ifvmGetUserInfo().empId != $("#ridActc").val()) {
					$("#vanApprovalBtn").attr("disabled", true);
				}
				//van 승인 or 검수요청 끝난후 잠금처리
				if ($("#dtlTrtStatus").val() != "00" &&$("#dtlTrtStatus").val() != "98") {
					$($('#manualDetailForm').find('select')).attr("disabled", true)
					$($('#manualDetailForm').find('input')).attr("disabled", true)
					$($('#manualDetailForm').find('textarea')).attr("disabled", true)
				}

				if($("#dtlTrtStatus").val() == "98"){
					$("#saveManualInfoBtn, #vanImmediateApprovalBtn, #inspectionReqBtn").prop('disabled',false);

				}
				tempObj = result.rows[0];
			});
		} else {
			$("#dtlTrtStatus").val("00");
			$("#dtlApvRpy").val("");

			if($("#dtlChnlNm").val()==""){
				$.ifvSyncPostJSON('<ifvm:action name="selectE1ChannelSetting"/>', {
					chnlNo : "10000"
				}, function(result) {
					if (result.records != 0) {
						var obj = result.rows[0];
						$("#dtlChnlNm").val(obj.chnlNm);
						$("#dtlChnlNo").val(obj.chnlNo);
						$("#dtlBizrNo").val(obj.bizrNo);
						$("#dtlApvRqtInstn").val(obj.apvRqtInstn);
						$("#ridChnl").val(obj.rid);
					}
				})
			}
		}
		buttonValid();
		numberFormatterSetting();
		dateFormatSetting();
	}

	function buttonValid(){
		if($("#ridActc").val()!=$.ifvmGetUserInfo().empId){
			$("#vanApprovalBtn").addClass("hidden");
			$("#inspectionReqBtn").removeClass("hidden");
			$("#saveManualInfoBtn").removeClass("hidden");
			$("#stampInfoDetailBtn").removeClass("hidden");
			$("#vanImmediateApprovalBtn").removeClass("hidden");
		}else{
			$("#vanImmediateApprovalBtn").addClass("hidden");
			$("#vanApprovalBtn").removeClass("hidden");
			$("#inspectionReqBtn").addClass("hidden");
			$("#saveManualInfoBtn").addClass("hidden");
			$("#stampInfoDetailBtn").addClass("hidden");
		}
		if($("#dtlTrtStatus").val()!="00" && $("#dtlTrtStatus").val()!="" && $("#dtlTrtStatus").val()!="98"){
			$("#saveManualInfoBtn").attr("disabled",true);
			$("#btnChannelSearch").addClass("hidden");
			$("#btnMemSearch").addClass("hidden");
			$("#inspectorhSearchBtn").addClass("hidden");
			$("#approverSearchBtn").addClass("hidden");
		}


	}
	function vanApprovalFn() {
		if (checkRequirdField()) { //1.필수 항목 check
			var submitData = $("#manualDetailForm").getSubmitData();
			submitData.ridActc = $("#ridActc").val();
			submitData.ridApv = $("#ridApv").val();
			submitData.ridChnl = $("#ridChnl").val();
			submitData.dtlRqtPoint = $("#dtlRqtPoint").val().replace(/[^\d]+/g,
					'');
			submitData.ridMbr = $("#ridMbr").val();
			submitData.rid = $("#rid").val();
			submitData.dtlStblAftrPointBlnc = $("#dtlStblAftrPointBlnc").val()
					.replace(/[^\d]+/g, '');


			$.ifvSyncPostJSON('<ifvm:action name="vanApprovalReq"/>',
					submitData, function(result) {
						alert(result.message);
						manualDetailDataLoad(testViewList_rid);
						dateFormatSetting();
					}, function(result) {
					});
		}
	}

	function vanImmediateApprovalFn() {
		if (checkRequirdField()) { //1.필수 항목 check
			var submitData = $("#manualDetailForm").getSubmitData();
			submitData.ridActc = $("#ridActc").val();
			submitData.ridApv = $("#ridApv").val();
			submitData.ridChnl = $("#ridChnl").val();
			submitData.dtlRqtPoint = $("#dtlRqtPoint").val().replace(/[^\d]+/g, '');
			submitData.ridMbr = $("#ridMbr").val();
			submitData.rid = $("#rid").val();
			submitData.dtlStblAftrPointBlnc = $("#dtlStblAftrPointBlnc").val().replace(/[^\d]+/g, '');

			//이중클릭 방지
			if(doubleSubmitCheck()) return;
			$.ifvSyncPostJSON('<ifvm:action name="vanImmediateApproval"/>',
					submitData, function(result) {
						if (result.expandObj == "VANUpdate") {
							alert(result.message);
							manualDetailDataLoad(testViewList_rid);
						}else{
							alert(result.message);
							qtjs.href('<ifvm:url name="manualDetail"/>?rid='+result.expandObj);
						}
					}, function(result) {
						//이중클릭 방지
						doubleSubmitFlag=false;
						if (result.message == "aNull") {
							if ($("#dtlRidActc").val() == "") {
								$.ifvCallValidationBox($("#dtlRidActc"),
										"<spring:message code='C00024'/>");
							} else if ($("#dtlRidApv").val() == "") {
								$.ifvCallValidationBox($("#dtlRidApv"),
										"<spring:message code='C00024'/>");
							}
							return;
						} else {
							alert(result.message);
						}
					});
		}
	}

	function checkRequirdField(isVanReq) {
		manualDtlValid = $("#manualDetailForm").ifvValidation();
		if (manualDtlValid.confirm() == true) {
			if ($("#dtlCustNm").val() == "") {
				$.ifvCallValidationBox($("#dtlCustNm"),
						"<spring:message code='C00024'/>");
				return false;
			} else if ($("#dtlChnlNm").val() == "") {
				$.ifvCallValidationBox($("#dtlChnlNm"),
						"<spring:message code='C00024'/>");
				return false;
			} else {
				return true;
			}
		} else {
			return false;
		}
	}

	function inspectionReqFn() {
		if (checkRequirdField()) { //1.필수 항목 check
			if($("#dtlRqtType").val() == "STMP" && $("#dtlPointType").val() == "P"){//요청유형이 '스탬프'일때  포인트 유형이 '수동 적립'일 수 없음
				alert('<spring:message code="L02123"/>');
				return;
			}
			var submitData = $("#manualDetailForm").getSubmitData();
			submitData.ridActc = $("#ridActc").val();
			submitData.ridApv = $("#ridApv").val();
			submitData.ridChnl = $("#ridChnl").val();
			submitData.dtlRqtPoint = $("#dtlRqtPoint").val().replace(/[^\d]+/g, '');
			submitData.ridMbr = $("#ridMbr").val();
			submitData.rid = $("#rid").val();
			submitData.dtlStblAftrPointBlnc = $("#dtlStblAftrPointBlnc").val().replace(/[^\d]+/g, '');
			if($("#rid").val()==""){
				reloadCheck =true;
			}
				$.ifvSyncPostJSON('<ifvm:action name="inspectionReq"/>',
						submitData, function(result) {
							alert(result.message);
							if(reloadCheck){
								testViewList_rid = result.expandObj.rid;
								qtjs.href('<ifvm:url name="manualDetail"/>' + '?rid=' + testViewList_rid );
							}else{
								manualDetailDataLoad(testViewList_rid);
							}
						}, function(result) {
							if (result.message == "aNull") {
								if ($("#dtlRidActc").val() == "") {
									$.ifvCallValidationBox($("#dtlRidActc"),
											"<spring:message code='C00024'/>");
								} else if ($("#dtlRidApv").val() == "") {
									$.ifvCallValidationBox($("#dtlRidApv"),
											"<spring:message code='C00024'/>");
								}
								return;
							} else {
								alert(result.message);
								if(result.expandObj != null){
									testViewList_rid = result.expandObj.rid;
									qtjs.href('<ifvm:url name="manualDetail"/>' + '?rid=' + testViewList_rid );
								}
							}

						});
		}

	}

	function channelSearchFn() {
		channelSearchPopOpen('<ifvm:url name="channelSearchHelp"/>'
				+ '?ouTypeCd=' + 'A')
	}

	function channelSearchHelpEnter() {
		if ($('#dtlChnlNm').val() == "") {
			$('#ridChnl').val("");
			$('#dtlBizrNo').val("");
			$("#dtlChnlNo").val("");
			$("#dtlApvRqtInstn").val("");
		} else {
			channelSearchPopOpen('<ifvm:url name="channelSearchHelp"/>?ouTypeCd=A&&chnlNm='
					+ encodeURI(encodeURIComponent($('#dtlChnlNm').val())));
		}
	}

	function channelSearchHelpBlur() {
		if ($('#dtlChnlNm').val() == "") {
			$('#ridChnl').val("");
			$('#dtlBizrNo').val("");
			$("#dtlChnlNo").val("");
			$("#dtlApvRqtInstn").val("");
		} else {
			channelSearchPopOpen('<ifvm:url name="channelSearchHelp"/>?ouTypeCd=A&&chnlNm='
					+ encodeURI(encodeURIComponent($('#dtlChnlNm').val())));
		}
	}

	function channelSearchPopOpen(url) {
		channelSearchHelpPop = {
			id : "channelSearchPopDiv"
		};
		channelSearchHelpPop.popup = function() {
			channelSearchHelpPop.pop = $('#' + channelSearchHelpPop.id)
					.ifvsfPopup({
						enableModal : true,
						enableResize : false,
						contentUrl : url,
						contentType : "ajax",
						title : "<spring:message code='L00987'/>",
						width : "700px"
					});
		};
		channelSearchHelpPop.beforeClose = function(obj) {
		};
		channelSearchHelpPop.close = function(obj) {
			if (obj != null || typeof obj != "undefined") {
				$("#dtlChnlNm").val(obj.chnlNm);
				$("#dtlChnlNo").val(obj.chnlNo);
				$("#dtlBizrNo").val(obj.bizrNo);
				$("#ridChnl").val(obj.rid);
				$("#dtlApvRqtInstn").val(obj.apvRqtInstn);
				tempObj.dtlChnlNm = obj.chnlNm;
			} else {
				$("#dtlChnlNm").val(tempObj.dtlChnlNm);
			}
			this.beforeClose(obj);
			channelSearchPopDiv._destroy();
		};
		channelSearchHelpPop.popup();
	}

	function mbrSearchHelpEnter() {
		if ($('#dtlCustNm').val() == "") {
			$('#ridMbr').val("");
			$('#dtlMbrNo').val("");
			$("#dtlMemDiv").val("");
			$("#dtlMemGrade").val("");
		} else {
			mbrSearchPopOpen('<ifvm:url name="mbrSearchHelp"/>?mbrNm='
					+ encodeURI(encodeURIComponent($('#dtlCustNm').val())));
		}
	}

	function mbrSearchHelpBlur() {
		if ($('#dtlCustNm').val() == "") {
			$('#ridMbr').val("");
			$('#dtlMbrNo').val("");
			$("#dtlMemDiv").val("");
			$("#dtlMemGrade").val("");
		} else {
			mbrSearchPopOpen('<ifvm:url name="mbrSearchHelp"/>?mbrNm='
					+ encodeURI(encodeURIComponent($('#dtlCustNm').val())));
		}
	}

	function mbrSearchFn() {
		mbrSearchPopOpen('<ifvm:url name="mbrSearchHelp"/>')
	}

	function mbrSearchPopOpen(url) {
		mbrSearchHelpPop = {
			id : "mbrSearchPopDiv"
		};
		mbrSearchHelpPop.popup = function() {
			mbrSearchHelpPop.pop = $('#' + mbrSearchHelpPop.id).ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : url,
				contentType : "ajax",
				title : "<spring:message code='L00988'/>",
				width : "700px",
			});
		};
		mbrSearchHelpPop.beforeClose = function(obj) {
		};
		mbrSearchHelpPop.close = function(obj) {
			if (obj != null || typeof obj != "undefined") {
				$("#dtlCustNm").val(obj.custNm);
				$("#dtlMbrNo").val(obj.mbrNo);
				$("#ridMbr").val(obj.rid);
				$("#dtlMemDiv").val(obj.memDiv);
				$("#dtlMemGrade").val(obj.tierCd);
				tempObj.dtlCustNm = obj.custNm;
			} else {
				$("#dtlCustNm").val(tempObj.dtlCustNm);
			}
			this.beforeClose(obj);
			mbrSearchPopDiv._destroy();
		};
		mbrSearchHelpPop.popup();
	}

	function inspectorSearchFn() {
		inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>' + '?authNm='
				+ 'E10007')
	}

	function inspectorSearchHelpEnter() {
		if ($('#dtlRidActc').val() == "") {
			$('#ridActc').val("");
		} else {
			inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>'
					+ '?authNm=E10007&&name='
					+ encodeURI(encodeURIComponent($('#dtlRidActc').val())));
		}
	}

	function inspectorSearchHelpBlur() {
		if ($('#dtlRidActc').val() == "") {
			$('#ridActc').val("");
		} else {
			inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>'
					+ '?authNm=E10007&&name='
					+ encodeURI(encodeURIComponent($('#dtlRidActc').val())));
		}
	}

	function inspectorSearchPopOpen(url) {

		empSearchHelpPop = {
			id : "empSearchPopDiv"
		};
		empSearchHelpPop.popup = function() {
			empSearchHelpPop.pop = $('#' + empSearchHelpPop.id).ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : url,
				contentType : "ajax",
				title : "<spring:message code='L00989'/>",
				width : "700px",
			});
		};
		empSearchHelpPop.beforeClose = function(obj) {
		};
		empSearchHelpPop.close = function(obj) {
			if (obj != null || typeof obj != "undefined") {
				if(obj.rid==$.ifvmGetUserInfo().empId){
					alert("<spring:message code='L01867'/>");
					return;
				}

				if (obj.authNm == 'E10007') {
					$("#dtlRidActc").val(obj.name);
					$("#ridActc").val(obj.rid);
					tempObj.dtlRidActc = obj.name;
				}
			} else {
				$("#dtlRidActc").val(tempObj.dtlRidActc);
			}
			this.beforeClose(obj);
			empSearchPopDiv._destroy();
		};
		empSearchHelpPop.popup();
	}

	function approverSearchHelpEnter() {
		if ($('#dtlRidApv').val() == "") {
			$('#ridApv').val("");
		} else {
			approverSearchHelpOpenPop('<ifvm:url name="empSearchHelp"/>'
					+ '?authNm=E10008&&name='
					+ encodeURI(encodeURIComponent($('#dtlRidApv').val())));
		}
	}

	function approverSearchHelpBlur() {
		if ($('#dtlRidApv').val() == "") {
			$('#ridApv').val("");
		} else {
			approverSearchHelpOpenPop('<ifvm:url name="empSearchHelp"/>'
					+ '?authNm=E10008&&name='
					+ encodeURI(encodeURIComponent($('#dtlRidApv').val())));
		}
	}

	function approverSearchHelpOpenPop(url) {
		empSearchHelpPop = {
			id : "empSearchPopDiv"
		};
		empSearchHelpPop.popup = function() {
			empSearchHelpPop.pop = $('#' + empSearchHelpPop.id).ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : url,
				contentType : "ajax",
				title : "<spring:message code='L00990'/>",
				width : "700px"
			});
		};
		empSearchHelpPop.beforeClose = function(obj) {
		};
		empSearchHelpPop.close = function(obj) {
			if (obj != null || typeof obj != "undefined") {

				if(obj.rid==$.ifvmGetUserInfo().empId){
					alert("<spring:message code='L01868'/>");
					return;
				}
				if (obj.authNm == 'E10008') {
					$("#dtlRidApv").val(obj.name);
					$("#ridApv").val(obj.rid);
					tempObj.dtlRidApv = obj.name;
				}
			} else {
				$("#dtiRidApv").val(tempObj.dtlRidApv)
			}
			this.beforeClose(obj);
			empSearchPopDiv._destroy();
		};
		empSearchHelpPop.popup();
	}
	function approverSearchFn() {
		approverSearchHelpOpenPop('<ifvm:url name="empSearchHelp"/>'
				+ '?authNm=' + 'E10008')
	}

	function saveManualInfoFn() {
		manualDtlValid = $("#manualDetailForm").ifvValidation();
		if (manualDtlValid.confirm() == true) {
			if ($("#dtlCustNm").val() == "") {
				$.ifvCallValidationBox($("#dtlCustNm"),
						"<spring:message code='C00024'/>");

			} else if ($("#dtlChnlNm").val() == "") {
				$.ifvCallValidationBox($("#dtlChnlNm"),
						"<spring:message code='C00024'/>");
			} else if($("#dtlRqtType").val() == "STMP" && $("#dtlPointType").val() == "P"){//요청유형이 '스탬프'일때  포인트 유형이 '수동 적립'일 수 없음
				alert('<spring:message code="L02123"/>');
				return;
			}


			else {
				var submitData = $("#manualDetailForm").getSubmitData();
				//			submitData.dtlCustNm = $("#dtlCustNm").val();
				//		submitData.dtlChnlNm = $("#dtlChnlNm").val();
				submitData.ridActc = $("#ridActc").val();
				submitData.ridApv = $("#ridApv").val();
				submitData.ridChnl = $("#ridChnl").val();
				submitData.ridMbr = $("#ridMbr").val();
				if (testViewList_rid == "null") { //신규
					//이중클릭 방지
					if(doubleSubmitCheck()) return;
						$.ifvSyncPostJSON('<ifvm:action name="insertManualInfo"/>',
								submitData, function(result) {
									alert('<spring:message code="I00741"/>');
									testViewList_rid=result.message;
									location.replace('<ifvm:url name="manualDetail"/>' + '?rid=' + testViewList_rid );
								});

				} else { //수정
					submitData.rid = testViewList_rid;
					$.ifvSyncPostJSON('<ifvm:action name="updateManualInfo"/>',
							submitData, function(result) {
								alert('<spring:message code="M00106"/>');
								manualDetailDataLoad(testViewList_rid);
							});
				}
			}
		}
	}

	   function doubleSubmitCheck(){
	        if(doubleSubmitFlag){
	            return doubleSubmitFlag;
	        }else{
	            doubleSubmitFlag = true;
	            return false;
	        }
	    }

	function commCodeSetting() {
		$.fn.ifvmSetSelectOptionCommCode("dtlRqtType", "REQ_TYPE", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("dtlPointType", "TXN_TYPE_CD_TM", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("hndopAcuStblRsn", "TXN_REASON_TYPE", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("dtlMemDiv", "MEMBER_TYPE", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("dtlMemGrade", "MEMBER_GRADE", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("dtlTrtStatus", "TXN_STATUS_CD", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("dtlApvRqtInstn", "TXN_TERMINAL", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("dtlApvRpy", "VAN_RETURN_CODE", null, null, false);



	/* 	$.ifvGetCommCodeList('select', 'dtlRqtType', '<ifvm:action name="getCommCodeList"/>', 'REQ_TYPE', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'dtlPointType', '<ifvm:action name="getCommCodeList"/>', 'TXN_TYPE_CD_TM', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'hndopAcuStblRsn', '<ifvm:action name="getCommCodeList"/>', 'TXN_REASON_TYPE', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'dtlMemDiv', '<ifvm:action name="getCommCodeList"/>', 'MEMBER_TYPE', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'dtlMemGrade', '<ifvm:action name="getCommCodeList"/>', 'MEMBER_GRADE', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'dtlTrtStatus', '<ifvm:action name="getCommCodeList"/>', 'TXN_STATUS_CD', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'dtlApvRqtInstn', '<ifvm:action name="getCommCodeList"/>', 'TXN_TERMINAL', 'loy', false, false, true);
		$.ifvGetCommCodeList('select', 'dtlApvRpy', '<ifvm:action name="getCommCodeList"/>', 'VAN_RETURN_CODE', 'loy', false, false, true); */

	}

	function numberFormatterSetting() {
		var numFormatVal = $("#dtlRqtPoint").val();
		$("#dtlRqtPoint").ifvNumberOnly();
		$("#dtlRqtPoint").val(numberWithCommas(numFormatVal));

		numFormatVal = $("#dtlStblAftrPointBlnc").val();
		$("#dtlStblAftrPointBlnc").ifvNumberOnly();
		$("#dtlStblAftrPointBlnc").val(numberWithCommas(numFormatVal));

	}
	//1000단위 정규식
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	function dateFormatSetting(){
		var dateFormatVal=$("#dtlDealDt").val().split(".")[0];
		$("#dtlDealDt").val(dateFormatVal);

		dateFormatVal = $("#dtlVanApvDt ").val().split(".")[0]
		$("#dtlVanApvDt ").val(dateFormatVal);

		dateFormatVal = $("#dtlActcRqtDt").val().split(".")[0]
		$("#dtlActcRqtDt").val(dateFormatVal);

		dateFormatVal = $("#dtlApvRqtDt").val().split(".")[0]
		$("#dtlApvRqtDt").val(dateFormatVal);

		dateFormatVal = $("#dtlActcTrtDt").val().split(".")[0]
		$("#dtlActcTrtDt").val(dateFormatVal);

		dateFormatVal = $("#dtlApvRjtDt").val().split(".")[0]
		$("#dtlApvRjtDt").val(dateFormatVal);

		dateFormatVal = $("#dtlApvDt").val().split(".")[0]
		$("#dtlApvDt").val(dateFormatVal);

	}
	function manualListFn() {
		var url = '<ifvm:url name="manualList"/>';
		qtjs.href(url);
	}
	/* function checkButtnAuth(){
		var isAuth = false;
		var authArr = $.ifvmGetAuthInfo().authList;
		for(var i = 0 ; i < authArr.length ; i++){
			var authObj = authArr[i];
			var authName = authObj.authName;
			if(authName == 'E10010') isAuth = true;
		}
		if(!isAuth){
			$("#vanImmediateApprovalBtn").remove();
		}
	} */
	$(document).ready(function() {
		//van 즉시승인 권한 체크
		//checkButtnAuth();
		$.ifvmLnbSetting('manualReqListNew');

		commCodeSetting();

		manualDetailDataLoad(testViewList_rid);

		numberFormatterSetting();
		dateFormatSetting();

		$("#dtlRqtType").change(function(){
			if($(this).val()=="STMP"){
				$("#dtlPointType option[value='P']").remove();
				$("#hndopAcuStblRsn").empty();
				$.ifvGetCommCodeList('select', 'hndopAcuStblRsn', '<ifvm:action name="getCommCodeList"/>', 'STAMP_TXN_REASON_TYPE', 'loy', false, false, true);

			}else if($(this).val()=="PNT"){
				$("#dtlPointType").empty();
				$.ifvGetCommCodeList('select', 'dtlPointType', '<ifvm:action name="getCommCodeList"/>', 'TXN_TYPE_CD_TM', 'loy', false, false, true);
				//$("#dtlPointType option[value='P']").show();
				$("#hndopAcuStblRsn").empty();
				$.ifvGetCommCodeList('select', 'hndopAcuStblRsn', '<ifvm:action name="getCommCodeList"/>', 'TXN_REASON_TYPE', 'loy', false, false, true);
			}
		})
		$("#dtlPointType").change(function(){
			$("#hndopAcuStblRsn").empty();
			if($(this).val()=="M"){
				if($("#dtlRqtType").val()=="STMP"){
					$.ifvGetCommCodeList('select', 'hndopAcuStblRsn', '<ifvm:action name="getCommCodeList"/>', 'STAMP_TXN_REASON_TYPE', 'loy', false, false, true);
					$("#hndopAcuStblRsn option").not('[value="862"]').not('[value=""]').remove();
				}
				if($("#dtlRqtType").val()=="PNT"){
					$.ifvGetCommCodeList('select', 'hndopAcuStblRsn', '<ifvm:action name="getCommCodeList"/>', 'TXN_REASON_TYPE', 'loy', false, false, true);
					$("#hndopAcuStblRsn option").not('[value="85000"]').not('[value=""]').remove();
				}
			}else if($(this).val()=="P" && $("#dtlRqtType").val()=="PNT"){
				$.ifvGetCommCodeList('select', 'hndopAcuStblRsn', '<ifvm:action name="getCommCodeList"/>', 'TXN_REASON_TYPE', 'loy', false, false, true);
				$("#hndopAcuStblRsn option[value='85000']").remove();
			}
		})
	});
</script>


<div class="page-title">
	<h1>
        <spring:message code="L00664"/> &gt;  <spring:message code="L00079"/>
	</h1>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-4">
		<span> <spring:message code="L00665" /></span>
	</div>

	<div class="col-xs-8 searchbtn_r">
		<ifvm:inputNew type="button" btnType="save" text="L00074" id="saveManualInfoBtn" btnFunc="saveManualInfoFn" />
		<ifvm:inputNew type="button" text="L00662" id="vanImmediateApprovalBtn" btnFunc="vanImmediateApprovalFn" objCode="LOY_VAN_002"/>
		<ifvm:inputNew type="button" text="L01259" id="vanApprovalBtn" btnFunc="vanApprovalFn" />
		<ifvm:inputNew type="button" text="L00663" id="inspectionReqBtn" btnFunc="inspectionReqFn" objCode="LOY_INS_002"/>
		<ifvm:inputNew type="button" text="L02058" id="cancelInsBtn" btnFunc="fnCancelIns" objCode="LOY_INS_003"/>
		<ifvm:inputNew type="button" text="M00002" id="manualListBtn" btnFunc="manualListFn" />
	</div>
	<script>
	function fnCancelIns(){
		var submitData = {
				rid : $("#rid").val()
		}

		$.ifvSyncPostJSON('<ifvm:action name="cancelManualIns"/>',
			submitData, function(result) {

			alert('<spring:message code="L02060" />');
			qtjs.reload();
		});

	}
	</script>
</div>

<div id="manualDetailForm">

	<div class="form-horizontal underline top_well">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L00685" /></span>
			</div>
		</div>
		<div class="row">
			<ifvm:inputNew type="select" id="dtlRqtType" names="dtlRqtType" maxLength="50"
				dto="dtlRqtType" label="L00607" labelClass="1" conClass="2"
				required="true" />
			<ifvm:inputNew type="text" id="dtlMbrNo" maxLength="50"
				dto="dtlMbrNo" label="M00688" labelClass="1" conClass="2"
				disabled="true" />
			<ifvm:inputNew type="text" id="dtlChnlNo" maxLength="50"
				dto="dtlChnlNo" label="L00564" labelClass="1" conClass="2"
				disabled="true" />
			<ifvm:inputNew type="select" id="dtlTrtStatus" names="dtlTrtStatus" maxLength="50"
				dto="dtlTrtStatus" label="L00666" labelClass="1" conClass="2"
				disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="select" id="dtlPointType"  names ="dtlPointType" maxLength="50"
				dto="dtlPointType" label="L00667" labelClass="1" conClass="2"
				required="true" />


			<ifvm:inputNew type="search" id="dtlCustNm|btnMemSearch"
				names="ruleCd" hidId="ridMbr" hidDto="ridMbr" dto="dtlCustNm"
				disabled="false" required="true" btnFunc="mbrSearchFn"
				searchBlurEvent="mbrSearchHelpBlur"
				searchEnterEvent="mbrSearchHelpEnter" label="L00435" labelClass="1"
				conClass="2" />

			<ifvm:inputNew type="search" id="dtlChnlNm|btnChannelSearch"
				names="dtlChnlNm" hidId="ridChnl" hidDto="ridChnl" dto="dtlChnlNm"
				disabled="false" required="true" btnFunc="channelSearchFn"
				searchBlurEvent="channelSearchHelpBlur"
				searchEnterEvent="channelSearchHelpEnter" label="L00565"
				labelClass="1" conClass="2" />

			<ifvm:inputNew type="text" id="dtlCreateBy" maxLength="50"
				dto="dtlCreateBy" label="L00668" labelClass="1" conClass="2"
				disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="select" id="hndopAcuStblRsn" names="hndopAcuStblRsn" maxLength="50"
				dto="hndopAcuStblRsn" label="L00669" labelClass="1" conClass="2"
				required="true" />
			<ifvm:inputNew type="select" id="dtlMemDiv" names="dtlMemDiv" maxLength="50"
				dto="dtlMemDiv" label="L00557" labelClass="1" conClass="2"
				disabled="true" />
			<ifvm:inputNew type="text" id="dtlBizrNo" maxLength="50"
				dto="dtlBizrNo" label="L00597" labelClass="1" conClass="2"
				disabled="true" />

			<ifvm:inputNew type="text" id="dtlDealDt" maxLength="50"
				dto="dtlDealDt" label="L00604" labelClass="1" conClass="2"
				disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="text" id="dtlRqtPoint" maxLength="50"
				dto="dtlRqtPoint" label="L00670" labelClass="1" conClass="2"
				required="true" />
			<ifvm:inputNew type="select" id="dtlMemGrade" names="dtlMemGrade" maxLength="50"
				dto="dtlMemGrade" label="L00180" labelClass="1" conClass="2"
				disabled="true" />
			<ifvm:inputNew type="select" id="dtlApvRqtInstn"  names="dtlApvRqtInstn" maxLength="50"
				dto="dtlApvRqtInstn" label="L00603" labelClass="1" conClass="2"
				disabled="true" />
		</div>

		<div class="row qt_border">
			<ifvm:inputNew type="textarea" id="hndopAcuStblDesc" maxLength="50"
				dto="hndopAcuStblDesc" label="L00671" labelClass="1" conClass="5" />
		</div>
	</div>

	<div class="half_wrap top_well">
		<div class="half_content half_left" id="approvalServerForm">
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="L00686" /></span>
				</div>
			</div>
			<div class="form-horizontal top_well underline" id="reachInfo">
				<div class="row">
					<ifvm:inputNew type="text" id="dtlApvDt" maxLength="50"
						dto="dtlApvDt" label="L00672" labelClass="2" conClass="4"
						disabled="true" />
					<ifvm:inputNew type="text" id="dtlStblAftrPointBlnc" maxLength="50"
						dto="dtlStblAftrPointBlnc" label="L00673" labelClass="2"
						conClass="4" disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="dtlVanApvDt" maxLength="50"
						dto="dtlVanApvDt " label="L00674" labelClass="2" conClass="4"
						disabled="true" />
					<ifvm:inputNew type="text" id="dtlDealTrckNo" maxLength="50"
						dto="dtlDealTrckNo" label="L00576" labelClass="2" conClass="4"
						disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="dtlApvNo" maxLength="50"
						dto="dtlApvNo" label="M00966" labelClass="2" conClass="4"
						disabled="true" />
					<ifvm:inputNew type="select" id="dtlApvRpy" names="dtlApvRpy" maxLength="50"
						dto="dtlApvRpy" label="L00675" labelClass="2" conClass="4"
						disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="textarea" id="dtlRpyMsg" maxLength="50"
						dto="dtlRpyMsg" label="L00676" labelClass="2" conClass="10"
						disabled="true" />
				</div>
				<ifvm:inputNew type="hidden" id="vocRid" />
			</div>
		</div>

		<div class="half_content half_right">
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span><spring:message code="L00687" /></span>
				</div>
			</div>
			<div class="form-horizontal top_well underline" id="mktAgree">
				<div class="row">


					<ifvm:inputNew type="search" id="dtlRidActc|inspectorhSearchBtn"
						names="dtlRidActc" hidId="ridActc" hidDto="ridActc"
						dto="dtlRidActc" disabled="false" btnFunc="inspectorSearchFn"
						searchBlurEvent="inspectorSearchHelpBlur"
						searchEnterEvent="inspectorSearchHelpEnter" label="L00677"
						labelClass="2" conClass="4" />

					<ifvm:inputNew type="search" id="dtlRidApv|approverSearchBtn"
						names="dtlRidApv" hidId="ridApv" hidDto="ridApv" dto="dtlRidApv"
						disabled="false" btnFunc="approverSearchFn"
						searchBlurEvent="approverSearchHelpBlur"
						searchEnterEvent="approverSearchHelpEnter" label="L00678"
						labelClass="2" conClass="4" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="dtlActcRqtDt" maxLength="50"
						dto="dtlActcRqtDt" label="L00679" labelClass="2" conClass="4"
						disabled="true" />
					<ifvm:inputNew type="text" id="dtlApvRqtDt" maxLength="50"
						dto="dtlApvRqtDt" label="L00680" labelClass="2" conClass="4"
						disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="text" id="dtlActcTrtDt" maxLength="50"
						dto="dtlActcTrtDt" label="L00681" labelClass="2" conClass="4"
						disabled="true" />
					<ifvm:inputNew type="text" id="dtlApvRjtDt" maxLength="50"
						dto="dtlApvRjtDt" label="L00682" labelClass="2" conClass="4"
						disabled="true" />
				</div>

				<div class="row">
					<ifvm:inputNew type="textarea" id="dtlActcRjtRsn" maxLength="50"
						dto="dtlActcRjtRsn" label="L00683" labelClass="2" conClass="4"
						disabled="true" />
					<ifvm:inputNew type="textarea" id="dtlApvRjtRsn" maxLength="50"
						dto="dtlApvRjtRsn" label="L00684" labelClass="2" conClass="4"
						disabled="true" />
				</div>
				<ifvm:inputNew type="hidden" id="rid" />
				<ifvm:inputNew type="hidden" id="ridMbr" />
				<ifvm:inputNew type="hidden" id="enisSetlMeth" />
			</div>
		</div>
	</div>

</div>

<script>

</script>
<div id="channelSearchPopDiv" class="popup_container"></div>
<div id="mbrSearchPopDiv" class="popup_container"></div>
<div id="empSearchPopDiv" class="popup_container"></div>