<%@ page import="java.util.UUID"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- SyncFusion Diagram Start -->
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/util.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/NodeDataClass.js" type="text/javascript"></script>    
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/methods.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/events.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/intelligentshapes.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/palettes.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/control.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/diagram/js/pathseg.js" type="text/javascript"></script>
<!-- SyncFusion Diagram End -->

<script>
// /webapp/resources/js/kepler/diagram/js/methods.js의 다이어그램 설정 시 사용 되는 변수
diagramType = "LGC_COMP";

// 커넥터 더블 클릭 여부 확인
var isConnectionDoubleClicked = false;

// 현재 선택된 테이블 관계 노드 ID
var curClickedTableRelNodeId = "";

// 다이어그램 테이블 관계 Alias 시퀀스 변수 
var tblAliasSequence = {
	  fact : 1
	, dimension : 1
	, aggregation : 1
}

// 테이블 시퀀스 초기화
function initTblAliasSequence(){
	tblAliasSequence = {
		  fact : 1
		, dimension : 1
		, aggregation : 1
	}
}

// 불러온 테이블 관계 노드를 기준으로 Sequence를 초기화
function setDefaultTblAliasSequence() {
    initTblAliasSequence();
    joinCommonData.tableRelList.forEach(function(data) {

        var typeCd = data.tblTypeCd
        var alias = data.tblAlias

        var curAliasSeq = alias.substring(1) * 1
        
        if (typeCd === "Fact") {
            var cmprVal = tblAliasSequence.fact;
            tblAliasSequence.fact = (cmprVal >= curAliasSeq) ? cmprVal + 1 : curAliasSeq;
        }
        else if (typeCd === "Dimension") {
            var cmprVal = tblAliasSequence.dimension;
            tblAliasSequence.dimension = (cmprVal >= curAliasSeq) ? cmprVal + 1 : curAliasSeq;
        }
        else if (typeCd === "Aggregation") {
            var cmprVal = tblAliasSequence.aggregation;
            tblAliasSequence.aggregation = (cmprVal >= curAliasSeq) ? cmprVal + 1 : curAliasSeq;
        }
    });
}

//테이블 관계 노드 Alias생성
function createTblAlias(tblTypeCd) {

    var prefix = "";
    var seq = "";

    if (tblTypeCd === "Fact") {
        prefix = "F";
        tblAliasSequence.fact++;
        seq = tblAliasSequence.fact;
    }
    else if (tblTypeCd === "Dimension") {
        prefix = "D";
        tblAliasSequence.dimension++;
        seq = tblAliasSequence.dimension;
    }
    else if (tblTypeCd === "Aggregation") {
        prefix = "A";
        tblAliasSequence.aggregation++;
        seq = tblAliasSequence.aggregation;
    }

    var tblAlias = prefix + $.fn.ifvmStr_pad(seq, 5, "0", 'LEFT');

    return tblAlias;
}

//다이어그램 초기화
function resetJoinTabDiagram(){
	var items = [];
	createDiagram(items);
}

// 다이어그램에 신규 테이블 관계 노드 설정
function addJoinTableRelNode(args) {
		
	// node 생성
	var node = {};
	node.name = $.ifvmGetRowID();
	node.borderWidth = 0;
	node.offsetX = args.event.offsetX;
	node.offsetY = args.event.offsetY;
	node.ports = getDefaultPort();
	    
	// NodeDataClass 생성
	var nodeData = new NodeDataClass();
	nodeData.nodeId = node.name;
	nodeData.htmlTemplateId = "lgcCompTableNodeTemplate";
	
	// Node Table Data Setting
	var tblMstId = args.droppedElementData.id;
	var tblMstNm = args.droppedElementData.text.replace(/\n/g, "").trim();
	var schmaTblNm = args.droppedElementData.text;
	var tblTypeCd  = "";
	joinCommonData.accodionTreeList.forEach(function(accodionItem){
		accodionItem.treeList.forEach(function(treeItem){
			if(tblMstId === treeItem.id){
				tblTypeCd = treeItem.tblTypeCd;
				schmaTblNm = treeItem.schmaTblNm;
			}
		})
	});
	var tblAlias = createTblAlias(tblTypeCd); // function -> logicalComponentJoin.jsp
	
	// 칼럼정보 가져오기
	var colList = getTableRelColumnMasterList({tblMstId : tblMstId});
	if(colList == '' || colList == null){
		alert("<spring:message code='M01678'/>");
		return;
	}
	
	nodeData.tableName = tblAlias + " - " + tblMstNm;
	nodeData.data = {
		 nodeId : node.name
		,tblRelId : ""
		,tempTblRelId : $.ifvmGetRowID()
		,tblMstId : tblMstId
		,tblMstNm : tblMstNm
		,schmaTblNm : schmaTblNm
		,tblAlias : tblAlias
		,tblTypeCd : tblTypeCd
		,isNew : true
		,columnList : colList
    	,grpColFlag : false
	};
    
    // Table Template Type Setting
	nodeData.tableType = setDiagramTableNodeStyle(tblTypeCd);
	
	node.diagramType = diagramType;
	node.addInfo = nodeData;
	
	// Node Creating
	renderNode(node);
	
	// Node Event Setting
	setDiagramTableNodeEvent(node.name);
	
}

