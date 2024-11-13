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

<div id="evtApplicantForm">
    <div class="page_btn_area" id=''>
        <div class="col-sm-4">
			<span>조회 결과</span>
    	</div>
        <div class="col-sm-8 searchbtn_r">
       		<!-- 부정 등록 -->
 	        <%-- <button class="btn btn-sm" id="limitWinMbrAddBtn" objCode="winnerLimit_OBJ">
            	<spring:message code="L02550"/>
            </button> --%>
<!--             <button class="btn btn-sm" id="prodEntryNewBtn" objCode="winnerNew_OBJ">
               	 신규
            </button> -->
            <button class="btn btn-sm" id=deleteEventWinnerBtn objCode="winnerDel_OBJ">
				당첨 취소
            </button>
            <button class="btn btn-sm" id="clearMaskBtn" objCode="winnerMask_OBJ">
            	마스킹 해제
            </button>
            <button class="btn btn-sm" id="eventWinnerUploadBtn" objCode="winnerUpld_OBJ">
				당첨자 업로드
            </button>
            <button class="btn btn-sm" id="eventWinnerTempDownBtn" objCode="winnerTempDown_OBJ">
				템플릿다운로드
            </button>
            <button class="btn btn-sm" id="eventWinnerDownBtn" objCode="winnerDown_OBJ">
				당첨자 다운로드
            </button>
            <button class="btn btn-sm" id="eventWinnerResetBtn" objCode="winnerReset_OBJ">
				초기화
            </button>
            <!-- <button class="btn btn-sm" id="benefitPaymentBtn" objCode="winnerBenefit_OBJ">
				혜택 지급
            </button>
            <button class="btn btn-sm" id="cancleBenefitPaymentBtn" objCode="winnerPayment_OBJ">
				혜택 지급 취소
            </button> -->
        </div>
    </div>
    <div id="winnerApplicantGrid" class="white_bg grid_bd0"></div>
</div>
<div id="searchMbrPop" class="popup_container"></div>
<div id="prodDialog" class="popup_container"></div>
<div id="ImgViewPop" class="popup_container"></div><!-- 이미지 보기 팝업 -->
<div id="limitMbrAddPop" class="popup_container"></div><!-- 부정회원등록 팝업 -->


<script type="text/x-jsrender" id="WinColumnTemplate">
   <img style="max-width: 60px; height: 45px; cursor:pointer;" src="{{:uploadPath}}" onclick="showEmg(this);"/>
</script>

<script type="text/javascript">
var winnerApplicantGrid;
var checkRid;

