<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
 <script id="evtStatusTemplate" type="text/x-jquery-tmpl">
{{if  evtStatus=="활성" }}
	<div style="color:#FF0000";>{{:evtStatus}}</div>
{{else}}
	{{:evtStatus}}
{{/if}}
</script>

<!-- 이벤트 유형별 span 태그 텍스트 설정 -->
<script id="evtSpanItem" type="text/x-jquery-tmpl">    
{{if eventTypeCd == 'MONTHLY'}}
	&gt; 응모/참여형(Monthly Rewards)
{{else (eventTypeCd == 'ONAIR')}}
	&gt; 이벤트 조회 및 등록(glo™ On Air)
{{else (eventTypeCd == 'UGC')}}
	&gt; 이벤트 조회 및 등록(Share Your glo™)
{{else (eventTypeCd == 'SNS')}}
	&gt; 이벤트 조회 및 등록(SNS Share)
{{else (eventTypeCd == 'GIFT')}}
	&gt; 이벤트 조회 및 등록(Gift)
{{else}}	
	&gt; 응모/참여형
{{/if}} 
</script>

<script type="text/javascript">
var eventTypeCd =  '<%= cleanXss(request.getParameter("eventTypeCd")) %>';
if(eventTypeCd == "null") eventTypeCd = null;
var eventPlanExcutionGrid;
var rid; 

//목록 조회
function getEventPlanExcutionList(){
    var ejGridOption = { 
    	recordDoubleClick : function(args){
    		rid = args.data.rid;
    		qtjs.href('<ifvm:url name="eventPlanExcutionDetail"/>' + '?rid=' + rid + '&eventTypeCd=' + eventTypeCd);
    	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }
      		data.eventType = eventTypeCd;
            return data;
       	},
       	loadComplete : function(data){
       		if(eventTypeCd!=null && eventTypeCd!='MONTHLY'){
       			eventPlanExcutionGrid.opt.gridControl.hideColumns("winCmpltDt");//당첨완료여부 hide
       			eventPlanExcutionGrid.opt.gridControl.hideColumns("winCmpltYn");//당첨완료일시 hide
       		}
		},
       	rowSelected : function(args){
       		rid = args.data.rid;
       		/* if(args.data.evtType=='Monthly Rewards'){
       			$('#setEventWinCmpltBtn').prop('disabled',false);
       		}else{
       			$('#setEventWinCmpltBtn').prop('disabled',true);
       		} */
       	},
       	dataUrl : '<ifvm:action name="getEventPlanExcutionList"/>',
        columns:[ 
        	  {
	      		  field : 'evtNo', headerText : '번호', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 't1.EVT_NO' }/* 번호 */
	      	  },{
	      		  field : 'evtType', headerText : '유형', headerTextAlign : 'center', textAlign : 'center',width:'130px',
	      		  customAttributes : {
	      			  index : 't2.mark_name' }/* 유형 */
	      	  },{
	      		  field : 'evtCatNm', headerText : '상세유형', headerTextAlign : 'center', textAlign : 'center',width:'130px',
	      		  customAttributes : {
	      			  index : 'evtCatcd' }/* 유형 */
	      	  },{
	      		  field : 'evtNm', headerText : '이벤트 명', headerTextAlign : 'center', textAlign : 'left', width : '350px',
	      		  customAttributes : {
	      			  index : 't1.evt_nm' }/* 이벤트명 */
	      	  },{
	      		  field : 'evtStatus', headerText : '상태', headerTextAlign : 'center', width:'80px',textAlign : 'center', template: "#evtStatusTemplate",
	      		  customAttributes : {
	      			  index : 't1.evt_status_cd' }/* 상태 */
	      	  },{
	      		  field : 'evtStartDt', headerText : '시작일', headerTextAlign : 'center', textAlign : 'center',width:'110px',
	      		  customAttributes : {
	      			  index : 't1.apply_start_dt' }/* 시작일 */
	      	  },{
	      		  field : 'evtEndDt', headerText : '종료일', headerTextAlign : 'center', textAlign : 'center',width:'110px',
	      		  customAttributes : {
	      			  index : 't1.apply_end_dt' }/* 종료일 */
	      	  },{
	      		  field : 'evtApplCnt', headerText : '<spring:message code="L02643"/>', headerTextAlign : 'center', textAlign : 'center',width:'80px', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'evtApplCnt' }/* 참여건수 */
	      	  },{
	      		  field : 'evtWinnerCnt', headerText : '<spring:message code="당첨건수"/>', headerTextAlign : 'center', textAlign : 'center',width:'80px', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'evtApplCnt' }/* 참여건수 */
	      	  },{
	      		  field : 'createDate', headerText : '등록일시', headerTextAlign : 'center', textAlign : 'center',width:'150px',
	      		  customAttributes : {
	      			  index : 't1.create_date' }/* 당첨완료일시 */
	      	  },{
	      		  field : 'modifyDate', headerText : '수정일시', headerTextAlign : 'center', textAlign : 'center',width:'150px',
	      		  customAttributes : {
	      			  index : 't1.modify_date' }/* 당첨완료일시 */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 't1.rid' }/* rid */
	      	  },{
	      		  field : 'evtStatusCd', headerText : 'evtStatusCd', visible : false,
	      		  customAttributes : {
	      			  index : '' }/* rid */
	      	  },{
	      		  field : 'tierLimitYn', headerText : '', visible : false,
	      		  customAttributes : {
	      			  index : 't1.TIER_LIMIT_YN' }/* tierLimitYn */
	      	  },{
		          field : 'mainImageYn', headerText : '', visible : false,
		          customAttributes : {
		              index : 't1.MAIN_IMG' }/* mainImageYn */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : "decode(t1.evt_status_cd, 'A', 1, 2), t1.apply_start_dt",
	      	  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
        autowidth : true ,
        radio : true,
        tempId : 'ifvGridNotSearchTemplete'
    };
    
    eventPlanExcutionGrid = $("#eventPlanExcutionGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function shareSnsContentAListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("eventPlanExcutionList","EVENT_PLAN_01",gridId);
    startDateInitialize();
}