// 다이어그램에 불러온 테이블 관계 데이터를 노드를 설정 
function setJoinTableRelNode(){
	joinCommonData.tableRelList.forEach(function(data){
	    // node 생성
	    var node = {};
	    node.name = data.tblRelId;
	    node.borderWidth = 0;
	    node.offsetX = data.offsetX;
	    node.offsetY = data.offsetY;
	    node.ports = getDefaultPort();
	        
	    // NodeDataClass 생성
	    var nodeData = new NodeDataClass();
	    nodeData.nodeId = data.tblRelId;
	    nodeData.htmlTemplateId = "lgcCompTableNodeTemplate";
	    
	    // Node Table Data Setting 
	    var tblMstId = data.tblMstId;
	    var tblMstNm = data.tblMstNm;
	    var schmaTblNm = data.schmaTblNm;
	    var tblTypeCd  = data.tblTypeCd;
	    var tblAlias = data.tblAlias;
	    
	    var colList =  getTableRelColumnMasterList({
        	tblMstId : data.tblMstId
        });
	    
	    var groupColumnFlag = false;
	    var groupColumnList = getTableRelGroupColumnList(data.tblRelId);
	    if ($.fn.ifvmIsNotEmpty(groupColumnList)) {
	    	$.each(groupColumnList, function(grpDataIdx, grpDataObject) {
	    		var colId = grpDataObject.colId;
	    		
	    		$.each(colList, function(colDataIdx, colDataObject) {
	    			if (colDataObject.columnMstId === colId) {
	    				colDataObject.grpColId = grpDataObject.grpColId;
	    				colDataObject.grpFuncTypeCd = grpDataObject.grpFuncTypeCd;
	    				return false;
	    			}
	    		});
	    	});
	    	
	    	groupColumnFlag = true;
	    }
	    
	    nodeData.tableName = tblAlias + " - " + tblMstNm;
	    nodeData.data = {
	    	 nodeId : node.name
	    	,tblRelId : data.tblRelId
	    	,tempTblRelId : ""
	    	,tblMstId : data.tblMstId
	    	,tblMstNm : data.tblMstNm
	    	,schmaTblNm : data.schmaTblNm
	    	,tblAlias : data.tblAlias
	    	,tblTypeCd : data.tblTypeCd
	    	,isNew : false
	    	,columnList : colList
	    	,grpColFlag : groupColumnFlag
	    };
	    
	    // Table Template Type Setting
		nodeData.tableType = setDiagramTableNodeStyle(tblTypeCd);
	    
	    node.addInfo = nodeData;
	    
	    // Node Creating
	    renderNode(node);
	    
		// Node Event Setting
		setDiagramTableNodeEvent(node.name);
	});
}

// 다이어그램 테이블 노드 스타일 설정
function setDiagramTableNodeStyle(tblTypeCd){
	var rtnStyle = "";
	if (tblTypeCd === "Fact") {
		rtnStyle = "lgcComp_tbl_box_fact";
	} else if (tblTypeCd === "Aggregation") {
		rtnStyle = "lgcComp_tbl_box_aggregation";
	} else {
		rtnStyle = "lgcComp_tbl_box_dimension";
	}
	return rtnStyle;
}

