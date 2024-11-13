<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src="/resources/js/tableDummy.js" type="text/javascript"></script>

<div class="page_btn_area">
	<div class="col-xs-2">
		<span>이벤트 성과 분석</span>
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" text="L00030" btnType="search" btnFunc="getTableData" />
	</div>
</div>
<div class="well form-horizontal underline" id="popSearchArea">
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="popType1" dto="popType1" label="고객유형" labelClass="1" conClass="2" nuc="true" required="true"/>
		<ifvm:inputNew type="select" id="popType2" dto="popType2" label="조회대상" labelClass="1" conClass="2" nuc="true" required="true"/>
		<ifvm:inputNew type="select" id="popEraSearchType" dto="popEraSearchType" label="조회방식" labelClass="1" conClass="2" nuc="true" required="true"/>
		<ifvm:inputNew type="select" id="popEraSearchTerm" dto="popEraSearchTerm" label="조회기간" labelClass="1" conClass="2" nuc="true" required="true"/>
	</div>
</div>
<div class="page_btn_area">
	<div class="col-xs-2">
		<span>조회결과</span>
	</div>
</div>
<div>
	<div id="eventResultAnalysisList" class="table_wrap custom_table">
		<table>
			<thead>
				<tr>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
	<div id="eventResultAnalysisChart" style="width: 100%; height: 300px;"></div>
</div>

<script>
var validation;
function setDropDownOption() {
	//ajax 통신 가정
	var optionArr1 = [
        {codeName: "NA", markName: "전체"},
        {codeName: "1", markName: "회원"},
        {codeName: "2", markName: "비회원"},
    ];

	var optionArr2 = [
        {codeName: "1", markName: "응모자"},
        {codeName: "2", markName: "당첨자"},
    ];

	var optionArr3 = [
        {codeName: "1", markName: "전후비교"},
        {codeName: "2", markName: "대조군비교"},
    ];

	var optionArr4 = [
        {codeName: "1", markName: "+1"},
        {codeName: "2", markName: "+2"},
        {codeName: "3", markName: "+3"},
        {codeName: "4", markName: "+4"},
        {codeName: "5", markName: "+5"},
        {codeName: "6", markName: "+6"},
        {codeName: "7", markName: "+7"},
        {codeName: "8", markName: "+8"},
        {codeName: "9", markName: "+9"},
        {codeName: "10", markName: "+10"},
        {codeName: "11", markName: "+11"},
        {codeName: "12", markName: "+12"},
    ];

	var option1 = $('#commCodeSelectTemplate').tmpl(optionArr1);
	$('#popType1').append(option1);

	var option2 = $('#commCodeSelectTemplate').tmpl(optionArr2);
	$('#popType2').append(option2);

	var option3 = $('#commCodeSelectTemplate').tmpl(optionArr3);
	$('#popEraSearchType').append(option3);

	var option4 = $('#commCodeSelectTemplate').tmpl(optionArr4);
	$('#popEraSearchTerm').append(option4);
}

function getTableData() {
	validation = $('#popSearchArea').ifvValidation();
	if(!validation.confirm()) return;
	var sData = $('#popSearchArea').getSubmitData();
	var rData = makeDummy(sData);
	setTableData(rData);
	setChart(rData);
}

function getKeyByCode(code) {
	var key;
	switch(code) {
	case "all" :
		key = '전체(T)';
		break;
	case "personal" :
		key = '인당(L)';
		break;
	case "vote" :
		key = '응모(T)';
		break;
	case "notvote" :
		key = '미응모(T)';
		break;
	case "diff" :
		key = '차이(T)';
		break;
	}

	return key;
}

function setTableData(data) {
	var dummyObj = {};
	var rows = [];
	var typeArr = [];
	for(var key in data.rows){
		var rowData = {};
		rowData.typeName = getKeyByCode(key);
		rowData.targetCnt = data.rows[key]["targetCnt"];

		//이전데이터
		for(var j = -data.eraSearchTerm; j < 0; j++) {
			rowData["M" + j] = data.rows[key]["M" + j];
		}
		rowData["M"] = data.rows[key]["M"];
		for(var j = 1; j <= data.eraSearchTerm; j++) {
			rowData["M+" + j] = data.rows[key]["M+" + j];
		}
		rowData.incQnty = data.rows[key]["incQnty"];
		rows.push(rowData);
	}
	dummyObj.rows = rows;
	dummyObj.eraSearchType = data.eraSearchType;
	dummyObj.eraSearchTerm = data.eraSearchTerm;
	dummyObj.openDate = data.defaultInfo.openDate;
	dummyObj.eventName = data.defaultInfo.eventName;

	setTable(dummyObj);
}

