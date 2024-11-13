<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var expDividListPopGrid; 

/**
 * 재원 분담처 선택을 위한 채널 목록 조회
 */
function initExpDividListPopData() {
	
	var ejGridOption = {
		loadComplete: function(obj) {
 		},
 		rowSelected: function (args) {
 			selectedObj = args.data;
		},
		serializeGridData: function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			data.dividorTypeCd = $('#dividorTypeCd').val();
			return data;
		},
		dataUrl:'<ifvm:action name="getChannelList"/>',
		columns:[ 
				field : 'chnlNo', headerText : '<spring:message code="L00564" />', headerTextAlign : 'center',
				customAttributes : {
					index : 'a.chnlNo' }
			},{
				field : 'chnlNm', headerText : '<spring:message code="V00022" />', headerTextAlign : 'center',
				customAttributes : {
					index : 'a.chnlNm' }
			},{
				field : 'parChnlNm', headerText : '<spring:message code="L00621" />', headerTextAlign : 'center',
				customAttributes : {
					index : 'a.parChnlNm' }
			},{
				field : 'rid', headerText : 'rid', headerTextAlign : 'center', visible : false,
				customAttributes : {
					index : 'a.rid' }
			}
		],
		requestGridData : {
			nd   : new Date().getTime(),
			rows : 10,
			sidx : 'a.rid',
			sord : 'desc',
			_search : false
		},
		rowList : [10,25,50,100],
		radio: true,
	};
	
	expDividListPopGrid = $("#expDividListPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function campaignSearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("campaignSearchHelpSearchList","PGM_L_078");
}

//공통 조회 호출
function campaignSearchHelpSearch() {
    $.fn.ifvmSubmitSearchCondition("campaignSearchHelpSearchList", initExpDividListPopData);
}

$(document).ready(function() {
	//페이지 최초 로드 시 공통조회조건값 초기화한다.
	requestitem = null;
	
    initExpDividListPopData();

    //공통 조회 조건 목록 설정
    campaignSearchHelpSearchInit();
	
    //조회
    $('#campaignSearchHelpSearchBtn').on('click', function(){
    	campaignSearchHelpSearch();
    });

    //초기화
    $("#campaignSearchHelpSearchInitBtn").on('click', function(){
    	campaignSearchHelpSearchInit();
    });


    $.ifvEnterSetting(["#campaignSearchHelpSearchList input"], function(){
    	initExpDividListPopData();
	});
});
</script>

<div id="expDividListPopWrap">

	<div>
		<div class="page_btn_area">
		    <div class="col-xs-7">
		        <span><spring:message code="L01838" /></span>
		    </div>
		    <div class="col-xs-5 searchbtn_r">
		        <button class="btn btn-sm" id="campaignSearchHelpSearchBtn"><i class="fa fa-search"></i>
		            <spring:message code="M00135" />
		        </button>
		        <button class="btn btn-sm" id="campaignSearchHelpSearchInitBtn">
		            <spring:message code="M00278" />
		        </button>
		    </div>
		</div>
		<div class="well form-horizontal" id="campaignSearchHelpSearchList" >
		</div>
	</div>

	<div>
	    <div class="page_btn_area" >
	        <div class="col-xs-7">
	            <span><spring:message code="M00277" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	        </div>
	    </div>
	    <div id="expDividListPopGrid" class="white_bg grid_bd0"></div>
	</div>


	<!-- <div id="emptyDialog" class="popup_container"></div> -->
	<div class="pop_btn_area">
		<%-- <ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceCampaignBtn" btnFunc="choiceCampaignFn"/> --%>
		<ifvm:inputNew type="button"   text="M00282"  id="expDividListPopSelectBtn" btnFunc="expDividListPopupSelect"/>
		<ifvm:inputNew type="button"   text="M00441"  id="expDividListPopCancelBtn" btnFunc="expDividListPopupClose"/>
	</div>
<!-- 	<div class="pop_inner_wrap"> -->
<!-- 		<div id="expDividListPopGrid"></div> -->
<!-- 	</div> -->
<!-- 	<div class="pop_btn_area"> -->
<!-- 	    <button class="btn btn-sm btn_gray" id="expDividListPopSelectBtn"> -->
<!-- 	        <i class="glyphicon glyphicon-check"></i> -->
<%-- 	        <spring:message code="M00282"/> --%>
<!-- 	    </button>  -->
<!-- 	    <button class="btn btn-sm btn_lightGray2" id="expDividListPopCancelBtn">          -->
<%-- 	        <spring:message code="M00441"/> --%>
<!-- 	    </button>  -->
<!-- 	</div> -->
</div>