<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src='${pageContext.request.contextPath}/resources/js/kepler/customerAnalysis/makeCustListTable.js' type="text/javascript"></script>

<script>

function getAnalysisListBycustTier(){
	var srchYM = $("#searchYear").val() + $("#searchMonth").val();
	var srchCTNm = $("#searchCustTier option:selected").text();
	var srchCTCd = $("#searchCustTier").val();
	
	$.ifvSyncPostJSON('<ifvm:action name="getAnalysisListByCustTier"/>',{
		yearMonth : srchYM		
	},function(result) {
		makeTable(result,srchYM,srchCTNm,srchCTCd);
	});
}

function getTableData(data, pYmonthcd, pMemtiercd, pRtnType){
	var rtnVal = null;
	
	for(var i=0; i<data.length; i++){
		if(data[i].ymonthcd == pYmonthcd && data[i].memgradecd == pMemtiercd){
			rtnVal = data[i];
			break;
		} 
	}
	
	if(rtnVal == null){
		rtnVal = "0";
	}else{
		if(pRtnType == "memactivecnt"){
			rtnVal = rtnVal.memactivecnt;
		}else if(pRtnType == "memactivecnt2"){
			rtnVal = rtnVal.memactivecnt2;
		}else if(pRtnType == "totactivecnt"){
			rtnVal = rtnVal.totactivecnt;
		}else if(pRtnType == "rate"){
			rtnVal = rtnVal.rate;
		}else if(pRtnType == "fillvolt"){
			rtnVal = rtnVal.fillvolt;
		}
	}
	
	rtnVal = numberWithCommas(rtnVal);
	
	return rtnVal;
}

function makeTable(dataArr, ymonth, custTermNm, custTermCd){
	var tableHead = "";
	var tableBody = "";
	var custTierVal = $("#searchCustTier").val();
	var pTermNmArr = termSetting("searchCustTier", "nm");
	var pTermCdArr = termSetting("searchCustTier", "cd");
	var pYearMonthArr = yearMonthSetting(ymonth.substring(0,4), ymonth.substring(4,6)); 
	
	$("#tableHead").empty();
	$("#tableBody").empty();
	
	tableHead += " <tr> ";
	tableHead += " 	<th>" + "<spring:message code='M02767'/>" + "</th> ";
	tableHead += " 	<th>" + "<spring:message code='M02754'/>" + "</th> ";
	tableHead += " 	<th> " + pYearMonthArr[0] + " </th> ";
	tableHead += " 	<th> " + pYearMonthArr[1] + " </th> ";
	tableHead += " 	<th> " + pYearMonthArr[2] + " </th> ";
	tableHead += " </tr> ";
	
	$("#tableHead").append(tableHead);
	
	if(custTierVal == "" || custTierVal == null){
		//전체
		for(var i=1; i<pTermCdArr.length; i++){
			tableBody += " <tr> ";
			tableBody += " 	<td rowspan='5' class='bg_gray'>" + pTermNmArr[i] + "</td> ";	
			tableBody += " 	<td class='bg_gray'> " + "<spring:message code='M02757'/>" + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[0], pTermCdArr[i], "memactivecnt") + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[1], pTermCdArr[i], "memactivecnt") + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[2], pTermCdArr[i], "memactivecnt") + " </td> ";	
			tableBody += " </tr> ";
			
			tableBody += " <tr> ";
			tableBody += " 	<td class='bg_gray'> " + "<spring:message code='M02758'/>" + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[0], pTermCdArr[i], "memactivecnt2") + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[1], pTermCdArr[i], "memactivecnt2") + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[2], pTermCdArr[i], "memactivecnt2") + " </td> ";	
			tableBody += " </tr> ";
			
			tableBody += " <tr> ";
			tableBody += " 	<td class='bg_gray'> " + "<spring:message code='M02759'/>" + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[0], pTermCdArr[i], "totactivecnt") + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[1], pTermCdArr[i], "totactivecnt") + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[2], pTermCdArr[i], "totactivecnt") + " </td> ";	
			tableBody += " </tr> ";
			
			tableBody += " <tr> ";
			tableBody += " 	<td class='bg_gray'> " + "<spring:message code='M02760'/>" + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[0], pTermCdArr[i], "rate") + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[1], pTermCdArr[i], "rate") + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[2], pTermCdArr[i], "rate") + " </td> ";	
			tableBody += " </tr> ";
			
			tableBody += " <tr> ";
			tableBody += " 	<td class='bg_gray'> " + "<spring:message code='M02761'/>" + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[0], pTermCdArr[i], "fillvolt") + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[1], pTermCdArr[i], "fillvolt") + " </td> ";	
			tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[2], pTermCdArr[i], "fillvolt") + " </td> ";	
			tableBody += " </tr> ";
		}
	}else{
		tableBody += " <tr> ";
		tableBody += " 	<td rowspan='5' class='bg_gray'>" + custTermNm + "</td> ";	
		tableBody += " 	<td class='bg_gray'> " + "<spring:message code='M02757'/>" + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[0], custTermCd, "memactivecnt") + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[1], custTermCd, "memactivecnt") + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[2], custTermCd, "memactivecnt") + " </td> ";	
		tableBody += " </tr> ";
		
		tableBody += " <tr> ";
		tableBody += " 	<td class='bg_gray'> " + "<spring:message code='M02758'/>" + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[0], custTermCd, "memactivecnt2") + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[1], custTermCd, "memactivecnt2") + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[2], custTermCd, "memactivecnt2") + " </td> ";	
		tableBody += " </tr> ";
		
		tableBody += " <tr> ";
		tableBody += " 	<td class='bg_gray'> " + "<spring:message code='M02759'/>" + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[0], custTermCd, "totactivecnt") + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[1], custTermCd, "totactivecnt") + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[2], custTermCd, "totactivecnt") + " </td> ";	
		tableBody += " </tr> ";
		
		tableBody += " <tr> ";
		tableBody += " 	<td class='bg_gray'> " + "<spring:message code='M02760'/>" + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[0], custTermCd, "rate") + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[1], custTermCd, "rate") + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[2], custTermCd, "rate") + " </td> ";	
		tableBody += " </tr> ";
		
		tableBody += " <tr> ";
		tableBody += " 	<td class='bg_gray'> " + "<spring:message code='M02761'/>" + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[0], custTermCd, "fillvolt") + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[1], custTermCd, "fillvolt") + " </td> ";	
		tableBody += " 	<td class='right'> " + getTableData(dataArr, pYearMonthArr[2], custTermCd, "fillvolt") + " </td> ";	
		tableBody += " </tr> ";
	}
	
	$("#tableBody").append(tableBody);
	
}

