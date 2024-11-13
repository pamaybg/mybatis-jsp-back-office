<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link href="${pageContext.request.contextPath}/resources/css/kepler/segReport.css" rel="stylesheet" />

<script type="text/javascript">
var rowList = [];
var colList = [];
var crossColList = [];
var crossRowList = [];
var incRowList = [];
var incColList = [];
var dtlRowList=[];
var dtlPreMonList=[];
var dtlColList=[];

var segMstList=[];

//고객 세분화명 드롭다운리스트 가져오기
function getSegMstList(){
	    $.ifvSyncPostJSON('<ifvm:action name="getSegMstList"/>', {
	    }, function(result) {
	    	segMstList = result;
	    	setSegMstList();
	    });
}


//등급별 전이 추이 데이터 setting
function reportDataSetting(){
	    $.ifvSyncPostJSON('<ifvm:action name="getTransReport2"/>', {
	    	yyyymm : $("#year").val()+$("#mon").val()
	    	,segMstId : $("#segMstNm").val()
	    }, function(result) {
	    	var i = result.length-1
	    	colList = result[i].colList;
	    	rowList = result;
	    	tableSetting();
	    });
}

//교차 등급별 분포 데이터 setting
function crossReportDataSetting(){
    $.ifvSyncPostJSON('<ifvm:action name="getCrossReport"/>', {
    	yyyymm : $("#year").val()+$("#mon").val()
    }, function(result) {
    	var i = result.length-1
    	crossColList = result[i].colList;
    	crossRowList = result;
    	crossTableSetting();
    });
}
//전월 대비 등급별 증감 현황 데이터 setting
function incReportDataSetting(){
    $.ifvSyncPostJSON('<ifvm:action name="getIncReport"/>', {
    	yyyymm : $("#year").val()+$("#mon").val()
    }, function(result) {
    	var i = result.length-1
    	incColList = result[i].colList;
    	incRowList = result;
    	incTableSetting();
    });
}

//고객 세분화 등급 전이 추이 상세 data setting
function dtlReportDataSetting(){
	    $.ifvSyncPostJSON('<ifvm:action name="getCrossDtlReport"/>', {
	    	yyyymm : $("#year").val()+$("#mon").val()
	    }, function(result) {
	    	var i = result.length-1;
	    	dtlColList=result[i].colList;
	    	dtlPreMonList =result[i].preMonList;
	    	dtlRowList = result;
	    	dtlTableSetting();
	    });
}

function setSegMstList(){
	var segMstObj = {segMstId:'',segMstNm:''};
	
	for(var i=0;i<segMstList.length;i++){
		segMstObj.segMstId = segMstList[i].segMstId;
		segMstObj.segMstNm = segMstList[i].segMstNm;
		var segTemp = $("#segMstTemp").tmpl(segMstObj);
		$("#segMstNm").append(segTemp);
	}
	
}


