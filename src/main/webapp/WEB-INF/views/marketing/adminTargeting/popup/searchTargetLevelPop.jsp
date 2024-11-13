<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var areaList;
var selectId;
var selectNm;
var selectChk = false;

function areaList(){
	var jqGridOption = {
		onSelectRow : function (data) {
			selectChk = true;
			selectNm = data.targetLevelNm;	
			selectTargetId = data.targetLevelId
		},
		url: '<ifvm:action name="getTargetLevelsList"/>',
	    colNames:[
	              '<spring:message code="M01122"/>',
	              '<spring:message code="M01123"/>',
	              '<spring:message code="M01124"/>',
	              '<spring:message code="M01125"/>',
	              '<spring:message code="M01126"/>',
	              '<spring:message code="M01127"/>',
	              '<spring:message code="M01129"/>',
	              '<spring:message code="M01131"/>',
	              '<spring:message code="M01132"/>',
	              'id'
	              ],
	    colModel:[{name:'targetLevelNm', index:'mstl.target_level_nm', resizable : false},
	              {name:'conDbType', index:'cc.code_name', resizable : false},
	              {name:'dbNm', index:'mstl.db_nm', resizable : false},
	              {name:'conIp', index:'mstl.con_ip', resizable : false},
	              {name:'conPort', index:' mstl.con_port', resizable : false},
	              {name:'conId', index:'mstl.con_id', resizable : false},
	              {name:'targetDesc', index:'mstl.target_desc', resizable : false},
	              {name:'empName', index:'em.name', resizable : false},
	              {name:'createDate', index:'mstl.create_date', resizable : false},
	              {name:'targetLevelId', index:'mstl.id', resizable : false, hidden : true}
			      ],  
		radio:true,
	    sortname: 'mstl.target_level_nm',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	areaList = $("#columnGridCon").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	areaList();
	$("#TgtLvlbtnSave").on("click", function(){
		if(selectChk){
			$("#targetLevelNm2").val(selectNm);
			$("#targetLevelNm").val(selectNm);
			fdPopClose();
		}
		else{
			alert('<spring:message code="M00004" />');
		}
	});
	$("#btnCancel").on("click", function(){
		fdPopClose();
	});
});
</script>

<div class="pop_inner_wrap">
	<div id="columnGridCon" class="grid_bd0 grid_w660"></div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="TgtLvlbtnSave">     
		<i class="glyphicon glyphicon-check" ></i>    
		<spring:message code="M00282"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCancel">         
		<spring:message code="M00284"/>
    </button> 
</div>
