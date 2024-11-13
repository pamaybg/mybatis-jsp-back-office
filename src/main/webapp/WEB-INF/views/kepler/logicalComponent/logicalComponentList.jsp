<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var logicalComponentListGrid = null;
var cDialog;
var selectChk = false;

var logicalComponent = {
	logicalComponentId: "",
	selRow: ""
};

//로지컬 컴포넌트 목록
function getLogicalComponentList(){
    
    var jqGridOption = {
   		serializeGridData : function( data ){
	        if ($.fn.ifvmIsNotEmpty(requestitem)) {
	             data.item = requestitem;
	         }      
	         return data;
	    },
    	onSelectRow : function (data) {
    		var url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId='+data.lgcCompId+'&tab=join';
        	qtjs.href(url);
        },
        url : '<ifv:action name="getLogicalComponentList"/>',
        colNames:[ '<spring:message code="M01427"/>',
                   '<spring:message code="M00324" />',
                   '<spring:message code="M00184" />',
                   '<spring:message code="M00185" />',
                   'lgcCompId'
                 ],
        colModel:[
            { name:'lgcCompNm',  index:'lgc_comp_nm', 	width:'200px', resizable : false, cellattr: function(){ return 'style="text-overflow:ellipsis;"';} },
            { name:'lgcDesc',    index:'lgc_desc', 		width:'170px', resizable : false },
            { name:'name',       index:'name', 			width:'80px',  align: 'center', resizable : false },
            { name:'createDate', index:'create_date', 	width:'100px', align: 'center', resizable : false, formatter:"date" , formatoptions:{ newformat:"Y-m-d H:i:s"} },
            { name:'lgcCompId',  index:'lgc_comp_id',	hidden : true }
        ],
        sortname: 'lgc.CREATE_DATE',
        sortorder: "desc",
    };
    logicalComponentListGrid = $("#logicalComponentListGrid").ifvGrid({ jqGridOption : jqGridOption });
    
    if(logicalComponent.selRow != "") {
    	$("#gridIdlogicalComponentListGrid").setSelection(logicalComponent.selRow, true);
    	logicalComponent.selRow = "";
    }
    
}

//공통 조회 조건 목록 설정
function logicalComponentListSearchInit() {
    $.fn.ifvmSetCommonCondList("logicalComponentSearchList","ANL_LGC_001");
}

//공통 조회 호출
function logicalComponentListSearch() {
    $.fn.ifvmSubmitSearchCondition("logicalComponentSearchList", getLogicalComponentList);
}

$(document).ready(function() {
	
	/**
	 * Page Initiation
	 */
    getLogicalComponentList();
    
    //공통 조회 조건 목록 설정
    logicalComponentListSearchInit();
    
    
	/**
	 * Button Handler Start
	 */
    //조회
    $('#logicalComponentListSearchBtn').on('click', function(){
    	logicalComponentListSearch();
    });
    
    //초기화
    $("#logicalComponentListSearchInitBtn").on('click', function(){
    	logicalComponentListSearchInit();
    });
    
    //신규 클릭시
    $('#logicalComponentNewBtn').on('click', function(){
    	var url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId=&tab=join';
    	qtjs.href(url);
    });
	/**
	 * Button Handler End
	 */
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="M01426" />
        &gt; <spring:message code="M00135" />
    </h1>
</div>

<!-- 조회 -->
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="logicalComponentListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="logicalComponentListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="logicalComponentSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="logicalComponentNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M00274" />
            </button> 
        </div>
    </div>
    <div id="logicalComponentListGrid" class="white_bg grid_bd0"></div>     
</div>

<div id="dialog" class="popup_container"></div>
<div id="dialogTempPop"></div>