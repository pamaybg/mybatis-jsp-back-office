<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var campaignSearchHelp;
var rid;
var campaignObj=null;
<%-- var prodNm = decodeURIComponent('<%= request.getParameter("prodNm") %>') --%>

//
function getcampaignSearchHelpSearch(){
	var ejGridOption = {
		recordDoubleClick : function (args) {
			campaignObj=args.data;
		},
		rowSelected : function (args) {
			campaignObj=args.data;
		},
		serializeGridData : function( data ){
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			data.type = 'LOY';
			return data;
		},
		loadComplete : function(data){
         	/* if(data.rows.length==1){
         		campaignObj = data.rows[0];
        		choiceCampaignFn();
        	} */
        	/* defaultSearchClose(); */
        },
        dataUrl : '<ifvm:action name="getPromotionList"/>',
        columns:[
			{
				field : 'dispNo', headerText : '캠페인코드', headerTextAlign : 'center',
				customAttributes : {
					index : 'c.DISP_NO' }
			},{
				field : 'campaignName', headerText : '캠페인명', headerTextAlign : 'center',
				customAttributes : {
					index : 'c.CAM_NM' }
			},{
				field : 'offerName', headerText : '오퍼명', headerTextAlign : 'center',
				customAttributes : {
					index : 'o.OFFER_NM' }
			},{
				field : 'offerTypeName', headerText : '오퍼유형', headerTextAlign : 'center',
				customAttributes : {
					index : 'c1.MARK_NAME' }
			},{
				field : 'validStartdtBasCdNm', headerText : '기준일자유형', headerTextAlign : 'center',
				customAttributes : {
					index : 'c1.mark_name' }
			},{
				field : 'validStartDtnum', headerText : '혜택시작일', headerTextAlign : 'center',
				customAttributes : {
					index : 'lopd.VALID_START_DTNUM' }
			},{
				field : 'validEndDtnum', headerText : '소멸예정월', headerTextAlign : 'center',
				customAttributes : {
					index : 'lopd.VALID_END_DTNUM' }
			},{
				field : 'rdmSeq', headerText : '차감순서', headerTextAlign : 'center',
				customAttributes : {
					index : 'lopd.RDM_SEQ' }
			},{
				field : 'dividorChnlNo', headerText : '재원부서코드', headerTextAlign : 'center',
				customAttributes : {
					index : 'lc.chnl_no' }
			},{
				field : 'dividorChnlNm', headerText : '재원부서명', headerTextAlign : 'center',
				customAttributes : {
					index : 'lc.chnl_nm' }
			},{
				field : 'pntAccntBigTypeCdNm', headerText : '지급계정(대)', headerTextAlign : 'center',
				customAttributes : {
					index : 'c9.mark_name' }
			},{
				field : 'pntAccntMidTypeCdNm', headerText : '지급계정(중)', headerTextAlign : 'center',
				customAttributes : {
					index : 'c10.mark_name' }
			},{
				field : 'pntAccntSmlTypeCdNm', headerText : '지급계정(소)', headerTextAlign : 'center',
				customAttributes : {
					index : 'c11.mark_name' }
			},{
				field : 'pntAccntDetailTypeCdNm', headerText : '지급계정(세)', headerTextAlign : 'center',
				customAttributes : {
					index : 'c12.mark_name' }
			},{
				field : 'pntAccntCodeVal', headerText : '회계코드', headerTextAlign : 'center',
				customAttributes : {
					index : 'c.PNT_ACCNT_CODE_VAL' }
			},{
				field : 'typeCode', headerText : 'typeCode', headerTextAlign : 'center', visible : false,
				customAttributes : {
					index : 'c8.CODE_NAME' }
			},{
				field : 'id', headerText : 'id', headerTextAlign : 'center', visible : false,
				customAttributes : {
					index : 'c.id' }
			},{
				field : 'type', headerText : 'type', headerTextAlign : 'center', visible : false,
				customAttributes : {
					index : 'c.type' }
			},{
				field : 'campaignApprovalStatusCode', headerText : 'campaignApprovalStatusCode', headerTextAlign : 'center', visible : false,
				customAttributes : {
					index : 'c9.CODE_NAME' }
			},{
				field : 'offerId', headerText : 'offerId', headerTextAlign : 'center', visible : false,
				customAttributes : {
					index : 'r.OFFER_ID' }
			},{
				field : 'offerNo', headerText : 'offerNo', headerTextAlign : 'center', visible : false,
				customAttributes : {
					index : 'o.OFFER_NO' }
			},{
				field : 'offerType', headerText : 'offerType', headerTextAlign : 'center', visible : false,
				customAttributes : {
					index : 'c1.CODE_NAME' }
			}
		],
		requestGridData : {
			nd   : new Date().getTime(),
			rows : 10,
			sidx : 'c.create_date',
			sord : 'desc',
			_search : false
		},
		rowList : [10,25,50,100],
		radio: true
	};

	campaignSearchHelp = $("#campaignSearchHelpGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


function gridDataSetFlag(cellValue) {
    if (cellValue == '1') return 'Y';
    else return 'N';
}


//공통 조회 조건 목록 설정
function campaignSearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("campaignSearchHelpSearchList","MKTMNG001");
}

//공통 조회 호출
function campaignSearchHelpSearch() {
    $.fn.ifvmSubmitSearchCondition("campaignSearchHelpSearchList", getcampaignSearchHelpSearch);
}

//닫기
function cancelcampaignSearchHelpFn(){
	promotionSearchHelpPopup.close();
}




$(document).ready(function() {
	//페이지 최초 로드 시 공통조회조건값 초기화한다.
	requestitem = null;
	
    //공통 조회 조건 목록 설정
    campaignSearchHelpSearchInit();
    /* defaultSearch(); */
    getcampaignSearchHelpSearch();

    //조회
    $('#campaignSearchHelpSearchBtn').on('click', function(){
    	campaignSearchHelpSearch();
    });

    //초기화
    $("#campaignSearchHelpSearchInitBtn").on('click', function(){
    	campaignSearchHelpSearchInit();
    });


    $.ifvEnterSetting(["#campaignSearchHelpSearchList input"], function(){
    	campaignSearchHelpSearch();
	});

});

</script>

<div id="pop_main_div_campaign">
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
	    <div class="well form-horizontal well_bt5" id="campaignSearchHelpSearchList" >
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
	    <div id="campaignSearchHelpGrid" class="white_bg grid_bd0"></div>
	</div>


	<!-- <div id="emptyDialog" class="popup_container"></div> -->
	<div class="pop_btn_area">
		<%-- <ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceCampaignBtn" btnFunc="choiceCampaignFn"/> --%>
		<ifvm:inputNew type="button"   text="L00913"  id="cancelcampaignSearchHelpBtn" btnFunc="cancelcampaignSearchHelpFn"/>
	</div>
</div>
