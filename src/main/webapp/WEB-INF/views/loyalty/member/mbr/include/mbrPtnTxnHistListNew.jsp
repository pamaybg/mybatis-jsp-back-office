<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var popSelectlId;           //팝업에서 선택한 값이 세팅되는 input ID
var manualDtlValidation;
var pointTxnList;
var mbrTxn_rid;
var txnCardMbrType = null;
var txnCardCprtCardCd = null;
var pntTxnDateType = 'A';   // A 최신  B 과거
var promoCnt;
var pointTxnDetail;

//포인트 거래리스트
function getPointTxnListListSearch(searchType){
  var ejGridOption = {
        serializeGridData : function( data ){

            if(typeof(gMbrDetail) != "undefined"){
                data.rid = gMbrDetail.data.rid;
            }else if(typeof(gGroupDetail) != "undefined"){
                data.rid = gGroupDetail.data.rid
            }
            
            data.searchType = searchType;
            data.pntTxnDateType = pntTxnDateType;
            if(searchType == 'DATE'){
            	data.startDt = $('#startDt').val().replaceAll('-','');
          		data.endDt = $('#endDt').val().replaceAll('-','');
          		acrlUseSetting('DATE');
            }else{
            	acrlUseSetting('A');
            }
      		
            //BAT 거래기간 조회조건추가
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }    
            
            return data;
        },
        rowSelected : function (args) {
            mbrTxn_rid = args.data.rid;
            txnCardMbrType = args.data.mbrType;
            txnCardCprtCardCd = args.data.cprtCardCd;
            promoCnt = args.data.promoCnt;
            pointTxnDetail = args.data.pntTxnType2Cd;
            chnlNo = args.data.chnlNo;
            //포인트 지급사유
            if(pointTxnDetail == 'CS' || pointTxnDetail == '관리자차감' || pointTxnDetail == '이벤트참여'){
            	$('#csDiv').prop('hidden',false);
        		$("#csDesc").val(pointTxnList.opt.gridControl.getSelectedRecords()[0].acrlDesc);
        	}else{
        		$('#csDiv').prop('hidden',true);
        	}
            
            fnButtonStatus();
        },
        loadComplete : function(obj){
            $('#cardNoUnmakingButton').attr('disabled',true);
            $('#txnDtlListBtn').attr('disabled',true);
            $('#txnItemListBtn').attr('disabled',true);
            if(typeof(gMbrDetail) != "undefined"){
                if(gMbrDetail.data.mbrStatCd == "20"){
                    $(".dropHidBtn").prop("disabled",true);
                }
            }
            window.top.setParentIframeHeight();
        },
        dataUrl : '<ifvm:action name="getMbrPtnTxnHistList"/>',
        columns:[
               {
                   field : 'txnDt', headerText : '<spring:message code="L00604"/>', headerTextAlign : 'center', textAlign: 'center',
                   customAttributes : {
                       index : 'lpt.TXN_DT' }//거래일시
               },
                  {
                      field : 'dtlApprNo', headerText : '<spring:message code="L01663"/>', headerTextAlign : 'center', textAlign: 'center',
                      customAttributes : {
                          index : 'lpt.APPR_NO' } //승인번호
                  },{
                      field : 'txnStat', headerText : '<spring:message code="L00351"/>', headerTextAlign : 'center', textAlign: 'center',
                      customAttributes : {
                          index : 'lpt.TXN_STAT_CD' } //거래상태
                  },{
                      field : 'apprDate', headerText : '<spring:message code="L00555"/>', headerTextAlign : 'center', textAlign: 'center',
                      customAttributes : {
                          index : 'lpt.APPR_DATE' } //승인일시
                  },{
                      field : 'pntTxnType1Cd', headerText : '<spring:message code="L00356"/>', headerTextAlign : 'center', textAlign: 'center',
                      customAttributes : {
                          index : 'lpt.PNT_TXN_TYPE_1_CD' } //거래 유형
                  },{
                      field : 'pntTxnType2Cd', headerText : '<spring:message code="L00556"/>', headerTextAlign : 'center', textAlign: 'center',
                      customAttributes : {
                          index : 'lpt.PNT_TXN_TYPE_2_CD' } //거래 상세 유형
                  },{
//                       field : 'pntTxnType3Cd', headerText : '지급계정 소분류', headerTextAlign : 'center',
//                       customAttributes : {
//                           index : 'c11.MARK_NAME' } //소분류
//                   },{
//                       field : 'pntTxnType4Cd', headerText : '지급계정 세분류', headerTextAlign : 'center',
//                       customAttributes : {
//                           index : 'c12.MARK_NAME' } //세분류
//                   },{
                      field : 'txnTypeDtlDesc', headerText : '거래유형 상세', headerTextAlign : 'center', textAlign: 'center',
                      customAttributes : {
                          index : 'lpt.txn_type_dtl_desc' } //거래유형 상세 
                  },
//                {
//                    field : 'cardNoDecoding', headerText : '<spring:message code="L00414"/>', headerTextAlign : 'center',
//                    customAttributes : {
//                        index : 'lpt.CARD_NUM' } // 카드번호
//                },
                  {
                      field : 'pntAmt', headerText : '<spring:message code="L00582"/>', headerTextAlign : 'center',textAlign: 'right', format : '{0:n0}',
                      customAttributes : {
                          index : 'lpt.PNT_AMT' } //포인트
                  },{
//                       field : 'validDate', headerText : '포인트 유효기간', headerTextAlign : 'center',textAlign: 'right',
//                       customAttributes : {
//                           index : 'lpa.VALID_START_DATE' } //포인트 유효기간
//                   },{
                      field : 'txnAmt', headerText : '<spring:message code="L00355"/>', headerTextAlign : 'center',textAlign: 'right', format : '{0:n0}',
                      customAttributes : {
                          index : 'lpt.TXN_AMT' } //거래금액
                  },{
                      field : 'chnlNm', headerText : '<spring:message code="L02517"/>', headerTextAlign : 'center',textAlign: 'center',
                      customAttributes : {
                          index : 'lc.CHNL_NM' } //등록채널
                  },
//                {
//                    field : 'chnlNo', headerText : '<spring:message code="L00222"/>', headerTextAlign : 'center',
//                    customAttributes : {
//                        index : 'lc.CHNL_NO' } //채널코드
//                },{
//                    field : 'cardKndNm', headerText : '<spring:message code="L00918"/>', headerTextAlign : 'center',
//                    customAttributes : {
//                        index : 'cc4.mark_name' } //카드종류
               /* },{
                   field : 'txnUniqNo', headerText : '거래 고유번호', headerTextAlign : 'center', textAlign: 'center', width:'15%',
                   customAttributes : {
                       index : 'lpt.TXN_UNIQ_NO' } //거래번호
               },{
                   field : 'rcptNo', headerText : '주문(영수증) 번호', headerTextAlign : 'center', textAlign: 'center', width:'15%',
                   customAttributes : {
                       index : 'lpt.rcpt_no' } //영수증 번호 
               }, */
                  {
                      field : 'rid', headerText : 'rid', headerTextAlign : '',visible: false,
                      customAttributes : {
                          index : 'lpt.rid' }
                  },{
                      field : 'ridChnl', headerText : 'ridChnl', headerTextAlign : '',visible: false,
                      customAttributes : {
                          index : 'lc.rid' }
                  },{
                      field : 'ridMbr', headerText : 'ridMbr', headerTextAlign : '',visible: false,
                      customAttributes : {
                          index : 'lm.rid' }
                  },{
                      field : 'ridMbrCard', headerText : 'ridMbrCard', headerTextAlign : '',visible: false,
                      customAttributes : {
                          index : 'lmc.rid' }
                  },{
                      field : 'mbrType', headerText : 'mbrType', headerTextAlign : '',visible: false,
                      customAttributes : {
                          index : 'lck.mbr_type' }
                  },{
                      field : 'cprtCardCd', headerText : 'cprtCardCd', headerTextAlign : '',visible: false,
                      customAttributes : {
                          index : 'lmc.cprt_card_cd'
                        }
                  },{
                      field : 'acrlDesc', headerText : 'acrlDesc', headerTextAlign : '',visible: false,
                      customAttributes : {
                          index : 'liv.voc_desc'
                        }
                  },{
    	      		  field : 'txnStatCd', headerText : 'txnStatCd',visible: false,
    	      		  customAttributes : {
    	      			  index : 'lpt.txnStatCd' }/* */
    	      	  },{
    	      		  field : 'apprDateYYYYMMDD', headerText : 'apprDateYYYYMMDD',visible: false,
    	      		  customAttributes : {
    	      			  index : 'lpt.APPR_DATE' }/* */
    	      	  },{
    	      		  field : 'pntTxnType1code', headerText : 'pntTxnType1code',visible: false,
    	      		  customAttributes : {
    	      			  index : 'lpt.PNT_TXN_TYPE_1_CD' }/* */
    	      	  },{
    	      		  field : 'pntTxnType2code', headerText : 'pntTxnType2code',visible: false,
    	      		  customAttributes : {
    	      			  index : 'lpt.PNT_TXN_TYPE_2_CD' }/* */
    	      	  },{
	      		      field : 'orgnApprNo', headerText : '<spring:message code="L00384"/>', visible: false,
	      		      customAttributes : {
	      			     index : 'lpt.orgn_appr_no' }/*원거래승인번호 */
	      		  },{
		      		  field : 'orgnApprDate', headerText : '<spring:message code="L00385"/>', visible: false,
		      		  customAttributes : {
		      			  index : 'lpt.orgn_appr_date' }/*원거래승인일시 */
		      	  },{
                      field : 'chnlNo', headerText : '', visible: false,
                      customAttributes : {
                          index : 'lc.CHNL_NO' } //채널코드
                  },
            ],
            requestGridData : {
                  nd   : new Date().getTime(),
                  rows : 10,
                  sidx : 'apprDate desc ,LPT.ROWID',
                  sord : 'desc',
                  _search : false 
              },
              rowList : [10,25,50,100],
              radio: true,
              tempId : 'ifvGridSimplePageTemplete'
        };

  pointTxnList = $("#pointTxnListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}
//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
        tag="";
    }
    return tag;
}
function saveCardInfo(){
    var submitData=$("#unRgstPointTxnListForm").getSubmitData();
    submitData.cardRid=rid;
    submitData.popProdNm=$("#popProdNm").val();
     $.ifvSyncPostJSON('<ifvm:action name="updateCardInfo"/>',
             submitData
         , function(result) {
         alert("<spring:message code='C00094'/>");
                $.ifvReload();
            },function(result){
            });
}