//등급별 전이 추이 테이블 setting
function tableSetting(){
	$("#month").empty();
	$("#dynamicTr").empty();
	$("#dynamicTbody").empty();
	$("#title").empty();
	$("#foot").empty();
	
	var colHtml='';
	var rowHtml='';
	var titleObj = {colSpan:colList.length+2, title : "고객 세분화 등급 전이 추이"};
	var titleTemp = $("#titleTemp").tmpl(titleObj);
	$("#title").append(titleTemp);
	
	var month = $("#mon").val()+'월';
	var monHtml = '<th></th><th scope ="colgroup" colspan='+ colList.length+1+'>'+month+'</th>';
	$("#month").append(monHtml);
	colHtml+='<th>전월</th>'
	
	//헤더
	for(var i =0; i<colList.length;i++){
		colHtml+="<th class ='head1 'scope='col'>" + colList[i] + "</th>"
	}
	colHtml+='<th>합계</th>'
	$("#dynamicTr").append(colHtml);
	tfootHtml = "<tr><td style='background: #787878;color:#fff'>합계</td>"
	//body 데이터
	
	//열합계를 위한 배열,변수
	var sumRateArr= [];
	var sumCntArr= [];
	var k=0;
	
	
 	for(var i =0; i < colList.length; i++){
 		var rowSumObj = {rateSum:0, cntSum:0};
 		$("#dynamicTbody").append("<tr>");
 		var obj = {col : colList[i]};
 		var tdFrTemp = $("#tdFrTemp").tmpl(obj);
 		$("#dynamicTbody").append(tdFrTemp);
 		var curColored=0;
 		var max=0;
 		var f = true;
 		
 		for (var j=0; j <rowList.length; j++) {
 			if (colList[i] == rowList[j].preStageNm) {
 				var row = rowList[j];
 				row.id = j;
 				//합계
 				rowSumObj.rateSum+=Number(rowList[j].transRate);
 				rowSumObj.cntSum+=Number(rowList[j].transCnt);
 				rowSumObj.rateSum = (Math.round(rowSumObj.rateSum));
 				
 				var sumTemp = $("#sumTemp").tmpl(rowSumObj);
 				var tdTemp = $("#tdTemp").tmpl(row);
 			 	$("#dynamicTbody").append(tdTemp);
 		 		f = false;
 		 		
 		 	//각 행에서 가장 큰 rate 구하기	
	 		if(rowList[j].transRate>=max){
	 			max = rowList[j].transRate;
	 			curColored = j;
	 		}
 		  }
 		}
 		$("#dynamicTbody").append(sumTemp);
 		
 		//각 행에서 가장 큰 rate 색 넣기
 		$("#"+curColored).css("background", "#b3d9ff");
 		
 		
 		//데이터 없을때 공백
 		if (f) {
 			var tdTemp = $("#tdTemp").tmpl({});
		 	$("#dynamicTbody").append(tdTemp);
 		}
 			
 		sumRateArr[i]=0;
 		sumCntArr[i]=0;
 		for(var j=0;j<colList.length;j++){
 			var a = Number(rowList[k].transRate);
 			var b = Number(rowList[k].transCnt);
 			sumRateArr[i]+=a;
 			sumCntArr[i]+=b;
 			k++;
 		}
	 
		 tfootHtml+="<td>"+sumRateArr[i].toFixed(2)+"%<br>"+sumCntArr[i]+"</td>" 
	}
 		
 	tfootHtml+= "<td></td></tr>";
 	$("#foot").append(tfootHtml); 
 	 	
}

//교차 등급별 분포 테이블 setting
function crossTableSetting(){
	$("#crossTr").empty();
	$("#crossTbody").empty();
	$("#crossTitle").empty();
	var colHtml='';
	var rowHtml='';
	
	var titleObj = {colSpan:crossColList.length+1, title : "교차 등급별 분포"};
	var titleTemp = $("#titleTemp").tmpl(titleObj);
	$("#crossTitle").append(titleTemp);
	
	
	colHtml+='<th></th>'
	for(var i =0; i<crossColList.length;i++){
		colHtml+='<th>' + crossColList[i] + '</th>'
	}
	$("#crossTr").append(colHtml);
	var _this = "";
	
	var rows = [];
	
 	for(var i =0; i < crossRowList.length; i++){
 		var obj = crossRowList[i];
 		if (_this != obj.stageNm) {
 			_this = obj.stageNm;
 			
 			if (i != 0) {
 				$("#crossTbody").append("</tr>");
 				
 				for (var k=0; k < crossColList.length; k++) {
 					if (typeof rows[k] != "undefined") {
 						$("#crossTbody").append(rows[k]);
 					} else {
 						var tdTemp = $("#tdTemp").tmpl({});
 					 	$("#crossTbody").append(tdTemp);
 					}
 				}
 				
 				rowList = [];
 			}
 			
			if (i+1 != crossRowList.length) {
				$("#crossTbody").append("<tr>");
				
	 			var tmpObj = {col : obj.stageNm};
	 			var tdCrossFrTemp = $("#tdFrTemp").tmpl(tmpObj);
			 	$("#crossTbody").append(tdCrossFrTemp);
			}
 		}
 		
 		obj.id = i;
		var tdCrossTemp = $("#tdCrossTemp").tmpl(obj);
 		
		//template을 배열에 저장
 		rows[crossColList.indexOf(obj.rowNm)] = tdCrossTemp;
 	}
 	
}

