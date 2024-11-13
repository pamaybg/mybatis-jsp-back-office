<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">
var gridVal;
var empAddListModal = null;
var empSelectedList = new Array;
var empList = new Array;
var empData = new Object;
var gridRecord = 0;
var check = true;
var totalPage = 0;
var selectList = new Array;
var groupId;
var page;

function empAddListModalInit(){
	var jqGridOption = {
		onSelectRow : function(data) {

			for(var i=0; i<gridRecord; i++){
				if(empSelectedList[i] != null && empSelectedList[i] != "null"){
					if(empSelectedList[i].empId != data.empId){
						check = true
					}
					else{
						empSelectedList.remove(i);
						check = false
						break;
					}
				}
			}
			if(check){

				empData = data;
				empData.page = page;
				empSelectedList.push(empData);
			}
		},
		onSelectAll : function(data) {


			if(empAddListModal.getCheckedGridData().length > 0){

				if(empSelectedList.length > 0){
					for(i=0; i<empAddListModal.getCheckedGridData().length; i++){
						for(j=0; j<empSelectedList.length; j++){

							if(empAddListModal.getCheckedGridData()[i].empId != empSelectedList[j].empId){
								check = true;
							}
							else{
								if(empSelectedList[j].page == page){

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
							if($.inArray(empList[i], empSelectedList) < 0){
								empList[i].page = page;
								empSelectedList.push(empList[i]);
							}
						}
						else{
							if($.inArray(empList[i], empSelectedList) > 0){
								empSelectedList.remove(empSelectedList.indexOf(empList[i]))
							}
						}
					}
				}
				else
				{
					for(i=0; i<empList.length; i++){
						empList[i].page = page;
						empSelectedList.push(empList[i])
					}
				}
			}
			else{

				if(empSelectedList.length > 0){
					for(var j=0; j<empSelectedList.length; j++){

						for(var i=0; i<empList.length; i++){

							if(empSelectedList[j].empId == empList[i].empId)
								empSelectedList.remove(j);

						}
					}
				}
			}
		},
		loadComplete : function(data){

			empList = data.rows;
			page = data.page
			gridRecord = data.records;
			totalPage = (data.records / data.rows.length);

			for(var i=0; i<gridRecord; i++){
				if(empSelectedList[i] != null && empSelectedList[i] != "null"){
					//if(empSelectedList[i].page == data.page){
						for(var j=0; j<empList.length; j++){
							if(empSelectedList[i].empId == empList[j].empId){
								selectList.push(j+1);
							}
						}
					//}
				}
			}
			empAddListModal.setCheckRow(selectList);
			selectList = [];

		},
		serializeGridData : function(data){

			data.accountId = ifvmUserInfo.accountId;
			data.authGroupId = groupId;
		},

        url : '<ifvm:action name="getEmpAddListModal"/>',
        colNames:[
					'userId',
					'<spring:message code="I02078" />',
					'<spring:message code="I00187" />',
					'<spring:message code="I02079" />',
					'empId',
					'ridUser'
                   ],
        colModel:[
					{ name:'userId', index:'u.user_id', resizable : false ,  searchable : false },
					{ name:'empName', index:'e.name', resizable : false },
			        { name:'empEmail', index:'e.email', resizable : false ,searchable: false },
			        { name:'empType', index: 'cc.mark_name', resizable : false},
			        { name:'empId', index:'e.id', hidden : true, searchable : false},
			        { name:'ridUser', index:'u.rid', hidden : true, searchable : false}
        ],
        sortname: 'e.create_date',
        sortorder: "desc",
        multiselect: true,
        caption: '<spring:message code="I02077"/>',
        tempId: 'ifvGridOriginTemplete'
    };
	empAddListModal = $("#empListGridCon").ifvGrid({ jqGridOption : jqGridOption });
};




$('#addMenuListBtn').click(function() {

	var empSelectList = new Array;
	var userSelectList = new Array;

	if (empSelectedList.length == 0) {
		alert('<spring:message code="I02051"/>');
	}
	else {
		for (var i = 0; i < empSelectedList.length; i++) {
			empSelectList.push(empSelectedList[i].empId);
			userSelectList.push(empSelectedList[i].ridUser);
		}
		if (confirm('<spring:message code="I02052"/>')) {

			$.ifvSyncPostJSON('<ifvm:action name="addEmpList"/>', {
				empSelectList : empSelectList,
				authGroupId : groupId,
				userSelectList : userSelectList
			}, function(result) {
				initUserGrid();
				appClose();
			});
		}
	}
});

function appClose() {
	javascript:$.modalClose();
}


$(document).ready(function(){
	empAddListModalInit();


});

</script>


<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header" >
			<button type="button" class="close" onclick="javascript:$.modalClose();">&times;</button>
   			<h4 class="modal-title"><spring:message code="I02080" /></h4>
		</div>
		<div class="modal-body" >
			<div class="row">
				<div id="empListGridCon" class="con_size"></div>
			</div>
		</div>
			<center>
				<div id="menuLsitBtn" class="row qt_border">
					<button class="btn btn-sm btn_gray" id="addMenuListBtn" objCode="empAddListModalAdd_OBJ">
						<i class="glyphicon glyphicon-check"></i>
						<spring:message code="I02030" />
					</button>
				</div>
		    </center>
	</div>
</div>