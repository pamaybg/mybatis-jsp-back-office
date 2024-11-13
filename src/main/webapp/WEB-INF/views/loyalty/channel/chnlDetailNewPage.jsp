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
<div class="page-title">
    <h1>
        <spring:message code="L00648"/>
        &gt;  <spring:message code="M00169"/>
    </h1>
</div>
<div>
	<div class="page_btn_area" id="headForm">
	    <div class="col-xs-7">
	    	<%-- 채널 상세 --%>
	        <span><spring:message code="M02462"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	        <ifvm:inputNew type="button" id="goSave" btnFunc="getChnlDetail.save" text="I00745" objCode="chnlDetailNewPageGoSave_OBJ"/>
			<ifvm:inputNew type="button" id="goTermsList" btnFunc="getChnlDetail.goList" text="L00824" objCode="chnlDetailNewPageGoList_OBJ"/>
	    </div>
	</div>
	
	<div class="form-horizontal underline top_well" id="chnlDetailForm" >
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="채널명"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="text" disabled="true" id="chnlNo" dto="chnlNo"/>
			</div>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="text"  required="true" id="chnlNm" dto="chnlNm"/>
			</div>
			
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="채널유형"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" required="true" id="chnlTypeCd" names="chnlTypeCd" maxLength="5" dto="chnlTypeCd"/>
			</div>
			
			<label class="col-xs-1 control-label"><spring:message code="채널서브유형"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="chnlSubTypeCd" names="chnlSubTypeCd" maxLength="5" dto="chnlSubTypeCd"/>
			</div>
	
			
	
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="채널 실제명"/></label>
			<div class="col-xs-5 control_content">
				<ifvm:inputNew type="text" required="true" maxLength="15" id="chnlRealNm" dto="chnlRealNm"/>
			</div>
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="상태"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" required="true" id="statCd" maxLength="5" names="statCd" dto="statCd"/>
			</div>
			
			<label class="col-xs-1 control-label"><spring:message code="채널 레벨"/></label>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="select" id="lvlCd" maxLength="5" names="lvlCd" dto="lvlCd"/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="상위채널"/></label>
			<div class="col-xs-2 control_content">
				<div class="input-group">
					<ifvm:inputNew type="search" disabled="true" id="parChnlNm" dto="parChnlNm" btnFunc="channelParentPopup"/>
				</div>
			</div>

			<label class="col-xs-1 control-label"><spring:message code="브랜드"/></label>
			<div class="col-xs-2 control_content">
				<div class="input-group">
					<ifvm:inputNew type="search" disabled="true" id="brdNm" dto="brdNm" btnFunc="brandPopup" />
					<ifvm:inputNew type="hidden" disabled="true" id="brdRid" dto="brdRid" />
				</div>
			</div>

			<label class="col-xs-1 control-label"><spring:message code="매장관리자"/></label>
			<div class="col-xs-1 control_content">
				<div class="input-group">
					<ifvm:inputNew type="text" disabled="true" id="empNm" dto="empNm"/>
					<ifvm:inputNew type="hidden" disabled="true" id="empRid" dto="empRid"/>
				</div>
			</div>
			<div class="col-xs-2 control_content">
				<div class="input-group">
					<ifvm:inputNew type="search" disabled="true" id="empNo" dto="empNo" btnFunc="searchEmployee"/>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="channelDetailTabArea"></div>

<div id="channelParentPop" class="popup_container"></div>
<div id="popupContainer" class="popup_container"></div>
<div id="empPopupContainer" class="popup_container"></div>

<script>
var channelDetailTabArea = $('#channelDetailTabArea').DrawTab({
	item: items
	
	
	/*
		{label: '<spring:message code="L00333"/> ', href: '<ifvm:url name="chnlAddInfoDetail"/>'},  
		{label: '이미지 정보', href: '<ifvm:url name="chnlimgInfoDetailNewPage"/>'}, 
		{label: '<spring:message code="L02701"/> ', href: '<ifvm:url name="chnlLoyPgmListNew"/>'},  
		{label: '<spring:message code="L02783"/> ', href: '<ifvm:url name="chnlMbrRelListNew"/>'},  
		{label: '<spring:message code="L02784"/> ', href: '<ifvm:url name="chnlSettleListNewPage"/>'},  
	*/
	
	
});

