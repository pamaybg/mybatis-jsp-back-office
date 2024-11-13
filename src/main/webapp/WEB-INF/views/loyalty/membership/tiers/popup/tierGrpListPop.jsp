<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="tierGrpListPopList"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="tierGrpListPopSelect" objCode="tierGrpListPopSelect_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="tierGrpListPopClose" objCode="tierGrpListPopClose_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var tierGrpListPopList = null;
var tierCdRid;

function getTierGrpListGridPop(){
	var ejGridOption = {
	    	serializeGridData : function(data) {
	    		data.tierGroupRid = tierGroupDetail_rid;
				return data;
			},rowSelected : function(args){
				tiersRulesTierRid = args.data.rid;
	       	},
	        dataUrl : '<ifvm:action name="getTierListNewPage"/>',

	        columns : [
	        	{
	      		  field : 'seqNo', headerText : '순서', headerTextAlign : 'center', textAlign : 'center', width:'60px',  customAttributes :{searchable : true}
	      	  },{
	    		  field : 'tierNm', headerText : '등급명', headerTextAlign : 'center', textAlign : 'center',  width:'150px' ,customAttributes :{searchable : true}
	    	  },{
	    		  field : 'tierTypeCd', headerText : '등급유형', textAlign : 'center', headerTextAlign : 'center', width:'80px', textAlign : 'center' , customAttributes : {index : 'tierTypeCd'}
	    	  },{
	    		  field : 'baseTierYn', headerText : '기본등급', headerTextAlign : 'center', textAlign : 'center' , width:'80px', customAttributes :{searchable : true}
	    	  },{
	    		  field : 'rid', headerText : 'rid',visible : false 
	    	  }
	        ],

	        requestGridData : {
	      	  sidx : '1',
	      	  sord : 'ASC',
	        },
	        radio: true
	    };
	
			tierGrpListPopList = $("#tierGrpListPopList").ifvsfGrid({ ejGridOption : ejGridOption });

};


$(document).ready(function() {
	getTierGrpListGridPop();

	$("#tierGrpListPopSelect").on('click', function(){
		tierDataArr = null;
		if(tierGrpListPopList.opt.gridControl.getSelectedRecords().length == 0) {
			alert('<spring:message code="M00285"/>');
		} else {
    		tierGrpListPopupClose();
    		
    	}
	});
	
	$("#tierGrpListPopClose").on('click', function(){
		tierGrpListPopupClose();
	}); 
});

</script>
