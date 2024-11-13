<%@ page trimDirectiveWhitespaces="true" %>
<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var authLogHistoryList;

//캠페인 목록
function getAuthLogHistoryList(){
    
    var ejGridOption = {
        serializeGridData : function( data ){
        	
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
	
            return data;
        },
        dataUrl : '<ifvm:action name="getAuthLogHistoryList"/>',
        columns: [
        	{
        		field: 'authLogTypeNm', headerText: '<spring:message code="M02885" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,  customAttributes :{index : 'authLogTypeCdNm'}
        	}, {
        		field: 'logTypeDtlNm', headerText: '<spring:message code="M02891" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, customAttributes :{index : 'logTypeDtlCdNm'}
        	}, {
        		field: 'targetNm', headerText: '<spring:message code="M02886" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, customAttributes :{searchable : true}

        	}, {
        		field: 'objNm', headerText: '<spring:message code="M02887" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, customAttributes :{searchable : true}
        	}, {
        		field: 'name', headerText: '<spring:message code="M02888" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, customAttributes :{searchable : true}
        	}, {
        		field: 'userId', headerText: '<spring:message code="M02889" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, customAttributes :{searchable : true}
        	}, {
        		field: 'srchDt', headerText: '<spring:message code="M02890" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center,
        	}, {
        		field: 'id', headerText: 'id', visible: false,
        	},

        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'srchDt',
        	  sord : 'desc',
        	  _search : false
          },
          rowList : [ 10, 25, 50, 100 ],
  		  radio : false,
//   	  gridDataInit: false,
  		  tempId :'ifvGridOriginTemplete'
      };
    
    authLogHistoryList = $("#authLogHistoryListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function authLogHistoryListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("authLogHistorySearchList", "LOG_003",gridId);
}

//공통 조회 호출
function authLogHistoryListSearch() {
    $.fn.ifvmSubmitSearchCondition("authLogHistorySearchList", function(){
    	authLogHistoryList.searchGrid({item: requestitem});
    });
}

//로그인 이력 엑셀 다운로드
function authLogHistoryExcelExport() {
	//엑셀 다운로드
	authLogHistoryList.ifvmGridExcelExport();
}

$(document).ready(function() {
    
    //공통 조회 조건 목록 설정
    authLogHistoryListSearchInit();
    getAuthLogHistoryList();
    
    //조회
    $('#authLogHistoryListSearchBtn').on('click', function(){
    	authLogHistoryListSearch();
    });
    
    //초기화
    $('#authLogHistoryListSearchInitBtn').on('click', function(){
    	authLogHistoryListSearchInit('authLogHistoryListGrid');
    });
    
    //엑셀다운로드
    $('#authLogHistoryExcelExportBtn').on('click', function(){
    	$.ifvExcelDn('/common/log/authLogHistoryDownload.do','authLogHistoryListGrid');
    });
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="O00208" />
        &gt; <spring:message code="L00030" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="authLogHistoryListSearchBtn" objCode="authLogHistListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="authLogHistoryListSearchInitBtn" objCode="authLogHistListInit_OBJ">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="authLogHistorySearchList">
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="authLogHistoryExcelExportBtn" objCode="authLogHistListExcelDwn_OBJ">
            	<i class="glyphicon glyphicon-check"></i>
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="authLogHistoryListGrid" class="white_bg grid_bd0"></div>     
</div>
