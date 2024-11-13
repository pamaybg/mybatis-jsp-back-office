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
<script>

var clubTierInfoPopValidation;
var ridClubTier = '<%= cleanXss(request.getParameter("rid")) %>';

function clubTierDetailSetting(){
	if(ridClubTier!="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getClubTierTabDtl"/>' , {rid : ridClubTier}
		, function(result) {
			$("#clubTierInfoPopDiv").dataSetting(result);
		})
	}
}


function clubTierPopValidFn(){
	clubTierInfoPopValidation = $("#clubTierInfoPopDiv").ifvValidation();
	if(clubTierInfoPopValidation.confirm()){

		for(var i=0; i<clubTierGrid.getRowData().length;i++){
			var gridObj = clubTierGrid.getRowData()[i];
			if(ridClubTier != gridObj.rid   &&  $("#clubTierInfoPopDiv #tierCd").val() == gridObj.tierCd){
				alert("등급코드가 중복됩니다");
				return false;
			}
		}
			return true;
	}
	return false;
}

function clubTierInfoPopSaveFn(){
	var submitData = {};
	submitData = $("#clubTierInfoPopDiv").getSubmitData();
	submitData.ridClub = clubTypeRid;
	submitData.rid = ridClubTier;


	if(clubTierPopValidFn()){
		$.ifvSyncPostJSON( ridClubTier=="null" ? '<ifvm:action name="addClubTierTab"/>' : '<ifvm:action name="editClubTierTab"/>',submitData
		, function(result) {
			alert("<spring:message code='M00295'/>");
			clubTierGrid.requestData();
			basicTierSelectSetting();
			clubTierPopClose();

		});
	}
}

function clubTierInfoPopCancelFn(){
	clubTierPopClose();
}

$(document).ready(function() {
	clubTierDetailSetting();
});
</script>

	<div class="pop_inner_wrap form-horizontal" id="clubTierInfoPopDiv" >
		<div class="row">
			<ifvm:inputNew type="text" id="tierCd" dto="tierCd"  label="등급코드" nuc="true" labelClass="3" conClass="6"  required="true" maxLength="50" />
		</div>

		<div class="row">
			<ifvm:inputNew type="text" id="tierNm" dto="tierNm"  label="등급명" nuc="true" labelClass="3" conClass="6"  required="true"   maxLength="50" />
		</div>

		<div class="row">
			<ifvm:inputNew type="number" id="secStart" dto="secStart"  label="설정구간(이상)" nuc="true" labelClass="3" conClass="6"  maxLength="50" />
		</div>

		<div class="row">
			<ifvm:inputNew type="number" id="secEnd" dto="secEnd"  label="설정구강(미만)" nuc="true" labelClass="3" conClass="6"  maxLength="50" />
		</div>
	</div>
	<div class="pop_btn_area">
       	<ifvm:inputNew type="button" btnType="save"    text="L00074"  id="clubTierInfoPopSaveBtn" btnFunc="clubTierInfoPopSaveFn"/>
        <ifvm:inputNew type="button"    text="L00073"  id="clubTierInfoPopCancelBtn" btnFunc="clubTierInfoPopCancelFn"/>
	</div>


<div id="tierInfoPopup" class ="popup_container"></div>
