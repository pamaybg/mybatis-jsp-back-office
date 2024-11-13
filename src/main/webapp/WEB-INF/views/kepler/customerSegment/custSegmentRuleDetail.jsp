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
<link href="${pageContext.request.contextPath}/resources/js/kepler/diagram/css/diagramStyle.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/util.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/NodeDataClass.js" type="text/javascript"></script>    
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/methods.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/events.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/palettes.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/control.js" type="text/javascript"></script>
<jsp:include page="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/template.jsp" />
<!-- SyncFusion Diagram End -->

<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />
<style>
   .helpBtn {
      background-image: url("/resources/images/icons/btn_help.png");
      background-repeat:no-repeat;
       background-position:center center;
       padding-left: 30px;
       vertical-align: middle;
       width: 17px;
       height: 17px;
       line-height: 17px;
   }
</style>
<script>
//다이어그램 유형
diagramType = "SEG";
var segmentFlag = true;
custRuleText=null;
diagramSubType = "CSSEG"

//고객 세분화 룰 생성시 텍스트
function setCustRuleTxt(segFilterIdForTxt){
	custRuleText=null;
	$.ifvPostJSON('<ifvm:action name="getCustRuleNmForTxt"/>', {
	  	  segFilterId: segFilterIdForTxt
	   }
	   , function(result) {
	      
	      if (isNotEmpty(result)) {
	      	  custRuleText=result.tgtGroupNm;
	      	if(custRuleText!=null){
	      	  
			  	$('<div class="tooltip"></div>')
        		.html("고객 세분화 룰 명 : "+custRuleText)
        		.appendTo('body')
        		.fadeIn('slow');
			}
	      }else{
	    		$('<div class="tooltip"></div>')
        		.html("생성된 고객 세분화 룰 없음")
        		.appendTo('body')
        		.fadeIn('slow');
			}
	    }, function(result) {
	    	custRuleText=null;
	    });
}

var segment = {
        segmentId: ''
        , logicalCompId: ''
        , selectedAtribGroupColId: ''
        , originalData: {}
} 

//세그먼트 데이터 설정
function initSegmentDetail() {
    var segmentId = '<%= cleanXss(request.getParameter("segmentId")) %>';
    segment.segmentId = $.fn.ifvmIsEmpty(segmentId) || segmentId == "null" ? '' : segmentId;
    
    if ($.fn.ifvmCheckBrowserForDiagram()) {
    
        //다이어그램 생성
        var items = [];
        createDiagram(items);
        
        //세그먼트 조회
        getSegmentDetail();
        
    	setTimeout(function(){
    	    //context menu 생성
    	    setContextMenu();
    	}, 100);
    
    }
}

//context menu 생성
function setContextMenu() {
    var data = [
                {id: "MENU_filterEdit", name: "<spring:message code='M01475' />"},
                {id: "MENU_filterReset", name: "<spring:message code='M00808' />"},
                {id: "MENU_filterSql", name: "<spring:message code='M01192' />"},
                {id: "MENU_remove", name: "<spring:message code='M00831' />"},
                //{id: "MENU_targtGroup", name: "<spring:message code='M01481' />"},
                {id: "MENU_custSegRule", name: "고객세분화 룰 생성"}
        ];
    
        
    //context menu 생성
    createContextMenu("segmentContextMenu", "diagram", data);
}

//세그먼트 상세 조회
function getSegmentDetail() {
    if (isNotEmpty(segment.segmentId)) {
        
        $.ifvPostJSON('<ifvm:action name="getSegmentDetail"/>', {
            segmentId: segment.segmentId
        }
        , function(result) {
            if (isNotEmpty(result)) {
                segment.originalData = result;
                setSegmentDetail(result);
            }
        }
        , function(result) {
            segmentMessageCheckr(result.message);
        });
    }
}

