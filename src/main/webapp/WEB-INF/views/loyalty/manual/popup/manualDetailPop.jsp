<%@page trimDirectiveWhitespaces="true" %>
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

var testViewList_rid = '<%= cleanXss(request.getParameter("rid")) %>';

var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID
var manualDtlValid;
var chnlObj=null;

function manualDetailDataLoad(testViewList_rid) {
	if(testViewList_rid !="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getManualDetail"/>', {
			  rid: testViewList_rid
			 }, function(result) {
			  if($.fn.ifvmIsNotEmpty(result)) {
			 		$($('#manualDetailForm').find('input')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);
			 		});

			 		$($('#manualDetailForm').find('select')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);
			 		});
			  }
			});
	}
}

function vanApproval(){
	tmValid=false;
	memValid=false;
	var approvalAfterPnt;
	manualDtlValid=$("#manualDetailForm").ifvValidation();
	$("#vanApprovalBtn").on("click",function(){
		if(manualDtlValid.confirm()==true){//1.필수입력 항목 체크
			if($("#dtlCustNm").val()==""){
				$.ifvCallValidationBox( $("#dtlCustNm"), "<spring:message code='C00024'/>" );

			} else if($("#dtlChnlNm").val()==""){
		   		 $.ifvCallValidationBox( $("#dtlChnlNm"), "<spring:message code='C00024'/>" );
			} else{
				checkTmCount();  //2. 1일 VAN 승인 횟수 제한
				if(tmValid){
					checkMemberStatus();  //3. 회원의 최종 상태 check
				}
				if(memValid){
					callVanApproval();
				}
			}
		}

	});
}

function inspectionReqFn(){
	if(manualDtlValid.confirm()==true){ //1.필수입력 항목 체크
		checkMemberStatus();//2. 회원의 최종 상태 check

		if($("#ridApv").val()==$("#ridActc").val()){
			alert('<spring:message code="L02034"/>');//'<spring:message code="L01129"/>'
			return;
		}
		if($("#dtlCreateBy").val() == $("#ridApv").val()){
			alert('<spring:message code="L02035"/>');
			return;
		}else if($("#dtlCreateBy").val()==$("#ridActc").val()){
			alert('<spring:message code="L02036"/>');
			return;
		}
	    var now = new Date();

	    var year= now.getFullYear();
	    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
	    var time = now.getHours() +":" + now.getMinutes() +":" +now.getSeconds();
	    var appvDate = year + '-' + mon + '-' + day + " "+ time;

		$("#dtlActcRqtDt").val(appvDate);
		$("#dtlTrtStatus").val("50");
		 var updateObj= {};
		 updateObj = $("#manualDetailForm").getSubmitData();
		 updateObj.ridActc = $("#ridActc").val();
		 updateObj.ridApv = $("#ridApv").val();
		 updateObj.ridChnl = $("#ridChnl").val();
		 updateObj.ridMbr = $("#ridMbr").val();
		 updateObj.rid = testViewList_rid;
		$.ifvSyncPostJSON('<ifvm:action name="updateActcInfo"/>', updateObj
				, function(result) {
					if(result.success){
						alert('<spring:message code="M00106"/>');
						manualDetailDataLoad(testViewList_rid);
					}
		})
	}
}

