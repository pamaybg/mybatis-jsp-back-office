<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
    <h1>
    	<spring:message code="M02216" />
        &gt; <spring:message code="M00169" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-2">
	        <span><spring:message code="L02320"/></span>
	    </div>
	    <div class="col-xs-10 searchbtn_r">
	        <ifvm:inputNew type="button" id="goSave"  text="I00745" objCode="clubDetailSave_OBJ"/>
			<ifvm:inputNew type="button" id="goTermsList" btnFunc="getClubDetail.goList" text="L00824" objCode="goTermsList_OBJ"/>
	    </div>
	</div>
	<div class="form-horizontal underline top_well" id="clubDetailForm">
		<div class="form-horizontal top_well underline" id="clubDetail">
			<br>
			<div class="row">
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="clubNo" label="L02692" labelClass="2" conClass="10" disabled="true"/>
				</div>
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="clubNm" label="L02693" labelClass="2" conClass="10" required="true" />
				</div>
			</div>
			<div class="row">
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="ctgCd" names="ctgCd" dto="ctgCd" label="M00180" labelClass="2" conClass="10" required="true" />	
				</div>
				<div class="col-xs-6">
					<ifvm:inputNew type="select" id="clubStatCd" names="clubStatCd" dto="clubStatCd" label="M00245" labelClass="2" conClass="10" required="true" />
				</div>
			</div>
			<div class="row">
				<div class="col-xs-6">
					<ifvm:inputNew type="checkBox" id="atchYn" names="atchYn"  label="L02694" labelClass="2" conClass="4"/>
				</div>
				<div class="col-xs-6">
					<ifvm:inputNew type="checkBox" id="publicYn" names="publicYn"  label="L02695" labelClass="2" conClass="4"/>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-6">
					<ifvm:inputNew type="checkBox" id="rejoinLimitYn" names="rejoinLimitYn" label="L02696" labelClass="2" conClass="4"/>
				</div>
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="rejoinLimitDaycnt" names="rejoinLimitDaycnt" label="L02697" labelClass="2" conClass="6" disabled="true"/>일
				</div>
			</div>
			<div class="row">
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="pgmNm" names="pgmNm" dto="pgmNm" label="L02701" labelClass="2" conClass="6"  disabled="true" required="true" />
					<span class="input-group-addon" style="padding: 4px;" id="loyProgramList">
						<a><i class="fa fa-search"></i></a>
					</span>
					<ifvm:inputNew type="hidden" id="loyPgmRid" conClass="1"  disabled="true"/>
				</div>
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="periodMm" names="periodMm" dto="periodMm" label="L02698" labelClass="2" conClass="6"/>월
				</div>
			</div>
			<div class="row">
				<div class="col-xs-6">
					<ifvm:inputNew type="text" id="createBy" names="createBy" dto="createBy" label="M00221" labelClass="2" conClass="10" disabled="true"/>
				</div>
				<div class="col-xs-6">
					<ifvm:inputNew type="date" id="createDate" names="createDate" dto="createDate" label="M00222" labelClass="2" conClass="10" disabled="true"/>
				</div>
			</div>
			<div class="row">
				<ifvm:inputNew type="textarea" id="etc" names="etc" dto="etc" label="L02699" labelClass="1" conClass="11" rows="5" maxLength="2000"/>
			</div>
		</div>
		<br>
		<div id="clubDetailTabArea"></div>
	</div>
</div>
<div id="loyPgmListPopupContainer" class="popup_container"></div>

<script type="text/javascript">
var isNew = true;
var clubDetailTab;
var clubRid = $.ifvGetParam('rid');

