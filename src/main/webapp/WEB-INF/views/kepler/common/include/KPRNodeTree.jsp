<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	$.fn.ifvmCreateKPRNodeTree = function( options ) {
		var _this = this;
		window[ _this.attr( "id" ) ];
	
		this.opt = $.extend({
			targetUrl: "<ifv:action name='getNodeList' />"
			, target: null
			, targetId: null
			, reportFlag: "N"
			, fields: {
				id: "nodeId"
				, parentId: "parNodeId"
				, text: "nodeText"
				, expanded: "expandedFlag"
			}
			, template : "#baseTreeTemplate"
		}, options);
	
		this.init = function() {
			var opt = this.opt;
			opt.target = $( "#" + opt.targetId ).ifvsfTree( opt );
	
			$.ifvPostJSON( opt.targetUrl, {
				reportFlag: opt.reportFlag
			}, function( rst ) {
				var thisTreeView = opt.target.data( "ejTreeView" );
	
				var nodeList = rst.nodeList;
				nodeList.forEach(function( thisObj, idx ) {
					thisObj.nodeId = opt.targetId + "_" + thisObj.nodeId;
	
					if( $.fn.ifvmIsNotEmpty( thisObj.parNodeId ) ) {
						thisObj.parNodeId = opt.targetId + "_" + thisObj.parNodeId;
					}
				});
	
				thisTreeView.dataSource( rst.nodeList );
				thisTreeView.refresh();
			});
		};
	
		this.init();
	
		return this;
	};
	
	$.fn.ifvmKPRNodeTreeSetButton = function() {
		var treeView = $( this ).data( "ejTreeView" );
		treeView.model.nodeSelect = function( args ) {
			var targetId = $( this.element ).attr( "id" );
			var thisId = args.id;
			var thisText = args.value;
			var nodeList = this.getTreeData();
			var thisNode = nodeList.filter(function( nodeObj ) {
				return nodeObj.nodeId === thisId;
			});
	
			var thisNodeType = thisNode[0].nodeType;
			var thisModifyFlag = thisNode[0].modifyFlag;
			var thisMyFolderFlag = thisNode[0].myFolderFlag;
	
			var thisElement = $( args.currentElement );
			var addBtn = thisElement.find( "[btnId=plus]" );
			var modifyBtn = thisElement.find( "[btnId=modify]" );
			var deleteBtn = thisElement.find( "[btnId=minus]" );
	
			if( thisNodeType === "F" ) {
				if( addBtn ) {
					if( !$( addBtn ).hasTriggerEvent( "click" ) ) {
						addBtn.click(function( evt ) {
							createFolderAddPop( "ADD", targetId, $.ifvmGetRowID(), "", thisId, thisMyFolderFlag );
						});
					}
				}
	
				if( modifyBtn && thisModifyFlag ) {
					if( !$( modifyBtn ).hasTriggerEvent( "click" ) ) {
						modifyBtn.click(function( evt ) {
							thisText = $.trim( thisText );
							createFolderAddPop( "MODIFY", targetId, thisId, thisText, null, thisMyFolderFlag );
						});
					}
				} else {
					modifyBtn.remove();
				}
	
				if( deleteBtn && thisModifyFlag ) {
					if( !$( deleteBtn ).hasTriggerEvent( "click" ) ) {
						deleteBtn.click({
							nodeId: thisId
						}, function( evt ) {
							var nodeId = evt.data.nodeId;
							nodeId = nodeId.substring( ( targetId + "_" ).length );
							
							$.ifvPostJSON( "<ifv:action name='removeFolder' />", {
								nodeId: nodeId
							}, function( rst ) {
								alert( "<spring:message code='M00003' />" );
	
								var treeObj = $( "#" + targetId ).data( "ejTreeView" );
								treeObj.removeNode( thisId );
							}, function( rst ) {
								alert( rst.message );
							});
						});
					}
				} else {
					deleteBtn.remove();
				}
			} else {
				addBtn.remove();
				modifyBtn.remove();
				deleteBtn.remove();
			}
		};
	};
	
	var createFolderAddPop = function( mode, targetId, nodeId, nodeText, parNodeId, myFolderFlag ) {
		var nodePopup = $( "#nodePopId" );
		var tempPop = null;
	
		if( !$.fn.ifvmIsNotEmpty( nodePopup ) ) {
			tempPop = $( "<div>" );
			tempPop.attr( "id", "nodePopId" );
			tempPop.addClass( "popup_container" );
			$( "body" ).append( tempPop );
		}
	
		$( "#nodePopId" ).ifvsfDialog({
			enableModal: true
			, enableResize: false
			, contentUrl: "<ifv:url name='folderDetailPop' />"
			, contentType: "ajax"
			, title: "폴더 저장"
			, width: 400
			, beforeOpen: function( data ) {
				$( "#fParNodeId" ).val( parNodeId );
				$( "#fNodeId" ).val( nodeId );
				$( "#fNodeText" ).val( nodeText );
				$( "#fMyFolderFlag" ).val( myFolderFlag );
				nodeTreeId = targetId;
				triggerMode = mode;
			}
			, close: function( data ) {
				folderDetailPopCon.destroy();
			}
		});
	
		folderDetailPopCon = $( "#nodePopId" ).data( "ejDialog" );
	};
</script>