function searchFunc(){
	getAnalysisListBycustTier();
}

$(document).ready(function(){
	dateSetting("searchYear","searchYear_temp","searchMonth","searchMonth_temp");
	
	$.ifvGetCommCodeList('select', 'searchCustTier', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_GRADE', 'com', false, false, true);
});

</script>

<div class="page_btn_area">
	<div class="col-xs-2">
		<span><spring:message code='M02766'/></span>
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" id=""  text="L00030" btnType="search" btnFunc="searchFunc"/>
	</div>
</div>
<div class="well form-horizontal underline" id="comSearchArea">
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="searchYear" label="M02752" labelClass="1" conClass="1" />
		<script id="searchYear_temp" type="text/x-jquery-tmpl">
			<option value="${'${'}value}">${'${'}value}</option>
		</script>
		<ifvm:inputNew type="select" id="searchMonth" conClass="1" />
		<script id="searchMonth_temp" type="text/x-jquery-tmpl">
			<option value="${'${'}value}">${'${'}value}</option>
		</script>
		<ifvm:inputNew type="select" id="searchCustTier" names="searchCustTier" label="M02767" labelClass="1" conClass="2" />
	</div>
</div>

<div>
<!-- 	<div class="col-xs-2"> -->
<%-- 		<span><spring:message code='M02762'/></span> --%>
<!-- 	</div> -->
<!-- 	<div class="page_btn_area"> -->
<!-- 		<div class="col-xs-10 searchbtn_r"> -->
			
<!-- 		</div> -->
<!-- 	</div> -->
	<div id="custTierTable" class="table_wrap">
		<table>
			<colgroup>
				<col style="width:12.5%">
				<col style="width:12.5%">
				<col style="width:25%">
				<col style="width:25%">
				<col style="width:25%">
			</colgroup>
			<thead id="tableHead">
				
			</thead>
			<tbody id="tableBody">
			
			</tbody>		
		</table>
	</div>
</div>