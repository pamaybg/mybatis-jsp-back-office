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

<script>

var tierRulePop_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var tierRulePop_isNew = true;  //신규 여부. 신규: true, 수정 : false 

var tierRulePop_validation;
var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID 


/* 팝업 닫기 */
function tierRulePopPopupClose(){
	tierRulePopPopupContainer._destroy();
 
}

function tierRulePopDataLoad(tierRulePop_rid) {
 tierRulePop_isNew = false; // 해당 함수는 수정모드일 경우에만 호출되므로, 신규 여부 플래그 값을 false로 세팅함.
 
 $.ifvSyncPostJSON('<ifvm:action name="getTierRuleDetail"/>', {	 
	 tierupMatrixRid : tierupMatrixRid
 }, function(result) {
    });
 
}


function tierRulePopSaveSubmit(){ 
 $.ifvSyncPostJSON(tierRulePop_isNew ? '<ifvm:action name="saveTierRuleDetail"/>' : '<ifvm:action name="editTierRuleDetail"/>', gettierRulePopObjForSubmit() 
 , function(result) {
   alert('<spring:message code="L00127"/>');
   tiersDtlPopClose();
   tierupMatrixListInit();
   
   
 });
}

/*
 submit을 위한 form 데이터 파라미터 세팅
 */ 
function gettierRulePopObjForSubmit(){
  
	var submitData =$("#tierRulePopForm").getSubmitData();

	return submitData;
 
}

//저장 버튼클릭 시 동작
function tierRulePopActionSave() {
  if(tierRulePop_validation.confirm())  tierRulePopSaveSubmit();
}


$(function(){
 //공통코드
 $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
  groupCode : 'MEMBER_TYPE'
  , enableNA : true
 },function(result) {
  var temp = $("#memTypeCdTemp").tmpl(result.rows);
  $("#memTypeCd").append(temp);
 });
 
$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
  groupCode : 'MEMBER_GRADE'
  , enableNA : true
 },function(result) {
  var temp = $("#tierCdTemp").tmpl(result.rows);
  $("#tierCd").append(temp);
 });
 
$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
  groupCode : 'MEMBER_VALUE'
  , enableNA : true
 },function(result) {
  var temp = $("#valueTierCdTemp").tmpl(result.rows);
  $("#valueTierCd").append(temp);
 });
 

 
 
 if($.fn.ifvmIsNotEmpty(tierupMatrixRid) && tierupMatrixRid != "null") {
  tierRulePopDataLoad(tierupMatrixRid);
 }else {  //신규일경우 로그인 세선의 프로그램을 세팅함.
  var userInfo = $.ifvmGetUserInfo();
  	$('#ridTierGroup').val(ridTierGroup);
 }
 
});
//1000단위 정규식
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 
  //소수점 제거할시에는 Math.round(x).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); 사용하면됩니다.
}

function numberFormatter(){
	var startValue=$("#startValue").val();
	
	$("#startValue").ifvNumberOnly();
	$("#startValue").val(numberWithCommas(startValue));

	
	var limitValue=$("#limitValue").val();
	
	$("#limitValue").ifvNumberOnly();
	$("#limitValue").val(numberWithCommas(limitValue));

	
	
}

$(document).ready(function(){
 
 
 $.ifvmLnbSetting('tierRulePop');
  
 
 numberFormatter();
   
 $("#tierRulePopBtnSave").click(function(){
  tierRulePopActionSave();
    });
 
 $("#tierRulePopBtnList").click(function(){
  qtjs.href('<ifvm:url name=""/>');
    });
 
 

 
 tierRulePop_validation = $("#tierRulePopForm").ifvValidation();
 
 $("input[vali-type=number]").keyup(function() {
        $(this).val($.fn.ifvmNumberWithCommas(this.value));
    });
 
});

</script>

<script id="memTypeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="tierCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="valueTierCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<div class="form-horizontal underline top_well" id="tierRulePopForm" >
  <div class="row  qt_border">
 <ifvm:inputNew type="select" id="memTypeCd" maxLength="50"  dto="memTypeCd"    label="L01686" labelClass="2" conClass="2" />
<ifvm:inputNew type="select" id="tierCd" maxLength="50"  dto="tierCd"    label="L01691" labelClass="2" conClass="2" />
<ifvm:inputNew type="select" id="valueTierCd" maxLength="50"  dto="valueTierCd"    label="L01687" labelClass="2" conClass="2" />

 
 </div>
 <div class="row  qt_border">
 <ifvm:inputNew type="text" id="startValue" maxLength="15"  dto="startValue"    label="L01688" labelClass="2" conClass="2" />
<ifvm:inputNew type="text" id="limitValue" maxLength="15"  dto="limitValue"    label="L01689" labelClass="2" conClass="2" />
 
 </div>
 
 
 <ifvm:inputNew type="hidden" id="ridTierupMatrix" maxLength="50"  dto="ridTierupMatrix"     labelClass="0" conClass="2" />
 <ifvm:inputNew type="hidden" id="ridTierGroup" maxLength="50"  dto="ridTierGroup"    labelClass="0" conClass="2" />
 
</div>

 <div class="pop_btn_area" style="height:60px;">
 
  <ifvm:inputNew type="button" btnType="save" text="I00745" id="tierRuleSaveBtn" btnFunc="tierRulePopActionSave" />
  <ifvm:inputNew type="button" btnType="close" text="I00404" id="tierRuleCloseBtn"  btnFunc="tiersDtlPopClose" />
  
 </div>
 
<div id="tierRulePopPopupContainer" class="popup_container"></div><!-- 팝업 -->


