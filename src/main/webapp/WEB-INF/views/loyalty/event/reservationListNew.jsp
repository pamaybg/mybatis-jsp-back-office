<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script id="status" type="text/x-jquery-tmpl">

	{{if  statusCd=="활성" }}
		<div style="color:#FF0000";>{{:statusCd}}</div>
	{{else}}<div>{{:statusCd}}</div>
	{{/if}}
</script>

<script type="text/javascript">
var reservationGrid;
var rid;

//목록 조회
function getReservationList(){
    var ejGridOption = {
    	recordDoubleClick : function(args){
    		rid = args.data.rid;
    		qtjs.href('<ifvm:url name="reservationDetail"/>' + '?rid=' + rid);
    	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},
       	rowSelected : function(args){
       		rid = args.data.rid;
       	},
       	dataUrl : '<ifvm:action name="getReservationList"/>',
        columns:[ 
        	  {
	      		  field : 'rid', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'lr.rid' }/* RID */
	      	  },{
	      		  field : 'placeNm', headerText : '<spring:message code="L02558" />', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'lr.place_Nm' }/* 예약명 */
	      	  },{
	      		  field : 'statusCd', headerText : '<spring:message code="L02559" />', headerTextAlign : 'center', textAlign : 'center', width : '50px', template : "#status", 
	      		  customAttributes : {
	      			  index : 'cc1.mark_name' }/*상태 */
	      	  },{
	      		  field : 'dpSeq', headerText : '<spring:message code="L02560" />', headerTextAlign : 'center', textAlign : 'center', width : '30px',
	      		  customAttributes : {
	      			  index : 'lr.dp_seq' }/*순서 */
	      	  },{
	      		  field : 'createBy', headerText : '<spring:message code="L02561" />', headerTextAlign : 'center', textAlign : 'center', width : '30px',
	      		  customAttributes : {
	      			  index : 'ee.name' }/* 작성자 */
	      	  },{
	      		  field : 'regDt', headerText : '<spring:message code="L01766" />', headerTextAlign : 'center', textAlign : 'center', width : '70px',
	      		  customAttributes : {
	      			  index : 'lr.reg_dt' }/* 등록일자  */
	      	  },{
	      		  field : 'status', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'lr.status' }/*상태 */
	      	  }
    	],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : "decode(lr.status, 'A', 1, 2), lr.reg_dt",
	      	  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
        autowidth : true ,
        radio : true,
        tempId : 'ifvGridSimplePageTemplete2'
    };
    
    reservationGrid = $("#reservationGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function reservationAListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("reservationSearchList","LOY_RESERVATION_001",gridId);
}

//공통 조회 호출
function reservationAListSearch() {
    $.fn.ifvmSubmitSearchCondition("reservationSearchList", getReservationList);
} 

//삭제
function deleteReservation(){
	var list = reservationGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].status;
		
		if(!(status == 'W')){
			alert('작성중인 이벤트만 삭제 하실수 있습니다.');
		}else{
			if(!confirm('<spring:message code="C00079" />')) return;
			$.ifvSyncPostJSON('<ifvm:action name="deleteReservation"/>', {
				rid: rid
			}, function(result) {
				alert('<spring:message code="M01266" />');
				getReservationList();
			});
		}	
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//중지
function stopReservation(){
	var list = reservationGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].status;
		
		if (status == 'A') {
			if(!confirm('이벤트를 중지하시겠습니까?')) return;
				
			$.ifvSyncPostJSON('<ifvm:action name="stopReservation"/>', {
				rid: rid
			}, function(result) {
				alert('중지되었습니다.');
				getReservationList();
			});
		} else {
			alert('활성중인 이벤트만 중지 하실수 있습니다.');
		} 
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//활성
function startReservation(){
	var list = reservationGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].status;
		
		if (status == 'W' || status == 'S') {
			if(!confirm('이벤트를 활성 하시겠습니까?')) return;
				
			$.ifvSyncPostJSON('<ifvm:action name="startReservation"/>', {
				rid: rid
			}, function(result) {
				alert('활성되었습니다.');
				getReservationList();
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
function finishReservation(){
	var list = reservationGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].status;
		
		if (status == 'A' || status == 'S') {
			if(!confirm('이벤트를 종료하시겠습니까?')) return;
				
			$.ifvSyncPostJSON('<ifvm:action name="finishReservation"/>', {
				rid: rid
			}, function(result) {
				alert('종료되었습니다.');
				getReservationList();
			});
		} else {
			alert('활성 또는 중지된 이벤트만 종료 하실수 있습니다.');
		}
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//미리보기 팝업 열기
function reservationPreviewTokenPopOpen() {
    $("#reservationPreviewTokenPopup").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="reservationPreviewTokenPop"/>',
        contentType: "ajax",
        title: '미리보기',
        width: '600px',
        close : 'reservPreviewTokenPopClose'
    });
}

//미리보기 팝업 닫기
function reservPreviewTokenPopClose() {
	reservationPreviewTokenPopup._destroy();
}


$(document).ready(function() {
    
    //공통 조회 조건 목록 설정
    reservationAListSearchInit();
	
    reservationAListSearch();
    
    //조회
    $('#reservationAListSearchBtn').on('click', function(){
    	reservationAListSearch();
    });
    
    //초기화
    $("#reservationAListClearBtn").on('click', function(){
    	reservationAListSearchInit("reservationGrid");
    });
    
    //신규
    $("#reservationNewBtn").on('click', function(){
    	qtjs.href('<ifvm:url name="reservationDetailList"/>');
    });
  
    //삭제
    $("#reservationRemoveBtn").on('click', function(){
    	deleteReservation();
    });
    
  	//중지
    $("#reservationStopBtn").on('click', function(){
    	stopReservation();
    });
  	
  	//활성
    $("#reservationStartBtn").on('click', function(){
    	startReservation();
    });
  	
  	//종료
    $("#reservationFinishBtn").on('click', function(){
    	finishReservation();
    });
  	
  	//미리보기
    $("#reservationPreviewBtn").on('click', function(){
    	reservationPreviewTokenPopOpen();
    });
  	
});

</script>

<div class="page-title">
    <h1>
     	이벤트 기획/실행
        <span>&gt; VIP 예약서비스</span>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reservationAListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="reservationAListClearBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="reservationSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="L00743" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id='reservationPreviewBtn'><%-- 미리보기 --%>
                <spring:message code="L01442" />
            </button>
            <button class="btn btn-sm" id="reservationNewBtn"><%-- 신규 --%>
                <spring:message code="M00274" />
            </button>
            <button class="btn btn-sm" id='reservationRemoveBtn'><%-- 삭제 --%>
                <spring:message code="M00165" />
            </button>
            <button class="btn btn-sm" id='reservationStopBtn'><%-- 중지 --%>
                <spring:message code="M02154" />
            </button>
            <button class="btn btn-sm" id='reservationStartBtn'><%-- 활성 --%>
                <spring:message code="L00430" />
            </button>
            <button class="btn btn-sm" id='reservationFinishBtn' style='background: red; border-color: red;'><%-- 종료 --%>
                <spring:message code="M00750" />
            </button>
        </div>
    </div>
    <div id="reservationGrid" class="white_bg grid_bd0 grid_scroll5"></div>     
</div>
<div id="reservationPreviewTokenPopup" class="popup_container"></div>