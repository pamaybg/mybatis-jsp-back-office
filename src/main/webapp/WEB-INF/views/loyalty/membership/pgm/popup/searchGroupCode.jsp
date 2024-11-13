<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="groupCodeListGrid" class="white_bg grid_bd0"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="seletGroupCode" objCode="searchGroupCodeSelect_OBJ">
		<spring:message code="M00131" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="closeGpCdPopBtn" objCode="searchGroupCodeClose_OBJ">
		<spring:message code="M01322" />
	</button>
</div>
<script type="text/javascript">
var groupCodeList;
var codeName = null;
var markName = null;

function getGroupCodeListGrid() {
	var ejGridOption = {
		serializeGridData : function(data) {
			return data;
		},
		rowSelected : function (args) {
			codeName = args.data.groupCode;
			markName = args.data.groupName;
        },
        recordDoubleClick : function (args) {
        	$("#gpCdNm").val(args.data.groupCode);
			$("#gpNm").val(args.data.groupName);
        	$.fn.ifvmPopupClose();
		},
        dataUrl : '<ifvm:action name="getGroupCodeListPop"/>',
        columns:[
      	  {
        		  field : 'typeMarkNm', headerText : '<spring:message code="LO2683"/>',  textAlign : 'center',
        		  customAttributes : {index : 'type' }
        	  },{
        		  field : 'groupCode', headerText : '<spring:message code="M00241"/>',
        		  customAttributes : {searchable : true} //
        	  },{
        		  field : 'groupName', headerText : '<spring:message code="M00238"/>', 
        		  customAttributes : { searchable : true} //
        	  },{
        		  field : 'lang', headerText : '<spring:message code="M00237"/>', textAlign : 'center',
        		  customAttributes : {searchable : true} //
        	  }
      ],
		 requestGridData : {
			rows : 10,
			sidx : 'groupCode',
			sord : 'asc'
		},
		rowList:[10, 20, 30],
		radio : true
	};

	groupCodeList = $("#groupCodeListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	getGroupCodeListGrid();
	
	$("#seletGroupCode").click(function(){
		if(codeName == null){
			alert('<spring:message code="M00499"/>')
		}else{
			$("#gpCdNm").val(codeName);
			$("#gpNm").val(markName);
        	$.fn.ifvmPopupClose();
		}
	});
	
	$("#closeGpCdPopBtn").click(function(){
    	$.fn.ifvmPopupClose();
	});
	
});
</script>