<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var validation;

function getIdxCreat(){
	$("#creatServiceNm").val(dbInformId);
	$("#creatTblNm").val(tableNm);
	$("#creatDpNm").val(dpNm);
	$("#creatDbmsTypeCd").val(dbType);
	$("#creatSchmaNm").val(schmaNm);
}

//create문 생성
function createVal(){
	var temp = null;
	;
	$.ifvSyncPostJSON('<ifvm:action name="getCreatIdxCol"/>'
	,{ tableId : tableId, idxId : idxId }
	,function(result) {
		var tblColList = result;
		temp = 'create table '+tableNm+'(';

		if(dbType == "MySQL"){
			tblColList.forEach(function(obj , i){
				temp += obj.colNm+" "+obj.dataTypeCd;
				// 사이즈
				if(obj.len.toString.length>0){
					temp += "("+obj.len+")";
				}
				// 널여부
				if(obj.nullYn == "Y"){
					temp += " not null ";
				}
				// 디폴트명
				if(obj.deftVal.length>0){
					temp += " default '"+obj.deftVal+"'";
				}
				// 디스플레이명
				if(obj.dpNm.length>0){
					temp +=" comment'"+obj.dpNm+"'";
				}
				// pk여부
				if(obj.pkYn == "Y"){
					temp += " primary key";
				}		
				temp +=",";
			});
			temp = temp.slice(0,-1);
			temp += ") ENGINE=InnoDB DEFAULT CHARSET=utf8";
		}else{
			tblColList.forEach(function(obj , i){
				temp += obj.colNm+" "+obj.dataTypeCd;
				// 사이즈
				if(obj.len.toString.length>0){
					temp += "("+obj.len+")";
				}
				// 널여부
				if(obj.nullYn == "Y"){
					temp += " not null ";
				}
				// 디폴트명
				if(obj.deftVal.length>0){
					temp += " default '"+obj.deftVal+"'";
				}
				// pk여부
				if(obj.pkYn == "Y"){
					temp += " primary key";
				}		
				temp +=",";
			});
			temp = temp.slice(0,-1);
			temp += ") tablespace "+tblSpaceNm;
		}
		alert(temp);
	});
	
//	return temp;
} 

//공통코드 조회 - db 유형
function getDbServiceComboList(){
	$.ifvSyncPostJSON(
		'<ifvm:action name="getDbServiceComboList"/>'
	   , {}
	   , function(result) {
			var temp = $("#selectTmp").tmpl(result.rows);
			$("#creatServiceNm").append(temp);
	   });
}; 

$(document).ready(function(){
	$("#tblCreatPopFormArea").ifvValidation();
	getDbServiceComboList();
	getIdxCreat();
	
	$("#idxCreatPopCancel").on("click", tableMstPopClose);
	
 	$("#idxCreatSaveBtn").on("click", function(){
 		createVal();
	}); 
	
});
</script>

<script id="selectTmp" type="text/x-jquery-tmpl">
<option value="${'${'}id}">${'${'}text}</option>
</script>

<div id='tblCreatPopFormArea'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01440"/></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="select" id="creatServiceNm" />
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="M00519"/></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="creatTblNm" disabled="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="M01573"/></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="creatDpNm" disabled="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="M00508"/></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="creatDbmsTypeCd"  disabled="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="M01583"/></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="creatSchmaNm" disabled="true"/>
	        </div>
	    </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="idxCreatSaveBtn">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M01575"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="idxCreatPopCancel">         
		<spring:message code="C00040"/>
	</button>  
</div>