//세그먼트 상세 설정
function setSegmentDetail(data) {
    
    //세그먼트명
    $("#txt_segmentName").text(data.segmentName);
    
    //설명
    if ($.fn.ifvmIsNotEmpty(data.segmentDesc)) {
    	$("#txt_segmentDesc").html("&nbsp;>>&nbsp;" + data.segmentDesc);
    	$("#txt_segmentDesc").show();
    } else {
        $("#txt_segmentDesc").hide();
    }
    
    //로지컬 컴포넌트명
    $("#logicalCompName").val(data.logicalCompName);
    
    //로지컬 컴포넌트
    if (isNotEmpty(data.logicalCompId)) {
    	setLogicalCompGroupAcrdnTree(data.logicalCompId);
    	segment.logicalCompId = data.logicalCompId;
    }
    
    //필터 노드 설정
    $.each(data.filterList, function(index, data) {
        setFilterNode(data);
    });
    
    //필터 커넥터 설정
	$.each(data.filterRelList, function(index, data) {
	    setFilterRelConnetor(data);
    });
    
  	//필터 조합 노드 텍스트 설정
    setFilterCombiNodeText();
    
    //선택 해제
    diagram.clearSelection();
}

//필터 노드 설정
function setFilterNode(data) {
    // node 생성
    var node = {};
    
    node.name = data.segFilterId;
    node.offsetX = data.offSetX;
    node.offsetY = data.offSetY;
        
    // NodeDataClass 생성
    var nodeData = new NodeDataClass();
    nodeData.nodeId = node.name;
    nodeData.htmlTemplateId = "segmentNodeTemplate";
    nodeData.data = data;
    
    var colType = data.atribGroupColType;
    nodeData.nodeType = colType;
    
    //어트리뷰트 그룹 컬럼 유형;  D: dimension, M: Measure, C: "Combination", A: "All Count"
    if (colType == "D") {
        nodeData.attributeType = "attribute_filter";
    }
    else if (colType == "M") {
        nodeData.attributeType = "attribute_member";
    }
    else if (colType == "A") {
        nodeData.attributeType = "attribute_all";
    }
    else if (colType == "C") {
        nodeData.attributeType = "attribute_combi";
    }
    else {
        nodeData.attributeType = "attribute_filter";
    }
    
    var operatCodeName  = $.fn.ifvmIsNotEmpty(data.operatCodeName) ? data.operatCodeName : "";
    var filterValue  = $.fn.ifvmIsNotEmpty(data.filterValue) ? data.filterValue : "";
    
    nodeData.data.filterText = operatCodeName + " " + filterValue;
    
    if ($.fn.ifvmIsNotEmpty(data.groupFuncTypeCode)) {
        if ("COUNT(DISTINCT)" == data.groupFuncTypeCode) {
            nodeData.data.filterText = "COUNT(DISTINCT " + data.displayName + ") " + nodeData.data.filterText;
        } else {
        	nodeData.data.filterText = data.groupFuncTypeCode + " (" + data.displayName + ") " + nodeData.data.filterText;
        }
    }
    
  	//필터 카운트
    nodeData.data.filterCount = $.fn.ifvmNumberWithCommas(data.filterCount);
    nodeData.diagramType = diagramType;
    node.addInfo = nodeData;
    
    // 노드 생성
    renderNode(node);
}

//필터 조합 노드 텍스트 설정
function setFilterCombiNodeText() {
    var deftNode = findNodeByNodeType("A")[0];
    if ($.fn.ifvmIsNotEmpty(deftNode)) {
        //하위 노드 추출
        var childNodes = getChildNode(deftNode.name);
        for(var i=0; i < childNodes.length; i++) {
            var node = childNodes[i];
            var data = node.addInfo.data;
            
            var combFilterText = getFilterCombiNodeText(data);
          	
            //조합필터일경우 텍스트 설정
	        if (combFilterText.success) {
	            //텍스트 설정
	   			data.filterText = combFilterText.filterText;
	   			data.filterText2 = combFilterText.filterText2;
	   			
	   			//템플릿 재설정
	   			diagram._updateNode(node.name, {templateId: "segmentNodeTemplate"} );
	   			
	   			//노드 높이 재설정
	   			var height = $("#" + node.addInfo.nodeId + node.addInfo._Suffix).height()+2;
	   			diagram._updateNode(node.name, {height: height} );
	       }
            
	        $.merge(childNodes, getChildNode(node.name));
        }
    }
}

