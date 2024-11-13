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

var clubOfferInfoPopValidation;
var ridClubBenf = '<%= cleanXss(request.getParameter("rid")) %>';


function clubOfferDetailSetting(){
	if(ridClubBenf!="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getClubBenfTabDtl"/>' , {rid : ridClubBenf}
		, function(result) {
			$("#clubOfferInfoPopDiv").dataSetting(result);
		})
	}
}

function offerSearchFn(){
	$("#offerSearchHelpPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="offerSearchHelp"/>',
        contentType: "ajax",
        title: "오퍼 목록",
        width: '700px',
        close : 'offerSearchHelpPopClose'
   });
}
function offerSearchHelpPopSave(obj){
	$("#clubOfferInfoPopDiv #offerNm").val(obj.offerName);
	$("#clubOfferInfoPopDiv #ridMktOfferMst").val(obj.id);
	offerSearchHelpPopClose();
}

function offerSearchHelpPopClose(){
	offerSearchHelpPop._destroy();
}



function tierSearchFn(){
	$("#tierInfoPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="clubTierListPop"/>',
        contentType: "ajax",
        title: '등급 정보',
        width: '700px',
    /*     close : function(obj) {
        	var clubTierCd="";
        	if(typeof obj.event !="undefined"){
	        	obj.event.forEach(function(seriesObj, idx) {
	        		clubTierCd = clubTierCd+seriesObj.tierCd+" /"
	        	})
	        	$("#tierCd").val(clubTierCd.substring(0,clubTierCd.length-1));
			}
        	tierInfoPopup._destroy();
        } */
        close :'tierInfoPopupClose'
	});
}


function tierInfoPopupSave(){
	var list =  loyTierListPopGrid.getCheckedList();
	var clubTierCd="";
	list.forEach(function (selectObj, idx){
		clubTierCd = clubTierCd+selectObj.tierCd+" /"
	});
	$("#tierCd").val(clubTierCd.substring(0,clubTierCd.length-1));
	tierInfoPopupClose();
}

function tierInfoPopupClose(){
	tierInfoPopup._destroy();
}


function clubOfferPopValidFn(){
	clubOfferInfoPopValidation = $("#clubOfferInfoPopDiv").ifvValidation();
	if(clubOfferInfoPopValidation.confirm()){
		for(var i=0; i<clubBenfGrid.getRowData().length;i++){
			var gridObj = clubBenfGrid.getRowData()[i];
			if(ridClubBenf != gridObj.rid   &&  $("#clubOfferInfoPopDiv #ridMktOfferMst").val() == gridObj.ridMktOfferMst){
				alert("오퍼가 중복됩니다");
				return false;
			}
		}
			return true;
	}
	return false;
}

function clubOfferInfoPopSaveFn(){
	var submitData = {};
	submitData = $("#clubOfferInfoPopDiv").getSubmitData();
	submitData.ridClub = clubTypeRid;
	submitData.rid = ridClubBenf;
	if(clubOfferPopValidFn()){
		$.ifvSyncPostJSON( ridClubBenf=="null" ? '<ifvm:action name="addClubBenfTab"/>' : '<ifvm:action name="editClubBenfTab"/>',submitData
		, function(result) {
			alert("<spring:message code='M00295'/>");
			clubBenfGrid.requestData();
			clubOfferPopClose();
		});
	}
}

function clubOfferInfoPopCancelFn(){
	clubOfferPopClose();
}


$(document).ready(function() {
	clubOfferDetailSetting();
});
</script>

	<div class="pop_inner_wrap form-horizontal" id="clubOfferInfoPopDiv" >
		<div class="row">
					<ifvm:inputNew type="search" id="offerNm|offerSearchBtn" required="true"
						names="offerNm" hidId="ridMktOfferMst" hidDto="ridMktOfferMst" dto="offerNm"
						disabled="false" btnFunc="offerSearchFn" label="오퍼명"  nuc ="true"
						labelClass="3" conClass="6" />

		</div>

		<div class="row">
					<ifvm:inputNew type="search" id="tierCd|tierSearchBtn" required="true"
						names="tierCd" hidId="tierRid" hidDto="tierRid" dto="tierCd"
						disabled="false" btnFunc="tierSearchFn" label="L00235"
						labelClass="3" conClass="6" />
		</div>


	</div>
	<div class="pop_btn_area">
       	<ifvm:inputNew type="button" btnType="save"    text="L00074"  id="clubOfferInfoPopSaveBtn" btnFunc="clubOfferInfoPopSaveFn"/>
        <ifvm:inputNew type="button"    text="L00073"  id="clubOfferInfoPopCancelBtn" btnFunc="clubOfferInfoPopCancelFn"/>
	</div>


<div id="tierInfoPopup" class ="popup_container"></div>
<div id=offerSearchHelpPop class ="popup_container"></div>