<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var segmentEditPopValidation;

function initSegmentEditPop() {
    segmentEditPopValidation = $(".segmentNameEditPop_wrap").ifvValidation();
    
    $("#segmentName").val(segment.originalData.segmentName);
    $("#segmentDesc").val(segment.originalData.segmentDesc);
}

//세그먼트명 저장
function saveSegmentName() {
    var data = {};
    data.segmentName = $("#segmentName").val();
    data.segmentDesc = $("#segmentDesc").val();
    data.segmentId = segment.segmentId;
    data.logicalCompId = segment.logicalCompId;
    
    var filterList = [];
    $.each(diagram.nodes(), function(index, node) {
        var fData = {};
        fData.segFilterId = node.name;
        fData.offSetX = node.offsetX;
        fData.offSetY = node.offsetY;
        
        filterList.push(fData); 
    });
    
    data.filterList = filterList;
    
    $.ifvProgressControl(true);
    
    $.ifvPostJSON('<ifvm:action name="saveSegment"/>', data
    , function(result) {
        $.ifvProgressControl(false);
        
        segment.originalData.segmentName = data.segmentName;
        segment.originalData.segmentDesc = data.segmentDesc;
        
        //세그먼트명
        $("#txt_segmentName").text(data.segmentName);
        
        //설명
        if ($.fn.ifvmIsNotEmpty(data.segmentDesc)) {
        	$("#txt_segmentDesc").html("&nbsp;>>&nbsp;" + data.segmentDesc);
        	$("#txt_segmentDesc").show();
        } else {
            $("#txt_segmentDesc").hide();
        }
        
		alert('<spring:message code="M00295" />');
		
		segmentNameEditPopupClose();
    }
 	, function(result) {
 	    $.ifvProgressControl(false);
 	   
 	    segmentMessageCheckr(result.message)
    });
}

$(document).ready(function(){
    
    initSegmentEditPop();
    
    //확인 클릭시
    $('#segmentNameEditPopSaveBtn').on('click', function(){
        if (segmentEditPopValidation.confirm()) {
            saveSegmentName();
        }
    });
    
    //닫기 클릭시
    $('#segmentNameEditPopCloseBtn').on('click', function(){
        segmentNameEditPopupClose();
    });
});
</script>
<div id="segmentNameEditPop_wrap" class="popup_container ">
    <div class="pop_inner_wrap">
        <div class="row qt_border">
        	<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00677" /></label>
        	<div class="col-xs-10 control_content">
        		<div class="input-group">
        			<ifvm:input type="text" maxLength="25" required="true" id="segmentName"/>
        		</div>
        	</div>
        </div>
    </div>
    <div class="pop_btn_area">
    	<button class="btn btn-sm btn_gray" id="segmentNameEditPopSaveBtn" objCode="segmentNameEditPopSaveBtn_OBJ">  
    		<i class="glyphicon glyphicon-check"></i>       
    		<spring:message code="M00137"/>
    	</button> 
    	<button class="btn btn-sm btn_lightGray2" id="segmentNameEditPopCloseBtn" objCode="segmentNameEditPopCloseBtn_OBJ">         
    		<spring:message code="M01322"/>
    	</button>
    </div> 
</div>
