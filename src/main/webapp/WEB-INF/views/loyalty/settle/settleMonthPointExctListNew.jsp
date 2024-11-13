<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleMonthPointAListGrid;

//등급그룹 목록 조회
function getSettleSolPayHistoryAList(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},
       	rowSelected : function(args){
       	},
       	dataUrl : '<ifvm:action name="getSettleMonthPointExctList"/>',
        columns:[ 
        	  {
	      		  field : 'yyyyMm' ,headerText : '계산기준일 ', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'yyyyMm' }/* 계산기준일 */
	      	  },{
	      		  field : 'acrlAmt', headerText : '적립 포인트 ', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'acrlAmt' , sortable: false}/* 적립 포인트*/
	      	  },{
	      		  field : 'rdmAmt', headerText : '사용포인트 ', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'rdmAmt' , sortable: false}/* 사용포인트  */
	      	  },{
	      		  field : 'expPnt', headerText : '소멸포인트', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'expPnt' , sortable: false}/*소멸포인트 */
	      	  },{
	      		  field : 'mExpPnt', headerText : '소멸포인트', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'mExpPnt' , sortable: false}/* 소멸포인트 */
	      	  },{
	      		  field : 'mRateChng', headerText : '증감율', headerTextAlign : 'center', textAlign: 'right',
	      		  customAttributes : {
	      			  index : 'mRateChng' , sortable: false}/* 증감율 */
	      	  },{
	      		  field : 'yExpPnt', headerText : '소멸포인트', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'yExpPnt' , sortable: false}/* 소멸포인트 */
	      	  },{
	      		  field : 'yRateChng', headerText : '증감율', headerTextAlign : 'center', textAlign: 'right',
	      		  customAttributes : {
	      			  index : 'yRateChng' , sortable: false}/* 증감율 */
	      	  }
        ],
        stackedHeaderRows: [{ 
            stackedHeaderColumns:[
            	{ headerText: "", column: "search_dt, base_dt, event_dt" },
                { headerText: "전월대비", column: "mExpPnt, mRateChng"  ,  headerTextAlign : "center" },
                { headerText: "전년대비", column: "yExpPnt, yRateChng"  ,  headerTextAlign : "center" },
            ] 
        }],
        actionComplete: function(args){
			$(this.getHeaderContent().find(".e-stackedHeaderCell")[1]).css("text-align", "center");
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[2]).css("text-align", "center");
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[3]).css("text-align", "center");
        },
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'yyyyMm',
	      	  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
	  	showStackedHeader:true,
        gridDataInit : false,
    	allowCellMerging : true,
        tempId : 'ifvGridSimplePageTemplete2'
    };
    
    settleMonthPointAListGrid = $("#settleMonthPointAListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회조건 필수값 체크
function validationCheck(table){
	var validationVal =  false;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('jointgtclm') == table){
			if($(this).parents('.SearchCondition').css("display") !="none"){
				if($.fn.ifvmIsNotEmpty( $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val())){
					validationVal = true;
				}
			}
		}
	})
	return validationVal;
}


//공통 조회 조건 목록 설정
function settleSolPayListSearchInit() {
    $.fn.ifvmSetCommonCondList("settleSolPayHistorySearchList","SETTLE_MONTH_POINT_EXCT_LIST");
    
    $(".searchTextVal option:selected").filter(function(){
        $(this).parents('.SearchCondition').find('.searchCondition option[value="NOT"]').remove();
    })
}

//공통 조회 호출
function settleDayAListSearch() {
	if(validationCheck("YYYY")){
		$.fn.ifvmSubmitSearchCondition("settleSolPayHistorySearchList",function() {
			settleMonthPointAListGrid.searchGrid({ item:requestitem });
		});
	}else{
		alert("년도를 입력해주세요.");
	}
} 

//엑셀 다운로드 
function settleSolPayHistoryListExcelExport() {
	$.ifvExcelDn('/loyalty/settle/getSettleMonthPointExctListExcel.do','settleMonthPointAListGrid');
}

$(document).ready(function() {
	
    //공통 조회 조건 목록 설정
    settleSolPayListSearchInit();
    
    //전체 그리드 조회
    getSettleSolPayHistoryAList();
    
    //조회
    $('#settleSolPayAListSearchBtn').on('click', function(){
    	settleDayAListSearch();
    });
    
    //초기화
    $("#settleSolPayAListSearchInitBtn").on('click', function(){
    	settleSolPayListSearchInit();
    });
    
  	//엑셀 다운로드
    $("#settleSolPayHistoryListExcelExportBtn").on('click', function(){
    	settleSolPayHistoryListExcelExport();
    });
});

</script>

<div class="page-title">
    <h1>
         <spring:message code="M02827" /> 
        &gt; 포인트 소멸 조회(월기준)
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleSolPayAListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="settleSolPayAListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    
    <div class="well form-horizontal well_bt5" id="settleSolPayHistorySearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" id =''>

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleSolPayHistoryListExcelExportBtn">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="settleMonthPointAListGrid" class="white_bg grid_bd0"></div> 
</div>
