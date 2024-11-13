<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="com.icignal.common.util.CommonUtil"%>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script id="commCodeTemplate1" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="commCodeTemplate2" type="text/x-jquery-tmpl">
<option value="${'${'}objId}">${'${'}objNm}</option>
</script>

<script type="text/javascript">

var validationModal;
var id = '<%= cleanXss(request.getParameter("id")) %>';
var codeId;
var checkBoxindex;

/* 팝업창을 담을 변수  */
var objPopup;

function getObjectDataTypeCommonCode(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'OBJ_TYPE_CD'
	},function(result){
		var temp = $("#commCodeTemplate1").tmpl(result.rows);
		$("#objectDataType").append(temp);
	});
};



function getObjectCode(codeId){
	$.ifvSyncPostJSON('<ifvm:action name="getObjectCode"/>', {
		objTypeCd : codeId
	},function(result){
		
		var temp = $("#commCodeTemplate2").tmpl(result.rows);
		$("#objectCode").append(temp);
	});
};
  
function getUIObjectDetail(){
	$('#id').val(id);
	$.ifvSyncPostJSON('<ifvm:action name="getUIObjectDetail"/>',{
		id : id
	},
	function(result) {
		$('#objectDataType').val(result.objTypeCd);
		$('#objectCode').val(result.objId);
		$('#uiObjectName').val(result.uiObjNm);
		$('#uiObjectDesc').val(result.uiObjDesc);
		if(result.useFlag == '1'){
			$('#useFlag1').attr('checked','checked');
		}else{
			$('#useFlag2').attr('checked','checked');
		}
	});
}  
  
function addUIObject(){
	
	$('#addUIObject').click(function(){
		if(validationModal.confirm() == true){
			if(pgmId == null){
				alert('<spring:message code="I02108"/>');
			}else{
				var jsonData = {
						objTypeCd : $('#objectDataType').val()
						, objId : $('#objectCode').val()
						, uiObjNm : $('#uiObjectName').val()
						, uiObjDesc : $('#uiObjectDesc').val()
						, useFlag : $('input[name=useFlag]:checked').val()
						, pgmId : pgmId
						, authId : authId
					}
					if( id == null || id == "null" || id == "undefined" || id <= 0){
						//신규
						url = '<ifvm:action name="insertUIObjectDetail"/>';
						if(confirm('<spring:message code="I01881"/>') === false) return;
					}else{
						//수정
						url = '<ifvm:action name="updateUIObjectDetail"/>';
						jsonData.id = id;
						if(confirm('<spring:message code="I01882"/>') === false) return;
					}
					
					$.ifvSyncPostJSON(url, jsonData, function(result) {
							if(result.success == true){
								alert('<spring:message code="I00741"/>');
								id = result.message;
								objectListSetting(authId, pgmId);
								objClosePop()
							}else{
								alert('<spring:message code="M01897"/>');
							}
						
					 },null,null,"#addUIObject");
			}
		}
	});
}

function cancelUIObject(){
	$('#cancelUIObject').click(function(){
		objectListSetting();
		objClosePop();
	});
}

function appClose() {
	javascript:$.modalClose();
}

function getCodeIdById(){
	$.ifvSyncPostJSON( '<ifvm:action name="getUIObjectDetail"/>',
			{id : id},
			function(result) {
				codeId = result.objTypeCd;
			}
		);
}
function getAuthList(){

	$.ifvSyncPostJSON('<ifvm:action name="getAuthListNotGrid"/>', {
		accountId : ifvmUserInfo.accountId
	},function(result){
		for (var i = 0; i < result.length; i++) {
			   var inp = $("<span id='check"+i+"'><input type='checkbox' id='check"+i+"' name='check' value='"+result[1].id+"'>"+result[i].authName+"</span>");
		    $("#check").append(inp);
		    $("#check").append("<br>");
			checkBoxindex=i;
		}
	},function(result){
	});
}

//권한 관리 오브젝트 목록 팝업 -> 오브젝트 코드 팝업
function objSearchBtn(){
	 objPopup = $("#objPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="objListPop"/>',
        contentType: "ajax",
        title: '오브젝트 목록',
        width: '1000px',
        close : 'closePop'
    }); 
}

function closePop(){
	objPopup.ejDialog('destroy');

}


$(document).ready(function(){
	getObjectDataTypeCommonCode();

	codeId = $('#objectDataType').val();
	if(id != null && id != "null" && id != "undefined" && id.length > 0){
		getCodeIdById();	
	}

	if(id != null && id != "null" && id != "undefined" && id.length > 0){
		getUIObjectDetail();
	}
	
	$('#objectDataType').change(function(){
		$("select[id='objectCode']").html('<option value=""></option>');
	});
	
	validationModal = $("#validationArea").ifvValidation();
	addUIObject();
	cancelUIObject();
});

</script>


<div class="well underline form-horizontal" id="validationArea" >			
	<div class="row qt_border">
		<div class="form-horizontal">
		<ifvm:inputNew type="select" id="objectDataType" required="true" label="I02088" labelClass="2" conClass="3"/>
		<ifvm:inputNew type="text" id="objectCodeVal" required="true" label="I02100" labelClass="2" conClass="3" disabled="true"/>
       	<ifvm:inputNew type="hidden" id="objectCode" conClass="1" />
       	
       	<ifvm:inputNew type="button" btnType="search"  text="L00030"  id="searchBtn" btnFunc="objSearchBtn" objCode="objSearchBtn_OBJ"/>
		</div>
	</div>

	<div clsee="row qt_border">
		<div class="form-horizontal">
		<ifvm:inputNew type="text" id="uiObjectName" required="true" label="I02090" labelClass="2" conClass="3" />
		<ifvm:inputNew type="hidden" id="id" conClass="1" />
		</div>
	</div>	
	<div class="row qt_border">
		<div class="form-horizontal">
		<ifvm:inputNew type="textarea" id="uiObjectDesc" label="I02091" labelClass="2" conClass="9" />
		</div>
	</div>
	<div class="row qt_border">
		<div class="form-horizontal">
		<ifvm:inputNew type="radio" id="useFlag" names="useFlag" required="true" text="I00833|M01898" values="1|0" label="I02092" labelClass="2" conClass="2" />
		</div>
	</div>

	<div class="pop_btn_area">
		<button id="addUIObject" class="btn btn-sm btn_gray" objCode="addUIObject_OBJ">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00170" />
		</button> 
		<button class="btn btn-sm " id="btnClosePop" onClick="objClosePop()" objCode="objClosePop_OBJ"><spring:message code="M00441" /></button>
	</div>
</div>
<div id="objPop" class="popup_container"></div>
