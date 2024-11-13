/*!
 * Infavor Diagram palettes
 * Copyright Jung Suk kim
 * v1.0.0
 */

 
var constraints = ej.datavisualization.Diagram.NodeConstraints.Select 
				| ej.datavisualization.Diagram.NodeConstraints.Delete
				| ej.datavisualization.Diagram.NodeConstraints.Connect
				| ej.datavisualization.Diagram.NodeConstraints.Drag;

var connectorConstraints = ej.datavisualization.Diagram.ConnectorConstraints.Select 
						| ej.datavisualization.Diagram.ConnectorConstraints.Delete
						| ej.datavisualization.Diagram.ConnectorConstraints.DragSourceEnd
						| ej.datavisualization.Diagram.ConnectorConstraints.DragTargetEnd
						| ej.datavisualization.Diagram.ConnectorConstraints.Drag
						| ej.datavisualization.Diagram.ConnectorConstraints.Bridging
						;

connectorConstraints = ej.datavisualization.Diagram.ConnectorConstraints.Default 
;

//팔레트를 구성
function setPalettes(palettesData) {
	var palettes = [];
	var mPalettes = [];
	var mItems = [];
	//palettes 구성
	$.each(palettesData, function(index, data) {
		var items = [];
		//palettes node item 구성
		$.each(data.nodeList, function(index, item) {
			var itemSet = {};

			//유형별 노드
			itemSet = getNodeByType("P_NODE", item);
			
			items.push(itemSet);
			mItems.push(itemSet);
		});
		
		//palettes connector item 구성
		$.each(data.connectorList, function(index, item) {
			
			//유형별 노드
			itemSet = getNodeByType("P_CONNECTOR", item);
			
			items.push(itemSet);
			mItems.push(itemSet);
		});
		var expanded = index == 0 ? 1 : 0;
		palettes.push( {name: data.paletteTypeName, expanded: expanded, items: items} );
	});
	
	mPalettes.push( {name: "mPalettes", expanded: 1, items: mItems} );
	
	window.diagramPaletteCollection2 = mPalettes;
	window.diagramPaletteCollection = palettes;
}

