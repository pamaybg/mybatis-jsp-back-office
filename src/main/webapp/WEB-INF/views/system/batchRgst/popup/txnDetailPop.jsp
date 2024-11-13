<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="txnCodeListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnTxnCodePopSelect" objCode="btnTxnCodePopSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnTxnCodePopCancel" objCode="btnTxnCodePopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var txnCodeListGrid = null;
var txnCodeNm;
function getTxnCodeList(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			txnCodeNm = data.markName;
			txnDetailCd = data.codeName;
        },
		serializeGridData : function( data ){
			data.pntTxnCode = $("#pntTxnType").val();
			return data;
		},
        dataUrl : '<ifvm:action name="getTxnCodeList"/>',
        columns:[
        	  {
        		  field : 'codeName', headerText : '거래유형 코드',textAlign : 'center', customAttributes :{searchable : true}
        	  },{
          		  field : 'markName', headerText : '거래상세유형',textAlign : 'cetner',  customAttributes :{searchable : true}
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '2',
      	  sord : 'DESC',
        },
        radio: true
      };
	txnCodeListGrid = $("#txnCodeListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	getTxnCodeList();
	
	$("#btnTxnCodePopSelect").click(function(){
		if(txnCodeListGrid.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		
    		$('#pntTxnDtlType').val(txnCodeNm);
    		
    		txnDetailCd = txnDetailCd;
    		
    		if(txnDetailCd=="161"){
    			$("#chnlNm").val("복리후생(HR)");
    			chnlNo="CH0000518";
    		}else if(txnDetailCd=="160"){	
    			$("#chnlNm").val("CS(고객서비스)");
    			chnlNo="CH0000519";
    		}else if(txnDetailCd=="111"){	
    			$("#chnlNm").val("락앤락몰");
    			chnlNo="CH0000128";
    		}else if(txnDetailCd=="110"){	
    			$("#chnlNm").val("고객통합(멤버십)");
    			chnlNo="CH0000001";
    		}
    		
    		$('#ofrNm').val(null);
    		$('#pntAmt').val(null);
    		$('#vocDesc').val(null);
    		
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnTxnCodePopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>