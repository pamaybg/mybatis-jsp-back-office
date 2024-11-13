<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="authListGridCon"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="addMenuListBtn" objCode="authAddListModelAdd_OBJ">
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnClose"  objCode="authAddListModelClose_OBJ">
		<spring:message code="M00441" />
	</button>
</div>


<script type="text/javascript">
var gridVal;
var authAddList;
var authSelectedList = new Array;
var authList = new Array;
var empData = new Object;
var gridRecord = 0;
var check = true;
var totalPage = 0;
var selectList = new Array;
var page;

function authAddListInit(){
	var ejGridOption = {
		rowSelected : function (args) {
			var data = args.data;
			
			authData = data;
			authData.page = page;
			var rid = authData.authId
			
			if(authSelectedList.length > 0){
				if(authSelectedList.indexOf(rid) != -1 ){
					authSelectedList.remove(authSelectedList.indexOf(rid));
				}else{
					authSelectedList.push(rid);
				}
			}else{
				authSelectedList.push(rid);
			}
			
        },
		serializeGridData : function( data ){
			data.authGroupId = groupId;
			return data;
		},
        dataUrl : '<ifvm:action name="getAuthAddListModal"/>',
        columns : [
		 	 {
		 			type : "checkbox" , width : 60, headerText :'선택'
		 	 },{
				field : 'authName', headerText : '<spring:message code="I02060"/>',  textAlign : 'center', customAttributes :{searchable : true, index: 'h.aut_nm'}
			}, {
				field : 'authNo', headerText : '<spring:message code="I02059"/>', textAlign : 'left', customAttributes :{searchable : true, index : 'h.aut_num'}
			}, {
				field : 'authDesc', headerText : '<spring:message code="I00075"/>',  textAlign : 'center', customAttributes : { searchable : true, index : 'h.aut_desc'}
			}, {
				field : 'authId', headerText : '<spring:message code="authId"/>', visible : false
			} ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'h.create_date',
      	  sord : 'desc',
        },
        radio: false
      };
	authAddList = $("#authListGridCon").ifvsfGrid({ ejGridOption : ejGridOption });
	
};



$(document).ready(function(){
	authAddListInit();
	
	$('#addMenuListBtn').click(function(){

		
	    if(authSelectedList.length == 0){
	        alert('<spring:message code="I02051"/>');
	    }else{
			$.ifvSyncPostJSON('<ifvm:action name="addAuthList"/>',{
				authSelectList : authSelectedList,
				 authGroupId : groupId,
			}, function(result){
				$.fn.ifvmPopupClose();
				authGrid._doAjax();
			},function(result){
				if(result.message) alert(result.message);
				else alert('추가 실패');
			});
	    }
	});
	
	$("#btnClose").click(function(){
		$.fn.ifvmPopupClose();
	});
});

</script>