//조합필터 텍스트 추출
function getFilterCombiNodeText(data) {
    var rtnValue = {
            filterText: ""
            , filterText2: ""
            , success: false
    };
    
    if ($.fn.ifvmIsNotEmpty(data.combFilterAId) && $.fn.ifvmIsNotEmpty(data.combFilterBId)) {
        var text = "";
           //필터A
	    	var nodeA = diagram.getNode(data.combFilterAId);
	    	if ($.fn.ifvmIsNotEmpty(nodeA)) {
	    	    var dataA = nodeA.addInfo.data;
	    	    //필터 텍스트가 있을경우
    	    	if ($.fn.ifvmIsNotEmpty(dataA.filterText)) {
        		    var displayName = $.fn.ifvmIsNotEmpty(dataA.displayName) ? dataA.displayName : "";
        		    var textA = displayName + " " + dataA.filterText; 
        		    
        		    //필터 텍스트2가 있을 경우
        		    if ($.fn.ifvmIsNotEmpty(dataA.filterText2)) {
        		        textA = textA + ", " + dataA.filterText2;
        		    }
        		    
        		    rtnValue.filterText = textA;
        		} else {
       	        	var displayName = $.fn.ifvmIsNotEmpty(dataA.displayName) ? dataA.displayName : "";
       	        	var operatCodeName = $.fn.ifvmIsNotEmpty(dataA.operatCodeName) ? dataA.operatCodeName : "";
       	    		var filterValue = $.fn.ifvmIsNotEmpty(dataA.filterValue) ? dataA.filterValue : "";
       	        	var textA = displayName + " " + operatCodeName + " " + filterValue;
       	        	
       	        	rtnValue.filterText = textA;
        		}
	    	}
	    
	    	//필터B
	    	var nodeB = diagram.getNode(data.combFilterBId);
			if ($.fn.ifvmIsNotEmpty(nodeB)) {
		    	var dataB = nodeB.addInfo.data;
		    	if ($.fn.ifvmIsNotEmpty(dataB.filterText)) {
		    	    var displayName = $.fn.ifvmIsNotEmpty(dataB.displayName) ? dataB.displayName : "";
		    	    var textB = displayName + " " + dataB.filterText;
		    	    
		    	    if ($.fn.ifvmIsNotEmpty(dataB.filterText2)) {
        		        textB = textB + ", " + dataB.filterText2;
        		    }
	    			
		    	    rtnValue.filterText2 = textB;
		    	} else {
	   		    	var displayName = $.fn.ifvmIsNotEmpty(dataB.displayName) ? dataB.displayName : "";
	   	        	var operatCodeName = $.fn.ifvmIsNotEmpty(dataB.operatCodeName) ? dataB.operatCodeName : "";
	   	    		var filterValue = $.fn.ifvmIsNotEmpty(dataB.filterValue) ? dataB.filterValue : "";
	   	        	var textB = displayName + " " + operatCodeName + " " + filterValue;
	   	        	
	   	        	rtnValue.filterText2 = textB;
		    	}
	    	}
			
			rtnValue.success = true;
    }
    
    return rtnValue;
}

//필터 관계 커넥터 설정
function setFilterRelConnetor(data) {
    var sourceNode = data.segFilterId;
    var targetNode = data.childFilterId;
    
    if (isNotEmpty(sourceNode) && isNotEmpty(targetNode)) {
        var nodeData = new NodeDataClass();
        nodeData.nodeId = data.segFilterRelId;
        nodeData.nodeType = "CONNECTOR";
        nodeData.data = data;
        
        var connector = {
                name: data.segFilterRelId,
                sourceNode: sourceNode,
                targetNode: targetNode,
                addInfo: nodeData
        }
        
        diagram.add(connector);
    }
}

//로지컬컴포넌트 트리 목록 조회
function setLogicalCompGroupAcrdnTree(logicalCompId) {
    if ($.fn.ifvmIsNotEmpty(logicalCompId)) {
        var logicalCompTreeData = [];
        
        //로지컬컴포넌트 트리 목록 조회
        $.ifvPostJSON('<ifvm:action name="getLogicalComponentTreeList"/>', {
            logicalCompId: logicalCompId
        },
        function(result) {
            if (result.length > 0 ) {
                logicalCompTreeData = result;
                
                var fields = {
                        "id": "id",
                        "text": "text",
                        "parentId": "parentId",
                        "colType": "colType"
                };
                
                //아코디언트리 생성
                createAccordionTree("logicalCompGroupAcrdn", logicalCompTreeData, fields, "#ifvAttributeGroupColumnTreeViewTemplate");
            }
        });
    }
}

