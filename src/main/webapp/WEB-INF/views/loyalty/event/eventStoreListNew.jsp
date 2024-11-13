<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script id="status" type="text/x-jquery-tmpl">
	{{if  storeStatus=="활성" }}
		<div style="color:#FF0000";>{{:storeStatus}}</div>
	{{else}}<div>{{:storeStatus}}</div>
	{{/if}}
</script>
<script type="text/javascript">
var eventStoreGrid;
var rid;

//목록 조회
function getEventStoreList(){
    var ejGridOption = {
    	recordDoubleClick : function(args){
    		rid = args.data.storeRid;
    		qtjs.href('<ifvm:url name="eventStoreDetail"/>' + '?rid=' + rid);
    	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},
       	rowSelected : function(args){
       		rid = args.data.storeRid;
       	},
       	dataUrl : '<ifvm:action name="getEventStoreList"/>',
        columns:[ 
        	  {
	      		  field : 'storeRid', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'ls.RID' }/* 스토어RID */
	      	  },{
	      		  field : 'storeTypeCd', headerText : '스토어 유형 코드', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'ls.STORE_TYPE' }/* 스토어 유형 코드 */
	      	  },{
	      		  field : 'storeType', headerText : '유형', headerTextAlign : 'center', textAlign : 'center', width : '70px' ,
	      		  customAttributes : {
	      			  index : 'cc1.MARK_NAME' }/* 스토어 유형 */
	      	  },{
	      		  field : 'storeEvtNm', headerText : 'glo shop 명', headerTextAlign : 'center', textAlign : 'left', width : '350px' ,
	      		  customAttributes : {
	      			  index : 'storeEvtNm' }/* 이달의 스토어 명 */
	      	  },{
	      		  field : 'storeStatusCd', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'ls.STORE_STATUS_CD' }/* 상태 코드 */
	      	  },{
	      		  field : 'storeStatus', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width : '50px' ,template : "#status",
	      		  customAttributes : {
	      			  index : 'cc2.MARK_NAME' }/* 상태 */
	      	  },{
	      		  field : 'actStartDt', headerText : '시작일', headerTextAlign : 'center', textAlign : 'center', width : '70px' ,
	      		  customAttributes : {
	      			  index : 'ls.ACT_START_DT' }/* 시작일시 */
	      	  },{
	      		  field : 'actEndDt', headerText : '종료일', headerTextAlign : 'center', textAlign : 'center', width : '70px' ,
	      		  customAttributes : {
	      			  index : 'ls.ACT_END_DT' }/* 종료일시 */
	      	  },{
	      		  field : 'storeTxnCnt', headerText : '거래건수', headerTextAlign : 'center', textAlign : 'right', format: '{0:n0}' , width : '60px' ,
	      		  customAttributes : {
	      			  index : 'storeTxnCnt' }/* 스토어 건수 */
	      	  },{
	      		  field : 'totPoint', headerText : '총포인트', headerTextAlign : 'center', textAlign : 'right', format: '{0:n0}' , width : '60px' ,
	      		  customAttributes : {
	      			  index : 'totPoint' }/* 총포인트 */
	      	  },{
	      		  field : 'mbrCnt', headerText : '회원수', headerTextAlign : 'center', textAlign : 'right', format: '{0:n0}' , width : '60px' ,
	      		  customAttributes : {
	      			  index : 'mbrCnt' }/* 회원수 */
	      	  },{
	      		  field : 'createDate', headerText : '생성일시', headerTextAlign : 'center', textAlign : 'center', width : '80px' ,
	      		  customAttributes : {
	      			  index : 'ls.CREATE_DATE' }/* 생성일시 */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : "decode(ls.STORE_STATUS_CD, 'A', 1, 2), ls.ACT_START_DT",
	      	  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
        autowidth : true ,
        radio : true,
        tempId : 'ifvGridNotSearchTemplete'
    };
    
    eventStoreGrid = $("#eventStoreGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function eventStoreAListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("eventPlanExcutionList","LOY_EVT_STORE_01",gridId);
}

//공통 조회 호출
function eventStoreAListSearch() {
    $.fn.ifvmSubmitSearchCondition("eventPlanExcutionList", getEventStoreList);
} 

//삭제
function deleteEventStore(){
	var list = eventStoreGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].storeRid;
		var status = list[0].storeStatusCd;
		
		if(!(status == 'W')){
			alert('작성중인 이벤트만 삭제 하실수 있습니다.');
		}else{
			if(!confirm('<spring:message code="C00079" />')) return;
			$.ifvSyncPostJSON('<ifvm:action name="deleteEventStore"/>', {
				rid: rid
			}, function(result) {
				alert('<spring:message code="M01266" />');
				getEventStoreList();
			});
		}	
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//중지
function stopEventStore(){
	var list = eventStoreGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].storeRid;
		var status = list[0].storeStatusCd;
		
		if (status == 'A') {
			if(!confirm('이벤트를 중지하시겠습니까?')) return;
				
			$.ifvSyncPostJSON('<ifvm:action name="stopEventStore"/>', {
				rid: rid
			}, function(result) {
				alert('중지되었습니다.');
				getEventStoreList();
			});
		} else {
			alert('활성중인 이벤트만 중지 하실수 있습니다.');
		} 
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//활성
function startEventStore(){
	var list = eventStoreGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].storeRid;
		var status = list[0].storeStatusCd;
		var storeTypeCd = list[0].storeTypeCd;
		
		if (status == 'W' || status == 'S') {
			if(!confirm('이벤트를 활성 하시겠습니까?')) return;
				
			$.ifvSyncPostJSON('<ifvm:action name="startEventStore"/>', {
				rid: rid
			   ,storeTypeCd : storeTypeCd
			}, function(result) {
				alert('활성되었습니다.');
				getEventStoreList();
			}, function(result){
				alert(result.message);
				return;
			});
		} else {
			alert('작성 또는 중지된 이벤트만 활성 하실수 있습니다.');
		}
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//종료
function finishEventStore(){
	var list = eventStoreGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].storeRid;
		var status = list[0].storeStatusCd;
		
		if (status == 'A' || status == 'S') {
			if(!confirm('이벤트를 종료하시겠습니까?')) return;
				
			$.ifvSyncPostJSON('<ifvm:action name="finishEventStorePlan"/>', {
				rid: rid
			}, function(result) {
				alert('종료되었습니다.');
				getEventStoreList();
			});
		} else {
			alert('활성 또는 중지된 이벤트만 종료 하실수 있습니다.');
		}
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//미리보기 팝업 열기
function eventPreviewTokenPopOpen() {
    $("#eventPreviewTokenPopup").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="eventStorePreviewTokenPop"/>',
        contentType: "ajax",
        title: '미리보기',
        width: '600px',
        close : 'eventPreviewTokenPopClose'
    });
}