function getEventWinnerList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		requestitem=null;
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }
	      		data.rid = eventRid;
	            return data;
	       	},
	       	loadComplete : function(data){
	       		/* if(evtType=='UGC'){
	       			$("#limitWinMbrAddBtn").show();
       			}else{
       				$("#limitWinMbrAddBtn").hide();
       			} */
			},
	       	rowSelected : function(args){
	       	},
	       	dataUrl : '<ifvm:action name="getProdEntryList"/>',
	        columns:[
	        	  {
		      		  field : 'rid', headerText : 'rid', visible : false,
		      		  customAttributes : {
		      			  index : 't1.rid'}/* rid */
		      	  },{
		      		  field : 'ridMbr', headerText : 'ridMbr', visible : false,
		      		  customAttributes : {
		      			  index : 'ridMbr'
		      			  } /* index : RID_MBR */
		      	  },{
		      		  field : 'mbrNo', headerText : '<spring:message code="L02427"/>', headerTextAlign : 'center', textAlign : 'center',template: "#mbrLinkTemplate",
		      		  customAttributes : {
		      			  index : 'mbrNo'
		      			, encColFlag : false 
		      			, searchable : true} /* 회원번호 */ /* index : 't1.mbr_no' */
		      	  },{
		      		  field : 'custNm', headerText : '<spring:message code="L01927"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'cust_Nm'
		      			, encColFlag : true
		      			, searchable : true}/* 회원명 */ /*   index : 't4.cust_nm' */
		      	  },{
		      		  field : 'sbscTypeCdNm', headerText : '<spring:message code="가입유형"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : { index : 'sbsc_type_cd', encColFlag : false, searchable : true}/* 회원상태 */ /*index : 'cc1.MARK_NAME'*/
		      	  },{
		      		  field : 'hhpNo', headerText : '<spring:message code="L01493"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'hhp_No'
		      			, encColFlag : true
		      			, searchable : true}/* 전화번호 */ /*   index : 't3.HHP_NO' */
		      	  },{
		      		  field : 'age', headerText : '<spring:message code="L02277"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'age'
		      			, encColFlag : false // true
		      			, searchable : true }/* 연령 */ 
		      	  },{
		      		  field : 'mbrStatus', headerText : '<spring:message code="L01653"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'mbrStatus' 
		      			, encColFlag : false
		      			, searchable : true } /* 회원상태 */ /*   index : 't5.MARK_NAME'  */
		      	  },{
		      		  field : 'createDate', headerText : '<spring:message code="M00249"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'createDate' 
		      			, searchable : false }/* 등록일자 */ /*   index : 't1.CREATE_DATE'  */
		      	  },{
		      		  field : 'createBy', headerText : '<spring:message code="L01602"/>', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {
		      			  index : 'createBy' 
		      			, encColFlag : false
		      			, searchable : true }/* 등록자 */ /*   index : 't8.NAME'  */
		      	  },{
		              field : 'uploadPath', headerText : '<spring:message code="L02540"/>', textAlign : 'center', headerTextAlign : 'center', width:'80px', template: "#WinColumnTemplate",
		              customAttributes : {
		                  index : 'uploadPath' 
		                , searchable : false }/* 이미지 */ /*        index : 't9.MBR_UPLOAD_PATH'  */
		          }
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'createDate', //'t1.CREATE_DATE'
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true
	    };
	winnerApplicantGrid = $("#winnerApplicantGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


function prodEntryNew(){
	mbrSearchHelpPopOpen();
}

function mbrSearchHelpPopOpen() {
	mbrSearchHelpPop = {
		id : "searchMbrPop",
		pop : function() {
			$("#" + this.id).ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : '<ifvm:url name="mbrSearchPopup"/>',
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
			getEventWinnerList();
		}
	}
	mbrSearchHelpPop.pop();
}

//삭제
function deleteEventWinner(){
	if($.fn.ifvmIsNotEmpty(winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0])) {
		var checkRid = winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0].rid;
		
		if( confirm('당첨 취소 하시겠습니까?') === false ) {
			return;
		} 
		$.ifvSyncPostJSON('<ifvm:action name="deleteEventWinner"/>', { rid : checkRid }
				, function(result) {
					alert('삭제되었습니다.');
					getEventWinnerList();
				}
		);
	} else {
		alert('목록을 선택해주세요.')
	}
}

//초기화
function eventWinnerReset(){
	if(confirm('현재 당첨자들이 모두 삭제됩니다. 진행하시겠습니까?') === false) return;
	$.ifvSyncPostJSON('<ifvm:action name="eventWinnerReset"/>',{
		rid : eventRid
	},function(result){
		alert('초기화되었습니다.')
		getEventWinnerList();
	});
}

//혜택지급
function benefitPayment(){
	if($.fn.ifvmIsNotEmpty(winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0])){
		var checkRid = winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0].rid;
		if(confirm('혜택을 지급하시겠습니까?') === false) return;
			var eventNo = $("#eventNo").val();
			var pType=null;
			if($.fn.ifvmIsNotEmpty(winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0])){
				pType = 'MBR';
			} else {
				pType = 'ALL';
			}
			$.ifvSyncPostJSON('<ifvm:action name="benefitPayment"/>',{
				pType   : pType,
				eventNo : eventNo,
				rid : checkRid
			},function(result){
				alert(result.rstMsg)
				getEventWinnerList();
			});
	}else{
		alert('목록을 선택해주세요.')
	}
}

