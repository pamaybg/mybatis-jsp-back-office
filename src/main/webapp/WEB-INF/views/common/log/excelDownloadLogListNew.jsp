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
    
    var ejGridOption = {
        serializeGridData : function( data ){
        	
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	
        	//페이지 설정
        	data.page = page;
        	
            return data;
        },
        recordDoubleClick : function (args) {

        	//goExcelDownloadLogDetail(args.data);
        },
        dataUrl : '<ifvm:action name="getExcelDownloadLogList"/>',
        columns: [
        	{
        		field: 'reqDt', headerText: '<spring:message code="M02170" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '130px'
        	}, {
        		field: 'reqTypeNm', headerText: '<spring:message code="M02171" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '100px'
        	}, {
        		field: 'reqIp', headerText: '<spring:message code="M02161" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '100px', customAttributes :{searchable : true}
        	}, {
        		field: 'targetId', headerText: '<spring:message code="타겟ID" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '260px', customAttributes :{searchable : true}
        	}, {
        		field: 'reqSessnId', headerText: '<spring:message code="M02162" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '260px', customAttributes :{searchable : true}
        	}, {
        		field: 'userId', headerText: '<spring:message code="M02163" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '130px', customAttributes :{searchable : true}
        	}, {
        		field: 'userStatNm', headerText: '<spring:message code="M02164" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '80px',
        	}, {
        		field: 'divNo', headerText: '<spring:message code="M02165" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '100px', customAttributes :{searchable : true}
        	}, {
        		field: 'divNm', headerText: '<spring:message code="M02166" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '100px', customAttributes :{searchable : true}
        	}, {
        		field: 'empNm', headerText: '<spring:message code="M02167" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '100px'
        	}, {
        		field: 'email', headerText: '<spring:message code="M02168" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '130px',
        	}, {
        		field: 'workStatusNm', headerText: '<spring:message code="M02172" />', headerTextAlign: 'center', textAlign: ej.TextAlign.Center, width: '80px',
        		customAttributes: {
        			index: 'workStatusCd'
        		}
        	}, {
        		field: 'id', headerText: 'ID', visible: false
        	},
        ],
        requestGridData : {
        	nd : new Date().getTime(),
        	rows : 10,
        	sidx : 'reqDt',
        	sord : 'desc',
        	_search : false
        },
        rowList : [10,25,50,100],
        isHorizontalScroll : true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    excelDownloadLogListGrid = $("#excelDownloadLogListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    //gridIdexcelDownloadLogListGrid = $("#gridIdexcelDownloadLogListGrid");
}

//상세 이동
/* function goExcelDownloadLogDetail(data) {
    var url = data.reqDtlLink + data.targetId;
    window.open(url, "_blank");
    
    excelDownloadLogDetailPopOpen(url);
} */
    
//상세 팝업 닫기
/* function excelDownloadLogDetailPopClose(){
	$('#excelDownloadLogDetailPopup').ejDialog('destroy');
} */

//상세 팝업 열기
/* function excelDownloadLogDetailPopOpen(url) {
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
} */

//공통 조회 조건 목록 설정
function excelDownloadLogListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("excelDownloadLogSearchList", "LOG_002",gridId);
    
}

//공통 조회 호출
function excelDownloadLogListSearch() {
    $.fn.ifvmSubmitSearchCondition("excelDownloadLogSearchList", function(){
    	excelDownloadLogListGrid.searchGrid({item: requestitem});
    });
}

//엑셀 다운로드
function excelDownloadLogExcelExport() {
	//excelDownloadLogListGrid.ifvmGridExcelExport();
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
    	excelDownloadLogListSearchInit("excelDownloadLogListGrid");
    });
    
  	//엑셀 다운로드 버튼 클릭시
    $('#excelDownloadLogExcelExportBtn').on('click', function() {
    	//엑셀 다운로드
    	$.ifvExcelDn('/common/log/ExcelDownload.do','excelDownloadLogListGrid');
//     	excelDownloadLogExcelExport();
    });
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="O00209" />
        &gt; <spring:message code="L00030" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelDownloadLogListSearchBtn" objCode="excelDownloadLogListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="excelDownloadLogListSearchInitBtn" objCode="excelDownloadLogListInit_OBJ">
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
        	<button class="btn btn-sm" id="excelDownloadLogExcelExportBtn" objCode="excelDownloadLogListExcelDwn_OBJ">
             <spring:message code="M01218" />
         	</button>
            <%-- <button class="btn btn-sm" id="excelDownloadLogExcelExportBtn">
            	<i class="glyphicon glyphicon-check"></i>
                <spring:message code="M01218" />
            </button>  --%>
        </div>
    </div>
    <div id="excelDownloadLogListGrid" class="white_bg grid_bd0"></div>     
</div>
<div id="excelDownloadLogDetailPopup"></div>