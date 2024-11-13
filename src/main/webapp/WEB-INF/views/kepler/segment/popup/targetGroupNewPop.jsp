<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var targetGroupNewPopValidation;

//타겟그룹 저장
function saveTargetGroup(type) {
    if (targetGroupNewPopValidation.confirm()) {
        $.ifvProgressControl(true);
        var targetGroupId = "";
        var node = diagram.selectionList[0];
        var nodeData = diagram._selectedObject.data;
        var requestData = {};
        
        requestData.segmentId = segment.segmentId;
        requestData.logicalCompId = segment.logicalCompId;
        requestData.segFilterId = nodeData.segFilterId;
        requestData.targetGroupName = $("#targetGroupName").val();
        requestData.targetGroupDesc = $("#targetGroupDesc").val();
        requestData.segmentType="TGT_GROUP";
        var filterText = nodeData.displayName + " " + nodeData.filterText;
        if ($.fn.ifvmIsNotEmpty(nodeData.filterText2)) {
            filterText = filterText + ", " + nodeData.filterText2;
        }
        
        requestData.dpCond = filterText;
        /* 
        var comprGroupTypeCode;
        comprGroupTypeCode = $(":input:radio[name=comprGroupTypeCode]:checked").val();
         */
        //값이 있을경우만
        /* 
        var comprGroupDtl = $("#comprGroupDtl_" + comprGroupTypeCode).val(); 
        if (comprGroupDtl != "") {
            requestData.comprGroupDtl = comprGroupDtl.replace(",", "");
        } else {
            comprGroupTypeCode = "NA";
        }
         */
        requestData.comprGroupTypeCode = "NA";
        
        
        $.ifvPostJSON('<ifvm:action name="addTargetGroup"/>', requestData , function(result) {
            	targetGroupId = result.message;
                        
	            if (type == "L") {
	                //타겟그룹 상세 이동
	                var url = '<ifvm:url name="targetGroupDetail"/>?targetGroupId='+targetGroupId;
	                qtjs.href(url);
	            } else {
	            	alert('<spring:message code="M00295" />');
	            }
	            
	            $.fn.ifvmPopupClose();
            	
	            //segmentMessageCheckr(result.message);

        });
        $.ifvProgressControl(false);
    }
}

//비교군 유형 선택시 설정
/* 
function setComprGroupTypeCode() {
    var comprGroupTypeCode = $(":input:radio[name=comprGroupTypeCode]:checked").val()
    if (comprGroupTypeCode == "R") {
        $("#comprGroupDtl_R").attr("disabled", false);
        $("#comprGroupDtl_C").attr("disabled", true);
        $("#comprGroupDtl_C").val("");
    } else {
        $("#comprGroupDtl_C").attr("disabled", false);
        $("#comprGroupDtl_R").attr("disabled", true);
        $("#comprGroupDtl_R").val("");
    }
}
 */

$(document).ready(function(){
    targetGroupNewPopValidation = $("#targetGroupNewPop_wrap").ifvValidation(); 
    
    //저장 클릭시
    $('#targetGroupNewPopSaveBtn').on('click', function(){
        saveTargetGroup("N");
    });
    
    //저장 및 열기 클릭시
    $('#targetGroupNewPopSaveAndOpenBtn').on('click', function(){
        saveTargetGroup("L");
    });
    
    //닫기 클릭시
    $('#targetGroupNewPopCloseBtn').on('click', function(){
        targetGroupNewPopupClose();
    });
    
  	//비교군 유형
  	/* 
    $("input[name=comprGroupTypeCode]").change(function() {
        setComprGroupTypeCode();
    });
  	//콤마
    $("input[name=comprGroupDtl_R]").keyup(function() {
        $(this).val($.fn.ifvmNumberWithCommas(this.value));
    });
    
  	//콤마
    $("input[name=comprGroupDtl_C]").keyup(function() {
        $(this).val($.fn.ifvmNumberWithCommas(this.value));
    }); 
  	 */
}); 
</script>

<div id="targetGroupNewPop_wrap" class="popup_container">
    <div class="pop_inner_wrap">
        <div class="row qt_border">
    		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M01490"/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" required="true" maxLength="25" id="targetGroupName" names="targetGroupName" />
            </div>
        </div>
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><spring:message code="타겟그룹 설명"/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" maxLength="25" id="targetGroupDesc" names="targetGroupDesc" />
            </div>
        </div>
        <%-- 비교군 숨김처리
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><spring:message code="M01491"/></label>
            <div class="col-xs-9 control_content">
            	<label class="col-xs-2 control-label">
                    <ifvm:input type="radio" names="comprGroupTypeCode" values="R" checked="true" id="comprGroupTypeCode" />
                    <spring:message code="M01492"/>
                </label>
                <div class="col-xs-3 control_content">
                    <ifvm:input type="text" maxLength="30" names="comprGroupDtl_R" id="comprGroupDtl_R" />
                </div>
                <label class="unit-label">%</label>
        		<label class="col-xs-2 control-label" >
                    <ifvm:input type="radio" names="comprGroupTypeCode" values="C" id="comprGroupTypeCode" />
                    <spring:message code="M00919"/>
                </label>
                <div class="col-xs-3 control_content">
                    <ifvm:input type="text" maxLength="30" disabled="true" names="comprGroupDtl_C" id="comprGroupDtl_C" />
                </div>
                <label class="unit-label">
                    <spring:message code="M01196"/>
                </label>
            </div>
        </div>
         --%>
	</div>
    <div class="pop_btn_area">
    	<button class="btn btn-sm btn_gray" id="targetGroupNewPopSaveBtn" objCode="targetGroupNewPopSaveBtn_OBJ">  
    		<i class="glyphicon glyphicon-check"></i>       
    		<spring:message code="M00137"/>
    	</button>
        <button class="btn btn-sm btn_gray" id="targetGroupNewPopSaveAndOpenBtn" objCode="targetGroupNewPopSaveAndOpenBtn_OBJ">  
            <i class="glyphicon glyphicon-check"></i>       
            <spring:message code="M01493"/>
        </button>  
    	<button class="btn btn-sm btn_lightGray2" id="targetGroupNewPopCloseBtn" objCode="targetGroupNewPopCloseBtn_OBJ">         
    		<spring:message code="M01322"/>
    	</button>
    </div> 
</div>
