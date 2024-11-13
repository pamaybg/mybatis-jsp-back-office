<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
	.tab-contents .page_btn_area .btn.disabled, .tab-contents .page_btn_area .btn[disabled] {
		display: inline;
	}
</style>

<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNewPage"/>?rid={{:ridMbr}}&tabid=mbrEventHistoryList" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>
<script type="text/javascript">
var eventApplicantGrid;
var cmpltFlag = null;

function getEventApplicantList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		requestitem=null;
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }
	      		data.rid = eventRid;
	      		data.eventType = $("#eventType").val();
	            return data;
	       	},
	       	rowSelected : function(args){
	       	},
	       	dataUrl : '<ifvm:action name="getEventApplicantList"/>',
	        columns:[ 
	        	  {
		      		  field : 'rid', headerText : 'rid', visible : false,
		      		  customAttributes : {
		      			  index : 'rid' }/* rid */ 
		      	  },{
		      		  field : 'ridMbr', headerText : 'ridMbr', visible : false,
		      		  customAttributes : {
		      			  index : 'ridMbr'} /* RID_MBR */ /*index : 't1.RID_MBR'*/
		      	  },{
		      		  field : 'mbrNo', headerText : '<spring:message code="L01747"/>', headerTextAlign : 'center', textAlign : 'center', template: "#mbrLinkTemplate",
		      		  customAttributes : { index : 'mbrNo', encColFlag : false, searchable : true} /* 회원번호 */ /*index : 't3.mbr_no'*/
		      	  },/* {
		      		  field : 'ecommMbrNo', headerText : '<spring:message code="L02656"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't3.ECOMM_MBR_NO'
		      			, encColFlag : false} 
		      	  }, */{
		      		  field : 'custNm', headerText : '<spring:message code="L01927"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : { index : 'cust_Nm' , encColFlag : true, searchable : true }/* 회원명 */ /*index : 't4.cust_nm', encColFlag : true*/
		      	  },{
		      		  field : 'sbscTypeCdNm', headerText : '<spring:message code="가입유형"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : { index : 'sbsc_type_cd', encColFlag : false, searchable : true}/* 회원상태 */ /*index : 'cc1.MARK_NAME'*/
		      	  },{
		      		  field : 'hhpNo', headerText : '<spring:message code="L01493"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'hhp_No'
		      			, encColFlag : true, searchable : true}/* 전화번호 */ /*index : 't3.HHP_NO'*/
		      	  },{
		      		  field : 'age', headerText : '<spring:message code="L02277"/>', headerTextAlign : 'center', textAlign : 'center',
		      		customAttributes : {  index : 'age', searchable : true} /* 연령 */ /*index : 'age'*/
		      	  }/* ,{
		      		  field : 'gender', headerText : '<spring:message code="L01184"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : { index : 'gender', encColFlag : false, searchable : false } //성별  //index : 't6.MARK_NAME'
		      	  } */,{
		      		  field : 'mbrStatus', headerText : '<spring:message code="L01244"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : { index : 'mbrStatus', encColFlag : false, searchable : true}/* 회원상태 */ /*index : 'cc1.MARK_NAME'*/
		      	  },{
		      		  field : 'applctDt', headerText : '<spring:message code="L02292"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'applctDt' 
		      			, searchable : false}/* 참여일자 */ /*index : 't1.applct_dt'*/
		      	  }/* ,{
		      		  field : 'applctTicketCnt', headerText : '<spring:message code="L02658"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't1.applct_ticket_cnt'
		      			, encColFlag : false} // 참여티켓수
		      	  } */,{
		      		  field : 'winYn', headerText : '<spring:message code="L01291"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : "winYn"
		      			, searchable : true }/* 당첨여부*/ /*index : '(CASE WHEN t5.RID IS NOT NULL THEN 'Y' ELSE 'N' END)'*/ //encColFlag : false
		      	  },{
		      		  field : 'winDt', headerText : '<spring:message code="M02701"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'winDt' 
		      			, searchable : false}/* 당첨일자 */ /*index : 't5.WIN_DT'*/
		      	  }/* ,{ 
		      		  field : 'bnfYn', headerText : '<spring:message code="L02662"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't5.BNF_YN' 
		      			, encColFlag : false} //혜택지급여부
		      	  } *//* ,{
		      		  field : 'bnfDt', headerText : '<spring:message code="L02663"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 't5.BNF_DT' 
		      			, searchable : false} // 혜택지급일시
		      	  } */
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'applctDt', //'t1.applct_dt'
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true
	    };
	eventApplicantGrid = $("#eventApplicantGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

function evtApplicantDownload(){
	$.ifvDBExcelDnSeo('<ifvm:action name="evtApplicantDown"/>','eventApplicantGrid',"evtApplicantExcel_OBJ");	
}

//당첨자이관 중복체크
function validWinnerTransfer(){
	if($.fn.ifvmIsNotEmpty(eventApplicantGrid.opt.gridControl.getSelectedRecords()[0])){
		var mbrNo = eventApplicantGrid.opt.gridControl.getSelectedRecords()[0].mbrNo
		var applicantRid = eventApplicantGrid.opt.gridControl.getSelectedRecords()[0].rid;
		$.ifvSyncPostJSON('<ifvm:action name="validWinnerTransfer"/>',{
			rid : eventRid ,
			mbrNo : mbrNo,
		},function(result){
			winnerTransfer();
		},function(result){
			alert('이미 당첨된 회원입니다.');
		});
	}else{
		alert('목록을 선택해주세요.');
	}
}

//당첨자 이관
function winnerTransfer(){
	if($.fn.ifvmIsNotEmpty(eventApplicantGrid.opt.gridControl.getSelectedRecords()[0])){
		var applicantRid = eventApplicantGrid.opt.gridControl.getSelectedRecords()[0].rid;
		
		var rtnValue = validTrans();
		if(rtnValue){
			$.ifvSyncPostJSON('<ifvm:action name="insertTransferWinner"/>',{
				rid : applicantRid
			},function(result){
				alert('저장되었습니다.');
			});
		}else{
			alert('이벤트가 종료 되었거나 또는 당첨일이 이벤트 종료일자보다 이후여야 가능합니다.');
		}
	}else{
		alert('목록을 선택해주세요.');
	}
}

//당첨 validcheck
function validTrans(){
	var rtnValue = false;
	
	$.ifvSyncPostJSON('<ifvm:action name="validCheckWinnerTrans"/>',{
		eventRid : eventRid
	},function(result){
		rtnValue = true;
	},function(result){
		rtnValue = false;
	});
	
	return rtnValue;
}

//응모취소
function cancleVote(){
	if($.fn.ifvmIsNotEmpty(eventApplicantGrid.opt.gridControl.getSelectedRecords()[0])){
		if(!confirm('해당 회원의 응모를 취소하시겠습니까?')) return;
		var applicantRid = eventApplicantGrid.opt.gridControl.getSelectedRecords()[0].rid;
			var eventNo = $("#eventNo").val();
			$.ifvSyncPostJSON('<ifvm:action name="cancelVote"/>',{
				rid : applicantRid,
				eventNo : eventNo
			},function(result){
				alert(result.rstMsg);
				getEventApplicantList();
			});
	}else{
		alert('목록을 선택해주세요.');
	}
}

//마스킹해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(eventApplicantGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = eventApplicantGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="evtAppliClearMask"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = eventApplicantGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhpNo'), result.unMaskHhp);
        });
    }
}

