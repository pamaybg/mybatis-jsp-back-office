<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var allFlag = false;
var callGrid;
var rowData = null;
var listUrl;


function getCallList(){
	var jqGridOption = {
		ondblClickRow : function(data){
		},
	    onSelectRow : function (data) {
	    	rowData = null;
	    	rowData = data;
	    	$("#unmaskBtn").attr("disabled",false);
		},
		serializeGridData : function( data ){
			//전체 조회 flag
			if(!allFlag){
				data.ridCrmuser = ifvmUserInfo.id;
			}
			
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }     
            return data;
		},
		loadComplete : function(data) {
			//마스킹해제 버튼 disabled 처리
	    	$("#unmaskBtn").attr("disabled",true);

			parent.setParentIframeHeight();
		},
		url: '<ifvm:action name="getCallList"/>',
	    colNames:[
	              '<spring:message code="L00132"/>', /* 채널유형 */
	              '<spring:message code="V00076"/>', /* 서비스유형 */
	              '<spring:message code="V00077"/>', /* 통화시간 */
	              '<spring:message code="L00320"/>', /* 고객명 */
	              '<spring:message code="V00029"/>', /* 통화ID */
	              '<spring:message code="V00078"/>', /* 통화일시 */
	              '<spring:message code="L00400"/>', /* 전화번호 */
	              '<spring:message code="V00079"/>', /* 상담원명 */
	              'rid'
	              ],
	    colModel:[
	              {name:'chnlType',  			index:'b.mark_name', 			resizable : false, 		align:'center',    	width:'100px'},
	              {name:'svcType', 				index:'c.mark_name', 			resizable : false, 		align:'center',    	width:'100px'},
	              {name:'cserCurTime', 			index:'a.CSER_CUR_TIME', 		resizable : false, 		align:'center',    	width:'100px'},
	              {name:'custNm',     			index:'d.cust_nm', 				resizable : false, 		align:'center',    	width:'100px'},
	              {name:'callId', 				index:'a.CALL_ID', 				resizable : false, 		align:'center',    	width:'100px'},
	              {name:'rcpDt',/* createDate*/	index:'a.CREATE_DATE', 			resizable : false, 		align:'center',    	width:'100px',  		formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"}},
	              {name:'telNo', 				index:'a.TEL_NO', 				resizable : false, 		align:'center',    	width:'100px'},
	              {name:'csName', 				index:'f.name', 				resizable : false, 		align:'center',    	width:'100px'},
	              {name:'rid', 					index:'a.rid', 					resizable : false, hidden : true},
			      ],  			
		radio:true,
		sortname: 'a.CREATE_DATE',
		sortorder: "desc",
// 		tempId : 'ifvGridExcelTemplete'
	};
	callGrid = $("#callListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function init(){
	getCallList();
// 	clickSearchCallListBtn();
	clickInitializeCallListBtn();
	
	searchInitialize();
}

//내 이력 조회
function clickSearchMyCallListBtn(){
	$.fn.ifvmSubmitSearchCondition("callSearchList", getCallList);
}

//전체 이력 조회
function clickSearchWholeCallListBtn(){
	if(!searchBlankCheck()){
		alert('<spring:message code="V00205"/>');
	}else{
		allFlag = true;
		
		$.fn.ifvmSubmitSearchCondition("callSearchList", getCallList);
		
		allFlag = false;
	}
	requestitem = [];
}

//녹취청취 버튼
function clickRecordBtn(){
	if(callGrid.getCheckedGridData()[0] != undefined){
		$("#playRecordFilePop").ifvsfPopup({
		   enableModal : true,
		   enableResize: false,
		   contentUrl: '<ifvm:url name="playRecordFilePop"/>?callId='+rowData.callId+'&callDate='+rowData.rcpDt,
		   contentType: "ajax",
		   title: "<spring:message code='V00158'/>",
		   width: 600,
		   close : 'playRecordFilePopClose'
		});
	}else{
		alert('<spring:message code="V00198"/>');
	}
}

//전화걸기 버튼
function clickCallBtn(){
	if(callGrid.getCheckedGridData()[0] != undefined){
		//전화번호 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	        rid: rowData.rid ,
	        type: 'voc4' ,
	        field: 'telNo'
	    },
	    function(result) {
	    	parent.localSoftMakeCall(result.message,null);
	    });
	}else{
		alert('<spring:message code="V00204"/>'); //한 개의 목록을 선택해주세요.
	}
}

//공통 조회 조건 목록 설정
function clickSearchCallListBtn() {
    $.fn.ifvmSubmitSearchCondition("callSearchList", getCallList);
}

