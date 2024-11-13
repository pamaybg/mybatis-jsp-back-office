<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}&tabid=mbrStoreHistListNew" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>
<script type="text/javascript">
var storeType = $("#storeType").val();
var transactionHistGrid;

function getTransactionHistList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }
	      		data.ridStore = storeRid;
	      		acrlUseSetting();
	            return data;
	       	},
	       	rowSelected : function(args){
	       	},
	       	dataUrl : '<ifvm:action name="getEventStoreTxnList"/>',
	        columns:[ 
	        	  {
		      		  field : 'rid', headerText : 'rid', visible : false,
		      		  customAttributes : {
		      			  index : 'lst.RID' }/* rid */
		      	  },{
		      		  field : 'ridMbr', headerText : 'ridMbr', visible: false,
		      		  customAttributes : {
		      			  index : 'lm.RID' }/* */
		      	  },{
		      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center', width:'80px',template: "#mbrLinkTemplate",
		      		  customAttributes : {
		      			  index : 'lm.MBR_NO'} /* 회원번호 */
		      	  },{
		      		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'custNm'} /* 회원명 */
		      	  },{
		      		  field : 'mbrStatus', headerText : '회원상태', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'c1.MARK_NAME'} /* 회원상태 */
		      	  },{
		      		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign : 'left',  width:'200px',
		      		  customAttributes : {
		      			  index : 'lch.chnl_Nm'}/* 스토어명 */
		      	  },{
		      		  field : 'txnDt', headerText : '거래일시', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : "TO_CHAR(lst.TXN_DT,'YYYY-MM-DD HH24:MI')" }/* 거래일시 */
		      	  },{
		      		  field : 'pntAmt', headerText : '포인트금액', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width:'80px',
		      		  customAttributes : {
		      			  index : 'lst.pnt_Amt' }/* 포인트금액 */
		      	  },{
		      		  field : 'txnStatus', headerText : '거래상태', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'c2.mark_name' }/* 거래상태 */
		      	  },{
		      		  field : 'txnPntType', headerText : '거래포인트유형', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'c3.mark_name' }/* 거래포인트유형 */
		      	  }
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : "TO_CHAR(lst.TXN_DT,'YYYY-MM-DD HH24:MI')",
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true,
	        tempId : 'ifvGridSimplePageTemplete'
	    };
	transactionHistGrid = $("#transactionHistGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function searchPntTxnAListSearchInit() {
    $.fn.ifvmSetCommonCondList("transactionHistList","LOY_STORE_TXN_TAB");
}

//공통 조회 호출
function searchPntTxnAListSearch() {
    $.fn.ifvmSubmitSearchCondition("transactionHistList", getTransactionHistList);
}

//마스킹해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(transactionHistGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = transactionHistGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="getEventStoreTxnMaskList"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = transactionHistGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
        });
    }
}

//적립 사용 셋팅
function acrlUseSetting() {
	//포인트 적립
	if(storeType=='P4'){
	totAcrlPoint();
	}
	//포인트 사용
	else if(storeType=='P3'){
	totRdmPoint();
	}
}

//포인트 사용
function totRdmPoint(){
	$.ifvPostJSON('<ifvm:action name="getStoreRdmPoint"/>',{
		ridStore : storeRid,
		item : requestitem
	},function(result){
		if(result.rdmAmt == null){
			$('#use').val(0);
		}else{
			$('#use').val((numberWithCommas(result.rdmAmt)));
		}
	});
}

//포인트 적립
function totAcrlPoint(){
	$.ifvPostJSON('<ifvm:action name="getStoreAcrlPoint"/>',{
		ridStore : storeRid,
		item : requestitem
	},function(result){
		if(result.acrlAmt == null){
			$('#acrl').val(0);
		}else{
			$('#acrl').val((numberWithCommas(result.acrlAmt)));			
		}
	});
}

function totPointInit(){
	if(storeType=='P3'){
		$("#totPoint").append('<span>사용</span>');
		$("#totPoint").append('<input type="text" id="use" style="width: 80px;" value="0" readonly/>');
	}
	else if(storeType=='P4'){
		$("#totPoint").append('<span>적립</span>');
		$("#totPoint").append('<input type="text" id="acrl"  style="width: 80px" value="0" readonly/>');
	}
}

function pointCancel(){
	if ($.fn.ifvmIsNotEmpty(transactionHistGrid.opt.gridControl.getSelectedRecords()[0])) {
		mbrNo = transactionHistGrid.opt.gridControl.getSelectedRecords()[0].mbrNo;
		txnRid = transactionHistGrid.opt.gridControl.getSelectedRecords()[0].rid;
	} else {
		 alert('<spring:message code="L00117"/>');
	}
	if($.fn.ifvmIsNotEmpty(mbrNo)){
		var result = confirm('포인트 취소하시겠습니까?');		
		if(result){
			$.ifvPostJSON('<ifvm:action name="gloShopPointCancel"/>',{
				mbrNo : mbrNo
			  , txnRid : txnRid
			},function(result){
				alert('취소되었습니다.');
				getTransactionHistList();
			},function(result){
				alert(result.message);
			});
		}
	}
}

function numberWithCommas(str) {
	   return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

$(document).ready(function() {
	totPointInit(); 
	
	searchPntTxnAListSearchInit();	
	$('.hasDatepicker').val(''); //거래일시 빈값
	//searchPntTxnAListSearch(); 
	
	getTransactionHistList();
	
	$('#tranSearchBtn').on('click',function(){
		searchPntTxnAListSearch();
	});
	
	$('#tranMaskBtn').on('click',function(){
		clearMaskAction();
	});
	
	$('#tranDownBtn').on('click',function(){
		$.ifvExcelDn('<ifvm:action name="getEventStoreTxnExcelDown"/>','transactionHistGrid');
	});
	
	$('#pointCancel').on('click',function(){
		pointCancel();
	});
	
	if(storeType == 'P3'){
		$('#pointCancel').prop('disabled',false);
	}else if(storeType == 'P4'){
		$('#pointCancel').prop('disabled',true);
	}else{
		$('#pointCancel').prop('disabled',true);
	}
});

</script>

<div id="evtApplicantForm">
    <div class="page_btn_area" id=''>
    	<div class="col-sm-7">
    	</div>
        <div class="col-sm-5 searchbtn_r">
        	<button class="btn btn-sm" id="tranMaskBtn">
            	마스킹해제
            </button>
        	<button class="btn btn-sm" id="pointCancel">
            	포인트취소
            </button>
        	<button class="btn btn-sm" id="tranSearchBtn">
            	조회
            </button>
            <!-- <button class="btn btn-sm" id="tranDownBtn">
            	다운로드
            </button> -->
        </div>
    </div>
</div>

<div class ="row white_bg">    
    <div class = "col-xs-9 control_content">
		<div class="form-horizontal well_bt5" id="transactionHistList"></div>
	</div>
	<div id="totPoint" class="col-xs-3 control_content" style="text-align:right; padding-left: 0; padding-right: 0; padding: 7px 15px;">
	</div>
</div>	
<div id="transactionHistGrid" class="white_bg grid_bd0"></div>
