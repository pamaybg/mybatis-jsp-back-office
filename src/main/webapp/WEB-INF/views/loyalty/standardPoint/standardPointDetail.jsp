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

var testViewList_rid = '<%= cleanXss(request.getParameter("rid")) %>';
var admValid;
function standardPointDataLoad(testViewList_rid) {
	if(testViewList_rid!="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getStandardPointDetail"/>', {
			  rid: testViewList_rid
			 }, function(result) {

			  if($.fn.ifvmIsNotEmpty(result)) {
					$($('#pointAdmForm').find('input')).each(function(index, item){
						$(item).val(result.rows[0][$(item).attr('id')]);
			 	 		if($(this).attr('type')=="checkbox"){
			 	 			if(result.rows[0][$(item).attr('id')]=='Y'){
			 	 				$(this).attr('checked', 'true');
			 	 			}
			 	 		}
			 		});
			 		$($('#pointAdmForm').find('select')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);
			 		});
			 		$($('#pointAdmForm').find('textarea')).each(function(index, item){
			 			$(item).val(result.rows[0][$(item).attr('id')]);
			 		});
			  }

			  if($("#statusCd").val() =="10"){
				  pointDtlDisabled();
				  $("#pointConfirmBtn").attr("disabled",true);
			  }
			 });
	}else{
		$("#statusCd").val("00");
	}

	if(testViewList_rid!="null"){
		$("#typeCd").attr("disabled",true);
	}
	buttonValid();
}


//1000단위 정규식
function numberWithCommas(x) {
    return  Math.round(x).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function typeCdValid(){
	$("#typeCd").change(function(){
		if($(this).val()=="G"){

		}
	});
}

$(document).ready(function(){
	$.ifvmLnbSetting('standardPointListNew');
	commCodeSetting();
	standardPointDataLoad(testViewList_rid);

 $.ifvmLnbSetting('testViewList');

 $("#transactListBtn").click(function(){
	 qtjs.href('<ifvm:url name="transactionList"/>');
    });

	tabContent();
	typeCdValid();
});

function tabContent() {
	var testTab = $('#tabContent').DrawTab({
		item: [
			{label:'<spring:message code="L00897"/>' , href: '<ifvm:url name="pointSaveListInfoNew"/>'},
			{label:'<spring:message code="L00898"/>' , href: '<ifvm:url name="pointUseListInfoNew"/>'},
			{label:'<spring:message code="L00899"/>' , href: '<ifvm:url name="pointAdjustmentInfoNew"/>'},
		]
	});
}

function pointLitFn(){
	var url = '<ifvm:url name="standardPointList"/>';
	qtjs.href(url);
}

function commCodeSetting(){
	//기준유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'POINT_RULE_STD'
		, enableNA : true
	},function(result) {
		var temp = $("#typeCdTemp").tmpl(result.rows);
		$("#typeCd").append(temp);
	});

	//기준코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'PRODUCT_STATUS'
		, enableNA : true
	},function(result) {
		var temp = $("#statusCdTemp").tmpl(result.rows);
		$("#statusCd").append(temp);
	});
}

