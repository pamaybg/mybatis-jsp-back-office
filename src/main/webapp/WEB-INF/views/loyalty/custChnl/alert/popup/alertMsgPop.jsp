<%@ page trimDirectiveWhitespaces="true" %>
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
<div class="form-horizontal underline top_well" id ="alertMsgMakePop" >
	<div class="row qt_border">
		<ifvm:inputNew type="radio" id="status" names="status" dto="status" required="true" label="L00090" labelClass="2" conClass="9" text="L00430|M02873" values="A|I" checkIndex="2"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="msgType" label="V00115" labelClass="2" conClass="9" disabled="true" required="true" values="전체공지"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="msg" label="V00097" labelClass="2" conClass="9" rows="5"/>
	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="save" text="M00137" id="alertMsgSave" objCode="alertMsgSave_OBJ"/>
	<ifvm:inputNew type="button" btnType="cancel" text="I00404" id="cancelBtn" objCode="alertMsgcancelBtn_OBJ"/>
</div>
<script>
var msgRid = '<%= cleanXss(request.getParameter("rid")) %>';
$(document).ready(function(){
	$('#alertMsgMakePop').ifvValidation();
	
	$("#alertMsgSave").on('click',function(){
		saveAlertMsg();
	});
	$("#cancelBtn").on('click',function(){
		alertMsgPopupClose();
	});
	if(rid != null || rid != "undefined"){
		getAlertMsgDetail();
	}
});

//저장 , 수정
function saveAlertMsg(){
	validation = $("#alertMsgMakePop").ifvValidation();
	if(validation.confirm() === false)return;
	else{
		if(msgRid == null || msgRid === "undefined"){
			url = '<ifvm:action name="insertAlertMsg"/>'
		}else{
			url = '<ifvm:action name="updateAlertMsg"/>'
		}
		$.ifvSyncPostJSON(url,{ 
			rid : rid,
			status : $(':radio[name="status"]:checked').val(),
			msgType : $("#msgType").val(),
			msg : $('#msg').val(),
		},function(result){
			alertMsgPopupClose();
			alert('<spring:message code="L00076" />');
			getAlertMsgList();
		});
	}
}

//상세
function getAlertMsgDetail(){
	
	$.ifvSyncPostJSON('<ifvm:action name="getAlertMsgPopupDetail"/>',{
		rid : rid
	},function(result){ //Success : true
		if(result.status == "A"){
			$("input:radio[name='status']:radio[value='A']").attr("checked",true);
		}
		else{
			$("input:radio[name='status']:radio[value='I']").attr("checked",true);
		}
		$("#msg").val(result.msg);
		$("#msgType").val(result.msgType);

	},function(result){ //Success : false
		if(result.status == "A"){
			$("input:radio[name='status']:radio[value='A']").attr("checked",true);
		}
		else{
			$("input:radio[name='status']:radio[value='I']").attr("checked",true);
		}
		$("#msg").val(result.msg);
		$("#msgType").val(result.msgType);
	});

}


</script>