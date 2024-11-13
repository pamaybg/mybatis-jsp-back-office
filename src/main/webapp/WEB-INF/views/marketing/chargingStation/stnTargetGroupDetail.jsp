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
<script type="text/javascript">
var targetGroupTargetListGrid;
var targetGroup = {
        targetGroupId: "",
        data: {}
}

function initTargetGroupDetail() {
    var targetGroupId = '<%= cleanXss(request.getParameter("targetGroupId")) %>';
    targetGroup.targetGroupId = $.fn.ifvmIsEmpty(targetGroupId) || targetGroupId == "null" ? '' : targetGroupId;
    
    //타겟그룹 상세 조회
    getTargetGroup();
}

//타겟그룹 상세 조회
function getTargetGroup() {
    var targetGroupId = targetGroup.targetGroupId;
    
    $.ifvPostJSON('<ifvm:action name="getTargetGroup"/>', {
        targetGroupId: targetGroupId
    },
    function(result) {
        //타겟그룹 설정
        setTargetGroup(result);
        targetGroup.data = result;
        
        //타겟그룹 대상자 조회
        getTargetGroupTargetList();
    },
    function(result) {
        $.errorChecker(result);
    });
}

//타겟그룹 설정
function setTargetGroup(data) {
    $("#targetGroupName").val(data.targetGroupName);
    $("#targetGroupDesc").val(data.targetGroupDesc);
    $("#filterText").val(data.dpCond);
    
    //대상수 조회 오류 발생시 메시지
    if (data.targetCount == "MSG_T0001") {
        $.ifvErrorPop('<spring:message code="M01694"/>');
    } else {
    	$("#targetCount").val(data.targetCount);
    }
    /* 
    var comprGroupDtl = data.comprGroupDtl;
    var comprGroupTypeCode = data.comprGroupTypeCode;
    if (comprGroupTypeCode == "R") {
        comprGroupDtl += " %";
    } else if (comprGroupTypeCode == "C") {
        comprGroupDtl += ' <spring:message code="M01196"/>';
    } else {
        comprGroupDtl = "";
    }
    $("#comprGroupDtl").val(comprGroupDtl);
     */
}

//타겟그룹 대상자 목록
function getTargetGroupTargetList() {
    var targetGroupId = targetGroup.targetGroupId;
    
    var targetGroupColList = [];
    
    //타겟그룹 대상자 컬럼 목록 조회
    $.ifvPostJSON('<ifvm:action name="getTargetGroupColumnList"/>', {
        targetGroupId: targetGroupId
    },
    function(result) {
        if (result.length > 0) {
        	targetGroupColList = result;
        }
        
      	//타겟그룹 대상자 그리드 설정
        setTargetGroupTargetListGrid(targetGroupColList);
    });

}

//타겟그룹 대상자 그리드 설정
function setTargetGroupTargetListGrid(targetGroupColList) {
    var targetGroupId = targetGroup.targetGroupId;
    var colNames = [];
    var colModel = [];
    	
    //타겟그룹 대상자 그리드 모델 설정
    $.each(targetGroupColList, function(index, col) {
        colNames.push(col.displayName);
        var model = {name: col.columnName, index: col.columnName, align: 'center', resizable: false}
        colModel.push(model);
    });
    
    //타겟그룹 대상자 그리드 설정
    var jqGridOption = {
            serializeGridData : function( data ){
    			data.targetGroupId = targetGroupId;
    		},	
        	url : '<ifvm:action name="getTargetGroupTargetList"/>',
            colNames: colNames,
            colModel: colModel,
            sortname: '1',
            sortorder: "desc",
       //   tempId : 'ifvGridOriginTemplete',
    };
    
    targetGroupTargetListGrid = $("#targetGroupTargetListGrid").ifvGrid({ jqGridOption : jqGridOption });
    
    if (targetGroupColList.length < 1) {    
        //컬럼 설정 팝업 열기
        targetGroupColumnSetPopupOpen();
    }
    
    //대상수
    $("#targetCount").val();
}

//목록 이동
function targetGroupList() {
    //타겟그룹 메인
    if (typeof targetGroupMain != "undefined") {
        targetGroupMain.targetGroupMainLoad();
    }
    //타겟그룹 관리
    else {
        qtjs.href('<ifvm:url name="targetGroupList"/>');
    }
}