function checkTmCount(){
	var iCnt = 0;
	var sMemId      = $("#dtlMbrNo").val();
	var sMemType    = $("#dtlMemDiv").val();
	var sMemGrade   = $("#dtlMemGrade").val();
	var sCurPoints  = $("#dtlRqtPoint").val();
	var sCurTxnType = $("#Transaction Type");

	//동호회/기부단체는 VAN즉시승인하지 않고 승인요청하도록 함
	if (sMemType == "G" || sMemType == "S" || sMemType == "E"){
		alert('<spring:message code="L01131"/>' +
				'<spring:message code="L01130"/>');
		return;
	}
	var memObj = {};
	memObj.memType = sMemType;
	memObj.memGrade  = sMemGrade;
	var sPointUnit ;
	var sPointNums ;
	//회원구분/등급별 적립기준을 조회한다.
	$.ifvSyncPostJSON('<ifvm:action name="checkMemCount"/>', memObj
			, function(result) {
				sPointUnit = 1;
				sPointNums = 0;
				if(result.rows.length!=0){
					sPointUnit = result.rows[0].acrlPnt;
					sPointNums = result.rows[0].acrlPntLmt;
				}

		 });
	//포인트 적립한도 10만원으로 계산
	//2011/12/05 유영진 VAN즉시 적립 한도액 500원 FIX
	var sPointLimit = 500 //100000/ (sPointUnit*1) * (sPointNums*1);

	if(sCurPoints*1 > sPointLimit){
		alert('<spring:message code="L01128"/>' +sPointLimit+ '<spring:message code="L01129"/>')
		return;
	}

	//당일자로 수동적립/차감요청 즉시처리한 건이 있는지 체크 (1일 2회까지 허용)
	var vocObj={}
	vocObj.ridMbr=$("#ridMbr").val();
	vocObj.pntType=$("#dtlPointType").val();
	var isRecord;
	$.ifvSyncPostJSON('<ifvm:action name="checkVocRqt"/>', vocObj
			, function(result) {
			if(result.rows.length!=0){
				isRecord = result.rows[0];
				if(isRecord.rqtPnt*1 + sCurPoints*1 > sPointLimit ){
					alert('<spring:message code="L01128"/>' +sPointLimit+ '<spring:message code="L01129"/>'+
							'<spring:message code="L01130"/>');
					return;
					//여기도 return 해야하는거 아닌지
				}
			}
		 	iCnt = 1;
		 	if (result.rows.length>1) {
		 		iCnt = 2 ;
		 	}
			if (iCnt == 2){
				alert('<spring:message code="L02037"/>');
				return;
			}
	})
	tmValid = true;
	approvalAfterPnt = isRecord.rqtPnt*1 + sCurPoints*1;
}

function checkMemberStatus(){
	var sMemId, sMemStatus, sStautValue, sMemberName = null;
	var pIsCase = "Y";
	sMemId=$("#ridMbr").val();
	$.ifvSyncPostJSON('<ifvm:action name="checkMemStatus"/>', {ridMbr : sMemId}
			, function(result) {
				if(result.rows.length!=0){
					sMemStatus = result.rows[0].mbrStatCd;
					sStautValue = result.rows[0].mbrStatCdValue;
					sMemberName = result.rows[0].custNm;
				}
	});
    if (sMemStatus != "10"){
        if (pIsCase == "Y"){
            alert( sMemberName +"님 회원상태가 " + sStautValue + "이므로, 포인트 승인을 할 수 없습니다.");
            return;
        }
        else{
        	alert( sMemberName + "님 회원상태가 " + sStautValue + "이므로, 포인트 승인을 할 수 없습니다.");
        	return;
        }
    }

    memValid = true;
}