/* VOC 생성  */

function fnMbrPntVocRequest(){
    mbrPntVocPop = {
        id : "mbrPntVocRequestPopDiv"
    };
    mbrPntVocPop.popup = function () {
        mbrPntVocPop.pop = $('#'+mbrPntVocPop.id).ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: '<ifvm:url name="mbrPntVocRequest"/>?mbrNo='+gMbrDetail.data.mbrNo ,
                    contentType: "ajax",
                    title: '<spring:message code="L02018"/>',
                    width: '1200px'
        });
    };
    mbrPntVocPop.beforeClose = function (obj) {
    };
    mbrPntVocPop.close = function (obj) {
        this.beforeClose(obj);
        mbrPntVocRequestPopDiv._destroy();
    };
    mbrPntVocPop.popup();
}

function allSearch() {
    changePointTxnListListSearch('ALL');
}
function acrlSearch() {
    changePointTxnListListSearch('ACRL');
    $('#startDt').val('');
    $('#endDt').val('');
    acrlUseSetting('ACRL');
}
function rdmSearch() {
    changePointTxnListListSearch('RDM');
    $('#startDt').val('');
    $('#endDt').val('');
    acrlUseSetting('RDM');
}
function partnerSearch() {
    changePointTxnListListSearch('PARTNER');
}
function butaneSearch() {
    changePointTxnListListSearch('BUTANE');
}

