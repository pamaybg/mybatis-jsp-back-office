<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var campaignSearchHelp;
var gridIdcampaignSearchHelp;
var rid;
var campaignObj=null;
<%-- var prodNm = decodeURIComponent('<%= request.getParameter("prodNm") %>') --%>

//
function getcampaignSearchHelpSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
        },
        onSelectRow : function (data) {
        	campaignObj=data;
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
        url : '<ifvm:action name="getPromotionList"/>',
        colNames:[
//                    '<spring:message code="L00417"/>',
//                    '<spring:message code="M00592"/>',
//                    '<spring:message code="M00593" />',
//                    '<spring:message code="M00594" />',
//                    '<spring:message code="M00595" />',
//                    '<spring:message code="M00974" />',  //승인진행상태
//                    '<spring:message code="M00598" />',  //유형
//                    '<spring:message code="M02304" />',  //캠페인 범위
//                    '<spring:message code="M02295" />',  //프로모션 여부
//                    '<spring:message code="M00596" />',  //기획자
//                    '<spring:message code="M00597" />',  //부서

//                  //'<spring:message code="M00606" />',  //목적
//                    '<spring:message code="M01870" />',  //오퍼
//                    '<spring:message code="M00319" />',  //오퍼유형
//                    '<spring:message code="M00600" />',  //비고

                   '캠페인코드',
                   '캠페인명',
                   '오퍼명',
                   '오퍼유형',
                   '기준일자유형',
                   '혜택시작일',
                   '소멸예정월',
                   '차감순서',
                   '재원부서코드',
                   '재원부서명',
                   '회계코드',
                   '지급계정(대)',
                   '지급계정(중)',
                   '지급계정(소)',
                   '지급계정(세)',
                   
                   'typeCode',
                   'id',
                   'type',
                   'campaignApprovalStatusCode',
                   'offerId',
                   'offerNo',
                   'offerType',
        ],
        colModel:[
            { name:'dispNo',                 index:'c.DISP_NO', resizable : false, align: 'center' },
            { name:'campaignName',           index:'c.CAM_NM',  resizable : false },
            { name:'offerName',              index:'o.OFFER_NM', resizable : false },
            { name:'offerTypeName',          index:'c1.MARK_NAME', resizable : false },
            { name:'validStartdtBasCdNm',    index:'c13.mark_name', resizable : false },
            { name:'validStartDtnum',        index:'lopd.VALID_START_DTNUM', resizable : false },
            { name:'validEndDtnum',          index:'lopd.VALID_END_DTNUM', resizable : false },
            { name:'rdmSeq',                 index:'lopd.RDM_SEQ', resizable : false },
            { name:'dividorChnlNo',          index:'lc.chnl_no', resizable : false },
            { name:'dividorChnlNm',          index:'lc.chnl_nm', resizable : false },
            { name:'pntAccntBigTypeCdNm',      index:'c9.mark_name', resizable : false },
            { name:'pntAccntMidTypeCdNm',      index:'c10.mark_name', resizable : false },
            { name:'pntAccntSmlTypeCdNm',      index:'c11.mark_name', resizable : false },
            { name:'pntAccntDetailTypeCdNm',   index:'c12.mark_name', resizable : false },
            { name:'pntAccntCodeVal',        index:'c.PNT_ACCNT_CODE_VAL', resizable : false },
//             { name:'campaignStartDate',      index:'c.CAM_START_DD', width:'100px', align: 'center', resizable : false },
//             { name:'campaignEndDate',        index:'c.CAM_END_DD', width:'100px', align: 'center', resizable : false },
//             { name:'campaignStatusCodeName', index:'c2.MARK_NAME', width:'100px', align: 'center', resizable : false },
//             { name:'campaignApprovalStatusCodeName', index:'c9.MARK_NAME', width:'100px', align: 'center', resizable : false },
//             { name:'campaignTypeCodeName',   index:'c8.MARK_NAME', width:'150px', resizable : false },
//             { name:'camScopeTypeNm',         index:'c10.MARK_NAME', width:'100px', align: 'center', resizable : false },
//             { name:'promYn',   				 index:'c.prom_yn', width:'100px', resizable : false, align: 'center', formatter: gridDataSetFlag },
//             { name:'campaignPlannerName',    index:'e.NAME', width:'150px', resizable : false },
//             { name:'planOrgCodeName',        index:'d1.div_nm', width:'150px', resizable : false },
//             { name:'description',            index:'c.CAM_DESC', width:'150px', resizable : false },

            { name:'campaignTypeCode',           index:'c8.CODE_NAME', hidden: true, searchable : false},
            { name:'id',                         index:'c.id',         hidden: true, searchable : false},
            { name:'type',                       index:'c.type',       hidden: true, searchable : false},
            { name:'campaignApprovalStatusCode', index:'c9.CODE_NAME', hidden: true, searchable : false},
            { name:'offerId', index:'r.OFFER_ID', hidden: true, searchable : false},
            { name:'offerNo', index:'o.OFFER_NO', hidden: true, searchable : false},
            { name:'offerType', index:'c1.CODE_NAME', hidden: true, searchable : false},
        ],
        sortname: 'c.create_date',
        sortorder: "desc",
        radio: true,
    };

    campaignSearchHelp = $("#campaignSearchHelpGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdcampaignSearchHelp = $("#gridIdcampaignSearchHelp");
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
