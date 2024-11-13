<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var campaignResultGrid;
var campaignExecutionGrid;
var errorHistoryPop;

//조회결과 그리드
function campaignResultGrid(){
	
	var jqGridOption = {
		serializeGridData : function( data ){
			
		},
		onSelectRow : function(){
			qtjs.href('<ifvm:url name="reactionInfoDetail"/>');
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
		tempId : 'ifvGridOriginTemplete2',
		radio : true
	};
	campaignResultGrid = $("#campaignResultGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//캠페인 실행 정보 그리드
function campaignExecutionGrid(){
    alert(2);
	
	var jqGridOption = {
		serializeGridData : function( data ){
			
		},
		onSelectRow : function(){
			
		},
	    //url: '<ifvm:action name="getListOffer"/>', 
	    colNames:['<spring:message code="M01338"/>',
	              '<spring:message code="M01339"/>', 
	              '<spring:message code="M01340"/>', 
	              '<spring:message code="M01341"/>', 
	              '<spring:message code="M01342"/>',
	              '<spring:message code="M01343"/>',
	              '<spring:message code="M01344"/>',
	              '<spring:message code="M01345"/>'
	              ],
	              
	    colModel:[
	        {name:'',index:'', resizable : false, align:'center'},
	        {name:'',index:'', resizable : false, align:'right'},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false, align:'center'},
	        {name:'',index:'', resizable : false, align:'center'},
	        {name:'',index:'', resizable : false, align:'center'},
	        {name:'',index:'', resizable : false}	
	    ],
	    sortname: '',
		sortorder: "desc",
		tempId : 'ifvGridExecutionTemplete',
		radio : true
	};
	campaignExecutionGrid = $("#campaignExecutionGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function errorHistoryPopClose(){
	errorHistoryPop._destroy();
}

$(document).ready(function(){
	campaignResultGrid();
	campaignExecutionGrid();
	
	//캠페인 조회 리스트
	/* var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	$.fn.ifvmSetCommonCondList("campaignViewList",LeftMenuId); */
	
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
        <spring:message code="M01324" />
        &gt; <spring:message code="M01325" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M01326" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="">
            	<i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="campaignViewList"></div>
</div>

<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-12">
            <span><spring:message code="M00277" /></span>
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
