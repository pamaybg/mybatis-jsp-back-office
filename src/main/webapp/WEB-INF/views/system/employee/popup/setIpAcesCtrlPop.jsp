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
<script type="text/javascript">
var ridUserAcl = '<%=cleanXss(request.getParameter("ridUserAcl"))%>';
var validation = null;


function init(){

	$.ifvGetCommCodeList('select', 'modal_aclType', '<ifvm:action name="getCommCodeList"/>', 'ACL_TYPE', 'com', false, false, false, false);
	$.ifvGetCommCodeList('select', 'modal_useYn', '<ifvm:action name="getCommCodeList"/>', 'YES_NO_FLAG', 'com', false, false, false, false);

	$('#modal_aclType1_ip1').ifvNumberRange();
	$('#modal_aclType1_ip2').ifvNumberRange();
	$('#modal_aclType1_ip3').ifvNumberRange();
	$('#modal_aclType1_ip4').ifvNumberRange();
	$('#modal_aclType2_ip1').ifvNumberRange();
	$('#modal_aclType2_ip2').ifvNumberRange();
	$('#modal_aclType2_ip3').ifvNumberRange();
	$('#modal_aclType2_ip4').ifvNumberRange();

	if(ridUserAcl != "undefined"){
		//상세
		$.ifvSyncPostJSON('<ifvm:action name="getIpAccessControlDetail"/>',{
			ridUserAcl : ridUserAcl
		},function(result) {
			$("#modal_aclType").val(result.aclType);
			$("#modal_useYn").val(result.useYn);

			if($("#modal_aclType").val() == '1'){
				//ACL 유형이 고정 IP일 때
				$("#modal_aclType1").show();
				$("#modal_aclType2").hide();

				$("#modal_aclType1_ip1").attr("required",true);
				$("#modal_aclType1_ip2").attr("required",true);
				$("#modal_aclType1_ip3").attr("required",true);
				$("#modal_aclType1_ip4").attr("required",true);

				$("#modal_aclType2_ip1").attr("required",false);

				$("#modal_aclType1_ip1").val(result.accessIpAddr.split(".")[0]);
				$("#modal_aclType1_ip2").val(result.accessIpAddr.split(".")[1]);
				$("#modal_aclType1_ip3").val(result.accessIpAddr.split(".")[2]);
				$("#modal_aclType1_ip4").val(result.accessIpAddr.split(".")[3]);
			}else if($("#modal_aclType").val() == '2'){
				//ACL 유형이 IP 대역일 때
				$("#modal_aclType1").hide();
				$("#modal_aclType2").show();

				$("#modal_aclType1_ip1").attr("required",false);
				$("#modal_aclType1_ip2").attr("required",false);
				$("#modal_aclType1_ip3").attr("required",false);
				$("#modal_aclType1_ip4").attr("required",false);

				$("#modal_aclType2_ip1").attr("required",true);

				$("#modal_aclType2_ip2").attr("placeholder","*");
				$("#modal_aclType2_ip3").attr("placeholder","*");
				$("#modal_aclType2_ip4").attr("placeholder","*");

				$("#modal_aclType2_ip1").val(result.accessIpAddr.split(".")[0]);
				if(result.accessIpAddr.split(".")[1] != "*"){
					$("#modal_aclType2_ip2").val(result.accessIpAddr.split(".")[1]);
				}
				if(result.accessIpAddr.split(".")[2] != "*"){
					$("#modal_aclType2_ip2").val(result.accessIpAddr.split(".")[2]);
				}
				if(result.accessIpAddr.split(".")[3] != "*"){
					$("#modal_aclType2_ip2").val(result.accessIpAddr.split(".")[3]);
				}
			}
		});
	}else{
		//신규
		$("#modal_aclType1").show();
		$("#modal_aclType2").hide();

		$("#modal_aclType2_ip1").attr("required",false);
	}
}

//로그인 사용자 팝업 IP접근제어 팝업 닫기
function setIpAcesCtrlPopClose() {
	$('#setIpAcesCtrl').ejDialog('destroy');
}