function changePointTxnListListSearch(type) {
    var data = {};
    if(typeof(gMbrDetail) != "undefined"){
        data.rid = gMbrDetail.data.rid;
    } else if (typeof(gGroupDetail) != "undefined"){
        data.rid = gGroupDetail.data.rid
    }

    data.searchType = type;
    data.pntTxnDateType = pntTxnDateType;
    data.page = 1;

    pointTxnList.searchGrid(data);
}

function oldSearch(){



    pointTxnPop ={
            id : "txnSearchPopupContainer",
            rid : (typeof(gMbrDetail) != "undefined")? gMbrDetail.data.rid : gGroupDetail.data.rid
        };
    pointTxnPop.popup = function (){
        pointTxnPop.pop = $('#'+pointTxnPop.id).ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="transactionListPop"/>?defaultMbrRid='+ pointTxnPop.rid +'&defaultArchive=Y',
                contentType: "ajax",
                title: '<spring:message code="L02019"/>',
                width: '1000px',
                maxHeight : null
            });
    };
    pointTxnPop.beforeClose = function (obj) {
    };
    pointTxnPop.close = function (obj) {
            this.beforeClose(obj);
            txnSearchPopupContainer._destroy();
     };
     pointTxnPop.popup();
}
function recentSearch(){
    pointTxnPop ={
            id : "txnSearchPopupContainer",
            rid : (typeof(gMbrDetail) != "undefined")? gMbrDetail.data.rid : gGroupDetail.data.rid
        };
    pointTxnPop.popup = function (){
        pointTxnPop.pop = $('#'+pointTxnPop.id).ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="transactionListPop"/>?defaultMbrRid='+ pointTxnPop.rid,
                contentType: "ajax",
                title: '<spring:message code="L02020"/>',
                width: '1000px',
                maxHeight : null
            });
    };
    pointTxnPop.beforeClose = function (obj) {
    };
    pointTxnPop.close = function (obj) {
            this.beforeClose(obj);
            txnSearchPopupContainer._destroy();
     };
     pointTxnPop.popup();
}

