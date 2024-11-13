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
<%-- var prodNm = decodeURIComponent('<%= request.getParameter("prodNm") %>') --%>
//다이소 CS포인트 팝업에서 노출할 프로모션캠페인 유형 제한 -> 지급계정 중분류 'CS'
var pntAccntMidTypeCd = '<%= cleanXss(request.getParameter("pntAccntMidTypeCd")) %>';
var offerType = '<%= cleanXss(request.getParameter("offerType")) %>';

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
				if (offerType == 'TARGET_SURVEY'){
					data.promType2Cd = 'AC2SUR';
				}
				//data.type = 'LOY';
				//data.pntAccntMidTypeCd = pntAccntMidTypeCd;
				/* if (offerType == 'TARGET_SURVEY'){
					data.pntAccntMidTypeCd = '161'
				}
				else if(offerType == 'TARGET_EVENT'){
					data.pntAccntMidTypeCd = '162'
				} */
				
				return data;
			},
			loadComplete : function(data){
	        },
	        dataUrl : '<ifvm:action name="getPromotionListPop"/>',
	        columns : [
	        	{
	      		  field : 'promNm', headerText : '프로모션 명', headerTextAlign : 'center', width:'200px', textAlign : 'left', customAttributes :{searchable : true}
	      	  },{
	    		  field : 'promTypeLv1CdNm', headerText : '대유형',width:'120px', headerTextAlign : 'center', textAlign : 'center' ,customAttributes :{index : 'promTypeLv1Cd'}
	    	  },{
	    		  field : 'promTypeLv2CdNm', headerText : '소유형',width:'80px',textAlign : 'center', headerTextAlign : 'center' , customAttributes :{index : 'promTypeLv2Cd'}
	    	  },{
	    		  field : 'promStatCdNm', headerText : '상태', headerTextAlign : 'center',width:'60px', textAlign : 'center' , customAttributes :{index : 'promStatCd'}
	    	  },{
	    		  field : 'ofrNo', headerText : '오퍼번호', headerTextAlign : 'center', width:'70px', textAlign : 'center' , customAttributes :{searchable : true}
	    	  },{
	    		  field : 'ofrNm', headerText : '오퍼명', headerTextAlign : 'center', width:'130px', textAlign : 'left' , customAttributes :{searchable : true}
	    	  },{
	    		  field : 'validStartDate', headerText : '시작일',width:'120px', headerTextAlign : 'center', textAlign : 'center'
	    	  },{
	    		  field : 'validEndDate', headerText : '종료일',width:'120px', headerTextAlign : 'center', textAlign : 'center'
	    	  },{
	    		  field : 'rid', headerText : 'rid',visible : false 
	    	  }
	        ],
			requestGridData : {
				nd   : new Date().getTime(),
				rows : 10,
				sidx : '1',
				sord : 'desc',
				_search : false
			},
			rowList : [10,25,50,100],
			radio: true
		};

		campaignSearchHelp = $("#campaignSearchHelpGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	}

//공통 조회 조건 목록 설정
function campaignSearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("campaignSearchHelpSearchList","LOY_CAMPAIGN_LIST_NEW");
}

//공통 조회 호출
function campaignSearchHelpSearch() {
    $.fn.ifvmSubmitSearchCondition("campaignSearchHelpSearchList", getcampaignSearchHelpSearch);
}

//선택
function choiceCampaignFn(){
	if(campaignObj!=null){
		//promotionSearchHelpPopup.close(campaignObj);
		$('#vocPointPopInfo #camNm').val(campaignObj.campaignName);
		$('#vocPointPopInfo #ridMktCamMst').val(campaignObj.id);
		$('#vocPointPopInfo #offerId').val(campaignObj.offerId);
		$('#vocPointPopInfo #offerNo').val(campaignObj.offerNo);
		$('#vocPointPopInfo #offerType').val(campaignObj.offerType);
		$('#vocPointPopInfo #pntAccntDetailTypeCd').val(campaignObj.pntAccntDetailTypeCd);
		
		dispNo = campaignObj.dispNo; //포인트 수동등록 전용
		camId = campaignObj.rid;		 //캠페인 ID
		$('#camNm').val(campaignObj.promNm); //포인트 수동등록 전용 캠페인명
		
		//chgEvntVal_PntAccntDetailTypeCd();
		promotionSearchHelpPopupClose();
		
		//$("#pntTxnType_2Cd").prop('disabled','true');
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
	            <button class="btn btn-sm" id="campaignSearchHelpSearchBtn" objCode="campaignSearchHelpSearchBtn_OBJ"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	            <button class="btn btn-sm" id="campaignSearchHelpSearchInitBtn" objCode="campaignSearchHelpSearchInitBtn_OBJ">
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
				<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceCampaignBtn" btnFunc="choiceCampaignFn" objCode="choiceCampaignBtn_OBJ"/>
				<ifvm:inputNew type="button"   text="M00441"  id="cancelcampaignSearchHelpBtn" btnFunc="cancelcampaignSearchHelpFn" objCode="cancelcampaignSearchHelpBtn_OBJ"/>
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