//로그인 사용자 팝업 IP접근제어 팝업 선택
function clickAddBtn(data){
	var accessIpAddr = null;
	validation = $("#formArea").ifvValidation();

	//유효성 체크
	if(validation.confirm()){

		if($("#modal_aclType").val() == '1'){
			//ACL 유형이 고정 IP일 때
			accessIpAddr = $("#modal_aclType1_ip1").val()+"."+$("#modal_aclType1_ip2").val()+"."+$("#modal_aclType1_ip3").val()+"."+$("#modal_aclType1_ip4").val();
		}else if($("#modal_aclType").val() == '2'){
			//ACL 유형이 IP 대역일 때
			var ip2 = null;
			var ip3 = null;
			var ip4 = null;

			if($("#modal_aclType2_ip2").val() == ""){
				ip2 = "*";
			}else{
				ip2 = $("#modal_aclType2_ip2").val();
			}
			if($("#modal_aclType2_ip3").val() == ""){
				ip3 = "*";
			}else{
				ip3 = $("#modal_aclType2_ip3").val();
			}
			if($("#modal_aclType2_ip4").val() == ""){
				ip4 = "*";
			}else{
				ip4 = $("#modal_aclType2_ip4").val();
			}

			accessIpAddr = $("#modal_aclType2_ip1").val()+"."+ip2+"."+ip3+"."+ip4;
		}

		if(ridUserAcl != "undefined"){
			//상세 수정
			$.ifvSyncPostJSON('<ifvm:action name="modifyIpAccessControl"/>',{
				ridCrmuser : temp.rid
				, ridUserAcl : ridUserAcl
				, aclType : $("#modal_aclType").val()
				, accessIpAddr : accessIpAddr
				, useYn : $("#modal_useYn").val()
			},function(result) {
				alert('<spring:message code="I00741"/>');
				setIpAcesCtrlPopClose()
				ipAccessControlList(temp.rid);
			});
		}else{
			//신규 추가
			$.ifvSyncPostJSON('<ifvm:action name="setIpAccessControl"/>',{
				ridCrmuser : temp.rid
				, ridUserAcl : ridUserAcl
				, aclType : $("#modal_aclType").val()
				, accessIpAddr : accessIpAddr
				, useYn : $("#modal_useYn").val()
			},function(result) {
				alert('<spring:message code="I00741"/>');
				setIpAcesCtrlPopClose()
				ipAccessControlList(temp.rid);
			});
		}

	}else{
		alert('<spring:message code="M01055"/>');
	}

}

$(document).ready(function(){
	init();

	$("#modal_aclType").change(function(){
		if($("#modal_aclType").val() == '1'){
			//ACL 유형이 고정 IP일 때
			$("#modal_aclType1").show();
			$("#modal_aclType2").hide();

			$("#modal_aclType1_ip1").attr("required",true);
			$("#modal_aclType1_ip2").attr("required",true);
			$("#modal_aclType1_ip3").attr("required",true);
			$("#modal_aclType1_ip4").attr("required",true);

			$("#modal_aclType2_ip1").attr("required",false);
		}else if($("#modal_aclType").val() == '2'){
			//ACL 유형이 IP 대역일 때
			$("#modal_aclType1").hide();
			$("#modal_aclType2").show();

			$("#modal_aclType1_ip1").attr("required",false);
			$("#modal_aclType1_ip2").attr("required",false);
			$("#modal_aclType1_ip3").attr("required",false);
			$("#modal_aclType1_ip4").attr("required",false);

			$("#modal_aclType2_ip1").attr("required",true);

			$("#modal_aclType2_ip2").attr("placeholder","*");
			$("#modal_aclType2_ip3").attr("placeholder","*");
			$("#modal_aclType2_ip4").attr("placeholder","*");
		}
	});
});

</script>

<div class="well form-horizontal">
	<div id='formArea'>
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="modal_aclType" names="modal_aclType" label="V00161" labelClass="2" conClass="4" required="true"/>
		</div>
		<div class="row qt_border" id="modal_aclType1">
			<ifvm:inputNew type="number" id="modal_aclType1_ip1" label="V00160" labelClass="2" conClass="2" minLength="1" maxLength="3" minNum="0" maxNum="255" required="true"/>
			<ifvm:inputNew type="number" id="modal_aclType1_ip2" conClass="2" minLength="1" maxLength="3" minNum="0" maxNum="255" required="true"/>
			<ifvm:inputNew type="number" id="modal_aclType1_ip3" conClass="2" minLength="1" maxLength="3" minNum="0" maxNum="255" required="true"/>
			<ifvm:inputNew type="number" id="modal_aclType1_ip4" conClass="2" minLength="1" maxLength="3" minNum="0" maxNum="255" required="true"/>
		</div>
		<div class="row qt_border" id="modal_aclType2">
			<ifvm:inputNew type="number" id="modal_aclType2_ip1" label="V00160" labelClass="2" conClass="2" minLength="1" maxLength="3" minNum="0" maxNum="255" required="true"/>
			<ifvm:inputNew type="number" id="modal_aclType2_ip2" conClass="2" minLength="1" maxLength="3" minNum="0" maxNum="255" />
			<ifvm:inputNew type="number" id="modal_aclType2_ip3" conClass="2" minLength="1" maxLength="3" minNum="0" maxNum="255" />
			<ifvm:inputNew type="number" id="modal_aclType2_ip4" conClass="2" minLength="1" maxLength="3" minNum="0" maxNum="255" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="modal_useYn" names="modal_useYn" label="V00162" labelClass="2" conClass="4" required="true"/>
		</div>
	</div>
</div>
<center>
	<div class="row qt_border">
		<ifvm:inputNew type="button" id="addBtn" text="L01462" btnFunc="clickAddBtn" objCode="setIpAccessCtrlPopSave_OBJ"/>
		<ifvm:inputNew type="button" id="" text="L00913" btnFunc="setIpAcesCtrlPopClose" objCode="setIpAccessCtrlPopClose_OBJ"/>
	</div>
</center>
