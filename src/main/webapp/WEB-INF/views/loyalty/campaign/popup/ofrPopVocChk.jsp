<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="mktOfferListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnCommOfferPopSelect" objCode="ofrPopVocChkSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCommOfferPopCancel" objCode="ofrPopVocChkSCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var mktOfferList = null;
var offerNm;
var offerNo;


function mktOfferListSetting(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			offerId = data.rid;
			offerNm = data.ofrNm;
			offerNo = data.ofrNo;
        },
		serializeGridData : function( data ){
			if(typeof ofrType != "undefined") {
				data.ofrType = ofrType;
			}
			
			if(typeof vocChk != "undefined") {
				data.vocChk = vocChk;
			}
			
			if(typeof txnDetailCd != "undefined") { // 거래상세유형값 존재여부 확인
				if(txnDetailCd == '160') { // '대응 지급 가능 여부' 체크되었을 경우
					data.vocYn = 'Y';
					data.empYn = null;
				} else if(txnDetailCd == '161') { // '임직원 지급 가능 여부' 체크되었을 경우 
					data.empYn = 'Y';
					data.vocYn = null;
				} 
			}
			
			return data;
		},
        dataUrl : '<ifvm:action name="getOfferListPopVoc"/>',
        columns:[
        	{
        		  field : 'id', headerText : 'id', visible : false 
        	  },{
        		  field : 'ofrNo', headerText : '<spring:message code="E00004"/>',textAlign : 'center',width: '100px', customAttributes :{searchable : true}
        	  },{
          		  field : 'ofrNm', headerText : '<spring:message code="E00005"/>',textAlign : 'left',width: '200px',  customAttributes :{searchable : true}
          	  },{
          		  field : 'ofrTypeCdNm', headerText : '<spring:message code="E00006"/>',textAlign : 'center',width: '150px', customAttributes :{index : 'ofrTypeCd'}
          	  },{
          		  field : 'ofrSubTypeCdNm', headerText : '<spring:message code="E00007"/>', textAlign : 'center',width: '90px', customAttributes :{index : 'ofrSubTypeCd'}
          	  },{
          		  field : 'statCdNm', headerText : '<spring:message code="상태"/>', textAlign : 'center',width: '90px', customAttributes :{index : 'statCd'}
          	  },{
          		  field : 'cpnYn', headerText : '쿠폰여부', textAlign : 'center',width: '70px', customAttributes :{searchable : true}
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'ofrNo,ofrNm',
      	  sord : 'ASC',
        },
        radio: true
      };
	mktOfferList = $("#mktOfferListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	mktOfferListSetting();
	
	$("#btnCommOfferPopSelect").click(function(){
		if(offerId == ''){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#offerNo').val(offerNo);
    		$('#ofrNo').val(offerNo);
    		$('#ofrNm').val(offerNm);
    		$('#sa1OfrNo').val(offerNo);
    		$('#sa1OfrNm').val(offerNm);
    		$('#ticketOfrNm').val(offerNm);
    		$('#ridOfr').val(offerId);
    		$('#offerId').val(offerId);
    		$('#offerNo').val(offerNo);
    		
    		offerRid = offerId;
    		ruleOfrRid = offerId;
    		ofrNo = offerNo;
    		sa1OfferRid = offerId;
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnCommOfferPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>