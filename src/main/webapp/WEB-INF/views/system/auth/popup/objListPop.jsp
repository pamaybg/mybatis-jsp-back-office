<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var objectList =null;
var storeId = null;
var authId;


function authListSetting(){
	
	var ejGridOption = {
			recordDoubleClick : function (args) {
		
		},
		serializeGridData : function( data ){
			return data;
		},
        dataUrl : '<ifvm:action name="getObjectListNew"/>',
        columns:[ 
        	{
        		field : 'objTypeCd', headerText : '<spring:message code="I02088"/>',textAlign : 'center', width :'120px'
        	  },{
        		  field : 'objCd', headerText : '<spring:message code="I02100"/>',textAlign : 'center', customAttributes :{searchable : true}
          	  },{
          		  field : 'objNm', headerText : '<spring:message code="I02101"/>',textAlign : 'center', customAttributes :{searchable : true}
          	  },{
          		  field : 'objDesc', headerText : '<spring:message code="I00075"/>', customAttributes :{searchable : true}
          	  },{
          		  field : 'modifyDate', headerText : '<spring:message code="I02056"/>', textAlign : 'center', width :'130px'
          	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'modifyDate',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio : true,
      };
	objectList = $("#authListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};


function selectObj(){
	
	var object=objectList.opt.gridControl.getSelectedRecords();
	$("#objectCodeVal").val(object[0].objCd);
	$("#objectCode").val(object[0].id);
	closePop();

}
$(document).ready(function() {
	authListSetting();
});

</script>


<div id="authListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="selectObjBtn" onClick="selectObj()" objCode="selectObjBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00038" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnClosePop" onClick="closePop()" objCode="btnClosePop_OBJ"><spring:message code="M00441" /></button>
</div>