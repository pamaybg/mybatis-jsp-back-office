<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 
=========================================================================================
=========================================================================================

JAVASCRIPT START

=========================================================================================
=========================================================================================
 -->
<script>

var rlstFindMemSeq = 1;
var rlstFindPntSeq = 1;
var rlstAcrlPntSeq = 1;
var rlstRdmPntSeq = 1;

var txnCommonResultData = {
	 resultFindMember : new Array()
	,resultFindPoint : new Array()
	,resultAcrlPoint : new Array()
	,resultRdmPoint : new Array()
};




/*******************************************************************************
 *******************************************************************************
 								회원 조회 관련 함수 
 *******************************************************************************
 *******************************************************************************/
/**
 * 회원 조회 실행
 */
function loyTxnFindMember(){
 	var reqObj = new Object();
	reqObj.cust_nm     = $("#inputMemNm").val();
	reqObj.cell_phn    = $("#inputMemCellPhn").val();
	reqObj.mbr_card_no = $("#inputMemCardNo").val();
	reqObj.email       = $("#inputMemEmail").val();
	reqObj.mbr_no      = $("#inputMemNo").val();
	reqObj.loy_pgm_no  = $("#inputMemLoyPgmNo").val();
	reqObj.chnl_no     = "";
	
	$.ifvProgressControl(true);
	$.ifvSyncPostJSON(
		'<ifv:action name="loyTxnFindMember"/>'
	    ,reqObj 
		,function(result) {
			// Object 처리
	    	var newObj = new Object();
	    	newObj.seq = rlstFindMemSeq++;
	    	newObj.res = result;
	    	txnCommonResultData.resultFindMember.push(newObj);
	    	
	    	// 화면
	    	$("#selectFindMemberResultSeq").prepend("<option value='" + newObj.seq +"'>" + newObj.seq + ". " + result.tran_no + "</option>");
	    	$("#selectFindMemberResultSeq").val(newObj.seq).prop("selected", true);
	    	$("#txtarMem").text(getFindMemberResText(result));
	    	
	    	$.ifvProgressControl(false);
        }
	    ,function(result) { // Fail
	    	alert("FAIL");
			$.ifvProgressControl(false);
		}
    );
	return true;
}
function getFindMemberResText(result){
	var rlstTxt = ""
		+"\n>> 전문길이 : "+ result.msg_len
		+"\n>> 전문유형 : "+ result.msg_type
		+"\n>> 전송일자 : "+ result.msg_date
		+"\n>> 전송시간 : "+ result.msg_time
		+"\n>> 응답코드 : "+ result.res_code
		+"\n>> 응답메세지 : "+ result.res_msg
		+"\n>> 거래고유번호 : "+ result.tran_no
		+"\n>> 거래일자 : "+ result.tran_date
		+"\n>> 거래시간 : "+ result.tran_time
		+"\n>> 고객명 : "+ result.cust_nm
		+"\n>> 휴대폰번호 : "+ result.cell_phn
		+"\n>> 멤버십 카드번호 : "+ result.mbr_card_no
		+"\n>> 이메일 : "+ result.email
		+"\n>> 회원번호 : "+ result.mbr_no
		+"\n>> 로얄티 프로그램 번호 : "+ result.loy_pgm_no
		+"\n>> 가맹점(채널)번호 : "+ result.chnl_no
		+"\n>> 회원 갯수 : "+ result.hdr_item_size
		+"\n>> 회원 item별 전문길이 : "+ result.hdr_item_item_len
		+"\n>> 회원 전체 전문길이 : "+ result.hdr_item_toatal_len
		;
	
	return rlstTxt;
}
/*******************************************************************************
 *******************************************************************************
 								회원 조회 관련 함수 
 *******************************************************************************
 *******************************************************************************/





/*******************************************************************************
 *******************************************************************************
 								포인트 조회 관련 함수 
 *******************************************************************************
 *******************************************************************************/
/** 포인트 조회 실행 */
function loyTxnFindPoint(){
	var reqObj = new Object();
	reqObj.auth_type  = $("#inputFindPntIdenType").val();
	reqObj.auth_val   = $("#inputFindPntIdenVal").val();
	reqObj.loy_pgm_no =	$("#inputFindPntPgmNo").val();
	reqObj.offr_type =	$("#inputFindPntOffrType").val(); 
	reqObj.offr_sub_type =	$("#inputFindPntOffrSubType").val(); 
	reqObj.chnl_no    = "";
	
	$.ifvProgressControl(true);
	$.ifvSyncPostJSON(
		'<ifv:action name="loyTxnFindPoint"/>'
	    ,reqObj 
		,function(result) {
			// Object 처리
	    	var newObj = new Object();
	    	newObj.seq = rlstFindPntSeq++;
	    	newObj.res = result;
	    	txnCommonResultData.resultFindPoint.push(newObj);
	    	
	    	// 화면
	    	$("#selectFindPointResultSeq").prepend("<option value='" + newObj.seq +"'>" + newObj.seq + ". " + result.tran_no + "</option>");
	    	$("#selectFindPointResultSeq").val(newObj.seq).prop("selected", true);
	    	$("#txtarFindPnt").text(getFindPointResText(result));
	    	
	    	$.ifvProgressControl(false);
        }
	    ,function(result) { // Fail
	    	alert("FAIL");
			$.ifvProgressControl(false);
		}
    );
	return true;
}
function getFindPointResText(result){
	var rlstTxt = ""
		+">> 전문길이 : "+ result.msg_len
		+"\n>> 전문유형 : "+ result.msg_type
		+"\n>> 전송일자 : "+ result.msg_date
		+"\n>> 전송시간 : "+ result.msg_time
		+"\n>> 응답코드 : "+ result.res_code
		+"\n>> 응답메세지 : "+ result.res_msg
		+"\n>> 거래고유번호 : "+ result.tran_no
		+"\n>> 거래일자 : "+ result.tran_date
		+"\n>> 거래시간 : "+ result.tran_time
		+"\n>> 로얄티 프로그램 번호 : "+ result.loy_pgm_no
		+"\n>> 가맹점(채널)번호 : "+ result.chnl_no
		+"\n>> 오퍼 유형 : "+ result.offr_type
		+"\n>> 오퍼 상세 유형 : "+ result.offr_sub_type
		+"\n>> 가용 Point : "+ result.use_pnt_amt
		+"\n>> 누적 Point : "+ result.acrl_pnt_amt
		+"\n>> 익월말 소멸예정 포인트 : "+ result.redm_expr_amt
		+"\n>> 총적립 포인트 : "+ result.total_acrl_pnt
		+"\n>> 총사용 포인트 : "+ result.total_rdm_pnt
			;
	
	return rlstTxt;
}
/*******************************************************************************
 *******************************************************************************
 								포인트 조회 관련 함수 
 *******************************************************************************
 *******************************************************************************/





