<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var pointManagementList;
var gridIdpointManagementList;
var rid ;

//등급그룹 목록 조회
function getPointManagementList(){
    var jqGridOption = {
       	ondblClickRow : function(data){
	   		var data = pointManagementList.getRowData()[data-1];
	   		rid = data.rid;
	   		pointDtlPop();   // 상세 보기 이벤트
       		
       		
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
        url : '<ifvm:action name="getPointList"/>',
        colNames:[ 
                   '<spring:message code="M02016" />',
                   '<spring:message code="M02017" />',
                   '<spring:message code="L00435"/>',
                   '<spring:message code="M02018" />',
                   '<spring:message code="M02019" />',
                   '<spring:message code="L00356"/>',
                   '<spring:message code="L00350"/>',
                   '<spring:message code="L00355"/>',
                   '<spring:message code="L00422"/>',
                   '<spring:message code="L00381"/>',
                   '<spring:message code="L00351"/>',
                   '<spring:message code="M00966"/>',
                   '<spring:message code="L00376"/>',
                   '<spring:message code="L00375"/>',
                   '<spring:message code="M02020" />',
                   '<spring:message code="M02021" />',
                   '<spring:message code="L00322"/>',
                   '<spring:message code="M00506"/>',
                   '<spring:message code="L00354"/>',
                   '<spring:message code="M01907"/>',
                   'rid',
                   'ridPgm',
                   'ridMbr',
                   'ridChnl'
                 ],
        colModel:[
            { name:'txnDate', 		index:'a.txn_date', 	resizable : true, align:'center', 	width:'90px' },
            { name:'txnTime', 		index:'a.txn_time', 	resizable : true, align:'center', 	width:'70px' },
            { name:'custNm', 		index:'c.cust_nm', 		resizable : true, formatter: goGridRowMbrLink, 	width:'100px'},
            { name:'birthDt', 		index:'c.birth_dt', 	resizable : true, align:'center', 	width:'70px' },
            { name:'mbrStatCd', 	index:'c.MBR_STAT_CD', 	resizable : true, align:'center', 	width:'60px'},
            { name:'pntTxnType1', 	index:'c1.mark_name', 	resizable : true, align:'center', 	width:'60px'},
            { name:'pntTxnType2', 	index:'c2.mark_name', 	resizable : true, align:'center', 	width:'100px'},
            { name:'txnAmt', 		index:'a.TXN_AMT', 		resizable : true, align:'right', 	width:'90px'},
            { name:'pntAmt', 		index:'a.pnt_amt', 		resizable : true, align:'right', 	width:'90px'},
            { name:'rcptNo', 		index:'a.rcpt_no', 		resizable : true, align:'center', 	width:'140px'},
            { name:'mbrStatCd', 	index:'c3.mark_name', 	resizable : true, align:'center', 	width:'60px'},
            { name:'apprNo', 		index:'a.appr_no', 		resizable : true, align:'center', 	width:'90px'},
            { name:'apprDate', 		index:'a.appr_date', 	resizable : true, align:'center', 	width:'90px'},
            { name:'apprTm', 		index:'a.appr_tm', 		resizable : true, align:'center', 	width:'70px'},
            { name:'orgnApprNo', 	index:'a.orgn_appr_no', resizable : true, align:'center', 	width:'100px'},
            { name:'orgnApprDate', 	index:'a.orgn_appr_date', resizable : true, align:'center', 	width:'100px'},
            { name:'posNo', 		index:'a.pos_no', 		resizable : true, align:'center', 	width:'120px'},
            { name:'chnlNm', 		index:'e.CHNL_NM', 		resizable : true, formatter: goGridRowChnlLink, 	width:'130px'},
            { name:'txnUniqNo', 	index:'a.txn_uniq_no', 	resizable : true, align:'center', 	width:'130px'},
            { name:'pgmNm', 		index:'d.pgm_nm', 		resizable : true, formatter: goGridRowPgmLink, 	width:'150px'},
            { name:'rid', 			index:'a.rid', 			hidden : true},
            { name:'ridPgm', 		index:'a.RID_PGM', 		hidden : true},
            { name:'ridMbr', 		index:'a.rid_mbr', 		hidden : true },
            { name:'ridChnl', 		index:'a.rid_chnl', 	hidden : true }
        ],
        tempId : 'ifvGridOriginTemplete'
    };
    
    pointManagementList = $("#pointManagementList").ifvGrid({ jqGridOption : jqGridOption });
    gridIdpointManagementList = $("#gridIdpointManagementList");
}

//그리드 텍스트 선택시 상세로 이동
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}
function goGridRowChnlLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id; 
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}
function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id; 
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}


//공통 조회 조건 목록 설정
function pointManagementListSearchInit() {
    $.fn.ifvmSetCommonCondList("pointSearchList","PLOY_201");
}

//공통 조회 호출
function pointManagementListSearch() {
    $.fn.ifvmSubmitSearchCondition("pointSearchList", getPointManagementList);
} 

// 상세 팝업 화면 호출 
function pointDtlPop(){
	
	$("#pointDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="pointDtlPopListNew"/>',
        contentType: "ajax",
        title: '<spring:message code="L00477"/>',
        width: '1000px',
        close : 'pointDtlPopClose'
    });
}

//팝업 닫기
function pointDtlPopClose() {
	pointDialog._destroy();
}


$(document).ready(function() {
    //공통 조회 조건 목록 설정
    pointManagementListSearchInit();
    
    pointManagementListSearch();
    //조회
    $('#pointManagementListSearchBtn').on('click', function(){
    	pointManagementListSearch();
    });
    
    //초기화
    $("#pointManagementListSearchInitBtn").on('click', function(){
    	pointManagementListSearchInit();
    });
    
});

</script>


<div class="page-title">
    <h1>
    <spring:message code="M02022" />
	&gt; <spring:message code="M00135" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="pointManagementListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="pointManagementListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="pointSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="pointManagementList" class="white_bg grid_bd0"></div>     
</div>

<div id="pointDialog" class="popup_container"></div>
