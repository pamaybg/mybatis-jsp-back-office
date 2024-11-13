<%@page import="java.util.UUID"%>
<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
#attributeGroupContextMenu {width: 174px;}
</style>


<script id="attrTreeTemplate" type="text/x-jsrender">
{{if colType == "P"}}
	<span class="folder_icon sprite-folder"></span>{{:text}}
{{else}}
	<span class="list_icon sprite-folder"></span>{{:text}}
{{/if}} 
</script>

<script>
var SUBFIX_SEG_KEY = " (Segment Key)";
var SUBFIX_DATE_KEY = " (Date Key)";
var SUBFIX_EVT_TRIGGER_KEY = " (Event Trigger Key)";

var isNodeDropped = false;
var isContextClicked = false;
var leftAttributeTreeData = new Array();

// 현재 오른쪽 클릭한 영역 정보
var curContextMenuTarget = {
	 e : null
	,data : null
	,dataIndex : 0
};

// 왼쪽 어코디언 트리 설정
function setLeftAccodianTree(){

	var accodianTreeData;
	$.ifvSyncPostJSON('<ifv:action name="getAttributeGroupLeftAccordionList"/>', {
	       lgcCompId: lgcCompData.lgcCompId
	   },
	   function(result) {
		   accodianTreeData = result;
		   leftAttributeTreeData = result;
	   }
	);
	
	// Fact / Aggregation 테이블에 칼럼이 없는 경우.
	if(accodianTreeData == ''){
		alert("<spring:message code='M01673'/>");
		
		var url = '<ifv:url name="logicalComponentDetail"/>?lgcCompId=' + lgcCompData.lgcCompId +"&tab=join";
    	qtjs.href(url);
	}
           
    var option = {
    		enableMultipleOpen: true
            ,treeOption: { 
            	nodeDragStop: function(e){
            		// 사용중인 분석/세그먼트가 존재하는 경우 
            		// kj.kang 주석처리
            		/*
            		if(lgcCompData.isAnalysisSegmentUsed){
            			alert("<spring:message code='M01439'/>");
            			e.cancel = true;
						return;
            		}
            		*/
            		
					// 바탕에 드랍할 경우 취소
					if(e.targetElementData.id === "" && e.targetElementData.parentId === ""){
						e.cancel = true;
						return;
					} 
					// 자식 노드에 드랍할 경우
					else if(e.targetElementData.parentId !== ""){
						e.cancel = true;
						return;
					}
            		
            		var thisDataSource = this.dataSource();
            		var selectedNodeList = this.getSelectedNodes();
            		var selectedNodeListFlag = $.fn.ifvmIsNotEmpty(selectedNodeList);
            		var tempTargetNodeList = new Array();
            		var targetNodeList = new Array();
            		
            		// 현재 선택된 리스트가 있냐 없냐에 따라 처리 방식 변경
            		// 선택된 리스트가 있다면, dataSource 에서 선택한 노드들의 정보를 꺼냄
            		// 선택된 리스트가 없다면, 현재 드래그 중인 노드의 정보를 꺼냄
            		$.each(thisDataSource, function(thisDataIdx, thisDataObj) {
            			if(selectedNodeListFlag) {
            				$.each(selectedNodeList, function(selectedNodeIdx, selectedNodeObj) {
            					var selectedNodeId = $(selectedNodeObj).attr("id");
            					
            					if(thisDataObj.id === selectedNodeId) {
            						tempTargetNodeList.push(thisDataObj);
            						return false;
            					}
            				});
            			} else {
            				if(thisDataObj.id === e.draggedElementData.id) {
            					tempTargetNodeList.push(thisDataObj);
            				}
            			}
            		});
            		
            		$.each(tempTargetNodeList, function(targetNodeIdx, targetNodeObj) {
            			var tempId = $.ifvmGetRowID();
            			
            			var atribColData = {
							id : tempId
							, parentId : e.targetElementData.id
							, text : targetNodeObj.text
							, hasChild : false
							, extended : false
							, atribGroupId : e.draggedElementData.id
							, attributeGroupColumnId : ""
							, tempAttributeGroupColumnId : tempId
							, dpNm : targetNodeObj.text
							, seq : ""
							, lgcCompId : lgcCompData.lgcCompId
							, lgcCompTblRelId : targetNodeObj.lgcCompTblRelId
							, tblAliasColNm : targetNodeObj.tblAliasColNm
							, colId : targetNodeObj.colId
							, dimColId : ""
							, calDtl : ""
							, calDtlHis : ""
							, calColYn : "0"
							, segKeyYn : "0"
							, evtTriggerKeyYn : "0" 
							, dateKeyYn : "0" 
							, colType : "C"
            			};
            			
            			targetNodeList.push(atribColData);
            		});
            		
            		var targetTree = $("#attributeTree").data("ejTreeView");
            		var targetDataSource = targetTree.dataSource();
            		targetDataSource = targetDataSource.concat(targetNodeList);
            		targetTree.dataSource(targetDataSource);
                	targetTree.expandAll();
                	targetTree.refresh();
                	
                	e.cancel = true;
                }
                , allowDropSibling: false
                , allowKeyboardNavigation : false
                , expanded: true         //전체 열기
                , allowDropChild: false  //자식노드로 이동
                , allowDragAndDrop: true //드래그 앤드 드랍
                , showCheckbox : false   //체크박스
                , allowEditing : false   //텍스트 변경
                , allowMultiSelection : true
                , template : "#ifvLogicalComponentTreeViewTemplate"
            }
    		,activate : "setAttributeTabScrollResize"
            ,inActivate : "setAttributeTabScrollResize"
    }
    
    //로지컬 컴포넌트 트리 생성
    $.fn.ifvmCreateAccordionTree("attributeAccordianTree", option, accodianTreeData);
    
    //아코디언트리 사이즈 설정
    setTimeout(function(){
    	setAttributeTabScrollResize();
    }, 100);
    
    setLeftAccodionListTooltip();
}

