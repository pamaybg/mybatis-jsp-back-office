<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var campaignInfoGrid;
var campaignSubjectReactGrid;
var channelUnsentPop;

//캠페인 정보 그리드
function campaignInfoGrid(){
	
	var jqGridOption = {
		serializeGridData : function( data ){
			
		},
		onSelectRow : function(){
			
		},
	    //url: '<ifvm:action name="getListOffer"/>', 
	    colNames:['<spring:message code="M01328"/>',
	              '<spring:message code="M01329"/>', 
	              '<spring:message code="M01330"/>', 
	              '<spring:message code="M01331"/>', 
	              '<spring:message code="M01332"/>',
	              '<spring:message code="M01333"/>',
	              '<spring:message code="M01334"/>',
	              '<spring:message code="M01335"/>',
	              '<spring:message code="M01336"/>'
	              ],
	              
	    colModel:[
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false, align:'center'},
	        {name:'',index:'', resizable : false, align:'center'},
	        {name:'',index:'', resizable : false, align:'center'},
	        {name:'',index:'', resizable : false, align:'center'},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false, align:'right'},
	        {name:'',index:'', resizable : false, align:'right'}	
	    ],
	    sortname: '',
		sortorder: "desc",
		tempId : 'ifvGridSingleTemplete'
	};
	campaignInfoGrid = $("#campaignInfoGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//대상자 목록 조회
function getGridReactionInfo(){
	/* $.ifvSyncPostJSON('<ifvm:action name="getSegColNames"/>'
	,function(result) { 
 		if(result.length > 0){*/
			var colNames = ['<spring:message code="M01338"/>',
			              '<spring:message code="M01359"/>', 
			              '<spring:message code="M01340"/>', 
			              '<spring:message code="M01360"/>', 
			              '<spring:message code="M01361"/>',
			              '<spring:message code="M01362"/>',
			              '<spring:message code="M01363"/>',
			              '<spring:message code="M01364"/>'
			              ];
			var colModel = [
			    	        {name:'',index:'', resizable : false},
			    	        {name:'',index:'', resizable : false, align:'center'},
			    	        {name:'',index:'', resizable : false},
			    	        {name:'',index:'', resizable : false},
			    	        {name:'',index:'', resizable : false, align:'center'},
			    	        {name:'',index:'', resizable : false, align:'center'},
			    	        {name:'',index:'', resizable : false, align:'center'},
			    	        {name:'',index:'', resizable : false}
			    	        
			    	    ];
			/* for(var i = 0; i < result.length; i++) {
				colNames.push(result[i].colKorName);
				colModel.push({index:result[i].colEngName, name:result[i].colEngName, resizable: false, align:'center'});				
			} */

			var widthUnit = 120;
			var totalUnitLength = parseInt(widthUnit * colModel.length);
			var parentLength = parseInt($('#campaignSubjectReactGrid').width());
			var targetListGridWidth;
			
			if(totalUnitLength < parentLength)
				targetListGridWidth = parentLength;
			else
				targetListGridWidth = totalUnitLength;
			
			
			var gridWidth = $("#campaignSubjectReactGrid").width();
			$('#campaignSubjectReactGrid').css('width', targetListGridWidth);
			
			campaignSubjectReactGrid(colNames, colModel);
			
			$("#campaignSubjectReactGrid .filter_area").css({'width': gridWidth});
			$("#campaignSubjectReactGrid .grid_scroll").css({'width': gridWidth, 'overflow-x': 'auto', 'overflow-y': 'hidden'});
		    
		//}
		
	//}); 
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

$(document).ready(function(){
	$.ifvmLnbSetting('campaignSubjectsList');	//좌측네비게이션 활성화
	campaignInfoGrid();
	getGridReactionInfo();
	
	//오류내역조회
	$("#channelUnsentReasonsBtn").on("click", function(){
		$("#channelUnsentPop").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="channelUnsentPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01357"/>',
	        width: 900,
	        close : 'channelUnsentPopClose'
	    });
		channelUnsentPop = $("#channelUnsentPop").data("ejDialog");
	});
	
	//목록 버튼
	$("#reactionListBtn").on("click", function(){
		qtjs.href('<ifvm:url name="reactionInfoList"/>');
	});
	
	$(window).on('resize', function(){
		var gridWidth = $("#SubjectReactGridWrap").width();
		$("#campaignSubjectReactGrid .filter_area").css({'width': gridWidth});
		$("#campaignSubjectReactGrid .grid_scroll").css({'width': gridWidth, 'overflow-x': 'auto', 'overflow-y': 'hidden'});
	}); 
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
                <spring:message code="M01323" />
            </button> 
        </div>
    </div>
    <div id="campaignInfoGrid" class="grid_bd0"></div>
</div>

<!-- 캠페인 대상자 반응 조회 -->
<div class="mg_top20">
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M01353" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="">
                <spring:message code="M01356" />
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
