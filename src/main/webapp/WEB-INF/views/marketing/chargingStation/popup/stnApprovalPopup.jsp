<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var curAprvEmpId; //현재결재대상 직원아이디
var curAprvSeq; //현재결재대상순서
var curAprvItemType; //현재결재대상 유형코드
var curAprvItemId; //현재결재대상 아이템아이디
var aprvId; //결재정보아이디
var aprvGrid;

//기본정보/결재라인정보 조회
function getAprvInfo() {
	$.ifvSyncPostJSON('<ifvm:action name="getChargingStationAprvInfo"/>',{
		camId : camId
	},
	function(result) {
		if(result != null && result.aprvId != null && result.aprvId.length > 0) {
			chnlNo = result.chnlNo;
			aprvId = result.aprvId;
			setInputAprvInfo(result);
			
			$("#aprvDesc").attr("disabled", "disabled");
		} else { //결재상신 전
			setBtnWorkingMode();
		
			chnlNo = result.chnlNo;
			setInputAprvInfo(result);
		}
	});
}

//결재 기본정보 input 세팅
function setInputAprvInfo(result) {
	$("#aprvCamName").val(result.camName);
	$("#aprvCamName").text(result.camName);
	
	$("#empName").val(result.empName);
	$("#empName").text(result.empName);
	
	$("#division").val(result.aprvDiv);
	$("#division").text(result.aprvDiv);
	
	$("#aprvDate").val(result.aprvDate);
	$("#aprvDate").text(result.aprvDate);
	
	$("#aprvDesc").val(result.aprvDesc);
	$("#aprvDesc").text(result.aprvDesc);
}