//전월 대비 등급별 증감 현황 테이블 setting
function incTableSetting(){
	$("#incTr").empty();
	$("#incTbody").empty();
	$("#incTitle").empty();
	var colHtml='';
	var rowHtml='';
	
	var titleObj = {colSpan:crossColList.length+1, title : "전월 대비 등급별 증감 현황"};
	var titleTemp = $("#titleTemp").tmpl(titleObj);
	$("#incTitle").append(titleTemp);
	
	colHtml+='<th></th>'
	
	
	for(var i =0; i<incColList.length;i++){
		colHtml+='<th>' + incColList[i] + '</th>'
	}
	$("#incTr").append(colHtml);
	var _this = "";
	
	var rows = [];
	
 	for(var i =0; i < incRowList.length; i++){
 		var obj = incRowList[i];
 		if (_this != obj.rowStageNm) {
 			_this = obj.rowStageNm;
 			
 			if (i != 0) {
 				$("#incTbody").append("</tr>");
 				
 				for (var k=0; k < incColList.length; k++) {
 					if (typeof rows[k] != "undefined") {
 						$("#incTbody").append(rows[k]);
 					} else {
 						var tdTemp = $("#tdIncTemp").tmpl({});
 					 	$("#incTbody").append(tdTemp);
 					}
 				}
 				
 				rowList = [];
 			}
 			
			if (i+1 != incRowList.length) {
				$("#incTbody").append("<tr>");
				
	 			var tmpObj = {col : obj.rowStageNm};
	 			var tdCrossFrTemp = $("#tdFrTemp").tmpl(tmpObj);
			 	$("#incTbody").append(tdCrossFrTemp);
			}
 		}
 		
 		obj.id = i;
		var tdIncTemp = $("#tdIncTemp").tmpl(obj);
 		
		//template을 배열에 저장
 		rows[incColList.indexOf(obj.colStageNm)] = tdIncTemp;
 	}
 	
}
//등급별 전이 추이 상세 테이블 setting
function dtlTableSetting(){

		$("#dtlTitle").empty();
		$("#dtlMonth").empty();
		$("#dtlStageNm").empty();
		$("#dtlTr").empty();
		$("#dtlFoot").empty();
		$("#dtlTbody").empty();
		
		var colHtml='';
		var colHtmlDtl='';
		var titleObj = {colSpan:dtlColList.length*crossColList.length+3, title : "고객 세분화 등급 전이 추이 상세"};
		var titleTemp = $("#titleTemp").tmpl(titleObj);
		$("#dtlTitle").append(titleTemp);
		var colspan = dtlColList.length*crossColList.length +1;
		var preMonth = dtlRowList[0].preMonth;
		var monHtml = '<th rowspan=3 colspan=2>'+$("#year").val()+'년 '+$("#mon").val()+'월</th><th colspan='+ colspan +'>'
						+preMonth.substring(0,4)+'년 '+preMonth.substring(4)+'월</th>';
		$("#dtlMonth").append(monHtml);
		
		//footer
		var tfootHtml;

		
		
		//헤더
		for(var i =0; i<dtlColList.length;i++){
			colHtml+="<th class='head1' colspan='"+crossColList.length+"'>" + dtlColList[i] + "</th>";
			for(j=0;j<crossColList.length;j++){
				colHtmlDtl+="<th style='background:#BBBBBB;'>" + crossColList[j] + "</th>";
			}
		}
		colHtml+='<th rowspan=2>합계</th>'
		$("#dtlStageNm").append(colHtml);
		$("#dtlTr").append(colHtmlDtl);
	
		//body 데이터
		var preMonSumObj={lcRate:0, lcCnt:0}
		var k=0;
		var sumRateArr=new Array();
		var sumCntArr=new Array();
		for(var i=0;i<dtlColList.length;i++){
	
			$("#dtlTbody").append('<tr>');
			var obj = {col:dtlColList[i]};
			var rowSum=0;
			var tdFrTemp = $("#tdFrTemp").tmpl(obj);
			var preMonObj ={lcRate:dtlPreMonList[i].lcRate, lcCnt:dtlPreMonList[i].lcCnt}
	
			var preMonTemp = $("#tdPreMonTemp").tmpl(preMonObj);
			$("#dtlTbody").append(tdFrTemp);
			$("#dtlTbody").append(preMonTemp);
			
			
			var sumObj={rateSum:0, cntSum:0};
			
			for(var j=0;j<colspan-1;j++){
				if (i==0) {
					sumRateArr[j] = Number(dtlRowList[k].crossRate);
					sumCntArr[j] = Number(dtlRowList[k].crossCnt);
				} else {
					sumRateArr[j] += Number(dtlRowList[k].crossRate);
					sumCntArr[j] += Number(dtlRowList[k].crossCnt);
				}
				var row = dtlRowList[k];
				row.id = k;
				sumObj.rateSum+= Number(dtlRowList[k].crossRate);
				sumObj.cntSum+=Number(dtlRowList[k].crossCnt);
				sumObj.rateSum = Math.round(sumObj.rateSum);
				var tdTemp = $("#tdCrossTemp").tmpl(row);
				var sumTemp = $("#sumTemp").tmpl(sumObj);
				$("#dtlTbody").append(tdTemp);
				k++;
			}
			
			$("#dtlTbody").append(sumTemp);
			$("#dtlTbody").append('</tr>');
			preMonSumObj.lcRate+=dtlPreMonList[i].lcRate;
			preMonSumObj.lcCnt+=dtlPreMonList[i].lcCnt;
		}
		
	
		tfootHtml = "<td class = 'dg'>합계</td><td class='c'>"+preMonSumObj.lcRate.toFixed(2)+"%<br>"+preMonSumObj.lcCnt+"</td>"; 
		$("#dtlFoot").append(tfootHtml);
		for(var j=0;j<colspan-1;j++){
			var sumObj2={rateSum:0, cntSum:0};
			sumObj2.rateSum = sumRateArr[j].toFixed(2); 
			sumObj2.cntSum = sumCntArr[j]; 
			var sumTemp = $("#sumTemp").tmpl(sumObj2);
			$("#dtlFoot").append(sumTemp);
		}
		$("#dtlFoot").append('<td></td>');;
	 	
	 	
	 	
	
}

