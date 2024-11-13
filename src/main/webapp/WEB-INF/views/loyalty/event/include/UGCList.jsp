<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}&tabid=mbrEventHistoryList" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>
<div class="page_btn_area" id=''>
   	<div class="col-sm-7">
		<span>조회 결과</span>
   	</div>
    <div class="col-sm-5 searchbtn_r">

    <ifvm:inputNew type="button"   btnType="search"  text="사진보기" nuc="true"  id="ugcDtlBtn" btnFunc="ugcDtlFn"/>
    	<!-- 부정 등록 -->
 	   <button class="btn btn-sm" id="limitUgcMbrAddBtn">
       	<spring:message code="L02550"/>
       </button>
	   <button class="btn btn-sm" id="clearMaskBtn">
           	마스킹 해제
       </button>
       <button class="btn btn-sm" id="ugcListDownload" objCode="COM_EXC_001">
           	 엑셀 다운로드
       </button>
    </div>
</div>
<div class ="row white_bg">
	<div class="control_content" style=" padding-left: 0; padding-right: 0; padding: 7px 15px;">
		<span>조회일</span>
		<input type="text" id=date style="width: 80px;"readonly="readonly" />
		<span style="padding-left: 10px;"><spring:message code="L02633"/></span><!-- 참여 인원 -->
		<input type="text" id="totalCnt" style="width: 80px;" readonly="readonly"/>
		<span style="padding-left: 10px;" >총 완료 인원 </span>
		<input type="text" id="tot_p" style="width: 80px;" readonly="readonly"/>
		<span style="padding-left: 10px;">총 완료 스탬프</span>
		<input type="text" id="tot_cnt"  style="width: 80px" readonly="readonly"/>
		<span style="padding-left: 10px;">총 스탬프</span>
		<input type="text" id="tot_stmp"  style="width: 80px" readonly="readonly"/>
	</div>
</div>

<div id="ugcListGrid" class="white_bg grid_bd0"></div>
<div id="ImgViewPop" class="popup_container"></div><!-- 팝업 -->
<div id="limitMbrAddPop" class="popup_container"></div><!-- 팝업 -->
<div id="ugcDtlPopDiv" class="popup_container"></div><!-- 사진보기 -->
<div id="limitUgcAddPop" class="popup_container"></div><!-- 팝업 -->

<script type="text/javascript">
var ugcListGrid;
var ridUGCEvt;
var ridUGCMbr;
function getUGCList(){
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
	       		ridUGCEvt = eventRid;
	       		ridUGCMbr = args.data.ridMbr;
	       	},
	       	dataUrl : '<ifvm:action name="getUGCList"/>',
	        columns:[
	        	  {
		      		  field : 'ridMbr', headerText : 'ridMbr', visible : false,
		      		  customAttributes : {
		      			  index : 'ridMbr' }/* ridmbr */
		      	  },{
		      		  field : 'rid', headerText : 'rid', visible : false,
		      		  customAttributes : {
		      			  index : 'rid' }/* ridEvt*/
		      	  },{
		      		  field : 'mbrNo', headerText : '<spring:message code="M00688"/>', headerTextAlign : 'center', textAlign : 'center', width:'80px',template: "#mbrLinkTemplate",
		      		  customAttributes : {
		      			  index : 'mbrNo'} /* 회원번호 */
		      	  },{
		      		  field : 'custNM', headerText : '<spring:message code="M00850"/>', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'custNM'} /* 회원명 */
		      	  },{
		      		  field : 'status', headerText : '<spring:message code="M02019"/>', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'status'} /* 회원상태 */
		      	  },{
		      		  field : 'stamp', headerText : '<spring:message code="L02587"/>', headerTextAlign : 'center', textAlign : 'center',  width:'80px',
		      		  customAttributes : {
		      			  index : 'stamp'}/*현재 스탬프 수*/
		      	  	},{
		      		  field : 'tot_stamp', headerText : '<spring:message code="L00579"/>', headerTextAlign : 'center', textAlign : 'center',  width:'80px',
		      		  customAttributes : {
		      			  index : 'b.tot_stamp'}/* 총 스탬프*/
		      	  },{
		      		  field : 'total', headerText : '<spring:message code="L02585"/>', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'total'}/* 완료 스탬프*/
		      	  }
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'mbrNo',
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true,
	        tempId : 'ifvGridSimplePageTemplete2'
	    };
	ugcListGrid = $("#ugcListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


//마스킹해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(ugcListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = ugcListGrid.opt.gridControl.getSelectedRecords()[0].ridMbr;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="ugcMbrClearMasking"/>', {
            ridMbr: v_rid
        },
        function(result) {
        	var gridObj = ugcListGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNM'), result.custNM);

        });
    }
}