//당첨취소
function deleteEventWinner(){
	if ($.fn.ifvmIsNotEmpty(eventApplicantGrid.opt.gridControl.getSelectedRecords()[0])) {
		var checkRid = eventApplicantGrid.opt.gridControl.getSelectedRecords()[0].ridEvtWinner;
		if(confirm('당첨 취소 하시겠습니까?(혜택지급도 취소 됩니다.)') === false) return;
		$.ifvSyncPostJSON('<ifvm:action name="deleteEventWinner"/>',{
			rid : checkRid
		},function(result){
			alert('당첨 취소 되었습니다.')
			getEventApplicantList();
		},function(result){
			alert(result.message);
		});
	}else{
		alert('목록을 선택해주세요.')
	}
}

function transUrl(){
	var url;
	if ($.fn.ifvmIsNotEmpty(eventApplicantGrid.opt.gridControl.getSelectedRecords()[0])) {
		url = eventApplicantGrid.opt.gridControl.getSelectedRecords()[0].applctUrl;
		if(url == null || $.fn.ifvmIsEmpty(url)){
			alert('해당 주소가 없습니다.');
		}else{
			if(url.indexOf("http") != -1){
				var newWindow = window.open("about:blank");
		    	newWindow.location.href = url;
			}else{
				var newWindow = window.open("about:blank");
		    	newWindow.location.href = "https://" + url;
			}
		}
	}else{
		alert('목록을 선택해주세요.');
	}
}