// 다이어그램의 테이블 노드에 이벤트 설정
function setDiagramTableNodeEvent(name){
	// 테이블 노드 삭제 클릭 핸들러
	$("#" + name + "_inhtml #aTableNodeDelete").click(function(e){
		removeLgcCompNodeByDeleteKey();
	});
	
	// 테이블 노드 마우스 오버 핸들러
	$('#' + name + "_html").hover(function(){
        // Hover over code
        var html = $("#aTblNm_" + name).clone();
        $(this).data('tipText', html).removeAttr('title');
        $('<div class="tooltip"></div>')
        .html(html)
        .appendTo('body')
        .fadeIn('slow');
    }, function() {
            // Hover out code
            $('.tooltip').remove();
    }).mousemove(function(e) {
            var mousex = e.pageX + 20; //Get X coordinates
            var mousey = e.pageY + 10; //Get Y coordinates
            $('.tooltip')
            .css({ top: mousey, left: mousex })
    });
}


// 다이어그램에 조인 칼럼 커넥터 설정
function setJoinColumnConnector(){
	joinCommonData.joinPopupDataList.forEach(function(data){
	    var sourceNode = data.leftNodeId;
	    var targetNode = data.rightNodeId;
	    
	    if (isNotEmpty(sourceNode) && isNotEmpty(targetNode)) {
	        
	    	data.nodeType = "connector";
	    	
	        var connector = {
	        	name : sourceNode + targetNode,
                sourceNode: sourceNode,
                targetNode: targetNode,
                addInfo: data
	        }
	        
	        diagram.add(connector);
	    }
	});
}

//테이블 노드 상세 팝업
function setTableNodeDetailPopup(id){
	curClickedTableRelNodeId = id;
	
	$("#logicalComponentPopupContainer").ifvsfPopup({
		enableModal : true
        ,enableResize: false
        ,allowKeyboardNavigation : false
        ,contentUrl: '<ifv:url name="logicalComponentColumnListPop"/>'
        ,contentType: "ajax"
        ,title: '<spring:message code="M00537"/>'
        ,width: 600
        ,close : 'logicalComponentPopClose'
    });
	logicalComponentPopupContainer = $("#logicalComponentPopupContainer").data("ejDialog");
}

// 모든 테이블 노드를 리스트로 가져오기
function getAllJoinTableRelList(){
	var resList = new Array();
	
	var curNodeList = diagram.nodes();
	curNodeList.forEach(function(node, idx){
		var data = node.addInfo.data;
		var resItem = {
			 tblRelId : data.tblRelId
			,tempTblRelId : data.tempTblRelId
			,schmaTblNm : data.schmaTblNm
			,tblId : data.tblMstId
			,tblNm : data.tblMstNm
			,tblAlias : data.tblAlias
			,offSetX : node.offsetX
			,offSetY : node.offsetY
			,lgcCompId : lgcCompData.lgcCompId
			,tableSeq : idx + 1
		}
		resList.push(resItem);
	});
	
	return resList;
}

// 모든 조인 칼럼을 리스트로 가져오기
function getAllJoinColumnList(){
	// 삭제 된 커넥터를 가져와 ID만 추출
	var rmvIdList = new Array();
	var rmvData = diagram._removeConnectors;
	rmvData.forEach(function(curData){
		if(curData.addInfo.joinColumnList !== undefined){
			curData.addInfo.joinColumnList.forEach(function(curRmData){
					rmvIdList.push(curRmData.joinColumnId);	
			});
		}
	});
	
	// 리스트 가져오기
	var list = joinCommonData.joinPopupDataList;
	var rtnJoinColumnList = new Array();
	list.forEach(function(item) {
		var curList = item.joinColumnList;
		curList.forEach(function(joinColumnItem){
			
			// 삭제여부 체크
			var isDeleted = false;
			rmvIdList.forEach(function(rmId){
				if(rmId === joinColumnItem.joinColumnId){
					isDeleted = true;
				}
			});
			
			if(!isDeleted){
				rtnJoinColumnList.push(joinColumnItem);
			}
		});
	});
	return rtnJoinColumnList;
}

// DB Service 콤보 리스트 조회
function getDbServiceComboList(){
	
	var resData;	
	$.ifvSyncPostJSON(
		'<ifv:action name="getJoinDbServiceComboList"/>'
	   , {}
	   , function(result) {
		   resData = result;
	   }
	);
	return resData; 
}

// DB Service 콤보 리스트 설정
function setDbServiceComboList(data, selectedVal){
	
	$("#selectTmpl").tmpl(data).appendTo("#selectDbService");
	
	if(selectedVal != null){
		joinCommonData.dbInformId = selectedVal;
		$("#selectDbService").val(selectedVal).prop("selected", "selected");
	}
}

