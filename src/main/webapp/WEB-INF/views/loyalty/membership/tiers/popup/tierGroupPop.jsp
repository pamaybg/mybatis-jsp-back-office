<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="tierGroupList"></div>
<div id="tiersList"></div>


<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="tierGroupSelect" objCode="tierGroupPopSelect_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="tierGroupPopCancel" objCode="tierGroupPopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var tierGroupList = null;
var tiersList = null;
var tierGrpTempRid;
var tierGrpTempNm;
var tierTempNm;
var tierTempRid;
var tierTempTypeCd;

function getTierGroupList(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			tierGrpTempRid = data.rid;
			tierGrpTempNm = data.tierGroupNm;
			getTiersList();
        },
		serializeGridData : function( data ){
			data.pgmRid = pgmRid;
			return data;
		},
        dataUrl : '<ifvm:action name="getTierGroupListPop"/>',
        columns:[
        	{
        		  field : 'rid', headerText : 'id', visible : false 
        	  },{
        		  field : 'tierGroupNm', headerText : '등급그룹명', textAlign : 'left', customAttributes : {searchable : true}
        	  },
        ],
        requestGridData : {
      	  sidx : '2',
        },
        radio: true
      };
	tierGroupList = $("#tierGroupList").ifvsfGrid({ ejGridOption : ejGridOption });
};

function getTiersList() {
	var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				tierTempNm = args.data.tierNm;
				tierTempRid = args.data.rid;
				tierTempTypeCd = args.data.tierTypeCd;
        },
		serializeGridData : function( data ){
			data.tierGroupRid = tierGrpTempRid;
			return data;
		},
        dataUrl : '<ifvm:action name="getTiersListPop"/>',
        columns : [
        	{
        		field : 'tierNm', headerText : '등급명',headerTextAlign : 'center', textAlign : 'center',  width:'200px' ,customAttributes :{searchable : true}
      	  },{
    		  field : 'tierTypeCd', headerText : '등급코드', headerTextAlign : 'center', textAlign : 'center',  width:'200px' ,customAttributes :{searchable : true}
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  },
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc',
      	  
        },
        radio: true,
        tempId : 'ifvGridSimplePageTemplete2'
    };
	tiersList = $("#tiersList").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getTierGroupList();
	
	$("#tierGroupSelect").click(function(){
		if(tierTempRid == null){
    		alert('<spring:message code="M00285"/>');
    	} else {
    		tierTempRid = tierTempRid;
    		var rowData = {
    				tierGroupRid : tierGrpTempRid,
    				tierRid		 : tierTempRid,
    				seqNo : seqNo
    		}
    		$('#tierGroupRid'+seqNo).val(tierGrpTempRid);
    		$('#tierRid'+seqNo).val(tierTempRid);
    		$('#tierGroup'+seqNo).val(tierGrpTempNm);
    		$('#tierTypeCd'+seqNo).val(tierTempNm); // tierTempTypeCd -> tierTempNm
    		$.fn.ifvmPopupClose();
    	}
	});
	
	$("#tierGroupPopCancel").click(function(){
		tierGroupClosePop();
	});
});
</script>