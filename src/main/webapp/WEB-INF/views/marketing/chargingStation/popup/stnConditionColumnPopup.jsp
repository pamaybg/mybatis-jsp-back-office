<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var conditionColumnGrid; 

function initConditionColumnGrid() {

	var colModelList = conditionDetailGrid.jqGridOption.colModel;
	var colNameList = conditionDetailGrid.jqGridOption.colNames; 
	
	var data = [];
	var cnt = 0;
	colModelList.forEach(function(info) {
		data[cnt] = {
			header : info.name,
			headerName : colNameList[cnt]
		}
		cnt++;
	})
	
    var jqGridOption = {
			data: data,
            colNames:['<spring:message code="M01164"/>',
                      'header'
            ],
            colModel:[
                      {name:'headerName',index:'headerName', align:'center', searchable : true, sortable:false},
                      {name:'header',index:'header', hidden:true}
            ],
            datatype: 'clientSide',
            multiselect : true,
            tempId : 'ifvGridOriginTemplete'
        };
    conditionColumnGrid = $("#conditionColumnGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//선택한 컬럼만 부모창 내 show
function showSelectedColumn() {
	var checkedList = conditionColumnGrid.getCheckedList();
	var colModelSettings = originJqGridOption.colModel;
	
	if(checkedList.length > 0) {
		for(var z=0; z<colModelSettings.length; z++) {
			colModelSettings[z].hidden = true;
		}
		
		for(var i=0; i<checkedList.length; i++) {
			for(var j=0; j<colModelSettings.length; j++) {
				if(colModelSettings[j].name == checkedList[i].header) {
					colModelSettings[j].hidden = false;
					break;
				}
			}
		}
		
		setConditionDetailGridCustom(colModelSettings);
		conditionColumnSetPopupClose();
	} else {
		alert('<spring:message code="L00066"/>');
	}
}

//확인
$("#conditionColumnPopupSaveBtn").on("click", function(){ 
	showSelectedColumn();
});

//닫기 
$("#conditionColumnPopupCancelBtn").on("click", function(){ 
	conditionColumnSetPopupClose();
});

$(document).ready(function(){
	initConditionColumnGrid();
});
</script>

<style>
.left_bold {font-weight:bold; text-align: left !important;}
</style>

<div id="dialogPopupWrap">
	<div class="pop_inner_wrap form-horizontal">
		<div class="row" id="conditionColumnGrid"/>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm" id="conditionColumnPopupSaveBtn"> <!-- 확인 -->
	        <spring:message code="C00126" />
	    </button>
	    <button class="btn btn-sm" id="conditionColumnPopupCancelBtn"> <!-- 닫기 -->
	        <spring:message code="L00913"/>
	    </button> 
	</div>
</div>