function winnerRdm(){
	$("#popupContainer").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl: '<ifvm:url name="winnerRdmPop"/>',
		contentType: "ajax",
		title: '당첨자 랜덤추출',
		width: '700px',
		close : 'winnerRdmPopClose'
	}); 
}

function winnerRdmPopClose(){
	popupContainer._destroy();
}

//유형별 화면세팅
function displaySet(){
	var eventType = $("#eventType").val();
	if(eventType != 'SNS'){
		eventApplicantGrid.opt.gridControl.hideColumns("snsId");
		eventApplicantGrid.opt.gridControl.hideColumns("applctUrl");
	}
	if(eventType == 'ONAIR'){
		//조회결과 숨기기
		eventApplicantGrid.opt.gridControl.hideColumns("applctTicketCnt");
		eventApplicantGrid.opt.gridControl.hideColumns("winYn");
		eventApplicantGrid.opt.gridControl.hideColumns("winDt");
		//버튼 숨기기
		/* $('#transUrlBtn').hide();
		$('#winnerTransfer').hide();
		$('#winnerRdm').hide();
		$('#cancleVote').hide();
		$('#deleteEventWinnerBtn').hide(); */
	}
}

function applctEntryNew(){
	mbrSearchHelpPop = {
			id : "searchMbrPop",
			pop : function() {
				$("#" + this.id).ifvsfPopup({
					enableModal : true,
					enableResize : false,
					contentUrl : '<ifvm:url name="mbrApplctSearchPopup"/>',
					contentType : "ajax",
					title : '<spring:message code="L00988"/>', // 회원 찾기
					width : '700px'
				});
			},
			close : function(obj) {
				if (obj) {
					this.beforeClose(obj)
				}
				var _popObj = eval(this.id)
				_popObj._destroy();
				getEventApplicantList();
			}
		}
		mbrSearchHelpPop.pop();
}


//엑셀 업로드
function eventApplicantUploadPopClose() {
	excelUploadPop._destroy();
}

//엑셀 업로드
function eventApplicantUploadPop() {
    $("#excelUploadPop").ifvsfPopup({
      	enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="eventApplicantExcelUploadPop"/>',
        contentType: "ajax",
        title: '참여자 엑셀업로드',
        width: '600px',
        close : 'eventApplicantUploadPopClose'
    });
}


// 초기화
function eventApplicantReset(){
	if( confirm('현재 참여자들이 모두 삭제됩니다. 진행하시겠습니까?') === false ) {
		return;	
	}
	// 현재 삭제되려는 회원목록들 중에 당첨자 목록에 회원번호로 있는 회원이 있는지 확인
	$.ifvSyncPostJSON('<ifvm:action name="isThereWinnerInApplicant"/>',{
		eventRid : eventRid 
	}, function(result){
		if(result.length != 0) {
			alert("당첨자가 포함되어 있습니다. 당첨자 취소 후 진행해주세요.");	
		} else {
			$.ifvSyncPostJSON('<ifvm:action name="eventApplicantReset"/>',{
				rid : eventRid
			},function(result){
				alert('초기화되었습니다.')
				getEventApplicantList();
			});
		}
	}, function(result){
		alert(result.message);
	});
}

