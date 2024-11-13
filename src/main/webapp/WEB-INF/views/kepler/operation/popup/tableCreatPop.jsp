<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var validation;
var sqlQuery = null;

function getTableCreat(){
	$("#creatServiceNm").val(dbInformId);
	$("#creatTblNm").val(tableNm);
	$("#creatDpNm").val(dpNm);
	$("#creatDbmsTypeCd").val(dbType);
	$("#creatSchmaNm").val(schmaNm);
}

//create문 생성
function createVal(){
	var temp = null;

	$.ifvSyncPostJSON('<ifvm:action name="getCreatTblCol"/>'
	,{ tableId : tableId }
	,function(result) {
		var tblColList = result;
		temp = 'create table '+schmaNm+"."+tableNm+'(';

		if(dbType == "MySQL"){
			tblColList.forEach(function(obj , i){
				temp += obj.colNm+" "+obj.dataTypeCd;
				// 사이즈
				if(obj.len.toString.length>0 || obj.len != null){
					temp += "("+obj.len+")";
				}
				// 널여부
				if(obj.nullYn == "Y"){
					temp += " not null ";
				}
				// 디폴트명
				if(obj.deftVal != null){
					if(obj.deftVal.length>0){
						temp += " default '"+obj.deftVal+"'";
					}
				}
				// 디스플레이명
				if(obj.dpNm.length>0 || obj.dpNm != null){
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
		
			sqlQuery = temp;
			 if (confirm(sqlQuery) == true) {
				$.ifvSyncPostJSON('<ifvm:action name="setTableCreat"/>', { 
				    sqlQuery : sqlQuery, dbInformId : dbInformId
				}, function(result) {
	                alert('<spring:message code="M02243" />');
			    }); 
			} 
		}
		else {
			tblColList.forEach(function(obj , i) {
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
				if(obj.deftVal != null){
					if(obj.deftVal.length>0){
						temp += " default '"+obj.deftVal+"'";
					}
				}
				// pk여부
				if(obj.pkYn == "Y"){
					temp += " primary key";
				}		
				temp +=",";
			});
			temp = temp.slice(0,-1);
			temp += ") tablespace "+tblSpaceNm;
	
			sqlQuery = temp;
			if(confirm(sqlQuery) == true){
				$.ifvSyncPostJSON('<ifvm:action name="setTableCreat"/>', {
				    sqlQuery : sqlQuery , dbInformId : dbInformId
				}, function(result) {
				    //alert("테이블이 생성 되었습니다.");
			        alert('<spring:message code="M02243" />');
				}); 
			}
			tblColList.forEach(function(obj , j){
				if(obj.dpNm != null){
					if(obj.dpNm.length>0){
						var commentQuery = "comment on column "+tableNm+"."+obj.colNm+" is '"+obj.dpNm+"'";
						alert(commentQuery);
					}
				}
				 $.ifvSyncPostJSON(
					'<ifvm:action name="setTableCreat"/>'
				   , { sqlQuery : commentQuery , dbInformId : dbInformId}
				   , function(result) {
				   }); 
			});
		}
	});
	
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
	getTableCreat();
	
	$("#tblCreatPopCancel").on("click", tableMstPopClose);
	
 	$("#tblCreatSaveBtn").on("click", function(){
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
	    	<label class="col-xs-3 control-label"><spring:message code="M01440" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="select" id="creatServiceNm" />
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="M00519" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="creatTblNm" disabled="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="M01573" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="creatDpNm" disabled="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="M00508" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="creatDbmsTypeCd"  disabled="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="M01583" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="creatSchmaNm" disabled="true"/>
	        </div>
	    </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="tblCreatSaveBtn">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tblCreatPopCancel">         
		<spring:message code="M00284"/>
	</button>  
</div>