//로지컬 컴포넌트 아코디언 트리 사이즈 설정
function setLogicalCompGroupAcrdnSize() {
    var height = $("#diagram").outerHeight() - $(".ans_top row").outerHeight() - 40;
    $("#logicalCompGroupAcrdn").css("height", height);
}

//세그먼트 필터 설정 팝업 열기
function segmentFilterSetPopOpen(atribGroupColId) {
    segment.selectedAtribGroupColId = atribGroupColId;
    
    if (isNotEmpty(atribGroupColId)) {
        $("#segmentFilterSetPopup").ifvsfPopup({
    		enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="segmentFilterSetPop_KPR"/>',
            contentType: "ajax",
            title: '<spring:message code="M01187" />',
			width: 980,
            close : 'segmentFilterSetPopupClose'
        });
    }
}

//세그먼트 필터 설정 팝업 닫기
function segmentFilterSetPopupClose() {
    segmentFilterSetPopup._destroy();
    
    if (diagram._selectedObject.data.dataStatus == "I") {
        diagram.remove();
    }
}

//세그먼트 필터 조합 팝업 열기
function segmentFilterCombiPopOpen(filterId) {
    $("#segmentFilterCombiPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="segmentFilterCombiPop_KPR"/>',
        contentType: "ajax",
        title: '<spring:message code="M01482" />',
        width: 550,
        close : 'segmentFilterCombiPopupClose'
    });
}

//세그먼트 필터 조합 팝업 닫기
function segmentFilterCombiPopupClose() {
    segmentFilterCombiPopup._destroy();
    
    if (diagram._selectedObject.data.dataStatus == "I") {
        diagram.remove();
    }
}

//로지컬컴포넌트 목록 팝업 열기
function logicalComponentListPopupOpen() {
    $("#logicalComponentListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="commonLogicalComponentListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01474" />',
        width: 640,
        close : 'logicalComponentListPopupClose'
    });
}

//로지컬컴포넌트 목록 팝업 닫기
function logicalComponentListPopupClose() {
    logicalComponentListPopup._destroy();
}

//로지컬컴포넌트 목록 팝업 확인 클릭시
function logicalComponentListPopConfirm() {
    //로지컬 컴포넌트 아이디 확인
    if ($.fn.ifvmIsNotEmpty(logicalComponentListGrid.getCheckedList())) {
        if (confirm('<spring:message code="M01477"/>')) {
            //다이어그램 초기화
            setDiagramClear();
            
            var logicalCompId = logicalComponentListGrid.getCheckedList()[0].logicalCompId;   //로지컬 컴포넌트 아이디
            var logicalCompName = logicalComponentListGrid.getCheckedList()[0].logicalCompName;	//로지컬 컴포넌트명
            var segmentId = segment.segmentId;
            
            $.ifvProgressControl(true);
            
            //세그먼트 로지컬컴포넌트 아이디 변경
            $.ifvPostJSON('<ifvm:action name="editSegmentLogicalComponentId"/>', {
                segmentId: segmentId, logicalCompId: logicalCompId
            },
            function(result) {
              	//로지컬컴포넌트 아이디 설정
                segment.logicalCompId = logicalCompId;
                
                //로지컬컴포넌트명 input 입력
                $("#logicalCompName").val(logicalCompName);
              	
              	//로지컬컴포넌트 트리 목록 조회
                setLogicalCompGroupAcrdnTree(logicalCompId);
              	
              	//워크플로우 초기화
                clearSegmentWorkflow();
              	
              	//세그먼트 재설정
                getSegmentDetail();
              	
                $.ifvProgressControl(false);
                
                //팝업 닫기
                logicalComponentListPopupClose();
                    
            },
            function(result) {
              	//로지컬컴포넌트 아이디 설정
                segment.logicalCompId = logicalCompId;
                
                //로지컬컴포넌트명 input 입력
                $("#logicalCompName").val(logicalCompName);
              	
              	//로지컬컴포넌트 트리 목록 조회
                setLogicalCompGroupAcrdnTree(logicalCompId);
              	
              	//워크플로우 초기화
                clearSegmentWorkflow();
              	
              	//세그먼트 재설정
                getSegmentDetail();
              	
                $.ifvProgressControl(false);
                
                //팝업 닫기
                logicalComponentListPopupClose();
                
                segmentMessageCheckr(result.message); 
            });
        }
        
    } else {
        alert('<spring:message code="M01471"/>');
    }
}