// 당첨완료여부 조회
function eventWinCompleteYn() {
	$.ifvSyncPostJSON('<ifvm:action name="getEventWinCompleteYn"/>', {
		eventRid : eventRid
	}, function(result){
		if( $.fn.ifvmIsNotEmpty(result)) {
	 		if(result.winCmpltYn == 'Y') { // 당첨완료 상태인 경우
	 			// 특정 버튼 비활성화
	 			$('#applctEntryNewBtn').prop('disabled', true);
	 			$('#evtApplicantUploadBtn').prop('disabled', true);
	 			$('#winnerTransfer').prop('disabled', true);
	 			$('#winnerRdm').prop('disabled', true);
	 			$('#cancleVote').prop('disabled', true);
	 			$('#eventApplicantResetBtn').prop('disabled', true);
	 		}
		}
 	},function(result){
 		alert(result.message);
 	});
}

// 이벤트 참여 가능 기간인지 확인
function validateApplyDate() {
	var flag = null;
	var startDt = $('#voteStartDate').val();
	var endDt = $('#voteEndDate').val();
	var todayDt = $.ifvGetTodayDate();
	
	if(todayDt >= startDt && todayDt <= endDt) {
		flag = true;
	} else {
		flag = false;
	}
	return flag;
}

// 이벤트의 상태(evtStatusCd) 확인
function validateEvtStatus() {
	var flag = null;
	var evtStatusCd = $('#evtStatusCd').val();
	
	if(evtStatusCd == 'A') {
		flag = true;
	} else {
		flag = false;
	}
	return flag;
}

//샘플데이터 다운로드
function eventApplicantTempDown(){
	var data = {};
	data.offerType = "EVENT_APPLICANT";
	$.fn.ifvmBatchRgstExcelSampleDown2(data);
}

