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
    <!-- SyncFusion Diagram Start -->
    <link href="${pageContext.request.contextPath}/resources/js/scoring/diagram/css/diagrambuilder.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/js/scoring/diagram/css/diagramStyle.css" rel="stylesheet" />

    <script src="${pageContext.request.contextPath}/resources/js/scoring/diagram/js/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scoring/diagram/js/NodeDataClass.js" type="text/javascript"></script>    
    <script src="${pageContext.request.contextPath}/resources/js/scoring/diagram/js/methods.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scoring/diagram/js/events.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scoring/diagram/js/intelligentshapes.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scoring/diagram/js/palettes.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scoring/diagram/js/control.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/scoring/diagram/js/pathseg.js" type="text/javascript"></script>
    <!-- SyncFusion Diagram End -->
    
    <!-- HTML Shape Template -->
    <script id="htmlTemplate" type="text/x-jsrender">
        <div></div>
    </script>
    
    <style>
    
    .e-datavisualization-symbolpalette .e-header-text {
        font-size: 12px;
        font-weight: bold; 
    }
    
    </style>
    
    <script id="campaignNodeTemplate" type="text/x-jquery-tmpl">
        <div id="${'${'}nodeName}${'${'}_Suffix}" class="foreignObject" style="width:152px;height:66px;padding:1px;">
            <div class="box_normal" style="background:${'${'}fillColor};">
                <div class="ic_img" id="icon" > </div>
                    <ul class="list">
                        <li class="title"> ${'${'}title} </li>
                        <li class="dec"> ${'${'}text} </li>
                    </ul>
                </div>
            </div>
        </div>
    </script>
    
<script>
    
//diagram 객체
var diagram;
var symbolpalette;
var minimizedPalette;

var URLcheckCampaignStatusSaveFlag = '<ifvm:action name="checkScoringStatusSaveFlag"/>';
var TXTUseAsTemplate = "<spring:message code='M01381' />";
var TXTCancelTemplate = "<spring:message code='M01382' />";
var TXTOnlyOneNodeCanbeadded  = "<spring:message code='M01028' />";

var strType = '<%= cleanXss(request.getParameter("type")) %>';

//workflow 기본정보
var workflow = {
    id: '',
    workflowName: '',
    workflowDescText: '',
    alertFlag: true
};

//scoring 정보
var scoring = {
    id: '',
    tempid: '',
    statusCode: '',
    templateUseFlag: '0'
};

/**
 * scoring 진행현황 load
 */
function getScoringWorkflowData() {
  $.ifvSyncPostJSON('<ifvm:action name="getScoringWorkflowStatusList"/>', {
       scoringId: scoring.id,
       workflowId: workflow.id
   },
   function(result) {
       setNodeDataByTaskId(result);
   });
}

/**
 * scoring 워크플로우 저장
 */
function saveWorkflow(saveType) {
	//저장 유형 확인
    var saveType = saveType != null ? saveType : "NODE";
	
	//task 노드 및 커넥터 추출
	var task = getNodesAndConnectors(diagram);
	var taskObj = {
			id : workflow.id,
			workflowName : workflow.workflowName,
			workflowDescText : workflow.workflowDescText,
			nodeList : task.nodeList, 
			connectorList : task.connectorList
	};
	
	//노드 데이터 추출
	var nodeData = getAllNodeDataClass(diagram);
	var nodeDataObj = {
			workflowId : workflow.id,
		    scoringId : scoring.id,
		    nodeList : nodeData, 
		    saveType : saveType,
		    workflowTask : taskObj
	};
	console.log("nodeDataObj");
	console.log(nodeDataObj);
	$.ifvSyncPostJSON('<ifvm:action name="saveScoringWorkflow"/>'
	, nodeDataObj
	, function(result) {
 		if (workflow.alertFlag) { 
  			alert("<spring:message code='M01026' />");
 		}
 		
 		//따옴표를 쌍따옴표로 변환
 		var rtnText = result.message.replaceAll("'", '"');
 		
 		//Json Object로 변환
 		var rtnValue = JSON.parse(rtnText);
    
    	//reset remove nodes
    	diagram._removeNodes = [];
    	
    	//message의 워크플로우 Id 확인
    	workflow.id = rtnValue.workflowId;
    
    	//message의 캠페인 Id 확인후 캠페인 워크플로우 데이터 reload
    	scoring.id = rtnValue.scoringId;
    	
    	//데이터 reload
    	getScoringWorkflowData();
	});
}

