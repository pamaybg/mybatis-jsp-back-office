<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var categoryListGrid;
var rid;
var catId;

//팝업 닫기
function categoryPopupClose() {
	dialog._destroy();
}

//상품카테고리 목록 조회
function getCategoryList(){
    var ejGridOption = {
   		recordDoubleClick : function(args){
       		var data = args.data;
       		rid = data.rid;
       		catId = data.catId;
       		categoryDtlPop();
       	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }     
            return data;
       	},		
       	rowSelected : function (args) {
			var data = args.data;
			rid = data.rid;
    	},
       	dataUrl : '<ifvm:action name="getCategoryList"/>',
       	columns:[
       	        {
                  field : 'brdNm', headerText : '<spring:message code="L02927"/>', textAlign : 'center',  customAttributes : {searchable: true, index : 'lbc.BRD_NM '}
              },
        	    {
          		  field : 'catId', headerText : '<spring:message code="M03047"/>', textAlign : 'center',  customAttributes : {searchable: true, index : 'lpc.CAT_ID '}
          	  },{
          		  field : 'catNm', headerText : '<spring:message code="L00291"/>', textAlign : 'left',  customAttributes : {searchable: true, index : 'lpc.CAT_NM'}
          	  },{
          		  field : 'parCatId', headerText : '<spring:message code="M03048"/>', textAlign : 'center', customAttributes : {searchable: true, index : 'lpc2.CAT_ID'}
        	  },{
          		  field : 'parCatNm', headerText : '<spring:message code="M01961"/>', textAlign : 'center',  customAttributes : {searchable: true, index : 'lpc2.CAT_NM'}
          	  },{
          		  field : 'modifyBy', headerText : '<spring:message code="Q02833"/>', textAlign : 'center', width : '13%'
          	  },{
          		  field : 'modifyDate', headerText : '<spring:message code="L02703"/>', textAlign : 'center',width : '13%'
              },{
          		  field : 'createDate', headerText : '<spring:message code="등록일자"/>', textAlign : 'center',width : '13%'
          	  },{
          		  field : 'rid', headerText : 'rid', visible : false ,
          	  }
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'createDate',
        	  sord : 'desc',
        	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    categoryListGrid = $("#categoryListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function categoryListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("categorySearchList","PRGO_CATEGORY",gridId);
}

//공통 조회 호출
function categoryListSearch() {
    $.fn.ifvmSubmitSearchCondition("categorySearchList", getCategoryList);
} 

function categoryDtlPop(){
	$("#dialog").ifvsfPopup({
		enableModal : true,
        enableResize: true,
        contentUrl: '<ifvm:url name="catDtlPop"/>',
        contentType: "ajax",
        title: '<spring:message code="상품 카테고리 등록" />',
        width: '700px',
        close : 'categoryPopupClose'
    });
}

function removeCategory(){
	if(confirm('삭제 하시겠습니까?')){
		$.ifvSyncPostJSON('<ifvm:action name="removeCategory"/>',{rid : rid}, function(result){
			alert('삭제 되었습니다.');
			categoryListGrid._doAjax();
		});
	}
}
//그리드 -> 엑셀 다운로드
function setCategoryExcelExport() {
    $.ifvExcelDn('<ifvm:action name="getCategoryListExport"/>','categoryListGrid');
}

$(document).ready(function() {
	getCategoryList();
    
    //공통 조회 조건 목록 설정
    categoryListSearchInit();
    
    //조회
    $('#categoryListSearchBtn').on('click', function(){
    	categoryListSearch();
    });
    
    //초기화
    $("#categoryListSearchInitBtn").on('click', function(){
    	categoryListSearchInit("categoryListGrid");
    });
    
    //신규 클릭시
    $('#categoryNewBtn').on('click', function(){
    	rid = null;
    	categoryDtlPop();
    });
    
    $('#categoryRemoveBtn').on('click', function(){
    	if(rid == null){
    		alert('삭제할 목록을 선택하세요');
    	}else{
    		removeCategory();
    	}
    });
    //엑셀 다운로드
    $('#categoryExcelExportBtn').on('click', function(){
        setCategoryExcelExport();
    });
    
    
});

</script>

<div class="page-title">
    <h1>
    <spring:message code="M01969" />
	&gt; <spring:message code="M00135" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="categoryListSearchBtn" objCode="categoryListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="categoryListSearchInitBtn" objCode="categoryListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="categorySearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <%--<button class="btn btn-sm" id="categoryNewBtn" objCode="categoryNew_OBJ"><i class="fa fa-plus"></i>
                <spring:message code="M00136" />
            </button> 
            <button class="btn btn-sm" id="categoryRemoveBtn" objCode="categoryRemoveBtn_OBJ"><i class="fa fa-minus"></i>
                <spring:message code="삭제" />
            </button> --%>
<!--             엑셀다운로드 -->
            <%-- <button class="btn btn-sm" id="categoryExcelExportBtn" objCode="categoryExcelExportBtn_OBJ">
                <spring:message code="M00838" />
            </button> --%>
        </div>
    </div>
    <div id="categoryListGrid" class="white_bg grid_bd0"></div>     
</div>
<div id="dialog" class="popup_container"></div>