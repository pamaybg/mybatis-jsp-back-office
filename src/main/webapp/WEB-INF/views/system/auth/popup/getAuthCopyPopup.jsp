<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>


var authListPop = null;

var storeId = null;
var authCopyId=null;
var authId;

function selectAuthCopy(){
	if(confirm('<spring:message code="D10277"/>')) {
	$.ifvSyncPostJSON('<ifvm:action name="callAuthCopyProc"/>',{
		pAuthID : setAuthId,
		pAtuhCopyID : authCopyId
	},
	function(result) {
		alert('<spring:message code="D10278"/>');
		objAuthPopupClose();
	},function(result){
		alert('<spring:message code="D10279"/>');
	});
}
}

function authListSetting(){
	
	var ejGridOption = {
			recordDoubleClick : function (args) {
			
		},rowSelected : function (args) {
			authCopyId=args.data.id;
        },
		serializeGridData : function( data ){
	
			data.id=setAuthId
			return data;
		},
        dataUrl : '<ifvm:action name="getAuthCopyList"/>',
        columns:[ 
        	{
        		  field : 'authNo', headerText : '<spring:message code="I02059"/>', headerTextAlign : 'center',
        	  },{
          		  field : 'authName', headerText : '<spring:message code="I02060"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'authDesc', headerText : '<spring:message code="I00075"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'authCreater', headerText : '<spring:message code="I02055"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'authCreateDate', headerText : '<spring:message code="I02056"/>', headerTextAlign : 'center',
          	  },{
          		  field : 'id', headerText : 'id', visible : false
          	  }	        	
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'authCreateDate',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio : true,
      };
	authListPop = $("#authListGridPop").ifvsfGrid({ ejGridOption : ejGridOption });
};


$(document).ready(function() {
	authListSetting();
});

</script>


<div id="authListGridPop"></div>
<div class="pop_btn_area">
	<button id="btnSave" class="btn btn-sm btn_gray"  id="selectAuthBtn" onClick="selectAuthCopy()" objCode="getAuthCopyPopSelectBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00038" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnClosePop" onClick="objAuthPopupClose()" objCode="getAuthCopyPopCloseBtn_OBJ" ><spring:message code="M00441"/></button>
</div>