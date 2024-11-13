<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="targetGroupList"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnTargetGroupPopSelect" objCode="">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnTargetGroupPopCancel" objCode="">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var targetGroupList = null;
var targetNm;

function getTargetGroupList(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			targetId = data.rid;
			targetNm = data.tgtGroupNm;
        },
		serializeGridData : function( data ){
			return data;
		},
        dataUrl : '<ifvm:action name="getTargetGroupList"/>',
        columns:[
        	{
        		  field : 'id', headerText : 'id', visible : false 
        	  },{
        		  field : 'ofrNo', headerText : '<spring:message code="E00004"/>',textAlign : 'center', customAttributes :{searchable : true}
        	  },{
          		  field : 'ofrNm', headerText : '<spring:message code="E00005"/>',textAlign : 'left',  customAttributes :{searchable : true}
          	  },{
          		  field : 'ofrTypeCdNm', headerText : '<spring:message code="E00006"/>',textAlign : 'center', customAttributes :{index : 'ofrTypeCd'}
          	  },{
          		  field : 'ofrSubTypeCdNm', headerText : '<spring:message code="E00007"/>', textAlign : 'center', customAttributes :{index : 'ofrSubTypeCd'}
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'ofrNo',
      	  sord : 'ASC',
        },
        radio: true
      };
	targetGroupList = $("#targetGroupList").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function(){
	getTargetGroupList();
	
	$("#btnTargetGroupPopSelect").click(function(){
		if(targetGroupList.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		$('#conView').val(targetNm);
    		targetGroupRid = targetId;
        	$.fn.ifvmPopupClose();
    	}
	});
	
	$("#btnTargetGroupPopCancel").click(function(){
		$.fn.ifvmPopupClose();
	});
});
</script>