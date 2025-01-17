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
var testViewList_rid = '<%=cleanXss(request.getParameter("rid"))%>';
	var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID
	var manualDtlValid;
	var chnlObj = null;
	var tempObj = {};
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
				}
				if ($("#dtlTrtStatus").val() != "00") {
					$("#inspectionReqBtn").attr("disabled", true);
					$("#vanImmediateApprovalBtn").attr("disabled", true);
				}

				if ($("#dtlTrtStatus").val() != "20"
						&& $.ifvmGetUserInfo().empId != $("ridActc").val()) {
					$("#vanApprovalBtn").attr("disabled", true);
				}
				//van 승인 or 검수요청 끝난후 잠금처리
				if ($("#dtlTrtStatus").val() != "00") {
					$($('#manualDetailForm').find('select')).attr("disabled",
							true)
					$($('#manualDetailForm').find('input')).attr("disabled",
							true)
					$($('#manualDetailForm').find('textarea')).attr("disabled",
							true)
				}
				tempObj = result.rows[0];
			});
		} else {
			$("#dtlTrtStatus").val("00");
			$("#dtlApvRpy").val("");
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
		buttonValid();
	}

	function buttonValid(){
		if($("#ridActc").val()!=ifvmUserInfo.empId){

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
		if($("#dtlTrtStatus").val()!="00" && $("#dtlTrtStatus").val()!="" ){
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

			//이부분 van승인으로 로직 바꿔야함. 17/12/07 아직 안바꿈
			$.ifvSyncPostJSON('<ifvm:action name="vanImmediateApproval"/>',
					submitData, function(result) {
						if (result.message == "VA") {
							alert("Van승인이 완료되었습니다.");
						}
						manualDetailDataLoad(testViewList_rid);
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
						}
					});
		}
	}

	function vanImmediateApprovalFn() {
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
			$.ifvSyncPostJSON('<ifvm:action name="vanImmediateApproval"/>',
					submitData, function(result) {
						if (result.message == "VA") {
							alert("Van승인이 완료되었습니다.");
						}
						manualDetailDataLoad(testViewList_rid);

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
						}

					});
		}

		/* 	var tmValid=true;
		 var memValid =false;
		 if(checkRequirdField()){
		 checkTmCount();  //2. 1일 VAN 승인 횟수 제한
		 if(tmValid){
		 checkMemberStatus();  //3. 회원의 최종 상태 check
		 }
		 if(memValid){
		 callVanApproval();
		 }
		 } */

		/* tmValid=false;
		memValid=false;
		var approvalAfterPnt;
		manualDtlValid=$("#manualDetailForm").ifvValidation();
		if(manualDtlValid.confirm()==true){//1.필수입력 항목 체크
			if($("#dtlCustNm").val()==""){
				$.ifvCallValidationBox( $("#dtlCustNm"), "<spring:message code='C00024'/>" );

			} else if($("#dtlChnlNm").val()==""){
		   		 $.ifvCallValidationBox( $("#dtlChnlNm"), "<spring:message code='C00024'/>" );
			} else{

			}
		} */

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

			if($("#rid").val()==""){
				$.ifvSyncPostJSON('<ifvm:action name="insertManualInfo"/>',
						submitData, function(result) {
							testViewList_rid=result.message;
							submitData.rid = testViewList_rid;
							$.ifvSyncPostJSON('<ifvm:action name="inspectionReq"/>',
									submitData, function(result) {
										alert(result.message);
										manualDetailDataLoad(testViewList_rid);
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
											location.replace('<ifvm:url name="manualDetail"/>' + '?rid=' + testViewList_rid );
										}
									});
					})
			} else{
				$.ifvSyncPostJSON('<ifvm:action name="inspectionReq"/>',
						submitData, function(result) {
							alert(result.message);
							manualDetailDataLoad(testViewList_rid);
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
								location.replace('<ifvm:url name="manualDetail"/>' + '?rid=' + testViewList_rid );
							}

						});
			}


		}
	}

	function checkTmCount() {
		var iCnt = 0;
		var sMemId = $("#dtlMbrNo").val();
		var sMemType = $("#dtlMemDiv").val();
		var sMemGrade = $("#dtlMemGrade").val();
		var sCurPoints = $("#dtlRqtPoint").val();
		var sCurTxnType = $("#Transaction Type");
		//동호회/기부단체는 VAN즉시승인하지 않고 승인요청하도록 함
		if (sMemType == "G" || sMemType == "S" || sMemType == "E") {
			alert('<spring:message code="L01131"/>'
					+ '<spring:message code="L01130"/>');
			return;
		}
		var memObj = {};
		memObj.memType = sMemType;
		memObj.memGrade = sMemGrade;
		var sPointUnit;
		var sPointNums;
		//회원구분/등급별 적립기준을 조회한다.
		$.ifvSyncPostJSON('<ifvm:action name="checkMemCount"/>', memObj,
				function(result) {
					sPointUnit = 1;
					sPointNums = 0;
					if (result.rows.length != 0) {
						sPointUnit = result.rows[0].acrlPnt;
						sPointNums = result.rows[0].acrlPntLmt;
					}
				});
		//포인트 적립한도 10만원으로 계산
		//2011/12/05 유영진 VAN즉시 적립 한도액 500원 FIX
		var sPointLimit = 500 //100000/ (sPointUnit*1) * (sPointNums*1);
		sCurPoints = sCurPoints.replace(/[^\d]+/g, '');
		if (sCurPoints * 1 > sPointLimit) {
			alert('<spring:message code="L01128"/>' + sPointLimit
					+ '<spring:message code="L01129"/>')
			return;
		}
		//당일자로 수동적립/차감요청 즉시처리한 건이 있는지 체크 (1일 2회까지 허용)
		var vocObj = {}
		vocObj.ridMbr = $("#ridMbr").val();
		vocObj.pntType = $("#dtlPointType").val();
		var isRecord;
		$.ifvSyncPostJSON(
						'<ifvm:action name="checkVocRqt"/>',
						vocObj,
						function(result) {
							if (result.rows.length != 0) {
								isRecord = result.rows[0];
								if (isRecord.rqtPnt * 1 + sCurPoints * 1 > sPointLimit) {
									alert('<spring:message code="L01128"/>'
											+ sPointLimit
											+ '<spring:message code="L01129"/>'
											+ '<spring:message code="L01130"/>');
									return;
									//여기도 return 해야하는거 아닌지
								}
							}
							iCnt = 1;
							if (result.rows.length > 1) {
								iCnt = 2;
							}
							if (iCnt == 2) {
								alert('<spring:message code="L02037"/>');
								return;
							}
						}, function(result) {

						});
		tmValid = true;
		if (typeof isRecord != "undefined" || isRecord == "") {
			approvalAfterPnt = isRecord.rqtPnt * 1 + sCurPoints * 1;
		} else {
			approvalAfterPnt = sCurPoints * 1;
		}
	}

	function checkMemberStatus() {
		var sMemId, sMemStatus, sStautValue, sMemberName = null;
		var pIsCase = "Y";
		sMemId = $("#ridMbr").val();
		$.ifvSyncPostJSON('<ifvm:action name="checkMemStatus"/>', {
			ridMbr : sMemId
		}, function(result) {
			if (result.rows.length != 0) {
				sMemStatus = result.rows[0].mbrStatCd;
				sStautValue = result.rows[0].mbrStatCdValue;
				sMemberName = result.rows[0].custNm;
			}
		});
		if (sMemStatus != "10") {
			if (pIsCase == "Y") {
				alert(sMemberName + "님 회원상태가 " + sStautValue
						+ "이므로, 포인트 승인을 할 수 없습니다.");
				return;
			} else {
				alert(sMemberName + "님 회원상태가 " + sStautValue
						+ "이므로, 포인트 승인을 할 수 없습니다.");
				return;
			}
		}
		memValid = true;
	}

	function callVanApproval() {
		var sTxnType = $("#dtlPointType").val();
		var sMemberSeq = $("#dtlMbrNo").val();
		var sMemberType = $("#dtlMemDiv").val();
		var sPartnerCode = $("#dtlChnlNo").val();
		var sBusinessNum = $("#dtlBizrNo").val();
		var sReqPoints = $("#dtlRqtPoint").val();
		var sReasonType = $("#hndopAcuStblRsn").val();

		sReasonType = sReasonType.substring(0, 3);
		var sProductCode = sReasonType;

		var sTxn = $("#enisSetlMeth").val();
		if (sTxn != "") {
			sProductCode = sTxn;
		}

		/* 	if(sTxnType == "P" && sReasonType == "140")	{
		 sProductCode = "413";  //GS적립
		 }
		 */
		sStep = "010";
		//var oSvcBS= TheApplication().GetService("E1 Point VAN Approval BS");
		var psIn = {};
		var psOut = {};
		psIn.sTxnType = sTxnType; //포인트유형
		psIn.sMemberSeq = sMemberSeq; //회원번호
		psIn.sMemberType = sMemberType; //회원구분
		psIn.sPartnerCode = sPartnerCode; //가맹점코드
		psIn.sBusinessNum = sBusinessNum; //사업자번호
		psIn.sReqPoints = sReqPoints; //요청포인트
		psIn.sProductCode = sProductCode; //제품코드
		sStep = "020";
		preInvokeMethod("PointApprovalTM", psIn, psOut); //포인트VAN승인요청
		sStep = "030";

		var sResult = psOut.result;
		var sReturnCd = psOut.repCode; //응답코드
		var sErrMsg; //= psOut.GetProperty("ErrMsg") ;	//Error메세지
		if (sResult == "S" && sReturnCd == "0000") {
			sStep = "040";
			var now = new Date();
			var year = now.getFullYear();
			var mon = (now.getMonth() + 1) > 9 ? '' + (now.getMonth() + 1)
					: '0' + (now.getMonth() + 1);
			var day = now.getDate() > 9 ? '' + now.getDate() : '0'
					+ now.getDate();
			var time = now.getHours() + ":" + now.getMinutes() + ":"
					+ now.getSeconds();
			var appvDate = year + '-' + mon + '-' + day + " " + time;
			//	$("#dtlStblAftrPointBlnc").val(approvalAfterPnt);
			//    $("#dtlVanApvDt").val(appvDate);
			//    $("#dtlApvDt").val(appvDate);

			$("#dtlDealTrckNo").val("test");
			$("#dtlApvNo").val("testNo");
			$("#dtlRpyMsg").val("TestMessage");
			var appObj = {};
			appObj = $("#manualDetailForm").getSubmitData();

			appObj.dtlRqtPoint = $("#dtlRqtPoint").val().replace(/[^\d]+/g, '');
			appObj.ridActc = $("#ridActc").val();
			appObj.ridApv = $("#ridApv").val();
			appObj.ridChnl = $("#ridChnl").val();
			appObj.ridMbr = $("#ridMbr").val();
			appObj.dtlStblAftrPointBlnc = approvalAfterPnt;
			//	appObj.dtlVanApvDt = appvDate 승인일자는 van승인시
			appObj.dtlApvDt = appvDate
			appObj.rid = testViewList_rid;
			$.ifvSyncPostJSON('<ifvm:action name="updateVanApproval"/>',
					appObj, function(result) {
						if (result.success) {
							alert("E1포인트 VAN승인 성공하였습니다.");
							manualDetailDataLoad(testViewList_rid);
							return;
						}
					});
			//인터페이스 적용
			/* 	sCancelData = psOut.GetProperty("CANCEL_DATA"); //망취소전문

				var sTranDate    = psOut.GetProperty("TranDate");	//거래일
				var sTranTime    = psOut.GetProperty("TranTime");	//거래시간
				var sTxnNumber   = psOut.GetProperty("TranUK");	 	//거래추적번호
				var sApprDate    = psOut.GetProperty("ApprDate");	//승인일자
				var sApprovalNum = psOut.GetProperty("ApprNum");	//승인번호
				var sApprovalPts = psOut.GetProperty("UsablePoint") ;//가용포인트
				var sTxnDate      = Change_Date_Fmt(sTranDate, sTranTime);
				var sApprvoalDate = Change_Date_Fmt(sApprDate, "");

				SetFieldValue("VAN Return Cd",       sReturnCd); 	 //응답코드
				SetFieldValue("VAN Return Desc",     "");			 //응답메세지
				SetFieldValue("Transaction Date",	 sTxnDate); 	 //거래일
				SetFieldValue("Transaction Number",  sTxnNumber);    //거래번호
				SetFieldValue("VAN Approval Date",	 sApprvoalDate); //승인일자
				SetFieldValue("VAN Approval Number", sApprovalNum);  //승인번호
				SetFieldValue("VAN Approval Points", sApprovalPts ); //승인후 포인트
				SetFieldValue("Status", "15");                  	 //처리상태 : VAN즉시승인
				WriteRecord(); */
			return sResult;
		} else {
			sStep = "050";
			/*
			 SetFieldValue("VAN Return Cd",  sReturnCd);
			 SetFieldValue("VAN Return Desc",sErrMsg.substring(0,300));
			 WriteRecord();

			 if (pIsCase){ //건별 승인일은 메세지 띄운다.
			 var sMsg = TheApplication().InvokeMethod("LookupValue","VAN_RETURN_CODE",sReturnCd);
			 if (sMsg != "") TheApplication().RaiseErrorText(sMsg);
			 else TheApplication().RaiseErrorText(sErrMsg);
			 } */
		}
	}

	function preInvokeMethod(MethodName, Inputs, Outputs) {
		if (MethodName == "PointApprovalTM") { //포인트수동적립/차감
			Point_Approval_TM(Inputs, Outputs);
			Outputs.result = "S"
			Outputs.repCode = "0000"
			return Outputs;
		} else if (MethodName == "ChangeTaxiMember") { //개인택시전환 : 기최근2개월간 충전포인트 더블적립
			Point_Taxi_Member(Inputs, Outputs);
			return;
		} else if (MethodName == "NetworkCancel") { //망취소요청
			Call_EAI_VAN_Cancel(Inputs, Outputs);
			return;
		}
		return (ContinueOperation);
	}

	function Point_Approval_TM(Inputs, Outputs) {
		/***************************************************************************
		 이  름 : Point_Approval_TM
		 기  능 : 포인트 수동적립/차감에 따른 처리를 한다.
		 작성자 : LWY@Quintet
		 작성일 : 2009/01/12
		 수정이력 :
		 기타사항 :
		 *****************************************************************************/
		//TheApplication().TraceOn("d:\\sba80\\trace_Approval_TM.txt","Allocation","All");
		//TheApplication().Trace("sTrType : " + sTrType);
		var sTxnType = Inputs.sTxnType; //포인트유형
		var sMemType = Inputs.sMemberType; //회원구분
		//동호회 포인트 수동처리
		if (sMemType == "G") {
			//Process_Group_Point(Inputs, Outputs);
		} else {
			if (sTxnType == "P") { //적립

				//Call_EAI_VAN_Plus(Inputs, Outputs);

			} else if (sTxnType == "M") { //사용
				//Call_EAI_VAN_Minus(Inputs, Outputs);
			}
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
		channelSearchPopOpen();
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
		mbrSearchPopOpen()
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
		inspectorSearchPopOpen();
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
				if(obj.rid==ifvmUserInfo.empId){
					alert("자기자신에게 검수 요청을 할수 없습니다.");
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
			inspectorSearchPopOpen('<ifvm:url name="empSearchHelp"/>'
					+ '?authNm=E10008&&name='
					+ encodeURI(encodeURIComponent($('#dtlRidApv').val())));
		}
	}

	function approverSearchHelpBlur() {
		approverSearchHelpOpenPop();
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

				if(obj.rid==ifvmUserInfo.empId){
					alert("자신에게 승인 요청을 할수 없습니다.");
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
			} else {
				var submitData = $("#manualDetailForm").getSubmitData();
				//			submitData.dtlCustNm = $("#dtlCustNm").val();
				//		submitData.dtlChnlNm = $("#dtlChnlNm").val();
				submitData.ridActc = $("#ridActc").val();
				submitData.ridApv = $("#ridApv").val();
				submitData.ridChnl = $("#ridChnl").val();
				submitData.ridMbr = $("#ridMbr").val();
				if (testViewList_rid == "null") { //신규
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

	function commCodeSetting() {
		//요청 유형
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'REQ_TYPE',
			enableNA : true
		}, function(result) {
			var temp = $("#dtlRqtTypeTemp").tmpl(result.rows);
			$("#dtlRqtType").append(temp);
		});

		//포인트 유형
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'TXN_TYPE_CD_TM',
			enableNA : true
		}, function(result) {
			var temp = $("#dtlPointTypeTemp").tmpl(result.rows);
			$("#dtlPointType").append(temp);
		});
		//수동 적립 사유
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'TXN_REASON_TYPE',
			enableNA : true
		}, function(result) {
			var temp = $("#hndopAcuStblRsnTemp").tmpl(result.rows);
			$("#hndopAcuStblRsn").append(temp);
		});

		//회원 구분
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'MEMBER_TYPE',
			enableNA : true
		}, function(result) {
			var temp = $("#dtlMemDivTemp").tmpl(result.rows);
			$("#dtlMemDiv").append(temp);
		});
		//회원등급
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'MEMBER_GRADE',
			enableNA : true
		}, function(result) {
			var temp = $("#dtlMemGradeTemp").tmpl(result.rows);
			$("#dtlMemGrade").append(temp);
		});

		//처리 상태
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'TXN_STATUS_CD',
			enableNA : true
		}, function(result) {
			var temp = $("#dtlTrtStatusTemp").tmpl(result.rows);
			$("#dtlTrtStatus").append(temp);
		});

		//승인 요청 기관
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'TXN_TERMINAL',
			enableNA : true
		}, function(result) {
			var temp = $("#dtlApvRqtInstnTemp").tmpl(result.rows);
			$("#dtlApvRqtInstn").append(temp);
		});

		//승인 응답
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>', {
			groupCode : 'VAN_RETURN_CODE',
			enableNA : true
		}, function(result) {
			var temp = $("#dtlApvRpyTemp").tmpl(result.rows);
			$("#dtlApvRpy").append(temp);
		});

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

	}
	function manualListFn() {
		var url = '<ifvm:url name="manualList"/>';
		qtjs.href(url);
	}

	$(document).ready(function() {
		$.ifvmLnbSetting('manualReqList');

		commCodeSetting();

		manualDetailDataLoad(testViewList_rid);

		numberFormatterSetting();
		dateFormatSetting();
	});
