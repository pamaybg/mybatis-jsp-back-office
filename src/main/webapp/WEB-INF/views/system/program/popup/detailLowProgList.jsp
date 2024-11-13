<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>



<script type="text/javascript">
var programList = null;
var childprgId = null;
var programNm = null;

function programListSetting(){
	var ejGridOption = {
			rowSelected : function (args) {
				childprgId = args.data.id;
				programNm = args.data.pgmNm;
        },
		serializeGridData : function( data ){
			data.prgId=progId;
			return data;
		},
        dataUrl : '<ifvm:action name="getDetailParProgList"/>',
        columns:[
        	{
        		  field : 'pgmNo', headerText : '<spring:message code="I02044"/>', customAttributes :{searchable : true}
        	  },{
          		  field : 'pgmNm', headerText : '<spring:message code="I02045"/>', customAttributes :{searchable : true}
          	  },{
          		  field : 'pgmTypeCd', headerText : '<spring:message code="I02046"/>', customAttributes :{index : 'pgmType'}
          	  },{
          		  field : 'pgmPath', headerText : '<spring:message code="I02047"/>', customAttributes :{searchable : true}
          	  },{
          		  field : 'prog_crea', headerText : '<spring:message code="I02055"/>', customAttributes :{index : 'name'}
          	  },{
          		  field : 'createDate', headerText : '<spring:message code="I02056"/>'
          	  },{
          		  field : 'id', headerText : 'id',visible : false 
          	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'createDate',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
      };
	programList = $("#programListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function() {
	programListSetting();

	$("#btnSelect").on('click', function(){
		if(childprgId == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		$('#parPgmId').val(childprgId);
    		$('#parPgmNm').val(programNm);
    		parPopupClose();
    	}
	});
	
	$("#btnCancel").on('click', function(){
		parPgmId = null;
		parPopupClose();
	}); 
});

</script>


<div id="programListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnSelect" objCode="selectParProgram_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="parProgramPopClose_OBJ"><spring:message code="M00441" /></button>
</div>