function initAprvLineGrid() {
    var jqGridOption = {
    		loadComplete : function(data){
    			var isApprovaling = false; //결재진행중 여부
    			dataList = data.rows;
    			gridRecord = data.records;
    			
    			for(var i=0; i<gridRecord; i++){
    				if(aprvId != null && dataList[i].aprvType == '013') { //결재검토중
    					
    					curAprvSeq = dataList[i].seq;
    					curAprvItemType = dataList[i].aprvItemType;
    					curAprvItemId = dataList[i].aprvItemId;
    					curAprvEmpId = dataList[i].aprvEmpId;
    					
    					isApprovaling = true;
    					setBtnAprvMode();
    					return true;
    				} else if(aprvId != null && dataList[i].aprvType == '021') { //결재반려 상태
    					$("#aprvDesc").attr("disabled", false);
    					setBtnWorkingMode();
    				} else if(aprvId != null && dataList[i].aprvType == '014') { //결재승인완료 상태
    					setBtnAprvCompleteMode();
    				}
    			}
    		},
            serializeGridData : function( data ){
            	if(camId != null && camId.length > 0) {
					data.camId = camId;
					data.chnlNo = chnlNo;
            	}
                return data;
            },
            url:'<ifvm:action name="getChargingStationAprvLine"/>',
            colNames:['<spring:message code="M00240"/>',
                      '<spring:message code="S00030"/>',
                      '<spring:message code="M00955"/>', 
                      '<spring:message code="M00956"/>', 
                      '<spring:message code="M00957"/>', 
                      '<spring:message code="L00357"/>',
                      '<spring:message code="M00979"/>',
                      'aprvEmpId',
                      'aprvItemId',
                      'aprvItemType',
                      'aprvType'
                      ],
            colModel:[
                {name:'seq',index:'seq', align:'center'},
                {name:'aprvDivMarkName',index:'c2.mark_name'}, 
                {name:'empName',index:'e.name'},
                {name:'division',index:'cd.div_nm'},
                {name:'aprvTypeMarkName',index:'c1.mark_name'},
                {name:'aprvDate',index:'meai.apv_dd', formatter:'date',  formatoptions:{newformat:"Y-m-d"}},
                {name:'rejectRsn',index:'meai.reject_rsn'},
                {name:'aprvEmpId',index:'e.id', hidden:true},
                {name:'aprvItemId',index:'meai.id', hidden:true},
                {name:'aprvItemType',index:'meai.apvr_type_cd', hidden:true},
                {name:'aprvType',index:'c1.code_name', hidden:true}
            ],
            radio : false,
            sortname: 'seq',
            sortorder: 'asc',
            tempId: 'ifvGridTempleteSimple'
        };
    aprvGrid = $("#approvalPopupGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//결재상신 전  승인,반려 버튼 숨김
function setBtnWorkingMode() {
	$("#approvalPopupAprvBtn").hide();
	$("#approvalPopupRejectBtn").hide();
	$("#approvalPopupSendBtn").show();
}

//결재상신 후 결재상신 버튼 숨김
function setBtnAprvMode() {
	$("#approvalPopupSendBtn").hide();
	$("#approvalPopupAprvBtn").show();
	$("#approvalPopupRejectBtn").show();
}

//결재상신 후 결재상신 버튼 숨김
function setBtnAprvCompleteMode() {
	$("#approvalPopupSendBtn").hide();
	$("#approvalPopupAprvBtn").hide();
	$("#approvalPopupRejectBtn").hide();
}

//결재상신
function setApprovalSend() {
	
	var progress = $.ifvLoading($("#approvalPopupSendBtn"));
	
	$.ifvPostJSON('<ifvm:action name="requestChargingStationApproval"/>', {
		aprvTitle : $("#aprvCamName").val()
		, aprvId : camId
		, list : aprvGrid.getRowData()
		, aprvDesc : $("#aprvDesc").val()
	}, function(result) {
		
		if(result.message != null && result.message.length > 0) {
			alert(result.message);
			$(progress).remove();
			$("#approvalPopupSendBtn").removeAttr('disabled');
		} else {
			initCampaign(segId);
			alert('<spring:message code="C00094"/>');
			getAprvInfo();
			initAprvLineGrid();
			setBtnAprvMode();
			$(progress).remove();
			$("#approvalPopupSendBtn").removeAttr('disabled');
		}
	});
}

//결재승인
function setApproved() {
	
	var progress1 = $.ifvLoading($("#approvalPopupAprvBtn"));
	var progress2 = $.ifvLoading($("#approvalPopupRejectBtn"));
	
	//결재대상자인 경우 
	$.ifvSyncPostJSON('<ifvm:action name="checkEnableAprv"/>',{
		aprvId : aprvId
		, aprvItemId : curAprvItemId
	}, function(result) { //결재대상자일때만
		if(result.message == 'true') {
			var editRejectData = {
				apvDd : '1',
				id : aprvId,
				statusCode : '014',
				itemId : curAprvItemId,
				aprvType : '01',
				rejectRsn : null,
				elecAprvStatusCd : '090',
				recordRid : camId,
				seq : curAprvSeq
			}
			if(curAprvItemType == '9') {
				editRejectData.lastFlg = true;
			}
		
			$.ifvSyncPostJSON('<ifvm:action name="editReject"/>'
			, editRejectData 
			, function(result) {
				initAprvLineGrid();
				alert('<spring:message code="M00992"/>');
			});
			
		    // 최종 승인자일 때 :: 결재 완료
		    $.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>', {
		        elecAprvStatusCd : '090',
		        id : aprvId,
		        aprvType : '01',
		        recordRid : camId
		    }, function(result) {
		    	
		    });
		} else {
			alert('<spring:message code="S00037"/>');
		}
	
		$(progress1).remove();
		$("#approvalPopupAprvBtn").removeAttr('disabled');
		$(progress2).remove();
		$("#approvalPopupRejectBtn").removeAttr('disabled');
	});
}

//결재반려
function setApprovalReject() {
	
	var progress1 = $.ifvLoading($("#approvalPopupAprvBtn"));
	var progress2 = $.ifvLoading($("#approvalPopupRejectBtn"));
	
	//결재대상자인 경우 
	$.ifvSyncPostJSON('<ifvm:action name="checkEnableAprv"/>',{
		aprvId : aprvId
		, aprvItemId : curAprvItemId
	}, function(result) { //결재대상자일때만
		if(result.message == 'true') {
			var editRejectData = {
				apvDd : '1',
				id : aprvId,
				statusCode : '021',
				itemId : curAprvItemId,
				aprvType : '01',
				rejectRsn : null,
				elecAprvStatusCd : '020',
				recordRid : camId,
				seq : curAprvSeq
			}
			if(curAprvItemType == '9') {
				editRejectData.lastFlg = true;
			}
		
			$.ifvSyncPostJSON('<ifvm:action name="editReject"/>'
			, editRejectData 
			, function(result) {
				initAprvLineGrid();
				alert('<spring:message code="M00996"/>');
			});
			
		    // 최종 승인자일 때 :: 결재 완료
		    $.ifvSyncPostJSON('<ifvm:action name="editAprvType"/>', {
		        elecAprvStatusCd : '020',
		        id : aprvId,
		        aprvType : '01',
		        recordRid : camId
		    }, function(result) {
		    	
		    });
		} else {
			alert('<spring:message code="S00037"/>');
		}
	
		$(progress1).remove();
		$("#approvalPopupAprvBtn").removeAttr('disabled');
		$(progress2).remove();
		$("#approvalPopupRejectBtn").removeAttr('disabled');
	});
}

