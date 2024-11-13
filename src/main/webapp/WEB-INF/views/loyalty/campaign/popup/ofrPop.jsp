<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="mktOfferListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnCommOfferPopSelect" objCode="ofrPopSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCommOfferPopCancel" objCode="ofrPopCancel_OBJ">
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
			
			return data;
		},
        dataUrl : '<ifvm:action name="getOfferListPop"/>',
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
          		  field : 'statCd', headerText : '<spring:message code="상태"/>', textAlign : 'center',width: '90px', customAttributes :{index : 'statCdNm'}
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
	$(".searchbox_select")[0].value="오퍼명";

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