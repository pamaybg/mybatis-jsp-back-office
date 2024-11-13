<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="tgtGrpIncList"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnTgtGrpPopSelect" objCode="tgtGrpIncPopSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btntgtGtpPopCancel" objCode="tgtGrpIncPopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var tgtGrpIncList = null;
var tgtGrpId;
var itgtGrpNm;
var itgtGrpNo;


function getTgtGrpIncList(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			tgtGrpId = data.rid;
			itgtGrpNm = data.tgtGrpNm;
			itgtGrpNo = data.tgtGrpNo;
        },
		serializeGridData : function( data ){
			return data;
		},
        dataUrl : '<ifvm:action name="getTgtGrpIncList"/>',
        columns:[
        	{
        		field : 'tgtGrpNo', headerText : '고객군번호',textAlign : 'center', customAttributes :{searchable : true}
        	  },{
        		  field : 'tgtGrpNm', headerText : '고객군명',textAlign : 'left',  customAttributes :{searchable : true}
        	  },{
        		  field : 'tgtTypeCdNm', headerText : '유형',textAlign : 'center',  customAttributes :{index : 'tgtTypeCd'}
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
	tgtGrpIncList = $("#tgtGrpIncList").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	getTgtGrpIncList();
	
	$("#btnTgtGrpPopSelect").click(function(){
		if(tgtGrpIncRid == ''){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#tgtGrpNo').val(itgtGrpNo);
    		$('#tgtGrpNm').val(itgtGrpNm);
    		tgtGrpIncRid = tgtGrpId;
    		tgtGrpCntrlRid = tgtGrpId;
    		tgtGrpActionRid = tgtGrpId;
    		ruleTgtGrpRid = tgtGrpId;
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btntgtGtpPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>