<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var campaignSearchHelp;
var gridIdcampaignSearchHelp;
var rid ;
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
            return data;
        },
        loadComplete : function(data){
         	if(data.rows.length==1){
         		campaignObj = data.rows[0];
        		choiceCampaignFn();
        	}
        	defaultSearchClose();
        },
        url : '<ifvm:action name="getCampaignList"/>',
        colNames:[
                   '<spring:message code="L00417"/>',
                   '<spring:message code="M00592"/>',
                   '<spring:message code="M00593" />',
                   '<spring:message code="M00594" />',
                   '<spring:message code="M00595" />',
                   '<spring:message code="M00974" />',  //승인진행상태
                   '<spring:message code="M00598" />',  //유형
                   '<spring:message code="M02304" />',  //캠페인 범위
                   '<spring:message code="M02295" />',  //프로모션 여부
                   '<spring:message code="M00596" />',  //기획자
                   '<spring:message code="M00597" />',  //부서

                 //'<spring:message code="M00606" />',  //목적
                   '<spring:message code="M01870" />',  //오퍼
                   '<spring:message code="M00600" />',  //비고

                   'typeCode',
                   'id',
                   'type',
                   'campaignApprovalStatusCode'
        ],
        colModel:[
            { name:'dispNo',                 index:'c.DISP_NO',  width:'100px', resizable : false, align: 'center', },
            { name:'campaignName',           index:'c.CAM_NM',   width:'250px', resizable : false, cellattr: function(){ return 'style="text-overflow:ellipsis;"';} },
            { name:'campaignStartDate',      index:'c.CAM_START_DD', width:'100px', align: 'center', resizable : false },
            { name:'campaignEndDate',        index:'c.CAM_END_DD', width:'100px', align: 'center', resizable : false },
            { name:'campaignStatusCodeName', index:'c2.MARK_NAME', width:'100px', align: 'center', resizable : false },
            { name:'campaignApprovalStatusCodeName', index:'c9.MARK_NAME', width:'100px', align: 'center', resizable : false },
            { name:'campaignTypeCodeName',   index:'c8.MARK_NAME', width:'150px', resizable : false },
            { name:'camScopeTypeNm',         index:'c10.MARK_NAME', width:'100px', align: 'center', resizable : false },
            { name:'promYn',   				 index:'c.prom_yn', width:'100px', resizable : false, align: 'center', formatter: gridDataSetFlag },
            { name:'campaignPlannerName',    index:'e.NAME', width:'150px', resizable : false },
            { name:'planOrgCodeName',        index:'d1.div_nm', width:'150px', resizable : false },
            { name:'offerName',              index:'o.OFFER_NM', width:'150px', resizable : false },
            { name:'description',            index:'c.CAM_DESC', width:'150px', resizable : false },

            { name:'campaignTypeCode',           index:'c8.CODE_NAME', hidden: true, searchable : false},
            { name:'id',                         index:'c.id',         hidden: true, searchable : false},
            { name:'type',                       index:'c.type',       hidden: true, searchable : false},
            { name:'campaignApprovalStatusCode', index:'c9.CODE_NAME', hidden: true, searchable : false},
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

// 상세 팝업 화면 호출
function emptyDtlPop(){

 $("#emptyDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="empty"/>',
        contentType: "ajax",
        title: 'empty',
        width: "1000px",
        close : 'emptyPopClose'
    });
}

//팝업 닫기
function emptyPopClose() {
	emptyDialog._destroy();
}

//고객 상세 이동
function emptyDtl() {
    qtjs.href('<ifvm:url name="empty"/>' + '?rid=' + rid);
}

function defaultSearch(){

	 if(typeof campaignNm != "undefined" && campaignNm != "undefined"
		 && $.fn.ifvmIsNotEmpty(campaignNm) && campaignNm != "null") {
		 first ='';

		$("#pop_main_div_campaign .SearchCondition .searchTextVal option:selected").filter(function(){
			if($(this).attr('joinsrcclm') == "CAMPAIGN_NM"){ $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(campaignNm)}
			})
		}
}

function defaultSearchClose(){
	 if(typeof campaignNm != "undefined" && campaignNm != "undefined"  && $.fn.ifvmIsNotEmpty(campaignNm) && campaignNm != "null") {
		if(campaignSearchHelp.getRowData().length==1){
			campaignSearchHelpPop.close(campaignSearchHelp.getRowDatas(1));
		}
		campaignNm = "null";
	 }
}


//선택
function choiceCampaignFn(){
	if(campaignObj!=null){
		campaignSearchHelpPop.close(campaignObj);
	}else{
		alert('<spring:message code="L01393" />');
	}
}
//닫기
function cancelcampaignSearchHelpFn(){
	campaignSearchHelpPop.close();
}




$(document).ready(function() {

    //공통 조회 조건 목록 설정
    campaignSearchHelpSearchInit();
    defaultSearch();
    campaignSearchHelpSearch();
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


	<div id="emptyDialog" class="popup_container"></div>
	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceCampaignBtn" btnFunc="choiceCampaignFn"/>
		<ifvm:inputNew type="button"   text="M00441"  id="cancelcampaignSearchHelpBtn" btnFunc="cancelcampaignSearchHelpFn"/>
	</div>
</div>
