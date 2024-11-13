<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="expectTgtGrpIncList"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnExpectTgtGrpPopSelect" objCode="expectTgtGrpSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnExpectTgtGtpPopCancel" objCode="expectTgtGrpCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var tgtGrpIncList = null;
var expectTgtGrpId;
var iexpectTgtGrpNm;
var iexpectTgtGrpNo;


function getExpectTgtGrpIncList(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			expectTgtGrpId = data.rid;
			iexpectTgtGrpNm = data.tgtGrpNm;
			iexpectTgtGrpNo = data.tgtGrpNo;
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
	expectTgtGrpIncList = $("#expectTgtGrpIncList").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	getExpectTgtGrpIncList();
	
	$("#btnExpectTgtGrpPopSelect").click(function(){
		if(expectTgtGrpRid == ''){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#expectTgtGrpNm').val(iexpectTgtGrpNm);
    		$('#expectTgtGrpNo').val(iexpectTgtGrpNo);
    		expectTgtGrpRid = expectTgtGrpId;
    		ruleExpectTgtGrpRid = expectTgtGrpId;
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnExpectTgtGtpPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>