//워크플로우 초기화
function clearSegmentWorkflow() {
    diagram.clear();
    diagram._removeNodes = [];
    diagram._removeConnectors = [];
}

//타겟그룹 생성 팝업 열기
function targetGroupNewPopupOpen() {
    $("#targetGroupNewPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="targetGroupNewPop_KPR"/>',
        contentType: "ajax",
        title: '<spring:message code="M01489" />',
        width: 550,
        close : 'targetGroupNewPopupClose'
    });
}

//타겟그룹 생성 팝업 닫기
function targetGroupNewPopupClose() {
    targetGroupNewPopup._destroy();
}

//커넥터의 세그먼트 관계 데이터 추출
function getChildFilterRelListData(name) {
    var filterRelList = [];
    
    //노드    
    var node = diagram.getNode(name);
    
    //연결 커넥터 목록
    $.each(node.inEdges, function(index, edge) {
        
        //커넥터 확인
        var cnntr = diagram.getNode(edge);
        
        if (isNotEmpty(cnntr)) {
            var sNode = diagram.getNode(cnntr.sourceNode);
            if (sNode.addInfo.nodeType != 'DEFAULT') {
                var filterRel = {};
                filterRel.segFilterRelId = cnntr.name;
                filterRel.childFilterId = cnntr.targetNode;
                filterRel.segFilterId = cnntr.sourceNode;
                filterRel.segmentId = segment.segmentId;
              	filterRel.dataStatus = node.addInfo.data.dataStatus;
                filterRelList.push(filterRel);
            }
        }
    });
    
    return filterRelList;
}

//첫번째 필터 노드인지 확인
function checkFirstFilter(name) {
    var checkFlag = false;
    var node = diagram.getNode(name);
    
    //연결 커넥터 목록
    $.each(node.inEdges, function(index, edge) {
        
        //커넥터 확인
        var cnntr = diagram.getNode(edge);
        
        if (isNotEmpty(cnntr) && !checkFlag) {
            var sNode = diagram.getNode(cnntr.sourceNode);
            if (sNode.addInfo.data.filterTypeCode == 'ALL') {
                checkFlag = true;
            }
        }
    });
    
    return checkFlag;
}

//세그먼트 저장
function saveSegment() {
    var data = {};
    data.segmentName = segment.originalData.segmentName;
    data.segmentDesc = segment.originalData.segmentDesc;
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
        alert('<spring:message code="M00295" />');
        
        $.ifvProgressControl(false);
    }
 	, function(result) {
 	    $.ifvProgressControl(false);
 	   
 	    segmentMessageCheckr(result.message)
    });
}

//세그먼트 필터 삭제
function removeFilter(data) {
    var filterData = data;
    filterData.dataStatus = "D";
    
    var filterRelList = [];
    $.each(diagram._removeConnectors, function(index, cnntr) {
       if(isNotEmpty(cnntr.addInfo.data)) {
			var data = cnntr.addInfo.data;
			data.dataStatus = "D";
			filterRelList.push(data);
       }
    });
    
    filterData.filterRelList = filterRelList;
    
    $.ifvProgressControl(true);
    
    $.ifvPostJSON('<ifvm:action name="saveSegmentFilter"/>', filterData
    , function(result) {
        $.ifvProgressControl(false);
        
        alert('<spring:message code="M00590" />');
		diagram._removeNodes = [];
		diagram._removeConnectors = [];
    }
 	, function(result) {
 	    $.ifvProgressControl(false);
 	   
 	    segmentMessageCheckr(result.message)
    });
}