function searchBtnStatus(){
    if ( pntTxnDateType== 'A'){
         $("#recentSearchButton").addClass('hidden');
         $("#oldSearchButton").removeClass('hidden');
       }else{
         $("#recentSearchButton").removeClass('hidden');
         $("#oldSearchButton").addClass('hidden');
       }
}

function fnCardNoUnmasking(){


    if ($.fn.ifvmIsNotEmpty(mbrTxn_rid)) {
            $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
                rid: mbrTxn_rid ,
                type: 'txn' ,
                field: 'cardNo'

            },
            function(result) {

                if(result.message!=null){
                    var rowid = pointTxnList.getRadioSelectedRowId();
                    pointTxnList.opt.grid.setCell( rowid, 'cardNoDecoding' , result.message );
                }


            });

    }

}


function fnPntItemList(){
     pointDetailPop ={
                id : "txnHistDetailPopupDialog"
            };
     pointDetailPop.popup = function (){
        pointDetailPop.pop = $('#'+pointDetailPop.id).ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: '<ifvm:url name="pntTxnItemListPop"/>?rid='+ mbrTxn_rid ,
                    contentType: "ajax",
                    title: '<spring:message code="L02021"/>',
                    width: '800px'
                });
        };
        pointDetailPop.beforeClose = function (obj) {
        };
        pointDetailPop.close = function (obj) {
                this.beforeClose(obj);
                txnHistDetailPopupDialog._destroy();
         };
         pointDetailPop.popup();
}

