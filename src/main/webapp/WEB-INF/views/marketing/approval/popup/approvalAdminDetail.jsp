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

var approvalAdminDetail_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var approvalAdminDetail_isNew = true;  //신규 여부. 신규: true, 수정 : false 

var approvalAdminDetail_validation;
var popSelectlId; //팝업에서 선택한 값이 세팅되는 input ID 

var elecReqTmplTemp;
var elecAprvTmplTemp;
var elecRjtTmplTemp;
var popupType ; 

/* 팝업 닫기 */
function approvalAdminDetailPopupClose(){
 $('#approvalAdminDetailPopupContainer').data('ejDialog')._destroy()
 
}

 
//초기 설정 함수
/* function detailInit() {
 if($.fn.ifvmIsNotEmpty(chnl_rid) && chnl_rid != "null") approvalAdminDetailDataLoad(chnl_rid);
} */

function approvalAdminDetailDataLoad(approvalAdminDetail_rid) {
 approvalAdminDetail_isNew = false; // 해당 함수는 수정모드일 경우에만 호출되므로, 신규 여부 플래그 값을 false로 세팅함.
 
 $.ifvSyncPostJSON('<ifvm:action name="getApprovalAdminDetail"/>', {
  id: approvalAdminDetail_rid
 }, function(result) {
  if($.fn.ifvmIsNotEmpty(result)) {
   /*  */
   //#x조회세팅x#
  $('#approvalAdminDetailForm').dataSetting( result );
  elecReqTmplTemp  = result.elecReqTmpl;
  elecAprvTmplTemp = result.elecAprvTmpl;
  elecRjtTmplTemp  = result.elecRjtTmpl ;
   
   
   
   }
   
    });
 
}


function approvalAdminDetailSaveSubmit(){ 
 $.ifvSyncPostJSON(approvalAdminDetail_isNew ? '<ifvm:action name="saveApprovalAdminDetail"/>' : '<ifvm:action name="editApprovalAdminDetail"/>', getapprovalAdminDetailObjForSubmit() 
 , function(result) {
   alert('<spring:message code="L00127"/>');
   approvalAdminDetailPopClose();
   getapprovalAdminListSearch();
   
   
   
 });
}

/*
 submit을 위한 form 데이터 파라미터 세팅
 */
 
 
function getapprovalAdminDetailObjForSubmit(){
 
 
 
 //체크박스 처리 샘플
 //var v_mbrJoinPsblYn = $.fn.ifvmIsNotEmpty($("#mbrJoinPsblYn").attr("checked")) ?  "Y" : "N";
 

  var submitData =$("#approvalAdminDetailForm").getSubmitData();
  

 return submitData;
 
}

//저장 버튼클릭 시 동작
function approvalAdminDetailActionSave() {
  if(approvalAdminDetail_validation.confirm())  approvalAdminDetailSaveSubmit();
}


$(function(){
 
 //상태
 
 //공통코드
 $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
  groupCode : 'APRV_TYPE_CD'
  , enableNA : true
 },function(result) {
  var temp = $("#elecAprvTypeTemp").tmpl(result.rows);
  $("#elecAprvType").append(temp);
 });
 

	 if(typeof approvalAdminDetail_rid != "undefined" && approvalAdminDetail_rid != "undefined" 
		 && $.fn.ifvmIsNotEmpty(approvalAdminDetail_rid) && approvalAdminDetail_rid != "null") {
		 approvalAdminDetailDataLoad(approvalAdminDetail_rid);
	}else {  //신규일경우 로그인 세선의 프로그램을 세팅함.
	var userInfo = $.ifvmGetUserInfo();
	}

 
});



/* 
ridElecReqTmpl
ridElecAprvTmpl
ridElecRjtTmpl */
function tempSearchHelpBlur(type){

}
function tempSearchHelpBtn(type){
	popupType = type;
	
	tempSearchHelp();
	
}
function tempSearchHelpEnter(type){

	
}


function tempSearchHelp(){		
		tempSearchHelpPop ={
			        id : "tempSearchHelpContainer"
			    };
		tempSearchHelpPop.popup = function (){
			tempSearchHelpPop.pop = $('#'+tempSearchHelpPop.id).ifvsfPopup({
			            enableModal: true,
			            enableResize: false,
			            contentUrl: '<ifvm:url name="contentListPopAppr"/>',
			            contentType: "ajax",
			            title: '템플릿 검색',
			            width: 1000,
			            close: tempSearchHelpPop.close
			        });
			};
			tempSearchHelpPop.beforeClose = function (obj) {
			}; 
			tempSearchHelpPop.close = function (obj) {
				 if(obj!=null&&obj.type!="close"){
					 if(popupType =="1"){						 
			        	$("#elecReqTmpl").val(obj.contentsName);
			        	elecReqTmplTemp = obj.contentsName;
			        	$("#ridElecReqTmpl").val(obj.id);			        			
					 }else if(popupType =="2"){
						$("#elecAprvTmpl").val(obj.contentsName);
						elecAprvTmplTemp = obj.contentsName;
				        $("#ridElecAprvTmpl").val(obj.id);
					 }else if(popupType =="3"){
						$("#elecRjtTmpl").val(obj.contentsName);
						elecRjtTmplTemp = obj.contentsName;
				        $("#ridElecRjtTmpl").val(obj.id);
					 }
				 }else{
					 if(popupType =="1"){
						 $('#elecReqTmpl').val(elecReqTmplTemp);		        			
					 }else if(popupType =="2"){
						 $('#elecAprvTmpl').val(elecAprvTmplTemp);
					 }else if(popupType =="3"){
						 $('#elecRjtTmpl').val(elecRjtTmplTemp);
					 }
					
				 }
				 tempSearchHelpPop.beforeClose(obj);
				 tempSearchHelpContainer._destroy();
			 };
			 tempSearchHelpPop.popup();	
}