//템플릿 사용/해제
function scoringWorkflowTempUseBtn() {
	var templateUseFlag = scoring.templateUseFlag == "0" ? "1" : "0";
	$.ifvSyncPostJSON('<ifvm:action name="saveCampaignWorkflowTemplateUse"/>', {
	    scoringId : scoring.id,
	    workflowId : workflow.id,
	    templateUseFlag : templateUseFlag
	},
	function(result) {
		scoring.templateUseFlag = templateUseFlag;
		alert("<spring:message code='M01026' />");
	});
	
	//템플릿 사용/해제 버튼 text 설정
	setScoringWorkflowTempUseBtn(scoring.templateUseFlag);
}

function scoringWorkFlowInit() {
    
    $.ifvmLnbSetting('scoringList');
    
    //캠페인 아이디 설정
    var id = '<%= cleanXss(request.getParameter("id")) %>';
    scoring.id = $.fn.ifvmIsEmpty(id) || id == "null" ? '' : id;
    
    if (isNotEmpty(scoring.id)) {
    	//캠페인 상태가 작업중이 아닐경우 저장 버튼 disabled
    	if (!checkNodeUnauthrized(scoring.id, "INFO")) {
    		$("#scoringWorkflowSaveBtn").attr('disabled',true);
    	}
    }
    
    //캠페인 템플릿 아이디 설정
    var tempid = '<%= cleanXss(request.getParameter("tempid")) %>';
    scoring.tempid = $.fn.ifvmIsEmpty(tempid) || tempid == "null" ? '' : tempid;
    
    // 브라우저 버전 체크
    if (!(ej.browserInfo().name === "msie" && Number(ej.browserInfo().version) < 9)) {
	
	    //팔레트 목록 호출
	    $.ifvSyncPostJSON('<ifvm:action name="getWorkflowPaletteList"/>', {
	    	type : "SCR"
	    },
	    function(result) {
	    	//스코어링에서 사용할 팔레트 
	        setPalettes(result);
	    });
	    
	    //팔레트 생성
	    createPalette();
	    
	    //Temp 구분
	    var items = [];
	    var type = "";
	    var param = {};
	    if ($.fn.ifvmIsNotEmpty(scoring.id)) {
	        type = "SCR";
	        param.parentId = scoring.id;
	    } else {
	        type = "TEMP";
	        param.id = scoring.tempid;
	    }
	    
	    //워크플로우 Task 호출 - parentId: 캠페인 ID
	    $.ifvSyncPostJSON('<ifvm:action name="getWorkflowTask"/>', param,
	    function(result) {
	        //기본정보
	        if ($.fn.ifvmIsNotEmpty(result)) {
	            if (type != "TEMP") {
	                workflow.id = result.id;
	                workflow.workflowName = result.workflowName;
	                workflow.workflowDescText = result.workflowDescText;
	            }
	            
	            //테스크 노드를 가져옴
	            items = result;
	        }
	    });
	    
	    //테스크 노드를 가져옴
	    if ($.fn.ifvmIsNotEmpty(items)) {
	    	items = getTaskNodes(items, type);
	    }
	    
	    //diagram 생성
	    createDiagram(items);
	    
	    //toolbar 생성
	    createTollbar();
	    
	    if ($.fn.ifvmIsNotEmpty(scoring.id)) {
	    	//scoring 데이터 load
	        getScoringWorkflowData();
	    } else {
	    	//신규 캠페인시 설정
	    	setNewCampaignWorkflowNode();
	    }
    
    } else {
        alert('<spring:message code="M01025" />');
    }
}

/**
 * validation 실패 메세지 출력 
 */
function validFailMessage(input, msg) {

    input.addClass('ifv_vali_wrong');
    input.parent().css('position', 'relative');
    
    var valiItem = $("<div class='vali_tooltip'>");
    var valiContent = $("<div class='vali_content'>");
    var valiArrow = $("<div class='vali_arrow'>");
    
    valiItem.append(valiContent);
    valiItem.append(valiArrow);
    
    valiContent.text(msg);

    var offset = input.offset();
    valiItem.css({ left : offset.left, top : offset.top, opacity : 0 });
    $('body').append(valiItem);

    var vwidth = valiItem.outerWidth();
    var vheight = valiItem.outerHeight();

    valiItem.css({ left : offset.left, top:offset.top - vheight - 10, });
    
    valiItem.stop().animate({ opacity : 1 }, 200, function() {
        valiItem.delay( 1000 ).animate({ opacity : 0 }, 50, function() {
            valiItem.remove();
            input.removeClass('ifv_vali_wrong');
        });
    });
}

