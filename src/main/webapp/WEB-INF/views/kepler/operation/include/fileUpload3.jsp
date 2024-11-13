<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

// 엑셀 맵핑데이터 저장
function excelMapping(){
	dataIDs = gridIdcolumMappingGrid.getDataIDs();
	
	$.each(dataIDs, function(index,data){
		var rowData = {};
		rowData.colId = index; 
		var value = $("#gridIdcolumMappingGrid #" + data + " td select option:selected").val();
		var code = $("#gridIdcolumMappingGrid #" + data + " td select option:selected").attr("codeid");
		rowData.excelColId = code;
		rowData.excelColNm = value;
		
		if($.fn.ifvmIsNotEmpty(rowData.excelColNm)){
			excelColList.push(rowData);	
		}
	});
	
	formData.append("excelColList", JSON.stringify(excelColList));
	$.ifvProgressControl(true);
	$.ajax({
		url: '<ifvm:action name="setExcelUpload"/>',
		data: formData,
		processData: false,
		contentType: false,
		type: 'POST',
		success: function(data){
			$.ifvProgressControl(false);
 			for(var i=0; i<data.fvId.length; i++){
				fvIds = data.fvId[i];	
			}
 			alert('<spring:message code="M01776"/>');
 			excelResultId = data.id;
 			failCnt = data.failCnt;
 			getExcelUpResultList();
		}
	}); 
	
}
// 엑셀 Head 값 selectbox 담기
function selectFormat(cellvalue, options, rowObjec){
	var select = "<select class='excelHeader' id='" + options.rowId + "' name='" + options.rowId + "'>"  ;
	//option
	$.each(excelHeader, function(index, data){
		if (data == cellvalue) {
			select += "<option codeId='" + index + "' value='" + data + "' selected >"+ data +"</option>";
		} else {
			select += "<option codeId='" + index + "' value='" + data + "'>"+ data +"</option>";
		}
	});
    select += "</select>";
    return select;
}

// 테이블 컬럼목록 조회
function getColumnMappingList(){
    var jqGridOption = {
   		serializeGridData : function( data ){
   			data.tableNm = tmpId;
   		},		
        url : '<ifvm:action name="getMappingColInfo"/>',
        colNames:[ '<spring:message code="M01164"/>',
        	       '<spring:message code="M01777"/>',
        	       'id'
                 ],
        colModel:[
            { name:'colNm', index:'column_comment',  resizable : false },
            { name:'excelColNm', index:'excelColNm', resizable : false, formatter : selectFormat},
            { name:'colId', index:'colId', hidden : true},
        ],
        loadonce: true,
        rowList : [10000],
        sortname: 'ordinal_position * 1',
        sortorder: "asc",
        tempId : 'excelMappingGridTemplate'
    };
    
    columMappingGrid = $("#columMappingGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdcolumMappingGrid = $("#gridIdcolumMappingGrid");
    
}

$(document).ready(function(){
	getColumnMappingList();
	
});

</script>
	
<script id="excelMappingGridTemplate" type="text/ifvGrid-tmpl">
<div class="ifv_grid_templete">
	<div class="grid_con">
		{grid}
	</div>
</div>
</script>

<div class="row">
	<label class="col-xs-10 description_title"><spring:message code="M01778"/></label>
</div>
<div id="columMappingGrid" class="white_bg grid_bd0"></div>
