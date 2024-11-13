<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script id="orderStatus" type="text/x-jquery-tmpl">

{{if  status=="활성" }}
	{{if leftQty==0}} <div style="color:#FF0000";>{{:orderStatus}} </div>
	{{else soldout<leftQty}} <div>{{:orderStatus}}</div>
	{{else soldout>=leftQty}} <div style="color:#0101DF">{{:orderStatus}} </div>
	
	{{/if}}
{{else}} <div style="color:#BDBDBD";>주문불가</div> 
{{/if}}
</script>
<script id="status" type="text/x-jquery-tmpl">

	{{if  status=="활성" }}
		<div style="color:#FF0000";>{{:status}}</div>
	{{else}}<div>{{:status}}</div>
	{{/if}}
</script>

<script type="text/javascript">
var pointMallGrid;
var rid;


//목록 조회
function getPointMallList(){
    var ejGridOption = {
    	recordDoubleClick : function(args){
    		rid = args.data.rid;
    		qtjs.href('<ifvm:url name="pointMallDetail"/>' + '?rid=' + rid);
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
       	dataUrl : '<ifvm:action name="getPointMallList"/>',
        columns:[ 
        	  {
	      		  field : 'rid', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'lpp.rid' }/* RID */
	      	  },{
	      		  field : 'statusCd', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'lpp.STATUS' }/* statusCd */
	      	  },{
	      		  field : 'tierLimitYn', headerText : '', headerTextAlign : 'center', textAlign : 'center', visible : false, 
	      		  customAttributes : {
	      			  index : 'lpp.TIER_LIMIT_YN' }/* 등급제한 */
	      	  },{
	      		  field : 'prodNo', headerText : '상품번호', headerTextAlign : 'center', textAlign : 'center', width: '100px', 
	      		  customAttributes : {
	      			  index : 'lpp.PROD_NO' }/* 상품번호*/
	      	  },{
	      		  field : 'catNm', headerText : '카테고리', headerTextAlign : 'center', textAlign : 'center',  width: '100px', 
	      		  customAttributes : {
	      			  index : 'lpc.CAT_NM' }/* 카테고리 */
	      	  },{
	      		  field : 'prodNm', headerText : '상품명', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lpp.PROD_NM' }/* 상품명 */
	      	  },{
	      		  field : 'prodCd', headerText : '상품코드', headerTextAlign : 'center',  textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lpp.PROD_CD' }/* 상품코드 */
	      	  }, /*{
	      		  field : 'brdNm', headerText : '브랜드', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lbc.brd_NM' }
	      	  },*/ /* 브랜드 */
	      	    {
	      		  field : 'status', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width: '100px',  template : "#status", 
	      		  customAttributes : {
	      			  index : 'cc1.MARK_NAME' }/* 상태 */
	      	  },{
	      		  field : 'tierLimit', headerText : '<spring:message code="L02613"/>', headerTextAlign : 'center', textAlign : 'center',   width: '100px', 
	      		  customAttributes : {
	      			  index : 'lpp.TIER_LIMIT_YN' }/* 등급제한여부 */
	      	  },{
	      		  field : 'prodQty', headerText : '<spring:message code="L02624"/>', headerTextAlign : 'center', textAlign : 'right', width: '100px',
	      		  customAttributes : {
	      			  index : 'lpp.PROD_QTY' }/*판매수량 */
	      	  },{
	      		  field : 'tranSactionCnt', headerText : '<spring:message code="L02615"/>', headerTextAlign : 'center', textAlign : 'right' , format: '{0:n0}', width: '100px', 
	      		  customAttributes : {
	      			  index : 'tranSactionCnt' }/* 주문수량 */
	      	  },{
	      		  field : 'leftQty', headerText : '<spring:message code="L02625"/>', headerTextAlign : 'center', textAlign : 'right',  width: '100px', 
	      		  customAttributes : {
	      			  index : 'leftQty' }/* 주문가능수량 */
	      	  },{
	      		  field : 'orderStatus', headerText : '주문상태', headerTextAlign : 'center', textAlign : 'center',  width: '100px',  template : "#orderStatus",template : "#orderStatus",
	      		  customAttributes : {
	      			  index : 'orderStatus' }/* 주문상태 */
	      	  }, {
	      		  field : 'regDate', headerText : '등록일시', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : "lpp.REG_DT" }/* 등록일시 */
	      	  },{
	      		  field : 'soldout', headerText : '', headerTextAlign : 'center', textAlign : 'center',   visible : false, 
	      		  customAttributes : {
	      			  index : 'lpp.soldout' }/* statusCd */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : "decode(lpp.STATUS, 'A', 1, 2), lpp.REG_DT",
	      	  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
        autowidth : true ,
        radio : true,
        tempId : 'ifvGridNotSearchTemplete'
    };
    
    pointMallGrid = $("#pointMallGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


//공통 조회 조건 목록 설정
function pointMallAListSearchInit(gridId) {
	$.fn.ifvmSetCommonCondList("pointMallList","LOY_POINT_MALL_001",gridId);
}

//공통 조회 호출
function pointMallAListSearch() {
	
 $.fn.ifvmSubmitSearchCondition("pointMallList", getPointMallList);
	
} 


//삭제
function deletePointMall(){
	var list = pointMallGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].statusCd;
		
		if(!(status == 'W')){
			alert('작성중인 이벤트만 삭제 하실수 있습니다.');
		}else{
			if(!confirm('<spring:message code="C00079" />')) return;
			$.ifvSyncPostJSON('<ifvm:action name="deletePointMall"/>', {
				rid: rid
			}, function(result) {
				alert('<spring:message code="M01266" />');
				getPointMallList();
			});
		}	
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//중지
function stopPointMall(){
	var list = pointMallGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].statusCd;
		
		if (status == 'A') {
			if(!confirm('이벤트를 중지하시겠습니까?')) return;
				
			$.ifvSyncPostJSON('<ifvm:action name="stopPointMall"/>', {
				rid: rid
			}, function(result) {
				alert('중지되었습니다.');
				getPointMallList();
			});
		} else {
			alert('활성중인 이벤트만 중지 하실수 있습니다.');
		} 
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//활성
function startPointMall(){
	var list = pointMallGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].statusCd;
		var tierLimitYn = list[0].tierLimitYn;
		var rtnValue=true;
		
		if (status == 'W' || status == 'S') {
			if(!confirm('이벤트를 활성 하시겠습니까?')) return;
			
			if(tierLimitYn=='Y'){
				$.ifvSyncPostJSON('<ifvm:action name="validPntTierLimit"/>', {
					ridTgtEvt: rid
				}, function(result) {
					rtnValue=true;
				}, function(result){
					alert('<spring:message code="L02622"/>');/* 등급제한을 1개 이상 등록해야 활성하실 수 있습니다. */
					rtnValue=false;
				});
			}
			if(!rtnValue) return;
			
			$.ifvSyncPostJSON('<ifvm:action name="startPointMall"/>', {
				rid: rid
			}, function(result) {
				alert('활성되었습니다.');
				getPointMallList();
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
function finishPointMall(){
	var list = pointMallGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].statusCd;
		
		if (status == 'A' || status == 'S') {
			if(!confirm('이벤트를 종료하시겠습니까?')) return;
				
			$.ifvSyncPostJSON('<ifvm:action name="finishPointMall"/>', {
				rid: rid
			}, function(result) {
				alert('종료되었습니다.');
				getPointMallList();
			});
		} else {
			alert('활성 또는 중지된 이벤트만 종료 하실수 있습니다.');
		}
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//미리보기 팝업 열기
function pointMallPreviewTokenPopOpen() {
    $("#pointMallPreviewTokenPopup").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="pointMallPreviewTokenPop"/>',
        contentType: "ajax",
        title: '미리보기',
        width: '600px',
        close : 'pointMallPreviewTokenPopClose'
    });
}

//미리보기 팝업 닫기
function pointMallPreviewTokenPopClose() {
	pointMallPreviewTokenPopup._destroy();
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
    pointMallAListSearchInit();
	
    pointMallAListSearch();
    
    //조회
    $('#pointMallAListSearchBtn').on('click', function(){
    	pointMallAListSearch();
    });
    
    //초기화
    $("#eventStoreAListClearBtn").on('click', function(){
    	pointMallAListSearchInit("pointMallGrid");
    });
    
    //신규
    $("#eventPlanNewBtn").on('click', function(){
    	qtjs.href('<ifvm:url name="pointMallDetail"/>');
    });
  
    //삭제
    $("#eventPlanRemoveBtn").on('click', function(){
    	deletePointMall();
    });
    
  	//중지
    $("#eventPlanStopBtn").on('click', function(){
    	stopPointMall();
    });
  	
  	//활성
    $("#eventPlanStartBtn").on('click', function(){
    	startPointMall();
    });
  	
  	//종료
    $("#eventStoreFinishBtn").on('click', function(){
    	finishPointMall();
    });
  	
  	//미리보기
    $("#eventPreviewBtn").on('click', function(){
    	pointMallPreviewTokenPopOpen();
    });
  	
});

</script>

<div class="page-title">
    <h1>
     	포인트 상품 등록
        <span>&gt; 포인트 상품 조회 및 등록</span>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="pointMallAListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="eventStoreAListClearBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="pointMallList"></div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
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
    <div id="pointMallGrid" class="white_bg grid_bd0 grid_scroll5"></div>     
</div>
<div id="pointMallPreviewTokenPopup" class="popup_container"></div>