//샘플데이터 다운로드
$.fn.ifvmBatchRgstExcelSampleDown2 = function(data) {
	var inputs = "";
	var url = "/system/batchRgst/excelSampleDown2.do";
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


$(document).ready(function() {
	if (typeof evtStatusCd == "undefined" || evtStatusCd == null) {
		/* $("#clearMaskBtn").prop('disabled',true);
		$("#cancleVote").prop('disabled',true);
		$("#winnerTransfer").prop('disabled',true);
		$("#deleteEventWinnerBtn").prop('disabled',true);
		$("#winnerRdm").prop('disabled',true); */
	} else if (evtStatusCd == 'E') {
		//$("#cancleVote").prop('disabled',true);
		//$("#winnerTransfer").prop('disabled',true);
		//$("#winnerRdm").prop('disabled',false);		
		//$("#deleteEventWinnerBtn").prop('disabled',true);
	}else if($('#eventType').val() != "MONTHLY"){
		//$("#winnerRdm").prop('disabled',true);
	}
	
	if (winCmpltYn == 'Y') {
		//$("#winnerTransfer").prop('disabled',true);
		//$("#deleteEventWinnerBtn").prop('disabled',true);
		//$("#winnerRdm").prop('disabled',true);
	}
	getEventApplicantList();
	
	// 엑셀다운로드
    $('#evtApplicantDownload').on('click', function() {
    	evtApplicantDownload();
    });

    // 당첨자이관
    $('#winnerTransfer').on('click', function() {
    	validWinnerTransfer();
    });
    
    // 응모취소
    $('#cancleVote').on('click', function() {
    	cancleVote();
    });
    
	//당첨 취소
    $('#deleteEventWinnerBtn').on('click',function(){
    	deleteEventWinner();
    })
    
	// 마스킹 해제
    $('#clearMaskBtn').on('click', function() {
    	clearMaskAction();
    });
	
 	// URL 이동
    $('#transUrlBtn').on('click', function() {
    	transUrl();
    });
 	
 	//당첨자 랜덤추출
 	$('#winnerRdm').on('click',function(){
 		winnerRdm();
 	});
 	
 	// 신규 버튼 클릭
 	$('#applctEntryNewBtn').on('click', function() {
 		/* if(!validateApplyDate()) { // 참여자 등록 가능한 기간인지 판별
			alert("이벤트 참여 기간 동안만 가능합니다.");
			return;
		} */
		if(!validateEvtStatus()) { // 이벤트의 현재 상태가 '활성'인지 판별
			alert("이벤트가 활성 상태일 때 가능합니다.");
			return;
		}
 		applctEntryNew();
    });
 	
	// 엑셀 업로드 클릭 시
    $('#evtApplicantUploadBtn').on('click', function(){
		/* if(!validateApplyDate()) { // 참여자 등록 가능한 기간인지 판별
			alert("이벤트 참여 기간 동안만 가능합니다.");
			return;
		} */
		if(!validateEvtStatus()) { // 이벤트의 현재 상태가 '활성'인지 판별
			alert("이벤트가 활성 상태일 때 가능합니다.");
			return;
		}
		eventApplicantUploadPop();
    });
 	
  //초기화
    $('#eventApplicantResetBtn').on('click',function(){
    	eventApplicantReset();
    });
  
 	// 엑셀 템플릿 다운로드
    $('#eventApplicantTempDownBtn').on('click', function() {
    	eventApplicantTempDown();
    });
 	
 	//유형별 화면세팅
 	displaySet();
 	
 	// 현 이벤트가 당첨완료 상태인지 여부에 따른 버튼 활성/비활성화
 	eventWinCompleteYn();
});

</script>

<div id="evtApplicantForm">
    <div class="page_btn_area" id=''>
    	<div class="col-sm-5">
			<span>조회 결과</span>    
    	</div>
        <div class="col-xs-7 searchbtn_r">
        	<!-- <button class="btn btn-sm" id="transUrlBtn">
            	URL 이동
            </button> -->
            <button class="btn btn-sm" id="applctEntryNewBtn" objCode="evtApplicantNew_OBJ">
               	 신규
            </button>
            <button class="btn btn-sm" id="evtApplicantUploadBtn" objCode="evtApplicantUpld_OBJ"> <!-- 엑셀 업로드 -->
				참여자 업로드
            </button>
            <button class="btn btn-sm" id="eventApplicantTempDownBtn" objCode="evtApplicantTempDown_OBJ">
				템플릿다운로드
            </button>
            <button class="btn btn-sm" id="clearMaskBtn" objCode="evtApplicantMask_OBJ">
            	마스킹 해제
            </button>
            <button class="btn btn-sm" id="evtApplicantDownload" objCode="evtApplicantExcel_OBJ">
               	참여자 다운로드
            </button>
            <button class="btn btn-sm" id="winnerTransfer"  objCode="evtApplicantTransWinner_OBJ">
				당첨자 이관
            </button>
             <button class="btn btn-sm" id="winnerRdm" objCode="evtApplicantWinRdm_OBJ">
				당첨자 랜덤추출
            </button>
            <button class="btn btn-sm" id="cancleVote"  objCode="evtApplicantChnl_OBJ">
            	응모 취소
            </button>
            <button class="btn btn-sm" id="eventApplicantResetBtn" objCode="evtApplicantReset_OBJ">
				초기화
            </button>
			<!-- <button class="btn btn-sm" id=deleteEventWinnerBtn objCode="evtApplicantDelWin_OBJ">
				당첨 취소
            </button> -->
        </div>
    </div>
    <div id="eventApplicantGrid" class="white_bg grid_bd0"></div>
</div>
<div id="popupContainer" class="popup_container"></div><!-- 팝업 -->
<div id="searchMbrPop" class="popup_container"></div>
<div id="excelUploadPop" class="popup_container"></div>