//전체 세그먼트 새로고침
function setSegmentRefresh() {
    /*var segmentId = segment.segmentId;
    var logicalCompId = segment.logicalCompId;
    
    $.ifvProgressControl(true);
    
    $.ifvPostJSON('<ifvm:action name="resetAllSegmentFilterCount"/>', {
        segmentId: segmentId, logicalCompId: logicalCompId
    }
    , function(result) {
      	
    	//워크플로우 초기화
        clearSegmentWorkflow();
      	
      	//세그먼트 재설정
        getSegmentDetail();
      	
        $.ifvProgressControl(false);
    }
 	, function(result) {
 	    $.ifvProgressControl(false);
 	   
 	    segmentMessageCheckr(result.message);
    });
    */
    
    //전체 노드 추출
	$.each(diagram.nodes(), function(index, node) {
	    if (isNotEmpty(node.addInfo.nodeId)) {
	    	//세그먼트 새로고침
	    	resetSegmentFilterCount(node.addInfo.nodeId);
	    }
	});
    
}

//세그먼트 새로고침
function resetSegmentFilterCount(segFilterId) {
    var segmentId = segment.segmentId;
    var logicalCompId = segment.logicalCompId;
    
    $.ifvProgressControl(true, $("#" + segFilterId + "_inhtml"));
    
    $.ifvPostJSON('<ifvm:action name="resetSegmentFilterCount"/>', {
        segmentId: segmentId, logicalCompId: logicalCompId, segFilterId: segFilterId
    }
    , function(result) {
      	
      	//필터 건수 설정
        var node = diagram.getNode(segFilterId);
        node.addInfo.data.filterCount =  $.fn.ifvmNumberWithCommas(result.message);
        
        diagram._updateNode(segFilterId, {templateId: "segmentNodeTemplate"} );
      	
        $.ifvProgressControl(false, $("#" + segFilterId + "_inhtml"));
    }
 	, function(result) {
 		$.ifvProgressControl(false, $("#" + segFilterId + "_inhtml"));
 	   
 	    segmentMessageCheckr(result.message);
    });
}

//세그먼트 메세지 확인
function segmentMessageCheckr(str) {
    var isMessage = false;
    switch( str ){
    	case 'MSG_S0001' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0001 );
    		isMessage = true;
    	break;
    	
    	case 'MSG_S0002' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0002 );
    		isMessage = true;
    	break;
    	
    	case 'MSG_S0003' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0003 );
    		isMessage = true;
    	break;
    	
    	case 'MSG_S0004' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0004 );
    		isMessage = true;
    	break;
    	
    	case 'MSG_S0005' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0005 );
    		isMessage = true;
    	break;
    	
    	case 'MSG_S0006' :
    		$.ifvErrorPop( MESSAGE.kepler.segment.error_MSG_S0006 );
    		isMessage = true;
    	break;
    }
    
    if (!isMessage)
    	$.messageCheckr(str);
    
}

//세그먼트 목록 화면 이동
function goSegmentList() {
    var url = '<ifvm:url name="custSegmentRuleListNew"/>';
    qtjs.href(url);
}

//타겟그룹 생성 팝업 열기
function filterSqlPopupOpen(node) {
    $("#filterSqlPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="segmentFilterSqlPop_KPR"/>',
        contentType: "ajax",
        title: '<spring:message code="M01192" />',
        width: 700,
        close : 'filterSqlPopupClose'
    });
}

//타겟그룹 생성 팝업 닫기
function filterSqlPopupClose() {
    filterSqlPopup._destroy();
}

//세그먼트명 변경 팝업 열기
function segmentNameEditPopupOpen() {
    
    $("#segmentNameEditPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="segmentNameEditPop_KPR"/>',
        contentType: "ajax",
        title: '<spring:message code="M00680" /> / <spring:message code="M00765" />',
        width: 600,
        close : 'segmentNameEditPopupClose'
    });
    
    segmentNameEditPopup.open();
}

//세그먼트명 변경 팝업 닫기
function segmentNameEditPopupClose() {
    segmentNameEditPopup._destroy();
}


//고객 세분화 룰 생성 팝업
function custSegmentRulePopupOpen(node) {
    $("#custsegmentRulePopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="custSegmentRulePop"/>',
        contentType: "ajax",
        title: '고객 세분화 룰 생성',
        width: 700,
        close : 'custSegmentRulePopupClose'
    });
}