/*******************************************************************************
 *******************************************************************************
 								포인트 적립 관련 함수 
 *******************************************************************************
 *******************************************************************************/
/**
 * 적립 / 적립취소 실행
 */
function loyTxnAcrlPoint(){
	var reqObj = new Object();
	reqObj.auth_type        = $("#inputAcrlIdenType").val();
	reqObj.auth_val         = $("#inputAcrlIdenVal").val(); 
	reqObj.loy_pgm_no       = $("#inputAcrlPgmNo").val();   
	reqObj.camp_no          = $("#inputAcrlCamNo").val();   
	reqObj.offr_type        = $("#inputAcrlOffrType").val();
	reqObj.offr_sub_type    = $("#inputAcrlOffrSubType").val();
	reqObj.chnl_no          = $("#inputAcrlChnlNo").val();
	reqObj.pos_no           = $("#inputAcrlPosNo").val();
	reqObj.tran_type_cd     = $("#selectAcrlTranCode :selected").val();
	reqObj.tran_dtl_type_cd = $("#selectAcrlTranDtlCode :selected").val();
	reqObj.tgt_tran_date    = $("#inputAcrlApprDate").val();
	reqObj.tgt_tran_no      = $("#inputAcrlApprNo").val();
	reqObj.accum_point      = $("#inputAcrlPntAmt").val();
	reqObj.accum_src_no     = $("#inputAcrlRefNo").val();
	reqObj.bill_odr_no      = $("#inputAcrlBillNo").val();
	reqObj.tran_amt         = $("#inputAcrlTranAmt").val();
	reqObj.mem_card_no      = $("#inputAcrlMemCardNo").val();
	reqObj.pay_mthd_date    = $("#inputAcrlPaymentDt").val();
	reqObj.sales_amt        = $("#inputAcrlTotSalesAmt").val();
	reqObj.pur_stat_cd      = "R";

	
	$.ifvProgressControl(true);
	$.ifvSyncPostJSON(
		'<ifv:action name="loyTxnAcrlPoint"/>'
	    ,reqObj 
		,function(result) {
	    	// Object 처리
	    	var newObj = new Object();
	    	newObj.seq = rlstAcrlPntSeq++;
	    	newObj.res = result;
	    	txnCommonResultData.resultAcrlPoint.push(newObj);
	    	
	    	// 화면 처리
	    	$("#selectAcrlPointResultSeq").prepend("<option value='" + newObj.seq +"'>" + newObj.seq + ". " + result.tran_no + "</option>");
	    	$("#selectAcrlPointResultSeq").val(newObj.seq).prop("selected", true);
	    	$("#txtarAcrlPnt").text(getAcrlPointResText(result));
	    	
	    	$.ifvProgressControl(false);
        }
	    ,function(result) { // Fail
	    	alert("FAIL");
			$.ifvProgressControl(false);
		}
    );
	return true;
}
function getAcrlPointResText(result){
	var rlstTxt = ""
		+">> 전문길이 : "+ result.msg_len
		+"\n>> 전문유형 : "+ result.msg_type
		+"\n>> 전송일자 : "+ result.msg_date
		+"\n>> 전송시간 : "+ result.msg_time
		+"\n>> 응답코드 : "+ result.res_code
		+"\n>> 응답메세지 : "+ result.res_msg
		+"\n>> 거래고유번호 : "+ result.tran_no
		+"\n>> 거래일자 : "+ result.tran_date
		+"\n>> 거래시간 : "+ result.tran_time
		+"\n>> 거래유형코드 : "+ result.tran_type_cd
		+"\n>> 거래유형상세코드 : "+ result.tran_dtl_type_cd
		+"\n>> 거래유형상세설명 : "+ result.tran_dtl_type_desc
		+"\n>> 원거래 승인일자 : "+ result.tgt_tran_date
		+"\n>> 원거래 승인번호 : "+ result.tgt_tran_no
		+"\n>> 로얄티 프로그램 번호 : "+ result.loy_pgm_no
		+"\n>> 캠페인 번호 : "+ result.camp_no
		+"\n>> 오퍼 유형 : "+ result.offr_type
		+"\n>> 오퍼 상세 유형 : "+ result.offr_sub_type
		+"\n>> 적립처(채널)번호 : "+ result.chnl_no
		+"\n>> POS번호 : "+ result.pos_no
		+"\n>> 영수증(주문) 번호 : "+ result.bill_odr_no
		+"\n>> 참조번호 : "+ result.accum_src_no
		+"\n>> 승인일자 : "+ result.appr_date
		+"\n>> 승인시간 : "+ result.appr_time
		+"\n>> 승인번호 : "+ result.appr_no
		+"\n>> 발생 Point : "+ result.apply_pnt_amt
		+"\n>> 가용 Point : "+ result.use_pnt_amt
		+"\n>> 누적 Point : "+ result.acrl_pnt_amt
		+"\n>> 익월말 소멸예정 포인트 : "+ result.redm_expt_pnt
		+"\n>> 이벤트 메시지 : "+ result.evnt_msg
		+"\n>> 인증유형 : "+ result.auth_type
		+"\n>> 인증값 : "+ result.auth_val
		+"\n>> 적립 포인트 : "+ result.accum_point
		+"\n>> 거래 금액 : "+ result.tran_amt
		+"\n>> 멤버십 카드번호 : "+ result.mem_card_no
		+"\n>> 결제완료일자 : "+ result.pay_mthd_date
		+"\n>> 총 매출금액 : "+ result.sales_amt
		+"\n>> 구매상태코드 : "+ result.pur_stat_cd
	
	return rlstTxt;
}

