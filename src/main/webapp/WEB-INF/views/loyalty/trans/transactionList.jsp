<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrNoLinkTemplate">
<a href ="javascript:void(0);" onclick="goMbrDetail('{{:ridMbr}}')"; style="color:#1266FF; text-decoration:underline;">{{:mbrNo}}</span>   
</script>


<script type="text/x-jsrender" id="mbrTypeCdTemplate">
{{if mbrStatCd == "D" }}
	휴면
{{/if}}
{{if mbrStatCd == "C" }}
	탈회
{{/if}}
{{if mbrStatCd == "A" || mbrStatCd == "S"}}
  	{{:custNm}}
{{/if}}
</script>

<script type="text/javascript">
var transactionList;
var transactionListDown;

var gridTransactionList;
var rid=null ;
var pointDialog = null;
var returnPage=null;
var txnRid =null;
var txnUniqNo =null;
var cardCheckObj={};
var regNumber = /[^0-9]/g;

//고객 상세 이동
function goCustDetail(id) {
  	qtjs.href('<ifvm:url name="mbrDetailNew"/>' + '?rid=' + id);
}


function geTtransactionSearch(){
    var ejGridOption = {
        rowSelected : function (args) {
        	rid=args.data.rid;
        	txnUniqNo= args.data.txnUniqNo;
        	cardCheckObj=args;
        	buttonStatus();
        },recordDoubleClick : function(args) {
    	  	var data = args.data.ridMbr ;
    	  	//goMbrDetail(data);
      	},
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            data.isMbrYn = 'Y';
            data.isCustYn = 'Y';
            data.isChnlYn = 'Y';
            return data;
        },
        loadComplete : function(obj){
        	 //$("#excelListBtn").prop('disabled',false);
        	//txnDesc
        	 cardCheckObj={};
        	buttonStatus();
        },
        dataUrl : '<ifvm:action name="getTransactionList"/>',
        columns:[
        	{
	      		  field : 'txnDt', headerText : '거래일자',headerTextAlign : 'center',width:'80', textAlign: 'center',customAttributes : {index : 'lpt.TXN_DT'}
	      	},{
	      		  field : 'txnDesc', headerText : '거래명', width:'220', headerTextAlign : 'center', textAlign: 'left', customAttributes : {index : 'txnDesc'}
	      	},{
	      		  field : 'pntTxnType1Cd', headerText : '유형', headerTextAlign : 'center', textAlign: 'center',width:'40',customAttributes : {index : 'lpt.PNT_TXN_TYPE_1_CD'}
	      	},{
	      		  field : 'pntTxnType2Cd', headerText : '상세유형', headerTextAlign : 'center', textAlign: 'center',width:'80',customAttributes : {index : 'lpt.PNT_TXN_TYPE_2_CD'}
	      	},{
	      		  field : 'txnStatNm', headerText : '상태', headerTextAlign : 'center', textAlign: 'center',width:'50'
	      	},{
	      		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign: 'left',width:'100',customAttributes : {index : 'lc.CHNL_NM'}
	      	},{
	      		  field : 'salesAmt', headerText : '판매가', headerTextAlign : 'center', textAlign: 'right',width:'50', format : '{0:n0}',customAttributes : {index : 'salesAmt'}
	      	},{
	      		  field : 'txnAmt', headerText : '결제금액', headerTextAlign : 'center', textAlign: 'right',width:'50', format : '{0:n0}',customAttributes : {index : 'lpt.TXN_AMT'} 
	      	},{
	      		  field : 'pntAmt', headerText : '포인트', headerTextAlign : 'center', textAlign: 'right',width:'50', format : '{0:n0}',customAttributes : {index : 'lpt.PNT_AMT'}
	      	},{
	      		  field : 'mbrNo', headerText : '회원번호', width:'70', headerTextAlign : 'center', textAlign: 'center', customAttributes : {index : 'mbrNo'}, template :'#mbrNoLinkTemplate'
	      	},{
	      		  field : 'custNm', headerText : '회원명', width:'70', headerTextAlign : 'center', textAlign: 'center', customAttributes : {index : 'custNm'}, template :'#mbrTypeCdTemplate'
	      	},{
	      		  field : 'rcptno', headerText : '주문(영수증)번호', width:'160', headerTextAlign : 'center', textAlign: 'left', customAttributes : {index : 'rcptno'}
	      	},{
	      		  field : 'ridMbr', headerText : 'ridMbr', visible: false,
	      	},{
	      		  field : 'rid', headerText : 'rid', visible: false,
	      	},{
	      		  field : 'mbrStatCd', headerText : 'mbrStatCd', visible: false,
	      	},{ 
	      		 field : 'txnUniqNo', headerText : 'txnUniqNo', visible: false,	      		
	      	}
		],
		 requestGridData : {
	      	  sidx : 'txnDt',
	      	  sord : 'desc'
	        },
	        radio: true,
	        gridDataInit: false,
       	tempId : 'ifvGridNotSearchTemplete',
        isHorizontalScroll : true,
        allowResizing: true
    };
    transactionList = $("#transactionListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridTransactionList = $("#gridTransactionList");
}