//고객 세분화 룰 생성 팝업 닫기
function custSegmentRulePopupClose() {
	custsegmentRulePopup._destroy();
}



$(document).ready(function() {

    $.ifvmLnbSetting('custSegmentRuleListNew');
    
    $.ifvProgressControl(true);
    
    
    //세그먼트 상세
    initSegmentDetail();
    
    //로지컬컴포넌트 목록 팝업 열기
    $('#lgcCompNamePopOpen').on('click', function(){
        logicalComponentListPopupOpen();
    });
    
    //저장 버튼
    $('#segmentSaveBtn').on('click', function(){
        saveSegment();
    });
    
    //새로고침 버튼
    $('#segmentRefreshBtn').on('click', function(){
        setSegmentRefresh();
    });
    
    //목록 버튼
    $('#segmentListBtn').on('click', function(){
        goSegmentList();
    });
    
    //세그먼트명 변경
    $('#segmentNameEditBtn').on('click', function(){
        segmentNameEditPopupOpen();
    });
    
    $(window).bind('resize', function () {
        //로지컬 컴포넌트 리사이즈
        setLogicalCompGroupAcrdnSize();
    });
    
    window.onload = function(){
        setTimeout(function(){
          $.ifvProgressControl(false);
        }, 0);
    }
    
    $.ifvProgressControl(false);
    
    
	$('.helpBtn').setupHelpMessage();
	
});

</script>

<div class="page-title">
	<h1>
		 고객 세분화 Rule 등록 &gt; <spring:message code="M00136" />
	</h1>
</div>
<div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00556" /> &gt; <b id="txt_segmentName"> </b><b id="txt_segmentDesc" style="display:none;"></b> </span>
			<a><i class="helpBtn" style="vertical-align: middle;">
	             <div class="helptxt" style="display:none;">
	             	<spring:message code="D10307"/>
	             </div>
	        </i></a>
	</div>
	<div class="col-xs-5 searchbtn_r" >
        <button class="btn btn-sm" id="segmentNameEditBtn"objCode="segmentNameEditBtn_OBJ">
            <spring:message code="M01450" />
        </button> 
        <button class="btn btn-sm" id="segmentRefreshBtn" objCode="segmentRefreshBtn_OBJ">
            <spring:message code="M00808" />
        </button> 
        <button class="btn btn-sm" id="segmentSaveBtn" objCode="segmentSaveBtn_OBJ">
        	<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00137" />
        </button>
        <button class="btn btn-sm" id="segmentListBtn" objCode="segmentListBtn_OBJ">
            <spring:message code="M00002" />
        </button> 
    </div>
</div>


<div class="analysis_wrap clear_wrap"> 
	<div class="analysis_tree">
		<div class="ans_top row">
			<label class="col-xs-3"><spring:message code="M02956" /></label>
			<div class="col-xs-9">
				<div class="input-group">
                    <ifvm:input type="text" id="logicalCompName" names="logicalCompName" disabled="true" />
                    <span class="input-group-addon" id="lgcCompNamePopOpen">
                        <a><i class="fa fa-search"></i></a>
                    </span> 
                </div>
			</div>
		</div>
	    <div id="logicalCompGroupAcrdn" class="acrdn_scroll_01 logical_component_tree"></div>
	</div>
	<div class="dashboard_wrap chart_wrap">
        <div id="diagram" >
        </div>
		<!-- <div class="dashboard_area" id="dashboardArea">
			<p class="txt_dashboard"><strong>선택된 테이블이 없습니다.</strong><br /> 
            테이블 선택 후<br />해당 영역으로 드래그해서 추가해 주세요.</p>
		</div> -->
	</div>
</div>
</div>
<div id="logicalComponentListPopup"></div>
<div id="segmentFilterSetPopup" class="popup_container"></div>
<div id="segmentFilterCombiPopup"></div>
<div id="targetGroupNewPopup"></div>
<div id="segmentNameEditPopup"></div>
<div id="filterSqlPopup"></div>
<div id="custsegmentRulePopup"></div>
<ul id="segmentContextMenu" class="right_mou_list" ></ul>