/*******************************************************************************
 *******************************************************************************
 								포인트 적립 관련 함수 
 *******************************************************************************
 *******************************************************************************/



/*******************************************************************************
 *******************************************************************************
 								포인트 사용 관련 함수 
 *******************************************************************************
 *******************************************************************************/
/**
 * 사용 / 사용취소 실행
 */
function loyTxnRdmPoint(){
	var reqObj = new Object();
	reqObj.auth_type        = $("#inputRdmIdenType").val();
	reqObj.auth_val         = $("#inputRdmIdenVal").val();
	reqObj.loy_pgm_no       = $("#inputRdmPgmNo").val();
	reqObj.offr_type        = $("#inputRdmOffrType").val();
	reqObj.offr_sub_type    = $("#inputRdmOffrSubType").val();
	reqObj.chnl_no          = $("#inputRdmChnlNo").val();
	reqObj.pos_no           = $("#inputRdmPosNo").val();
	reqObj.tran_type_cd     = $("#selectRdmTranCode :selected").val();
	reqObj.tran_dtl_type_cd = $("#selectRdmTranDtlCode :selected").val();
	reqObj.tgt_tran_date    = $("#inputRdmOrgnApprDt").val();
	reqObj.tgt_tran_no      = $("#inputRdmOrgnApprNo").val();
	reqObj.tran_pnt         = $("#inputRdmTranPnt").val();
	reqObj.bill_odr_no      = $("#inputRdmBillNo").val();
	reqObj.tran_amt         = $("#inputRdmTranAmt").val();

	$.ifvProgressControl(true);
	$.ifvSyncPostJSON(
		'<ifv:action name="loyTxnRdmPoint"/>'
	    ,reqObj 
		,function(result) { // Success
	    	// Object 처리
	    	var newObj = new Object();
	    	newObj.seq = rlstRdmPntSeq++;
	    	newObj.res = result;
	    	txnCommonResultData.resultRdmPoint.push(newObj);
	    	
	    	// 화면 처리
	    	$("#selectRdmPointResultSeq").prepend("<option value='" + newObj.seq +"'>" + newObj.seq + ". " + result.tran_no + "</option>");
	    	$("#selectRdmPointResultSeq").val(newObj.seq).prop("selected", true);
	    	$("#txtarRdmPnt").text(getRdmPointResText(result));
	    	
	    	$.ifvProgressControl(false);
         }
		,function(result) { // Fail
			alert("FAIL");
			$.ifvProgressControl(false);
		}
    );
	return true;
}
function getRdmPointResText(result){
	var rlstTxt = ""
		+">> 전문길이 : "+ result.msg_len
		+"\n>> 전문유형 : "+ result.msg_type
		+"\n>> 전송일자 : "+ result.msg_date
		+"\n>> 전송시간 : "+ result.msg_time
		+"\n>> 응답코드 : "+ result.res_code
		+"\n>> 응답메세지 : "+ result.res_msg
		+"\n>> 거래고유번호 : "+ result.tran_no
		+"\n>> 거래일자 : "+ result.tran_date
		+"\n>> 거래시간 : "+ result.tran_time
		+"\n>> 거래유형코드 : "+ result.tran_type_cd
		+"\n>> 거래유형상세코드 : "+ result.tran_dtl_type_cd
		+"\n>> 거래유형상세설명 : "+ result.tran_dtl_type_desc
		+"\n>> 승인일자 : "+ result.appr_date
		+"\n>> 승인시간 : "+ result.appr_time
		+"\n>> 승인번호 : "+ result.appr_no
		+"\n>> 원거래 승인일자 : "+ result.tgt_tran_date
		+"\n>> 원거래 승인번호 : "+ result.tgt_tran_no
		+"\n>> 로얄티 프로그램 번호 : "+ result.loy_pgm_no
		+"\n>> 오퍼 유형 : "+ result.offr_type
		+"\n>> 오퍼 상세 유형 : "+ result.offr_sub_type
		+"\n>> 가맹점(채널)번호 : "+ result.chnl_no
		+"\n>> POS번호 : "+ result.pos_no
		+"\n>> 영수증(주문) 번호 : "+ result.bill_odr_no
		+"\n>> 회원번호 : "+ result.mem_no
		+"\n>> 인증유형 : "+ result.auth_type
		+"\n>> 인증값 : "+ result.auth_val
		+"\n>> 가용 Point : "+ result.use_pnt_amt
		+"\n>> 누적 Point : "+ result.acrl_pnt_amt
		+"\n>> 익월말 소멸예정 포인트 : "+ result.redm_expt_pnt
		+"\n>> 거래 포인트 : "+ result.tran_pnt
		+"\n>> 거래 금액 : "+ result.tran_amt
		+"\n>> 포인트 사용 비밀번호 : "+ result.pnt_use_pwd
		+"\n>> 이벤트 메시지 : "+ result.evnt_msg
		;
	
	return rlstTxt;
}
/*******************************************************************************
 *******************************************************************************
 								포인트 사용 관련 함수 
 *******************************************************************************
 *******************************************************************************/




