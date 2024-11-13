<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="dataSetListGrid"></div>
<div id="dataSetItemListGrid"></div>
<!-- <div class="page_btn_area" id="dataSetItemArea">
	<div class="col-xs-7">
		<span>데이터셋 아이템</span>
	</div>
</div> -->
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="DataSetItemSelect" objCode="dataSetItemListSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="dataSetItemCancle" objCode="dataSetItemListCancle_OBJ">
		<spring:message code="M00441" />
	</button>
</div>


<script type="text/javascript">
var dataSetItemListGrid = null;
var dataSetListGrid = null;
var tierGrpDataSetRid;
var tierGrpDataSetItemRid;
var tierDataSetItemRid;
var tierRuleDsNm;
var tierRuleDsDesc;
/* var tierFieldTypeCdNm; */

function getDataSetList(){
	var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				tierGrpDataSetRid = data.tierDataSetRid;
				getDataSetItemList();
        },
		serializeGridData : function( data ){
			data.tierGrpJobRid = tierGrpJobRid;
			return data;
		},
        dataUrl : '<ifvm:action name="getDataSetList"/>',
        columns : [
        	{
      		  field : 'dsNm', headerText : '데이터셋명', headerTextAlign : 'center', textAlign : 'center',width:'200px' , customAttributes :{searchable : true}
      	  },{
    		  field : 'objNm', headerText : '오브젝트명', headerTextAlign : 'center', textAlign : 'center',  width:'200px' ,customAttributes :{searchable : true}
    	  },{
    		  field : 'extRange', headerText : '추출범위', textAlign : 'center', headerTextAlign : 'center', textAlign : 'center' , customAttributes : {searchable : true}
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  },{
    		  field : 'tierDataSetRid', headerText : 'TierDataSetRid',visible : false 
    	  }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc',
      	  
        },
        radio: true,
        tempId : 'ifvGridSimplePageTemplete2'
    };
	dataSetListGrid = $("#dataSetListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

function getDataSetItemList(){
	$('#dataSetItemArea').show();
	var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				tierRuleDsNm = args.data.dsNm;
				tierRuleDsDesc = args.data.fieldDesc;
				/* tierFieldTypeCdNm = args.data.fieldTypeCdNm; */
				tierGrpDataSetItemRid = args.data.tierDataSetItemRid;
        },
		serializeGridData : function( data ){
			data.tierGrpDataSetRid = tierGrpDataSetRid;
			return data;
		},
        dataUrl : '<ifvm:action name="getDataSetItemList"/>',
        columns : [
        	{
        		field : 'dsNm', headerText : 'dsNm',visible : false 
      	  },{
    		  field : 'fieldDesc', headerText : '항목명', headerTextAlign : 'center', textAlign : 'center',  width:'200px' ,customAttributes :{searchable : true}
    	  },{
    		  field : 'fieldNm', headerText : '필드명', headerTextAlign : 'center', textAlign : 'center',  width:'200px' ,customAttributes :{searchable : true}
    	  },{
    		  field : 'fieldTypeCdNm', headerText : '필드타입', headerTextAlign : 'center', textAlign : 'center',  width:'200px' ,customAttributes :{index : 'fieldTypeCd'}
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  },{
    		  field : 'tierDataSetRid', headerText : 'tierDataSetRid',visible : false 
    	  },{
    		  field : 'tierDataSetItemRid', headerText : 'tierDataSetItemRid',visible : false 
    	  }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc',
      	  
        },
        radio: true,
        tempId : 'ifvGridSimplePageTemplete2'
    };
	dataSetItemListGrid = $("#dataSetItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

	
$(document).ready(function() {
	getDataSetList();

	$("#DataSetItemSelect").on('click', function(){
		if(dataSetItemListGrid.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		
    		var rowid = tiersCondListGrid.getRadioSelectedRowId();
    		$('#dataSetRidVal'+rowid).val(tierGrpDataSetRid);
    		$('#tierRuleDsNm'+rowid).val(tierRuleDsNm);
    		$('#fieldDesc'+rowid).val(tierRuleDsDesc);
    		$('#dataSetItemRidVal'+rowid).val(tierGrpDataSetItemRid);
    		dataSetItemListClosePop();
    	}
	});
	
	$("#dataSetItemCancle").on('click', function(){
		dataSetItemListClosePop();
	}); 
});

</script>
