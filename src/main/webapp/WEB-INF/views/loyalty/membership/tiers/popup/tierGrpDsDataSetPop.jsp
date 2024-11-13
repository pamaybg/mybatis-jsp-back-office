<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="tierGrpDsdatasetListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnSelect" objCode="tierGrpDsDatasetSelect_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="datasetPopCancle" objCode="tierGrpDsDatasetCancle_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var tierGrpDsdatasetListGrid = null;
var dataSetNm;
var dataSetObjNm;
function gettierGrpDsDatasetListGrid(){
	var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				dataSetRid = data.rid;
				dataSetNm  = data.dsNm;
				dataSetObjNm  = data.objNm;
        },
		serializeGridData : function( data ){
			data.tierGrpJobRid = tierGrpJobRid;
			return data;
		},
        dataUrl : '<ifvm:action name="getTierGrpDsDatasetList"/>',
        columns:[
        	{
        		  field : 'dsNm', headerText : '데이터셋명', width : '60px',  customAttributes :{searchable : true}
        	  },{
	    		  field : 'objNm', headerText : '오브젝트명',width : '60px', headerTextAlign : 'center', textAlign : 'left' ,customAttributes :{searchable : true}
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
	tierGrpDsdatasetListGrid = $("#tierGrpDsdatasetListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function() {
	gettierGrpDsDatasetListGrid();

	$("#btnSelect").on('click', function(){
		if(tierGrpDsdatasetListGrid.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		$('#dsNm').val(dataSetNm);
    		$('#objNm').val(dataSetObjNm);
    		tierGrpDsDataSetListClosePop();
    	}
	});
	
	$("#datasetPopCancle").on('click', function(){
		tierGrpDsDataSetListClosePop();
	}); 
});

</script>
