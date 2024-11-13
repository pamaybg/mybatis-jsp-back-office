<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var tableMstListGrid;

var tableId;
var tblNm;
var dbId;
var tblType;
var subjectAreaNm;

//테이블 컬럼 목록
function getTableMstList() {
    var jqGridOption = {
       	ondblClickRow : function(data) {
       		var data = tableMstListGrid.getRowData()[data-1];
       		tableId = data.tableId;
       		tblNm = data.tblNm;
       		dbId = data.dbId;
       		tblType = data.tblType;
       		subjectAreaNm = data.subjectAreaNm;
    		qtjs.href('<ifvm:url name="tableProperDetail"/>?tableId='+tableId+'&tblNm='+tblNm+'&dbId='+dbId+'&tblType='+tblType+'&subjectAreaNm='+encodeURIComponent(subjectAreaNm));
       	},
        onSelectRow : function (data) {
       	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }     
            return data;
       	},		
       	loadComplete : function(obj){
       	},	
        url : '<ifvm:action name="getTableMstList_KPR"/>',
        colNames:[ 
                   '<spring:message code="M01577"/>',
                   '<spring:message code="M01155"/>',
                   '<spring:message code="M00508" />',
                   '<spring:message code="M00236" />',
                   '<spring:message code="M00519" />',
                   '<spring:message code="M01573" />',
                   '<spring:message code="M01605" />',
                   '<spring:message code="M01593" />',
                   '<spring:message code="M01576" />',
                   'id',
                   'dbId',
                   'tblType'
                 ],
        colModel:[
            { name:'serviceNm', index:'di.service_nm', resizable : false },
            { name:'subjectAreaNm', index:'s.subject_area_nm', resizable : false },
            { name:'dbmsTypeCd', index:'t.dbms_type_cd', resizable : false },
            { name:'schmaNm', index:'t.schma_nm', resizable : false },
            { name:'tblNm', index:'t.tbl_nm', resizable : false},
            { name:'dpNm', index:'t.dp_nm', resizable : false},
            { name:'tblTypeCd', index:'c.mark_name', resizable : false},
            { name:'tblSpaceNm', index:'t.tbl_space_nm', resizable : false},
            { name:'importYn', index:'t.import_yn', resizable : false},
            { name:'tableId', index:'t.ID', hidden : true }, 
            { name:'dbId', index:'sd.db_id', hidden : true }, 
            { name:'tblType', index:'c.code_name', hidden : true } 
        ],
        sortname: 't.create_date',
        sortorder: "desc",
    };
    
    tableMstListGrid = $("#tableMstListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

/* 팝업 닫기 */
function tableMstPopClose(){
	$('#dialog').ejDialog('destroy');
}

//공통 조회 조건 목록 설정
function tableMstListSearchInit() {
    $.fn.ifvmSetCommonCondList("tableMstSearchList","ANL_TBL_001");
}

//공통 조회 호출
function tableMstListSearch() {
    $.fn.ifvmSubmitSearchCondition("tableMstSearchList", getTableMstList);
} 

//테이블 불러오기 팝업 열기
function tableCallPopOpen() {
    $("#dialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tableImportPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01606" />',
        width: "700",
        close : 'tableMstPopClose'
    });
} 

$(document).ready(function() {
    getTableMstList();
    
    //공통 조회 조건 목록 설정
    tableMstListSearchInit();
    
    //조회
    $('#tableMstListSearchBtn').on('click', function(){
    	tableMstListSearch();
    });
    
    //초기화
    $("#tableMstListSearchInitBtn").on('click', function(){
    	tableMstListSearchInit();
    });
    
    //신규 클릭시
    $('#tableNewBtn').on('click', function(){
    	tableId = null;
    	qtjs.href('<ifvm:url name="tableProperDetail"/>');
    });

    //불러오기 클릭시
    $('#tableCallBtn').on('click', function(){
    	tableCallPopOpen();
    });
});

</script>

<div class="page-title">
    <h1>
         <spring:message code="M01291" />
        &gt; <spring:message code="M00273" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <%-- 조회 버튼 --%>
            <button class="btn btn-sm" id="tableMstListSearchBtn">
                <i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <%-- 초기화 버튼 --%>
            <button class="btn btn-sm" id="tableMstListSearchInitBtn">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="tableMstSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <%-- 신규 버튼 --%>
            <button class="btn btn-sm" id="tableNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M00136" />
            </button>
            <%-- 불러오기 버튼 --%>
            <button class="btn btn-sm" id="tableCallBtn">
               <spring:message code="M00613" />
            </button>
        </div>
    </div>
    <div id="tableMstListGrid" class="white_bg grid_bd0"></div>     
</div>

<div id="dialog" class="popup_container"></div>
