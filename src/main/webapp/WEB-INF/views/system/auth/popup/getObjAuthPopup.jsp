<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var authList = null;
var authId;
var progId = pgmId;
var objID = objID;

//선택
function selectAuth(){
	selectAuthList = [];
	
	if(authList.getCheckedGridData().length > 0){
		//그리드에서 선택된 row 가져오기
		for(var i=0; i<authList.getCheckedGridData().length; i++){
			selectAuthList[i] = authList.getCheckedGridData()[i].id; 
		}
		
		 var jsonData = {	
					objId : objID,
					pgmId :progId,
					authIdList : selectAuthList
		}
		 
		$.ifvSyncPostJSON('<ifvm:action name="setAuthObjRelPopup"/>',jsonData,
		function(result) {
			objAuthPopupClose();
			objAuthList._doAjax();
			alert("권한이 등록되었습니다.")
		},function(result){
			if(selectAuthList==""){
				alert("권한을 선택해주세요")
			}else{
			alert("권한 등록에 실패하였습니다.");
			}
		});
	}else{
		alert("목록을 선택해주세요")
	}
	

}

function authListSetting(){
	
	var jqGridOption = {
		onSelectRow : function (data) {
			
        	authId=data.id;
        },
        serializeGridData : function( data ){
			
			data.uiObjId=objID;
			data.pgmId=progId;
			return data;
		},
		url : '<ifvm:action name="getAuthListPop"/>',
		//헤더 이름
		 colNames:[ 
			 '<spring:message code="I02059" />',
            '<spring:message code="I02060" />',
             '<spring:message code="I00075" />',
             '<spring:message code="I02055" />',
             '<spring:message code="I02056" />',
             'id'
  		],
  		//데이터 매핑
        colModel:[ 
        	{
        		name : 'authNo', index : 'authNo',resizable : true, width: 100 ,searchable : true, align :'center'
        	  },{
        		name : 'authName',  index : 'authName',resizable : true,  searchable : true, align :'center'
          	  },{
          		name : 'authDesc',  index : 'authDesc',resizable : true,  searchable : true, align :'center'
          	  },{
          		name : 'authCreater', index : 'authCreater',resizable : true,   searchable : true, align :'center'
          	  },{
          		name : 'authCreateDate', index : 'authCreateDate', resizable : true,    searchable : true, align :'center'
          	  },{
          		name : 'id', index : 'id', hidden : true ,
          	  }	        	
        ],
        multiselect: true,
        sortname : 'authCreateDate',
        sortorder : 'desc',
        tempId: 'ifvGridOriginTemplete',
        rowList : [10,25,50,100],
      };
	authList = $("#authListGrid").ifvGrid({ jqGridOption : jqGridOption });
	//그리드 사이즈 조정
	authList.setWidth(911);
};


$(document).ready(function() {
	authListSetting();
	//var gridId = "gridIdauthListGrid";
	 //$.ifvCheckBoxGrid(gridId);
});

</script>

<div id="authListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="selectAuthBtn" onClick="selectAuth()" objCode="getObjAuthPopSelectBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00038" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnClosePop" onClick="objAuthPopupClose()" objCode="getObjAuthPopCloseBtn_OBJ"><spring:message code="M00441" /></button>
</div>