$(function () {
    $.ifvProgressControl(true);   
    
	scoringWorkFlowInit();
	
	/*
	//템플릿 사용/해제
    $("#scoringWorkflowTempUseBtn").click(function () {
    	workflow.alertFlag = true;
    	scoringWorkflowTempUseBtn();
    });
	*/
	
    //저장
    $("#scoringWorkflowSaveBtn").click(function () {
    	workflow.alertFlag = true;
        saveWorkflow("WF");
    });
    
    //캠페인목록 이동
    $("#scoringListBtn").click(function () {
        qtjs.href('<ifvm:url name="scoringList"/>');
    });
    
    window.onload = function(){
        setTimeout(function(){
          //var t = performance.timing;
          //console.log(t.loadEventEnd - t.responseEnd);
          $.ifvProgressControl(false);
        }, 0);
    }

    $('#Line_header').hide();
    $.ifvProgressControl(false);
});

</script>
<div id="dialog" class="popup_container" style="display:none;"></div>
<div class="page-title">
	<h1>
		<spring:message code="L02250" />
        &gt; <spring:message code="L02251"/>
	</h1>
</div>
    <!-- page_btn_area -->
	<div class="page_btn_area">
	    <div class="col-xs-7">
	        <span><spring:message code="L02250" /></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	    	<%-- <button class="btn btn-sm" id="campaignWorkflowClearBtn">
                <spring:message code="M00278" />
            </button>  --%>
            <%--
            <button class="btn btn-sm" id="scoringWorkflowTempUseBtn" disabled>
                <i class="glyphicon glyphicon-check"></i>
                <span id="scoringWorkflowTempUseBtnText" > <spring:message code="M01381" /></span>
            </button>
            --%>
            <button class="btn btn-sm" id="scoringWorkflowSaveBtn">
            	<i class="glyphicon glyphicon-check"></i>
                <spring:message code="M00307" />
            </button>
            <button class="btn btn-sm" id="scoringListBtn">
				<spring:message code="M01024" />
            </button> 
	    </div>
	</div>
	
    <!-- Header -->
    <div class="sample-header" id="sample-header">
    	
        <div class="sample-header-content">
        	<div id="edit_splitter_palette" class="edit_splitter_leftArrow"></div>
        
            <div class="sample-header-toolbar">
                <div class="Diagram-Toolbar">
                     <div id="toolbarEvents" style="display: none; max-height: 33px;">
                         <ul id="toolblock2" class="toolblock2rightBorderVisible">
                             <li id="ZoomIn_Tool" title="Zoom In" onmouseover="ToolBarMouseOver(this)" onmouseout="ToolBarMouseOut(this)">
                                 <div class="icon-TBi__Zoomin toolBarIconStyle" ></div>
                             </li>
                             <li id="ZoomOut_Tool" title="Zoom Out" onmouseover="ToolBarMouseOver(this)" onmouseout="ToolBarMouseOut(this)">
                                 <div class="icon-TBi__Zoomout toolBarIconStyle" ></div>
                             </li>
                             <li id="FitToPage_Tool" title="Fit To Page" onmouseover="ToolBarMouseOver(this)" onmouseout="ToolBarMouseOut(this)">
                                 <div class="icon-TBi__FitToPage toolBarIconStyle" ></div>
                             </li>
						</ul><ul id="toolblock3" class="toolblock3rightBorderVisible">
                             <li id="Pan_Tool" title="Pan" onmouseover="ToolBarMouseOver(this)" onmouseout="ToolBarMouseOut(this)">
                                 <div class="icon-TBi__pan toolBarIconStyle" ></div>
                             </li>
                             <li id="MoveTool_Tool" title="Pointer" onmouseover="ToolBarMouseOver(this)" onmouseout="ToolBarMouseOut(this)" class="focus">
                                 <div class="icon-TBi__MoveTool toolBarIconStyle" ></div>
                             </li>
                         </ul>
                     </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Layout 설정 -->
    <div class="sample-main">
        
        <div id="main-left">
            <div id="symbolpalette" style="width:100px; height:100%;"></div>
            <div id="minimizedPalette" style="width:100px; height:100%;"></div>
        </div>
        
        <div class="middle_section"></div>
        
        <div id="main-right" class="width: 100%; height: 100%">
            <div id="diagram"></div>
        </div>
    </div>
    
    <div id="Overview-div" class="Overview-div" style="width: 253px; float: left; display: none">
        <div id="Overview"></div>
        <table cellpadding="3">
            <tr>
                <td><span class="sliderValue"></span></td>
                <td>
                    <div id="overviewSlider"></div>
                </td>
            </tr>
        </table>
    </div>