//테이블 관계 노드 생성 시 노드 내에 설정할 컬럼 마스터 정보 조회
function getTableRelColumnMasterList(reqData){
	var resData;
	$.ifvSyncPostJSON(
		'<ifv:action name="getJoinColumnMasterList"/>'
	   , reqData
	   , function(result) {
		   resData = result;
	   }
	);
	return resData;
}

var getTableRelGroupColumnList = function(tblRelId) {
	var resData = null;

	$.ifvSyncPostJSON("<ifv:action name='getLgcCompGrpColMstList' />", {
		tblRelId : tblRelId
	}, function(resList) {
		resData = resList;
	});
	
	return resData;
};

// 왼쪽 어코디언 리스트 조회
function getLeftAccodionList(){
	
	var reqData = {
		dbInformId : $("#selectDbService :selected").val(),
		lgcCompId : lgcCompData.lgcCompId,
		tblIdList : joinCommonData.tblList
	}
	
	var resData;
	$.ifvSyncPostJSON(
		'<ifv:action name="getJoinAccordionList"/>'
	   , reqData
	   , function(result) {
		   resData = result;
	   }
	);
	return resData;
}

// 왼쪽 어코디언 리스트 설정
function setLeftAccodionList(data){
	
	$("#divJoinAccrodianTreeContainer").html("");
	$("#divJoinAccrodianTreeContainer").append("<div id='joinAccrodianTree' class='logical_component_tree'></div>");
	
	//로지컬 컴포넌트 트리 생성
	var fields = {
        "id": "id",
        "text": "text",
        "parentId": "parentId",
        "colType": "colType"
    };
	createAccordionTree("joinAccrodianTree", data, fields, "#ifvLogicalComponentTreeViewTemplate", "setJoinTabScrollResize");
	
    //아코디언트리 사이즈 설정
    setTimeout(function(){
    	setJoinTabScrollResize();
    }, 100);
    
    setLeftAccodionListTooltip();
}

//트리 노드에 MouseOver 시, Tooltip
function setLeftAccodionListTooltip(){
	
	// Mouse Over 시, Tooltip
	$("#joinAccrodianTree .e-item .tree_wrap li").each(function(){
		$(this).hover(function(e){
	        // Hover over code
	        var html = $(this).clone();
	        $(this).data('tipText', html).removeAttr('title');
	        $('<div class="tooltip"></div>')
	        .html(html)
	        .appendTo('body')
	        .fadeIn('slow');
	    }, function() {
	            // Hover out code
	            $('.tooltip').remove();
	    }).mousemove(function(e) {
	            var mousex = e.pageX + 20; //Get X coordinates
	            var mousey = e.pageY + 10; //Get Y coordinates
	            $('.tooltip')
	            .css({ top: mousey, left: mousex })
	    });
	});
}

// 조인 커넥터 더블 클릭 시, 설정 팝업 표시
function setJoinSettingPop(data){
	
	// 신규 조인 관계일 때
	if(data.popType === "NEW"){
		var leftData = data.leftTblNode.addInfo.data;
		var rightData = data.rightTblNode.addInfo.data;

		var leftId = (leftData.tblRelId === "") ? leftData.tempTblRelId : leftData.tblRelId;
		var rightId = (rightData.tblRelId === "") ? rightData.tempTblRelId : rightData.tblRelId;
		
		// 자기 자신을 노드로 연결 했을 때
		if(leftId === rightId){
			alert("<spring:message code='M01505'/>");
			return false;
		} 
		
		// 이미 조인 관계 커넥터가 존재할 때
		var isExists = false;
		joinCommonData.joinPopupDataList.forEach(function(item, index) {
			
			var isEqualLeftId = (item.leftLgcCompTblRelId === leftId || item.leftLgcCompTblRelId === rightId);
			var isEqualRightId = (item.rightLgcCompTblRelId === leftId || item.rightLgcCompTblRelId === rightId);
			
			if(isEqualLeftId && isEqualRightId){
				isExists = true;
			}
		});
		if(isExists){
			alert("<spring:message code='M01506'/>");
			return false;
		}
		
		// 디멘전간의 연결인지 확인
		if(leftData.tblTypeCd === "Dimension" 
				&& rightData.tblTypeCd === "Dimension"){
			alert("<spring:message code='M01518'/>");
			return false;
		}
	} else {
		isConnectionDoubleClicked = true;
	}
	
	// 새로운 조인 관계를 설정하기 위한 팝업 실행
	joinCommonData.curJoinPopData = data;
	$("#logicalComponentPopupContainer").ifvsfPopup({
		enableModal : true
        ,enableResize: false
        ,allowKeyboardNavigation : false
        ,contentUrl: '<ifv:url name="logicalComponentJoinSettingPop"/>'
        ,contentType: "ajax"
        ,title: '<spring:message code="M01429"/>'
        ,width: 700
        ,close : 'joinSettingPopup_Close'
    });
	logicalComponentPopupContainer = $("#logicalComponentPopupContainer").data("ejDialog");
	
	return true;
}

