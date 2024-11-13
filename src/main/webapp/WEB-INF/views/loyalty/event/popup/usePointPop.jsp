<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="pop_main_div">
	<div class="row qt_border" id="usePointForm">
		<table class="usePointTable">
			<tr>
				<th></th>
				<th width="150px" style="text-algin:center;">구분</th>
				<th width="150px" style="text-algin:center;">금액</th>
			</tr>
			<tr> 
				<td><%-- <ifvm:inputNew type="button" id="addAcrl"  text="추가" nuc="true" />< --%></td>
				<td><ifvm:inputNew type="select" id="acrlType1" names="acrlType" className="acrlType1" conClass="12" disabled="true"/></td>
				<td><ifvm:inputNew type="text" id="acrlAmt1"  className="acrlAmt" conClass="12"/></td>
			</tr>
			<tr id="acrl2">
				<td></td>
				<td><ifvm:inputNew type="select" id="acrlType2" names="acrlType" className="acrlType" conClass="12" disabled="true"/></td>
				<td><ifvm:inputNew type="text" id="acrlAmt2"  className="acrlAmt" conClass="12"/></td>
			</tr>
			<tr id="acrl3">
				<td></td>
				<td><ifvm:inputNew type="select" id="acrlType3" names="acrlType" className="acrlType" conClass="12" disabled="true"/></td>
				<td><ifvm:inputNew type="text" id="acrlAmt3"  className="acrlAmt" conClass="12"/></td>
			</tr>
		</table>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectBtn">
	        <i class="glyphicon glyphicon-check"></i><spring:message code="L02251"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="cancelBtn"><spring:message code="L00124"/>   
	    </button> 
	</div> 
</div>
<style>
	.usePointTable{margin-left:35px;}
	.usePointTable th{text-align:center;}
</style>
<script>


//초기셋팅
function settingAcrlAmt(){
	var totArry = $('#usePointPrice').val().split(',');
	
	if($.fn.ifvmIsNotEmpty(totArry[0])){
		$('#acrlAmt1').val(totArry[0]);
		
		//두번째 적립금액 셋팅
		if($.fn.ifvmIsNotEmpty(totArry[1])){
			$('#acrlAmt2').val(totArry[1]);
		}else{
			$("#acrl2").css('display','none');
			$("#acrl3").css('display','none');
			return
		}
		
		//세번째 적립금액 셋팅
		if($.fn.ifvmIsNotEmpty(totArry[2])){
			$('#acrlAmt3').val(totArry[2]);
		}else{
			$("#acrl3").css('display','none');
			return
		}
	}else{
		$('#acrlAmt1').val(totArry[0]);
		$("#acrl2").css('display','none')
		$("#acrl3").css('display','none')
	}
}

//숨김처리
function addAcrlAmt(){
	if($("#acrl2").css('display') == "none"){
		$("#acrl2").css('display','');
	}else if ($("#acrl3").css('display') == "none"){
		$("#acrl3").css('display','');
	}
}

// 콤마 추가
function insertAcrlAmt(){
	var acrlAmt1 = $('#acrlAmt1').val();
	var acrlAmt2 = $('#acrlAmt2').val();
	var acrlAmt3 = $('#acrlAmt3').val();
	var totAmt = '';
	
	if($.fn.ifvmIsEmpty(acrlAmt1)){
		alert('첫번째 적립금액은 필수값 입니다.')
	}else{
		if($.fn.ifvmIsNotEmpty(acrlAmt1) || totAmt != ''){
			totAmt = acrlAmt1;
		}
		if($.fn.ifvmIsNotEmpty(acrlAmt2)){
			totAmt = totAmt + ',' + acrlAmt2;
		}
		if($.fn.ifvmIsNotEmpty(acrlAmt3)){
			totAmt = totAmt + ',' + acrlAmt3;
		}
		
		$('#usePointPrice').val(totAmt);
		
		usePointPopUpClose();
	}
}

$(document).ready(function(){
	$.fn.ifvmSetSelectOptionCommCode("acrlType", "LOY_ACRL_TYPE", null, null, true);
	
	//초기셋팅
	settingAcrlAmt();
	
	//추가 이벤트
	$('#addAcrl').click(function(){
		addAcrlAmt();
	});
	
	//등록
	$('#selectBtn').click(function(){
		insertAcrlAmt();
	});
	
	//취소버튼
	$('#cancelBtn').click(function(){
		usePointPopUpClose();
	});
});

</script>