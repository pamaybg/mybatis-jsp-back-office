<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">
var authList = null;
var authId;

function selectAuth(){
	var chkArr =  $("#gridIdauthListGrid").ejGrid("getRows"); 
	selectProgramAuthList = [];
	
	if(chkArr != "" && chkArr != null){
			for(var i=0; i<chkArr.length; i++) {
				if($($(chkArr[i])[0]).attr('aria-selected')) {
					selectProgramAuthList.push($(chkArr[i])[0].lastElementChild.innerText);
			    }
			}
	}
	
	 var jsonData = {	
				pgmId :pgmId,
				authIdList : selectProgramAuthList
	}
	 	
	$.ifvSyncPostJSON('<ifvm:action name="setAuthProgramAddRel"/>',jsonData,
	function(result) {
		AuthPopupClose();
		alert("권한이 등록되었습니다.")
	},function(result){
		if(selectProgramAuthList==""){
			alert("권한을 선택해주세요")
		}else{
		alert("권한 등록에 실패하였습니다.");
		}
	});

}

function authListInit(){
	var ejGridOption = {
		rowSelected : function (args) {
        	authId=args.data.id
        },
		serializeGridData : function( data ){
			data.pgmId=pgmId;
			return data;
		},
        dataUrl : '<ifvm:action name="getAuthProgramList"/>',
        columns:[ 
        	{
    			type : "checkbox",
    			width : 50
    		},
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
          		  field : 'id', headerText : 'id', visible : false ,
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
      };
	authList = $("#authListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
};

$(document).ready(function() {
	authListInit();
	 var gridId = "gridIdauthListGrid";
	 $.ifvCheckBoxGrid(gridId);
	 
	 
});

</script>

<div id="authListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="selectAuthBtn" onClick="selectAuth()" objCode="getAuthAddDialogSelect_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00038" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnClosePop" onClick="AuthPopupClose()" objCode="getAuthAddDialogClose_OBJ"><spring:message code="M00441" /></button>
</div>