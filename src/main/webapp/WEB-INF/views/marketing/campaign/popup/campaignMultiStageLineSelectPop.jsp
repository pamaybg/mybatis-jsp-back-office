<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

	var lineSelectPopData = {
	};
	
	// 커넥터 생성
	function lineSelected(type) {
        var item = getPaletteItemByName(type);
        if (item) {
            var name = $.ifvmGetRowID();//item.name + ej.datavisualization.Diagram.Util.randomId();

            var nodeData = new NodeDataClass();
            nodeData.nodeName = name;
            nodeData.nodeId = item.addInfo.nodeId;
            nodeData.taskId = name;
            
            node = {
				name: name,
				segments: item.segments,
				cornerRadius: 10,
				sourceNode: lineSelectPopData.sourceNode,
				targetNode: lineSelectPopData.targetNode,
				targetDecorator: item.targetDecorator,
				lineWidth: item.lineWidth,
				lineDashArray: item.lineDashArray,
				lineColor: item.lineColor,
				labels: item.labels,
				constraints: item.constraints,
				addInfo: nodeData
            };
            
            diagram.add(node);
        }
	}

	$(document).ready(function() {
		$("#campaignMultiStageLineYes").click(function(evt) {
			lineSelected("yes");
			dialog._destroy();
		});
		
		$("#campaignMultiStageLineNo").click(function(evt) {
			lineSelected("no");
			dialog._destroy();
		});
	});
</script>

<div class="pop_inner_wrap">
	<div class="form-horizontal">
		<label>성공 여부에 따른 노드의 실행 유형을 선택해 주세요.</label>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="campaignMultiStageLineYes">
		Yes
	</button>
	<button class="btn btn-sm btn_gray" id="campaignMultiStageLineNo">
		No
	</button>
</div>