//미리보기 팝업 닫기
function eventPreviewTokenPopClose() {
	eventPreviewTokenPopup._destroy();
}

//url 복사
function copyUrl() {
	var list = eventStoreGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		var rid = list[0].storeRid;
		var copyText = 'https://www.glolive.co.kr/always-on/glo_shop/' + rid;
		copyToClipboard(copyText);
		alert('url이 복사되었습니다');
	} else {
		alert('목록을 선택해 주세요.');
	}
}

function copyToClipboard(val) {
	  var t = document.createElement("textarea");
	  document.body.appendChild(t);
	  t.value = val;
	  if (navigator.userAgent.match(/ipad|ipod|iphone/i)) {
		  // save current contentEditable/readOnly status
		  var editable = t.contentEditable;
		  var readOnly = t.readOnly;
		  
		  // convert to editable with readonly to stop iOS keyboard opening
		  t.contentEditable = true;
		  t.readOnly = true;
		  
		  // create a selectable range
		  var range = document.createRange();
		  range.selectNodeContents(t);

		  // select the range
		  var selection = window.getSelection();
		  selection.removeAllRanges();
		  selection.addRange(range);
		  t.setSelectionRange(0, 999999);

		  // restore contentEditable/readOnly to original state
		  t.contentEditable = editable;
		  t.readOnly = readOnly;
	  } else {
		  t.select();
	  }
	  document.execCommand('copy');
	  document.body.removeChild(t);
}

$(document).ready(function() {
    
    //공통 조회 조건 목록 설정
    eventStoreAListSearchInit();
	
    eventStoreAListSearch();
    
    //조회
    $('#eventStoreAListSearchBtn').on('click', function(){
    	eventStoreAListSearch();
    });
    
    //초기화
    $("#eventStoreAListClearBtn").on('click', function(){
    	eventStoreAListSearchInit('eventStoreGrid');
    });
    
    //신규
    $("#eventPlanNewBtn").on('click', function(){
    	qtjs.href('<ifvm:url name="eventStoreDetail"/>');
    });
  
    //삭제
    $("#eventPlanRemoveBtn").on('click', function(){
    	deleteEventStore();
    });
    
  	//중지
    $("#eventPlanStopBtn").on('click', function(){
    	stopEventStore();
    });
  	
  	//활성
    $("#eventPlanStartBtn").on('click', function(){
    	startEventStore();
    });
  	
  	//종료
    $("#eventStoreFinishBtn").on('click', function(){
    	finishEventStore();
    });
  	
  	//미리보기
    $("#eventPreviewBtn").on('click', function(){
    	eventPreviewTokenPopOpen();
    });
  	
  	//URL 복사
  	$("#copyUrlBtn").on('click', function() {
  		copyUrl();
  	});
});

</script>

<div class="page-title">
    <h1>
     	GLO SHOP
        <span>&gt; SHOP 조회 및 등록</span>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="eventStoreAListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="eventStoreAListClearBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="eventPlanExcutionList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
       		<%-- <button class="btn btn-sm" id="copyUrlBtn">URL 복사
                <spring:message code="D10257" />
            </button> --%>
            <button class="btn btn-sm" id='eventPreviewBtn'><%-- 미리보기 --%>
                <spring:message code="L01442" />
            </button>
            <button class="btn btn-sm" id="eventPlanNewBtn"><%-- 신규 --%>
                <spring:message code="M00274" />
            </button>
            <button class="btn btn-sm" id='eventPlanRemoveBtn'><%-- 삭제 --%>
                <spring:message code="M00165" />
            </button>
            <button class="btn btn-sm" id='eventPlanStopBtn'><%-- 중지 --%>
                <spring:message code="M02154" />
            </button>
            <button class="btn btn-sm" id='eventPlanStartBtn'><%-- 활성 --%>
                <spring:message code="L00430" />
            </button>
            <button class="btn btn-sm" id='eventStoreFinishBtn' style='background: red; border-color: red;'><%-- 종료 --%>
                <spring:message code="M00750" />
            </button>
        </div>
    </div>
    <div id="eventStoreGrid" class="white_bg grid_bd0 grid_scroll5"></div>     
</div>
<div id="eventPreviewTokenPopup" class="popup_container"></div>