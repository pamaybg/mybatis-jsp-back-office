<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var storeSatisfactionListGrid;

$(document).ready(function() {
	getStoreSatisfactionList();

    //공통 조회 조건 목록 설정
    //storeSatisfactionListSearchInit();

    //조회
    $('#storeSatisfactionListSearchBtn').on('click', function() {
    	storeSatisfactionListSearch();
    });

    //초기화
    $("#storeSatisfactionListSearchInitBtn").on('click', function() {
    	storeSatisfactionListSearchInit();
    });
});

//공통 조회 조건 목록 설정
function storeSatisfactionListSearchInit() {
  $.fn.ifvmSetCommonCondList("storeSatisfactionSearchList", "LOY_501");
}

//공통 조회 호출
function storeSatisfactionListSearch() {
  $.fn.ifvmSubmitSearchCondition("storeSatisfactionSearchList", function(){
	  storeSatisfactionListGrid.searchGrid({item: requestitem});
  });
}

/**
 * 매장만족도 설문결과 목록
 */
function getStoreSatisfactionList(){
    var ejGridOption = {
   		recordDoubleClick : function(args) {
       	},
      	serializeGridData : function(data) {
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
       	},
       	loadComplete : function(obj){
       	},
       	dataUrl : '<ifvm:action name="getStoreSatisfactionList"/>',
       	columns:[
        		{
        		  field : 'chnlNo', headerText : '<spring:message code="L02274"/>', headerTextAlign : 'center',
        		  customAttributes : {
        			  index : 'lc.chnl_no' } //
        	  },{
          		  field : 'chnlNm', headerText : '<spring:message code="L02275"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'lc.chnl_nm' } //
          	  },{
          		  field : 'chnlAdr', headerText : '<spring:message code="L02276"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'chnlAdr' } //
          	  } ,{
          		  field : 'ages', headerText : '<spring:message code="L02277"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'ages' } //
          	  } ,{
          		  field : 'satisVal', headerText : '<spring:message code="L02278"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'lcs.satis_val' } //
          	  },{
          		  field : 'rid', headerText : 'rid', visible : false ,
          		  customAttributes : {
          			  index : 'lcs.rid' } //
          	  }
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'lcs.create_date',
        	  sord : 'desc',
        	  _search : false
        },
        allowSorting: true,
        rowList : [10,25,50,100],
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };

    storeSatisfactionListGrid = $("#storeSatisfactionListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}
</script>

<div class="page-title">
    <h1>
    매장만족도 &gt; <spring:message code="M00135" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="SatisfactionListSearchBtn" objCode="SatisfactionListSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="SatisfactionListSearchInitBtn" objCode="SatisfactionListSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="storeSatisfactionSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <%-- <button class="btn btn-sm" id="categoryNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M00136" />
            </button>  --%>
        </div>
    </div>
    <div id="storeSatisfactionListGrid" class="white_bg grid_bd0"></div>
</div>
