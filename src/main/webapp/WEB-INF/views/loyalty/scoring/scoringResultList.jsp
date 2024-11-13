<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var scoringResultListGrid;
var gridIdscoringResultListGrid;

var checkedRidMbr;
var scrTypeCd;

/**
 * 이벤트트리거 scorign 결과 목록 조회
 */
function getScoringResultList() {
    
    var ejGridOption = {
        rowSelected : function (args) {
        	checkedRidMbr = args.data.ridMbr;
        	scrTypeCd = args.data.scrTypeCd;
        },
        recordDoubleClick : function (args) {
        	getScoringResultDetail();
        },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        dataUrl : '<ifvm:action name="getScoringResultList"/>',
        columns:[ 
        	{
	      		  field : 'mbrNo', headerText : '<spring:message code="M00688"/>', headerTextAlign : 'center', width : '90px' ,
	      		  customAttributes : {
	      			  index : 'lm.MBR_NO' }/* 회원번호 */
	      	  },{
	      		  field : 'mbrNm', headerText : '<spring:message code="L00435"/>', headerTextAlign : 'center', width : '90px' ,
	      		  customAttributes : {
	      			  index : 'lm.MBR_HID_NM' }/* 회원명 */
	      	  },{
	      		  field : 'scrTypeCdMarkName', headerText : '<spring:message code="M00755"/>', headerTextAlign : 'center', width : '90px' ,
	      		  customAttributes : {
	      			  index : 'c1.MARK_NAME' }/* 유형 */
	      	  },{
	      		  field : 'scrPnt', headerText : '<spring:message code="L02227"/>', headerTextAlign : 'center', width : '90px' ,
	      		  customAttributes : {
	      			  index : 'lsa.SCR_PNT' }/* 점수 */
	      	  },{
	      		  field : 'scrCreateDate', headerText : '<spring:message code="L02228"/>', headerTextAlign : 'center',width : '90px' ,
	      		  customAttributes : {
	      			  index : 'lsa.CREATE_DATE' }/* 생성일 */
	      	  },{
	      		  field : 'scrModifyDate', headerText : '<spring:message code="L02229"/>', headerTextAlign : 'center',width : '90px' ,
	      		  customAttributes : {
	      			  index : 'lsa.MODIFY_DATE' }/* 최종변경일 */
	      	  },{
	      		  field : 'ridMbr', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			searchable : false,
	      			  index : 'lm.RID' }/* */
	      	  },{
	      		  field : 'scrTypeCd', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			searchable : false,
	      			  index : 'esm.SCR_TYPE_CD' }/* */
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lsa.CREATE_DATE',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
        //tempId : 'ifvGridOriginTemplete'
    };
    scoringResultListGrid = $("#scoringResultListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridIdscoringResultListGrid = $("#gridIdscoringResultListGrid");
}

/**
 * scoring 결과 상세조회
 * 결과 상세조회 팝업 호출
 */
function getScoringResultDetail() {
	//목록 선택 체크
	if($.fn.ifvmIsEmpty(checkedRidMbr)) {
		alert('<spring:message code="L00066"/>');
		return true;
	}
	
	$("#scoringResultDetailPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="scoringResultDetailPop"/>?ridMbr=' + checkedRidMbr + '&scrTypeCd=' + scrTypeCd,
        contentType: "ajax",
        title: '<spring:message code="L02256" />',
        width: 800,
        close : 'scoringResultDetailPopClose'
    });
}

/**
 * 결과 상세조회 팝업 close
 */
function scoringResultDetailPopClose() {
	scoringResultDetailPop._destroy();
}

/**
 * 공통 조회 조건 목록 설정
 */
function scoringListSearchInit() {
    $.fn.ifvmSetCommonCondList("scoringSearchList", "PLOY_502");
}

/**
 * 공통 조회 호출
 */
function scoringListSearch() {
    $.fn.ifvmSubmitSearchCondition("scoringSearchList", getScoringResultList);
}

$(document).ready(function() {
	
    //공통 조회 조건 목록 설정
    scoringListSearchInit();

    //조회
    $('#scoringListSearchBtn').on('click', function() {
        scoringListSearch();
    });

    //초기화
    $("#scoringListSearchInitBtn").on('click', function() {
        scoringListSearchInit();
    });
	
	getScoringResultList();
	
	$("#scoringResultDetailBtn").click(function() {
		getScoringResultDetail();
	});
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="L02255" />
        &gt; <spring:message code="M00273" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="scoringListSearchBtn">
                <i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="scoringListSearchInitBtn">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="scoringSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="scoringResultDetailBtn"><%-- 상세조회 --%>
                <spring:message code="M01354" />
            </button>
        </div>
    </div>
    <div id="scoringResultListGrid" class="white_bg grid_bd0"></div>     
</div>

<div id="scoringResultDetailPop" class="popup_container"></div>
