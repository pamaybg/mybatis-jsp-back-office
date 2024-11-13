<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var chnlTxnHistList;
var gridIdchnlTxnHistList;
var rid ;
var mbrTxn_rid=null;
var txnCardMbrType = null;
var txnCardCprtCardCd= null;



//가맹점 거래이력
function getchnlTxnHistListSearch(searchType){
    var jqGridOption = {
        ondblClickRow : function(data){
            var data = chnlTxnHistList.getRowData()[data-1];
            rid = data.rid;
        },
        onSelectRow : function (data) {
        	mbrTxn_rid = data.rid;
        	txnCardMbrType = data.mbrType;
        	txnCardCprtCardCd = data.cprtCardCd;
        	fnButtonStatus();
        },
        serializeGridData : function( data ){

        	data.searchType = searchType
        	data.rid = channelDetail_rid;
            return data;
        },
        loadComplete : function(obj){

        	 $('#cardNoUnmakingButton').attr('disabled',true);
        	  $('#txnDtlListBtn').attr('disabled',true);
        	  $('#txnItemListBtn').attr('disabled',true);
        },
        url : '<ifvm:action name="getChnlSubTxnHistList"/>',
        colNames:[
                   '<spring:message code="L01402" />',
                   '<spring:message code="L01403" />',
                   '<spring:message code="L01404" />',
                   '<spring:message code="L01405" />',
                   '<spring:message code="L01406" />',
                   '<spring:message code="L01407" />',
                   '<spring:message code="L01408" />',
                   '<spring:message code="L01409" />',
                   '<spring:message code="L01410" />',
                   '<spring:message code="L01411" />',
                   '<spring:message code="L01412" />',
                   '<spring:message code="L01413" />',

                   'rid',
                   'mbrType',
                   'cprtCardCd',
                   'ridMbr'
                 ],
        colModel:[
             { name:'chnlNo',   	index:'b.chnl_no',  resizable : true, align:'center',   width:'100px' ,sortable:false },
             { name:'chnlNm',   	index:'b.chnl_nm',  resizable : true, align:'center',   width:'100px' ,sortable:false },
             { name:'apprDate',   	index:'a.appr_dt',  resizable : true, align:'center',  	width:'100px' ,sortable:false },
             { name:'mbrNo',   		index:'c.mbr_no',  	resizable : true, align:'center',   width:'100px' ,sortable:false, formatter: goGridRowMbrLink },
             { name:'custNm',   	index:'d.cust_nm',  resizable : true, align:'center',   width:'100px' ,sortable:false },
             { name:'cardNum',   	index:'a.card_num', resizable : true, align:'center',   width:'150px' ,sortable:false },
             { name:'pntTxnType2Cd',index:'e.mark_name',resizable : true, align:'center',   width:'100px' ,sortable:false },
             { name:'prodNm',   	index:'f.prod_nm',  resizable : true, align:'center',   width:'100px' ,sortable:false },
             { name:'txnAmt',   	index:'a.txn_amt',  resizable : true, align:'right',    formatter:'integer', width:'100px' ,sortable:false },
             { name:'pntAmt',   	index:'a.pnt_amt',  resizable : true, align:'right',    formatter:'integer', width:'100px' ,sortable:false },
             { name:'usePnt',   	index:'a.use_pnt',  resizable : true, align:'right',    formatter:'integer', width:'100px' ,sortable:false },
             { name:'giftPnt',   	index:'a.gift_pnt', resizable : true, align:'right',  	formatter:'integer', width:'100px' ,sortable:false },

             { name:'rid',    		index:'a.rid',    		hidden : true},
             { name:'mbrType',    	index:'lck.mbr_type',   hidden : true},
             { name:'cprtCardCd',   index:'lmc.cprt_card_cd',hidden : true},
             { name:'ridMbr',    	index:'lmc.rid',    	hidden : true}
        ],
        sortname: 'a.appr_dt',
        autowidth : true ,
        sortorder: "desc",

        radio : true
    };

    chnlTxnHistList = $("#chnlTxnHistListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdchnlTxnHistList = $("#gridIdchnlTxnHistList");
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

//공통 조회 호출
function chnlTxnHistListSearch() {
    $.fn.ifvmSubmitSearchCondition("chnlTxnHistListSearchList", getchnlTxnHistListSearch);
}

function allSearch(){
	getchnlTxnHistListSearch('ALL');
}
function acrlSearch(){
	getchnlTxnHistListSearch('ACRL');
}
function rdmSearch(){
	getchnlTxnHistListSearch('RDM');
}
function partnerSearch(){
	getchnlTxnHistListSearch('PARTNER');
}


function oldSearch(){
	pointTxnPop ={
	        id : "txnSearchPopupContainer"
	    };
	pointTxnPop.popup = function (){
		pointTxnPop.pop = $('#'+pointTxnPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="transactionListPop"/>?defaultChnlRid='+channelDetail_rid +'&defaultArchive=Y',
	            contentType: "ajax",
	            title: '과거 이력 조회 ',
	            width: '1000px'
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
	        id : "txnSearchPopupContainer"
	    };
	pointTxnPop.popup = function (){
		pointTxnPop.pop = $('#'+pointTxnPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: '<ifvm:url name="transactionListPop"/>?defaultChnlRid='+ channelDetail_rid,
	            contentType: "ajax",
	            title: '이력 상세 조회 ',
	            width: '1000px'
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





function fnCardNoUnmasking() {


    if ($.fn.ifvmIsNotEmpty(mbrTxn_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
            rid : mbrTxn_rid,
            type : 'txn',
            field : 'cardNo'

        }, function(result) {

            var rowid = chnlTxnHistList.getRadioSelectedRowId();
            if (result.message != null) {
                chnlTxnHistList.opt.grid.setCell(rowid, 'cardNum', result.message);
            }
        });
    }
}


function fnPromotionList(){
	 pointDetailPop ={
		        id : "txnHistDetailPopupDialog"
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
		        txnHistDetailPopupDialog._destroy();
		 };
		 pointDetailPop.popup();
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
		            title: '유외상품',
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

	mbrTxn_rid!=null ? $('#txnDtlListBtn').attr('disabled',false) : $('#txnDtlListBtn').attr('disabled',true);
	mbrTxn_rid!=null ? $('#txnItemListBtn').attr('disabled',false) : $('#txnItemListBtn').attr('disabled',true);

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

$(document).ready(function() {
	//마스킹해제 권한 체크
	//checkButtnAuth();
    chnlTxnHistListSearch();
});

</script>



<div>
    <div class="page_btn_area" >
        <div class="col-xs-2">

        </div>
        <div class="col-xs-10 searchbtn_r">
	        <ifvm:inputNew type="button" text="L00326" id="cardNoUnmakingButton"  btnFunc="fnCardNoUnmasking" objCode="LOY_MAS_001" />
	        <ifvm:inputNew type="button" btnType="search" text="L01854" id="recentSearchButton"  btnFunc="recentSearch" />
			<ifvm:inputNew type="button" btnType="search" text="L01853" id="oldSearchButton"  btnFunc="oldSearch" />
			<ifvm:inputNew type="button" btnType="search" text="C00037" id="allSearchButton"  btnFunc="allSearch" />
			<ifvm:inputNew type="button" btnType="search" text="L00954" id="acrlSearchButton"  btnFunc="acrlSearch" />
			<ifvm:inputNew type="button" btnType="search" text="L00956" id="rdmSearchButton"  btnFunc="rdmSearch" />

			<ifvm:inputNew type="button" btnType="select" text="M00169" id="txnDtlListBtn"  btnFunc="fnPromotionList" />
			<ifvm:inputNew type="button" btnType="select" text="L02000" id="txnItemListBtn"  btnFunc="fnPntItemList" />


        </div>
    </div>
    <div id="chnlTxnHistListGrid" class="white_bg grid_bd0"></div>
    <div id="txnSearchPopupContainer" class="popup_container"></div><!-- 팝업 -->
</div>

<div id="txnHistDetailPopupDialog" class="popup_container"></div>


