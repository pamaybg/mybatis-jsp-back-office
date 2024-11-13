<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var commCodeExParList;

$(document).ready(function() {
	setCommCodeExParList();
	
	$("#btnParSelect").on('click', function(){
		selectParCodeId();
	});	
	$("#btnParClose").on('click', function(){
		commCodeExParPopupClose();
	});
});

function setCommCodeExParList() {
    var jqGridOption = {
           	ondblClickRow : function(data){
           	},
            onSelectRow : function (data) {
           	},
          	serializeGridData : function( data ){
          		data.strSchema	= $("#strSchema").val();
           	},		
           	loadComplete : function(obj){
           	},	
            url : '<ifvm:action name="getCommCodeExParCodeList"/>',
            colNames:[ 
                       '<spring:message code="M00241"/>',
                       '<spring:message code="M00238"/>',
                       'CODE NAME',
                       'MARK NAME',
                       '<spring:message code="M00237"/>',
                       'id'
                     ],
            colModel:[
                { name:'groupCode', index:'GROUP_CODE', resizable : false },
                { name:'groupName', index:'GROUP_NAME', resizable : false },
                { name:'codeName', index:'CODE_NAME', resizable : false },
                { name:'markName', index:'MARK_NAME', resizable : false},
                { name:'lang', index:'LANG', resizable : false},
                { name:'id', index:'ID', hidden : true }
            ],
            sortname: 'GROUP_CODE',
            sortorder: "ASC",
            radio: true,
            tempId : 'ifvGridOriginTemplete'
        };
        
    commCodeExParList = $("#commCodeExParCodeGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function selectParCodeId() {
	var selectedParCodeItem = commCodeExParList.getCheckedList();
	if($.fn.ifvmIsNotEmpty(selectedParCodeItem)) {
		$("#validationArea #parCodeId").val(selectedParCodeItem[0].id); // hidden의 rid필드에 parCode에 대한 rid값을 초기화해넣는다(DB로 실제 저장이 이뤄질것)
		$("#validationArea #parCodeNm").val(selectedParCodeItem[0].codeName); // 눈에보이는 parCodeNm필드에 parCode에 대한 코드네임을 초기화해넣는다(보여주기 용) 
		commCodeExParPopupClose();
	} else {
		alert('<spring:message code="M01705" />');
	}
}

</script>
<div id='dbInformPopFormArea'>
	<div class="pop_inner_wrap">
		<div id="commCodeExParCodeGrid" class="grid_bd0 grid_w660"></div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnParSelect" objCode="commCodeExParCodePopSelect_OBJ">     
		<i class="glyphicon glyphicon-check" ></i>    
		<spring:message code="M00211"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnParClose" objCode="commCodeExParCodePopClose_OBJ">         
		<spring:message code="C00040"/>
    </button> 
</div>
