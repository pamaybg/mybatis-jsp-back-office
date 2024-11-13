<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="parParamGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnParParamSelect" objCode="parParamPopSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnParParamCancel" objCode="parParamPopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var paramNm=null;
var paramRid=null;

function offerListSetting(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			paramRid = data.rid;
			paramNm = data.paramNm;
        },
		serializeGridData : function( data ){
			data.paramTypeCd = paramTypeCd;
			//data.paramSubTypeCd = paramSubTypeCd;
			data.rid         = rid;
			return data;
		},
        dataUrl : '<ifvm:action name="getParParamList"/>',
        columns:[
        	{
        		  field : 'rid', headerText : 'id', visible : false 
        	  },{
        		  field : 'paramNm', headerText : '<spring:message code="파라미터명"/>', textAlign : 'left', customAttributes : {searchable : true}
        	  },{
          		  field : 'paramTypeCdNm', headerText : '<spring:message code="유형"/>', textAlign : 'center', customAttributes : {index : 'paramTypeCd'}
          	  },{
          		  field : 'dataTypeCdNm', headerText : '<spring:message code="데이터유형"/>', textAlign : 'center', customAttributes : {index : 'dataTypeCd'}
          	  },
        ],
        requestGridData : {
      	  sidx : '2',
        },
        radio: true
      };
	$("#parParamGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	offerListSetting();
	
	$("#btnParParamSelect").click(function(){
		if(paramRid == null){
    		alert('<spring:message code="M00285"/>');
    	} else {
			$("#parParamNm").val(paramNm);
			parRid = paramRid;
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnParParamCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>