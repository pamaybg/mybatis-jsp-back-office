<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="datasetListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnSelect" objCode="datasetListSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="datasetPopCancle" objCode="datasetListCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var datasetListGrid = null;
var dataSetNm;

function getDatasetListGrid(){
	var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				dataSetRid = data.rid;
				dataSetNm  = data.dsNm;
        },
		serializeGridData : function( data ){
			data.cateMbr = $("#cateMbr").val();
			return data;
		},
        dataUrl : '<ifvm:action name="getDatasetList"/>',
        columns:[
        	{
        		  field : 'dsNm', headerText : '데이터셋명', width : '60px',  customAttributes :{searchable : true}
        	  },{
	    		  field : 'objNm', headerText : '오브젝트명',width : '60px', headerTextAlign : 'center', textAlign : 'center' ,customAttributes :{searchable : true}
	    	  },{
          		  field : 'rid', headerText : 'rid', visible : false 
          	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '1',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
      };
	datasetListGrid = $("#datasetListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function() {
	getDatasetListGrid();

	$("#btnSelect").on('click', function(){
		if(datasetListGrid.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		$('#mbrDsNm').val(dataSetNm);
    		$('#dataSetRid').val(dataSetRid);
    		dsRid = dataSetRid;
    		$.fn.ifvmPopupClose();
    	}
	});
	
	$("#datasetPopCancle").on('click', function(){
		$.fn.ifvmPopupClose();
	}); 
});

</script>
