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
var clubPartenariatInfoPopValidation;
var ridClubChnl = '<%= cleanXss(request.getParameter("rid")) %>';

function clubPartenariatDetailSetting(){
	if(ridClubChnl!="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getClubPartenariatTabDtl"/>' , {rid : ridClubChnl}
		, function(result) {
			$("#clubPartenariatInfoPopDiv").dataSetting(result);
		})
	}
}

function clubPartenariatPopValidFn(){
	clubPartenariatInfoPopValidation = $("#clubPartenariatInfoPopDiv").ifvValidation();
	if(clubPartenariatInfoPopValidation.confirm()){
		for(var i=0; i<clubPartenariatGrid.opt.gridControl.model.currentViewData.length;i++){
			var gridObj = clubPartenariatGrid.opt.gridControl.model.currentViewData[i];
			if(ridClubChnl != gridObj.rid &&  gridObj.chnlNo ==$("#clubPartenariatInfoPopDiv #chnlNo").val() ){
				alert("제휴사가 중복됩니다");
				return false;
			}
		}
			return true;
	}
	return false;
}


function clubPartenariatInfoPopSaveFn(){
	var submitData = {};
	submitData = $("#clubPartenariatInfoPopDiv").getSubmitData();
	submitData.ridClub = clubTypeRid;
	submitData.rid = ridClubChnl;
	if(clubPartenariatPopValidFn()){
		$.ifvSyncPostJSON( ridClubChnl=="null" ? '<ifvm:action name="addClubPartenariatTab"/>' : '<ifvm:action name="editClubPartenariatTab"/>',submitData
		, function(result) {
			alert("<spring:message code='M00295'/>");
			getClubPartList();
			clubPartenariatPopClose();
		});
	}
}
function clubChnlPopupPop(){
	$("#clubChnlSearchHelpPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="clubChnlPop"/>',
        contentType: "ajax",
        title: "제휴사 찾기",
        width: '700px',
        close : 'clubChnlPopupClose'
 	});
}

function clubChnlPopupClose(chnlObj){
	$("#clubPartenariatInfoPopDiv #chnlNm").val(chnlObj.chnlNm);
	$("#clubPartenariatInfoPopDiv #chnlNo").val(chnlObj.chnlNo);
	$("#clubPartenariatInfoPopDiv #ridChnl").val(chnlObj.rid);
	clubChnlSearchHelpPopClose();

}

function clubChnlSearchHelpPopClose(){
	clubChnlSearchHelpPop._destroy();
}





function clubPartenariatInfoPopCancelFn(){
	clubPartenariatPopClose();
}

$(document).ready(function() {
	clubPartenariatDetailSetting();
});
</script>

	<div class="pop_inner_wrap form-horizontal" id="clubPartenariatInfoPopDiv" >
		<div class="row">
			<ifvm:inputNew type="text" id="chnlNo" dto="chnlNo"  label="제휴사코드" nuc="true" labelClass="3" conClass="6"  maxLength="50" disabled="true" />
		</div>

		<div class="row">
			<ifvm:inputNew type="search" id="chnlNm|btnChnlPop" required="true"
						names="chnlNm" hidId="ridChnl" hidDto="ridChnl" dto="chnlNm"
						disabled="false" btnFunc="clubChnlPopupPop" label="제휴사명"  nuc ="true"
						labelClass="3" conClass="6" />

		</div>



	</div>
	<div class="pop_btn_area">
       	<ifvm:inputNew type="button" btnType="save"    text="L00074"  id="clubPartenariatInfoPopSaveBtn" btnFunc="clubPartenariatInfoPopSaveFn"/>
        <ifvm:inputNew type="button"    text="L00073"  id="clubPartenariatInfoPopCancelBtn" btnFunc="clubPartenariatInfoPopCancelFn"/>
	</div>


<div id="prodSearchHelpPop" class ="popup_container"></div>
<div id="clubChnlSearchHelpPop" class ="popup_container"></div>