function getTransactionDown(){
    var ejGridOption = {
        rowSelected : function (args) { 
        	rid=args.data.rid;
        	cardCheckObj=args;
        	buttonStatus();
        },
       serializeGridData : function( data ){
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            data.isMbrYn = 'Y';
            data.isCustYn = 'Y';
            data.isChnlYn = 'Y';
            return data;
        },
        loadComplete : function(obj){
			
        },
        columns:[
            {
                field : 'txnUniqNo', headerText : '거래번호', width:'180', headerTextAlign : 'center', textAlign: 'left', customAttributes : {index : 'lpt.TXN_UNIQ_NO'}
          }
          ,{
              field : 'custTypeCdNm', headerText : '회원유형', textAlign : 'center', width:85, customAttributes : {index : 'lc2.CUST_TYPE_CD'}
          }
          ,{
                field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign: 'left', headerTextAlign : 'center', width:'80', textAlign : 'center', customAttributes : {index : 'cust_Nm'}
          }
          ,{
              field : 'tierNm', headerText : '회원등급', width:'100',  headerTextAlign : 'center', textAlign: 'center',customAttributes : {index : 'lt.TIER_NM'}
          }
          ,{
              field : 'birthDt', headerText : '나이', width:'80',  headerTextAlign : 'center', textAlign: 'center',customAttributes : {index : 'lc2.BIRTH_DATE'}
          }
          ,{
              field : 'genCdNm', headerText : '성별', textAlign : 'center', customAttributes : {index : 'lc2.GEN_CD'},width:80
          }
          ,{
                field : 'hhp', headerText : '휴대전화번호', headerTextAlign : 'center', textAlign: 'center',width:'100',customAttributes : {index : 'lc2.hhp'}
          }
          ,{
                field : 'pntTxnType1Cd', headerText : '유형', headerTextAlign : 'center', textAlign: 'center',width:'80',customAttributes : {index : 'lpt.PNT_TXN_TYPE_1_CD'}
          }
          ,{
                field : 'pntTxnType2Cd', headerText : '상세유형', headerTextAlign : 'center', textAlign: 'left',width:'80',customAttributes : {index : 'lpt.PNT_TXN_TYPE_2_CD'}
          }
          ,{
                field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign: 'left',width:'100',customAttributes : {index : 'lc.CHNL_NM'}
          }
          ,{
                field : 'txnAmt', headerText : '결제금액', headerTextAlign : 'center', textAlign: 'right',width:'100', format : '{0:n0}',customAttributes : {index : 'lpt.TXN_AMT'}
          }
          ,{
                field : 'pntAmt', headerText : '포인트', headerTextAlign : 'center', textAlign: 'right',width:'100', format : '{0:n0}',customAttributes : {index : 'lpt.PNT_AMT'}
          }
          ,{
                field : 'txnDt', headerText : '거래일자',headerTextAlign : 'center',width:'100', textAlign: 'center',customAttributes : {index : 'lpt.TXN_DT'}
          }
          ,{
                field : 'apprDate', headerText : '승인일자',headerTextAlign : 'center', textAlign: 'center',width:'100',customAttributes : {index : 'lpt.APPR_DT'}
          }
          ,{
                field : 'ridMbr', headerText : 'ridMbr', visible: false,
          }
          ,{
                field : 'rid', headerText : 'rid', visible: false,
          }
		],
		 requestGridData : {
	      	  sidx : '3',
	      	  sord : 'desc'
	        },
	        radio: true,
	        gridDataInit: false,
       	tempId : 'ifvGridNotSearchTemplete'
    };
    transactionListDown = $("#transactionListDownload").ifvsfGrid({ ejGridOption : ejGridOption });
}

