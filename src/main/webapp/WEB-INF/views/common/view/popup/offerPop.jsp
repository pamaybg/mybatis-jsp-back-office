<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="offerListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnCommOfferPopSelect" objCode="offerPopSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCommOfferPopCancel" objCode="offerPopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var offerNm;
var offerNo;
var ofrType;
var ofrSubType;
var ofrValAmt;
var ofrValType;

function offerListSetting(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			offerId = data.rid;
			offerNm = data.ofrNm;
			offerNo = data.ofrNo;
			cpnYn   = data.cpnYn;
			ofrType = data.ofrTypeCd;
			ofrSubType = data.ofrSubTypeCd;
			ofrValType = data.ofrValType;
			ofrValAmt = data.ofrValAmt;
        },
		serializeGridData : function( data ){
			if($("#tierBnftTypeCd").val()=='undefined') {
				data.issType='N';
			}
			return data;
		},
        dataUrl : '<ifvm:action name="getOfferListPop"/>',
        columns:[
        	{
        		  field : 'id', headerText : 'id', visible : false 
        	  },{
        		  field : 'ofrNo', headerText : '<spring:message code="E00004"/>', textAlign : 'center', customAttributes : {searchable : true}
        	  },{
          		  field : 'ofrNm', headerText : '<spring:message code="E00005"/>', textAlign : 'left', customAttributes : {searchable : true}
          	  },{
          		  field : 'ofrTypeCdNm', headerText : '<spring:message code="E00006"/>', textAlign : 'center', customAttributes : {index : 'ofrTypeCd'}
          	  },{
          		  field : 'ofrSubTypeCdNm', headerText : '<spring:message code="E00007"/>', textAlign : 'center', customAttributes : {index : 'ofrSubTypeCd'}
          	  },{
          		 field : 'cpnYn', headerText : '<spring:message code="쿠폰여부"/>', textAlign : 'center', customAttributes : {searchable : true}
        	  },{
          		  field : 'issTypeNm', headerText : '발급구분', textAlign : 'center',width: '70px', customAttributes :{index : 'issType'}
          	  },{
        		  field : 'ofrValType', headerText : 'id', visible : false 
        	  },{
        		  field : 'ofrValAmt', headerText : 'id', visible : false 
        	  }
        ],
        requestGridData : {
      	  sidx : 'ofrNo',
        },
        radio: true
      };
	$("#offerListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	offerListSetting();
	
	$("#btnCommOfferPopSelect").click(function(){
		if(offerId == ''){
    		alert('<spring:message code="M00285"/>');
    	} else {
            var targetFields = ifvGlobal.searchHelp.field;
            $('#' + targetFields.rid).val(offerId);
            $('#' + targetFields.name).val(offerNm);
            $('#' + targetFields.no).val(offerNo);
            $('#' + targetFields.ofrSubType).val(ofrSubType);
            if(ofrType=='P') {
    			$("#ofrValType").val("F");
    			$("#ofrValAmt").attr("disabled",false);
    			$("#qty").attr("disabled",true);
    	    	$("#qty").val("");
    	    	/* $("#textLabel").text("원"); */
    		} else {
    			$("#ofrValType").val(ofrValType);
    			$("#ofrValAmt").val(ofrValAmt);
    			$("#ofrValAmt").attr("disabled",true);
    			$("#qty").attr("disabled",false);
    			/* $("#textLabel").text("%"); */
    		}
            if(ofrValType=='R' ) {
            	$("#textLabel").text("%");
            } else if (ofrValType=='F' || ofrValType=='B') {
            	$("#textLabel").text("원");
            }
            
            if(cpnYn=='Y') {
    	    	/* $("#qty").attr("disabled",false); */
    	    	$("#cpnYn").val("쿠폰");
    	    	/* $("#textLabel").text("원"); */
    	    } else {
    	    	/* $("#qty").attr("disabled",true); */
    	    	/* $("#qty").val(""); */
    	    	$("#cpnYn").val("");
    	    	/* $("#textLabel").text("Point"); */
    	    }
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnCommOfferPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>