<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">

var piMaskGrid;
var date=new Date();
var currentdate=date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();

function getMaskingDecList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }
	      	
	       	},
	       	rowSelected : function(args){
	       	},
	       	dataUrl : '<ifvm:action name="getPiMaskDecList"/>',
	        columns:[ 
	        	  { 
		      		  field : 'createDate', headerText : '<spring:message code="L02591"/>', headerTextAlign : 'center', textAlign : 'center', width:'60px' /* 열람일시 */
		      	  },{
		      		  field : 'name', headerText : '<spring:message code="L02592"/>', headerTextAlign : 'center', textAlign : 'center', width:'70px' /* 열람자명 */
		      	  },{
		      		  field : 'pageInfo', headerText : '<spring:message code="M00183"/>', headerTextAlign : 'center', textAlign : 'left', width:'150px' /* 프로그램경로 */ ,customAttributes :{searchable : true} 
		      	  },{
		      		  field : 'infoType', headerText : '<spring:message code="L02593"/>', headerTextAlign : 'center', textAlign : 'center', width:'70px' /*관련테이블*/, customAttributes :{searchable : true}
		      	  	},{
		      		  field : 'rid', headerText : '<spring:message code="L02594"/>', headerTextAlign : 'center', textAlign : 'center', width:'100px' /* row id*/ 
		      	  },{
		      		  field : 'reason', headerText : '<spring:message code="L02595"/>', headerTextAlign : 'center', textAlign : 'center', width:'80px' /*열람사유 */
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
	        autowidth : true ,
	    };
	piMaskGrid = $("#piMaskGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function piMaskListSearchInit() {
    $.fn.ifvmSetCommonCondList("getPiMaskDecList","PI_MASK_LIST");
    $(".datepicker").val(currentdate); //날짜 초기화
}

//공통 조회 호출
function piMaskListSearch() {
   $.fn.ifvmSubmitSearchCondition("getPiMaskDecList", getMaskingDecList);
}

//엑셀 다운로드 
function excelExport() {
	$.ifvExcelDn('<ifvm:action name="getPiMaskDecExcelDn"/>','piMaskGrid' );
}


$(document).ready(function() {
 	
	piMaskListSearchInit()
 	getMaskingDecList();

 	
    $('#piMaskListSearchBtn').on('click', function(){
    	piMaskListSearch();
    });
 	//초기화
 	$("#piMaskListClearBtn").on('click', function(){
 		piMaskListSearchInit();
 	});
 	
	//엑셀 다운로드
	$("#excelExportBtn").on('click', function(){
		excelExport();
	});

});

</script>

<div class="page-title">
    <h1>
     	 <spring:message code="O00211" />
        &gt; <spring:message code="L00030" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="piMaskListSearchBtn" objCode="piMaskingDesListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="piMaskListClearBtn" objCode="piMaskingDesListInit_OBJ">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="getPiMaskDecList" >
    </div>
</div>

<div id="piMaskForm">
    <div class="page_btn_area" id=''>
    	<div class="col-xs-7">
			<span>조회 결과</span>    
    	</div>
    	<div class="col-xs-5 searchbtn_r">
    		<button class="btn btn-sm" id="excelExportBtn" objCode="piMaskingDesListExcelDwn_OBJ">
    		<i class="glyphicon glyphicon-check"></i>
            	<spring:message code="M01218" />
         	</button>
    	</div>
       
    </div>


<div id="piMaskGrid" class="white_bg grid_bd0"></div>
</div>


<div id="ImgViewPop" class="popup_container"></div><!-- 팝업 -->
<div id="limitMbrAddPop" class="popup_container"></div><!-- 팝업 -->