//공통 조회 호출
function shareSnsContentAListSearch() {
    $.fn.ifvmSubmitSearchCondition("eventPlanExcutionList", getEventPlanExcutionList);
} 

//이벤트시작일 startDate를 3개월 날짜값으로 초기화해주기
function startDateInitialize(){ 
	var EndDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .end_date input').val());
	
	var month = EndDate.getMonth();
	var year = EndDate.getFullYear();
	var day = EndDate.getDate();
	EndDate.setHours(0, 0, 0, 0);

	var dates = new Date();
	dates.setYear(year);
	dates.setMonth(month-2);
	dates.setDate(day);
	dates.setHours(0, 0, 0, 0);
	dates = getFormatDate(dates);
	
	$('.changeTypeAreaCode .start_date input').val(dates)
}

function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}

//삭제
function delEventPlan(){
	var list = eventPlanExcutionGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].evtStatusCd;
		
		if(!(status == 'W')){
			alert('작성중인 이벤트만 삭제 하실수 있습니다.');
		}else{
			if(!confirm('<spring:message code="C00079" />')) return;
			$.ifvSyncPostJSON('<ifvm:action name="deleteEventPlan"/>', {
				rid: rid
			}, function(result) {
				alert('<spring:message code="M01266" />');
				getEventPlanExcutionList();
			});
		}	
	} else {
		alert('<spring:message code="E00099" />');
	}
}

//중지
function stopEventPlan(){
	var list = eventPlanExcutionGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].evtStatusCd;
		
		if (status == 'A') {
			if(!confirm('이벤트를 중지하시겠습니까?')) return;
				
			$.ifvSyncPostJSON('<ifvm:action name="updateStopEventPlan"/>', {
				rid: rid
			}, function(result) {
				alert('중지되었습니다.');
				getEventPlanExcutionList();
			});
		} else {
			alert('활성중인 이벤트만 중지 하실수 있습니다.');
		} 
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//활성
function startEventPlan(){
	var list = eventPlanExcutionGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].evtStatusCd;
		var rtnValue=true;
		var evtType = list[0].evtType;
		var tierLimitYn = list[0].tierLimitYn;
        var mainImageYn = list[0].mainImageYn;
		
		if (status == 'W' || status == 'S') {
			if(!confirm('이벤트를 활성 하시겠습니까?')) return;
			
			if(evtType=='UGC' && tierLimitYn=='Y'){
				$.ifvSyncPostJSON('<ifvm:action name="validPntTierLimit"/>', {
					ridTgtEvt: rid
				}, function(result) {
					rtnValue=true;
				}, function(result){
					alert('<spring:message code="L02622"/>');/* 등급제한을 1개 이상 등록해야 활성하실 수 있습니다. */
					rtnValue=false;
				});
			}
			
            if(evtType=='On Air' && mainImageYn=='N'){
                rtnValue=false;
                alert('<spring:message code="L02623"/>');/* 메인이미지를 등록해야 활성하실 수 있습니다. */
            }
            
			if(!rtnValue) return;
			
			$.ifvSyncPostJSON('<ifvm:action name="updateStartEventPlan"/>', {
				rid: rid
			}, function(result) {
				alert('활성되었습니다.');
				getEventPlanExcutionList();
			});
		} else {
			alert('작성 또는 중지된 이벤트만 활성 하실수 있습니다.');
		}
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//중지
function finishEventPlan(){
	var list = eventPlanExcutionGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].evtStatusCd;
		
		if (status == 'A' || status == 'S') {
			if(!confirm('이벤트를 종료하시겠습니까?')) return;
				
			$.ifvSyncPostJSON('<ifvm:action name="updateFinishEventPlan"/>', {
				rid: rid
			}, function(result) {
				alert('종료되었습니다.');
				getEventPlanExcutionList();
			});
		} else {
			alert('활성 또는 중지된 이벤트만 종료 하실수 있습니다.');
		}
	} else {
		alert('목록을 선택해 주세요.');
	}
}