function pointStandardSaveFn(){
	admValid = $("#pointAdmForm").ifvValidation();
	if(admValid.confirm()==true){
		if($("#typeCd").val()=="G" && $("#ascStnYn").is(":checked")){
			alert('<spring:message code="L02042"/>')
			return;
		}

		var submitData=$("#pointAdmForm").getSubmitData();
		if($("#ascStnYn").prop("checked")){
			submitData.ascStnYn = "Y"
		}else{
			submitData.ascStnYn = "N"
		}
		if(testViewList_rid != "null" ){
			submitData.rid = testViewList_rid;
			 $.ifvSyncPostJSON('<ifvm:action name="updatePointAdm"/>', submitData, function(result) {
					alert('<spring:message code="L01260"/>');
					location.replace('<ifvm:url name="standardPointDetail"/>' + '?rid=' + testViewList_rid );
			})
		}else{
			 $.ifvSyncPostJSON('<ifvm:action name="insertPointAdm"/>', submitData, function(result) {
					alert('<spring:message code="I00741"/>');
					testViewList_rid=result.message;
					location.replace('<ifvm:url name="standardPointDetail"/>' + '?rid=' + testViewList_rid );
			})
		}
	}
}
function pointDtlDisabled(){
	$('#pointAdmForm').find('input').each(function(index, item){
		$(item).attr("disabled",true);
	});

	$('#pointAdmForm').find('select').each(function(index, item){
		$(item).attr("disabled",true);
	});
	$('#pointAdmForm').find('textarea').each(function(index, item){
		$(item).attr("disabled",true);
	});
}
function buttonValid(){
	if($("#statusCd").val()!="00"){
		$("#pointSaveBtn").attr("disabled",true);
		$("#pointSaveBtn").attr("disabled",true);
	}
}

function pointConfirmFn(){
	if(confirm('<spring:message code="L02010"/>')) {
		 $.ifvSyncPostJSON('<ifvm:action name="updatePointStatusCd"/>', {rid : testViewList_rid}, function(result) {
			 alert('<spring:message code="L01588"/>');
			 standardPointDataLoad(testViewList_rid);
		 });
		pointDtlDisabled();
	}

}
</script>


<script id="typeCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="statusCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
.well {
	margin-bottom: 0;
}

.top_well {
	border-bottom: 0;
}
</style>

<div class="page-title">
	<h1>
		<spring:message code="L00895"/> &gt;  <spring:message code="L00079"/>
	</h1>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-7">
		<span> <spring:message code="L00910" /></span></span>
	</div>

	<div class="col-xs-5 searchbtn_r">
		<%-- <ifvm:inputNew type="button" btnType="save"  text="L00074"  id="pointSaveBtn" btnFunc="pointStandardSaveFn"/> --%>
		<ifvm:inputNew type="button" text="L00900" id="pointConfirmBtn"
			btnFunc="pointConfirmFn" objCode="pointConfirmBtn_OBJ"/>
		<ifvm:inputNew type="button" text="M00002" id="pointLitBtn"
			btnFunc="pointLitFn" objCode="pointLitBtn_OBJ"/>
	</div>
</div>


<div class="form-horizontal underline top_well" id="pointAdmForm">

	<div class="row  qt_border">
		<ifvm:inputNew type="select" id="typeCd" maxLength="50" dto="typeCd"
			label="L00891" labelClass="1" conClass="4" required="true" />
		<label class="col-xs-2 control-label"><spring:message
				code="L00892" /></label>
		<div class="col-xs-4 control_content">
			<input type="checkbox" id="ascStnYn" />
		</div>

	</div>
	<div class="row qt_border" >
		<ifvm:inputNew type="text" id="ruleCd" maxLength="50" dto="ruleCd"
			label="L00893" labelClass="1" conClass="4" disabled="true" />
		<ifvm:inputNew type="select" id="statusCd" maxLength="50"
			dto="statusCd" label="L00894" labelClass="2" conClass="4"
			disabled="true" />
	</div>

	<div class="row  qt_border">
		<ifvm:inputNew type="textarea" id="ruleTypeCd" maxLength="300"
			dto="ruleTypeCd" label="L00896" labelClass="1" conClass="10"
			required="true" />
	</div>
</div>

<div id="testViewListTabArea">
	<div class="btn-group btn-group-justified" id="tabType"></div>
	<!-- 탭 컨텐츠 -->
	<div id="tabArea">
		<div id="tabContent"></div>
	</div>

</div>

<script>

</script>

<script>

</script>
<div id="testViewListPopupContainer" class="popup_container"></div>
<!-- 팝업 -->
<div id="stampDetailPopDiv" class="popup_container content_container"></div>
