<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var campaignResultGrid;
var campaignExecutionGrid;
var errorHistoryPop;
var cam_id;

var objCampaignPopup;

/**
 * 조회결과 그리드
 */
function campaignResult() {

    var jqGridOption = {
        onSelectRow : function (data) {

        },
		ondblClickRow : function(data) {
			qtjs.href('<ifvm:url name="reactionInfoDetail"/>?cam_id=' + cam_id);
		},
		onSelectRow : function() {
			cam_id = campaignResultGrid.getCheckedGridData()[0].id;
			$.fn.ifvmSubmitSearchCondition("campaignExecutionGrid", campaignExecution);
		},
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        url : '<ifvm:action name="getCampaignList"/>',
        colNames:[ 
                   '<spring:message code="L00417"/>',
                   '<spring:message code="M00592"/>',
                   '<spring:message code="M00593" />',
                   '<spring:message code="M00594" />',
                   '<spring:message code="M00595" />',
                   '<spring:message code="M00974" />',  //승인진행상태
                   '<spring:message code="M00598" />',  //유형
                   '<spring:message code="M02304" />',  //캠페인 범위
                   '<spring:message code="M02295" />',  //프로모션 여부
                   '<spring:message code="M00596" />',  //기획자
                   '<spring:message code="M00597" />',  //부서
                   '<spring:message code="M01870" />',  //오퍼
                   '<spring:message code="M00600" />',  //비고
                   'typeCode',
                   'id',
                   'type',
                   'campaignApprovalStatusCode'
        ],
        colModel:[
            { name:'dispNo',                 index:'c.DISP_NO',  width:'100px', resizable : false, align: 'center', },
            { name:'campaignName',           index:'c.CAM_NM',   width:'250px', resizable : false, cellattr: function(){ return 'style="text-overflow:ellipsis;"';} },
            { name:'campaignStartDate',      index:'c.CAM_START_DD', width:'100px', align: 'center', resizable : false },
            { name:'campaignEndDate',        index:'c.CAM_END_DD', width:'100px', align: 'center', resizable : false },
            { name:'campaignStatusCodeName', index:'c2.MARK_NAME', width:'100px', align: 'center', resizable : false },
            { name:'campaignApprovalStatusCodeName', index:'c9.MARK_NAME', width:'100px', align: 'center', resizable : false },
            { name:'campaignTypeCodeName',   index:'c8.MARK_NAME', width:'150px', resizable : false },
            { name:'camScopeTypeNm',         index:'c10.MARK_NAME', width:'100px', align: 'center', resizable : false },
            { name:'promYn',   				 index:'c.prom_yn', width:'100px', resizable : false },
            { name:'campaignPlannerName',    index:'e.NAME', width:'150px', resizable : false },
            { name:'planOrgCodeName',        index:'d1.div_nm', width:'150px', resizable : false },
            { name:'offerName',              index:'o.OFFER_NM', width:'150px', resizable : false },
            { name:'description',            index:'c.CAM_DESC', width:'150px', resizable : false },
            { name:'campaignTypeCode',           index:'c8.CODE_NAME', hidden: true, searchable : false},
            { name:'id',                         index:'c.id',         hidden: true, searchable : false},
            { name:'type',                       index:'c.type',       hidden: true, searchable : false},
            { name:'campaignApprovalStatusCode', index:'c9.CODE_NAME', hidden: true, searchable : false},
        ],
        sortname: 'c.create_date',
        sortorder: "desc",
        radio: true,
    };    
    
    /* 
		ondblClickRow : function(data) {
			qtjs.href('<ifvm:url name="reactionInfoDetail"/>?cam_id='+cam_id);
		},
		onSelectRow : function() {
			cam_id = campaignResultGrid.getCheckedGridData()[0].cam_id;
			$.fn.ifvmSubmitSearchCondition("campaignExecutionGrid", campaignExecution);
		},
		loadComplete : function(data) {
			cam_id = "";
			$.fn.ifvmSubmitSearchCondition("campaignViewList", campaignExecution);
		},

	}; */
	campaignResultGrid = $("#campaignResultGrid").ifvGrid({ jqGridOption : jqGridOption });
}

/**
 * 프로모션 실행 정보 조회 
 */
