<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
var parRid=null;
var apiParamRid=null;
$(document).ready(function(){
	
	$("#addParParamPopBtn").on("click", function(){
		paramTypeCd="RES";
		addParParamPop();
	});
	
	$("#apiParamReqCancleBtn").on("click", function(){
		$.fn.ifvmPopupClose();
	});
	$("#apiParamReqSaveBtn").on("click", function(){
		var obj = {};
		validation = $("#apiParamReqForm").ifvValidation();
		
		if($('input:checkbox[id="requiredYn"]').is(":checked") == true){
			requiredYn = 'Y'
		}else{
			requiredYn = 'N'
		}
		
		varData = $("#apiParamReqForm").getSubmitData();
		varData.paramTypeCd = 'RES';
		varData.parRid = parRid;
		varData.apiRid = rid;
		varData.requiredYn = requiredYn;
		
		if(parRid!=null || $("#dataTypeCd").val()=='Array' || $("#dataTypeCd").val()=='Object') {
			varData.grpYn = 'Y';	
		} else {
			varData.grpYn = 'N';
		}
		
		if(validation.confirm()){
			if(apiParamResRid != null){
				// 수정
			
				varData.rid = apiParamRid;
				$.ifvSyncPostJSON('<ifvm:action name="editApiParamReq"/>',varData
				,function(result) {
					alert('<spring:message code="M00267"/>');
					$.fn.ifvmPopupClose();
					ifvGlobal.apiBodyParamNew.setGridDataLoad();
				});
			} else {
				
				$.ifvSyncPostJSON('<ifvm:action name="saveApiParamReq"/>',varData
				,function(result) {
					alert('<spring:message code="M00267"/>');
					$.fn.ifvmPopupClose();
					ifvGlobal.apiBodyParamNew.setGridDataLoad();
				});
			}
		}
	});
});

function addParParamPop() {
	$("#parParamPop").ifvsfPopup({
		enableModal : true,
	    enableResize: false,
	    contentUrl: '<ifvm:url name="parParamPop"/>',
	    contentType: "ajax",
	    title: '상위 파라미터 조회',
	    width: '600px',
	    close : 'addParParamClosePop',
	});
}

function addParParamClosePop() {
	parParamPop._destroy();
}

/*로딩 시 세팅해주는 부분. 
* 선택구역,반경 등의 Data를 가져와 화면에 뿌려준다.
*/
$(function(){
	$.fn.ifvmSetSelectOptionCommCode("paramTypeCd", "API_PARAM_TYPE_CD", "RES", null, true);
	$.fn.ifvmSetSelectOptionCommCode("dataTypeCd", "API_PARAM_DATA_TYPE_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("paramSubTypeCd", "API_PARAM_SUB_TYPE_CD", paramSubTypeCd, null, true);
	if(apiParamResRid != null) {
		//이벤트 조회
		$.ifvSyncPostJSON('<ifvm:action name="getParamResDetail"/>', {
			rid : apiParamResRid
		}, function(result) {
			$("#apiParamReqForm").dataSetting(result);
			parRid = result.parRid;
			apiParamRid  = result.rid;
			if(result.requiredYn=='Y'){
        		$("input:checkbox[id='requiredYn']").attr("checked", true);
        	} else {
        		$("input:checkbox[id='requiredYn']").attr("checked", false);
        	}
		});
	} else {
	}
	
});
</script>

<div class="form-horizontal underline top_well" id='apiParamReqForm'>
	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <%-- <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='순서'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" names="seqNo" dto="seqNo" id="seqNo" required="true"/>
	        </div> --%>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='파라미터  서브유형'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" names="paramSubTypeCd" dto="paramSubTypeCd" id="paramSubTypeCd" required="true" disabled="true"/>
	        </div>
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='필드'/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="text" id="paramNm" dto="paramNm" required="true"/>
	        </div>
	        <%-- <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code=''/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="password" id="pwd" required="true"/>
	        </div> --%>
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='데이터 유형'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" id="dataTypeCd" dto="dataTypeCd" names="dataTypeCd" required="true"/>
	        </div>
	        
	        <label class="col-xs-2 control-label"><spring:message code='데이터 형식'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="dataFormat" dto="dataFormat" names="dataFormat"/>
	        </div>
	    </div>
	    
	    <div class="row qt_border">
	      <label class="col-xs-2 control-label"><spring:message code="상위 오브젝트"/></label>
				<div class="col-xs-4 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" id="parParamNm" dto="parParamNm"/>
						<span class="input-group-addon" id="addParParamPopBtn">
							<a><i class="fa fa-search"></i></a>
						</span>
					</div>
				</div>
	    </div>

	    <div class="row">
	        <label class="col-xs-2 control-label"><spring:message code="필수여부"/></label>
                <div class="col-xs-5 control_content">
                    <ifvm:input type="checkbox" id="requiredYn" dto="requiredYn"  names="requiredYn" checked="true" />
                </div>
	    </div>
	    
	    <div class="row">
				<label class="col-xs-2 control-label"><spring:message code="파라미터명"/></label>
				<div class="col-xs-10 control_content">
					<ifvm:input type="textarea" id="paramDesc" dto="paramDesc" rows="5" maxLength="1000" />
				</div>   
		</div>
	    
	    <div class="row">
				<label class="col-xs-2 control-label"><spring:message code="설명"/></label>
				<div class="col-xs-10 control_content">
					<ifvm:input type="textarea" id="addDesc" dto="addDesc" rows="5" maxLength="1000" />
				</div>	    
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="apiParamReqSaveBtn" objCode="emailHostionPopSave_OBJ">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="apiParamReqCancleBtn" objCode="emailHostionPopCancel_OBJ">         
		<spring:message code="M00284"/>
	</button>  
</div>

<div id="parParamPop" class="popup_container"></div>