//고객 상세 이동
function goMbrDetail(id) {
    //개인정보 조회 이력남기기

    $.fn.ifvmPersonalCondLogPageId("PGM_L_050", true);
     $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
     rid : id,
     mbrNo : ''
    }, function(result){
    	returnPage="transactionList";
     if(result.custTypeCd != null){
      if(result.custTypeCd == 'C'){
          //개인정보 조회 이력남기기(법인)
               qtjs.href('<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid=' + result.mbRid+'&checkBackPage='+returnPage);
        } else if(result.custTypeCd == 'I' || result.custTypeCd == 'E'|| result.custTypeCd == 'D'|| result.custTypeCd == 'O'|| result.custTypeCd == 'X') {
          //개인정보 조회 이력남기기(개인/임직원)
               qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid+'&checkBackPage='+returnPage);
        }
     }
    });
}

/**
 * 회원상세 이동 링크 세팅
 */
/* function mbrDetailLink(cellvalue, options, rowObjec){
	var tag = '<a href ="javascript:void(0);" name="mbrDetailNewPage"  onclick = "goCustDetail(\''+rowObjec.ridMbr+'\'   );" style="color:#1266FF; text-decoration:underline;" >' + rowObjec.mbrNo + '</a>';
return tag;
} */

//그리드 텍스트 선택시 상세로 이동  참고 샘플
// function goGridRowMbrLink(cellvalue, options, rowObjec){
// 	if( rowObjec.memDivCd == 'P' ||rowObjec.memDivCd == 'T' ){
// 	    var id = rowObjec.ridMbr;
// 	    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
// 	    var tag=null;
// 	}else{
// 		 var id = rowObjec.ridMbr;
// 	    var url = '<ifvm:url name="mbrGroupDetail"/>' + '?rid=' + id;
// 	    var tag=null;

// 	}

//     if(cellvalue!=null){
//         tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
//     }else{
//     	tag="";
//     }
//     return tag;
// }
// function goGridRowChnlLink(cellvalue, options, rowObjec){
//     var id = rowObjec.ridChnl;
//     var url = '<ifvm:url name="chnlDetail"/>?rid=' + id;
//     var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
//     return tag;
// }
// function goGridRowPgmLink(cellvalue, options, rowObjec){
//     var id = rowObjec.ridPgm;
//     var url = '<ifvm:url name="pgmDetail"/>?rid=' + id;
//     var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
//     return tag;
// }

// function goGridRowProdLink(cellvalue, options, rowObjec){
// 	//상담원 일 경우는 제픔 링크 걸지 않음
// 	var authList = $.ifvmGetAuthInfo().authList;
// 	var isAuth = true;

// 	for(var i = 0 ; i < authList.length ;i++){
// 		if(authList[i].authName == 'E10004' ||authList[i].authName == 'E10005'){
// 			isAuth = false;
// 		}
// 	}

// 	var id = rowObjec.ridProd;
//     var url = '<ifvm:url name="productDetail"/>' + '?rid=' + id;
//     var tag=null;
//     if(cellvalue!=null && isAuth){
//         tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
//     }else{
//     	tag=cellvalue;
//     }
//     return cellvalue;
// }



//공통 조회 조건 목록 설정
function transactionListSearchInit(gridId) {

    $.fn.ifvmSetCommonCondList("transactionSearchList","PGM_L_050",gridId);
//     searchInitialize();
    startDateInitialize();
}

function dateValid(filedName){  //날짜 한달 이상 조회 못하게 validation
	var betweenDay 	=  0
	var dateValid =true;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm') == filedName ){
			if($(this).parents('.SearchCondition').css("display")	!="none"){
				var startDt = $(this).parents('.SearchCondition').find('.changeTypeAreaCode .start_date input').val()
				var endDt = $(this).parents('.SearchCondition').find('.changeTypeAreaCode .end_date input').val();
				var dateArray = startDt.split("-");
				var startObj = new Date(dateArray[0], Number(dateArray[1])-1, dateArray[2]);
				dateArray = endDt.split("-");
				var endObj = new Date(dateArray[0], Number(dateArray[1])-1, dateArray[2]);
				betweenDay  =  (endObj.getTime() - startObj.getTime()) //1000/60/60/24;
			}
		}
	})
	if(betweenDay>30){
		dateValid = false;
	}
	return dateValid;
}