//로지컬 컴포넌트 아코디언 트리 사이즈 설정
function setJoinTabScrollResize() {
    var height = $("#diagram").outerHeight() - $(".ans_top row").outerHeight() - 40;
    $("#divJoinAccrodianTreeContainer").css("height", height);
  	//스크롤 생성
    /* $("#divJoinAccrodianTreeContainer").ejScroller({
        height: height
    });
  	
    var scrollobj = $("#divJoinAccrodianTreeContainer").data("ejScroller");
    scrollobj.refresh(); */
}

//저장여부를 물어봐야하는지 확인
function isNeedTabSaveAlert(){
	
	var isNeed = false;
	
	// 신규 저장이면 무조건 저장
	if(lgcCompData.mode === "NEW"){
		isNeed = true;
	}
	// 수정일 때
	else {
		
		// 커넥션 더블클릭 시
		if(isConnectionDoubleClicked){
			isNeed = true;
		}
		
		// 노드 위치 변경여부 확인
		var curNodeList = diagram.nodes();
		var savedList = joinCommonData.tableRelList;
		curNodeList.forEach(function(rawItem){
			// 신규 추가 노드가 존재 시
			if(rawItem.addInfo.data.tempTblRelId !== ""){
				isNeed = true;	
			}
			
			savedList.forEach(function(savedItem){
				if(rawItem.addInfo.data.tblRelId === savedItem.tblRelId){
					if(""+rawItem.offsetX !== savedItem.offsetX){
						isNeed = true;
					} else if(""+rawItem.offsetY !== savedItem.offsetY){
						isNeed = true;
					}
				} 
			});
		});
		
	}
	
	return isNeed;
}

// 테이블관꼐 및 커넥터 삭제 처리 ( and Delete 키 삭제 처리)
function removeLgcCompNodeByDeleteKey(args){
	
	var curNode = diagram.selectionList[0];
	if(curNode.addInfo.nodeType === "connector"){
		if (!confirm(MESSAGE.common.removeConfirm)) {
        	return;
        }
		
		var newList = new Array();
		joinCommonData.joinPopupDataList.forEach(function(item) {
			var isEqualLeftId = (item.leftNodeId === curNode.sourceNode);
			var isEqualRightId = (item.rightNodeId === curNode.targetNode);
			
			if(!isEqualLeftId || !isEqualRightId){
				newList.push(item);
			}
		});
		
		joinCommonData.joinPopupDataList = newList;
		
		diagram.remove();
	} else {
		// 테이블 노드 삭제
		if (confirm("<spring:message code='M01686'/>")) {
			diagram.remove();
        }
	}
	
}



// 조인 설정 탭 초기 설정
function logicalJoinTab_Init(){
	
	// 공통데이터 초기화
	initTblAliasSequence();
	
	// DB 콤보 리스트 설정
	var dbServiceData = getDbServiceComboList();
	if(joinCommonData.dbInformId  != null 
			|| joinCommonData.dbInformId !== undefined){
		setDbServiceComboList(dbServiceData, joinCommonData.dbInformId);	
	} else {
		setDbServiceComboList(dbServiceData);
	}
	joinCommonData.dbInformId = $("#selectDbService :selected").val();
	
	// 왼쪽 어코디언 트리 리스트 설정
	if(joinCommonData.dbInformId !== undefined && joinCommonData.dbInformId !== ""){
		var accodionData = getLeftAccodionList();
		joinCommonData.accodionTreeList = accodionData;
		setLeftAccodionList(accodionData);	
	}
	
	//다이어그램 생성
	resetJoinTabDiagram();	
	
	// 테이블 관계 노드 설정	
	if(joinCommonData.tableRelList != null 
			|| joinCommonData.tableRelList !== undefined){
		diagram.clear();
		setJoinTableRelNode();		  // 노드 생성
		setDefaultTblAliasSequence(); // 시퀀스 초기화
	}

	// 커넥터 설정
	if(joinCommonData.joinPopupDataList != null 
			|| joinCommonData.joinPopupDataList !== undefined){
		setJoinColumnConnector();     // 커넥터 생성
	}
	
	diagram.clearSelection();
	
	// 왼쪽 어코디언 메뉴 리사이즈 시 스크롤을 다시 그림
	$(window).bind('resize', function () {
        //로지컬 컴포넌트 리사이즈
        setJoinTabScrollResize();
    });
	
	// 분석/세그먼트에서 사용시
	if(lgcCompData.isAnalysisSegmentUsed){
		// DB Service 비활성화
		$("#selectDbService").prop("disabled", "true");

		// 테이블 노드 삭제버튼 숨김
		var nodeList = diagram.nodes();
		nodeList.forEach(function(node){
			$("#"+node.addInfo.nodeId+"_html #divTableNodeDelete").hide();
		});
	}
}

