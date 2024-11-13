<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>
var campaignInfoGrid;
var campaignSubjectReactGrid;
var channelUnsentPop;
var resendHistoryPop;
var cam_id = '<%= cleanXss(request.getParameter("cam_id")) %>';

//캠페인 정보 그리드
function campaignInfoGrid(){
	
	var jqGridOption = {
		serializeGridData : function( data ){
			data.cam_id = cam_id;
			return data;
		},
		onSelectRow : function(){
			
		},
		loadComplete : function( data ){
			//$.fn.ifvmSubmitSearchCondition("getGridReactionInfo", getGridReactionInfo);
			getGridReactionInfo();
		},
	    url: '<ifvm:action name="getCampaignStatusList"/>', 
	    colNames:['<spring:message code="M00592"/>',
	              '<spring:message code="M01058"/>', 
	              '<spring:message code="M01330"/>', 
	              '<spring:message code="M01331"/>', 
	              '<spring:message code="M01332"/>',
	              '<spring:message code="M01333"/>',
	              '<spring:message code="M01334"/>',
	              '<spring:message code="M01335"/>',
	              '<spring:message code="M01336"/>',
	              'cam_id',
	              'chnl_type',
	              'offer_type'
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
			{name:'cam_id', index:'cam_id', resizable : false,  hidden : true,  searchable : false},
			{name:'chnl_type', index:'chnl_type', resizable : false,  hidden : true,  searchable : false},
			{name:'offer_type', index:'offer_type', resizable : false,  hidden : true,  searchable : false}
	    ],
	    sortname: 'cam_id',
		sortorder: "desc",
		tempId : 'ifvGridSingleTemplete'
	};
	campaignInfoGrid = $("#campaignInfoGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//대상자 목록 조회
function getGridReactionInfo(){
	
	var paramColNames = ['<spring:message code="M01338"/>',
			              '<spring:message code="M01359"/>', 
			              '<spring:message code="M01340"/>', 
			              '<spring:message code="M01360"/>', 
			              '<spring:message code="M01361"/>',
			              '<spring:message code="M01362"/>',
			              '<spring:message code="M01363"/>',
			              '<spring:message code="M00342"/>'
			              ];
		var paramColModel = [
		    	        {name:'exe_seq',index:'a.exe_seq', resizable : false, align:'center', width:70},
						{name:'exe_dt',index:'a.exe_dt', resizable : false, align:'center'},
						{name:'exe_info_status_cd',index:'a.exe_info_status_cd', resizable : false},
						{name:'mem_id',index:'a.mem_id', resizable : false, width:90},
						{name:'con_yn',index:'a.con_yn', resizable : false, align:'center'},
						{name:'chan_send_yn',index:'a.chan_send_yn', resizable : false, align:'center'},
						{name:'user_yn',index:'a.user_yn', resizable : false, align:'center'},
						{name:'bnf_value',index:'a.bnf_value', resizable : false, width: 110}
		    	    ];
		
		var chnlType = campaignInfoGrid.getRowData()[0].chnl_type;
		
		if (chnlType == "MMS" || chnlType == "LMS") {
			chnlType = "SMS";
		}
		
// 		console.log(chnlType);
		
	    //채널별 반응정보 마스터 목록 조회
	    $.ifvSyncPostJSON('<ifvm:action name="getRspnsInfoMstList"/>', { 
	    	spcfChnlRspnsCd: chnlType
	    },
	    function(result) {
	    	rspnsList = result;
// 	        console.log(rspnsList);
	    });
	    
	    //model length
	    var paramColModelLen = paramColNames.length + 1;

	    //col Model
	    $.each(rspnsList, function(index, data) {
	    	data.index = paramColModelLen + index;
	    	paramColNames.push(data.responseName);
	    	paramColModel.push({index: 'camRspnsCd', name: 'camRspnsCd', resizable: false, align:'center', formatter: rspnsFormatter});
	    });
		
		paramColNames.push('tgt_dtl_id');
	 	paramColModel.push({name:'tgt_dtl_id', index:'tgt_dtl_id', resizable : false,  hidden : true,  searchable : false});
		
		var jqGridOption = {
				serializeGridData : function( data ){
					data.cam_id = cam_id;
					return data;
				},
				onSelectRow : function(){
					
				},
			    url: '<ifvm:action name="getCampaignDetailList"/>', 
			    colNames: paramColNames,
			    colModel: paramColModel,
			    sortname: 'exe_seq',
				sortorder: "asc",
				tempId : 'ifvGridOriginTemplete2',
				radio : true
		};
		
		campaignSubjectReactGrid = $("#campaignSubjectReactGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//방응정보 컬럼 설정
function rspnsFormatter(cellValue, options, rowdata){
	if (typeof cellValue == "undefined") cellValue = "";
	var value = $.fn.ifvmIsEmpty(cellValue) ? "" : cellValue;
	var arrValue = value.split(',');
	
	var rtnValue = "";
	
	$.each(rspnsList, function(index, data) {
		if (options.pos == data.index) {
			var code = data.responseCode;
			return $.each(arrValue, function(index, data) {
				if (code == data) {
					rtnValue = "Y";
					
					return false;
				}
			})
		}
	});
	
    return rtnValue;
}

//캠페인 대상자 반응 조회 그리드
function campaignSubjectReactGrid(colNames, colModel){
	
	var jqGridOption = {
		serializeGridData : function( data ){
			
		},
		onSelectRow : function(){
			
		},
	    //url: '<ifvm:action name="getListOffer"/>', 
	    colNames:colNames,
	    colModel:colModel,
	    sortname: '',
		sortorder: "desc",
		tempId : 'ifvGridScrollTemplete',
		radio : true
	};
	campaignSubjectReactGrid = $("#campaignSubjectReactGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function channelUnsentPopClose(){
	channelUnsentPop._destroy();
}

function resendHistoryPopClose(){
	resendHistoryPop._destroy();
}

$(document).ready(function(){
	$.ifvmLnbSetting('campaignSubjectsList');	//좌측네비게이션 활성화
	campaignInfoGrid();
	//오류내역조회
	$("#channelUnsentReasonsBtn").on("click", function(){
		
		var rowData = campaignSubjectReactGrid.getCheckedGridData()[0];
		
		if( rowData != null ){
			$("#channelUnsentPop").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="channelUnsentPop"/>?tgt_dtl_id='+rowData.tgt_dtl_id,
		        contentType: "ajax",
		        title: '<spring:message code="M01357"/>',
		        width: 900,
		        close : 'channelUnsentPopClose'
		    });
		} else {
			alert('<spring:message code="M00004"/>');
		}
	});
	
	//엑셀 다운로드
	$("#excelCampaignDetailListBtn").on("click", function(){
		if(campaignInfoGrid.getRowData()[0].chnl_type == ""){
			alert('<spring:message code="S00045"/>');
		} else {
			qtjs.href('<ifvm:action name="excelCampaignDetailList"/>'+"?cam_id="+cam_id);
		}
	});
	
	//목록 버튼
	$("#reactionListBtn").on("click", function(){
		qtjs.href('<ifvm:url name="campaignSubjectsList"/>');
	});
	
	$(window).on('resize', function(){
		var gridWidth = $("#SubjectReactGridWrap").width();
		$("#campaignSubjectReactGrid .filter_area").css({'width': gridWidth});
		$("#campaignSubjectReactGrid .grid_scroll").css({'width': gridWidth, 'overflow-x': 'auto', 'overflow-y': 'hidden'});
	}); 
	
	
	
// 	//채널 재전송 추가
// 	$("#chnlReSend").on("click", function(){
		
// // 		
// 		var selectData = campaignSubjectReactGrid.getCheckedGridData();
		
// 		if(selectData != null && selectData.length > 0){
			
// 			if(selectData[0].con_yn == 'Y'){
// 				alert('<spring:message code="M01654"/>');
// 			}
// 			else if(campaignInfoGrid.getRowData()[0].chnl_type == "CALL"){
// 				alert('<spring:message code="M01655"/>');
// 			}
// 			else if(campaignInfoGrid.getRowData()[0].chnl_type == ""){
// 				alert('<spring:message code="S00045"/>');
// 			}
// 			else{
				
// 				if (confirm('<spring:message code="M01360"/> ' + '[' + selectData[0].mem_id + ']' + ' <spring:message code="M01656"/> ')) {
					
// 					$.ifvSyncPostJSON('<ifvm:action name="chnlReSend"/>',{
// 						tgtDtlId	: selectData[0].tgt_dtl_id
// 					},function(result) {
// 						alert('<spring:message code="M01657"/>');
// 					});
					
// 				} else {
					
// 				}
				
// 			}
			
// 		}
// 		else{
// 			alert('<spring:message code="M00004"/>');
// 		}
		
		
// 	});
	
// 	//채널 재전송 추가
// 	$("#chnlReSendHistory").on("click", function(){
		
// 		if(campaignInfoGrid.getRowData()[0].chnl_type == "") {
// 			alert('<spring:message code="S00045"/>');
// 			return false;
// 		}
		
// 		$("#resendHistoryPop").ifvsfPopup({
// 			enableModal : true,
// 	        enableResize: false,
// 	        contentUrl: '<ifvm:url name="resendHistoryPop"/>?camId='+cam_id,
// 	        contentType: "ajax",
// 	        title: '<spring:message code="M01658"/>',
// 	        width: 900,
// 	        close : 'resendHistoryPopClose'
// 	    });
// 	});
	
	
	
	
});
</script>

<script id="ifvGridSingleTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="grid_con">
			{grid}
		</div>
	</div>
</script>

<script id="ifvGridScrollTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		{title}

		<div class="filter_area">
			<div class="left">
				{searchBox}
			</div>
			<div class="right">
				{rowsBox}
			</div>
		</div>
		<div class="grid_scroll">
			<div class="grid_con">
				{grid}
			</div>
			<div class="page">
				{page}
				<div class="total_area">{total}</div>	
			<div>
		</div>
	</div>
</script>

<div class="page-title">
    <h1>
        <spring:message code="M01353" />
        &gt; <spring:message code="M01354" />
    </h1>
</div>

<!-- 캠페인 정보 -->
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M01355" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reactionListBtn">
                <spring:message code="M00002" />
            </button> 
        </div>
    </div>
    <div id="campaignInfoGrid" class="grid_bd0"></div>
</div>

<!-- 캠페인 대상자 반응 조회 -->
<div class="mg_top20">
    <div class="page_btn_area" id=''>
        <div class="col-xs-6">
            <span><spring:message code="M01353" /></span>
        </div>
        <div class="col-xs-6 searchbtn_r">
<!--          	<button class="btn btn-sm" id="chnlReSend"> -->
<%--             		<spring:message code="M01422" /> --%>
<!--             </button>  -->
<!--              <button class="btn btn-sm" id="chnlReSendHistory"> -->
<%--                 	<spring:message code="M01423" /> --%>
<!--             </button>  -->
            <button class="btn btn-sm" id="excelCampaignDetailListBtn">
                <spring:message code="M01218" />
            </button> 
            <button class="btn btn-sm" id="channelUnsentReasonsBtn">
                <spring:message code="M01357" />
            </button> 
        </div>
    </div>
    <div class="modal-open" id="SubjectReactGridWrap">
    	<div id="campaignSubjectReactGrid" class="grid_bd0"></div>
    </div>
</div>

<div id="channelUnsentPop" class="popup_container"></div>

<div id="resendHistoryPop" class="popup_container"></div>