function searchBlankCheck(){
	var blankCheck=false;
	var searchCondSize= $('.changeTypeAreaCode').size();
	var displayRowNum=[];
	var txnCheck=0;
	$($('.row.qt_border.SearchCondition')).each(function(index,item){
		if($("#rows"+index).css("display") !="none"){
			if($("#rows"+index).children(".changeTypeAreaCode").find('.smart-form').size()!=0){ //date
				if($("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_frt.start_date").children(".smart-form").children(".input").children("input").val() !=""
					&& $("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_scd.end_date").children(".smart-form").children(".input").children("input").val() !="" ){
					txnCheck++;
				}
			}
			if($("#rows"+index+ " .searchTextVal option:selected").attr('joinsrcclm')=="TXN_NUM"){
				if($("#rows"+index+ " .changeTypeAreaCode input").val()!=""){
					txnCheck++;
				}
			}

			if($("#rows"+index+ " .searchTextVal option:selected").attr('joinsrcclm')=="CARD_NUM"){
				if($("#rows"+index+ " .changeTypeAreaCode input").val()!=""){
					txnCheck++;
				}
			}
		}
	})  //빈값 처리
	if(txnCheck>0){
		blankCheck=true;
	}
	return blankCheck;
}

//날짜데이터 형식 함수
function getFormatDate(date){
    var year = date.getFullYear();            //yyyy
    var month = (1 + date.getMonth());        //M
    month = month >= 10 ? month : '0'+month;  //month 두자리로 저장
    var day = date.getDate();                 //d
    day = day >= 10 ? day : '0'+day;          //day 두자리로 저장
    
    return  year+'-'+month+'-'+day; 	      //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}
// 거래일자 startDate를 3개월 날짜값으로 초기화해주기
function startDateInitialize(){ 
	var EndDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .end_date input').val());
	
	var month = EndDate.getMonth();
	var year = EndDate.getFullYear();
	var day = EndDate.getDate();
    EndDate.setHours(0, 0, 0, 0);
	
	var dates = new Date();
    dates.setYear(year);
    dates.setMonth(month-2);
    dates.setDate(day);
    dates.setHours(0, 0, 0, 0);
	dates = getFormatDate(dates);
	
	$('.changeTypeAreaCode .start_date input').val(dates)
}

// 조회조건 초기화
function searchInitialize(){
	$(".SearchCondition .searchCondition option[value='LIKE']").remove();
	$(".SearchCondition .searchCondition option[value='NOT']").remove();
	//$(".datepicker").val("");
	startDateInitialize();
}

function searchEventInitialize(){
	$(".SearchCondition .searchCondition option[value='LIKE']").remove();
	$(".SearchCondition .searchCondition option[value='NOT']").remove();
}

// function commSearchEventFn(){
//     $('.itemPlusBtn').live('click', function(){
//     	searchEventInitialize();
//     })
//     $('.itemMinusBtn').live('click', function(){
//     	searchEventInitialize();
//     })
//     $('.searchTextVal').live('change', function(){
//     	searchEventInitialize();
//     });
// }

//공통 조회 호출
function transactionListSearch() {
	// 밸리데이션 플래그
	var searchValidation = true ;

	var startDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .start_date input').val());
	var EndDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .end_date input').val());
	var todayDate = new Date($.ifvGetTodayDate()); // 오늘 날짜 값 객체
    startDate.setHours(0, 0, 0, 0);
    EndDate.setHours(0, 0, 0, 0);
    todayDate.setHours(0, 0, 0, 0);
    
    var year = EndDate.getFullYear();
    var month = EndDate.getMonth();
    var day = EndDate.getDate();
    var d = new Date(); // 3개월 전 기준 날짜 d
    d.setHours(0, 0, 0, 0);
	
    d.setYear(year);
    d.setMonth(month-2);
    d.setDate(day); 
	
	if(startDate < d){ // 시작날짜가 3개월전을 초과 시
        alert('최대 3개월 까지만 조회가 가능합니다.');
		searchValidation = false;
		return;
	}
	
	if(startDate > todayDate){ // 시작날짜가 오늘을 초과 시
		alert('현재일까지만 조회가능합니다.');
		searchValidation = false;
		return;
	}
	
	if(EndDate > todayDate){ // 끝 날짜가 오늘을 초과 시
		alert('현재일까지만 조회가능합니다.');
		searchValidation = false;
		return;
	}
	
  	$.fn.ifvmSubmitSearchCondition("transactionSearchList", function() {
    	if ($.fn.ifvmIsNotEmpty(requestitem)) {
    		transactionList.searchGrid({item : requestitem});
    	} else {
    		alert('최소 1개의 조회조건을 입력해주세요.');
    	}
    });

// 	if(!dateCondUniqueCheck()){
// 		alert('<spring:message code="L02016" />');
// 		/* searchValidation=false; */
// 	}

// 	if(searchValidation){

// 	    $.fn.ifvmSubmitSearchCondition("transactionSearchList", geTtransactionSearch);
// 	    //$("#transactionListGrid").ifvGrid({ ejGridOption : ejGridOptionInit });
// 	}else{
// 		$.fn.ifvmSubmitSearchCondition("transactionSearchList", geTtransactionSearch);
// 		//$("#transactionListGrid").ifvGrid({ ejGridOption : ejGridOptionInit });
// 	}
}

//고객 상세 이동
function transactionDetailDtl() {
 	var url = '<ifvm:url name="transactionDetail"/>';
 	if(rid !=null){
 		url = url + '?rid=' +  escape(rid);
 	}
 	//location.href = url
 	qtjs.href(url);
}


/*포인트 상세 팝업*/

 function pointDtlPop(){

		$("#pointDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="pointDtlPopListNew"/>',
	        contentType: "ajax",
	        title: '<spring:message code="L00477"/>',
	        width: '1000px',
	        close : 'pointDtlPopClose'
	    });
 }


