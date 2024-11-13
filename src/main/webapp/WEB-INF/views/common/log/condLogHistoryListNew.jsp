<%@ page trimDirectiveWhitespaces="true" %>
<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var condLogHistoryList;

//캠페인 목록
function getCondLogHistoryList(){
    
    var ejGridOption = {
        serializeGridData : function( data ){
        	
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
	
            return data;
        },
        dataUrl : '<ifvm:action name="getCondLogHistoryList"/>',
        columns: [
        	{
        		field: 'pgmNm', headerText: '<spring:message code="조회화면" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center ,customAttributes :{searchable : true}
        	},{
        		field: 'name', headerText: '<spring:message code="M02880" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, customAttributes :{searchable : true}
        	},{
        		field: 'srchDt', headerText: '<spring:message code="M02882" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
        	},{
        		field: 'custNm', headerText: '<spring:message code="고객명" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, customAttributes :{searchable : false}
        	},{
        		field: 'hhp', headerText: '<spring:message code="전화번호" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, 
        	},{
        		field: 'custRid', headerText: '<spring:message code="고객RID" />', visible: false,
        	},{
        		field: 'rid', headerText: 'rid', visible: false,
        	},

        ],
        
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : '8',
        	  sord : 'desc',
        	  _search : false
          },
          rowList : [ 10, 25, 50, 100 ],
  		  radio : true,
//   	  gridDataInit: false,
  		  tempId :'ifvGridOriginTemplete'
      };
    
    condLogHistoryList = $("#condLogHistoryListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function condLogHistoryListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("condLogHistorySearchList", "LOG_004",gridId);
}

//공통 조회 호출
function condLogHistoryListSearch() {
    $.fn.ifvmSubmitSearchCondition("condLogHistorySearchList", function(){
    	condLogHistoryList.searchGrid({item: requestitem});
    });
}

//로그인 이력 엑셀 다운로드
function condLogHistoryExcelExport() {
	//엑셀 다운로드
	condLogHistoryList.ifvmGridExcelExport();
} 

//마스크해제
function clearMaskAction() {
	var v_rid;
	if ($.fn.ifvmIsNotEmpty(condLogHistoryList.opt.gridControl.getSelectedRecords()[0])) v_rid = condLogHistoryList.opt.gridControl.getSelectedRecords()[0].rid;
	else alert('<spring:message code="M02219"/>');
	
	if ($.fn.ifvmIsNotEmpty(v_rid)) {
	    $.ifvSyncPostJSON('<ifvm:action name="clearMaskCondLogHistList"/>', { rid: v_rid },
	    function(result) {
	    	var gridObj = condLogHistoryList.opt.gridControl;
	    	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
	    	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.noneMskCustNm);
	    	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.noneMskHhp);
	    });
	}
}

$(document).ready(function() {
    
    //공통 조회 조건 목록 설정
    condLogHistoryListSearchInit();
    getCondLogHistoryList();
    
    //조회
    $('#condLogHistoryListSearchBtn').on('click', function(){
    	condLogHistoryListSearch();
    });
    
    //초기화
    $('#condLogHistoryListSearchInitBtn').on('click', function(){
    	condLogHistoryListSearchInit('condLogHistoryListGrid');
    });
    
    //엑셀다운로드
    $('#condLogHistoryExcelExportBtn').on('click', function(){
    	//$.ifvExcelDn('/common/log/condLogHistoryDownload.do','condLogHistoryListGrid');
    	$.ifvDBExcelDn('/common/log/condLogHistoryDownload.do', $("#condLogHistoryExcelExportBtn").attr("objcode"));
    });
    
	//마스킹해제
	$("#clearMasked").on('click', function() {
		clearMaskAction();
	});
});

</script>
<div class="page-title">
    <h1>
        <spring:message code="O00207" />
        &gt; <spring:message code="L00030" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="condLogHistoryListSearchBtn" objCode="condLogHistListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="condLogHistoryListSearchInitBtn" objCode="condLogHistListInit_OBJ">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="condLogHistorySearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="clearMasked" objCode="condLogHistClearMasked_OBJ">
                <spring:message code="마스킹해제" />
            </button>
            <button class="btn btn-sm" id="condLogHistoryExcelExportBtn" objCode="condLogHistListExcelDwn_OBJ">
            	<i class="glyphicon glyphicon-check"></i>
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="condLogHistoryListGrid" class="white_bg grid_bd0"></div>     
</div>