/**
 * 
 */
function initComponent(){
	
	/****************************************************** 
	 *						Find Member
	 ******************************************************/
	$("#btnMemExamCellPhn").click(function(){
		$("#inputMemNm").val("jhchoi");
		$("#inputMemCellPhn").val("01062816411");
		$("#inputMemCardNo").val("");
		$("#inputMemEmail").val("");
		$("#inputMemNo").val("");
		$("#inputMemLoyPgmNo").val("LP0001");  
	});
	$("#btnMemExamEmail").click(function(){
		$("#inputMemNm").val("");
		$("#inputMemCellPhn").val("");
		$("#inputMemCardNo").val("");
		$("#inputMemEmail").val("jhchoi999@quintet.co.kr");
		$("#inputMemNo").val("");
		$("#inputMemLoyPgmNo").val("LP0001");  
	});
	$("#btnMemExamMbrNo").click(function(){
		$("#inputMemNm").val("");
		$("#inputMemCellPhn").val("");
		$("#inputMemCardNo").val("");
		$("#inputMemEmail").val("");
		$("#inputMemNo").val("11");
		$("#inputMemLoyPgmNo").val("LP0001");  
	});
	$("#btnMemExecute").click(function(){
		loyTxnFindMember();
	});
	$("#selectFindMemberResultSeq").change(function(e) {
  		var curVal = e.target.value;
		txnCommonResultData.resultFindMember.forEach(function(row){
			if(""+row.seq == curVal){
				$("#txtarMem").text(getFindMemberResText(row.res));
				return;
			}
		});
	});
	/****************************************************** 
	 *						Find Member 
	 ******************************************************/
	
	
	/****************************************************** 
	 *						Find Point 
	 ******************************************************/
	$("#btnFindPointExecute").click(function(){
		loyTxnFindPoint();
	});
	// Find Point 
	$("#btnFindPointExam1").click(function(){
		$("#inputFindPntIdenType").val("02");
		$("#inputFindPntIdenVal").val("01062816411");
		$("#inputFindPntPgmNo").val("LP0001");
	});
	$("#selectFindPointResultSeq").change(function(e) {
		var curVal = e.target.value;
		txnCommonResultData.resultFindPoint.forEach(function(row){
			if(""+row.seq == curVal){
				$("#txtarFindPnt").text(getFindPointResText(row.res));
				return;
			}
		});
	});
	/****************************************************** 
	 *						Find Point 
	 ******************************************************/
	
	 
	/****************************************************** 
	 *						Acrl Point 
	 ******************************************************/
	$("#btnAcrlPointExecute").click(function(){
		loyTxnAcrlPoint();	
	});
	
	// 직접적립 SET
	$("#btnAcrlPointDirect").click(function(){
		$("#inputAcrlIdenType").val("02");
		$("#inputAcrlIdenVal").val("01062816411"); 
		$("#inputAcrlPgmNo").val("LP0001");   
		$("#inputAcrlCamNo").val("");
		$("#inputAcrlChnlNo").val("CH0000026");
		$("#inputAcrlOffrNo").val("OFR201600099");
		$("#inputAcrlPosNo").val("POS-NO-00001");
		$("#selectAcrlTranCode").val("100").prop("selected", "selected");
		$("#selectAcrlTranDtlCode").val("110").prop("selected", "selected");
		$("#inputAcrlPntAmt").val("1000");
		$("#inputAcrlRefNo").val("");
		$("#inputAcrlBillNo").val("");
		$("#inputAcrlTranAmt").val("10000");
		$("#inputAcrlMemCardNo").val("");
		$("#inputAcrlPaymentDt").val("");
		$("#inputAcrlTotSalesAmt").val("");
		$("#inputAcrlApprNo").val("");
		$("#inputAcrlApprDate").val("");
	});

	// 직접적립취소 SET
	$("#btnAcrlPointDirectCancel").click(function(){
		$("#inputAcrlIdenType").val("02");
		$("#inputAcrlIdenVal").val("01062816411"); 
		$("#inputAcrlPgmNo").val("LP0001");   
		$("#inputAcrlCamNo").val("");
		$("#inputAcrlChnlNo").val("CH0000026");
		$("#inputAcrlOffrNo").val("OFR201600099");
		$("#inputAcrlPosNo").val("POS-NO-00001");
		$("#selectAcrlTranCode").val("120").prop("selected", "selected");
		$("#selectAcrlTranDtlCode").val("210").prop("selected", "selected");
		$("#inputAcrlPntAmt").val("0");
		$("#inputAcrlRefNo").val("");
		$("#inputAcrlBillNo").val("");
		$("#inputAcrlTranAmt").val("0");
		$("#inputAcrlMemCardNo").val("");
		$("#inputAcrlPaymentDt").val("");
		$("#inputAcrlTotSalesAmt").val("");
		$("#inputAcrlApprNo").val("값을 입력하세요");
		$("#inputAcrlApprDate").val("값을 입력하세요");
	});
	
	// 구매적립 SET
	$("#btnAcrlPointPur").click(function(){
		$("#inputAcrlIdenType").val("02");
		$("#inputAcrlIdenVal").val("01062816411"); 
		$("#inputAcrlPgmNo").val("LP0001");   
		$("#inputAcrlCamNo").val("");
		$("#inputAcrlChnlNo").val("CH0000026");
		$("#inputAcrlOffrNo").val("OFR201600099");
		$("#inputAcrlPosNo").val("POS-NO-00001");
		$("#selectAcrlTranCode").val("100").prop("selected", "selected");
		$("#selectAcrlTranDtlCode").val("100").prop("selected", "selected");
		$("#inputAcrlPntAmt").val("1000");
		$("#inputAcrlRefNo").val("");
		$("#inputAcrlBillNo").val("BILL-NO-0001");
		$("#inputAcrlTranAmt").val("10000");
		$("#inputAcrlMemCardNo").val("");
		$("#inputAcrlPaymentDt").val("20170116");
		$("#inputAcrlTotSalesAmt").val("10000");
		$("#inputAcrlApprNo").val("");
		$("#inputAcrlApprDate").val("");
	});
	
	// 구매적립취소 SET
	$("#btnAcrlPointPurCancel").click(function(){
		$("#inputAcrlIdenType").val("02");
		$("#inputAcrlIdenVal").val("01062816411"); 
		$("#inputAcrlPgmNo").val("LP0001");   
		$("#inputAcrlCamNo").val("");
		$("#inputAcrlChnlNo").val("CH0000026");
		$("#inputAcrlOffrNo").val("OFR201600099");
		$("#inputAcrlPosNo").val("POS-NO-00001");
		$("#selectAcrlTranCode").val("120").prop("selected", "selected");
		$("#selectAcrlTranDtlCode").val("210").prop("selected", "selected");
		$("#inputAcrlPntAmt").val("0");
		$("#inputAcrlRefNo").val("");
		$("#inputAcrlBillNo").val("");
		$("#inputAcrlTranAmt").val("0");
		$("#inputAcrlMemCardNo").val("");
		$("#inputAcrlPaymentDt").val("");
		$("#inputAcrlTotSalesAmt").val("");
		$("#inputAcrlApprNo").val("값을 입력하세요");
		$("#inputAcrlApprDate").val("값을 입력하세요");
	});
	
	$("#selectAcrlPointResultSeq").change(function(e) {
		var curVal = e.target.value;
		txnCommonResultData.resultAcrlPoint.forEach(function(row){
			if(""+row.seq == curVal){
				$("#txtarAcrlPnt").text(getAcrlPointResText(row.res));
				return;
			}
		});
	});
	/****************************************************** 
	 *						Acrl Point 
	 ******************************************************/

	/****************************************************** 
	 *						Rdm Point 
	 ******************************************************/
	$("#btnRdmPointExecute").click(function(){
		loyTxnRdmPoint();
	});
	// Rdm Point
	// 사용 SET
	$("#btnRdmPointUsePointExam").click(function(){
		$("#inputRdmIdenType").val("02");
		$("#inputRdmIdenVal").val("01062816411");
		$("#inputRdmPgmNo").val("LP0001");
		$("#inputRdmChnlNo").val("CH0000026");
		$("#inputRdmPosNo").val("POS-NO-00001");
		$("#selectRdmTranCode").val("200").prop("selected", "selected");
		$("#selectRdmTranDtlCode").val("200").prop("selected", "selected");
		$("#inputRdmOrgnApprDt").val("");
		$("#inputRdmOrgnApprNo").val("");
		$("#inputRdmTranPnt").val("1000");
		$("#inputRdmBillNo").val("");
		$("#inputRdmTranAmt").val("0");
	});
	
	// 사용취소 SET
	$("#btnRdmPointCancelExam").click(function(){
		$("#inputRdmIdenType").val("02");
		$("#inputRdmIdenVal").val("01062816411");
		$("#inputRdmPgmNo").val("LP0001");
		$("#inputRdmChnlNo").val("CH0000026");
		$("#inputRdmPosNo").val("POS-NO-00001");
		$("#selectRdmTranCode").val("220").prop("selected", "selected");
		$("#selectRdmTranDtlCode").val("130").prop("selected", "selected");
		$("#inputRdmOrgnApprDt").val("값을 입력하세요");
		$("#inputRdmOrgnApprNo").val("값을 입력하세요");
		$("#inputRdmTranPnt").val("0");
		$("#inputRdmBillNo").val("");
		$("#inputRdmTranAmt").val("0");
	});
	
	$("#selectRdmPointResultSeq").change(function(e) {
		var curVal = e.target.value;
		txnCommonResultData.resultRdmPoint.forEach(function(row){
			if(""+row.seq == curVal){
				$("#txtarRdmPnt").text(getRdmPointResText(row.res));
				return;
			}
		});
	});
	/****************************************************** 
	 *						Rdm Point 
	 ******************************************************/
}