//팝업 닫기
 function pointDtlPopClose() {
 	pointDialog._destroy();
 }


/*
function fnPointDetailPop(){
	 pointDetailPop ={
		        id : "pointDetailPopDiv"
		    };
	 pointDetailPop.popup = function (){
	 	pointDetailPop.pop = $('#'+pointDetailPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pointDetailPop"/>' +"?promoRid="+rid,
		            contentType: "ajax",
		            title: '<spring:message code="L02044" />',
		            width: "1000px"
		        });
		};
		pointDetailPop.beforeClose = function (obj) {
		};
		pointDetailPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 pointDetailPop.popup();
}
*/

function dateCondUniqueCheck(){
	var uniqueCheck = [];
	var uniqueValid=true;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if(  $(this).val()=="DATE" &&   $(this).parents('.SearchCondition').css("display")	!="none"){
			$(this).attr('joinsrcclm');
			uniqueCheck.push($(this).attr('joinsrcclm'));
		}
	})
	for(var i=0; i<uniqueCheck.length; i++){
		for(var j=0; j<i;j++){
			if(uniqueCheck[i]==uniqueCheck[j]){
				uniqueValid=false;
			}
		}
	}
	return uniqueValid;
}

function buttonStatus(){

	 var pntType = null;
	pntType = cardCheckObj.pntTxnType1Cd;
	var pointDtlPopBtnDisabled = false;

	//적일일경우만 포인트상세 버튼을 활성화 시킴. by moon.
	if(pntType != null &&  pntType != '적립'){
		pointDtlPopBtnDisabled = true;
	}


	if( pointDtlPopBtnDisabled == false ){
		$("#pointDtlPopBtn").attr('disabled',false);
	}else{
		$("#pointDtlPopBtn").attr('disabled',true);
	}


	rid!=null&&(cardCheckObj.cardTypeCdCode=='20'&& cardCheckObj.cprtCardCd!='' && cardCheckObj.cprtCardCd !=null)
		? $('#unMaskBtn').attr('disabled',false) : $('#unMaskBtn').attr('disabled',true);
}