</script>

<script id="dtlRqtTypeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>


<script id="dtlPointTypeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlTrtStatusTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlMemDivTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlMemGradeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlApvRqtInstnTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="dtlApvRpyTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="hndopAcuStblRsnTemp" type="text/x-jquery-tmpl">
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




<div id="manualDetailForm">

	<div class="form-horizontal underline top_well">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L00685" /></span>
			</div>
		</div>
		<div class="row  qt_border">
			<ifvm:inputNew type="select" id="dtlRqtType" maxLength="50"
				dto="dtlRqtType" label="L00607" labelClass="1" conClass="2"
				required="true" />
			<ifvm:inputNew type="text" id="dtlMbrNo" maxLength="50"
				dto="dtlMbrNo" label="M00688" labelClass="1" conClass="2"
				disabled="true" />
			<ifvm:inputNew type="text" id="dtlChnlNo" maxLength="50"
				dto="dtlChnlNo" label="L00564" labelClass="1" conClass="2"
				disabled="true" />
			<ifvm:inputNew type="select" id="dtlTrtStatus" maxLength="50"
				dto="dtlTrtStatus" label="L00666" labelClass="1" conClass="2"
				disabled="true" />
		</div>

		<div class="row  qt_border">
			<ifvm:inputNew type="select" id="dtlPointType" maxLength="50"
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

		<div class="row  qt_border">
			<ifvm:inputNew type="select" id="hndopAcuStblRsn" maxLength="50"
				dto="hndopAcuStblRsn" label="L00669" labelClass="1" conClass="2"
				required="true" />
			<ifvm:inputNew type="select" id="dtlMemDiv" maxLength="50"
				dto="dtlMemDiv" label="L00557" labelClass="1" conClass="2"
				disabled="true" />
			<ifvm:inputNew type="text" id="dtlBizrNo" maxLength="50"
				dto="dtlBizrNo" label="L00597" labelClass="1" conClass="2"
				disabled="true" />

			<ifvm:inputNew type="text" id="dtlDealDt" maxLength="50"
				dto="dtlDealDt" label="L00604" labelClass="1" conClass="2"
				disabled="true" />
		</div>

		<div class="row  qt_border">
			<ifvm:inputNew type="text" id="dtlRqtPoint" maxLength="50"
				dto="dtlRqtPoint" label="L00670" labelClass="1" conClass="2"
				required="true" />
			<ifvm:inputNew type="select" id="dtlMemGrade" maxLength="50"
				dto="dtlMemGrade" label="L00180" labelClass="1" conClass="2"
				disabled="true" />
			<ifvm:inputNew type="select" id="dtlApvRqtInstn" maxLength="50"
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
				<div class="row  qt_border">
					<ifvm:inputNew type="text" id="dtlApvDt" maxLength="50"
						dto="dtlApvDt" label="L00672" labelClass="2" conClass="4"
						disabled="true" />
					<ifvm:inputNew type="text" id="dtlStblAftrPointBlnc" maxLength="50"
						dto="dtlStblAftrPointBlnc" label="L00673" labelClass="2"
						conClass="4" disabled="true" />
				</div>

				<div class="row  qt_border">
					<ifvm:inputNew type="text" id="dtlVanApvDt" maxLength="50"
						dto="dtlVanApvDt " label="L00674" labelClass="2" conClass="4"
						disabled="true" />
					<ifvm:inputNew type="text" id="dtlDealTrckNo" maxLength="50"
						dto="dtlDealTrckNo" label="L00576" labelClass="2" conClass="4"
						disabled="true" />
				</div>

				<div class="row  qt_border">
					<ifvm:inputNew type="text" id="dtlApvNo" maxLength="50"
						dto="dtlApvNo" label="M00966" labelClass="2" conClass="4"
						disabled="true" />
					<ifvm:inputNew type="select" id="dtlApvRpy" maxLength="50"
						dto="dtlApvRpy" label="L00675" labelClass="2" conClass="4"
						disabled="true" />
				</div>

				<div class="row  qt_border">
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
				<div class="row  qt_border">


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

				<div class="row  qt_border">
					<ifvm:inputNew type="text" id="dtlActcRqtDt" maxLength="50"
						dto="dtlActcRqtDt" label="L00679" labelClass="2" conClass="4"
						disabled="true" />
					<ifvm:inputNew type="text" id="dtlApvRqtDt" maxLength="50"
						dto="dtlApvRqtDt" label="L00680" labelClass="2" conClass="4"
						disabled="true" />
				</div>

				<div class="row  qt_border">
					<ifvm:inputNew type="text" id="dtlActcTrtDt" maxLength="50"
						dto="dtlActcTrtDt" label="L00681" labelClass="2" conClass="4"
						disabled="true" />
					<ifvm:inputNew type="text" id="dtlApvRjtDt" maxLength="50"
						dto="dtlApvRjtDt" label="L00682" labelClass="2" conClass="4"
						disabled="true" />
				</div>

				<div class="row  qt_border">
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