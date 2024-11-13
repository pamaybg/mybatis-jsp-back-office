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

<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<!-- SyncFusion Diagram Start -->
<link href="${pageContext.request.contextPath}/resources/js/kepler/segment/css/diagramStyle.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/js/kepler/segment/util.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/segment/NodeDataClass.js" type="text/javascript"></script>    
<script src="${pageContext.request.contextPath}/resources/js/kepler/segment/methods.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/segment/events.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/segment/control.js" type="text/javascript"></script>
<jsp:include page="${pageContext.request.contextPath}/resources/js/kepler/segment/template.jsp" />



<script>
//다이어그램 유형
diagramType = "TGT_GROUP";

var segmentFlag = true;

var segment = {
        segmentId: ''
        , logicalCompId: ''
        , selectedAtribGroupColId: ''
        , originalData: {}
}

var segmentViewPopObj;

function setSegmentViewPopObj() {
    this.kprCon = new keplerDiagramControl();
    this.kprEvt = new keplerDiagramEvent();
    this.kprMeth = new keplerDiagramMethods();
}

//세그먼트 데이터 설정
function initSegmentDetail() {
    var _this = segmentViewPopObj;
    
    var segmentId = '<%= cleanXss(request.getParameter("segmentId")) %>';
    segment.segmentId = $.fn.ifvmIsEmpty(segmentId) || segmentId == "null" ? '' : segmentId;
    
    //다이어그램 생성
    var items = [];
    _this.kprCon.createDiagram("KPRDiagram", items);
    
    //세그먼트 조회
    getSegmentDetail();
}

//context menu 생성
function setContextMenu() {
    var _this = segmentViewPopObj;
    
    var data = [
                {id: "MENU_filterEdit", name: "<spring:message code='M01475' />"},
                {id: "MENU_remove", name: "<spring:message code='M00831' />"},
                {id: "MENU_targtGroup", name: "<spring:message code='M01481' />"}
        ];
        
    //context menu 생성
    _this.kprCon.createContextMenu("segmentContextMenu", "KPRDiagram", data);
}

//세그먼트 상세 조회
function getSegmentDetail() {
    if ($.fn.ifvmIsNotEmpty(segment.segmentId)) {
        
        $.ifvPostJSON('<ifvm:action name="getSegmentDetail"/>', {
            segmentId: segment.segmentId
        }
        , function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
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
    //로지컬 컴포넌트
    if ($.fn.ifvmIsNotEmpty(data.logicalCompId)) {
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
    KPRDiagram.clearSelection();
}

//필터 노드 설정
function setFilterNode(data) {
    var _this = segmentViewPopObj;
    
    // node 생성
    var node = {};
    node.name = data.segFilterId;
    node.offsetX = data.offSetX;
    node.offsetY = data.offSetY;
        
    // keplerNodeDataClass 생성
    var nodeData = new keplerNodeDataClass();
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
    
    node.addInfo = nodeData;
    
    // 노드 생성
    _this.kprMeth.renderNode(node);
}

//필터 조합 노드 텍스트 설정
function setFilterCombiNodeText() {
    var _this = segmentViewPopObj; 
    
    var deftNode = _this.kprMeth.findNodeByNodeType("A")[0];
    if ($.fn.ifvmIsNotEmpty(deftNode)) {
        //하위 노드 추출
        var childNodes = _this.kprMeth.getChildNode(deftNode.name);
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
	   			KPRDiagram._updateNode(node.name, {templateId: "segmentNodeTemplate"} );
	   			
	   			//노드 높이 재설정
	   			var height = $("#" + node.addInfo.nodeId + node.addInfo._Suffix).height()+2;
	   			KPRDiagram._updateNode(node.name, {height: height} );
	       }
            
	        $.merge(childNodes, _this.kprMeth.getChildNode(node.name));
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
	    	var nodeA = KPRDiagram.getNode(data.combFilterAId);
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
	    	var nodeB = KPRDiagram.getNode(data.combFilterBId);
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
    
    if ($.fn.ifvmIsNotEmpty(sourceNode) && $.fn.ifvmIsNotEmpty(targetNode)) {
        var nodeData = new keplerNodeDataClass();
        nodeData.nodeId = data.segFilterRelId;
        nodeData.nodeType = "CONNECTOR";
        nodeData.data = data;
        
        var connector = {
                name: data.segFilterRelId,
                sourceNode: sourceNode,
                targetNode: targetNode,
                addInfo: nodeData
        }
        
        KPRDiagram.add(connector);
    }
}


//세그먼트 필터 설정 팝업 열기
function segmentFilterSetPopOpen(atribGroupColId) {
    segment.selectedAtribGroupColId = atribGroupColId;
    
    if ($.fn.ifvmIsNotEmpty(atribGroupColId)) {
        $("#segmentFilterSetPopup").ifvsfPopup({
    		enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="segmentFilterSetPop_KPR"/>',
            contentType: "ajax",
            title: '<spring:message code="M01187" />',
            width: 828,
            close : 'segmentFilterSetPopupClose'
        });
    }
}

//세그먼트 필터 설정 팝업 닫기
function segmentFilterSetPopupClose() {
    segmentFilterSetPopup._destroy();
    
    if (KPRDiagram._selectedObject.data.dataStatus == "I") {
        KPRDiagram.remove();
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
        width: 500,
        close : 'segmentFilterCombiPopupClose'
    });
}

//세그먼트 필터 조합 팝업 닫기
function segmentFilterCombiPopupClose() {
    segmentFilterCombiPopup._destroy();
    
    if (KPRDiagram._selectedObject.data.dataStatus == "I") {
        KPRDiagram.remove();
    }
}

//커넥터의 세그먼트 관계 데이터 추출
function getChildFilterRelListData(name) {
    var filterRelList = [];
    
    //노드    
    var node = KPRDiagram.getNode(name);
    
    //연결 커넥터 목록
    $.each(node.inEdges, function(index, edge) {
        
        //커넥터 확인
        var cnntr = KPRDiagram.getNode(edge);
        
        if ($.fn.ifvmIsNotEmpty(cnntr)) {
            var sNode = KPRDiagram.getNode(cnntr.sourceNode);
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

//세그먼트 새로고침
function setSegmentRefresh() {
    var segmentId = segment.segmentId;
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
 	   
 	    segmentMessageCheckr(result.message)
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

$(document).ready(function() {
    /* $.ifvProgressControl(true, $("#segmentPopup"));*/
    
    segmentViewPopObj = new setSegmentViewPopObj();
    
    //세그먼트 상세
    initSegmentDetail();
    
    //새로고침 버튼
    $('#segmentRefreshBtn').on('click', function(){
        setSegmentRefresh();
    });
});

</script>
<div class="" style="width: 760px; height:610px;">
    <div id="KPRDiagram" ></div>
</div>
<div id="logicalComponentListPopup"></div>
<div id="segmentFilterSetPopup"></div>
<div id="segmentFilterCombiPopup"></div>
<div id="targetGroupNewPopup"></div>
<ul id="segmentContextMenu" class="right_mou_list" >

</ul>

