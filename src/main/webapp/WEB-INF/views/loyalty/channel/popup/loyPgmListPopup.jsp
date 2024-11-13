<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="programListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnSelect" objCode="loyPgmListPopupSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="pgmPopBtnCancel" objCode="loyPgmListPopupCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var loyProgramList = null;
var PgmNm;
var PgmNo;

function programListSetting(){
	var ejGridOption = {
			recordDoubleClick : function(args){
				$('#pgmNo').val(pgmNo);
	    		$('#pgmNm').val(pgmNm);
	    		$('#pgmRid').val(pgmRid);
	    		$.fn.ifvmPopupClose();
		        },
			rowSelected : function (args) {
				var data = args.data;
				pgmRid = data.rid;
				pgmNm  = data.pgmNm;
				pgmNo  = data.pgmNo;
        },
		serializeGridData : function( data ){
			
			return data;
		},
        dataUrl : '<ifvm:action name="getLoyPgmListNew"/>',
        columns:[
        	{
        		  field : 'pgmNo', headerText : '프로그램 번호', textAlign : 'center', width : '60px',  customAttributes :{searchable : true}
        	  },{
          		  field : 'pgmNm', headerText : '프로그램명', width : '150px', customAttributes :{searchable : true}
          	  },{
          		  field : 'rid', headerText : 'rid',visible : false 
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '3',
      	  sord : 'ASC',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
      };
	loyProgramList = $("#programListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function() {
	programListSetting();

	$("#btnSelect").on('click', function(){
		if(loyProgramList.opt.gridControl.getSelectedRecords().length==0){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		$('#pgmNo').val(pgmNo);
    		$('#pgmNm').val(pgmNm);
    		$('#pgmRid').val(pgmRid);
    		$.fn.ifvmPopupClose();
    		//loyPgmListClosePop();
    	}
	});

	$("#pgmPopBtnCancel").on('click', function(){
		$.fn.ifvmPopupClose();
		//loyPgmListClosePop();
	});
});

</script>