function fnButtonStatus(){
    if (mbrTxn_rid != null && (txnCardMbrType == '20' && txnCardCprtCardCd != '' )) {
        $('#cardNoUnmakingButton').attr('disabled',false)
    }
    else $('#cardNoUnmakingButton').attr('disabled',true);
    if (promoCnt == 0 || promoCnt == null)  $("#txnDtlListBtn").attr('disabled',true);
    else 									$("#txnDtlListBtn").attr('disabled',false);
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
        $("#cardNoUnmakingButton").remove();
    }
}

//포인트거래 상세 연결 formatter
function goGridRowTrDetail(cellvalue, options, rowObjec){
    var trRid = rowObjec.rid;
    var url = '<ifvm:url name="transactionDetail"/>' + '?rid=' + trRid;
    var tag = null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
        tag="";
    }
    return tag;
}

//가맹점 상세 연결 formatter
function goGridRowChnlDetail(cellvalue, options, rowObjec){
    var tRidChnl = rowObjec.ridChnl;
    var url = '<ifvm:url name="channelDetail"/>' + '?rid=' + tRidChnl;
    var tag = null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
        tag="";
    }
    return tag;
}

//달력셋팅
function setCalendar() {
	var startDate = $('#startDt');
	var endDate = $('#endDt');

	//설정
	startDate.ifvDateChecker({
	});
	endDate.ifvDateChecker({
	});
}

/* //공통 조회 조건 목록 설정
function searchPntTxnAListSearch() {
    $.fn.ifvmSetCommonCondList("mbrPtnTxnHistList","LOY_PNT_TAB","pointTxnListGrid");
   // $(".datepicker").val(""); //검색초기화
}

//공통 조회 호출
function searchPntTxnAListSearchInit() {
    $.fn.ifvmSubmitSearchCondition("mbrPtnTxnHistList", getPointTxnListListSearch('A'));
}  */

function searchPntTxnValidcheck(){
	var startDt = $('#startDt').val();
	var endDt = $('#endDt').val();
    if ($.fn.ifvmIsNotEmpty(startDt) && $.fn.ifvmIsNotEmpty(endDt)) {
    	getPointTxnListListSearch('DATE');
   	} else {
   		alert('거래기간을 모두 입력해주세요.');
   	}
}

$(document).ready(function(){
    $.fn.ifvmSetSelectOptionCommCode("searchType", "POINT_SEARCH_TYPE", null, null, false);
	
    setCalendar();
    
    //searchPntTxnAListSearch();
    
    getPointTxnListListSearch('A'); 
    
    acrlUseSetting('A');
    
    //searchPntTxnAListSearchInit();
    
    $('#searchButton').on('click',function(){
    	searchPntTxnValidcheck();
    });
    
    $('#csDiv').prop('hidden',true);
    
    //stampDetailDataLoad(testViewList_rid);
    $.ifvmLnbSetting('testViewList');

    $("#searchType").on('change', function(){
        var searchType = $("#searchType").val();
        changePointTxnListListSearch(searchType);
    });

    // 단체일경우 voc 버튼 히든 처리
    if ( $('#mbrTypeCd').val() == '20'){
         $("#vocCreateButton").addClass('hidden');
    }

    //checkButtnAuth();
    window.top.setParentIframeHeight();
    
    $('#acrl').prop('disabled',true);
	$('#use').prop('disabled',true);
});

function fnPromotionList(){
    pointDetailPop = {
        popup: function () {
            $('#rgstPromoDetailPopDiv').ifvsfPopup({
                enableModal: true,
                enableResize: false,
                contentUrl: '<ifvm:url name="pointDetailPopNew"/>?promoRid='+ mbrTxn_rid ,
                contentType: "ajax",
                title: "<spring:message code='L00599'/>",
                width: '1000px'
            });
        },
        beforeClose: function (obj) {
        },
        close: function (obj) {
            this.beforeClose(obj);
            rgstPromoDetailPopDiv._destroy();
        }
    }
    pointDetailPop.popup();
}

