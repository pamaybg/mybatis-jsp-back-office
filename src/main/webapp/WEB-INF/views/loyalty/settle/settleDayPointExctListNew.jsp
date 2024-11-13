<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleSolPayHistoryAListGrid;

var yyyy;
var mm;
var dd;

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
       	dataUrl : '<ifvm:action name="getSettleDayPointExctList"/>',
        columns:[
        	  {
	      		  field : 'search_dt' ,headerText : '계산기준일 ', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'search_dt' , sortable: false}/* 계산기준일 */
	      	  },{
	      		  field : 'b_acrl_amt', headerText : '적립 포인트 ', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'e_acrl_amt', sortable: false }/* 적립 포인트*/
	      	  },{
	      		  field : 'e_acrl_amt', headerText : '적립 포인트 ', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'e_acrl_amt' , sortable: false}/* 이벤트  */
	      	  },{
	      		  field : 'c_acrl_amt', headerText : '적립 포인트 ', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'c_acrl_amt' , sortable: false}/*만료포인트 */
	      	  },{
	      		  field : 'rdm_amt', headerText : '사용 포인트', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'rdm_amt' , sortable: false}/* 사용포인트 */
	      	  },{
	      		  field : 'exp_pnt', headerText : '소멸 포인트', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'exp_pnt' , sortable: false}/* 소멸 포인트 */
	      	  }
        ],
		loadComplete: function(args){
			$('#settleSolPayHistoryAListGrid').find('.e-gridcontent tbody tr').eq(0).children('td').eq(1).css({"text-align": "center"})
			$('#settleSolPayHistoryAListGrid').find('.e-gridcontent tbody tr').eq(0).children('td').eq(2).css({"text-align": "center"})
			$('#settleSolPayHistoryAListGrid').find('.e-gridcontent tbody tr').eq(0).children('td').eq(3).css({"text-align": "center"})
			$('#settleSolPayHistoryAListGrid').find('.e-gridcontent tbody tr').eq(0).children('td').eq(4).css({"text-align": "center"})
			$('#settleSolPayHistoryAListGrid').find('.e-gridcontent tbody tr').eq(0).children('td').eq(5).css({"text-align": "center"})
        },
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'search_dt',
	      	  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
	    //showStackedHeader:true,
        gridDataInit : false,
    	allowCellMerging : true,
        tempId : 'ifvGridSimplePageTemplete2'
    };

    settleSolPayHistoryAListGrid = $("#settleSolPayHistoryAListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회조건 필수값 체크
function validationCheck(table){
	var validationVal =  false;

	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('grpcode') == table){
			if($(this).parents('.SearchCondition').css("display") !="none"){
				if($.fn.ifvmIsNotEmpty( $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val())){
					validationVal = true;
					if(table == "SETTLE_YEAR"){
						yyyy = $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val()
					}else if(table == "SETTLE_MONTH"){
						mm = $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val()
					}else if(table == "LOY_SETTLE_DAY"){
						dd = $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val()
					}
				}
			}
		}
	})
	return validationVal;
}


//공통 조회 조건 목록 설정
function settleSolPayListSearchInit() {
    $.fn.ifvmSetCommonCondList("settleSolPayHistorySearchList","SETTLE_DAY_POINT_EXCT_LIST");

    $(".searchTextVal option:selected").filter(function(){
        $(this).parents('.SearchCondition').find('.searchCondition option[value="NOT"]').remove();
        $(this).parents('.SearchCondition').find('option[value="ALL"]').remove();
    })
}

//공통 조회 호출
function settleDayAListSearch() {
	if(validationCheck("SETTLE_YEAR") && validationCheck("SETTLE_MONTH") && validationCheck("LOY_SETTLE_DAY")){
		$.fn.ifvmSubmitSearchCondition("settleSolPayHistorySearchList",function() {
			settleSolPayHistoryAListGrid.searchGrid({
				item:requestitem,
				yyyy : yyyy,
				mm : mm,
				dd : dd
				});
		});
	}else{
		alert("조회조건을 모두 입력해주세요.");
	}
}

//엑셀 다운로드
function settleSolPayHistoryListExcelExport() {
	$.ifvExcelDn('/loyalty/settle/getSettleDayPointExctListExcel.do','settleSolPayHistoryAListGrid');
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
        &gt; 포인트 소멸 조회(일기준)
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
    <div id="settleSolPayHistoryAListGrid" class="white_bg grid_bd0"></div>
</div>
