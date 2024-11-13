<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var campaignResultGrid;
var campaignExecutionGrid;
var errorHistoryPop;
var cam_id;
//조회결과 그리드
function campaignResult(){
    
	var jqGridOption = {
		serializeGridData : function( data ){
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
			data.type = "STN";
            return data;
		},
		ondblClickRow : function(data){
			qtjs.href('<ifvm:url name="stnReactionInfoDetail"/>?cam_id='+cam_id);
		},
		onSelectRow : function(){
			cam_id = campaignResultGrid.getCheckedGridData()[0].cam_id;
			$.fn.ifvmSubmitSearchCondition("campaignExecutionGrid", campaignExecution);
		},
		loadComplete : function( data ){
			cam_id = "";
			$.fn.ifvmSubmitSearchCondition("campaignViewList", campaignExecution);
		},
	    url: '<ifvm:action name="getStnCampaignStatusList"/>', 
	    colNames:['<spring:message code="M00592"/>',
	              '<spring:message code="M01329"/>', 
	              '<spring:message code="M01330"/>', 
	              '<spring:message code="M01331"/>', 
	              '<spring:message code="M01332"/>',
	              '<spring:message code="M01333"/>',
	              '<spring:message code="M01334"/>',
	              '<spring:message code="M01335"/>',
	              '<spring:message code="M01336"/>',
	              '<spring:message code="M02505"/>',
	              '<spring:message code="M00314"/>',
	              'cam_id'
	              ],
	              
	    colModel:[
	        {name:'cam_nm',index:'a.CAM_NM', resizable : false},
			{name:'cam_type_cd',index:'b.MARK_NAME', resizable : false},
			{name:'cam_start_dd',index:'a.CAM_START_DD', resizable : false, align:'center'},
			{name:'cam_end_dd',index:'a.CAM_END_DD', resizable : false, align:'center'},
			{name:'cam_status_cd',index:'c.MARK_NAME', resizable : false, align:'center'},
			{name:'approval',index:'d.mark_name', resizable : false, align:'center'},
			{name:'chnl_type_nm',index:'g.MARK_NAME', resizable : false},
			{name:'tgt_tot_cnt',index:'m.tgt_tot_cnt', resizable : false, align:'right'},
			{name:'ctrl_group_cnt',index:'k.CTRL_GROUP_CNT', resizable : false, align:'right'},	
			{name:'send_tot_cnt',index:'n.send_tot_cnt', resizable : false, align:'right'},
			{name:'offer_nm',index:'p.OFFER_NM', resizable : false},
			{name:'cam_id', index:'cam_id', resizable : false,  hidden : true,  searchable : false}
	    ],
	    sortname: 'cam_start_dd',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete2',
		radio : true
	};
	campaignResultGrid = $("#campaignResultGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//캠페인 실행 정보 그리드
function campaignExecution() {
	
	var jqGridOption = {
		serializeGridData : function( data ){
			console.log(cam_id);
			data.cam_id = cam_id;
			return data;
		},
	    url: '<ifvm:action name="getStnCampaignStatusDetailList"/>', 
	    colNames:['<spring:message code="M01338"/>',
	              '<spring:message code="M01339"/>', 
	              '<spring:message code="M01396"/>',
	              '<spring:message code="M01340"/>', 
	              '<spring:message code="M01341"/>',
	              '<spring:message code="M01342"/>',
	              '<spring:message code="M01343"/>',
	              '<spring:message code="M01344"/>',
	              '<spring:message code="M01345"/>'
	              ],
	              
	    colModel:[
				{name:'exe_seq',index:'b.EXE_SEQ', resizable : false, align:'center'},
				{name:'tgt_tot_cnt',index:'c.tgt_tot_cnt', resizable : false, align:'right'},
				{name:'send_tot_cnt',index:'d.send_tot_cnt', resizable : false, align:'right'},
				{name:'exe_info_status_cd',index:'d.mark_name', resizable : false},
				{name:'exe_info_status_bat_dtl_cd',index:'e.mark_name', resizable : false},
				{name:'exe_dt',index:'b.EXE_DT', resizable : false},
				
				{name:'min_start_dt',index:'e.MIN_START_DT', resizable : false},
				{name:'max_end_dt',index:'e.MAX_END_DT', resizable : false},
				{name:'bat_status',index:'e.bat_status', resizable : false}

	    ],
	    sortname: 'exe_seq',
		sortorder: "asc",
		tempId : 'ifvGridOriginTemplete2',
		radio : false
	};
	campaignExecutionGrid = $("#campaignExecutionGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function errorHistoryPopClose(){
	errorHistoryPop._destroy();
}

//공통 조회 조건 목록 설정
function campaignListSearchInit() {
    $.fn.ifvmSetCommonCondList("campaignViewList","STNCAM002");
}

$(document).ready(function(){
	campaignResult();
	campaignExecution();
	
	//캠페인 조회 리스트
	var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	$.fn.ifvmSetCommonCondList("campaignViewList",LeftMenuId);
	
	//오류내역조회
	$("#errorHistoryBtn").on("click", function(){
		$("#errorHistoryPop").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="errorHistoryPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01346"/>',
	        width: 900,
	        close : 'errorHistoryPopClose'
	    });
		errorHistoryPop = $("#errorHistoryPop").data("ejDialog");
	});
	
	//공통 조회 조건 목록 설정
    campaignListSearchInit();
	
  	//조회
    $('#campaignListSearchBtn').on('click', function(){
    	$.fn.ifvmSubmitSearchCondition("campaignViewList", campaignResult);
    });
    
    //초기화
    $("#campaignListSearchInitBtn").on('click', function(){
        $.fn.ifvmSetCommonCondList("campaignViewList","STNCAM002");
    });
    
    $("#commonDtlBtn").on('click', function(){
    	
    	var data = campaignResultGrid.getCheckedList()[0];
    	
    	if (typeof(data) == 'undefined') {
    		alert('<spring:message code="M00004" />');
    	}
    	else{
    		 qtjs.href('<ifvm:url name="stnCampaignSubjectsDetail"/>?cam_id=' + data.cam_id);
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

<!-- <div class="page-title"> -->
<!--     <h1> -->
<%--         <spring:message code="M01324" /> --%>
<%--         &gt; <spring:message code="M01325" /> --%>
<!--     </h1> -->
<!-- </div> -->

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M01326" /></span>
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
