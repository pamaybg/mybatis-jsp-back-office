<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
        <spring:message code="프로모션 반응"/><!-- 회원 -->
        &gt; <spring:message code="조회"/><!-- 고객 -->
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="promReactListSearch_OBJ" ><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="promReactListSearchInit_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="promReactionGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
var promReactionGrid = null;
//고객 목록
function getPromReactionList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			//페이지 설정
			return data;
		},
   		recordDoubleClick : function (args) {
   			var data = args.data.rid ;
   	    	promReactDetail(data,args.data.ridProm);
        },

        dataUrl : '<ifvm:action name="getPromReactionList"/>',

        columns : [
        	{
      		  field : 'promNo', headerText : '번호', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'promNm', headerText : '프로모션 명', headerTextAlign : 'center',textAlign : 'left', width:'250px', customAttributes :{searchable : true}
    	  },{
    		  field : 'promTypeLv1CdNm', headerText : '대유형', headerTextAlign : 'center',textAlign : 'center',customAttributes :{index : 'promTypeLv1Cd'}
    	  },{
    		  field : 'promTypeLv2CdNm', headerText : '소유형', headerTextAlign : 'center', textAlign : 'center',customAttributes :{index : 'promTypeLv2Cd'}
    	  },{
    		  field : 'validStartDate', headerText : '시작일', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'validEndDate', headerText : '종료일', headerTextAlign : 'center', textAlign : 'center',
    	  },{
    		  field : 'respTotCost', headerText : '총 비용', headerTextAlign : 'center', format : '{0:n0}', textAlign : 'right'
    	  },{
    		  field : 'kpiDateTypeCdNm', headerText : 'KPI유형', headerTextAlign : 'center', textAlign : 'center',customAttributes :{index : 'kpiDateTypeCd'}
    	  },{
    		  field : 'respAmt', headerText : 'KPI측정결과', headerTextAlign : 'center',  format : '{0:n0}', textAlign : 'right'
    	  },{
    		  field : 'respLastDate', headerText : 'KPI측정일', headerTextAlign : 'center', textAlign : 'center',
    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
    	  },{
    		  field : 'ridProm', headerText : 'ridProm', headerTextAlign : '' ,visible: false,
    	  }
        ],

        requestGridData : {
      	  sidx : '10',
      	  sord : 'desc',

        },
        rowList : [10,25,50,100],
        radio: true,
    };

    promReactionGrid = $("#promReactionGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","PROM_REACTION_LIST",gridId);
}

//공통 조회 호출
function promReactionListSearch() {
	$.fn.ifvmSubmitSearchCondition("commSearchList", function(){
		promReactionGrid.searchGrid({item: requestitem});
    });
	
}


//고객 상세 이동
function promReactDetail(id,ridProm) {
	qtjs.href('<ifvm:url name="promReactionDetail"/>' + '?rid=' + id+"&ridProm="+ridProm);
}

$(document).ready(function() {
	 searchCondInit();

	 //마스킹해제 권한 체크
	 getPromReactionList();
	 
	//조회
	 $('#searchCondBtn').on('click', function(){
		 promReactionListSearch();
	 });

	 //초기화
	 $("#searchCondInitBtn").on('click', function(){
	 	searchCondInit("promReactionGrid");
	 });
	 
	 
});




</script>