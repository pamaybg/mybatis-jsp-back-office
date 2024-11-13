<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="TierDataSetItemListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="dataSetItemSelect" objCode="dataSetItemSelect_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="dataSetItemCancle" objCode="dataSetItemCancle_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var datasetListGrid = null;
var dataSetNm;
var tiersDataSetItemRid;
var dataSetItemfieldNm;
var dataSetItemfieldDesc;
function getTierDataSetItemListGrid(){
	var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				tiersDataSetItemRid = data.rid;
				dataSetItemfieldNm  = data.fieldNm;
				dataSetItemfieldDesc = data.fieldDesc;
        },
		serializeGridData : function( data ){
			data.dataSetRid = dataSetRid;
			return data;
		},
        dataUrl : '<ifvm:action name="getTiersDatasetItemList"/>',
        columns:[
        	{
        		  field : 'fieldNm', headerText : '필드명', width : '60px',  customAttributes :{searchable : true}
        	  },{
	    		  field : 'fieldDesc', headerText : '항목명',width : '60px', headerTextAlign : 'center', textAlign : 'center' ,customAttributes :{searchable : true}
	    	  },
			// {
	    	// 	  field : 'fieldTypeCd', headerText : '필드타입',width : '60px', headerTextAlign : 'center', textAlign : 'center' ,customAttributes :{searchable : true}
	    	//   },
			{
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
	TierDataSetItemListGrid = $("#TierDataSetItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function() {
	getTierDataSetItemListGrid();

	$("#dataSetItemSelect").on('click', function(){
		if(TierDataSetItemListGrid.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		$('#dataSetItemfieldNm').val(dataSetItemfieldNm);
    		$('#dataSetItemfieldDesc').val(dataSetItemfieldDesc);
    		$('#dsItemNm').val(dataSetItemfieldNm);
    		dsItemRid = tiersDataSetItemRid;
    		tiersDataSetItemRid = tiersDataSetItemRid;
    		tierGrpDsDataSetItemClosePop();
    		dsItemRid = tiersDataSetItemRid;
    	}
	});
	
	$("#dataSetItemCancle").on('click', function(){
		tierGrpDsDataSetItemClosePop();
	}); 
});

</script>