//컬럼 설정 팝업 열기
function targetGroupColumnSetPopupOpen() {
    $("#targetGroupColumnSetPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="targetGroupColumnSetPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01496" />',
        width: 400,
        close : 'targetGroupColumnSetPopupClose'
    });
}

//컬럼 설정 팝업 닫기
function targetGroupColumnSetPopupClose(){
    targetGroupColumnSetPopup._destroy();
}

//엑셀 다운로드
function excelDownload() {
    var targetGroupId = targetGroup.targetGroupId;
    
    qtjs.href('<ifvm:action name="exportExcelTargetGroupTargetList"/>'+"?targetGroupId="+targetGroupId);
}

//세그먼트 팝업 열기
function openSegmentViewPopup() {
    var segmentId = targetGroup.data.segmentId;
    
    if ($.fn.ifvmIsNotEmpty(segmentId)) {
        $("#segmentViewPopup").ifvsfPopup({
    		enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="targetGroupSegmentViewPop"/>?segmentId=' + segmentId,
            contentType: "ajax",
            title: '<spring:message code="M00546" />',
            width: 800,
            close : 'segmentViewPopupClose'
        });
    }
}

//세그먼트 팝업 닫기
function segmentViewPopupClose() {
    segmentViewPopup._destroy();
    $('.tooltip').remove();
}

$(document).ready(function() {
    $.ifvmLnbSetting('targetGroupList');

    initTargetGroupDetail();
    
    //목록
    $('#targetGroupListBtn').on('click', function(){
        targetGroupList();
    });
    
    //컬럼 설정
    $('#columnSetBtn').on('click', function(){
        targetGroupColumnSetPopupOpen();
    });
    
    //엑셀 다운로드
    $('#excelDownloadBtn').on('click', function(){
        excelDownload();
    });
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="M01494" />
        &gt; <spring:message code="M00582" />
    </h1>
</div>

<div id="targetGroupDetail_area">
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00556" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r" id="targetGroupDetailBtn_area">
<!--             <button class="btn btn-sm" id="segmentViewPopupOpenBtn"> -->
<%--                 <i class="fa fa-search"></i><spring:message code="M00546" /> --%>
<!--             </button> -->
            <button class="btn btn-sm" id="targetGroupListBtn">
                <spring:message code="M00002" />
            </button>
        </div>
    </div>
    <div>
        <div class="well form-horizontal underline">
            <div class="row qt_border">
                <label class="col-xs-2 control-label"><spring:message code="M01490"/></label>
                <div class="col-xs-9 control_content">
                    <ifvm:input type="text" required="true" disabled="true" id="targetGroupName" />
                </div>
            </div>
            <div class="row qt_border">
                <label class="col-xs-2 control-label"><spring:message code="M00324"/></label>
                <div class="col-xs-9 control_content">
                    <ifvm:input type="text" required="true" disabled="true" id="targetGroupDesc" />
                </div>
            </div>
            <div class="row qt_border">
                <label class="col-xs-2 control-label"><spring:message code="M01232"/></label>
                <div class="col-xs-9 control_content">
                    <ifvm:input type="text" required="true" disabled="true" id="filterText" />
                </div>
            </div>
            <div class="row qt_border">
                <label class="col-xs-2 control-label"><spring:message code="M01495"/></label>
                <div class="col-xs-9 control_content">
                    <ifvm:input type="text" required="true" disabled="true" id="targetCount" />
                </div>
            </div>
            <%-- 
            <div class="row qt_border">
                <label class="col-xs-2 control-label"><spring:message code="M00846"/></label>
                <div class="col-xs-9 control_content">
                    <ifvm:input type="text" required="true" disabled="true" id="comprGroupDtl" />
                </div>
            </div>
             --%>
        </div>
        <div class="page_btn_area">
		    <div class="col-xs-5">
			    <span><spring:message code="M01217"/></span>
		    </div>
            <div class="col-xs-7 searchbtn_r">
                <button class="btn btn-sm" id="columnSetBtn">
                    <spring:message code="M01496" />
                </button> 
                <button class="btn btn-sm" id="excelDownloadBtn">
                    <spring:message code="M01218" />
                </button> 
            </div>
	   </div>
        <div id="targetGroupTargetListGrid" class="white_bg grid_bd0"></div>
    </div>
</div>
<div id="targetGroupColumnSetPopup"></div>
<div id="segmentViewPopup"></div>
