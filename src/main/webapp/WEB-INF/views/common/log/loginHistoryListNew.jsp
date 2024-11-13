<%@ page trimDirectiveWhitespaces="true" %>
<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var loginHistoryList;

//캠페인 목록
function getLoginHistoryList(){
    
    var ejGridOption = {
        serializeGridData : function( data ){
        	
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
	
            return data;
        },
        dataUrl : '<ifvm:action name="getLoginHistoryList"/>',
        columns: [
        	{
        		field: 'loginDt', headerText: '<spring:message code="M02160" />', headerTextAlign: 'center', width: '130px',
        	}, {
        		field: 'ip', headerText: '<spring:message code="M02161" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '90px', customAttributes :{searchable : true}
        	}, {
        		field: 'sessnId', headerText: '<spring:message code="M02162" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '230px', customAttributes :{searchable : true}
        	}, {
        		field: 'userId', headerText: '<spring:message code="M02163" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '150px', customAttributes :{searchable : true}
        	}, {
        		field: 'userStatNm', headerText: '<spring:message code="M02164" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '70px',
        		customAttributes: {
        			index: 'userStatCd'
        		}
        	}, {
        		field: 'divNo', headerText: '<spring:message code="M02165" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '80px', customAttributes :{searchable : true}
        	}, {
        		field: 'divNm', headerText: '<spring:message code="M02166" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '80px', customAttributes :{searchable : true}
        	}, {
        		field: 'empNm', headerText: '<spring:message code="M02167" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '100px',
        	}, {
        		field: 'email', headerText: '<spring:message code="M02168" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '150px',
        	}, {
        		field: 'workStatusNm', headerText: '<spring:message code="M02172" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '70px',
        		customAttributes: {
        			index: 'workStatusCd'
        		}
        	}, {
        		field: 'markName', headerText: '<spring:message code="V00170" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '70px',
        		customAttributes: {
        			index: 'markNameCd'
        		}
        	}, {
        		field: 'id', headerText: 'id', visible: false,
        	},
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'loginDt',
        	  sord : 'desc',
        	  _search : false
          },
          rowList : [ 10, 25, 50, 100 ],
  		  radio : false,
       	  gridDataInit: false,
  		  tempId :'ifvGridOriginTemplete'
      };
    
    loginHistoryList = $("#loginHistoryListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function loginHistoryListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("loginHistorySearchList", "LOG_001",gridId);
}

//공통 조회 호출
function loginHistoryListSearch() {
    $.fn.ifvmSubmitSearchCondition("loginHistorySearchList", function(){
    	loginHistoryList.searchGrid({item: requestitem});
    });
}

//로그인 이력 엑셀 다운로드
function loginHistoryExcelExport() {
	//엑셀 다운로드
    $.ifvExcelDn('<ifvm:action name="LoginHistoryDownload"/>','loginHistoryListGrid');
    //loginHistoryList.ifvmGridExcelExport();
}

$(document).ready(function() {
    
    //공통 조회 조건 목록 설정
    loginHistoryListSearchInit();
    getLoginHistoryList();
    
    //조회
    $('#loginHistoryListSearchBtn').on('click', function(){
    	loginHistoryListSearch();
    });
    
    //초기화
    $('#loginHistoryListSearchInitBtn').on('click', function(){
    	loginHistoryListSearchInit('loginHistoryListGrid');
    });
    
    //엑셀다운로드
    $('#loginHistoryExcelExportBtn').on('click', function(){
    	$.ifvExcelDn('/common/log/LoginHistoryDownload.do','loginHistoryListGrid');
    });
});

</script>

<div class="page-title">
    <h1>
       <spring:message code="O00210" />
        &gt; <spring:message code="L00030" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="loginHistoryListSearchBtn" objCode="loginHistoryListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="loginHistoryListSearchInitBtn" objCode="loginHistoryListInit_OBJ">
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
            <button class="btn btn-sm" id="loginHistoryExcelExportBtn" objCode="loginHistoryListExcelDwn_OBJ">
            	<i class="glyphicon glyphicon-check"></i>
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="loginHistoryListGrid" class="white_bg grid_bd0"></div>     
</div>