function getCampaignPromExecGrid() {
    
	var jqGridOption = {
		serializeGridData : function(data) {
			data.cam_id = cam_id;
			return data;
		},
	    url: '<ifvm:action name="getCampaignPromExecList"/>', 
	    colNames:[
	            '<spring:message code="M01338"/>',
	            '<spring:message code="M01345"/>',
		],
	    colModel:[
				{name:'exe_seq',                    index:'b.EXE_SEQ',      resizable : false, align:'center'},
				{name:'tgt_tot_cnt',                index:'c.tgt_tot_cnt',  resizable : false, align:'right' },
				{name:'send_tot_cnt',               index:'d.send_tot_cnt', resizable : false, align:'right' },
				{name:'exe_info_status_cd',         index:'d.mark_name',    resizable : false},
				{name:'exe_info_status_bat_dtl_cd', index:'e.mark_name',    resizable : false},
				{name:'exe_dt',                     index:'b.EXE_DT',       resizable : false},
				{name:'min_start_dt',               index:'e.MIN_START_DT', resizable : false},
				{name:'max_end_dt',                 index:'e.MAX_END_DT',   resizable : false},
				{name:'bat_status',                 index:'e.bat_status',   resizable : false},
	    ],
	    sortname: 'exe_seq',
		sortorder: "asc",
		radio : false
	};
	campaignPromExecGrid = $("#campaignPromExecGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//캠페인 실행 정보 그리드
function campaignExecution() {
	var jqGridOption = {
		serializeGridData : function(data) {
			data.cam_id = cam_id;
			return data;
		},
	    url: '<ifvm:action name="getCampaignPromExecList"/>', 
	    colNames:['<spring:message code="M01338"/>',
	              '<spring:message code="M01345"/>',
	              '<spring:message code="M01345"/>',
	              '<spring:message code="M01345"/>',
	              '<spring:message code="M01345"/>',
	              '<spring:message code="M01345"/>',
	              '<spring:message code="M01345"/>',
	              '<spring:message code="M01345"/>',
	              '<spring:message code="M01345"/>',
	              '<spring:message code="M01345"/>',
	              '<spring:message code="M01345"/>',
	              '<spring:message code="M01345"/>',
	              ],
	    colModel:[
				{name:'exePromid', 				index:'t1.id', 					resizable : false, align:'center'},
				{name:'promNo', 				index:'t1.prom_no as promno', 	resizable : false, align:'right' },
				{name:'promStartDt', 			index:'t1.prom_start_dt', 		resizable : false, align:'right' },
				{name:'promEndDt', 				index:'t1.prom_end_dt', 		resizable : false},
				{name:'tgtHadId', 				index:'t2.id', 					resizable : false},
				{name:'txnTranYn', 				index:'t1.txn_tran_yn', 		resizable : false},
				{name:'exeInfoStatusCd', 		index:'t1.exe_info_status_cd', 	resizable : false},
				{name:'exeInfoStatusNm', 		index:'c1.mark_name',			resizable : false},
				{name:'exeInfoStatusBatDtlCd', 	index:'t1.exe_info_status_bat_dtl_cd', resizable : false},
				{name:'exeInfoStatusBatDtlNm', 	index:'c2.mark_name', 			resizable : false},
				{name:'exeSeq', 				index:'t1.exe_seq', 			resizable : false},
				{name:'camId', 					index:'t1.cam_id', 				resizable : false},
	    ],
	    sortname: 't1.id',
		sortorder: "asc",
		radio : false
	};
	campaignExecutionGrid = $("#campaignExecutionGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function errorHistoryPopClose(){
	objCampaignPopup._destroy();
}

//공통 조회 조건 목록 설정
function campaignListSearchInit() {
    $.fn.ifvmSetCommonCondList("campaignViewList","MKTMNG004");
}

$(document).ready(function(){
	campaignResult();
	//campaignExecution();
	
	//캠페인 조회 리스트
	var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	$.fn.ifvmSetCommonCondList("campaignViewList",LeftMenuId);
	
	//오류내역조회
	$("#errorHistoryBtn").on("click", function(){
	objCampaignPopup = $("#errorHistoryPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="errorHistoryPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01346"/>',
        width: 900,
        close : 'errorHistoryPopClose'
	}); 
		objCampaignPopup = $("#errorHistoryPop").data("ejDialog");
	});
	
	//공통 조회 조건 목록 설정
    campaignListSearchInit();
	
  	//조회
    $('#campaignListSearchBtn').on('click', function(){
    	$.fn.ifvmSubmitSearchCondition("campaignViewList", campaignResult);
    });
    
    //초기화
    $("#campaignListSearchInitBtn").on('click', function(){
        $.fn.ifvmSetCommonCondList("campaignViewList","MKTMNG004");
    });
    
    $("#commonDtlBtn").on('click', function(){
    	
    	var data = campaignResultGrid.getCheckedList()[0];
    	
    	if (typeof(data) == 'undefined') {
    		alert('<spring:message code="M00004" />');
    	}
    	else{
    		 qtjs.href('<ifvm:url name="reactionInfoDetail"/>?cam_id=' + data.cam_id);
    	}
    	
    });
});
</script>

<script id="ifvGridExecutionTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="filter_area">
			<div class="left">
				{searchBox}
			</div>
		</div>
		<div class="grid_con">
			{grid}
		</div>
	</div>
</script>

<div class="page-title">
    <h1>
        <spring:message code="M02452" />
        &gt; <spring:message code="M01325" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="campaignListSearchBtn">
            	<i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="campaignListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="campaignViewList"></div>
</div>

<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
       		<button class="btn btn-sm" id="commonDtlBtn">
       			<spring:message code="M01424" />
      	  	</button> 
        </div>
    </div>
    <div id="campaignResultGrid" class="white_bg grid_bd0"></div>     
</div>

<!-- 캠페인 실행 정보 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M01327" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="errorHistoryBtn">         
				<spring:message code="M01337"/>
			</button> 
		</div>
    </div>
    <div id="campaignExecutionGrid" class="white_bg grid_bd0 grid_scroll5"></div>     
</div>

<div id="errorHistoryPop" class="popup_container"></div>