function setTable(data) {
	var tableWrap = $('#eventResultAnalysisList');
	var $thead = tableWrap.find('thead > tr');
	var $tbody = tableWrap.find('tbody');
	var numReg = /\B(?=(\d{3})+(?!\d))/g;

	$thead.empty();
	$tbody.empty();

	//head setting start
	//고정헤더 앞 3개
	$thead.append('<th>게시시기</th>');
	$thead.append('<th>이벤트명</th>');
	$thead.append('<th colspan="2">대상자수</th>');
	//가변헤더
	for(var i = -data.eraSearchTerm; i < 0; i++) {
		$thead.append('<th>M' + i + '</th>');
	}
	$thead.append('<th class="th-color1">M-' + data.eraSearchTerm + '누계</th>');
	$thead.append('<th class="th-color2">M</th>');
	for(var i = 1; i <= data.eraSearchTerm; i++) {
		$thead.append('<th colspan="2">M+' + i + '</th>');
	}
	$thead.append('<th colspan="2">M+' + data.eraSearchTerm + '누계</th>');
	$thead.append('<th>증대물량</th>');
	//head setting end

	//body setting start
	var bodyRowspan;
	data.eraSearchType == 1 ? bodyRowspan = 2 : bodyRowspan = 3;
	data.rows.forEach(function(item, index) {
		var tr = $('<tr>');
		var beforeSum = 0;
		var afterSum = 0;
		if(index == 0) {
			tr.append('<td class="tac" rowspan="' + bodyRowspan + '">' + data.openDate + '</td>');
			tr.append('<td rowspan="' + bodyRowspan + '">' + data.eventName + '</td>');
		}

		tr.append('<td>' + item.typeName + '</td>');
		tr.append('<td class="tar">' + item.targetCnt.toString().replace(numReg, ',') + '</td>');
		for(var i = -data.eraSearchTerm; i < 0; i++) {
			tr.append('<td class="tar">' + item['M' + i].toString().replace(numReg, ',') + '</td>');
			beforeSum += item['M' + i];
		}

		tr.append('<td class="td-color1 tar">' + beforeSum.toString().replace(numReg, ',') + '</td>');
		tr.append('<td class="td-color2 tar">' + item.M.toString().replace(numReg, ',') + '</td>');

		for(var i = 1; i <= data.eraSearchTerm; i++) {
			tr.append('<td class="tar">' + item['M+' + i].toString().replace(numReg, ',') + '</td>');
			var per = (Math.round((item["M+" + i] * 100 / item.targetCnt) * 100) / 100) + "%";
			tr.append('<td class="tar">' + per + '</td>');
			afterSum += item['M+' + i];
		}

		tr.append('<td class="tar">' + afterSum.toString().replace(numReg, ',') + '</td>');
		var totPer = (Math.round((afterSum * 100 / item.targetCnt) * 100) / 100) + "%";
		tr.append('<td class="tar">' + totPer + '</td>');
		tr.append('<td class="tar">' + item.incQnty + '</td>');
		$tbody.append(tr);
	});
}

function setChart(data) {
	if(window.eventResultAnalysisChart.pluginName) { window.eventResultAnalysisChart._destroy();}
	var termData = {};
	for(var key in data.rows){
		var rowData = {};

		//이전데이터
		for(var j = -data.eraSearchTerm; j < 0; j++) {
			rowData["M" + j] = data.rows[key]["M" + j];
		}
		rowData["M"] = data.rows[key]["M"];
		for(var j = 1; j <= data.eraSearchTerm; j++) {
			rowData["M+" + j] = data.rows[key]["M+" + j];
		}
		termData[key] = rowData;
	}

	var chartData = [];
	for (var key in termData) {
		if(key == "diff") continue;
	   var item = {};
	   item.name = getKeyByCode(key);
	   item.points = [];
	   for (var subkey in termData[key]) {
	      var obj = {};
	      obj.x = subkey;
	      obj.y = termData[key][subkey];

	      item.points.push(obj);
	   }
	   chartData.push(item);
	}
	if(window.eventResultAnalysisChart.pluginName) {
		var eraChart = $('#eventResultAnalysisChart').ejChart('instance');
		eraChart.model.series = chartData;
		eraChart.redraw();
	} else {
		$("#eventResultAnalysisChart").ifvsfChart({
	        primaryXAxis:
	         {
	         },
	         primaryYAxis:{
	         },
	         commonSeriesOptions:
	         {
	             type: 'line', enableAnimation: true,
	             tooltip:{ visible :true, template:'Tooltip'},
	             border : {width: 2}
	         },
	         series: chartData,
	         isResponsive: true,
	         title :{text: data.eventName},
	         size: { height: "300" },
	         legend: { visible: true}
	     });
	}
}

$(document).ready(function() {
	setDropDownOption();
});

</script>