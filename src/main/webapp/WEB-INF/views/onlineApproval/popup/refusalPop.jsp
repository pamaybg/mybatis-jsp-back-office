<%@page trimDirectiveWhitespaces="true" %>
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
var apId = '<%= cleanXss(request.getParameter("id")) %>'; 

function editReject() {
    // language code

    var active = 0;
//     var checkedList = approvedRequestListGrid2.getCheckedList();
    var checkedList = approvedRequestListGrid2.opt.gridControl.getSelectedRecords();
    var listFlowIdList = [];

    

    // 상태값 변경
    $.ifvSyncPostJSON('<ifvm:action name="editReject"/>', {
        apvDd : '1',
        id : checkedList[0].id,
        statusCode : '021',
        itemId : checkedList[0].itemId,
        aprvType : checkedList[0].aprvType,
        rejectRsn : $("#description").val(),
        elecAprvStatusCd : '020',
        recordRid : checkedList[0].recordRid,
        seq : checkedList[0].seq,
		approvalTypeCd : checkedList[i].apvrTypeCd
		, elecAprvEmpNo: checkedList[i].elecAprvEmpNo
		, elecAprvTitle: checkedList[i].elecAprvTitle
    }, function(result) {
        setTimeout(function() {
            Aprvcount();
        }, 100);
    });

    // 최종 승인자일 때 :: 결재 완료
    $.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>', {
        elecAprvStatusCd : '020',
        id : checkedList[0].id,
        aprvType : checkedList[0].aprvType,
        recordRid : checkedList[0].recordRid
    }, function(result) {
        setTimeout(function() {
            Aprvcount();
        }, 100);
        alert('<spring:message code="M00996"/>');
    });

//     approvedRequestListGrid2.requestData({});
	approvedRequestListGrid2.searchGrid({});
}

//결재 상신
function aprvreject(){
	//상태 값 코드
	$.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>',{
		elecAprvStatusCd : '020'
		,id : apId
	},function(result) {
	});
}

$(document).ready(function() {
	
	$('#saveBtn').on('click', function() {
		editReject();
		approvalPopupClose();
	});
	
	$('#refusalCancelBtn').on('click', function() {
		approvalPopupClose();
	});
	
});
</script>



<div id="capacityWrap">
	<div class="pop_inner_wrap form-horizontal">
		<div class="row">
			<label class="col-xs-3 control-label"><spring:message code="M00979"/></label>
			<div class="col-xs-9 control_content">
				<ifvm:input type="textarea" maxLength="1000" className="text_description text_description_150" id="description" />
			</div>
		</div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="saveBtn" objCode="refusalPopSave_OBJ">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00280"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="refusalCancelBtn" objCode="refusalPopCancel_OBJ">         
			<spring:message code="M00284"/>
		</button> 
	</div>
</div>