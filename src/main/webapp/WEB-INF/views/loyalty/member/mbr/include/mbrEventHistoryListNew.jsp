<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-5">
        </div>
        <div class="col-xs-7 searchbtn_r">
        	<ifvm:inputNew type="button"   btnType="search"  text="UGC이력" nuc="true"  id="ugcHistListBtn" btnFunc="ugcHistListFn"/> <!-- UGC이력 -->
        	<button class="btn btn-sm" id="pollAttendBtn">
	        	<spring:message code="L02604"/><!-- glo Choice 참여 -->
	        </button>
	        <button class="btn btn-sm" id="AttendHistBtn">
	        	<spring:message code="L02521"/><!-- 출석체크 -->
	        </button>
        </div>
    </div>
    <div id="mbrEventHistoryListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="pointCouponPop" class="popup_container"></div>
<div id="attendContainer" class="popup_container"></div><!-- 출석체크 팝업 -->
<div id="pollAttendContainer" class="popup_container"></div><!-- poll참여 팝업 -->
<div id="ugcHistListContainer" class="popup_container"></div><!-- ugc이력 팝업 -->

<script type="text/javascript">

var mbrEventHistoryList;

var mbrEventHistoryObj = {
	//스탬프 이력 그리드
	initMbrEventHistoryList : function(data) {
		var ejGridOption = {
	       	serializeGridData : function(data) {
	       	data.ridMbr = mbr_rid;
	       	},
	        loadComplete : function(data){
	        	var dataLength= data.getCurrentViewData().length;
	        	if(dataLength>0){//현재 그리드에 데이터가 있는 경우
		        	for(var i=0; i<dataLength; i++){
		        		if(data.getCurrentViewData()[i].applctUrl != null){
		        			//그리드의 applctUrl text를 'URL 이동'으로 변경
		        			data.setCellText(i, mbrEventHistoryList.opt.gridControl.getColumnIndexByField('applctUrl'), '<spring:message code="L02605"/>');
		        			var eventNo=data.getCurrentViewData()[i].eventNo;
		        			//URL이 있는 경우에 스타일 변경
		        			$('#'+eventNo).attr('style','color: blue; cursor:pointer; text-decoration: underline; text-align: center;');
		        			//URL이 있는 경우에 click이벤트 추가
		        			$('#'+eventNo).attr('onclick','transUrl('+i+')');
		        		}
		        	}
	        	}
	        },
	        dataUrl : '<ifvm:action name="getMbrEventHistoryList"/>',
	        columns:[
	        		{
	         		  field : 'eventNo', headerText : '이벤트 번호', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'T1.EVT_NO' }
	         	  },{
	         		  field : 'eventTypeCd', headerText : '이벤트 유형', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 't4.MARK_NAME' }
	         	  },{
	         		  field : 'eventCategory', headerText : '이벤트 카테고리', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 't5.MARK_NAME' }
	         	  },{
	         		  field : 'evtNm', headerText : '이벤트명', headerTextAlign : 'center', textAlign : 'left',
	         		  customAttributes : {
	         			  index : 't1.EVT_NM' }
	         	  },{
	         		  field : 'applctUrl', headerText : '응모 URL', headerTextAlign : 'center', textAlign : 'center' ,
	         		  customAttributes : {
	         			  searchable : false,
	         			  index : 't2.applct_url', id: '{{:eventNo}}'}
	         	  },{
	         		  field : 'evtStartDt', headerText : '시작일시', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 't1.APPLY_START_DT ' }
	         	  },{
	         		  field : 'evtEndDt', headerText : '종료일시', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 't1.APPLY_END_DT' }
	         	  },{
	         		  field : 'applctDt', headerText : '응모일시', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 't2.APPLCT_DT' }
	         	  },{
	         		  field : 'applTicketCnt', headerText : '응모티켓수', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 't2.APPLCT_TICKET_CNT' }
	         	  },{
	         		  field : 'winYn', headerText : '당첨여부', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'T3.RID_MBR' }
	         	  },{
	         		  field : 'bnfYn', headerText : '혜택지급여부', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 't3.BNF_YN' }
	         	  },{
	         		  field : 'bnfTypecd', headerText : '혜택유형', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 't6.mark_name' }
	         	  },{
	         		  field : 'bnfDt', headerText : '혜택지급일시', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 't3.BNF_DT' }
	         	  }
	         ],
	         requestGridData : {
	        	 nd   : new Date().getTime(),
	        	 rows : 10,
	        	 sidx : 't2.APPLCT_DT',
	        	 sord : 'desc',
	        	 _search : false
			},
			radio : true
	    }

		mbrEventHistoryList = $("#mbrEventHistoryListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	}
}

function transUrl(i){
		url = mbrEventHistoryList.opt.gridControl.model.currentViewData[i].applctUrl;
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
}

//ugc이력 팝업
function ugcHistListFn(){
	ugcHistListPopupOpen();
}

function ugcHistListPopupOpen(){
	ugcHistListPopup = {
	        popup: function () {
	            $('#ugcHistListContainer').ifvsfPopup({
	                enableModal: true,
	                enableResize: false,
	                contentUrl: '<ifvm:url name="mbrUGCHistListNew"/>',
	                contentType: "ajax",
	                title: "상세이력",
	                width: '1000px'
	            });
	        },
	        close: function (obj) {
	        	ugcHistListContainer._destroy();
	        }
	    }
	ugcHistListPopup.popup();
}

//poll참여 팝업Open
function pollAttendPop(){
	$("#pollAttendContainer").ifvsfPopup({
    	enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrPollPrtcpStts"/>',
        contentType: "ajax",
        title: '<spring:message code="L02604"/>',/* glo Choice 참여 */
        width: '1000px',
        close : 'pollAttendPopClose'
        });
}

//poll참여 팝업Close
function pollAttendPopClose() {
	pollAttendContainer._destroy();
}

//출석체크 팝업Open
function attendHistPop(){
	$("#attendContainer").ifvsfPopup({
    	enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrAttendEventHistListNew"/>',
        contentType: "ajax",
        title: '<spring:message code="L02521"/>',/* 출석체크 */
        width: '1000px',
        close : 'attendHistPopClose'
        });
}

//출석체크 팝업Close
function attendHistPopClose() {
	attendContainer._destroy();
}

$(document).ready(function(){
	mbrEventHistoryObj.initMbrEventHistoryList();
	window.top.setParentIframeHeight();

 	// 출석체크 버튼 클릭
    $('#AttendHistBtn').on('click', function() {
    	attendHistPop();
    });

 	// poll참여 버튼 클릭
    $('#pollAttendBtn').on('click', function() {
    	pollAttendPop();
    });

});

</script>