var getClubDetail={
		init : function(){
			initTab();
		    var createDate = $("#createDate");
		    createDate.val($.ifvGetTodayDate());
		    createDate.ifvDateChecker({
				minDate : "today",
			});
			
			if (typeof clubRid === 'undefined') {
				isNew = true;		
				//termsDetailTab.disabledTab([0,1,2]);	
				$("#clubNo").val("");
				$("#clubNm").val("");
				$.fn.ifvmSetSelectOptionCommCode("ctgCd", "LOY_CLUB_TYPE_CD", null, null, true);
				$.fn.ifvmSetSelectOptionCommCode("clubStatCd", "LOY_ACTIVE_CD", null, null, true);
				$("#atchYn").val("");
				$("#publicYn").val("");
				$("#rejoinLimitYn").val("");
				$("#rejoinLimitDaycnt").val("");
				$("#loyPgmRid").val("");
				$("#pgmNm").val("");
				$("#pgmNm").val("");
				$("#periodMm").val("");
				$("#createBy").val("");
				$("#etc").val("");
			}
				
			else
				isNew = false;
			
			if(!isNew){
				
				$.ifvSyncPostJSON('<ifvm:action name="getClubDetail"/>', {
					rid : clubRid,
					ridPgm : $("#loyPgmRid").val()
				}, function(result) {
					if($.fn.ifvmIsNotEmpty(result)){
						$("#clubDetailForm").dataSetting(result);
						$("#clubNo").val(result.clubNo);
						$("#clubNm").val(result.clubNm);
						$.fn.ifvmSetSelectOptionCommCode("ctgCd", "LOY_CLUB_TYPE_CD", result.ctgCd, null, true);
						$.fn.ifvmSetSelectOptionCommCode("clubStatCd", "LOY_ACTIVE_CD", result.clubStatCd, null, true);
						if(result.atchYn == 'Y') $("input:checkbox[name='atchYn']").prop("checked",true) 
						else $("input:checkbox[name='atchYn']").prop("checked",false);
						if(result.publicYn== 'Y') $("input:checkbox[name='publicYn']").prop("checked",true) 
						else N = $("input:checkbox[name='publicYn']").prop("checked",false);
						if(result.rejoinLimitYn =='Y') {
							$("input:checkbox[name='rejoinLimitYn']").prop("checked",true);
							$("#rejoinLimitDaycnt").attr('disabled',false);
						}
						else {
							$("input:checkbox[name='rejoinLimitYn']").prop("checked",false);
							$("#rejoinLimitDaycnt").attr('disabled',true);
						}
						$("#rejoinLimitDaycnt").val(result.rejoinLimitDaycnt);
						$("#loyPgmRid").val(result.ridPgm);
						$("#pgmNm").val(result.pgmNm);
						$("#periodMm").val(result.periodMm);
						$("#createBy").val(result.createBy);
						$("#etc").val(result.etc);
					}
				});
			}
		},
		save : function(){
		 	//rejoinLimitDaycnt 체크
		 	if($("input:checkbox[name='rejoinLimitYn']")){
				var rejoinLimitDaycnt= $("#rejoinLimitDaycnt").val();
			 	if(rejoinLimitDaycnt < 0 || rejoinLimitDaycnt > 30){
					alert('<spring:message code="D10286"/>');
					$("#rejoinLimitDaycnt").focus();
					return;
				} 
		 	}
			var tUrl = isNew? '<ifvm:action name="saveClubDetail"/>' : '<ifvm:action name="modifyClubDetail"/>';
			var tData = null;
			tData = {
					rid : clubRid,
					clubNo : $("#clubNo").val(),
					clubNm : $("#clubNm").val(),
					ctgCd : $("#ctgCd").val(),
					clubStatCd : $("#clubStatCd").val(),
					atchYn : $("input:checkbox[name='atchYn']").is(":checked") ? 'Y' :'N',
					publicYn :$("input:checkbox[name='publicYn']").is(":checked") ? 'Y' :'N',
					rejoinLimitYn : $("input:checkbox[name='rejoinLimitYn']").is(":checked") ? 'Y' :'N',
					rejoinLimitDaycnt : $("input:checkbox[name='rejoinLimitYn']").is(":checked") ? $("#rejoinLimitDaycnt").val() : null,
					ridPgm : $("#loyPgmRid").val(),
					pgmNm : $("#pgmNm").val(),
					periodMm : $("#periodMm").val(),
					createBy : $("#createBy").val(),
					createDate : $("#createDate").val(),
					etc : $("#etc").val()
			};
			
			$.ifvSyncPostJSON(tUrl, tData
				, function(result) {
					if(result.rid != null) rid = result.rid;
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
						qtjs.href('<ifvm:url name="clubDetail"/>'+'?rid='+rid);
					}
				}, function(result) {
					alert('<spring:message code="M02248"/>');
			});
		},
		goList : function(){
			qtjs.href('<ifvm:url name="clubList"/>');
		}
}


function initTab() {
	$("#clubDetailTabArea").empty();

	termsDetailTab = $("#clubDetailTabArea").DrawTab(
    {
    	 item: items
    	/* [
			{
               label: '<spring:message code="D10262"/>',
               href: '<ifvm:url name="clubAttrList"/>'
			},
			{
               label: '<spring:message code="M00599"/>',
               href: '<ifvm:url name="clubOfferList"/>'
			},
    		{
               label: '<spring:message code="L02700"/>',
               href: '<ifvm:url name="clubMbrList"/>'
           }
        ] */
    });
}

function getLoyPgmList(){
	$("#loyPgmListPopupContainer").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="clubLoyPgmListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="L00325"/>',
        width: 900,
        close : 'loyPgmTPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	});
        }
    });
}

function loyPgmTPopupClose() {
	loyPgmListPopupContainer._destroy();
} 
 
$(document).ready(function() {
	
	getClubDetail.init();
	
	$("#goSave").click(function(){
		var validation = $("#clubDetail").ifvValidation();
		if (typeof clubRid === 'undefined' || clubRid == null) isNew = true;
		else isNew = false;
		
		if(validation.confirm()) getClubDetail.save();
		else return;
	});
	
	//LOY_PGM POPUP
	$("#loyProgramList").click(function(){
		getLoyPgmList();
	})
	
	$("#rejoinLimitYn").click(function(){
		if($("input:checkbox[name='rejoinLimitYn']").is(":checked")) {
			$("#rejoinLimitDaycnt").attr('disabled',false);
		}else{
			$("#rejoinLimitDaycnt").attr('disabled',true);
		}
	});

	
});
</script>