function fnUnMak(){
	if ($.fn.ifvmIsNotEmpty(rid)) {
	        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	            rid: rid ,
	            type: 'txn' ,
	            field: 'cardNo'
	        },
	        function(result) {
	        	var rowid = transactionList.getRadioSelectedRowId();
	        	if(result.message!=null){
	        		transactionList.opt.grid.setCell( rowid, 'cardNoDecoding' , result.message );
	        	}
	        });
	}
}
function checkButtnAuth(){
	var isAuth = false;
	var authArr = $.ifvmGetAuthInfo().authList;
	for(var i = 0 ; i < authArr.length ; i++){
		var authObj = authArr[i];
		var authName = authObj.authName;
		if(authName == 'E10010') isAuth = true;
	}
	if(!isAuth){
		$("#unMaskBtn").remove();
	}
}

//마스크해제 
function clearMaskAction() {
	 var v_rid;
	    if ($.fn.ifvmIsNotEmpty(transactionList.opt.gridControl.getSelectedRecords()[0])) {
	    	v_rid = transactionList.opt.gridControl.getSelectedRecords()[0].rid;
	    }
	    else {
	        alert('<spring:message code="M02219"/>');
	    }

	    if ($.fn.ifvmIsNotEmpty(v_rid)) {
	        $.ifvSyncPostJSON('<ifvm:action name="clearMaskTrans"/>', {
	        	rid: v_rid
	        },
	        function(result) {
	        	var gridObj = transactionList.opt.gridControl;
	        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
	        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
	        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
	        });
	    }
	}

//포인트 취소
function cancelPointFn(){
	var mbrNo , apprNo , apprDate , orgnApproNo , orgnApprDate,txnStatCd ,txnUniqNo;
	var validCheck = transactionList.opt.gridControl.getSelectedRecords()[0];
	
	if($.fn.ifvmIsNotEmpty(validCheck)){
		orgnApproNo = validCheck.orgnApprNo;
		orgnApprDate = validCheck.orgnApprDate;
		txnStatCd = validCheck.txnStatCd;
		pntTxnType1code = validCheck.pntTxnType1code;
		pntTxnType2code = validCheck.pntTxnType2code;
		//적립 구매적립,사용 상품구매
		if((pntTxnType1code == '100' && pntTxnType2code == '100') || (pntTxnType1code == '200' && pntTxnType2code == '200')){
			
			apprNo = validCheck.apprNo;
			apprDate = validCheck.apprDateYYYYMMDD;
			mbrNo = validCheck.mbrNo;
			txnUniqNo = validCheck.txnUniqNo;
			
			//포인트 취소 호출API
			$.ifvSyncPostJSON('<ifvm:action name="pointCancelApiRequest"/>', {
				mbrNo : mbrNo,
				apprNo : apprNo,
				apprDate : apprDate,
				txnUniqNo : txnUniqNo,
				pntTxnType1code : pntTxnType1code,
				pntTxnType2code : pntTxnType2code
		    },function(result) {
		    	alert('정상적으로 해당포인트가 취소되었습니다.')
		    },function(result){
		    	alert(result.message);
		    });
		}else{
			alert('거래유형,거래상세유형이 적립,구매적립 또는 사용,상품구매 일경우에만 포인트를 취소하실수있습니다.');		
		}
	}else{
		alert('목록을 선택해주세요');
	}
	
}

function fnPromotionList(){
	if(transactionList.opt.gridControl.getSelectedRecords().length == 0){
		alert('<spring:message code="M00285"/>');
		return;
	}
	//100 : 적립 , 200 : 사용
	txnRid = transactionList.opt.gridControl.getSelectedRecords()[0].rid;

	if(transactionList.opt.gridControl.getSelectedRecords()[0].pntTxnType1code=="200"){ //사용
		$("#pointUseDetailPopDiv").ifvsfPopup({
        	enableModal : true,
        	enableResize : false,
        	contentUrl : '<ifvm:url name="pointUseDetailPopNew"/>',
       	 	contentType : "ajax",
        	title : "<spring:message code="포인트 사용 상세"/>",
        	width : '1000px',
        	close : 'pointUseDetailClosePopDiv',
    	});
		
	}else if(transactionList.opt.gridControl.getSelectedRecords()[0].pntTxnType1code=="100"){  /*포인트 적립일 경우 */
		$("#rgstPromoDetailPopDiv").ifvsfPopup({
        	enableModal : true,
        	enableResize : false,
        	contentUrl : '<ifvm:url name="pointDetailPopNew"/>',
       	 	contentType : "ajax",
        	title : "<spring:message code="포인트 적립 상세"/>",
        	width : '1000px',
        	close : 'rgstPromoDetailClosePopDiv',
    	});
	}
}