function test(i, j) {
	alert(i + j);
}



$(document).ready(function() {
	$.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("mon", "SETTLE_MONTH", null, null, true);

	
	
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth();
	month = month >= 10 ? month : '0' + month;
	$("#year").val(year);
	$("#mon").val(month);
	getSegMstList();
	reportDataSetting();
	crossReportDataSetting();
	incReportDataSetting();
	dtlReportDataSetting();
	
    $('#transReportSearchBtn').on('click', function() {
    	reportDataSetting();
    	crossReportDataSetting();
    	incReportDataSetting();
    	dtlReportDataSetting();
    	
     });
    
	
});	    
</script>

<script id="tdFrTemp" type="text/x-jquery-templ">
<td class ="fr" style="background:#9B9B9B; border-bottom:1px solid #fff; font-weight: normal; color:#fff;"> ${'${'}col}</td>
</script>

<script id="tdTemp" type="text/x-jquery-templ">
<td id="${'${'}id}"><a href="#" onclick="test('${'${'}transRate}','${'${'}transCnt}')"><span class = "c">${'${'}transRate}% <br> (${'${'}transCnt})<span></a></td>
</script>

<script id="tdCrossTemp" type="text/x-jquery-templ">
<td id="${'${'}id}">${'${'}crossRate}% <br> (${'${'}crossCnt})</td>
</script>
<script id="tdPreMonTemp" type="text/x-jquery-templ">
<td style="background:#EAEAEA; border-bottom:1px solid #fff;">${'${'}lcRate}%<br>(${'${'}lcCnt})</td>
</script>