//유형별 노드
function getNodeByType(type, item) {
	var itemSet = {};
	
	if (type.match("NODE")) {
		//NodeDataClass 정의 설정
		var nodeData = new NodeDataClass();
		
		//palette or task 구분
		//palette
		if (type == "P_NODE") {
			nodeData.nodeId = item.id;
			nodeData.nodeName = item.nodeName;
			nodeData.nodeType = item.nodeTypeCode;
			nodeData.title = item.nodeTypeName;
			nodeData.text = item.nodeDesc;
			nodeData.htmlTemplateId = item.htmlTemplateId;
			nodeData.imageSource = item.imageSource;
			nodeData.nodeDesc = item.nodeDesc;
			nodeData.fillColor = item.fillColor;
			nodeData.connectSeq = stringToNumber(item.connectSeq);
			nodeData.paletteTypeCode = item.paletteTypeCode;
		}
		//task
		else if (type == "T_NODE") {
	        nodeData.nodeId = item.nodeId;
	        nodeData.nodeName = item.id;
	        nodeData.nodeType = item.nodeTypeCode;
	        nodeData.taskId = item.id;
	        nodeData.taskType = item.taskTypeCode;
	        nodeData.title = item.nodeTypeName;
	        nodeData.text = item.nodeDesc;
	        nodeData.htmlTemplateId = item.htmlTemplateId;
	        nodeData.imageSource = item.imageSource;
	        nodeData.nodeDesc = item.nodeDesc;
	        nodeData.fillColor = item.fillColor;
	        nodeData.connectSeq = stringToNumber(item.connectSeq);
	        nodeData.paletteTypeCode = item.paletteTypeCode;
	        
	        item.nodeName = item.id;
		}
		
		$.each(item.handleList, function(index, handle) {
			nodeData.handleList.push(handle);
		});
		item.nodeData = nodeData;
		
		var readOnly = item.labelReadOnly == '0' ? false : true;
		item.readOnly = readOnly;
		
        //좌표 String Number 형변환
        var offsetX = stringToNumber(item.offSetX) | 20;
        item.offsetX = offsetX;
        var offsetY = stringToNumber(item.offSetY) | 20;
        item.offsetY = offsetY;
        var nodeConstraints = constraints;
        item.nodeConstraints = nodeConstraints;
        
        var defaultPort = getDefaultPort();
		
		// 이미지 또는 html 유형
		if (item.shapeTypeCode == "IMAGE" || item.shapeTypeCode == "HTML") {
			var shapeType = item.shapeTypeCode == "HTML" ? ej.datavisualization.Diagram.Shapes.Html : item.shapeTypeCode == "IMAGE" ? ej.datavisualization.Diagram.Shapes.Image : "";
			
			itemSet = { 
				name: item.nodeName,
				width: stringToNumber(item.width),
				height: stringToNumber(item.height),
				type: shapeType,
				source: item.imageSource,
				templateId : item.htmlTemplateId,
				borderWidth: item.borderWidth,
				labels: [{ readOnly: readOnly, offset: {x: 0.5, y:1} }],
				constraints : item.nodeConstraints,
				offsetX: item.offsetX, offsetY: item.offsetY,
				addInfo: item.nodeData,
				ports: defaultPort
			};
		}
		// polygon 유형
		else if (item.shapeTypeCode == "POLYGON") {
			//points 값을 구한다
			var points = stringToJSONObject(item.points);
			//points JSON 값이 없다면 쉐이프를 추가 하지 않는다.
			if (points != "") {
				//points x,y 스트링 값을 숫자로 변환
				$.each(points, function() {
					this.x = stringToNumber( this.x );
					this.y = stringToNumber( this.y );
				});
				
				itemSet = {
					name: item.nodeName, 
					width: stringToNumber(item.width),
					height: stringToNumber(item.height),
					fillColor: item.fillColor,
					borderColor: item.borderColor,
					borderWidth: item.borderWidth,
					shape: "polygon",
					labels: [{ text: item.labelText, readOnly: item.readOnly, offset: {x: 0.5, y:1} }],
					offsetX: item.offsetX, offsetY: item.offsetY,
					constraints : item.nodeConstraints,
					addInfo: item.nodeData,
					ports: defaultPort,
					
					points: points
					
				};
			}
		} 
		// path 유형
		else if (item.shapeTypeCode == "PATH") {
			itemSet = {
				name: item.nodeName,
				width: stringToNumber(item.width),
				height: stringToNumber(item.height),
				
				shape: "path", 
				pathData: item.imagePathData,
				borderWidth: item.borderWidth,
				borderColor: item.borderColor,
				fillColor: item.fillColor,
				
				htmlTemplateId : item.htmlTemplateId,
				labels: [{ text: item.labelText, readOnly: item.readOnly, offset: {x: 0.5, y:1} }],
				offsetX: item.offsetX, offsetY: item.offsetY,
				constraints : item.nodeConstraints,
				addInfo: item.nodeData,
				ports: defaultPort
			};
		} 
	}
	
	//connector 유형
	else if (type.match("CONNECTOR")) {
		//NodeDataClass 정의 설정
		var nodeData = new NodeDataClass();
		
		//palette or task 구분
		//palette
		if (type == "P_CONNECTOR") {
			nodeData.nodeId = item.id;
			nodeData.nodeName = item.connectorName;
			nodeData.nodeType = "connector";
			nodeData.title = item.connectorName;
			nodeData.htmlTemplateId = item.htmlTemplateId;
			nodeData.imageSource = item.imageSource;
			nodeData.nodeDesc = item.connectorDesc;
		}
		//task
		else if (type == "T_CONNECTOR") {
	        nodeData.nodeId = item.connectorId;
	        nodeData.nodeName = item.id;
	        nodeData.nodeType = "connector";
	        nodeData.taskId = item.id;
	        nodeData.taskType = item.taskTypeCode;
	        nodeData.title = item.connectorName;
	        item.connectorName = item.id;
	        nodeData.nodeDesc = item.connectorDesc;
		}
		
		item.nodeData = nodeData;
		
		var readOnly = item.labelReadOnly == '0' ? false : true;
		item.readOnly = readOnly;
		
		item.sourceNode = isNotEmpty(item.sourceNode) ? item.sourceNode : "";
		item.sourcePointX = stringToNumber(item.sourcePointX) | 0;
		item.sourcePointY = stringToNumber(item.sourcePointY) | 0;
		
		item.targetNode = isNotEmpty(item.targetNode) ? item.targetNode : "";
		item.targetPointX = stringToNumber(item.targetPointX) | 40;
		item.targetPointY = stringToNumber(item.targetPointY) | 40;
		
		item.lineWidth = stringToNumber(item.lineWidth) | 0;
		
		var labels = [{ readOnly: item.readOnly}];
		
		if ($.fn.ifvmIsNotEmpty(item.labelText)) {
			labels[0].text = item.labelText;
			labels[0].fillColor = "white";
		}
		
		itemSet = { 
				name: item.connectorName,
				segments: [{ type: item.segmentTypeName }],
				cornerRadius: 10,
				sourceNode: item.sourceNode,
				sourcePoint: { x: item.sourcePointX, y: item.sourcePointY },
				targetNode: item.targetNode,
				targetPoint: { x: item.targetPointX, y: item.targetPointY }, 
				targetDecorator: { shape: "arrow" },
				lineWidth: item.lineWidth,
				lineDashArray: item.lineDashArray,
				lineColor: item.lineColor,
				labels: labels,
				addInfo: item.nodeData,
				constraints: connectorConstraints
			};
	}
	
	return itemSet;
}