var channelDetail_rid = '<%= cleanXss(request.getParameter("rid")) %>';
channelDetail_rid = channelDetail_rid == 'null' ? null : channelDetail_rid;
var channelDetail_isNew = true;  //신규 여부. 신규: true, 수정 : false
var parChnlRid=null;
var getChnlDetail={
		init : function(){
			$.fn.ifvmSetSelectOptionCommCode("chnlTypeCd", "LOY_CHNL_TYPE_CD", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("statCd", "COM_STAT_TYPE_1_CD", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("lvlCd", "CHNL_LVL_CD", null, null, false);
			$.fn.ifvmSetSelectOptionCommCodeSync("chnlSubTypeCd", "LOY_CHNL_SUB_TYPE_CD", null, "chnlTypeCd", false);
	    	if (channelDetail_rid === null){
	    		channelDetail_isNew = true;
	    	channelDetailTabArea.disabledTab([0,1,2,3,4]);
	    	}
			else
				channelDetail_isNew = false;
			if (!channelDetail_isNew) {
				$.ifvSyncPostJSON('<ifvm:action name="getChnlDetailNew"/>', {
					rid : channelDetail_rid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#chnlDetailForm").dataSetting(result);
						$.fn.ifvmSetSelectOptionCommCodeSync("chnlSubTypeCd", "LOY_CHNL_SUB_TYPE_CD", null, "chnlTypeCd", false);
						$("#chnlSubTypeCd").val(result.chnlSubTypeCd);
						parChnlRid = result.parChnlRid;
					}
				}, function(result) {
					alert(result.message);
				});
			}
		},//INIT END
		save : function(){
			var validation = $("#chnlDetailForm").ifvValidation();
			
			//유효성 체크
			if(validation.confirm()){
				var url = channelDetail_isNew? '<ifvm:action name="saveChnlDetail"/>' : '<ifvm:action name="modifyChnlDetail"/>';
				var varData = null;
				varData = $("#chnlDetailForm").getSubmitData();
				varData.rid = channelDetail_rid;
				varData.parChnlRid = parChnlRid;

				$.ifvSyncPostJSON(url, varData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
						if($.fn.ifvmIsNotEmpty(result.message)) channelDetail_rid = result.message;
						if(channelDetail_isNew) {
							qtjs.href('<ifvm:url name="chnlDetailNewPage"/>' + '?rid=' + channelDetail_rid);
						}
					}
				}, function(result) {
					alert("<spring:message code="M02248" />");
				});
			 }
		},//SAVE END
		goList : function(){
			//location.href = '<ifvm:url name="srcTgtList"/>';
			qtjs.href('<ifvm:url name="channelListNewPage"/>');
		}
	}
function channelParentPopup() {
	$("#channelParentPop").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl: '<ifvm:url name="chnlParentPop"/>',
		contentType: "ajax",
		title: '상위채널 등록',
		width: '800px',
		close : 'chnlPopclose',
	});
}

function chnlPopclose() {
	channelParentPop._destroy();
}

function brandPopup(){
	$.fn.ifvmPopupOpen('popupContainer', null,
			'<ifvm:url name="brandPop"/>',
			'<spring:message code="브랜드"/>', 860);
}

function searchEmployee(){
	$.fn.ifvmPopupOpen('empPopupContainer', null,
			'<ifvm:url name="empListCommonPop"/>',
			'<spring:message code="직원"/>', 860);
}


$(document).ready(function() {

	getChnlDetail.init();
	
	/*$('#btnChnlParPop').on('click', function(){
		channelParentPopup();
	});*/
	
	$("#chnlNm").keyup(function(){
		$("#chnlRealNm").val($("#chnlNm").val());
	});

});

</script>

