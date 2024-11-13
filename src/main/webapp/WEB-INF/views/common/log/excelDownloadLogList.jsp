<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var excelDownloadLogListGrid;
var gridIdexcelDownloadLogListGrid;

//캠페인 목록
function getExcelDownloadLogList(page){
    
    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1; 
    
    var jqGridOption = {
        serializeGridData : function( data ){
        	
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	
        	//페이지 설정
        	data.page = page;
        	
            return data;
        },
        ondblClickRow : function (rowNo) {
        	goExcelDownloadLogDetail(excelDownloadLogListGrid.opt.data.rows[rowNo-1]);
        },
        url : '<ifvm:action name="getExcelDownloadLogList"/>',
        colNames:[ '<spring:message code="M02170" />',
                   '<spring:message code="M02171" />',
                   '<spring:message code="M02161" />',
                   '<spring:message code="M02162" />',
                   '<spring:message code="M02163" />',
                   '<spring:message code="M02164" />',
                   '<spring:message code="M02165" />',
                   '<spring:message code="M02166" />',
                   '<spring:message code="M02167" />',
                   '<spring:message code="M02168" />',
                   '<spring:message code="M02172" />',
                   'id'
                 ],
        colModel:[
        	{ name:'reqDt', index:'t1.req_dt', width:'150px', align: 'center', resizable : true },
            { name:'reqTypeNm', index:'c1.mark_name', width:'100px', align: 'center', resizable : true },
            { name:'reqIp', index:'t1.req_ip', width:'100px', align: 'center', resizable : true },
            { name:'reqSessnId', index:'e.name', width:'200px', align: 'center', resizable : true },
            { name:'userId', index:'u1.user_id', width:'100px', align: 'center', resizable : true },
            { name:'userStatNm', index:'c2.mark_name', width:'100px', align: 'center', resizable : true },
            { name:'divNo', index:'d1.div_no', width:'100px', align: 'center', resizable : true },
            { name:'divNm', index:'d1.div_nm', width:'200px', align: 'center', resizable : true },
            { name:'empNm', index:'e1.name', width:'100px', align: 'center', resizable : true },
            { name:'email', index:'e1.email', width:'200px', align: 'center', resizable : true },
            { name:'workStatusNm', index:'c3.markName', width:'100px', align: 'center', resizable : true },
            { name:'id', index:'', hidden : true } 
        ],
        sortname: 't1.req_dt',
        sortorder: "desc",
        tempId : 'ifvGridOriginTemplete'
    };
    
    excelDownloadLogListGrid = $("#excelDownloadLogListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdexcelDownloadLogListGrid = $("#gridIdexcelDownloadLogListGrid");
}

//상세 이동
function goExcelDownloadLogDetail(data) {
    var url = data.reqDtlLink + data.targetId;
    window.open(url, "_blank");
    
    //excelDownloadLogDetailPopOpen(url);
}
    
//상세 팝업 닫기
function excelDownloadLogDetailPopClose(){
	$('#excelDownloadLogDetailPopup').ejDialog('destroy');
}

//상세 팝업 열기
function excelDownloadLogDetailPopOpen(url) {
    $("#excelDownloadLogDetailPopup").ifvsfPopup({
		enableModal : true,
        enableResize: true,
        contentUrl: url,
        contentType: "ajax",
        title: '<spring:message code="M01470" />',
        width: '900px',
        height: '500px',
        close : 'excelDownloadLogDetailPopClose'
    });
}

//공통 조회 조건 목록 설정
function excelDownloadLogListSearchInit() {
    $.fn.ifvmSetCommonCondList("excelDownloadLogSearchList", "MKTMNG001");
}

//공통 조회 호출
function excelDownloadLogListSearch() {
    $.fn.ifvmSubmitSearchCondition("excelDownloadLogSearchList", getExcelDownloadLogList);
}

//엑셀 다운로드
function excelDownloadLogExcelExport() {
	excelDownloadLogListGrid.ifvmGridExcelExport();
}

$(document).ready(function() {
    getExcelDownloadLogList();
    
    //공통 조회 조건 목록 설정
    excelDownloadLogListSearchInit();
    
    //조회
    $('#excelDownloadLogListSearchBtn').on('click', function(){
    	excelDownloadLogListSearch();
    });
    
    //초기화
    $('#excelDownloadLogListSearchInitBtn').on('click', function(){
    	excelDownloadLogListSearchInit();
    });
    
  	//엑셀 다운로드 버튼 클릭시
    $('#excelDownloadLogExcelExportBtn').on('click', function() {
    	//엑셀 다운로드
    	excelDownloadLogExcelExport();
    });
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="M02158" />
        &gt; <spring:message code="M02169" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelDownloadLogListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="excelDownloadLogListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="excelDownloadLogSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelDownloadLogExcelExportBtn">
            	<i class="glyphicon glyphicon-check"></i>
                <spring:message code="M01218" />
            </button> 
        </div>
    </div>
    <div id="excelDownloadLogListGrid" class="white_bg grid_bd0"></div>     
</div>
<div id="excelDownloadLogDetailPopup"></div>