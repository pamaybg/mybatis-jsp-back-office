<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="mktOfferListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnCommOfferPopSelect" objCode="sa1RuleOfrSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCommOfferPopCancel" objCode="sa1RuleOfrCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var mktOfferList = null;
var offerNm;
var offerNo;
var cpnYn;
function mktOfferListSetting(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			offerId = data.rid;
			offerNm = data.ofrNm;
			offerNo = data.ofrNo;
			cpnYn = data.cpnYn;
        },
		serializeGridData : function( data ){
			return data;
		},
        dataUrl : '<ifvm:action name="getOfferListPop"/>',
        columns:[
        	{
        		  field : 'id', headerText : 'id', visible : false 
        	  },{
        		  field : 'ofrNo', headerText : '<spring:message code="E00004"/>',textAlign : 'center', customAttributes :{searchable : true}
        	  },{
          		  field : 'ofrNm', headerText : '<spring:message code="E00005"/>',textAlign : 'left',  customAttributes :{searchable : true}
          	  },{
          		  field : 'ofrTypeCdNm', headerText : '<spring:message code="E00006"/>',textAlign : 'center', customAttributes :{index : 'ofrTypeCd'}
          	  },{
          		  field : 'ofrSubTypeCdNm', headerText : '<spring:message code="E00007"/>', textAlign : 'center', customAttributes :{index : 'ofrSubTypeCd'}
          	  },{
          		  field : 'cpnYn', headerText : '쿠폰여부', textAlign : 'center', customAttributes :{searchable : true}
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'ofrNo',
      	  sord : 'ASC',
        },
        radio: true
      };
	mktOfferList = $("#mktOfferListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	mktOfferListSetting();
	
	$("#btnCommOfferPopSelect").click(function(){
		if(mktOfferList.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#sa1RuleOfrRid'+ruleSa1SeqNo).val(offerId);
    		$('#sa1RuleOfrNo'+ruleSa1SeqNo).val(offerNo);
    		$('#sa1RuleOfrNm'+ruleSa1SeqNo).val(offerNm);
    		$('#sa1CpnYn'+ruleSa1SeqNo).val(cpnYn);
    		
    		$('#sa2SumRuleOfrRid'+ruleSa1SeqNo).val(offerId);
    		$('#sa2SumRuleOfrNo'+ruleSa1SeqNo).val(offerNo);
    		$('#sa2SumRuleOfrNm'+ruleSa1SeqNo).val(offerNm);
    		
    		
    		$('#ac2OnRuleOfrRid'+ruleSa1SeqNo).val(offerId);
    		$('#ac2OnRuleOfrNo'+ruleSa1SeqNo).val(offerNo);
    		$('#ac2OnRuleOfrNm'+ruleSa1SeqNo).val(offerNm);
    		
			/* if(cpnYn=='Y') {
    			$("#ac2OnOfrAmtType"+ruleSa1SeqNo).attr("disabled",true);
    			$("#ac2OnOfrAmtType"+ruleSa1SeqNo).val("");
    			$("#sa2SumOfrAmtType"+ruleSa1SeqNo).attr("disabled",true);
    			$("#sa2SumOfrAmtType"+ruleSa1SeqNo).val("");
    			$("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",true);
    			$("#ofrAmtType"+ruleSa1SeqNo).val("");
    		} else {
    			$("#ac2OnOfrAmtType"+ruleSa1SeqNo).attr("disabled",false);
    			$("#sa2SumOfrAmtType"+ruleSa1SeqNo).attr("disabled",false);
    			$("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",false);
    		} */
    		$.fn.ifvmPopupClose();

    		if($("#sa1CpnYn"+ruleSa1SeqNo).val()=='Y') {
    	      	$("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",true);
    	      	$("#info"+ruleSa1SeqNo).text("개");
    		} else {
    			$("#ofrAmtType"+ruleSa1SeqNo).attr("disabled",false);
    			$("#info"+ruleSa1SeqNo).text("");
    		}
    	}
	});
	
	$("#btnCommOfferPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>