<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var folderDetailPopCon;
	var triggerMode;
	var nodeTreeId;

	$(document).ready(function() {
		$( "#folderSaveBtn" ).on( "click", function() {
			var targetUrl;
			if ( triggerMode == "ADD" ) {
				targetUrl = "<ifv:action name='addFolder' />";
			} else {
				targetUrl = "<ifv:action name='editFolder' />";
			}
			
			var nodeId = $( "#fNodeId" ).val();
			var nodeIndex = nodeId.indexOf( nodeTreeId + "_" );
			
			if( nodeIndex > -1 ) {
				nodeId = nodeId.substring( ( nodeTreeId + "_" ).length );
			}
			
			var parNodeId = $( "#fParNodeId" ).val();
			var parNodeIndex = parNodeId.indexOf( nodeTreeId + "_" );
			
			if( parNodeIndex > -1 ) {
				parNodeId = parNodeId.substring( ( nodeTreeId + "_" ).length );
			}
			
			$.ifvPostJSON( targetUrl, {
				nodeId: nodeId
				, parNodeId: parNodeId
				, nodeText: $( "#fNodeText" ).val()
				, myFolderFlag: $( "#fMyFolderFlag" ).val()
			}, function( rst ) {
				alert( "<spring:message code='C00094' />" );
				var treeObj = $( "#" + nodeTreeId ).data( "ejTreeView" );
				
				if( triggerMode == "ADD" ) {
					var targetObj = {
						nodeId: nodeTreeId + "_" + $( "#fNodeId" ).val()
						, parNodeId: $( "#fParNodeId" ).val()
						, nodeText: $( "#fNodeText" ).val()
						, myFolderFlag: $( "#fMyFolderFlag" ).val()
						, modifyFlag: true
						, expandedFlag: false
						, nodeType: "F"
					};
					treeObj.addNode( targetObj, $( "#fParNodeId" ).val() );
					treeObj.refresh();
				} else {
					treeObj.updateText( $( "#fNodeId" ).val(), $( "#fNodeText" ).val() );
				}
				
				folderDetailPopCon.close();
			});
		});
		
		$( "#folderCancelBtn" ).on( "click", function() {
			folderDetailPopCon.close();
		});
	});
</script>

<div class="pop_inner_wrap">
	<div>
		<div id="chartLabelDetailArea" class="analysis_setup_prompt form-horizontal">
			<div class="row">
				<label class="col-xs-3 control-label text-right"><spring:message code="M01536" /></label>
	
				<div class="col-xs-9 control_content">
					<ifv:input type="hidden" id="fParNodeId" />
					<ifv:input type="hidden" id="fNodeId" />
					<ifv:input type="hidden" id="fMyFolderFlag" />
					<ifv:input type="text" id="fNodeText" />
				</div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="folderSaveBtn">
		<i class="glyphicon glyphicon-check"></i> <spring:message code='M00137' />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="folderCancelBtn"><spring:message code='M00171' /></button>
</div>