function callVanApproval(){
	var sTxnType     = $("#dtlPointType").val();
	var sMemberSeq   = $("#dtlMbrNo").val();
	var sMemberType  = $("#dtlMemDiv").val();
	var sPartnerCode = $("#dtlChnlNo").val();
	var sBusinessNum = $("#dtlBizrNo").val();
	var sReqPoints   = $("#dtlRqtPoint").val();
	var sReasonType  = $("#hndopAcuStblRsn").val();

	sReasonType = sReasonType.substring(0,3);
	var sProductCode = sReasonType;


	var sTxn = $("#enisSetlMeth").val();
	if(sTxn !=""){
		sProductCode = sTxn;
	}

/* 	if(sTxnType == "P" && sReasonType == "140")	{
		sProductCode = "413";  //GS적립
	}
	 */
	sStep = "010";
	//var oSvcBS= TheApplication().GetService("E1 Point VAN Approval BS");
	var psIn  = {};
	var psOut = {};


	psIn.sTxnType = sTxnType;				//포인트유형
	psIn.sMemberSeq = sMemberSeq;			//회원번호
	psIn.sMemberType = sMemberType;			//회원구분
	psIn.sPartnerCode = sPartnerCode;		//가맹점코드
	psIn.sBusinessNum = sBusinessNum;		//사업자번호
	psIn.sReqPoints = sReqPoints;			//요청포인트
	psIn.sProductCode = sProductCode;		//제품코드
	sStep = "020";
	preInvokeMethod("PointApprovalTM",psIn,psOut); //포인트VAN승인요청
	sStep = "030";

	var sResult   = psOut.result;
   	var sReturnCd = psOut.repCode;	//응답코드
   	var sErrMsg;   //= psOut.GetProperty("ErrMsg") ;	//Error메세지
    if (sResult == "S" && sReturnCd == "0000"){
		sStep = "040";
		var now = new Date();

	    var year= now.getFullYear();
	    var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	    var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
	    var time = now.getHours() +":" + now.getMinutes() +":" +now.getSeconds();
	    var appvDate = year + '-' + mon + '-' + day + " "+ time;
	    $("#dtlVanApvDt").val(appvDate);
	    $("#dtlApvDt").val(appvDate);
		$("#dtlStblAftrPointBlnc").val(approvalAfterPnt);
		$("#dtlDealTrckNo").val("test");
		$("#dtlApvNo").val("testNo");
		$("#dtlRpyMsg").val("TestMessage");
		var appObj={};
		appObj= $("#manualDetailForm").getSubmitData();
		appObj.ridActc = $("#ridActc").val();
		appObj.ridApv = $("#ridApv").val();
		appObj.ridChnl = $("#ridChnl").val();
		appObj.ridMbr = $("#ridMbr").val();
		appObj.rid = testViewList_rid;
		$.ifvSyncPostJSON('<ifvm:action name="updateVanApproval"/>', appObj
		, function(result) {
			if(result.success){
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
    }else{
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

function preInvokeMethod (MethodName, Inputs, Outputs){
    if (MethodName == "PointApprovalTM"){        //포인트수동적립/차감
        Point_Approval_TM(Inputs, Outputs);
    	Outputs.result ="S"
    	Outputs.repCode = "0000"
        return Outputs;
    }else if (MethodName == "ChangeTaxiMember"){  //개인택시전환 : 기최근2개월간 충전포인트 더블적립

        Point_Taxi_Member(Inputs, Outputs);
        return ;
    }
    else if (MethodName == "NetworkCancel"){  //망취소요청
        Call_EAI_VAN_Cancel(Inputs, Outputs);
        return ;
    }
    return (ContinueOperation);
}

function Point_Approval_TM(Inputs, Outputs){
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

    var sTxnType = Inputs.sTxnType;   //포인트유형
    var sMemType = Inputs.sMemberType;        //회원구분
    //동호회 포인트 수동처리
    if (sMemType == "G"){
        //Process_Group_Point(Inputs, Outputs);
    }else{
        if (sTxnType == "P"){    //적립

            //Call_EAI_VAN_Plus(Inputs, Outputs);

        }else if (sTxnType == "M") {   //사용
            //Call_EAI_VAN_Minus(Inputs, Outputs);
        }
    }
}


function searchHelp(){
	//회원명 찾기
	mbrSearchFn();

	//가맹점 찾기
	channelSearchFn();

	//검수자 찾기
	inspectorSearchFn();

	//승인자 찾기
	approverSearchFn();
}

function channelSearchFn(){
	$("#btnChannelSearch").on("click",function(){
		channelSearchHelpPop ={
			        id : "channelSearchPopDiv"
			    };
		channelSearchHelpPop.popup = function (){
			channelSearchHelpPop.pop = $('#'+channelSearchHelpPop.id).ifvsfPopup({
			            enableModal: true,
			            enableResize: false,
			            contentUrl: '<ifvm:url name="channelSearchHelp"/>' + '?ouTypeCd=' + 'A',
			            contentType: "ajax",
			            title: "<spring:message code='L00987'/>",
			            width: "700px"
			        });
			};
			channelSearchHelpPop.beforeClose = function (obj) {
			};
			channelSearchHelpPop.close = function (obj) {
				 if(obj!=null || typeof obj!="undefined"){
			        	$("#dtlChnlNm").val(obj.chnlNm);
			        	$("#dtlChnlNo").val(obj.chnlNo);
			        	$("#dtlBizrNo").val(obj.bizrNo);
			        	$("#ridChnl").val(obj.rid);

			        }
			        this.beforeClose(obj);
			        channelSearchPopDiv._destroy();
			 };
			channelSearchHelpPop.popup();
	});

}

function mbrSearchFn(){
	$("#btnMemSearch").on("click",function(){
		mbrSearchHelpPop ={
		        id : "mbrSearchPopDiv"
		    };
		mbrSearchHelpPop.popup = function (){
		mbrSearchHelpPop.pop = $('#'+mbrSearchHelpPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="mbrSearchHelp"/>'    ,
		            contentType: "ajax",
		            title: "<spring:message code='L00988'/>",
		            width: "700px",


		        });
		};
		mbrSearchHelpPop.beforeClose = function (obj) {
		};
		mbrSearchHelpPop.close = function (obj) {
			 if(obj!=null || typeof obj!="undefined"){
		        	$("#dtlCustNm").val(obj.custNm);
		        	$("#dtlMbrNo").val(obj.mbrNo);
		        	$("#ridMbr").val(obj.rid);
		        	$("#dtlMemDiv").val(obj.memDiv);
		        }
		        this.beforeClose(obj);
		        mbrSearchPopDiv._destroy();
		 };
		 mbrSearchHelpPop.popup();
	});
}
function close(obj){

}
function inspectorSearchFn(){
	$("#inspectorhSearchBtn").on("click",function(){
		empSearchHelpPop ={
		        id : "empSearchPopDiv"
		    };
		empSearchHelpPop.popup = function (){
			empSearchHelpPop.pop = $('#'+empSearchHelpPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="empSearchHelp"/>'   + '?authNm=' + 'E10007'  ,
		            contentType: "ajax",
		            title: "<spring:message code='L00989'/>",
		            width: "700px",
		        });
		};
		empSearchHelpPop.beforeClose = function (obj) {
		};
		empSearchHelpPop.close = function (obj) {
			 if(obj!=null || typeof obj!="undefined"){
		        	$("#dtlRidActc").val(obj.name);
		        	$("#ridActc").val(obj.rid);
		        }
		        this.beforeClose(obj);
		        empSearchPopDiv._destroy();
		 };
		 empSearchHelpPop.popup();
	});
}

function approverSearchFn(){
	$("#approverSearchBtn").on("click",function(){
		empSearchHelpPop ={
		        id : "empSearchPopDiv"
		    };
		empSearchHelpPop.popup = function (){
			empSearchHelpPop.pop = $('#'+empSearchHelpPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="empSearchHelp"/>'   + '?authNm=' + 'E10008'  ,
		            contentType: "ajax",
		            title: "<spring:message code='L00990'/>",
		            width: "700px"
		        });
		};
		empSearchHelpPop.beforeClose = function (obj) {
		};
		empSearchHelpPop.close = function (obj) {
			 if(obj!=null || typeof obj!="undefined"){
				 $("#dtlRidApv").val(obj.name);
				 $("#ridApv").val(obj.rid);
		        }
		        this.beforeClose(obj);
		        empSearchPopDiv._destroy();
		 };
		 empSearchHelpPop.popup();
	});
}


function saveManualInfo(){
	manualDtlValid=$("#manualDetailForm").ifvValidation();
	if(manualDtlValid.confirm()==true){
		if($("#dtlCustNm").val()==""){
   		 $.ifvCallValidationBox( $("#dtlCustNm"), "<spring:message code='C00024'/>" );

		} else if($("#dtlChnlNm").val()==""){
	   		 $.ifvCallValidationBox( $("#dtlChnlNm"), "<spring:message code='C00024'/>" );
		} else{
			var submitData =$("#manualDetailForm").getSubmitData();
//			submitData.dtlCustNm = $("#dtlCustNm").val();
	//		submitData.dtlChnlNm = $("#dtlChnlNm").val();
			submitData.ridActc = $("#ridActc").val();
			submitData.ridApv = $("#ridApv").val();
			submitData.ridChnl = $("#ridChnl").val();
			submitData.ridMbr = $("#ridMbr").val();
			if(testViewList_rid=="null"){  //신규
				$.ifvSyncPostJSON('<ifvm:action name="insertManualInfo"/>', submitData
						, function(result) {
							alert('<spring:message code="I00741"/>');

					    });

			}else{ 	//수정
				submitData.rid = testViewList_rid;
				$.ifvSyncPostJSON('<ifvm:action name="updateManualInfo"/>', submitData
						, function(result) {
							alert('<spring:message code="M00106"/>');
					    });
			}
		}
	}

}

function commCodeSetting(){

	//요청 유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'REQ_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlRqtTypeTemp").tmpl(result.rows);
		$("#dtlRqtType").append(temp);
	});

	//포인트 유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'TXN_TYPE_CD_TM'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlPointTypeTemp").tmpl(result.rows);
		$("#dtlPointType").append(temp);
	});
	//수동 적립 사유
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'TXN_REASON_ALL_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#hndopAcuStblRsnTemp").tmpl(result.rows);
		$("#hndopAcuStblRsn").append(temp);
	});

	//회원 구분
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'MEMBER_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlMemDivTemp").tmpl(result.rows);
		$("#dtlMemDiv").append(temp);
	});
	//회원등급
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'MEMBER_GRADE'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlMemGradeTemp").tmpl(result.rows);
		$("#dtlMemGrade").append(temp);
	});


	//처리 상태
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'TXN_STATUS_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlTrtStatusTemp").tmpl(result.rows);
		$("#dtlTrtStatus").append(temp);
	});


	//승인 요청 기관
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'TXN_TERMINAL'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlApvRqtInstnTemp").tmpl(result.rows);
		$("#dtlApvRqtInstn").append(temp);
	});

	//승인 응답
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'VAN_RETURN_CODE'
		, enableNA : true
	},function(result) {
		var temp = $("#dtlApvRpyTemp").tmpl(result.rows);
		$("#dtlApvRpy").append(temp);
	});

}
//1000단위 정규식
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
function numberFormatterSetting(){
	var numFormatVal=$("#dtlRqtPoint").val();

	$("#dtlRqtPoint").val(numberWithCommas(numFormatVal));
	$("#dtlRqtPoint").attr("style", "text-align:right;");

	numFormatVal=$("#dtlStblAftrPointBlnc").val();
	$("#dtlStblAftrPointBlnc").val(numberWithCommas(numFormatVal));
	$("#dtlStblAftrPointBlnc").attr("style", "text-align:right;");


}
function checkButtnAuth(){
	var isAuth = false;
	var authArr = $.ifvmGetAuthInfo().authList;
	for(var i = 0 ; i < authArr.length ; i++){
		var authObj = authArr[i];
		var authName = authObj.authName;
		if(authName == 'E10011') isAuth = true;
	}
	if(!isAuth){
		$("#vanDirectBtn").remove();
	}
}