//다운로드
function ugcListDownload(){
	$.ifvExcelDn('<ifvm:action name="ugcListExport"/>','ugcListGrid');
}


function totAch(){
	$.ifvSyncPostJSON('<ifvm:action name="getUGCAch"/>',{
    	rid : eventRid
		},function(result){
            $('#tot_p').val(result.tot_p);
            $('#tot_cnt').val(result.tot_cnt);
            $('#tot_stmp').val(result.tot_stmp);
            $('#totalCnt').val(result.tot_mbr_cnt);
	});
}

//날짜 셋팅
function dateSet(){
	var date=new Date();
	var currentdate=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
	$('#date').val(currentdate);
}

//사진보기
function ugcDtlFn(){
	ugcDtlPopupOpen();
}

function ugcDtlPopupOpen(){
    if ($.fn.ifvmIsNotEmpty(ugcListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	ugcDtlPopup = {
    	        popup: function () {
    	            $('#ugcDtlPopDiv').ifvsfPopup({
    	                enableModal: true,
    	                enableResize: false,
    	                contentUrl: '<ifvm:url name="mbrUGCDtlPop"/>?rid_evt='+ ridUGCEvt+"&ugcDiv=Y",
    	                contentType: "ajax",
    	                title: "사진보기",
    	                width: '1000px'
    	            });
    	        },
    	        close: function (obj) {
    	        	ugcDtlPopDiv._destroy();
    	        }
    	    }
    	ugcDtlPopup.popup();
    }
    else {
        alert('목록을 선택해주세요.');
    }

}

//부정회원 중복체크
function validUgcLimitMbr(){
	if($.fn.ifvmIsNotEmpty(ugcListGrid.opt.gridControl.getSelectedRecords()[0])){
		var ridMbr = ugcListGrid.opt.gridControl.getSelectedRecords()[0].ridMbr;
		$.ifvSyncPostJSON('<ifvm:action name="validLimitMbr"/>',{
			evtRid : eventRid ,
			ridMbr : ridMbr
		},function(result){
			limitUgcMbrAdd();
		},function(result){
			alert('<spring:message code="L02576"/>');//이미 부정 회원으로 등록되어 있습니다.
		});
	}else{
		alert('<spring:message code="M00854"/>');//대상자를 선택하세요.
	}
}

//부정 등록 팝업 Open
function limitUgcMbrAdd(){
    if ($.fn.ifvmIsNotEmpty(ugcListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	var rid= ugcListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    	var ridMbr= ugcListGrid.opt.gridControl.getSelectedRecords()[0].ridMbr;
    	var mbrStatus= ugcListGrid.opt.gridControl.getSelectedRecords()[0].status;
    	if(mbrStatus == '탈퇴'){
    		alert('<spring:message code="L02577"/>');//탈퇴한 회원입니다.
    	}else{
    		$("#limitUgcAddPop").ifvsfPopup({
  		      enableModal : true,
  		      enableResize: false,
  		      contentUrl: '<ifvm:url name="limitMbrAddPop"/>?ridMbr=' + ridMbr,
  		      contentType: "ajax",
  		      title: '<spring:message code="L02551"/>',/* 부정등록회원 */
  		      width: '400px',
  		      close : 'limitUgcAddPopupClose'
  			});
    	}
    }else {
        alert('<spring:message code="M00854"/>');//대상자를 선택하세요.
    }
}

//부정 등록 팝업 Close
function limitUgcAddPopupClose() {
	limitUgcAddPop._destroy();
}

$(document).ready(function() {

	//날짜 셋팅
	dateSet();

	totAch();

	getUGCList();

	if (typeof evtStatusCd == "undefined" || evtStatusCd == null) {
		$("#clearMaskBtn").prop('disabled',true);
	}

	// 엑셀다운로드
    $('#ugcListDownload').on('click', function() {
    	ugcListDownload();
    });

	// 마스킹 해제
    $('#clearMaskBtn').on('click', function() {
    	clearMaskAction();
    });

 	// 부정 등록 중복체크
	$('#limitUgcMbrAddBtn').on('click', function() {
		validUgcLimitMbr();
    });
});

</script>