function initComponentValue(){
	/** 회원 조회 */

	
	/** 포인트 조회 */
	
	
	/** 포인트 적립 */
	// 거래코드
	$("#selectAcrlTranCode").append("<option value='100'>적립 (100)</option>");
	$("#selectAcrlTranCode").append("<option value='110'>적립오류 (110)</option>");
	$("#selectAcrlTranCode").append("<option value='120'>적립취소 (120)</option>");
	
	// 거래상세코드
	$("#selectAcrlTranDtlCode").append("<option value='100'>구매 (100)</option>");
	$("#selectAcrlTranDtlCode").append("<option value='110'>가입 웰컴 (110)</option>");
	$("#selectAcrlTranDtlCode").append("<option value='120'>승급 웰컴 (120)</option>");
	$("#selectAcrlTranDtlCode").append("<option value='140'>선물/양도 (140)</option>");
	$("#selectAcrlTranDtlCode").append("<option value='150'>SWAP (150)</option>");
	$("#selectAcrlTranDtlCode").append("<option value='160'>VoC (160)</option>");
	$("#selectAcrlTranDtlCode").append("<option value='170'>포인트구매 (170)</option>");
	$("#selectAcrlTranDtlCode").append("<option value='199'>기타 (199)</option>");
	$("#selectAcrlTranDtlCode").append("<option value='210'>적립취소 (210)</option>");
	
	/** 포인트 사용 */
	$("#selectRdmTranCode").append("<option value='200'>사용 (200)</option>");
	$("#selectRdmTranCode").append("<option value='210'>사용오류 (210)</option>");
	$("#selectRdmTranCode").append("<option value='220'>사용취소 (220)</option>");
	
	$("#selectRdmTranDtlCode").append("<option value='200'>구매 (200)</option>");
	$("#selectRdmTranDtlCode").append("<option value='220'>소멸 (220)</option>");
	$("#selectRdmTranDtlCode").append("<option value='230'>선물/양도 (230)</option>");
	$("#selectRdmTranDtlCode").append("<option value='240'>SWAP (240)</option>");
	$("#selectRdmTranDtlCode").append("<option value='250'>마이너스 충당 (250)</option>");
	$("#selectRdmTranDtlCode").append("<option value='299'>기타 (299)</option>");
	$("#selectRdmTranDtlCode").append("<option value='130'>사용취소 (130)</option>");
}

