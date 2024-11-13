<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="mktOfferListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnCommBnftPopSelect" objCode="">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCommBnftPopCancel" objCode="">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var mktBnftList = null;
var bnftNm;
var bnftNo;
var bnftId;

function mktOfferListSetting(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			bnftId = data.rid;
			bnftNm = data.ofrNm;
			bnftNo = data.ofrNo;
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
	mktBnftList = $("#mktOfferListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	mktOfferListSetting();
	
	$("#btnCommBnftPopSelect").click(function(){
		if(mktBnftList.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#bnftOfrNm').val(bnftNo);
    		bnftOfrRid = bnftId;
    		$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnCommBnftPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>