function pointUseDetailClosePopDiv(){
	pointUseDetailPopDiv._destroy();
}


function rgstPromoDetailClosePopDiv(){
	rgstPromoDetailPopDiv._destroy();
}

$(document).ready(function() {
	//마스킹해제 권한 체크
	//checkButtnAuth();
    //공통 조회 조건 목록 설정
    transactionListSearchInit();

	//$("#transactionListGrid").ifvGrid({ ejGridOption : ejGridOptionInit });
	geTtransactionSearch();
	getTransactionDown();
	
    //포인트 상세팝업 호출
    $("#pointDtlPopBtn").on("click",function(){
    	if(rid!=null){
    		pointDtlPop();
    	}else{
    		alert('<spring:message code="L01820" />');
    	}
    });
    
    $("#pointListSearchInitBtn").on("click",function(){
    	transactionListSearchInit("transactionList")
    });

   /*  //마스킹 해제
    $("#unMaskBtn").on("click",function(){
    	fnUnMak();
    }) */
    //공통 조회조건 추가 제어 기능
//     commSearchEventFn();

    /* 2018.11.20. hy.jun 작업중 */
    /* $('#transactionSearchList').on('change', function() {
    	var isExist = false;
    	var DupElm = null;
    	$('#transactionSearchList .SearchCondition').each(function(i, e) {
    		if($(e).css('display') === 'block') {
    			isExist = true;
    		}
    	});
    }); */
    
    //$("#excelListBtn").prop('disabled',true);
    
    $("#excelListBtn").on('click', function() {
    	if(transactionList.opt.gridControl.getRows().length == 0) { // 그리드리스트 데이터건이 아무것도 없는 상태면 다운로드버튼눌러도 다운 안되도록 한다
    		return;
    	}
      //$.ifvExcelDn('/loyalty/trans/excelDownTransaction.do','transactionListDownload' );
    	$.ifvDBExcelDnSeo('<ifvm:action name="excelDownTransaction"/>','transactionListDownload',"transactionListExcelDown_OBJ");

    });
    
  //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
  
  //포인트거래취소 클릭시
  $('#cancelPoint').on('click',function(){
	 cancelPointFn(); 
  });
});


</script>


<div class="page-title">
    <h1>
        <spring:message code="포인트 이력" />
        &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>&nbsp;<span></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" text="M00135"  id="pointListSearchBtn" btnFunc="transactionListSearch" btnType="search" objCode="transactionListSearch_OBJ"/>
            <ifvm:inputNew type="button" text="M00278"  id="pointListSearchInitBtn" objCode="transactionListInit_OBJ"/>
        </div>
    </div>
 
    <div class="well form-horizontal well_bt5" id="transactionSearchList">
    </div>
</div>

<div>  
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L00033" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<!-- <button class="btn btn-sm" id="cancelPoint">
             	포인트취소
         	</button> -->
         	<ifvm:inputNew type="button" btnType="search" text="거래 상세" id="txnDtlListBtn"  btnFunc="fnPromotionList" objCode="transactionListDetail_OBJ"/>
         	  <button class="btn btn-sm" id="excelListBtn" objCode="transactionListExcelDown_OBJ">
             	<spring:message code="M01218" /> <!-- 다운로드 -->
         	</button>
         	<button class="btn btn-sm" id="clearMaskBtn" objCode="transactionListMaskClear_OBJ">
             	<spring:message code="L00326" /> <!-- 마스킹해제 -->
         	</button>
<%--         	<ifvm:inputNew type="button"   text="L00326"  id="unMaskBtn" btnFunc="fnUnMak"	 disabled="true" objCode="LOY_MAS_014"/> --%>
<%--         	<ifvm:inputNew type="button" btnType="search"  text="L00588"  id="pointDtlPopBtn" disabled="true" /> --%>
        </div>
    </div>
    <div id="transactionListGrid" class="white_bg grid_bd0"></div>
	<div id="transactionListDownload" hidden="true" ></div>
</div>

 <div id="pointDialog" class="popup_container"></div>
 <div id="rgstPromoDetailPopDiv" class="popup_container"></div>
<div id="pointUseDetailPopDiv" class="popup_container"></div>