$(document).ready(function() {
	initComponent();
	initComponentValue();
}); 

</script>
<!-- 
=========================================================================================
=========================================================================================

JAVASCRIPT END

=========================================================================================
=========================================================================================
 -->









<!-- 
=========================================================================================
=========================================================================================

HTML START

=========================================================================================
=========================================================================================
 -->

<div class="page-title">
	<h1 id="loyTitle">
		승인 서버 테스트
	</h1>
</div>

<!-- 
=========================================================================================
	회원조회
=========================================================================================
 -->
<div class="row">
	<div class="col-xs-12">
		<div class="page_btn_area">
			<div class="col-xs-2">
				<span>회원조회 조건</span>
			</div>
			<div class="col-xs-5 searchbtn_r">
				<button id="btnMemExamCellPhn" class="btn btn-sm">이름/휴대폰조회 SET</button>
				<button id="btnMemExamEmail" class="btn btn-sm">이메일조회 SET</button>
				<button id="btnMemExamMbrNo" class="btn btn-sm">회원번호조회 SET</button>
				<button id="btnMemExecute" class="btn btn-sm">실행</button>
		    </div>
		    <div class="col-xs-1">
		    
		    </div>
			<div class="col-xs-2">
				<span>회원조회 결과</span>
			</div>
			<div class="col-xs-2 searchbtn_r">
				<button id="btnFindMemberResultInit" class="btn btn-sm">초기화</button>
		    </div>
		</div>
		<div class="well form-horizontal mb0">
			<div class="row qt_border">
				<div class="col-xs-7">
					<div class="row qt_border">
						<div class="col-xs-4">
							<label class="col-xs-4 control-label">이름</label>
							<div class="col-xs-8 control_content">
								<div class="input-group">
									<ifv:input id="inputMemNm" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<label class="col-xs-4 control-label">휴대폰</label>
							<div class="col-xs-8 control_content">
								<div class="input-group">
									<ifv:input id="inputMemCellPhn" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<label class="col-xs-4 control-label"><span class="asterisk">*</span>로얄티<br>프로그램번호</label>
							<div class="col-xs-8 control_content">
								<div class="input-group">
									<ifv:input id="inputMemLoyPgmNo" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
					</div>
					<div class="row qt_border">
						<div class="col-xs-4">
							<label class="col-xs-4 control-label">멤버십<br>카드번호</label>
							<div class="col-xs-8 control_content">
								<div class="input-group">
									<ifv:input id="inputMemCardNo" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<label class="col-xs-4 control-label">이메일</label>
							<div class="col-xs-8 control_content">
								<div class="input-group">
									<ifv:input id="inputMemEmail" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-4">
							<label class="col-xs-4 control-label">회원번호</label>
							<div class="col-xs-8 control_content">
								<div class="input-group">
									<ifv:input id="inputMemNo" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
					</div>
					<div class="row qt_border">
						<div class="col-xs-9"></div>
						<label class="col-xs-3 control-label" style="text-align:left">
								※ 1. 조회조건 : "이름 + 휴대폰"
							<br>※ 2. 조회조건 : "휴대폰"
							<br>※ 3. 조회조건 : "멤버십 카드번호"
							<br>※ 4. 조회조건 : "E-Mail"
						</label>
					</div>
				</div>
				<div class="col-xs-1">
				
				</div>
				<div class="col-xs-4">
					<div class="row qt_border">
						<div class="col-xs-12">
							<div class="col-xs-12 control_content">
								<div class="input-group">
									<ifv:input id="selectFindMemberResultSeq" type="select"/>
								</div>
							</div>
						</div>
					</div>
					<textarea id="txtarMem" rows="8" cols="1"></textarea>
				</div>
			</div>
			
			
		</div>
	</div>