//이벤트 당첨 완료
function setEventWinCmplt(){
	var list = eventPlanExcutionGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var rid = list[0].rid;
		var status = list[0].evtStatusCd;
		
		if (status == 'A' || status == 'E') {
			if(!confirm('당첨을 완료 하시겠습니까?')) return;
				
			$.ifvSyncPostJSON('<ifvm:action name="setEventWinCmplt"/>', {
				rid: rid
			}, function(result) {
				/* $.ifvSyncPostJSON('<ifvm:action name="InsertMbrMsg"/>', {
					rid  : rid,
					type : "EVT_WIN"
				},function(result) {
					
				}); */
				alert('당첨 완료 되었습니다.');
				getEventPlanExcutionList();
			});
		} else {
			alert('활성 또는 종료된 이벤트만 당첨 완료 하실수 있습니다.');
		}
	} else {
		alert('목록을 선택해 주세요.');
	}
}


//url 복사
function copyUrl() {
	var list = eventPlanExcutionGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		var rid = list[0].rid;

		var copyText = 'https://www.glolive.co.kr/playground/rewards_detail/' + rid;
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
    
	if(eventTypeCd!=null){
		$("[class^=active]").each(function() {
			  $(this).removeClass("active");
		});
		$('#eventPlanExcution\\?eventTypeCd\\='+eventTypeCd).addClass('active')
	}
	
	/* if(eventTypeCd=='MONTHLY' || eventTypeCd==null){
		$('#setEventWinCmpltBtn').show();
	}else{
		$('#setEventWinCmpltBtn').hide();
	} */

	$('#evtSpanItem').tmpl(eventTypeCd).appendTo('#evtSpan');//이벤트 유형별 span 태그 텍스트 설정

    //공통 조회 조건 목록 설정
    shareSnsContentAListSearchInit();
	
    shareSnsContentAListSearch();
    
    //조회
    $('#eventPlanExcutionAListSearchBtn').on('click', function(){
    	shareSnsContentAListSearch();
    });
    
    //초기화
    $("#eventPlanExcutionAListClearBtn").on('click', function(){
    	shareSnsContentAListSearchInit('eventPlanExcutionGrid');
    });
    
    //신규
    $("#eventPlanNewBtn").on('click', function(){
    	qtjs.href('<ifvm:url name="eventPlanExcutionDetail"/>'+'?eventTypeCd='+eventTypeCd);
    });
  
    //삭제
    $("#eventPlanRemoveBtn").on('click', function(){
    	delEventPlan();
    });
    
  	//중지
    $("#eventPlanStopBtn").on('click', function(){
    	stopEventPlan();
    });
  	
  	//활성
    $("#eventPlanStartBtn").on('click', function(){
    	startEventPlan();
    });
  	
  	//종료
    $("#finishEventPlanBtn").on('click', function(){
    	finishEventPlan();
    });
  	
  	//당첨 완료
    $("#setEventWinCmpltBtn").on('click', function(){
    	setEventWinCmplt();
    });
  	
  	//URL 복사
  	$("#copyUrlBtn").on('click', function() {
  		copyUrl();
  	});
  	
  	$("select option[value='02']").attr("selected", true);
    $("#rows2 select option[value='NOT']").attr("selected", true);
    $("#searchCondBtn").trigger("click");
});

</script>
<div class="page-title">
    <h1>
     	응모/참여형
        <span id="evtSpan"></span>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="eventPlanExcutionAListSearchBtn" objCode="eventPlanListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="eventPlanExcutionAListClearBtn" objCode="eventPlanListSearchInit_OBJ">
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
            <button class="btn btn-sm" id="eventPlanNewBtn" objCode="eventPlanListNew_OBJ"><%-- 신규 --%>
                <spring:message code="M00274" />
            </button>
            <button class="btn btn-sm" id='eventPlanRemoveBtn' objCode="eventPlanListDel_OBJ"><%-- 삭제 --%>
                <spring:message code="M00165" />
            </button>
            <button class="btn btn-sm" id='eventPlanStopBtn' objCode="eventPlanListStop_OBJ"><%-- 중지 --%>
                <spring:message code="M02154" />
            </button>
            <button class="btn btn-sm" id='eventPlanStartBtn' objCode="eventPlanListStart_OBJ"><%-- 활성 --%>
                <spring:message code="L00430" />
            </button>
			<button class="btn btn-sm" id='setEventWinCmpltBtn' objCode="eventPlanListCmplt_OBJ"><%-- 당첨 완료 --%>
                	당첨 완료
            </button>
            <button class="btn btn-sm" id='finishEventPlanBtn' objCode="eventPlanListFinish_OBJ" style='background: red; border-color: red;'><%-- 종료 --%>
                <spring:message code="M00750" />
            </button>
        </div>
    </div>
    <div id="eventPlanExcutionGrid" class="white_bg grid_bd0 grid_scroll5"></div>     
</div>
<div id="eventPreviewTokenPopup" class="popup_container"></div>