//혜택 지급 취소
function cancleBenefitPayment(){
	if($.fn.ifvmIsNotEmpty(winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0])){
		var checkRid = winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0].rid;
		if(confirm('혜택 지급을 취소하시겠습니까?') === false) return;
		var eventNo = $("#eventNo").val();
		$.ifvSyncPostJSON('<ifvm:action name="cancleBenefitPayment"/>',{
			eventNo : eventNo,
			rid : checkRid
		},function(result){
			alert(result.rstMsg);
			getEventWinnerList();
		});
	}else{
		alert('목록을 선택해주세요.')
	}
}
//엑셀 업로드
function eventWinnerUploadPopClose() {
	prodDialog._destroy();
}
//엑셀 업로드
function eventWinnerUploadPop() {
    $("#prodDialog").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="eventWinnerExcelUploadPop"/>',
        contentType: "ajax",
        title: '당첨자 엑셀업로드',
        width: '600px',
        close : 'eventWinnerUploadPopClose'
    });
}

//샘플데이터 다운로드
function eventWinnerTempDown(){
	var data = {};
	data.offerType = "EVENT_WINNER";
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

function eventWinnerExcelDown(){
	$.ifvDBExcelDnSeo('<ifvm:action name="eventWinnerExcelDown"/>','winnerApplicantGrid',"winnerDown_OBJ");
}

//마스킹해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="evtWinnerClearMask"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = winnerApplicantGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhpNo'), result.unMaskHhp);
        });
    }
}

//부정회원 중복체크
function validLimitMbr(){
	if($.fn.ifvmIsNotEmpty(winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0])){
		var ridMbr = winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0].ridMbr;
		$.ifvSyncPostJSON('<ifvm:action name="validLimitMbr"/>',{
			evtRid : eventRid ,
			ridMbr : ridMbr
		},function(result){
			limitMbrAdd();
		},function(result){
			alert('<spring:message code="L02576"/>');//이미 부정 회원으로 등록되어 있습니다.
		});
	}else{
		alert('<spring:message code="M00854"/>');//대상자를 선택하세요.
	}
}

//부정 등록 팝업 Open
function limitMbrAdd(){
    if ($.fn.ifvmIsNotEmpty(winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0])) {
    	var rid= winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0].rid;
    	var ridMbr= winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0].ridMbr;
    	var mbrStatus= winnerApplicantGrid.opt.gridControl.getSelectedRecords()[0].mbrStatus;
    	if(mbrStatus == '탈퇴'){
    		alert('<spring:message code="L02577"/>');//탈퇴한 회원입니다.
    	}else{
    		$("#limitMbrAddPop").ifvsfPopup({
  		      enableModal : true,
  		      enableResize: false,
  		      contentUrl: '<ifvm:url name="limitWinMbrAddPop"/>?ridMbr=' + ridMbr + '&rid=' + rid,
  		      contentType: "ajax",
  		      title: '<spring:message code="L02551"/>',/* 부정등록회원 */
  		      width: '400px',
  		      close : 'limitMbrAddPopupClose'
  			});
    	}
    }else {
        alert('<spring:message code="M00854"/>');//대상자를 선택하세요.
    }
}

//부정 등록 팝업 Close
function limitMbrAddPopupClose() {
	limitMbrAddPop._destroy();
}

//이미지 보기 팝업 Open
function showEmg(data){
	var imageUrl;//사진 URL
    if ($.fn.ifvmIsNotEmpty(data.src)) {
    	imageUrl = data.src;
    	$("#ImgViewPop").ifvsfPopup({
    	      enableModal : true,
    	      enableResize: false,
    	      contentUrl: '<ifvm:url name="imgViewPop"/>?path=' + imageUrl,
    	      contentType: "ajax",
    	      title: '<spring:message code="L02541"/>',/* 이미지 보기 */
    	      width: '900px',
    	      close : 'imgViewPopupClose'
    	});
    }else {
    	alert('<spring:message code="L02586"/>');//이미지가 없습니다.
    }
}

