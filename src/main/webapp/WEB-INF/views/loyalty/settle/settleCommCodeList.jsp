<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleMonthAcculUseGrid;
var yyyy;
var mm;

var headerArr = ["CHNL_NM", "CHNL_NO", "FIX_DAT"];

//등급그룹 목록 조회
function getSettleMonthAcculUseList(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
            return data;
       	},
		loadComplete : function(obj){
			$('.e-gridheader').css("overflow-x", "hidden");
			$('.e-gridcontent').css("overflow-x", "scroll");
			$('.e-gridheader').bind("scroll", function(){
				$('.e-gridcontent').scrollTop($(this).scrollTop());
				$('.e-gridcontent').scrollLeft($(this).scrollLeft());
			});
			$('.e-gridcontent').bind("scroll", function(){
				$('.e-gridheader').scrollTop($(this).scrollTop());
				$('.e-gridheader').scrollLeft($(this).scrollLeft());
			});
		},
       	dataUrl : '<ifvm:action name="getSettleCommCodeList"/>',
        columns:[ 
        	  {
	      		  field : 'CHNL_NM', headerText : '매장명', headerTextAlign : 'center', textAlign: 'left', width : "100px",
	      		  customAttributes : {
	      			  index : 'chnl_nm' , sortable: false}/* 매장명 */
	      	  },{
	      		  field : 'CHNL_NO', headerText : '매장코드', headerTextAlign : 'center', textAlign: 'left',width : "100px",
	      		  customAttributes : {
	      			  index : 'chnl_no' , sortable: false }/* 매장코드 */
	      	  },{
	      		  field : 'FIX_DAT', headerText : '확정일', headerTextAlign : 'center', textAlign: 'center',width : "100px",
	      		  customAttributes : {
	      			  index : 'fix_dat' , sortable: false}/* 확정일 */
	      	  }
	      	  
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  _search : false
	    },
	    rowList : [10,25,50, 100],
        gridDataInit : false,
        tempId : 'ifvGridOriginTemplete'
    };
    
    settleMonthAcculUseGrid = $("#settleMonthAcculUseList").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function settleDayMonthAcculUseListSearchInit() {
    $.fn.ifvmSetCommonCondList("settleMonthHistorySearchList","SETTLE_MONTH_HISTORY");
}

//공통 조회조건 필수값 체크
function validationCheck(table){
	var validationVal =  false;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('grpcode') == table){
			if($(this).parents('.SearchCondition').css("display") !="none"){
				if($.fn.ifvmIsNotEmpty( $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val())){
					validationVal = true;
					if(table == 'SETTLE_YEAR'){
						
						yyyy = $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val();
						
						validationVal = true;
					}else if(table = 'SETTLE_MONTH'){
						mm = $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val();
							validationVal = true;
						}
				}
			}
		}
	})
	return validationVal;
}


//공통 조회조건 필수값 체크
function validationCheck2(table){
	var validationVal =  false;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if($(this).attr('grpcode') == table){
			if($(this).parents('.SearchCondition').css("display") !="none"){
				if($.fn.ifvmIsNotEmpty( $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val())){
					validationVal = true;
					if(table == 'SETTLE_YEAR'){
						var dateTime = new Date();
						var yyyyVal;
						
						yyyy = $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val();
						
						yyyyVal = Number(yyyy);
						if(yyyyVal >2018 && yyyyVal <= dateTime.getFullYear()){
							validationVal = true;
						}else{
							validationVal = false;
						}
					}else if(table = 'SETTLE_MONTH'){
						var dateTime = new Date();
						var yyyyVal = $(".SearchCondition .searchTextVal option:selected[grpcode=SETTLE_YEAR]").parents('.SearchCondition').find('.changeTypeAreaCode  select').val();
						yyyyVal = Number(yyyyVal);
						mm = $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val();
						
						mmVal = Number(mm);
						if(yyyyVal < dateTime.getFullYear() && yyyyVal >2018){
						}else if(yyyyVal == dateTime.getFullYear()){
							if(mmVal <= (dateTime.getMonth() +1)){
								validationVal = true;
							}else{
								validationVal = false;
							}
						}
					}
				}
			}
		}
	})
	return validationVal;
}


function searchSettleCommCodeList(){
	$.ifvSyncPostJSON('<ifvm:action name="getSettleCommCodeHeader"/>', {
		item : requestitem,
		yyyy : yyyy,
        mm : mm
    }, function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
			var columnsData = [];
			columnsData = settleMonthAcculUseGrid.opt.ejGridOption.columns;
			var headerInfo = JSON.parse(result.message);
			var headerKeyArr = Object.getOwnPropertyNames(headerInfo);
			
			for(var i=0; i<headerKeyArr.length; i++){
				var columnData = {};
				if(headerArr.includes(headerKeyArr[i])){
					columnData = {
				      		  field : '', headerText : '', headerTextAlign : 'center', textAlign: 'center', width : "100px",
				      		  customAttributes : {
				      			  index : '' , sortable: false}
				      	  }
				}else{
					columnData = {
				      		  field : '', headerText : '', headerTextAlign : 'center', textAlign: 'right', width : "160px", format : '{0:n0}',
				      		  customAttributes : {
				      			  index : '' , sortable: false}
				      	  }
				}
				
				columnData.field = headerKeyArr[i];
				columnData.headerText = headerInfo[headerKeyArr[i]];
				columnData.customAttributes.index = headerKeyArr[i];
				columnsData.push(columnData);
			}
        	
			
			settleMonthAcculUseGrid.opt.ejGridOption.columns = columnsData;
			settleMonthAcculUseGrid._makeGrid();
        	settleMonthAcculUseGrid.searchGrid({
        		item : requestitem,
        		yyyy : yyyy,
        		mm : mm
        	});

        }
    });
	
}

//공통 조회 호출
function settleDayMonthAcculUseListSearch() {
	if(validationCheck("SETTLE_YEAR") && validationCheck("SETTLE_MONTH")){
		if(validationCheck2("SETTLE_YEAR") && validationCheck2("SETTLE_MONTH")){
			$.fn.ifvmSubmitSearchCondition("settleMonthHistorySearchList",function() {
				searchSettleCommCodeList();
			});
		}else{
			alert("2019년부터 현재 달까지의 데이터만 조회 할 수 있습니다.")
		}
	}else{
		alert("년도와 월을 모두 입력해주세요");
	}
};


$(document).ready(function() {
	getSettleMonthAcculUseList();
    
    //공통 조회 조건 목록 설정
    settleDayMonthAcculUseListSearchInit();
    
    //조회
    $('#settleDayCListSearchBtn').on('click', function(){
    	settleDayMonthAcculUseListSearch();
    });
    
    //초기화
    $("#settleDayCListSearchInitBtn").on('click', function(){
    	settleDayMonthAcculUseListSearchInit();
    });
    
    $("#excelListBtn").on('click', function() {
      	$.ifvExcelDn('/loyalty/settle/getSettleCommCodeExcel.do','settleMonthAcculUseList' );
    });
    
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="M02827" /> 
        &gt; 본사 공통코드 	상세 내역
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="settleDayCListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="settleDayCListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="settleMonthHistorySearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="excelListBtn">
				<spring:message code="M01218" />
			</button>
		</div>
    </div>
    <div id="settleMonthAcculUseList" class="white_bg grid_bd0"></div>     
</div>