$(document).ready(function(){
 
 $.ifvmLnbSetting('approvalAdminListNew');
  
 
 
   

 
 

 
 approvalAdminDetail_validation = $("#approvalAdminDetailForm").ifvValidation();
 
 $("input[vali-type=number]").keyup(function() {
        $(this).val($.fn.ifvmNumberWithCommas(this.value));
    });
 
});

</script>



<script id="elecAprvTypeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>








<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>


<div class="page_btn_area" id="headForm">
 <div class="col-xs-7">
  <span>유형 관리</span>
 </div>
 
 
</div>


<div class="form-horizontal underline top_well" id="approvalAdminDetailForm" >
  <div class="row  qt_border">
 <ifvm:inputNew type="select" id="elecAprvType" maxLength="50"  dto="elecAprvType"    label="L01593" labelClass="2" conClass="2" />
 <ifvm:inputNew type="text" id="elecAprvTblNm" maxLength="50"  dto="elecAprvTblNm"    label="L01594" labelClass="2" conClass="2" />


 </div>
 <div class="row  qt_border">
 <ifvm:inputNew type="search" id="elecReqTmpl|tempSearch1" names="elecReqTmpl" hidId="ridElecReqTmpl" hidDto="ridElecReqTmpl" dto="elecReqTmpl" 
			   btnFunc="tempSearchHelpBtn('1')" searchBlurEvent="tempSearchHelpBlur('1')" searchEnterEvent="tempSearchHelpEnter('1')" label="L01595"  labelClass="2" conClass="2" />

 <ifvm:inputNew type="search" id="elecAprvTmpl|tempSearch2" names="elecAprvTmpl" hidId="ridElecAprvTmpl" hidDto="ridElecAprvTmpl" dto="elecAprvTmpl" 
			   btnFunc="tempSearchHelpBtn('2')" searchBlurEvent="tempSearchHelpBlur('2')" searchEnterEvent="tempSearchHelpEnter('2')" label="L01597"  labelClass="2" conClass="2" />

 
 <ifvm:inputNew type="search" id="elecRjtTmpl|tempSearch3" names="elecRjtTmpl" hidId="ridElecRjtTmpl" hidDto="ridElecRjtTmpl" dto="elecRjtTmpl" 
			   btnFunc="tempSearchHelpBtn('3')" searchBlurEvent="tempSearchHelpBlur('3')" searchEnterEvent="tempSearchHelpEnter('3')" label="L01599"  labelClass="2" conClass="2" />

 
 
 

 
 </div>
 <div class="row  qt_border">
 <ifvm:inputNew type="text" id="elecReqFuncNm" maxLength="50"  dto="elecReqFuncNm"    label="L01596" labelClass="2" conClass="2" />
<ifvm:inputNew type="text" id="elecAprvFuncNm" maxLength="50"  dto="elecAprvFuncNm"    label="L01598" labelClass="2" conClass="2" />
<ifvm:inputNew type="text" id="elecRjtFuncNm" maxLength="50"  dto="elecRjtFuncNm"    label="L01600" labelClass="2" conClass="2" />

 
 </div>
 <div class="row  qt_border">
 <ifvm:inputNew type="text" id="elecReqAutomailId" maxLength="32"  dto="elecReqAutomailId"    label="숭인요청(썬더메일id)" nuc="true" labelClass="2" conClass="2" />
<ifvm:inputNew type="text" id="elecAprvAutomailId" maxLength="32"  dto="elecAprvAutomailId"    label="숭인처리(썬더메일id)" nuc="true" labelClass="2" conClass="2" />
<ifvm:inputNew type="text" id="elecRjtAutomailId" maxLength="32"  dto="elecRjtAutomailId"    label="숭인거절(썬더메일id)" nuc="true" labelClass="2" conClass="2" />

 
 </div>

 <ifvm:inputNew type="hidden" id="id" maxLength="50"  dto="id"   labelClass="0" conClass="2" />
</div>

<div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="save" text="L00125" id="approvalAdminSaveBtn"  btnFunc="approvalAdminDetailActionSave" />
	<ifvm:inputNew type="button" btnType="close" text="M00441" id="approvalAdmiCanceleBtn" btnFunc="approvalAdminDetailPopClose" />

	 
</div>
<div id="approvalAdminDetailTabArea"></div>

<div id="tempSearchHelpContainer" class="popup_container"></div><!-- 팝업 -->