</div>


<!-- 
=========================================================================================
	포인트조회
=========================================================================================
 -->
<div class="row">
	<div class="page_btn_area">
		<div class="col-xs-2">
			<span>포인트조회 조건</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button id="btnFindPointExam1" class="btn btn-sm">조회 SET</button>
			<button id="btnFindPointExecute" class="btn btn-sm">실행</button>
	    </div>
	    <div class="col-xs-1">
	    
	    </div>
		<div class="col-xs-1">
			<span>포인트 조회 결과</span>
		</div>
		<div class="col-xs-3 searchbtn_r">
			<button id="btnFindPointResultInit" class="btn btn-sm">초기화</button>
	    </div>
	</div>
	<div class="well form-horizontal mb0">
		<div class="row qt_border">
			<div class="col-xs-7"> 
				<div class="row qt_border">
					<div class="col-xs-4">
						<label class="col-xs-5 control-label"><span class="asterisk">*</span>인증타입</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputFindPntIdenType" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<label class="col-xs-5 control-label"><span class="asterisk">*</span>인증값</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputFindPntIdenVal" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<label class="col-xs-5 control-label"><span class="asterisk">*</span>프로그램번호</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputFindPntPgmNo" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row qt_border">
					<div class="col-xs-4">
						<label class="col-xs-5 control-label">오퍼유형</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputFindPntOffrType" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-4">
						<label class="col-xs-5 control-label">오퍼상세유형</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputFindPntOffrSubType" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row qt_border">
					<div class="col-xs-6"></div>
					<label class="col-xs-6 control-label">
						※ 회원조회로 받은 "인증타입 + 인증값"을 기준으로 조회
					</label>
				</div>
			</div>
			<div class="col-xs-1">
	    
	    	</div>
			<div class="col-xs-4">
				<div class="row qt_border">
					<div class="col-xs-12">
						<div class="col-xs-12 control_content">
							<div class="input-group">
								<ifv:input id="selectFindPointResultSeq" type="select"/>
							</div>
						</div>
					</div>
				</div>
				<textarea id="txtarFindPnt" rows="5" cols="1"></textarea>
			</div>
		</div>
	</div>
</div>




<!-- 
=========================================================================================
	포인트 적립 / 적립 취소
=========================================================================================
 -->
<div class="row">
	<div class="page_btn_area">
		<div class="col-xs-2">
			<span>포인트 적립 / 적립취소 조건</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button id="btnAcrlPointDirect" class="btn btn-sm">직접적립 SET</button>
			<button id="btnAcrlPointDirectCancel" class="btn btn-sm">직접적립취소 SET</button>
			<button id="btnAcrlPointPur" class="btn btn-sm">구매적립 SET</button>
			<button id="btnAcrlPointPurCancel" class="btn btn-sm">구매적립취소 SET</button>
			<button id="btnAcrlPointExecute" class="btn btn-sm">실행</button>
	    </div>
	    <div class="col-xs-1">
	    
	    </div>
	    <div class="col-xs-2">
			<span>포인트 적립 / 적립취소 결과</span>
		</div>
		<div class="col-xs-2 searchbtn_r">
			<button id="btnAcrlPointResultInit" class="btn btn-sm">초기화</button>
	    </div>
	</div>
	<div class="well form-horizontal mb0">
		<div class="row qt_border">
			<div class="col-xs-7">
				<div class="row qt_border">
					<div class="col-xs-3">
						<label class="col-xs-5 control-label"><span class="asterisk">*</span>인증타입</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlIdenType" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label"><span class="asterisk">*</span>인증값</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlIdenVal" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label"><span class="asterisk">*</span>프로그램번호</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlPgmNo" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">POS번호</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlPosNo" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row qt_border">
					<div class="col-xs-3">
						<label class="col-xs-5 control-label"><span class="asterisk">*</span>거래유형코드</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="selectAcrlTranCode" type="select"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label"><span class="asterisk">*</span>거래유형<br>상세코드</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="selectAcrlTranDtlCode" type="select"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label"><span class="asterisk">*</span>사용처(채널)번호</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlChnlNo" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">적립포인트</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlPntAmt" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row qt_border">
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">참조번호</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlRefNo" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">영수증(주문)번호</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlBillNo" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">거래금액</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlTranAmt" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">멤버십<br>카드번호</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlMemCardNo" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row qt_border">
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">결제완료일자</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlPaymentDt" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">총 매출금액</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlTotSalesAmt" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">승인번호<br>(취소시)</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlApprNo" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">승인일자<br>(취소시)</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlApprDate" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row qt_border">
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">오퍼유형</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlOffrType" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">오퍼상세유형</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlOffrSubType" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
					<div class="col-xs-3">
						<label class="col-xs-5 control-label">캠페인번호</label>
						<div class="col-xs-7 control_content">
							<div class="input-group">
								<ifv:input id="inputAcrlCamNo" type="text" maxLength="100"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row qt_border">
					<div class="col-xs-6"></div>
					<label class="col-xs-6 control-label" style="text-align:left">
						          ※ 1. 직접적립 : "적립포인트 + 거래금액" 필수입력
						<br>※ 2. 직접적립취소 : "승인번호 + 승인일자" 필수입력
						<br>※ 3. 구매적립 : "영수증번호 + 거래금액 + 결제완료일자 + 총 매출금액" 필수입력
						<br>※ 4. 구매적립취소 : "승인번호 + 승인일자" 필수입력
					</label>
				</div>
			</div>
			<div class="col-xs-1">
			
			</div>
			<div class="col-xs-4">
				<div class="row qt_border">
					<div class="col-xs-12">
						<div class="col-xs-12 control_content">
							<div class="input-group">
								<ifv:input id="selectAcrlPointResultSeq" type="select"/>
							</div>
						</div>
					</div>
				</div>
				<textarea id="txtarAcrlPnt" rows="16" cols="1"></textarea>
			</div>
		</div>
	</div>
