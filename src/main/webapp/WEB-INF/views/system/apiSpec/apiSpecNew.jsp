<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
	.red{ color : #ff0000;}
</style>
<div class="page-title">
    <h1>
		API 등록 &gt; 신규
    </h1>
</div>

<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span>신규 등록</span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
	    	<%-- <ifvm:inputNew type="button" id="apiSpecExcelDown" btnFunc="excelDownFn" text="엑셀다운로드" objCode="apiSpecExcelDown_OBJ"/> --%>
			<ifvm:inputNew type="button" id="apiSave" btnFunc="apiSaveClick" btnType="save" text="L00074" objCode="apiSpecNewSave_OBJ" />
			<ifvm:inputNew type="button" id="goApiSpecList" btnFunc="btnListClick" text="D00024" objCode="goApiSpecList_OBJ"/>
	    </div>
	</div>

	<div class="form-horizontal underline top_well" id="apiSpecForm">
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span>분류</label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="apiGrpCd" names="apiGrpCd" dto="apiGrpCd" required="true"/>
			</div>
			<label class="col-xs-1 control-label">API 번호</label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="text" id="apiNo" names="apiNo" dto="apiNo" disabled="true"/>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span>API 명</label>
			<div class="col-xs-6 control_content">
				<ifvm:inputNew type="text" id="apiNm" names="apiNm" dto="apiNm" required="true"/>
			</div>
		</div>
		<div class="row qt_border">
			<div class="col-xs-2 control-label">프로시저 명</div>
			<div class="col-xs-6 control_content">
				<ifvm:inputNew type="text" id="spNm" names="spNm" dto="spNm"/>
			</div>
		</div> 
		<div class="row qt_border">
			<div class="col-xs-2 control-label">프로토콜</div>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="protocol" names="protocol" dto="protocol"/>
			</div>
			<div class="col-xs-2 control-label">상태</div>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="statCd" names="statCd" dto="statCd"/>
			</div>
		</div> 
		<div class="row qt_border">
			<div class="col-xs-2 control-label">HTTP 메소드</div>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="httpMethodCd" names="httpMethodCd" dto="httpMethodCd"/>
			</div>
			<div class="col-xs-2 control-label">HTTP 컨텐츠</div>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="httpContentTypeCd" names="httpContentTypeCd" dto="httpContentTypeCd"/>
			</div>
		</div> 
		<div class="row qt_border">
			<label class="col-xs-2 control-label">요청 URL</label>
			<div class="col-xs-6 control_content">
				<ifvm:inputNew type="text" id="reqUrl" names="reqUrl" dto="reqUrl" maxLength="100"/>
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-2 control-label">API 설명</label>
			<div class="col-xs-6 control_content">
				<ifvm:inputNew type="textarea" id="apiDesc" names="apiDesc" dto="apiDesc"  maxLength="300" rows="2"/>
			</div>
		</div>	
		<div class="row qt_border">
			<label class="col-xs-2 control-label">host</label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="search" id="host" names="host" dto="host" btnFunc="searchHost" />
			</div>
			<label class="col-xs-2 control-label">port</label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="text" id="port" names="port" dto="port" disabled="true"/>
			</div>
			<ifvm:inputNew type="hidden" id="systemRid" names="systemRid" dto="systemRid" conClass="1"/>
		</div>	
	</div>
</div>
<div id="apispecTab"></div>
<div id="popupContainer" class="popup_container"></div>
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
var rid =  '<%= cleanXss(request.getParameter("rid")) %>';

if(rid == "null") rid = null;

$(document).ready(function() {
	initTab();
	//$("#apiSpecExcelDown").attr("disabled",true);
	
	/* $.fn.ifvmSetSelectOptionCommCode("resourceLoc", "API_RESOURCE_LOC", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("serviceType", "API_SERVICE_TYPE", null, null, true); */
	$.fn.ifvmSetSelectOptionCommCode("statCd", "COM_STAT_TYPE_2_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("apiGrpCd", "LOY_API_GROUP_CD", null, null, false);
	$.fn.ifvmSetSelectOptionCommCode("httpMethodCd", "LOY_API_HTTP_METHOD_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("httpContentTypeCd", "LOY_API_CONTENT_TYPE_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("protocol", "LOY_API_PROTOCOL", null, null, true);
	if(rid != null){
		apiSpecDetail();
		//$("#apiSpecExcelDown").attr("disabled",false)
	}
	
	$("#apiGrpCd").change(function(){
		$.ifvSyncPostJSON('<ifvm:action name="getApiSpecNo"/>',{
			apiGrpCd : $("#apiGrpCd").val()
		},function(result){
			$("#apiNo").val(result.apiNo);
		});
	})
	
});


//저장
function apiSaveClick(){
	var url;
	validation = $("#apiSpecForm").ifvValidation();
	if(validation.confirm() === false) return;
		
	
	// 신규 수정 여부 
	if(rid == null){
		url = '/system/apiSpec/insertApiSpec.do';
		if(confirm('<spring:message code="M01633"/>') === false) return;
	} else{
		url = '/system/apiSpec/updateApiSpec.do';
		if(confirm('<spring:message code="M01633"/>') === false) return;
	}
	
	$.ifvSyncPostJSON(url,{
		rid : rid,
		apiNo : $("#apiNo").val(),
		apiNm : $("#apiNm").val(),
		spNm : $("#spNm").val(),
		reqUrl : $("#reqUrl").val(),
		apiDesc :$("#apiDesc").val(),
		systemRid :$("#systemRid").val(),
		apiGrpCd : $("select[name=apiGrpCd]").val(),
		protocol : $("select[name=protocol]").val(),
		statCd : $("select[name=statCd]").val(),
		httpMethodCd : $("select[name=httpMethodCd]").val(),
		httpContentTypeCd : $("select[name=httpContentTypeCd]").val()
	},function(result){
		if(result.success == true){
			alert('<spring:message code="M00005"/>');
			rid = result.message;
			qtjs.href('<ifvm:url name="apiSpecNew"/>'+'?rid='+rid);
		}else{
			alert('<spring:message code="M00029"/>');
		}
	});
	
}



//상세화면
function apiSpecDetail(args){
	$.ifvSyncPostJSON('<ifvm:action name="apiSpecDetail"/>',{
		rid : rid
	},function(result){
		 
		$("#apiNo").val(result.apiNo);
		$("#apiNm").val(result.apiNm);
		$("#spNm").val(result.spNm);
		$("#apiDesc").val(result.apiDesc);
		$("#reqUrl").val(result.reqUrl);
		$("#host").val(result.host);
		$("#port").val(result.port);
		$("#systemRid").val(result.systemRid);
		
		/* $("apiGrpCd").val(result.apiGrpCd),
		$("#protocol").val(result.protocol);
		$("#statCd").val(result.statCd);
		$("#httpMethodCd").val(result.httpMethodCd);
		$("#httpContentTypeCd").val(result.httpContentTypeCd); */
		
		$.fn.ifvmSetSelectOptionCommCode("statCd", "COM_STAT_TYPE_2_CD", result.statCd, null, true);
		$.fn.ifvmSetSelectOptionCommCode("apiGrpCd", "LOY_API_GROUP_CD", result.apiGrpCd, null, true);
		$.fn.ifvmSetSelectOptionCommCode("httpMethodCd", "LOY_API_HTTP_METHOD_CD", result.httpMethodCd, null, true);
		$.fn.ifvmSetSelectOptionCommCode("httpContentTypeCd", "LOY_API_CONTENT_TYPE_CD", result.httpContentTypeCd, null, true);
		$.fn.ifvmSetSelectOptionCommCode("protocol", "LOY_API_PROTOCOL", result.protocol, null, true);

	});
}
	function initTab() {
	    /* 탭 */
	    apispecTab = $('#apispecTab').DrawTab({
	        item: items 
// 	        	[
// 	            /* {label: '첨부문서', href: '<ifvm:url name="excelFileUpload"/>'}, */
// 	            {label: '요청', href: '<ifvm:url name="apiParamReqList"/>'},
// 	            {label: '응답', href: '<ifvm:url name="apiParamResList"/>'},
// 	           /*  {label: '채널', href: '<ifvm:url name="apiChnlList"/>'}, */
// 	            /* {label: '전송로그', href: '<ifvm:url name="apiSendLogList"/>'} */
// 	        ]
	    });
	}


function btnListClick() {
	history.pushState(null, null, location.href );
	qtjs.href('<ifvm:url name="apiSpecList"/>');
}

function searchHost(){
	$("#popupContainer").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="systemMgtListPop"/>',
        contentType : "ajax",
        title : "<spring:message code="사이트 조회"/>",
        width : '860px',
        close : 'popupClose',
     });
}

function popupClose(){
	popupContainer._destroy();
}

/* function excelDownFn(){
	$.ifvDBExcelDn('/system/program/progRelExcelDown.do', $("#apiSpecExcelDown").attr("objcode"));
} */
</script>