//트리 노드에 MouseOver 시, Tooltip
function setLeftAccodionListTooltip(){
	
	// Mouse Over 시, Tooltip
	$("#attributeAccordianTree .e-item .tree_wrap li").each(function(){
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

// 어트리뷰트 그룹 트리 설정
function setAttributeTree(){
	
	$("#attributeDashboard").html();
	$("#attributeDashboard").append("<div id='attributeTree' class='atrib_tree'></div>");
	
	var treeData;
	$.ifvSyncPostJSON('<ifv:action name="getAttributeGroupTreeNodeList"/>', {
	       lgcCompId: lgcCompData.lgcCompId
	   },
	   function(result) {
		   treeData = result;
	   }
	);
	
	// 세그먼트 키, 기준날짜 키 텍스트 변경
	var newTreeData = new Array();
	treeData.forEach(function(node, idx){
		if(node.segKeyYn === "1"){
			node.text = node.text + SUBFIX_SEG_KEY; 
		}
		if(node.dateKeyYn === "1"){
			node.text = node.text + SUBFIX_DATE_KEY; 
		}
		if(node.evtTriggerKeyYn === "1"){
			node.text = node.text + SUBFIX_EVT_TRIGGER_KEY; 
		}
		newTreeData.push(node);
	});
	
	// Create Attribute Tree 
	var attrTreeObtion = {
			 allowDragAndDrop : true
			,allowDropChild : false
			,allowDropSibling : true
			,allowEditing : false
			,allowKeyboardNavigation : false
			,template : "#attrTreeTemplate"
		    ,fields: { id: "id"
		    	, parentId: "parentId"
		    	, text: "text"
		    	, hasChild: "hasChild"
		    	, dataSource: newTreeData
		    	, expanded: "expanded" 
		    }
			,nodeDrag : function(e){}
			,nodeDragStop : function(e){
				
				// 부모 자식 여부 체크
				var isParent = false;
	        	$("#attributeTree").data("ejTreeView").getTreeData().forEach(function(item){
	        		if(item.id === e.draggedElementData.id){
	        			isParent = (item.colType === "P") ? true : false; 
	        		}
	      		});
				
				
	        	var target = e.targetElementData;
	        	var targetData = null;
	        	$("#attributeTree").data("ejTreeView").getTreeData().forEach(function(item){
	        		if(item.id === e.targetElementData.id){
	        			targetData = item;
	        		}
	      		});
	        	
				// 부모 노드가 드래그 앤 드랍 되었을 경우
				if(isParent){
					// 최상위에 드래그 앤 드랍 되었을 경우를 제외하곤 드래그 앤 드랍 불가
					if(targetData !== null){
						e.cancel = true;
					} else {
						if(!confirm("<spring:message code='M00066'/>")){
							e.cancel = true;	
						}
					}
				}
				// 자식 노드가 드래그 앤 드랍 되었을 경우
				else {
					// 최상위에 드래그 앤 드랍 불가
					if(target.id === "" && target.parentId === ""){
						e.cancel = true;
					} else if(target.parentId !== ""){
						e.cancel = true;
					}				
				}
			 }
			,nodeDropped : function(e){
				
				// 드랍 여부 처리
	    		isNodeDropped = true;
				
				// 데이터 재처리
				var treeObj = $("#attributeTree").data("ejTreeView");
				var treeData = treeObj.getTreeData();
				treeObj.dataSource(treeData);
				treeObj.expandAll();
				treeObj.refresh();
			}
		}
	
	$("#attributeTree").ifvsfTree(attrTreeObtion);
	$("#attributeTree").data("ejTreeView");
	
	
}

// 어트리뷰트 그룹 트리 내에서 사용할 컨텍스트 메뉴 설정
function setContext(){
	 var contextData = [
          	     {id: "MENU_CREATE_ATTR_GRP", name: "<spring:message code='M01449' />"}
        	    ,{id: "MENU_MODIFY_NAME", name: "<spring:message code='M01450' />"}
         	    ,{id: "MENU_REMOVE", name: "<spring:message code='M00831' />"}
         	    ,{id: "MENU_ADD_CON_FILED", name: "<spring:message code='M01451' />"}
        	    ,{id: "MENU_MDF_CON_FILED", name: "<spring:message code='M01452' />"}
        	    ,{id: "MENU_SEG_KEY", name: "<spring:message code='M01453' />"}
        	    ,{id: "MENU_SEG_KEY_UNCHECK", name: "<spring:message code='M01679'/>"}
        	    ,{id: "MENU_DATE_KEY", name: "<spring:message code='M01662' />"}
        	    ,{id: "MENU_DATE_KEY_UNCHECK", name: "<spring:message code='M01663' />"}

        	    // 2018. 2. 13. jh.kim. 이벤트 트리거 키 추가
        	    ,{id: "MENU_EVT_TRIGGER_KEY", name: "<spring:message code='M02712' />"}
        	    ,{id: "MENU_EVT_TRIGGER_KEY_UNCHECK", name: "<spring:message code='M02713' />"}
        	    ,{id: "MENU_SELECT_SQL", name: "<spring:message code='M02953' />"}         	         	
        	    
        	];
	 
     var contextOption = {
         menuType: ej.MenuType.ContextMenu,
         openOnClick: false,
         contextMenuTarget: "#attributeDashboard",
         click: "contextMenuClickHandler",
         beforeOpen: function(e) {        	 
        	 curContextMenuTarget.e = e;
        	 
        	 // Tree Node
        	 if(e.target.nodeName === "A"){
				$(curContextMenuTarget.e.target).click(); 
        		
				var treeObj = $("#attributeTree").data("ejTreeView");
				var selectedEle = treeObj.getSelectedNode();
				var targetRawData = treeObj.getNode($(selectedEle).prop("id"));
        		
        		// Get Data Setting
        		curContextMenuTarget.data = null;
        		treeObj.getTreeData().forEach(function(item, index){
        			if(item.id === targetRawData.id){
        				curContextMenuTarget.data = item;
        				curContextMenuTarget.dataIndex = index;
        			}
        		});
        		
        		// Selected Data Check
        		if(curContextMenuTarget.data == null){
        			e.cancel = true;
        			return;
        		}
        		
        		// When Parent
				if(curContextMenuTarget.data.colType === "P"){
					$("#MENU_CREATE_ATTR_GRP").hide();
	        		$("#MENU_MODIFY_NAME").show();
	        		$("#MENU_ADD_CON_FILED").show();
	        		$("#MENU_MDF_CON_FILED").hide();
	        		$("#MENU_SEG_KEY").hide();
	        		$("#MENU_SEG_KEY_UNCHECK").hide();
	        		$("#MENU_EVT_TRIGGER_KEY").hide();
	        		$("#MENU_EVT_TRIGGER_KEY_UNCHECK").hide();
	        		$("#MENU_DATE_KEY").hide();
	        		$("#MENU_DATE_KEY_UNCHECK").hide();
	        		$("#MENU_SELECT_SQL").hide();
	        		
	        		// kj.kang 추가
        			if(lgcCompData.isAnalysisSegmentUsed) { // 수정 화면에서 분석 또는 세그먼트가 사용 중인 화면일 경우 (사용 중인 LC)
       					var isChildSavedFlag = false;
       					treeObj.getTreeData().forEach(function(item, index) {
       						// 트리 오브젝트 중 타입이 C(차일드)이며, 부모의 아이디 값이 현재 선택된 어트리뷰트 그룹의 아이디와 같을 때, attributeGroupColumnId 값이 존재한다면(저장된 값이라면) 삭제가 불가능
       						if(item.parentId === curContextMenuTarget.data.id && item.colType === "C" && $.fn.ifvmIsNotEmpty(item.attributeGroupColumnId)) {
       							isChildSavedFlag = true;
       						}
       					});
       					if(isChildSavedFlag) {
       						$("#MENU_REMOVE").hide();
       					} else {
       						$("#MENU_REMOVE").show();
       					}
        			} else {
        				$("#MENU_REMOVE").show();
        			}
				}
				// When Child
				else if(curContextMenuTarget.data.colType === "C"){
					$("#MENU_CREATE_ATTR_GRP").hide();
	        		$("#MENU_MODIFY_NAME").show();
	        		$("#MENU_ADD_CON_FILED").hide();
	        		$("#MENU_SELECT_SQL").show();

	        		// kj.kang 수정 - 제거버튼 노출 여부 :: 수정에서는 제거할 수 없으나, 저장하지 않은 데이터는 제거 가능
	        		if(lgcCompData.isAnalysisSegmentUsed 
	        		        && $.fn.ifvmIsNotEmpty(curContextMenuTarget.data.attributeGroupColumnId)) {
	        			$("#MENU_REMOVE").hide();
	        		} else {
	        			$("#MENU_REMOVE").show();
	        		}
	        		
	        		// Segment Key Setting : kj.kang 수정 - 세그먼트에서 사용중일 경우, 수정모드에서 안띄워줌
	        		if (lgcCompData.isSegmentUsed) {
	        			$("#MENU_SEG_KEY").hide();
	        			$("#MENU_SEG_KEY_UNCHECK").hide();
	        		} else {
						if(curContextMenuTarget.data.segKeyYn === "0") {
			        		$("#MENU_SEG_KEY").show();
			        		$("#MENU_SEG_KEY_UNCHECK").hide();
						} else {
			        		$("#MENU_SEG_KEY").hide();
			        		$("#MENU_SEG_KEY_UNCHECK").show();
						}
	        		}
	        		
	        		// Event Trigger Key Setting : jh.kim 추가 - 이벤트트리거 키로 사용중일 경우
					if(curContextMenuTarget.data.evtTriggerKeyYn === "1") {
		        		$("#MENU_EVT_TRIGGER_KEY").hide();
		        		$("#MENU_EVT_TRIGGER_KEY_UNCHECK").show();
					} else {
					    $("#MENU_EVT_TRIGGER_KEY").show();
		        		$("#MENU_EVT_TRIGGER_KEY_UNCHECK").hide();
					}
	        		
					// Date Key Setting : kj.kang 수정 - 분석에서 사용중일 경우, 수정모드에서 안띄워줌
					if(lgcCompData.isAnalysisUsed) {
						$("#MENU_DATE_KEY").hide();
						$("#MENU_DATE_KEY_UNCHECK").hide();
					} else {
						if(curContextMenuTarget.data.dateKeyYn === "0"){
			        		$("#MENU_DATE_KEY").show();
			        		$("#MENU_DATE_KEY_UNCHECK").hide();
						} else {
			        		$("#MENU_DATE_KEY").hide();
			        		$("#MENU_DATE_KEY_UNCHECK").show();
						}
					}
	        		
	        		// Cal Dtl Setting
					if(curContextMenuTarget.data.calColYn === "0"){
						$("#MENU_MDF_CON_FILED").hide();		        		
					} else {
						$("#MENU_MDF_CON_FILED").show();
		        		$("#MENU_SEG_KEY").hide();
		        		$("#MENU_SEG_KEY_UNCHECK").hide();
		        		$("#MENU_EVT_TRIGGER_KEY").hide();
		        		$("#MENU_EVT_TRIGGER_KEY_UNCHECK").hide();
		        		$("#MENU_DATE_KEY").hide();
		        		$("#MENU_DATE_KEY_UNCHECK").hide();
					}
				}
        		// When None Node
        		else {
					$("#MENU_CREATE_ATTR_GRP").hide();
	        		$("#MENU_MODIFY_NAME").hide();
	        		$("#MENU_REMOVE").hide();
	        		$("#MENU_ADD_CON_FILED").hide();
	        		$("#MENU_MDF_CON_FILED").hide();
	        		$("#MENU_SEG_KEY").hide();
	        		$("#MENU_SEG_KEY_UNCHECK").hide();
	        		$("#MENU_EVT_TRIGGER_KEY").hide();
	        		$("#MENU_EVT_TRIGGER_KEY_UNCHECK").hide();
	        		$("#MENU_DATE_KEY").hide();
	        		$("#MENU_DATE_KEY_UNCHECK").hide();
	        		e.cancel = true;
        		}
        	 }
        	 // Tree Background
        	 else if(e.target.nodeName === "DIV"){
       			$("#MENU_CREATE_ATTR_GRP").show();
           		$("#MENU_MODIFY_NAME").hide();
           		$("#MENU_REMOVE").hide();
           		$("#MENU_ADD_CON_FILED").hide();
           		$("#MENU_MDF_CON_FILED").hide();
           		$("#MENU_SEG_KEY").hide();
           		$("#MENU_SEG_KEY_UNCHECK").hide();
        		$("#MENU_EVT_TRIGGER_KEY").hide();
        		$("#MENU_EVT_TRIGGER_KEY_UNCHECK").hide();
           		$("#MENU_DATE_KEY").hide();
           		$("#MENU_DATE_KEY_UNCHECK").hide();
        		$("#MENU_SELECT_SQL").hide();
        	 }
        	 // None
        	 else {
				$("#MENU_CREATE_ATTR_GRP").hide();
        		$("#MENU_MODIFY_NAME").hide();
        		$("#MENU_REMOVE").hide();
        		$("#MENU_ADD_CON_FILED").hide();
        		$("#MENU_MDF_CON_FILED").hide();
        		$("#MENU_SEG_KEY").hide();
        		$("#MENU_SEG_KEY_UNCHECK").hide();
        		$("#MENU_EVT_TRIGGER_KEY").hide();
        		$("#MENU_EVT_TRIGGER_KEY_UNCHECK").hide();
        		$("#MENU_DATE_KEY").hide();
        		$("#MENU_DATE_KEY_UNCHECK").hide();
        		$("#MENU_SELECT_SQL").hide();
        		
        		e.cancel = true;
        	 }
         },
         data: contextData
     };
     
 	// Context Menu 생성
     $.fn.ifvmCreateContextMenu("attributeGroupContextMenu", contextOption);
 	
}

// 컨텍스트 메뉴 클릭 이벤트 핸들러
function contextMenuClickHandler(e){
	
	// 컨텍스트 클릭 여부 처리
	isContextClicked = true; 
	
	// 트리사용 객체 가져오기
	var treeObj = $("#attributeTree").data("ejTreeView");
	
	// 어트리뷰트 그룹 추가 
	if(e.element.id === "MENU_CREATE_ATTR_GRP"){
		$("#logicalComponentPopupContainer").ifvsfPopup({
			enableModal : true
	        ,enableResize: false
	        ,allowKeyboardNavigation : false
	        ,contentUrl: "<ifv:url name='logicalComponentAttributeAddPop'/>"
	        ,contentType: "ajax"
	        ,title: '<spring:message code="M01460"/>'
	        ,width: 400
	        ,close : 'logicalComponentPopClose'
	    });
		
		logicalComponentPopupContainer = $("#logicalComponentPopupContainer").data("ejDialog");

		
	} 
	// 변환 필드 추가 
	else if(e.element.id === "MENU_ADD_CON_FILED"){
		$("#logicalComponentPopupContainer").ifvsfPopup({
			enableModal : true
	        ,enableResize: false
	        ,allowKeyboardNavigation : false
	        ,contentUrl: '<ifv:url name="logicalComponentFieldSettingPop"/>?mode=NEW'
	        ,contentType: "ajax"
	        ,title: '<spring:message code="M01454"/>'
	        ,width: 600
	        ,close : 'logicalComponentPopClose'
	    });
		
		logicalComponentPopupContainer = $("#logicalComponentPopupContainer").data("ejDialog");
	}
	// 변환 필드 수정
	else if(e.element.id === "MENU_MDF_CON_FILED"){
		$("#logicalComponentPopupContainer").ifvsfPopup({
			enableModal : true
	        ,enableResize: false
	        ,allowKeyboardNavigation : false
	        ,contentUrl: '<ifv:url name="logicalComponentFieldSettingPop"/>?mode=MODIFY'
	        ,contentType: "ajax"
	        ,title: '<spring:message code="M01454"/>'
	        ,width: 600
	        ,close : 'logicalComponentPopClose'
	    });
		
		logicalComponentPopupContainer = $("#logicalComponentPopupContainer").data("ejDialog");
	}
	// 이름 변경
	else if(e.element.id === "MENU_MODIFY_NAME"){
		$("#logicalComponentPopupContainer").ifvsfPopup({
			enableModal : true
	        ,enableResize: false
	        ,allowKeyboardNavigation : false
	        ,contentUrl: "<ifv:url name='logicalComponentEditAttributeNamePop'/>"
	        ,contentType: "ajax"
	        ,title: '<spring:message code="M01450"/>'
	        ,width: 400
	        ,close : 'logicalComponentPopClose'
	    });
		
		logicalComponentPopupContainer = $("#logicalComponentPopupContainer").data("ejDialog");
	}
	// 노드 삭제
	else if(e.element.id === "MENU_REMOVE"){
		
		// 어트리뷰트 그룹 삭제 시
		if(curContextMenuTarget.data.colType === "P"){
			var isExistChild = false;
			var treeData = treeObj.getTreeData();
			treeData.forEach(function(node, index){
				if(node.parentId === curContextMenuTarget.data.id){
					isExistChild = true;
				}
			});
			
			// 하위 노드 존재 시
			if(isExistChild){
				if(!confirm("<spring:message code='M01675' />")){
					return;
				}	
			}
		}
		
		// 노드 삭제
		treeObj.removeNode(curContextMenuTarget.data.id);
		var treeData = treeObj.getTreeData();
		treeObj.dataSource(treeData);
		treeObj.expandAll();
		treeObj.refresh();
	}
	// 세그먼트 키 설정
	else if(e.element.id === "MENU_SEG_KEY"){
		
		// 세그먼트 설정 가능 여부 체크
		var canUseObj = isCanUseSegmentDateKey(curContextMenuTarget.data.id);
		if(canUseObj.isExistsSegKey){
			alert("<spring:message code='M01457' />");
			return;
		} 
		
		if(canUseObj.isExistsSelfKey){
			alert("<spring:message code='M01664' />");
			return;
		}
		
		// 세그먼트 키 설정 확인
		if(confirm("<spring:message code='M01455' />")){
			var newTreeData = treeObj.getTreeData();
			curContextMenuTarget.data.text = curContextMenuTarget.data.text + SUBFIX_SEG_KEY;
			curContextMenuTarget.data.segKeyYn = "1";
			newTreeData[curContextMenuTarget.dataIndex] = curContextMenuTarget.data;
			treeObj.expandAll();
			treeObj.refresh();
		}
	} 
	// 세그먼트 키 해제
	else if(e.element.id === "MENU_SEG_KEY_UNCHECK"){
		if(confirm("<spring:message code='M01456' />")){
			var newTreeData = treeObj.getTreeData();
			curContextMenuTarget.data.text = curContextMenuTarget.data.text.replace(SUBFIX_SEG_KEY, "");
			curContextMenuTarget.data.segKeyYn = "0";
			newTreeData[curContextMenuTarget.dataIndex] = curContextMenuTarget.data;
			treeObj.expandAll();
			treeObj.refresh();
		}
	}
	
	// 2018. 2. 13. jh.kim. 이벤트트리거 키 설정
	else if (e.element.id === "MENU_EVT_TRIGGER_KEY") {

		// 이벤트트리거 키 설정 가능 여부 체크
		var canUseObj = isCanUseSegmentDateKey(curContextMenuTarget.data.id);
		if (canUseObj.isExistsEvtTriggerKey) {
			alert("<spring:message code='M02715' />");
			return;
		}
		
		if (canUseObj.isExistsSelfKey) {
			alert("<spring:message code='M01664' />");
			return;
		}
		
		// 이벤트트리거 키 설정 확인
		if (confirm("<spring:message code='M02716' />")) {
			var newTreeData = treeObj.getTreeData();
			curContextMenuTarget.data.text = curContextMenuTarget.data.text + SUBFIX_EVT_TRIGGER_KEY;
			curContextMenuTarget.data.evtTriggerKeyYn = "1";
			newTreeData[curContextMenuTarget.dataIndex] = curContextMenuTarget.data;
			treeObj.expandAll();
			treeObj.refresh();
		}
	}
	// 2018. 2. 13. jh.kim. 이벤트트리거 키 해제
	else if (e.element.id === "MENU_EVT_TRIGGER_KEY_UNCHECK") {
		if(confirm("<spring:message code='M02717' />")){
			var newTreeData = treeObj.getTreeData();
			curContextMenuTarget.data.text = curContextMenuTarget.data.text.replace(SUBFIX_EVT_TRIGGER_KEY, "");
			curContextMenuTarget.data.evtTriggerKeyYn = "0";
			newTreeData[curContextMenuTarget.dataIndex] = curContextMenuTarget.data;
			treeObj.expandAll();
			treeObj.refresh();
		}
	}
	// 기준일자 키 설정
	else if(e.element.id === "MENU_DATE_KEY"){
		
		// 기준일자 설정 가능 여부 체크
		var canUseObj = isCanUseSegmentDateKey(curContextMenuTarget.data.id);
		if(canUseObj.isExistsDateKey){
			alert("<spring:message code='M01666' />");
			return;
		} 
		
		if(canUseObj.isExistsSelfKey){
			alert("<spring:message code='M01664' />");
			return;
		}
		
		// 기준일자 키 설정 확인
		if (confirm("<spring:message code='M01667' />")) {
			var newTreeData = treeObj.getTreeData();
			curContextMenuTarget.data.text = curContextMenuTarget.data.text + SUBFIX_DATE_KEY;
			curContextMenuTarget.data.dateKeyYn = "1";
			newTreeData[curContextMenuTarget.dataIndex] = curContextMenuTarget.data;
			treeObj.expandAll();
			treeObj.refresh();
		}
	} 
	// 기준일자 키 해제
	else if(e.element.id === "MENU_DATE_KEY_UNCHECK"){
		if(confirm("<spring:message code='M01668' />")){
			var newTreeData = treeObj.getTreeData();
			curContextMenuTarget.data.text = curContextMenuTarget.data.text.replace(SUBFIX_DATE_KEY, "");
			curContextMenuTarget.data.dateKeyYn = "0";
			newTreeData[curContextMenuTarget.dataIndex] = curContextMenuTarget.data;
			treeObj.expandAll();
			treeObj.refresh();
		}
	}
	//사용자 쿼리 등록
	else if(e.element.id === "MENU_SELECT_SQL"){
		if( $.fn.ifvmIsNotEmpty(curContextMenuTarget.data.attributeGroupColumnId)) {
			$("#logicalComponentPopupContainer").ifvsfPopup({
				enableModal : true
		        ,enableResize: false
		        ,allowKeyboardNavigation : false
		        ,contentUrl: "<ifv:url name='logicalComponentSelectSqlAttributeSettingPop'/>"
		        ,contentType: "ajax"
		        ,title: '<spring:message code="M02953"/>'
		        ,width: 500
		        ,close : 'logicalComponentPopClose'
		    });
			
			logicalComponentPopupContainer = $("#logicalComponentPopupContainer").data("ejDialog");
		} else {
			alert("<spring:message code='M02955' />");		
		}
	}
}
		
// 키 설정 여부 확인
function isCanUseSegmentDateKey(id){
	
	// 이미 세그먼트가 설정 되어 있는지 확인
	var isExistsSegKey = false;
	var isExistsDateKey = false;
	var isExistsEvtTriggerKey = false;
	var isExistsSelfKey = false;

	var treeObj = $("#attributeTree").data("ejTreeView");
	var newTreeData = treeObj.getTreeData();
	newTreeData.forEach(function(item, index){

		// 자기자신에 대한 체크
		if(item.id === id){
			if(item.dateKeyYn === "1"){
				isExistsSelfKey = true;
			}
			if(item.segKeyYn === "1"){
				isExistsSelfKey = true;
			}
			if(item.evtTriggerKeyYn === "1"){
			    isExistsSelfKey = true;
			}
		}
		if(item.segKeyYn === "1"){
			isExistsSegKey = true;
		}
		if(item.dateKeyYn === "1"){
			isExistsDateKey = true;
		}
		if(item.evtTriggerKeyYn === "1"){
		    isExistsEvtTriggerKey = true;
		}
	});
	
	var res = {
		 isExistsSegKey : isExistsSegKey
		,isExistsDateKey : isExistsDateKey
		,isExistsSelfKey : isExistsSelfKey
		,isExistsEvtTriggerKey : isExistsEvtTriggerKey
	}
	
	return res;
}

// 어트리뷰트 그룹 리스트 가져오기
function getAtribGroupList(){
	
	var atribGroupList = new Array();
	
	var idx = 0;
	var dataList = $("#attributeTree").data("ejTreeView").getTreeData();
	dataList.forEach(function(treeNode){
		if(treeNode.colType === "P"){
			var atribGroup = {
				 attributeGroupId : treeNode.atribGroupId||""
				,tempAttributeGroupId : treeNode.tempAttributeGroupId||""
				,atribGroupNm : treeNode.text
				,seq : idx++
				,lgcCompId : lgcCompData.lgcCompId
			}
			atribGroupList.push(atribGroup);
		}
	});
	
	return atribGroupList;
}

//어트리뷰트 그룹 칼럼 리스트 가져오기
function getAtribGroupColumnList(){
	
	var atribGroupColumnList = new Array();
	
	var idx = 0;
	var dataList = $("#attributeTree").data("ejTreeView").getTreeData();
	dataList.forEach(function(treeNode) {
		if(treeNode.colType === "C"){
			var atribColGroup = {
				 atribGroupId : treeNode.parentId
				,attributeGroupColumnId : treeNode.attributeGroupColumnId
				,tempAttributeGroupColumnId : treeNode.tempAttributeGroupColumnId
				,dpNm : removeSubfixKeyVal(treeNode.text)
				,seq : idx++
				,lgcCompId : treeNode.lgcCompId
				,lgcCompTblRelId : treeNode.lgcCompTblRelId
				,tblAliasColNm : treeNode.tblAliasColNm
				,colId : treeNode.colId
				,dimColId : ""
				,calDtl : treeNode.calDtl
				,calDtlHis : treeNode.calDtlHis
				,calColYn : treeNode.calColYn
				,segKeyYn : treeNode.segKeyYn
				,dateKeyYn : treeNode.dateKeyYn 
				,evtTriggerKeyYn : treeNode.evtTriggerKeyYn
				,sqlValue : treeNode.sqlValue

			}
			atribGroupColumnList.push(atribColGroup);
		}
	});
	
	return atribGroupColumnList;
}

// 저장 후 데이터 셋 변경
function afterEditLogicalComponentAttribute(reqDto){
	
	var treeObj = $("#attributeTree").data("ejTreeView");
	var treeDataList = treeObj.getTreeData();
	
	var newTreeDataList = new Array();
	treeDataList.forEach(function(item){
		if(item.colType === "P"){
			item.attributeGroupId = (item.tempAttributeGroupId !== "") ? item.tempAttributeGroupId : item.attributeGroupId;
			item.tempAttributeGroupId = "";
		} else {
			item.attributeGroupColumnId = (item.tempAttributeGroupColumnId !== "") ? item.tempAttributeGroupColumnId : item.attributeGroupColumnId;
			item.tempAttributeGroupColumnId = "";
		}
		newTreeDataList.push(item);
	});
	
	treeObj.dataSource(newTreeDataList);
	treeObj.refresh();
}

// 저장여부를 물어봐야하는지 확인
function isNeedAtribTabSaveAlert(){
	
	var isNeed = false;

	// 노드 드랍 여부
	if(isNodeDropped){
		isNeed = true;
	}
	
	// 컨텍스트 클릭 여부 확인
	if(isContextClicked){
		isNeed = true;
	}
	
	return isNeed;
}

//로지컬 컴포넌트 아코디언 트리 사이즈 설정
function setAttributeTabScrollResize() {
    var height = $(".analysis_wrap").outerHeight() - 40;
    
    $("#divAttributeAccordianTreeContainer").css("height", height);
  	//스크롤 생성
    /* $("#divAttributeAccordianTreeContainer").ejScroller({
        height: height
    });
  	
    var scrollobj = $("#divAttributeAccordianTreeContainer").data("ejScroller");
    scrollobj.refresh();  */
}

// 세그먼트, 기준날짜 키 값 제거
function removeSubfixKeyVal(str){
	return str.replace(SUBFIX_SEG_KEY, "").replace(SUBFIX_DATE_KEY, "").replace(SUBFIX_EVT_TRIGGER_KEY, "");
}

// 어트리뷰트 그룹 탭 초기화
function logicalAttributeGroupTab_Init(){
	setLeftAccodianTree();
	setAttributeTree();
	setContext();
	
 	// 왼쪽 어코디언 메뉴 리사이즈 시 스크롤을 다시 그림
 	$(window).bind('resize', function () {
        //로지컬 컴포넌트 리사이즈
        setAttributeTabScrollResize();
    });
}

$(document).ready(function() {
	logicalAttributeGroupTab_Init();
});

</script>

<div class="analysis_wrap clear_wrap">
	<div class="analysis_tree">
		<div id="divAttributeAccordianTreeContainer" style="overflow-y:auto;">
			<div id="attributeAccordianTree" class="logical_component_tree"></div>
		</div>
	</div>
	<div class="dashboard_wrap chart_wrap">
		<div id="attributeDashboard" class="dashboard_area"></div>
	</div>
</div>

<ul id="attributeGroupContextMenu" class="right_mou_list" ></ul>
<ul id="attributeGroupTreeNodeContextMenu" class="right_mou_list" ></ul>