//결재상신
$("#approvalPopupSendBtn").on("click", function(){ 
	setApprovalSend();
});

//결재승인
$("#approvalPopupAprvBtn").on("click", function(){ 
	setApproved();
});

//결재반려
$("#approvalPopupRejectBtn").on("click", function(){ 
	setApprovalReject();
});

//팝업닫기
$("#approvalPopupCloseBtn").on("click", function(){ 
	approvalPopupClose();
});

$(document).ready(function(){
	getAprvInfo();
	initAprvLineGrid();
});

</script>

<script id="ifvGridTempleteSimple" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="grid_con">
			{grid}
		</div>
	</div>
</script>

<style>
.left_bold {font-weight:bold; text-align: left !important;}
</style>

<div id="dialogPopupWrap">
	<div id="stnApprovalPopupArea" class="pop_inner_wrap form-horizontal">
		<div class="row qt_border">
			<label class="col-xs-12 control-label left_bold"><spring:message code="M00556"/></label>
		</div>
		<div class="row group_box_line popup_contents_height" id="approvalPopCon">
			<div class="row qt_border"/>
			<div class="row qt_border">
			    <label class="col-xs-2 control-label"><spring:message code="M00941"/></label>
			    <div class="col-xs-10 control_content">
			        <ifvm:input type="text" id="aprvCamName" names="aprvCamName" readonly="readonly" disabled="true"/>
			    </div>
			</div>
			<div class="row qt_border">
			    <label class="col-xs-2 control-label"><spring:message code="M00942"/></label>    
			    <div class="col-xs-4 control_content">
			        <ifvm:input type="text" id="empName" names="empName" readonly="readonly" disabled="true"/>
			    </div>
			    <label class="col-xs-2 control-label"><spring:message code="S00029"/></label>    
			    <div class="col-xs-4 control_content">
			        <ifvm:input type="text" id="division" names="division" readonly="readonly" disabled="true"/>
			    </div>
			</div>
			<div class="row qt_border">
			    <label class="col-xs-2 control-label"><spring:message code="M00944"/></label>    
			    <div class="col-xs-4 control_content">
			        <ifvm:input type="text" id="aprvDate" names="aprvDate" readonly="readonly" disabled="true"/>
			    </div>
			</div>
			<div class="row qt_border">
				<ifvm:inputNew type="textarea" id="aprvDesc" label="M00947" maxLength="200" labelClass="2" conClass="10" rows="3"/>
			</div>
		</div>
	</div>
	<div class="row qt_border"/>
	<div class="pop_inner_wrap form-horizontal">
		<div class="row qt_border">
			<label class="col-xs-12 control-label left_bold"><spring:message code="M00949"/></label>
		</div>
		<div class="row group_box_line popup_contents_height" id="approvalPopupGrid"/>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm" style="display:none;" id="approvalPopupSendBtn"> <!-- 결재상신 -->
	        <spring:message code="M00987" />
	    </button>
	    <button class="btn btn-sm" style="display:none;" id="approvalPopupAprvBtn"> <!-- 승인 -->
	        <spring:message code="L01444" />
	    </button>
	    <button class="btn btn-sm" style="display:none;" id="approvalPopupRejectBtn"> <!-- 반려 -->
	        <spring:message code="L01445" />
	    </button>
	    <button class="btn btn-sm" id="approvalPopupCloseBtn"> <!-- 닫기 -->
	        <spring:message code="I00404"/>
	    </button> 
	</div>
</div>