function logicalJoinTab_Hadler(){
	
	// DB Service 콤보 박스 이벤트 핸들러
	$("#selectDbService").change(function(e){
		var selectedVal = joinCommonData.dbInformId||"";
		
		if(selectedVal === "" || confirm("<spring:message code='M01504'/>")){
			
			// 공통 데이터 재정의
			initTblAliasSequence();
			joinCommonData.tableRelList = new Array();
			joinCommonData.joinPopupDataList = new Array();
			joinCommonData.dbInformId = e.target.value;
			
			// 어코디언 리스트 변경
			var accodionData = getLeftAccodionList();
			joinCommonData.accodionTreeList = accodionData; 
			setLeftAccodionList(accodionData);

			// 다이어그램 재설정
			diagram.destroy();
			resetJoinTabDiagram();
		} else {
			$("#" + e.target.id).val(joinCommonData.dbInformId).prop("seleted", "selected");
		}
		
	});
}

// ****** NHIS 관련 추가 ******/
//그룹 설정 팝업
var setTableGroupColPopup = function(tblRelId, colList, grpColFlag) {
	curClickedTableRelNodeId = tblRelId;
	
	var lgcGrpColListPop = $("#lgcGrpColListPop");

	if ($.fn.ifvmIsNotEmpty(lgcGrpColListPop)) {
		lgcGrpColListPop.remove();
	}

	lgcGrpColListPop = $("<div class='popup_container' />");
	lgcGrpColListPop.attr("id", "lgcGrpColListPop");

	lgcGrpColListPop.ifvsfPopup({
		enableModal : true,
		enableResize : false,
		contentUrl : "<ifv:url name='logicalComponentGroupColumnSettingPop'/>",
		contentType : "ajax",
		title : "그룹 함수 설정",
		ajaxSuccess: function(args) {
			setMeasureColList(colList, grpColFlag);
		}
	});
};

var getAllJoinColumnGrpList = function() {
	var nodeList = diagram.nodes();
	var rstList = new Array();
	
	$.each(nodeList, function(nodeDataIdx, nodeDataObject) {
		var grpColFlag = nodeDataObject.addInfo.data.grpColFlag;
		var columnList = nodeDataObject.addInfo.data.columnList;
		
		if (grpColFlag) {
			$.each(columnList, function(colDataIdx, colDataObject) {
				var colUseType = colDataObject.columnUseType;
				
				if (colUseType === "MEASURE") {
					var tempObject = new Object();
					tempObject.tblRelId = nodeDataObject.addInfo.data.tblRelId;
					tempObject.colId = colDataObject.columnMstId;
					tempObject.grpColId = colDataObject.grpColId;
					tempObject.grpFuncTypeCd = colDataObject.grpFuncTypeCd;
					
					rstList.push(tempObject);
				}
			});
		}
	});
	
	return rstList;
};
//****** NHIS 추가 ******/

$(document).ready(function() {
	logicalJoinTab_Init();
	logicalJoinTab_Hadler();
});
</script>

<script id="selectTmpl" type="text/x-jquery-tmpl">
<option value="${'${'}id}">${'${'}text}</option>
</script>

<div class="analysis_wrap clear_wrap">
	<div class="analysis_tree">
		<div class="ans_top row">
			<label class="col-xs-3" style="padding-top: 5px;"><spring:message code="M01440" /></label>
			<div class="col-xs-9">
				<ifv:input id="selectDbService" type="select" />
			</div>
		</div>
		<div id="divJoinAccrodianTreeContainer" style="overflow-y:auto;">
			<div id="joinAccrodianTree" class="logical_component_tree"></div>
		</div>
	</div>
	<div id="divDiagram" class="dashboard_wrap chart_wrap">
        <div id="diagram" ></div>
	</div>
</div>