$(document).ready(function(){
	//van 즉시승인 권한 체크
	//checkButtnAuth();
 	commCodeSetting();

	manualDetailDataLoad(testViewList_rid);
 	vanApproval();

 	$("#saveManualInfoBtn").on("click",function(){
 		saveManualInfo();
 	});

 	$("#manualListBtn").on("click",function(){
 		var url = '<ifvm:url name="manualList"/>';
 		qtjs.href(url);
 	})


 	$("#inspectionReqBtn").on("click",function(){
 		inspectionReqFn();
 	})
 	searchHelp();
 	numberFormatterSetting();
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

</script>

<script id="userIdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="userCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>


<div id="manualDetailForm" >

<div class="form-horizontal underline top_well" >
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L00685"/></span>
			</div>
		</div>
  <div class="row  qt_border">
  <ifvm:inputNew type="select" id="dtlApprDt" maxLength="50"  dto="dtlApprDt"   label="L00607" labelClass="1" conClass="2" />
  <ifvm:inputNew type="text" id="dtlMbrNo" maxLength="50"  dto="dtlMbrNo"   label="M00688" labelClass="1" conClass="2" required="true" />
  <ifvm:inputNew type="text" id="dtlchnlNo" maxLength="50"  dto="dtlchnlNo"   label="L00564" labelClass="1" conClass="2" required="true"/>
  <ifvm:inputNew type="text" id="dtlAcrlStamp" maxLength="50"  dto="dtlAcrlStamp"   label="L00557" labelClass="1" conClass="2" />

 </div>

 <div class="row  qt_border">
   <ifvm:inputNew type="select" id="dtlAcrlStamp" maxLength="50"  dto="dtlAcrlStamp"   label="L00667" labelClass="1" conClass="2" />
	<label class="col-xs-1 control-label"><spring:message code="L00435"/></label>
	<div class="col-xs-2 control_content">
		<div class="input-group">
			<ifvm:input type="text" id="addr1Zip" />
			<span class="input-group-addon" id="btnAddrZip1Pop">
				<a><i class="fa fa-search"></i></a>
			</span>
		</div>
	</div>
	<label class="col-xs-1 control-label"><spring:message code="L00565"/></label>
	<div class="col-xs-2 control_content">
		<div class="input-group">
			<ifvm:input type="text" id="addr1Zip" />
			<span class="input-group-addon" id="btnAddrZip1Pop">
				<a><i class="fa fa-search"></i></a>
			</span>
		</div>
	</div>
  <ifvm:inputNew type="text" id="dtlCnclDt" maxLength="50"  dto="dtlCnclDt"   label="L00180" labelClass="1" conClass="2" />
 </div>

</div>

 <div class="half_wrap top_well">
	<div class="half_content half_left">
		<div class="form-horizontal top_well underline" id="reachInfo" >
			<div class="row  qt_border">
				<ifvm:inputNew type="text" id="dtlTxnType2Cd" maxLength="50"  dto="dtlTxnType2Cd"   label="L00669" labelClass="2" conClass="4" />
				<ifvm:inputNew type="text" id="dtlTxnType2Cd" maxLength="50"  dto="dtlTxnType2Cd"   label="L00670" labelClass="2" conClass="4" />
			</div>

			<div class="row  qt_border">
				<ifvm:inputNew type="textarea" id="dtlTxnType2Cd" maxLength="50"  dto="dtlTxnType2Cd"   label="L00671" labelClass="2" conClass="10" />
			</div>

		</div>
	</div>

	<div class="half_content half_right">
		<div class="page_btn_area">
			<div class="col-xs-12">
				<span><spring:message code="L00687"/></span>
			</div>
		</div>
		<div class="form-horizontal top_well underline" id="mktAgree" >
			<div class="row  qt_border">
				<label class="col-xs-2 control-label"><spring:message code="L00677"/></label>
				<div class="col-xs-4 control_content">
					<div class="input-group">
						<ifvm:input type="text" id="addr1Zip" />
						<span class="input-group-addon" id="btnAddrZip1Pop">
							<a><i class="fa fa-search"></i></a>
						</span>
					</div>
				</div>

				<label class="col-xs-2 control-label"><spring:message code="L00678"/></label>
				<div class="col-xs-4 control_content">
					<div class="input-group">
						<ifvm:input type="text" id="addr1Zip" />
						<span class="input-group-addon" id="btnAddrZip1Pop">
							<a><i class="fa fa-search"></i></a>
						</span>
					</div>
				</div>
			</div>


		</div>

	</div>
  </div>

</div>
<div class="pop_btn_area">

<button class="btn btn-sm" id="stampInfoDetailBtn"><i class="glyphicon glyphicon-check"></i><spring:message code="M00280"/></button>
	 <button class="btn btn-sm" id="cancelPopBtn"><spring:message code="C00040"/></button>
	 <button class="btn btn-sm" id="vanDirectBtn"><spring:message code="L00662"/></button>
	 <button class="btn btn-sm" id="closeStampDtlPop"><spring:message code="L00663"/></button>
</div>

<script>
</script>
<div id="testViewListPopupContainer" class="popup_container"></div><!-- 팝업 -->
 <div id="stampDetailPopDiv" class="popup_container content_container"></div>
