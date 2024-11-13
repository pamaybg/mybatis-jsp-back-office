<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var campaignProgramListGrid;
//프로그램 목록
function getCampaignProgramList(){
    
    var jqGridOption = {
   		loadComplete : function(obj){
   			//popup 높이 맞추기
 			new ifvm.PopupHeight({
 				popupDivId : 'programPop',
 				contentsId : 'dialogProgPopupWrap'
 			});
   		},
    	onSelectRow : function (data) {
        	
        },
        serializeGridData : function( data ){
        	
        },
        url : '<ifvm:action name="getCampaignProgramList"/>',
        colNames:[ '<spring:message code="M00782"/>',
                   '<spring:message code="M00780"/>',
                   '<spring:message code="M00765"/>',
                   'id'
                 ],
        colModel:[
            { name:'campaignProgramNo', index:'p.CAM_PROG_NO', resizable : false },
            { name:'campaignProgramName', index:'p.CAM_PROG_NM', resizable : false },
            { name:'campaignProgramDesc', index:'p.CAM_PROG_DESC', resizable : false },
            { name:'id', index:'p.id', hidden : true }
        ],
        sortname: 'p.MODIFY_BY',
        sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    campaignProgramListGrid = $("#campaignProgramListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	getCampaignProgramList();
	
	//등록 클릭시
    $('#campaignProgramPopAddBtn').on('click', function(){
    	var campaignProgramPopValidation = $("#campaignProgramPop").ifvValidation();
    	
    	if (campaignProgramPopValidation.confirm()) {
	    	var campaignProgramName = $("#camProgramName").val();
	    	var campaignProgramDesc = $("#camProgramDesc").val();
	    	
	    	$.ifvSyncPostJSON('<ifvm:action name="addCampaignProgram"/>', {
	    		campaignProgramName: campaignProgramName, campaignProgramDesc: campaignProgramDesc
	        },
	        function(result) {
	        	$("#programName").val('');
	            $("#programDesc").text('');
	            getCampaignProgramList();
	        });
    	}
    });
    
    //삭제 클릭시
    $('#campaignProgramPopRemoveBtn').on('click', function(){
    	
    	var rowNo = campaignProgramListGrid.getCheckedRowIds();
    	
    	if( rowNo.length != 0 ) {
	        var id = campaignProgramListGrid.getRowData()[rowNo-1].id;
	        $.ifvSyncPostJSON('<ifvm:action name="removeCampaignProgram"/>', {
	            id : id
	        },
	        function(result) {
	            getCampaignProgramList();
	        });
    	} else {
    		alert( "<spring:message code='M00911' />" );
    	}
    });
    
    //선택 클릭시
    $('#campaignProgramPopSelectBtn').on('click', function(){
    	var rowNo = campaignProgramListGrid.getCheckedRowIds();
        var id = campaignProgramListGrid.getRowData()[rowNo-1].id;
        var name = campaignProgramListGrid.getRowData()[rowNo-1].campaignProgramName;
        
        //기본정보Pop 프로그램 ID/명 설정
    	campaignDefaultInfo.camDefaultInfo.programId = id;
    	$("#programName").val(name);
    	
    	programPop._destroy();
    });
    
    //취소 클릭시
    $('#campaignProgramPopCancelBtn').on('click', function(){
    	programPop._destroy();
    });
    
    
});
</script>

<div id="dialogProgPopupWrap">
	<div class="pop_inner_wrap form-horizontal" id="campaignProgramPop" >
		<header class="temp_title_bb">
			<spring:message code="M00779"/>
			<button class="btn_pop_white pop_top_btn" id="campaignProgramPopAddBtn" >
				<img src="<ifvm:image name='ico_input'/>" alt="" />
				<spring:message code="M00767"/>
			</button>
		</header>
        <div class="row qt_border">
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00780"/></label>
            <div class="col-xs-10 control_content">
                <ifvm:input type="text" required="true" id="camProgramName" />
            </div>
        </div>
        <div class="row qt_border">
            <label class="col-xs-2 control-label"><spring:message code="M00600"/></label>
            <div class="col-xs-10 control_content">
                <ifvm:input type="textarea" rows="2" id="camProgramDesc" />
            </div>
        </div>
        
        <header class="temp_title">
			<spring:message code="M00768"/>
			<button class="btn_pop_white pop_top_btn" id="campaignProgramPopRemoveBtn" >
				<img src="<ifvm:image name='btn_delete'/>" alt="" />
				<spring:message code="M00275"/>
			</button>
		</header>
        <div id="campaignProgramListGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="campaignProgramPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="campaignProgramPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>