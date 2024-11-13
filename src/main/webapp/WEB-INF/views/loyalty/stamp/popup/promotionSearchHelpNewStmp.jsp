<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script type="text/javascript">

var campaignSearchHelp;
var rid;
var campaignObj=null;
var campaignTypeCode = '<%= cleanXss(request.getParameter("campaignTypeCode")) %>';
if(campaignTypeCode === 'null') {
	campaignTypeCode = null;
}

//popup 높이 맞추기
function initPopupHeight() {
  setTimeout(function() {
      try {
          new ifvm.PopupHeight({
              popupDivId : 'promotionSearchHelpPopup',
              contentsId : 'pop_main_div_campaign'
          });
      }
      catch(e) {
      }
  }, 500);
}

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
				data.type = 'MKT';
				data.campaignTypeCode = campaignTypeCode;
				return data;
			},
			loadComplete : function(data){
				
// 				initPopupHeight();
				
	         	/* if(data.rows.length==1){
	         		campaignObj = data.rows[0];
	        		choiceCampaignFn();
	        	} */
	        	/* defaultSearchClose(); */
	        },
	        dataUrl : '<ifvm:action name="getPromotionList"/>',
	        columns:[
				{
					field : 'dispNo', headerText : '캠페인코드', headerTextAlign : 'center', textAlign : 'left', width : '80px',
					customAttributes : {
						index : 'c.DISP_NO' }
				},{
					field : 'campaignName', headerText : '캠페인명', headerTextAlign : 'center', textAlign : 'left', width : '150px',
					customAttributes : {
						index : 'c.CAM_NM' }
				},{
					field : 'campaignStartDate', headerText : '시작일', headerTextAlign : 'center', textAlign : 'center', width : '70px',
					customAttributes : {
						index : 'c.CAM_START_DD' }
				},{
					field : 'campaignEndDate', headerText : '종료일', headerTextAlign : 'center', textAlign : 'center', width : '70px',
					customAttributes : {
						index : 'c.CAM_END_DD' }
				},{
					field : 'offerName', headerText : '오퍼명', headerTextAlign : 'center', textAlign : 'left', width : '100px',
					customAttributes : {
						index : 'o.OFFER_NM' }
				},{
					field : 'offerTypeName', headerText : '오퍼유형', headerTextAlign : 'center', textAlign : 'center', width : '70px',
					customAttributes : {
						index : 'c1.MARK_NAME' }
				},{
					field : 'validStartdtBasCdNm', headerText : '기준일자유형', headerTextAlign : 'center', textAlign : 'center', width : '70px',
					customAttributes : {
						index : 'c1.mark_name' }
				},{
					field : 'validStartDtnum', headerText : '혜택시작일', headerTextAlign : 'center', textAlign : 'center', width : '50px',
					customAttributes : {
						index : 'lopd.VALID_START_DTNUM' }
				},{
					field : 'validEndDtnum', headerText : '소멸예정월', headerTextAlign : 'center', textAlign : 'center', width : '50px',
					customAttributes : {
						index : 'lopd.VALID_END_DTNUM' }
				},{
					field : 'selfTotAmt', headerText : '혜택금액', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '70px',
					customAttributes : {
						index : 'o.SELF_TOT_AMT' }
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

// 상세 팝업 화면 호출
/* function emptyDtlPop(){

 $("#emptyDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="empty"/>',
        contentType: "ajax",
        title: 'empty',
        width: "1000px",
        close : 'emptyPopClose'
    });
} */

//팝업 닫기
/* function emptyPopClose() {
 $('#emptyDialog').ejDialog('destroy');
} */

//고객 상세 이동
/* function emptyDtl() {
    qtjs.href('<ifvm:url name="empty"/>' + '?rid=' + rid);
} */

/* function defaultSearch(){

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
			promotionSearchHelpPopup.close(campaignSearchHelp.getRowDatas(1));
		}
		campaignNm = "null";
	 }
} */


//선택
function choiceCampaignFn(){
	if(campaignObj!=null){
		//promotionSearchHelpPopup.close(campaignObj);
		$('#stmpItemDetailForm #camNm').val(campaignObj.campaignName);
		$('#stmpItemDetailForm #camNo').val(campaignObj.dispNo);
		
		promotionSearchHelpPopupClose();
	}else{
		alert('<spring:message code="L01393" />');
	}
}
//닫기
function cancelcampaignSearchHelpFn(){
	promotionSearchHelpPopup.close();
}




$(document).ready(function() {

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
				<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceCampaignBtn" btnFunc="choiceCampaignFn"/>
				<ifvm:inputNew type="button"   text="M00441"  id="cancelcampaignSearchHelpBtn" btnFunc="cancelcampaignSearchHelpFn"/>
	        </div>
	    </div>
	    <div id="campaignSearchHelpGrid" class="white_bg grid_bd0"></div>
	</div>


	<!-- <div id="emptyDialog" class="popup_container"></div> -->
<!-- 	<div class="pop_btn_area"> -->
<%-- 		<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceCampaignBtn" btnFunc="choiceCampaignFn"/> --%>
<%-- 		<ifvm:inputNew type="button"   text="M00441"  id="cancelcampaignSearchHelpBtn" btnFunc="cancelcampaignSearchHelpFn"/> --%>
<!-- 	</div> -->
</div>
