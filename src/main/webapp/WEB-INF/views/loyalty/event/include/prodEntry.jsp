<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}&tabid=mbrEventHistoryList" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>
<script type="text/javascript">
var eventProdEntryGrid;

function getEventApplicantList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		requestitem=null;
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }
	      		data.rid = eventRid;
	            return data;
	       	},
	       	rowSelected : function(args){
	       	},
	       	dataUrl : '<ifvm:action name="getSelectProdEntryList"/>',
	        columns:[ 
	        	  {
		      		  field : 'rid', headerText : 'rid', visible : false,
		      		  customAttributes : {
		      			  index : 't1.rid' }/* rid */
		      	  },{
		      		  field : 'ridMbr', headerText : 'ridMbr', visible : false,
		      		  customAttributes : {
		      			  index : 't1.RID_MBR'} /* RID_MBR */
		      	  },{
		      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center',template: "#mbrLinkTemplate",
		      		  customAttributes : {
		      			  index : 't3.mbr_no'} /* 회원번호 */
		      	  },{
		      		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't5.custNm' 
		      			, encColFlag : true}/* 회원명 */
		      	  },{
		      		  field : 'mbrStatus', headerText : '회원상태', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't5.MARK_NAME' }/* 회원상태 */
		      	  },{
		      		  field : 'rdgDt', headerText : '신청일시', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't1.REG_DT' }/* 신청일시 */
		      	  },{
		      		  field : 'receiveCustNm', headerText : '받을사람', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't1.RECEIVE_CUST_NM' }/* 받을사람 */
		      	  },{
		      		  field : 'receiveHhpNo', headerText : '휴대폰 번호', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't1.RECEIVE_HHP_NO' }/* 휴대폰 번호 */
		      	  },{
		      		  field : 'receiveZipNo', headerText : '배송지 우편번호', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't1.RECEIVE_ZIP_NO' }/* 배송지 우편번호 */
		      	  },{
		      		  field : 'receiveAddrH', headerText : '배송지 주소 1', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't1.RECEIVE_ADDR_H' }/* 배송지 주소 1 */
		      	  },{
		      		  field : 'receiveAddrD', headerText : '배송지 주소 2', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't1.RECEIVE_ADDR_D' }/* 배송지 주소 2 */
		      	  },{
		      		  field : 'sendYn', headerText : '발송여부', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't1.SEND_YN' }/* 발송여부 */
		      	  },{
		      		  field : 'sendDt', headerText : '발송일시', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't1.SEND_DT' }/* 발송일시 */
		      	  }
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 't1.REG_DT',
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true
	    };
	eventProdEntryGrid = $("#eventProdEntryGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function evtApplicantDownload(){
	$.ifvExcelDn('<ifvm:action name="eventProdEntryExcelDown"/>','eventProdEntryGrid');	
}

//발송 완료
function sendProdEntry(){
	if($.fn.ifvmIsNotEmpty(eventProdEntryGrid.opt.gridControl.getSelectedRecords()[0])){
		var prodEntryRid = eventProdEntryGrid.opt.gridControl.getSelectedRecords()[0].rid;
		$.ifvSyncPostJSON('<ifvm:action name="updateSendSuccess"/>',{
			rid : prodEntryRid
		},function(result){
			alert('발송 처리 되었습니다')
			getEventApplicantList();
		});
	}else{
		alert('목록을 선택해주세요.');
	}
}

//발송 완료
function cancelProdEntry(){
	if($.fn.ifvmIsNotEmpty(eventProdEntryGrid.opt.gridControl.getSelectedRecords()[0])){
		var prodEntryRid = eventProdEntryGrid.opt.gridControl.getSelectedRecords()[0].rid;
		$.ifvSyncPostJSON('<ifvm:action name="updateSendCancel"/>',{
			rid : prodEntryRid
		},function(result){
			alert('발송취소 처리 되었습니다')
			getEventApplicantList();
		});
	}else{
		alert('목록을 선택해주세요.');
	}
}

//템플릿 다운로드
function tempDownload(){
	var data = {};
	data.offerType = "PROD_ENTRY";
	$.fn.ifvmBatchRgstExcelSampleDown2(data);
}

//샘플데이터 다운로드
$.fn.ifvmBatchRgstExcelSampleDown2 = function(data) {
	var inputs = "";
	var url = "/loyalty/batchRgst/excelSampleDown2.do";
	var method = "post"
		//data를 입력받음
		if( data ){
			if ($.fn.ifvmIsNotEmpty(data.offerType)) {
				inputs += '<input type="hidden" name="offerType" value="'+ data.offerType +'" />';

				// request를 보낸다.
				jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
				.appendTo('body').submit().remove();
			}
		};
};

//엑셀 업로드
function prodEntryUploadPopClose() {
	prodDialog._destroy();
}
//엑셀 업로드
function prodEntryUploadPop() {
    $("#prodDialog").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="prodEntryExcelUploadPop"/>',
        contentType: "ajax",
        title: '상품 엑셀업로드',
        width: '600px',
        close : 'prodEntryUploadPopClose'
    });
}

//마스킹해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(eventProdEntryGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = eventProdEntryGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="evtProdEntryClearMask"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = eventProdEntryGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
        });
    }
}

$(document).ready(function() {
	
	getEventApplicantList()
	
	if(evtStatusCd == 'E'){
		$("#sendProdEntry").prop('disabled',true);
		$("#cancelProdEntry").prop('disabled',true);
		$("#sendSucExcelUpload").prop('disabled',true);
	}
	
	// 엑셀업로드
    $('#sendSucExcelUpload').on('click', function() {
    	prodEntryUploadPop();
    });

    // 템플릿 다운로드
    $('#tempDownload').on('click', function() {
    	tempDownload();
    });
    
    // 발송완료
    $('#sendProdEntry').on('click', function() {
    	sendProdEntry();
    });
    
    // 발송취소
    $('#cancelProdEntry').on('click', function() {
    	cancelProdEntry();
    });
    
	// 마스킹 해제
    $('#clearMaskBtn').on('click', function() {
    	clearMaskAction();
    });
	
	//엑셀다운로드
	$('#evtApplicantDownload').on('click', function() {
		evtApplicantDownload();
    });
});

</script>

<div id="evtApplicantForm">
    <div class="page_btn_area" id=''>
    	<div class="col-sm-7">
			<span>조회 결과</span>    
    	</div>
        <div class="col-sm-5 searchbtn_r">
         	<button class="btn btn-sm" id="clearMaskBtn">
            	마스킹 해제
            </button>
        	<button class="btn btn-sm" id="sendProdEntry" objCode="LOY_SEND_COMPLETE">
				발송완료
            </button>
            <button class="btn btn-sm" id="cancelProdEntry">
				발송취소
            </button>
            <button class="btn btn-sm" id="sendSucExcelUpload" objCode="LOY_EXC_SEND">
				엑셀 업로드(발송완료)
            </button>
            <button class="btn btn-sm" id="tempDownload">
            	템플릿 다운로드
            </button>
            <button class="btn btn-sm" id="evtApplicantDownload" objCode="COM_EXC_001">
               	 다운로드
            </button>
        </div>
    </div>
    <div id="eventProdEntryGrid" class="white_bg grid_bd0"></div>
</div>
<div id="prodDialog" class="popup_container"></div>