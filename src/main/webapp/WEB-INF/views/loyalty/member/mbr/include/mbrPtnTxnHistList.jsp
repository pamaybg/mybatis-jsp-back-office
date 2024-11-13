<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script>



var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID
var manualDtlValidation;
var pointTxnList;
var mbrTxn_rid;
var txnCardMbrType = null;
var txnCardCprtCardCd= null;
var pntTxnDateType = 'A'; // A 최신  B 과거
var promoCnt;



//포인트 거래리스트
function getPointTxnListListSearch(searchType){
  var jqGridOption = {
  		serializeGridData : function( data ){

  			if(typeof(gMbrDetail) != "undefined"){
  				data.rid = gMbrDetail.data.rid;
  			}else if(typeof(gGroupDetail) != "undefined"){
  				data.rid = gGroupDetail.data.rid
  			}

	       		data.searchType = searchType;
				data.pntTxnDateType = pntTxnDateType;
	            return data;
	        },

	        onSelectRow : function (data) {

	        	mbrTxn_rid = data.rid;
	        	txnCardMbrType = data.mbrType;
	        	txnCardCprtCardCd = data.cprtCardCd;
	        	promoCnt = data.promoCnt;
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
	        url : '<ifvm:action name="getMbrPtnTxnHistList"/>',
	        colNames:[
	                   '<spring:message code="L00554" />',  /*거래번호 */
	                   '<spring:message code="L00604" />',  /*거래일시 */
	                   '<spring:message code="L00555" />',  /*승인일시 */
	                   '<spring:message code="L00556" />',  /*거래 상세유형*/

	                   '<spring:message code="L00414" />', /*카드번호 */
	                   /*'<spring:message code="L00919" />',*/ /*제휴사 */ 
	                   '<spring:message code="L00582" />', /*발생포인트*/
	                   /*'<spring:message code="L00583" />',*/ /*사용포인트 */
	                   /*'<spring:message code="L00584" />',*/ /*선물포인트 */
	                   /*'<spring:message code="L00971" />',*/ /*프로모션 포인트 */
	                   /*'<spring:message code="L00596" />',*/ /*거래후가용포인트 */
	                   /*'<spring:message code="L00567" />',*/ /*제품명 */
	                   '<spring:message code="L00355" />', /*거래금액 */
	                   '<spring:message code="L00565" />', /*가맹점명 */
	                   '<spring:message code="L00564" />', /*가맹점코드 */
	                   '<spring:message code="L00918" />', /*카드종류 */


	                   'rid',
	                   'ridChnl',
	                   'ridMbr',
	                   'ridMbrCard',
	                   'mbrType',
	                   'cprtCardCd'
	                 ],
	        colModel:[
	             { name:'txnUniqNo',   index:'lpt.TXN_NUM',  resizable : true, align:'center',    width:'180px',sortable:false , formatter:goGridRowTrDetail },
	             { name:'txnDt',   index:'lpt.TXN_DT',  resizable : true, align:'center',  width:'135px' ,formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"},sortable:false  },
	             { name:'apprDate',   index:'lpt.APPR_DATE',  resizable : true, align:'center',  width:'135px' ,formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"},sortable:false  },
	             { name:'pntTxnType2Cd',   index:'lpt.PNT_TXN_TYPE_2_CD',  resizable : true, align:'center',     width:'100px' ,sortable:false },

	             { name:'cardNoDecoding',   index:'lpt.CARD_NUM',  resizable : true, align:'center',    width:'150px' ,sortable:false  },
	             /*{ name:'cprtCard',   index:'d.mark_name',  resizable : true, align:'center',    width:'100px' ,sortable:false }, */
	             { name:'pntAmt',   index:'lpt.PNT_AMT',  resizable : true, align:'right',    width:'80px',formatter:'integer' ,sortable:false },
	             /*{ name:'usePnt',   index:'lpt.USE_PNT',  resizable : true, align:'right',    width:'80px',formatter:'integer',sortable:false  },*/
	             /*{ name:'giftPnt',   index:'lpt.GIFT_PNT',  resizable : true,align:'right',    width:'80px',formatter:'integer' ,sortable:false },*/
	             /*{ name:'promoCnt',   index:'promoCnt',  resizable : true, align:'right',    width:'120px',formatter: 'integer' ,sortable:false },*/
	             /*{ name:'totalPntAvl',   index:'totalPntAvl',  resizable : true, align:'right',    width:'120px',formatter: 'integer' ,sortable:false },*/
	             /*{ name:'prodNm',   index:'lp.PROD_NM',  resizable : true, align:'center',    width:'100px' ,sortable:false },*/
	             { name:'txnAmt',   index:'lpt.TXN_AMT',  resizable : true, align:'right',    width:'80px',formatter:'integer',sortable:false  },
	             { name:'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',    width:'120px' ,sortable:false, formatter:goGridRowChnlDetail },
	             { name:'chnlNo',   index:'lc.CHNL_NO',  resizable : true, align:'center',    width:'80px' ,sortable:false },
	             { name:'cardKndNm',   index:'cc4.mark_name',  resizable : true, align:'center',    width:'100px' ,sortable:false },

	             { name:'rid',    index:'lpt.rid',    hidden : true},
	             { name:'ridChnl',    index:'lc.rid',    hidden : true},
	             { name:'ridMbr',    index:'lm.rid',    hidden : true},
	             { name:'ridMbrCard',    index:'lmc.rid',    hidden : true},
	             { name:'mbrType',    index:'lck.mbr_type',    hidden : true},
	             { name:'cprtCardCd',    index:'lmc.cprt_card_cd',    hidden : true}
	        ],
	        sortname: 'apprDate',
			autowidth : true ,
			sortorder: "desc",

	       	radio: true
	    };

  pointTxnList = $("#pointTxnListGrid").ifvGrid({ jqGridOption : jqGridOption });
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

function fnPromotionList(){
	 pointDetailPop ={
		        id : "rgstPromoDetailPopDiv"
		    };
	 pointDetailPop.popup = function (){
	 	pointDetailPop.pop = $('#'+pointDetailPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pointDetailPop"/>?promoRid='+ mbrTxn_rid ,
		            contentType: "ajax",
		            title: '프로모션항목',
		            width: '1000px'
		        });
		};
		pointDetailPop.beforeClose = function (obj) {
		};
		pointDetailPop.close = function (obj) {
		        this.beforeClose(obj);
		        rgstPromoDetailPopDiv._destroy();
		 };
		 pointDetailPop.popup();
}


/* VOC 생성  */

function fnMbrPntVocRequest(){
	 mbrPntVocPop ={
		        id : "mbrPntVocRequestPopDiv"
		    };
	 mbrPntVocPop.popup = function (){
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


function allSearch(){
	getPointTxnListListSearch('ALL');
}
function acrlSearch(){
	getPointTxnListListSearch('ACRL');
}
function rdmSearch(){
	getPointTxnListListSearch('RDM');
}
function partnerSearch(){
	getPointTxnListListSearch('PARTNER');
}
function butaneSearch(){
	getPointTxnListListSearch('BUTANE');
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


	mbrTxn_rid!=null&&(txnCardMbrType=='20'&&txnCardCprtCardCd!='' )
	? $('#cardNoUnmakingButton').attr('disabled',false) : $('#cardNoUnmakingButton').attr('disabled',true);

	if(promoCnt ==0 || promoCnt ==null){
		$("#txnDtlListBtn").attr('disabled',true);
	}else{
		$("#txnDtlListBtn").attr('disabled',false);
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

$(document).ready(function(){
	$.ifvGetCommCodeList('select', 'searchType', '<ifvm:action name="getCommCodeList2"/>', 'POINT_SEARCH_TYPE', 'loy', false, false, true);


	//stampDetailDataLoad(testViewList_rid);
 	getPointTxnListListSearch('A');


    $("#searchType").on('change', function(){
    	var searchType = $("#searchType").val();
    	getPointTxnListListSearch(searchType);
       });


    // 단체일경우 voc 버튼 히든 처리

     if ( $('#mbrTypeCd').val() == '20'){
    	 $("#vocCreateButton").addClass('hidden');

     }

     //checkButtnAuth();
     window.top.setParentIframeHeight();
});
</script>


<div class="page_btn_area">
	<div class="col-xs-2">
	</div>

	<div class="col-xs-10 searchbtn_r">

		<ifvm:inputNew type="button" btnType="search" text="L01854" id="recentSearchButton"  btnFunc="recentSearch" />
<%-- 		<ifvm:inputNew type="button" btnType="search" text="L01853" id="oldSearchButton"  btnFunc="oldSearch" /> --%>
		<ifvm:inputNew type="button" btnType="search" text="C00037" id="allSearchButton"  btnFunc="allSearch" />
		<ifvm:inputNew type="button" btnType="search" text="L00954" id="acrlSearchButton"  btnFunc="acrlSearch" />
		<ifvm:inputNew type="button" btnType="search" text="L00956" id="rdmSearchButton"  btnFunc="rdmSearch" />
<%-- 		<ifvm:inputNew type="button" btnType="search" text="L00957" id="partnerSearchButton" btnFunc="partnerSearch" /><!--제휴사조회  --> --%>
<%-- 		<ifvm:inputNew type="button" btnType="search" text="L02189" id="butaneSearchButton" btnFunc="butaneSearch" /><!--부탄조회  --> --%>
		<ifvm:inputNew type="button" text="L00326" id="cardNoUnmakingButton"  btnFunc="fnCardNoUnmasking" objCode="LOY_MAS_006"/><!-- 마스킹해제 -->
		<ifvm:inputNew type="button" text="L02018" id="vocCreateButton" btnFunc="fnMbrPntVocRequest" 	className="dropHidBtn"/><!-- 수동 요청 -->
		<ifvm:inputNew type="button" btnType="search" text="L00588" id="txnDtlListBtn"  btnFunc="fnPromotionList" />
<%-- 		<ifvm:inputNew type="button" text="L02000" id="txnItemListBtn"  btnFunc="fnPntItemList" /> --%>
		<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload2('pointTxnListGrid')" />
 	</div>
</div>

   <div id="pointTxnListGrid" class="white_bg grid_bd0"></div>

<script>
</script>

<div id="testViewListPopupContainer" class="popup_container"></div><!-- 팝업 -->
<div id="txnSearchPopupContainer" class="popup_container"></div><!-- 팝업 -->
<div id="rgstPromoDetailPopDiv" class="popup_container content_container"></div>
<div id="mbrPntVocRequestPopDiv" class="popup_container"></div><!-- 팝업 -->
<div id="txnHistDetailPopupDialog" class="popup_container"></div>