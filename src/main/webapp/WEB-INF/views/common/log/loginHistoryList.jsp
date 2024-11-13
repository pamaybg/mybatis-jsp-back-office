<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var loginHistoryListGrid;
var gridIdloginHistoryListGrid;

//캠페인 목록
function getLoginHistoryList(page){
    
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
        },
        url : '<ifvm:action name="getLoginHistoryList"/>',
        colNames:[ '<spring:message code="M02160" />',
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
        	{ name:'loginDt', index:'t1.create_date', width:'150px', align: 'center', resizable : true },
            { name:'ip', index:'t1.ip', width:'100px', align: 'center', resizable : true },
            { name:'sessnId', index:'t1.sessn_id', width:'200px', align: 'center', resizable : true },
            { name:'userId', index:'u1.user_id', width:'100px', align: 'center', resizable : true },
            { name:'userStatNm', index:'c2.mark_name', width:'100px', align: 'center', resizable : true },
            { name:'divNo', index:'d1.div_no', width:'100px', align: 'center', resizable : true },
            { name:'divNm', index:'d1.div_nm', width:'200px', align: 'center', resizable : true },
            { name:'empNm', index:'e1.name', width:'100px', align: 'center', resizable : true },
            { name:'email', index:'e1.email', width:'200px', align: 'center', resizable : true },
            { name:'workStatusNm', index:'c3.markName', width:'100px', align: 'center', resizable : true },
            { name:'id', index:'', hidden : true } 
        ],
        sortname: 't1.create_date',
        sortorder: "desc",
        tempId : 'ifvGridOriginTemplete'
    };
    
    loginHistoryListGrid = $("#loginHistoryListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdloginHistoryListGrid = $("#gridIdloginHistoryListGrid");
}

//공통 조회 조건 목록 설정
function loginHistoryListSearchInit() {
    $.fn.ifvmSetCommonCondList("loginHistorySearchList", "MKTMNG001");
}

//공통 조회 호출
function loginHistoryListSearch() {
    $.fn.ifvmSubmitSearchCondition("loginHistorySearchList", getLoginHistoryList);
}

//로그인 이력 엑셀 다운로드
function loginHistoryExcelExport() {
	//엑셀 다운로드
	loginHistoryListGrid.ifvmGridExcelExport();
}

$(document).ready(function() {
    getLoginHistoryList();
    
    //공통 조회 조건 목록 설정
    loginHistoryListSearchInit();
    
    //조회
    $('#loginHistoryListSearchBtn').on('click', function(){
    	loginHistoryListSearch();
    });
    
    //초기화
    $('#loginHistoryListSearchInitBtn').on('click', function(){
    	loginHistoryListSearchInit();
    });
    
    //엑셀다운로드
    $('#loginHistoryExcelExportBtn').on('click', function(){
    	loginHistoryExcelExport();
    });
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="M02158" />
        &gt; <spring:message code="M02159" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="loginHistoryListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="loginHistoryListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="loginHistorySearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="loginHistoryExcelExportBtn">
            	<i class="glyphicon glyphicon-check"></i>
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="loginHistoryListGrid" class="white_bg grid_bd0"></div>     
</div>