//이미지 보기 팝업 Close
function imgViewPopupClose() {
	ImgViewPop._destroy();
}

//사진 URL 행 세팅
function uploadPathSet(){
	var eventType = $("#eventType").val();
	if(eventType == 'UGC'){
		winnerApplicantGrid.opt.gridControl.showColumns("uploadPath");
	}else{
		winnerApplicantGrid.opt.gridControl.hideColumns("uploadPath");
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

//당첨완료여부 조회
function eventWinCompleteYn() {
	$.ifvSyncPostJSON('<ifvm:action name="getEventWinCompleteYn"/>', {
		eventRid : eventRid
	}, function(result){
		if( $.fn.ifvmIsNotEmpty(result)) {
			if(result.winCmpltYn == 'Y') { // 당첨완료 상태인 경우
				// 특정 버튼 비활성화
				$('#deleteEventWinnerBtn').prop('disabled', true);
				$('#eventWinnerUploadBtn').prop('disabled', true);
				$('#eventWinnerResetBtn').prop('disabled', true);
			}
		}
	},function(result){
		alert(result.message);
	});
}


$(document).ready(function() {

	getEventWinnerList();

	//종료된 이벤트 수정 X
	if(evtStatusCd == 'E'){
		/* $("#prodEntryNewBtn").prop('disabled',true);
		$("#deleteEventWinnerBtn").prop('disabled',true);

		$("#eventWinnerResetBtn").prop('disabled',true);
		$("#benefitPaymentBtn").prop('disabled',true);
		$("#cancleBenefitPaymentBtn").prop('disabled',true); */
	}else if( winCmpltYn == 'Y'){
		/* $("#eventWinnerUploadBtn").prop('disabled',true);
		$("#eventWinnerResetBtn").prop('disabled',true);
		$("#benefitPaymentBtn").prop('disabled',true);
		$("#cancleBenefitPaymentBtn").prop('disabled',true); */
	}

	uploadPathSet();//사진 URL 행 세팅

	// 신규
    $('#prodEntryNewBtn').on('click', function() {
    	prodEntryNew();
    });

	// 엑셀 업로드
    $('#eventWinnerUploadBtn').on('click', function() {
    	eventWinnerUploadPop();
    	/* var rtnValue = validTrans();
		if(rtnValue){
    		eventWinnerUploadPop();
		}else{
			alert('이벤트가 종료 되었거나 또는 현재일자가 이벤트 종료일자보다 커야지만 가능합니다.');
		} */
    });

	// 엑셀 템플릿 다운로드
    $('#eventWinnerTempDownBtn').on('click', function() {
    	eventWinnerTempDown();
    });

	//당첨 취소
    $('#deleteEventWinnerBtn').on('click',function(){
    	deleteEventWinner();
    })

    //초기화
    $('#eventWinnerResetBtn').on('click',function(){
    	eventWinnerReset();
    });

    //혜택 지급
    $('#benefitPaymentBtn').on('click',function(){
    	benefitPayment();
    });

    //혜택 지급 취소
    $('#cancleBenefitPaymentBtn').on('click',function(){
    	cancleBenefitPayment();
    });

    $("#eventWinnerDownBtn").on('click',function(){
    	eventWinnerExcelDown();
    });

	// 마스킹 해제
    $('#clearMaskBtn').on('click', function() {
    	clearMaskAction();
    });

 	// 부정 등록 중복체크
	$('#limitWinMbrAddBtn').on('click', function() {
		validLimitMbr();
    });
 	
	// 현 이벤트가 당첨완료 상태인지 여부에 따른 버튼 활성/비활성화
	eventWinCompleteYn();
});

</script>