</div>


<!-- 
=========================================================================================
	포인트 사용 / 사용취소
=========================================================================================
 -->
<div class="row">
	<div class="col-xs-12">
		<div class="page_btn_area">
			<div class="col-xs-2">
				<span>포인트 사용 / 사용취소 조건</span>
			</div>
			<div class="col-xs-5 searchbtn_r">
				<button id="btnRdmPointUsePointExam" class="btn btn-sm">포인트 사용 SET</button>
				<button id="btnRdmPointCancelExam" class="btn btn-sm">포인트 사용취소 SET</button>
				<button id="btnRdmPointExecute" class="btn btn-sm">실행</button>
		    </div>
		    <div class="col-xs-1">
		    
		    </div>
			<div class="col-xs-2">
				<span>포인트 사용 / 사용취소 결과</span>
			</div>
			<div class="col-xs-2 searchbtn_r">
				<button id="btnRdmPointResultInit" class="btn btn-sm">초기화</button>
		    </div>
		</div>
		<div class="well form-horizontal mb0">
			<div class="row qt_border">
				<div class="col-xs-7">
					<div class="row qt_border">
						<div class="col-xs-3">
							<label class="col-xs-5 control-label"><span class="asterisk">*</span>인증타입</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmIdenType" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<label class="col-xs-5 control-label"><span class="asterisk">*</span>인증값</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmIdenVal" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<label class="col-xs-5 control-label"><span class="asterisk">*</span>프로그램번호</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmPgmNo" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<label class="col-xs-5 control-label"><span class="asterisk">*</span>사용처<br>(채널)번호</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmChnlNo" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
					</div>
					<div class="row qt_border">
						<div class="col-xs-3">
							<label class="col-xs-5 control-label">POS번호</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmPosNo" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<label class="col-xs-5 control-label"><span class="asterisk">*</span>거래유형코드</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="selectRdmTranCode" type="select"/>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<label class="col-xs-5 control-label"><span class="asterisk">*</span>거래유형<br>상세코드</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="selectRdmTranDtlCode" type="select"/>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<label class="col-xs-5 control-label">영수증(주문)<br>번호</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmBillNo" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
					</div>
					<div class="row qt_border">
						<div class="col-xs-3">
							<label class="col-xs-5 control-label">거래금액</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmTranAmt" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<label class="col-xs-5 control-label">사용포인트</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmTranPnt" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<label class="col-xs-5 control-label">원거래<br>승인일자</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmOrgnApprDt" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<label class="col-xs-5 control-label">원거래<br>승인번호</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmOrgnApprNo" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
					</div>
					<div class="row qt_border">
						<div class="col-xs-3">
							<label class="col-xs-5 control-label">오퍼유형</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmOffrType" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
						<div class="col-xs-3">
							<label class="col-xs-5 control-label">오퍼상세유형</label>
							<div class="col-xs-7 control_content">
								<div class="input-group">
									<ifv:input id="inputRdmOffrSubType" type="text" maxLength="100"/>
								</div>
							</div>
						</div>
					</div>
					<div class="row qt_border">
						<div class="col-xs-6"></div>
						<label class="col-xs-6 control-label" style="text-align:left">
							          ※ 1. 포인트 사용 : "사용포인트" 필수입력
							<br>※ 2. 포인트 사용취소 : "원거래 승인일자 + 원거래 승인번호" 필수입력
						</label>
					</div>
				</div>
				
				<div class="col-xs-1">
				
				</div>
				<div class="col-xs-4">
					<div class="row qt_border">
						<div class="col-xs-12">
							<div class="col-xs-12 control_content">
								<div class="input-group">
									<ifv:input id="selectRdmPointResultSeq" type="select"/>
								</div>
							</div>
						</div>
					</div>
					<textarea id="txtarRdmPnt" rows="10" cols="1"></textarea>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 
=========================================================================================
=========================================================================================

HTML END

=========================================================================================
=========================================================================================
 -->