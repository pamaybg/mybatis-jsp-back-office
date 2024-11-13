<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="prodTgtGrpIncList"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnProdTgtGrpPopSelect" objCode="prodTgtGrpSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnProdTgtGtpPopCancel" objCode="prodTgtGrpCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var prodTgtGrpIncList = null;
var prodTgtGrpId;
var prodTgtGrpNm;
var prodTgtGrpNo;


function getProdTgtGrpList(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			prodTgtGrpId = data.rid;
			prodTgtGrpNm = data.prodTgtGrpNm;
			prodTgtGrpNo = data.prodTgtGrpNo;
        },
		serializeGridData : function( data ){
			return data;
		},
        dataUrl : '<ifvm:action name="getProdTgtGrpList"/>',
        columns:[
        	{
        		field : 'prodTgtGrpNo', headerText : '상품군번호',textAlign : 'center', customAttributes :{searchable : true}
        	  },{
        		  field : 'prodTgtGrpNm', headerText : '상품군명',textAlign : 'left',  customAttributes :{searchable : true}
        	  },{
        		  field : 'id', headerText : 'id', visible : false 
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '1',
      	  sord : 'desc',
        },
        radio: true
      };
	prodTgtGrpIncList = $("#prodTgtGrpIncList").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	getProdTgtGrpList();
	
	$("#btnProdTgtGrpPopSelect").click(function(){
		if(prodTgtGrpIncList.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#prodTgtGrpNo').val(prodTgtGrpNo);
    		$('#prodTgtGrpNm').val(prodTgtGrpNm);
    		prodTgtGrpRid = prodTgtGrpId;
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnProdTgtGtpPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>