//포인트 팝업 권한부여
function validAuthCheck(){
	var authCheck = true;
	$.ifvSyncPostJSON('<ifvm:action name="validAuthCheck"/>', {
    },function(result){
    	authCheck = true;
    	fnVocPointOpen();
    },function(result){
    	authCheck = false;
		alert('권한이없습니다.');
    });
	return authCheck;
}

/**
 * VOC 포인트 팝업 호출
 */
function fnVocPointOpen() {
    vocPopup = {
        open: function() {
            $("#vocPopupContainer").ifvsfPopup({
                enableModal : true,
                enableResize: false,
                contentUrl: '<ifvm:url name="mbrVocPop"/>',
                contentType: "ajax",
                title: 'CS포인트',
                width: 700
                //close : vocPopup.close
            });
            vocPopupContainer = $("#vocPopupContainer").data("ejDialog");
        },
        close: function() {
            vocPopupContainer._destroy();
        }
    }

    vocPopup.open();
}

//포인트 취소
function cancelPointFn(){
	var mbrNo , apprNo , apprDate , orgnApproNo , orgnApprDate,txnStatCd ,txnUniqNo ,chnlNo;
	var validCheck = pointTxnList.opt.gridControl.getSelectedRecords()[0];
		if($.fn.ifvmIsNotEmpty(validCheck)){
			orgnApproNo = validCheck.orgnApprNo;
			orgnApprDate = validCheck.orgnApprDate;
			txnStatCd = validCheck.txnStatCd;
			pntTxnType1code = validCheck.pntTxnType1code;
			pntTxnType2code = validCheck.pntTxnType2code;
			chnlNo = validCheck.chnlNo;
			var result = confirm('포인트만 취소됩니다.\n정말로 취소하시겠습니까?');
			if(result){
				//원거래 승인번호 X,원거래 승인일자 X,거래상태 null , 적립 구매적립,사용 상품구매
				if((pntTxnType1code == '100' && pntTxnType2code == '100') || (pntTxnType1code == '200' && pntTxnType2code == '200')){
					mbrNo = gMbrDetail.data.mbrNo;
					apprNo = validCheck.dtlApprNo;
					apprDate = validCheck.apprDateYYYYMMDD;
					txnUniqNo = validCheck.txnUniqNo;
					
					//포인트 취소 호출API
					$.ifvSyncPostJSON('<ifvm:action name="pointCancelApiRequest"/>', {
						mbrNo : mbrNo,
						apprNo : apprNo,
						apprDate : apprDate,
						txnUniqNo : txnUniqNo,
						pntTxnType1code : pntTxnType1code,
						pntTxnType2code : pntTxnType2code,
						chnlNo : chnlNo
				    },function(result) {
				    	var searchType = $("#searchType").val();
				        changePointTxnListListSearch(searchType);
				    	alert('정상적으로 해당포인트가 취소되었습니다.');
				    	gMbrDetail.loadData();
				    },function(result){
				    	alert(result.message);
				    });
				}else{
					alert('거래유형,거래상세유형이 적립,구매적립 또는 사용,상품구매 일경우에만 포인트를 취소하실수있습니다.');		
				}
			}
		}else{
			alert('목록을 선택해주세요');
		}
}

//적립 사용 셋팅
function acrlUseSetting(type) {
	var acrl;
	var use;
	
	if(type == 'A'){
		//포인트 적립
		totAcrlPoint(type);
		//포인트 사용
		totRdmPoint(type);
	}else if (type == 'ACRL'){
		totAcrlPoint(type)
	}else if (type == 'RDM'){
		totRdmPoint(type)
	}else if (type == 'DATE'){
		totAcrlPoint(type);
		totRdmPoint(type);
	}
}

