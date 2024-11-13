<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>

<link href="${pageContext.request.contextPath}/resources/js/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />

<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/icekake/icekake.js' type="text/javascript"></script>


<script id="commCodeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script>

var validation;
var id = '<%= cleanXss(request.getParameter("id")) %>';
if( id == 'null' ) id = null;



function getObjectDataTypeCommonCode(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'OBJ_TYPE_CD'
	},function(result){
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#objectDataType").append(temp);
	});
};

function objectDetail(){

		$.ifvSyncPostJSON('<ifvm:action name="getObjectDetail"/>',{
			id : id
		},
		function(result) {
			$('#objectDataType').val(result.objTypeCd);
			$('#objectCode').val(result.objCd);
			$('#objectName').val(result.objNm);
			$('#id').val(result.id);
			$('#objectDesc').val(result.objDesc);
		});
};

function saveClick(){
	$("#btnSave").click(function(){

		if(validation.confirm() == true){
			 var jsonData = {
					objTypeCd : $("#objectDataType").val(),
					objCd : $("#objectCode").val(),
					objNm : $("#objectName").val(),
					objDesc : $("#objectDesc").val()
				}
			 if( id == null ){
				//신규
				url = '<ifvm:action name="insertObjectDetail"/>';
				if(confirm('<spring:message code="I01881"/>') === false) return;
			}else{
				//수정
				url = '<ifvm:action name="updateObjectDetail"/>';
				jsonData.id = id;
				if(confirm('<spring:message code="I01882"/>') === false) return;
			}

			$.ifvSyncPostJSON(url, jsonData, function(result) {

				if(result.message == '1'){
					if(result.success == true){
						alert('<spring:message code="I00741"/>');
						id = result.message;
						qtjs.href('<ifvm:url name="objectList"/>');
					}
				}else{
					alert('<spring:message code="I02106"/>');
					$('#objectCode').focus();
				}

			 }, null, null, "#btnSave" );
		}
	});
}

//목록 돌아가기
function goList() {
	qtjs.href('<ifvm:url name="objectList"/>');
}

$(document).ready(function() {

	getObjectDataTypeCommonCode();

	$.ifvmLnbSetting('objectListNew');

	if(id != null){
		objectDetail();
	}

	if( id != null ){
		$("#titleDetailName").html('<spring:message code="I00195"/>');
	}

	validation = $("#formArea").ifvValidation();

	saveClick();
});


</script>

<div class="page-title">
	<h1>
		<spring:message code="I02105"/>
		 &gt; <span id="titleDetailName"><spring:message code="I00080" /></span>
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="I02089" /></span>
		</div>
		 <div class="col-sm-5 searchbtn_r">
			<ifvm:inputNew type="button" id="btnSave" className="authUpdateBtn" text="I02029" btnType="save" objCode="objectDetailSave_OBJ"/>
			<ifvm:inputNew type="button" id="goObjListNew" btnFunc="goList" text="L00824" objCode="goObjListNew_OBJ" />
		</div>
	</div>
	
	<div class="well" id="formArea">
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="select" id="objectDataType" required="true" label="I02088" labelClass="1" conClass="4"/>
			</div>
		</div>
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="objectCode" required="true" label="I02100" labelClass="1" conClass="4" />
				<span style="color:red"> ※ 유일한 값이여야합니다.</span>
			</div>
		</div>
	
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="objectName" required="true" label="I02101" labelClass="1" conClass="4" />
				<ifvm:inputNew type="hidden" id="id" conClass="3" />
			</div>
		</div>
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="textarea" id="objectDesc" label="I02102" labelClass="1" conClass="10" />
			</div>
		</div>
	</div>
</div>