//공통 조회 호출
function clickInitializeCallListBtn() {
    $.fn.ifvmSetCommonCondList("callSearchList","PGM_V_002");
    getRidOfChnlType();
} 

//공통 조회 조건 값 유효성 체크 - 김준기 선생님
function searchBlankCheck(){
 var blankCheck=false;
 var searchCondSize= $('.changeTypeAreaCode').size();
 var displayRowNum=[];
 $($('.row.qt_border.SearchCondition')).each(function(index,item){
  if($("#rows"+index).css("display") !="none"){
   if($("#rows"+index).children(".changeTypeAreaCode").find('.smart-form').size()!=0){ //date
    if($("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_frt.start_date").children(".smart-form").children(".input").children("input").val() !=""
     && $("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_scd.end_date").children(".smart-form").children(".input").children("input").val() !="" ){
     blankCheck=true;
    }
   }else if($("#rows"+index).children('.changeTypeAreaCode').find("select").size()!=0){  //select
    if($("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2").children("select").val()!=""       ){
     blankCheck=true;
    }
   }else if($("#rows"+index).children('.changeTypeAreaCode').find("input").size()!=0){  //input
    if($("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2").children("input").val()!=""){
     blankCheck=true
    }
   }
  } 
 })
 return blankCheck;
}

//채널유형 조건에 해당하는 부분만 출력
function getRidOfChnlType(){
	$("#callSearchList .searchTextVal option:selected").filter(function(){
		if($(this).attr("joinsrcclm") == "CHNL_TYPE"){
			$(this).parents(".SearchCondition").find(".changeTypeAreaCode select option").not("[value=''],[value=10],[value=20],[value=30],[value=40],[value=50],[value=60],[value=99],[value=Inbound],[value=Outbound]").remove();
		}
	});
}

//회원명 초기 조건 equal 로 설정
function searchInitialize(){
	$("#callSearchList .searchTextVal option:selected").filter(function(){
		if($(this).attr('joinsrcclm') == 'CALL_ID'){
			$(this).parents('.SearchCondition').find('#searchCon').val("EQUAL(=)");
		}
	});
}

function clickUnmaskBtn(){
	if(callGrid.getCheckedGridData()[0] != undefined){
		//전화번호 마스킹 해제
		$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
	        rid: rowData.rid ,
	        type: 'voc4' ,
	        field: 'telNo'
	    },
	    function(result) {
	    	var rowid = callGrid.getRadioSelectedRowId();
            if (result.message != null) {
            	callGrid.opt.grid.setCell(rowid, 'telNo', result.message);
            }
	    });
	}else{
		alert('<spring:message code="V00204"/>'); //한 개의 목록을 선택해주세요.
	}
}

$(document).ready(function(){
	init();
	
	$.ifvEnterSetting(["#callSearchList"], function(){
		clickSearchCallListBtn();
	});
	
	if( !window.parent.document.getElementById("TSPhone")){
		$("#callBtn").attr("disabled",true);
	}
});
</script>

<div class="page-title">
    <h1>
    <spring:message code="V00075" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-2">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-10 searchbtn_r">
            <ifvm:inputNew type="button" id="searchCallListBtn"  text="L00030" btnType="search" btnFunc="clickSearchCallListBtn"/>
            <ifvm:inputNew type="button" id="initializeCallListBtn"  text="L00031" btnType="" btnFunc="clickInitializeCallListBtn"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="callSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-2">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-10 searchbtn_r">
        	<ifvm:inputNew type="button" id="unmaskBtn"  text="L00326" btnType="" btnFunc="clickUnmaskBtn" objCode="COM_MSK_001"/>
        	<ifvm:inputNew type="button" id="recordBtn"  text="V00080" btnType="" btnFunc="clickRecordBtn" objCode="VOC_REC_001"/>
        	<ifvm:inputNew type="button" id="callBtn"  text="V00081" btnType="" btnFunc="clickCallBtn"/>
        	<ifvm:inputNew type="button" id="searchMyCallListBtn"  text="V00082" btnType="search" btnFunc="clickSearchMyCallListBtn" objCode="VOC_MHS_001"/>
        	<ifvm:inputNew type="button" id="searchWholeCallListBtn"  text="V00083" btnType="search" btnFunc="clickSearchWholeCallListBtn" objCode="VOC_WHS_001"/>
        	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('callListGrid')" objCode="COM_EXC_001"/>
        </div>
    </div>
    <div id="callListGrid" class="white_bg grid_bd0"></div>     
</div>

<!-- 녹취파일 듣기 팝업 -->
<div id="playRecordFilePop"></div>