<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 현재 사용 않합니다  -->
<script type="text/javascript">
var gridVal;
var authAddListModal = null;
var authSelectedList = new Array;
var authList = new Array;
var empData = new Object;
var gridRecord = 0;
var check = true;
var totalPage = 0;
var selectList = new Array;
var page;

function authAddListModalInit(){
	var jqGridOption = {
		onSelectRow : function(data) {

			for(var i=0; i<gridRecord; i++){
				if(authSelectedList[i] != null && authSelectedList[i] != "null"){
					if(authSelectedList[i].authId != data.authId){
						check = true
					}
					else{
						authSelectedList.remove(i)
						check = false
						break;
					}
				}
			}
			if(check){
				authData = data;
				authData.page = page;
				authSelectedList.push(authData);

			}
		},
		onSelectAll : function(data) {


			if(authAddListModal.getCheckedGridData().length > 0){

				if(authSelectedList.length > 0){
					for(i=0; i<authAddListModal.getCheckedGridData().length; i++){
						for(j=0; j<authSelectedList.length; j++){

							if(authAddListModal.getCheckedGridData()[i].authId != authSelectedList[j].authId){
								check = true;
							}
							else{
								if(authSelectedList[j].page == page){

									check = false;
									break;
								}
								else{
									check=true;
									break;
								}
							}
						}

						if(check){
							if($.inArray(authList[i], authSelectedList) < 0){
								authList[i].page = page;
								authSelectedList.push(authList[i]);
							}
						}
						else{
							if($.inArray(authList[i], authSelectedList) > 0){
								authSelectedList.remove(authSelectedList.indexOf(authList[i]))
							}
						}
					}
				}
				else
				{
					for(i=0; i<authList.length; i++){
						authList[i].page = page;
						authSelectedList.push(authList[i])
					}
				}
			}
			else{

				if(authSelectedList.length > 0){
					for(var j=0; j<authSelectedList.length; j++){

						for(var i=0; i<authList.length; i++){

							if(authSelectedList[j].authId == authList[i].authId)
								authSelectedList.remove(j);

						}
					}
				}
			}
		},
		loadComplete : function(data){

			authList = data.rows;
			gridRecord = data.records;
			totalPage = (data.records / data.rows.length);

			for(var i=0; i<gridRecord; i++){
				if(authSelectedList[i] != null && authSelectedList[i] != "null"){
						for(var j=0; j<authList.length; j++){
							if(authSelectedList[i].authId == authList[j].authId){
								selectList.push(j+1);
							}
						}
				}
			}
			authAddListModal.setCheckRow(selectList);
			selectList = [];

		},
		serializeGridData : function(data){
			data.authGroupId = groupId;
		},

        url : '<ifvm:action name="getAuthAddListModal"/>',
        colNames:[
					'<spring:message code="I02060" />',
					'<spring:message code="I02059" />',
					'<spring:message code="I00075" />',
					'authId'
                   ],
        colModel:[
					{ name:'authName', index:'h.aut_nm', resizable : false },
			        { name:'authNo', index:'h.aut_num', resizable : false },
			        { name:'authDesc', index: 'h.aut_desc', resizable : false},
			        { name:'authId', index:'h.id', hidden : true, searchable : false}
        ],
        sortname: 'h.create_date',
        sortorder: "desc",
        multiselect: true,
        caption: '<spring:message code="I02062"/>'
    };
	authAddListModal = $("#authListGridCon").ifvGrid({ jqGridOption : jqGridOption });
};




  $('#addMenuListBtn').click(function(){

	var authSelectList = new Array;

    if(authSelectedList.length==0){
        alert('<spring:message code="I02051"/>');
    }else{
    	for(var i=0; i<authSelectedList.length; i++){
    		authSelectList.push(authSelectedList[i].authId);
    	}
	if(confirm('<spring:message code="I02052"/>')){

		 $.ifvSyncPostJSON('<ifvm:action name="addAuthList"/>',
	 		{authSelectList : authSelectList,
			 authGroupId : groupId,
			 },
			 function(result){

				 initAuthGrid();
 				 appClose();
             });
	 }
    }

});

function appClose() {
	javascript:$.modalClose();
}


$(document).ready(function(){
	authAddListModalInit();


});

</script>


<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header" >
			<button type="button" class="close" onclick="javascript:$.modalClose();">&times;</button>
   			<h4 class="modal-title"><spring:message code="I02064" /></h4>
		</div>
		<div class="modal-body" >
			<div class="row">
				<div id="authListGridCon" class="con_size"></div>
			</div>
		</div>
			<center>
				<div id="menuLsitBtn" class="row qt_border">
					<button class="btn btn-sm btn_gray" id="addMenuListBtn" objCode="authAddListModelAdd_OBJ">
						<i class="glyphicon glyphicon-check"></i>
						<spring:message code="I02030" />
					</button>
				</div>
		    </center>
	</div>
</div>