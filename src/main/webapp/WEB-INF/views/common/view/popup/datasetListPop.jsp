<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="datasetList"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnDatasetPopSelect" objCode="datasetListSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnDatasetPopCancel" objCode="datasetListCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var datasetList = null;
var dsNm;

function getDatasetListSetting(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			dsId = data.rid;
			dsNm = data.dsNm;
        },
		serializeGridData : function( data ){
			return data;
		},
		dataUrl : '<ifvm:action name="getDataSetMasterList"/>',
		columns : [
			{
				field : 'dsNm', headerText : '데이터셋명', headerTextAlign : 'center', textAlign : 'left',width:'230px',
				customAttributes: {searchable : true }
			},{
				field : 'objNm', headerText : '오브젝트 이름', headerTextAlign : 'center', textAlign : 'left',width:'230px',
				customAttributes: {searchable : true}
			},{
				field : 'name', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center',width:'110px',
				customAttributes: {index : 'name',searchable : true}
			},{
				field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center',width:'150px',

			},{
				field : 'rid', headerText : 'rid', headerTextAlign : 'center', textAlign : 'center', visible : false,
				customAttributes: {		index : 'rid'	}
			}
		],
		requestGridData : {
			sidx : "4",
			sord : 'desc',
		},
		radio : true,
};
	datasetList = $("#datasetList").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	getDatasetListSetting();
	
	$("#btnDatasetPopSelect").click(function(){
		if(datasetList.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#conView').val(dsNm);
    		$('#dsNm').val(dsNm);
    		datasetRid = dsId;
    		dataSetRid = dsId;
    		dsRid = dsId;
    		chnlDatasetRid = dsId;
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnDatasetPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>