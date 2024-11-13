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
    storeSatisfactionListSearchInit();

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
	$.fn.ifvmSetCommonCondList("storeSatisfactionSearchList", "LOY_5012");
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
       	dataUrl : '<ifvm:action name="getStoreSatisfactionListByChnl"/>',
       	columns:[
				{//참여일자
        		  field : 'createDate', headerText : '<spring:message code="L02292"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
        		  customAttributes : {
        			  index : "TO_CHAR(lcs.create_date, 'yyyy-mm-dd')" }
        	  },{//매장코드
          		  field : 'chnlNo', headerText : '<spring:message code="D10173"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
          		  customAttributes : {
          			  index : 'lc.chnl_no' }
          	  },{//매장명
          		  field : 'chnlNm', headerText : '<spring:message code="M00366"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'lc.chnl_nm' }
          	  },{//직원친절도
          		  field : 'satisScore01', headerText : '<spring:message code="L02293"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right,
          		  customAttributes : {
          			  index : "sum(case  when lcs.SATIS_DIV_CD = '01' then SATIS_VAL else 0 end)" }
          	  },{//상품진열, 구성만족도
          		  field : 'satisScore02', headerText : '<spring:message code="L02294"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right,
          		  customAttributes : {
          			  index : "sum(case  when lcs.SATIS_DIV_CD = '02' then SATIS_VAL else 0 end)" }
          	  },{//쇼핑환경청결도
          		  field : 'satisScore03', headerText : '<spring:message code="L02295"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right,
          		  customAttributes : {
          			  index : "sum(case  when lcs.SATIS_DIV_CD = '03' then SATIS_VAL else 0 end)" }
          	  },{//총점
          		  field : 'total', headerText : '<spring:message code="L02296"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right,
          		  customAttributes : {
          			  index : 'sum(SATIS_VAL)' }
			  }
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : "TO_CHAR(lcs.create_date, 'yyyy-mm-dd')",
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
    	<spring:message code="L02297" />
		&gt; <spring:message code="M00135" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="storeSatisfactionListSearchBtn" objCode="SatisfactionListByChnlSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="storeSatisfactionListSearchInitBtn" objCode="SatisfactionListByChnlSearchInitBtn_OBJ">
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
