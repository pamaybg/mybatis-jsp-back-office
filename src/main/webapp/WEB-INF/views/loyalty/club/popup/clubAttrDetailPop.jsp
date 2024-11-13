<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal underline top_well" id="clubDetailForm">
	<div class="form-horizontal top_well underline" id="clubDetail">
		<br>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="fieldTypeCd" names="fieldTypeCd" label="L02702" labelClass="2" conClass="9" />
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="checkBox" id="reqYn" names="reqYn" label="L02707" labelClass="2" conClass="9"/>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="select" id="code" names="code" label="Q02900" labelClass="2" conClass="9"/>	
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="val" names="val" label="D10249" labelClass="2" conClass="9"/>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="attrCreateBy" names="createBy"  label="M00221" labelClass="2" conClass="9" disabled="true"/>
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="date" id="attrCreateDate" names="createDate"  label="M00326" labelClass="2" conClass="9" disabled="true"/>
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="saveAttrBtn" objCode="clubAttrDetailSave_OBJ">
		<spring:message code="M01855" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="cancelAttrBtn" objCode="clubAttrDetailCancel_OBJ">
		<spring:message code="I00404" />
	</button>
</div>
		

<script type="text/javascript">

function getClubAttrDetail(){
	$.ifvSyncPostJSON('<ifvm:action name="getClubAttrDetail"/>', {
		rid : clubAttrRid,
		parRid : clubRid
	},function(result){
		$.fn.ifvmSetSelectOptionCommCode("fieldTypeCd", "LOY_CLUB_FIELD_CD", result.fieldTypeCd, null, true);
		if(result.reqYn == 'Y') $("input:checkbox[name='reqYn']").prop("checked",true);
		else $("input:checkbox[name='reqYn']").prop("checked",false);
		$.fn.ifvmSetSelectOptionCommCodeSync("code", "LOY_CLUB_SUB_TYPE_CD", result.code, "ctgCd", true);
		$("#val").val(result.val);
		$("#attrCreateBy").val(result.createBy);
		$("#attrCreateDate").val(result.createDate);
		
	});
}

var ClubAttrDetailPop={
		init : function(){
		    var createDate = $("#attrCreateDate");
		    createDate.val($.ifvGetTodayDate());
		    createDate.ifvDateChecker({
				minDate : "today",
			});
			
			if (typeof clubAttrRid === 'undefined' || clubAttrRid == null) {
				isNew = true;		
				$.fn.ifvmSetSelectOptionCommCode("fieldTypeCd", "LOY_CLUB_FIELD_CD", null, null, true);
				$("#reqYn").val("");
				$.fn.ifvmSetSelectOptionCommCodeSync("code", "LOY_CLUB_SUB_TYPE_CD", null, "ctgCd", true);
				$("#val").val("");
				$("#attrCreateBy").val("");
			}
			else{
				isNew = false;
				getClubAttrDetail();
			}

		},
		save : function(){
			if (typeof clubAttrRid === 'undefined' || clubAttrRid == null) 
				isNew = true;		
			else
				isNew = false;
			var tUrl = isNew? '<ifvm:action name="saveClubAttrDetail"/>' : '<ifvm:action name="modifyClubAttrDetail"/>';
			var tData = null;
			tData = {
					rid : clubAttrRid,
					ridClub : clubRid,
					fieldTypeCd : $("#fieldTypeCd").val(),
					reqYn : $("input:checkbox[name='reqYn']").is(":checked") ? 'Y' :'N',
					code : $("#code").val(),
					val : $("#val").val(),
					createBy : $("#attrCreateBy").val(),
					createDate: $("#attrCreateDate").val()
			};
			
			$.ifvSyncPostJSON(tUrl, tData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094"/>");
						clubAttrDetailPopupClose();
						clubAttrList._doAjax();
					}
				}, function(result) {
					alert('<spring:message code="M02248"/>');
			});
		}
}

$(document).ready(function(){
	
	ClubAttrDetailPop.init();
	
	$("#saveAttrBtn").click(function(){
		ClubAttrDetailPop.save();
	});
	
	$("#cancelAttrBtn").click(function(){
		clubAttrDetailPopupClose();
	});
	
});
</script>