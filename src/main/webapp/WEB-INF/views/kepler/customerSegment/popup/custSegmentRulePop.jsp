<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var custRuleNewPopValidation;

//타겟그룹 저장
function saveCustRule(type) {
    if (custRuleNewPopValidation.confirm()) {
        $.ifvProgressControl(true);
        var targetGroupId = "";
        var node = diagram.selectionList[0];
        var nodeData = diagram._selectedObject.data;
        var requestData = {};
        
        requestData.segmentId = segment.segmentId;
        requestData.logicalCompId = segment.logicalCompId;
        requestData.segFilterId = nodeData.segFilterId;
        requestData.custRuleName = $("#custRuleName").val();
        requestData.custRuleDesc = $("#custRuleDesc").val();
        requestData.segmentType="CUST_SEG_RULE";
        
        var filterText = nodeData.displayName + " " + nodeData.filterText;
        if ($.fn.ifvmIsNotEmpty(nodeData.filterText2)) {
            filterText = filterText + ", " + nodeData.filterText2;
        }
        
        requestData.dpCond = filterText;

        requestData.comprGroupTypeCode = "CS"; //CUST SEGMENT
        
         $.ifvPostJSON('<ifvm:action name="addCustSegmentRule"/>', requestData , function(result) {
            	targetGroupId = result.message;
                        
	            if (type == "L") {
	                //타겟그룹 상세 이동
	                var url = '<ifvm:url name="targetGroupDetail"/>?targetGroupId='+targetGroupId;
	                qtjs.href(url);
	            }else {
	                //팝업 닫기
	                 custSegmentRulePopupClose();
	            }
            	//segmentMessageCheckr(result.message);
            	alert("생성되었습니다.");
        });
        $.ifvProgressControl(false);
    }
}


$(document).ready(function(){
	custRuleNewPopValidation = $("#custRuleNewPop_wrap").ifvValidation(); 
	var urlParams = $.ifvGetParams();
    var segmentId = urlParams.segmentId;
     //저장 클릭시
    $('#custRuleSaveBtn').on('click', function(){
        saveCustRule("N");
    });
     //저장 및 열기 클릭시
    $('#custRuleSaveAndOpenBtn').on('click', function(){
    	saveCustRule("L");
    });
     //닫기 클릭시
    $('#custRuleNewPopCloseBtn').on('click', function(){
    	custSegmentRulePopupClose();
    });

}); 
</script>

<div id="custRuleNewPop_wrap" class="popup_container">
    <div class="pop_inner_wrap">
        <div class="row qt_border">
    		<label class="col-xs-3 control-label"><span class="asterisk">*</span>고객 세분화 룰 명</label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" required="true" maxLength="25" id="custRuleName" names="custRuleName" />
            </div>
        </div>
        <div class="row qt_border">
    		<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00324"/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" required="true" maxLength="100" id="custRuleDesc" names="custRuleDesc" />
            </div>
        </div>
      	</div>
    <div class="pop_btn_area">
    	<button class="btn btn-sm btn_gray" id="custRuleSaveBtn">  
    		<i class="glyphicon glyphicon-check"></i>       
    		<spring:message code="M00137"/>
    	</button>
       <%--  <button class="btn btn-sm btn_gray" id="custRuleSaveAndOpenBtn">  
            <i class="glyphicon glyphicon-check"></i>       
            <spring:message code="M01493"/>
        </button>   --%>
    	<button class="btn btn-sm btn_lightGray2" id="custRuleNewPopCloseBtn">         
    		<spring:message code="M01322"/>
    	</button>
    </div> 
</div>
