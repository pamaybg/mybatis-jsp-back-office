<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var orgInfoGrid;

//조직정보 리스트
function orgInfoGrid(){
	var jqGridOption = {
		serializeGridData : function( data ){
		},
	    url: '<ifvm:action name="getOrganizationInfoList"/>', 
	    colNames:[
	              '<spring:message code="M00555"/>',
	              '<spring:message code="M00336"/>', 
	              '<spring:message code="L00479"/>', 
	              '<spring:message code="L00478"/>',
	              '<spring:message code="L00480"/>',
	              '<spring:message code="L00481"/>',
	              'rid'
	              ], 
	    colModel:[
	        {name:'divNm',     index:'cd1.div_nm',      resizable : false,  searchable : true, align :'center'},
	        {name:'divNo',     index:'cd1.div_no',      resizable : false,  searchable : true, align :'center'},
	        {name:'divLvl',    index:'cd1.div_lvl',     resizable : false,  searchable : true, align :'center'},
	        {name:'divTypeCd', index:'cc1.mark_name',   resizable : false,  searchable : true, align :'center'},
	        {name:'ridParDiv', index:'cd2.div_nm',      resizable : false,  searchable : true, align :'center'},
	        {name:'divStatus', index:'cc2.mark_name',   resizable : false,  searchable : true, align :'center'},
	        {name:'rid',       index:'cd1.rid',         hidden : true}
	    ],
	    radio:true,
	    sortname: 'cd1.MODIFY_DATE',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete' 
	};
	orgInfoGrid = $("#orgInfoGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	orgInfoGrid();
	
	//선택 클릭시
    $('#selectBtn').on('click', function(){
    	if(orgInfoGrid.getCheckedGridData() == ''){
    		alert('<spring:message code="L00117"/>');
    	}else {
    		var dataArr = orgInfoGrid.getCheckedGridData();
  			$("#"+popSelectlId).val(dataArr[0].rid);
  			$('#ridParDivNm').val(dataArr[0].divNm);
        	popupClose();	
    	}
    });
	
  	//취소 클릭시
    $('#cancelBtn').on('click', function(){
    	popupClose();
    });
});
</script>

<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="orgInfoGrid" class=""></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectBtn" objCode="orgSearchPopCancel_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
			<spring:message code="L00123"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="cancelBtn" objCode="orgSearchPopSelect_OBJ">
	    <spring:message code="L00124"/>         
	    </button> 
	</div>
</div>
