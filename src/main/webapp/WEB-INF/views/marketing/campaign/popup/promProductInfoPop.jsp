<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var targetProductInfoPopValidation;
var promProductPopListGrid;

function setPromProductPopListGridInit(){
	var jqGridOption = {
		/* serializeGridData : function( data ){
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }    
    		return data;
		}, */
		//url : '<ifvm:action name="getPromProductPopListNew"/>',
		colNames:[
            '상품명',
            '상품분류명',
            '상품분류코드',
            '상품품번코드',
            '판매가격',
            'barCod',
          ],
		 colModel:[
		     {name:'gdsNam'		,index:'gdsNam' ,width:'100px', align:'center', resizable : false},
		     {name:'etcSnam'	,index:'etcSnam',width:'130px', align:'left'  , resizable : false},
		     {name:'etcCod'		,index:'etcCod' ,width:'80px' , align:'center', resizable : false},
		     {name:'gdsNum'		,index:'gdsNum' ,width:'70px', align:'center', resizable : false},
		     {name:'salePrc'	,index:'salePrc',width:'80px', align:'right' , resizable : false,formatter : 'integer'},
		 	 {name:'barCod'		,index:'barCod', hidden:true} 
		 ],
	sortname: 'etcCod',
	sortorder: "desc",
	rowList : [10,25,50,100],
	tempId : 'ifvGridNonFilterTemplete',
	multiselect: true,
	};
 
	promProductListGrid = $("#promProductPopList").ifvGrid({ jqGridOption : jqGridOption });	
}

function setPromProductPopListGrid(){
	var jqGridOption = {
		 serializeGridData : function( data ){
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }    
    		return data;
		},
		url : '<ifvm:action name="getPromProductPopListNew"/>',
		colNames:[
            '상품명',
            '상품분류명',
            '상품분류코드',
            '상품품번코드',
            '판매가격',
            'barCod',
          ],
		 colModel:[
		     {name:'gdsNam'		,index:'gdsNam' ,width:'100px', align:'center', resizable : false},
		     {name:'etcSnam'	,index:'etcSnam',width:'130px', align:'left'  , resizable : false},
		     {name:'etcCod'		,index:'etcCod' ,width:'80px' , align:'center', resizable : false},
		     {name:'gdsNum'		,index:'gdsNum' ,width:'70px', align:'center', resizable : false},
		     {name:'salePrc'	,index:'salePrc',width:'80px', align:'right' , resizable : false,formatter : 'integer'},
		 	 {name:'barCod'		,index:'barCod', hidden:true} 
		 ],
	sortname: 'etcCod',
	sortorder: "desc",
	rowList : [10,25,50,100],
	tempId : 'ifvGridNonFilterTemplete',
	multiselect: true,
	};
 
	promProductListGrid = $("#promProductPopList").ifvGrid({ jqGridOption : jqGridOption });	
}

 //프로모션 상품 저장
/* function promProductInfoPopupSave(){
	//프로모션 상품목록
	ruleSetData.promProductPopList = promProductPopListGrid.opt.gridControl.getSelectedRecords();
	//팝업닫기 
	promProductInfoPopClose();
} */


//프로모션 상품목록 저장
 function promProductPopSave(){
	 var dataObj = {};
	 var valid;
	dataObj.rulesetPromProductList=[];
	dataObj.rulesetPromProductList = promProductListGrid.getCheckedList();
	dataObj.ridMktCamMst = camRid;
			
	if(promProductListGrid.getCheckedGridData().length==0){
		alert("상품을 선택해주세요");
		return;
	}
	
	//중복상품 여부판단
	$.ifvSyncPostJSON('<ifvm:action name="getProductPromValid"/>', dataObj ,
	function(result) {
		valid = false;
	},function(result){
		valid = true; 
	});
	
	if(valid == false){
		alert('대상상품 리스트에 중복된 상품이 있습니다.');
		return;
	}	
	
	var data ={}
	data.rulesetPromProductList=[];
	data.rulesetPromProductList = promProductListGrid.getCheckedList();
	data.prodRId = rowData;

	$.ifvSyncPostJSON('<ifvm:action name="setPromProduct"/>', data,
	function(result) {
		alert('저장되었습니다.');
	 	//조회
	 	setTargetPromProductListGrid(rowData);
		promProductInfoPopClose();
	});
	
} 

//공통 조회조건 호출
function promProductListSearch(){
	if(validationCheck()){
		$.fn.ifvmSubmitSearchCondition("promProductPopSearchList",setPromProductPopListGrid);
	}else{
		alert('조회조건을 입력해 주세요.')
	}
}

//공통 조회조건 목록 설정
function promProductListSearchInit(){
	 $.fn.ifvmSetCommonCondList("promProductPopSearchList","R_PROM_PRODUCT");
}

//공통 조회조건 필수값 체크
function validationCheck(){
	var validationVal =  false;
	var searchValid =  $.fn.ifvmIsNotEmpty($('.ifvm_comm_cond_text').val());
	if(searchValid){
		validationVal = true;
	}
	return validationVal;
}

 $(document).ready(function() {
	setPromProductPopListGridInit();
	promProductListSearchInit();
	
	//저장
	 $('#promProductInfoPopSaveBtn').on('click', function() {
		promProductPopSave();
    }); 
	
	//닫기
	$('#promProductInfoPopCancelBtn').on('click', function() {
		promProductInfoPopClose();
    });
	
    // 조회
    $('#promProductListSearchBtn').on('click', function() {
    	promProductListSearch();
    });

    // 초기화
    $("#promProductListSearchInitBtn").on('click', function() {
    	promProductListSearchInit();
    });
    
});
</script>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00739" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="promProductListSearchBtn">
            	<i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="promProductListSearchInitBtn">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="promProductPopSearchList" >
    </div>
</div>
<div id="promProductInfoPopWrap">
	<div id = "promProductPopList" class="white_bg grid_bd0"></div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="promProductInfoPopSaveBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button> 
	    <button class="btn btn-sm btn_lightGray2" id="promProductInfoPopCancelBtn">
	        	닫기
	    </button>
	</div>
</div>