//포인트 적립
function totAcrlPoint(type){
	$.ifvSyncPostJSON('<ifvm:action name="getTotAcrlPoint"/>',{
		rid : gMbrDetail.data.rid,
		searchType : type,
		startDt : $('#startDt').val().replaceAll('-',''),
		endDt : $('#endDt').val().replaceAll('-','')
	},function(result){
		if(result.acrlAmt == null){
			$('#acrl').val(0);
		}else{
			$('#acrl').val(result.acrlAmt);			
		}
		if(type == 'ACRL'){
			$('#use').val(0);			
		}
	});
}

//포인트 사용
function totRdmPoint(type){
	$.ifvSyncPostJSON('<ifvm:action name="getTotRdmPoint"/>',{
		rid : gMbrDetail.data.rid,
		searchType : type ,
		startDt : $('#startDt').val().replaceAll('-',''),
		endDt : $('#endDt').val().replaceAll('-','')
	},function(result){
		if(result.rdmAmt == null){
			$('#use').val(0);
		}else{
			$('#use').val(result.rdmAmt);
		}
		if(type == 'RDM'){
			$('#acrl').val(0);			
		}
	});
}

//포인트 소멸이력
function dormancyPntList() {
	dormancyPntListPop = {
		id : "dormancyPntListPop",
		pop : function() {
			$("#" + this.id).ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : '<ifvm:url name="mbrDormancyPntListPop"/>',
				contentType : "ajax",
				title : '소멸이력', // 가용 포인트
				width : '1000px'
			});
		},
		beforeClose : function(obj) {

		},
		close : function(obj) {
			if (obj) {
				this.beforeClose(obj)
			}
			var _popObj = eval(this.id)
			_popObj._destroy();
		}
	};
	
	dormancyPntListPop.pop();
	
}

function pointExcelList() {
	$.ifvExcelDn('/loyalty/member/mbr/excelMbrPointTxnList.do',"pointTxnListGrid");
}

//스탬프 적립 처리
/* function acrlStmp() {
	var _selectedRow = pointTxnList.opt.gridControl.getSelectedRecords()[0];
	if($.fn.ifvmIsNotEmpty(_selectedRow)) {
	    $.ifvSyncPostJSON('<ifvm:action name="acrlStmp"/>', {
			rid : _selectedRow.rid
	    }, function(result) {
			alert('스탬프 적립처리 되었습니다.');
		},function(result){
			if(result.message === '500') {
				alert('[에러코드:500] 존재하지 않는 거래입니다. 관리자에게 문의해주세요.');
			} else if(result.message === '501') {
				alert('[에러코드:501] 이미 적립처리된 거래건입니다.');
			} else if(result.message === '502') {
				alert('[에러코드:502] 취소된 거래건은 적립처리할 수 없습니다.');
			} else if(result.message === '503') {
				alert('[에러코드:503] 존재하지 않는 스탬프 거래입니다. 관리자에게 문의해주세요.');
			} else if(result.message === '504') {
				alert('[에러코드:504] 스탬프정보가 존재하지 않습니다. 관리자에게 문의해주세요.');
			} else if(result.message === '505') {
				alert('[에러코드:505] 스탬프 혜택정보가 올바르지 않습니다. 관리자에게 문의해주세요.');
			} else if(result.message === '506') {
				alert('[에러코드:506] 포인트 금액이 0원 이하인 거래건은 스탬프 적립처리 되지 않습니다.');
			} else if(result.message === '507') {
				alert('[에러코드:507] 해당 회원이 참여 중인 스탬프가 없습니다.');
			} else if(result.message === '508') {
				alert('[에러코드:508] 행사 중인 스탬프가 존재하지 않습니다.');
			} else if(result.message === '509') {
				alert('[에러코드:509] 스탬프 구간정보가 올바르지 않습니다. 관리자에게 문의해주세요.');
			} else if(result.message === '999') {
				alert('거래유형/상세유형이 "적립/구매" 이거나 "취소/구매취소"인 거래건만 적립처리 할 수 있습니다.');
			} else {
				if(result.errorType != 0) {
					$.errorChecker(result);
				} else {
					alert('알 수 없는 에러가 발생하였습니다. 관리자에게 문의해주세요.');
				}
			}
		});
	} else {
		alert('<spring:message code="L00066"/>');
	}
} */