<script id="tdIncTemp" type="text/x-jquery-templ">
{{if incRate=='U'}}<td id="${'${'}id}" style="color:#D70000;font-weight:normal">▲ ${'${'}crossRate}% <br> (${'${'}crossCnt})</a></td>
{{else}}<td id="${'${'}id}" style="color:#015DAD;font-weight:normal">▼ ${'${'}crossRate}% <br> (${'${'}crossCnt})</a></td>{{/if}}
</script>


<script id="sumTemp" type="text/x-jquery-templ">
<td style="background:#EAEAEA; border-bottom:1px solid #fff; font-weight:normal">${'${'}rateSum}%<br>(${'${'}cntSum})</td>
</script>

<script id = "titleTemp" type="text/x-jquery-templ">
<th colspan="${'${'}colSpan}" style="background:#fff; text-align:left; font-size:16px; font-family:NotoSans;color:#000000">
${'${'}title}</th>
</script>


<script id = "segMstTemp" type="text/x-jquery-templ">
<option value = "${'${'}segMstId}">${'${'}segMstNm}</option>
</script>


<div class="page-title">
	<h1>리포트 &gt; 고객 세분화 등급별 리포트</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>고객 세분화 등급별 리포트</span>
		</div>
	</div>
	<div class="row"></div>
	<div class="row">
		<div class="col-xs-10">
			<ifvm:inputNew type="select" id="segMstNm" names="segMstNm" label="M03001"
				labelClass="2" conClass="3" />
			<ifvm:inputNew type="select" id="year" names="year" label="L02393"
				labelClass="1" conClass="2" />
			<ifvm:inputNew type="select" id="mon" names="mon" label="L02394"
				labelClass="1" conClass="2" />
			<button class="btn btn-sm" id="transReportSearchBtn">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
		</div>
	</div>
	<div class="white_bg grid_bd0">
		<table id=dynamicTable class="type02">
			<thead>
				<tr id=title></tr>
				<tr id=month></tr>
				<tr id=dynamicTr></tr>
			</thead>
			<tbody id="dynamicTbody">
			</tbody>
			<tfoot id="foot">
			</tfoot>
		</table>
	</div>
	<div class="well">
		<div class="left">
			<div class="white_bg grid_bd0">
				<table id="crossReportTable" class="type02">
					<thead>
						<tr id="crossTitle"></tr>
						<tr id="crossTr"></tr>
					</thead>
					<tbody id="crossTbody"></tbody>
				</table>
			</div>
		</div>
		<div class="right">
			<div class="white_bg grid_bd0">
				<table id="incReportTable" class="type02">
					<thead>
						<tr id="incTitle"></tr>
						<tr id="incTr"></tr>
					</thead>
					<tbody id="incTbody"></tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="bottom">
		<div style="width: 100%; height: 100%; overflow: auto">
			<div class="white_bg grid_bd0">
				<table id=crossDtlTable class="type02">
					<thead>
						<tr id=dtlTitle>
						</tr>
						<tr id=dtlMonth></tr>
						<tr id=dtlStageNm></tr>
						<tr id=dtlTr></tr>
					</thead>
					<tbody id="dtlTbody">
					</tbody>
					<tfoot>
						<tr id="dtlFoot"></tr>

					</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>