</script>

<div class="page_btn_area">
    <div class="col-xs-2"></div>
    <div class="col-xs-10 searchbtn_r">
    	<!-- 일반조회 -->
        <ifvm:inputNew type="button" btnType="search" text="조회" nuc="true" id="searchButton" objCode="searchButton_obj"/>
    	<!-- 적립조회 -->
        <ifvm:inputNew type="button" btnType="search" text="L00954" id="acrlSearchButton"  btnFunc="acrlSearch" objCode="acrlSearchButton_obj"/>
        <!-- 사용조회 -->
        <ifvm:inputNew type="button" btnType="search" text="L00956" id="rdmSearchButton"  btnFunc="rdmSearch" objCode="rdmSearchButton_obj"/>
        <!-- VOC포인트 -->
        <ifvm:inputNew type="button" text="CS포인트" nuc="true" id="vocPointButton" btnFunc="validAuthCheck" className="dropHidBtn" objCode="vocPointButton_obj"/>
        <!-- 스탬프적립 -->
        <%-- <ifvm:inputNew type="button" text="스탬프적립" nuc="true" id="acrlStmpButton" btnFunc="acrlStmp" className="dropHidBtn"/> --%>
        <!-- 포인트상세 -->
        <ifvm:inputNew type="button" btnType="search" text="L00588" id="txnDtlListBtn"  btnFunc="fnPromotionList" objCode="txnDtlListBtn_obj"/>
        <!-- 소멸이력 -->
        <ifvm:inputNew type="button" text="소멸이력"  btnFunc="dormancyPntList" nuc="true" objCode="dormancyPntList_obj"/>
        <!-- 적립취소 -->
        <!-- bat 임시주석 포인트취소 -->
    	<ifvm:inputNew type="button" text="포인트취소"  nuc="true" id="cancelPoint"  btnFunc="cancelPointFn" objCode="cancelPoint_obj"/>
    	<!-- 엑셀다운로드 -->
    	<ifvm:inputNew type="button" text="엑셀다운로드"  nuc="true" id="pointExcelButton" btnFunc="pointExcelList" objCode="pointExcelButton_obj"/>
    </div>
</div>
<div class ="row white_bg">
	<div class = "col-xs-9 control_content">
		<!-- <div class="form-horizontal well_bt5" id="mbrPtnTxnHistList"></div> -->
        <label class="col-xs-1 control-label">거래기간</label>
        <div class="col-xs-4 control_content">
        	<ifvm:inputNew type="dateTerm" startDto="startDt" endDto="endDt" startId="startDt" endId="endDt" nuc="true" /> 
      	</div>
	</div>
	<div class="col-xs-3 control_content" style="text-align:right;">
		<span>적립</span>
		<input type="number" id="acrl" style="width: 80px;" value="0"/>
		<span style="padding-left: 10px;">사용</span>
		<input type="number" id="use"  style="width: 80px" value="0"/>
	</div>
</div>
<div id="pointTxnListGrid" class="white_bg grid_bd0"></div>
<div class ="row qt_border" id="csDiv">
	<label class="col-xs-1 control-label">CS사유</label>
	<div class="col-xs-6">
		<ifvm:input type="textarea" id="csDesc" disabled="true" rows="5"/>
	</div>
</div>
<div id="testViewListPopupContainer" class="popup_container"></div><!-- 팝업 -->
<div id="txnSearchPopupContainer" class="popup_container"></div><!-- 팝업 -->
<div id="rgstPromoDetailPopDiv" class="popup_container"></div>
<div id="mbrPntVocRequestPopDiv" class="popup_container"></div><!-- 팝업 -->
<div id="txnHistDetailPopupDialog" class="popup_container"></div>
<div id="vocPopupContainer" class="popup_container"></div>
<div id="dormancyPntListPop" class="popup_container"></div>
