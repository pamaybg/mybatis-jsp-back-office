<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settleHistoryList;
var actYearMonth ;
var actnum;
var actHeadObj={};

//정산이력조회
function getSettleHistoryListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
	      var data = settleHistoryList.getRowData()[data-1];
	      actYearMonth = data.act_yearmonth;
	      actHeadObj.actYearMonth =  data.act_yearmonth;
	      actHeadObj.actnum = data.act_num
	      settleDtl(actHeadObj);
        },
        onSelectRow : function (data) {
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	data.actYearMonth = $("#startYM").val();
        	data.endactyearmonth = $("#endYM").val();

        	//하나라도 빈값이면 조회안되게 설정
        	if($("#startYM").val()=="" || $("#endYM").val()=="" ){
        		data.actYearMonth ="1111"
        		data.endactyearmonth = "1111"
        	}
            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getSettleHistoryList"/>',
        colNames:[
                   '<spring:message code="L01877" />',  /* 정산월 */
                   '<spring:message code="L01878" />',  /* 정산시작일자 */
                   '<spring:message code="L01879" />',  /* 정산종료일자 */
                   '<spring:message code="L01880" />',	/* 정산방법 */
                   '<spring:message code="L01881" />',	/* 전체 금액 */
                   '<spring:message code="L01882" />',	/* E1 금액 */
                   '<spring:message code="L01883" />',	/* 가맹점 금액 */
                   '<spring:message code="L01884" />',	/* 버전  */
                   '<spring:message code="L01885" />',	/* 상태  */
                 ],
        colModel:[
             { name:'act_yearmonth',   index:'act_yearmonth',  resizable : true, align:'center',    width:'100px' /* ,formatter : actYearMonthFormat */ },
             { name:'act_start_dt',   index:'act_start_dt',  resizable : true, align:'center',    width:'100px' , formatter : actStartDtFormat},
             { name:'act_end_dt',   index:'act_end_dt',  resizable : true, align:'center',    width:'100px' ,formatter : actEndDtFormat },
             { name:'act_exec_method',   index:'act_exec_method',  resizable : true, align:'center' ,  width:'100px' },
             { name:'act_point_sum',   index:'act_point_sum',  resizable : true, align:'right' ,  width:'100px',formatter:'integer' },
             { name:'act_e1share',   index:'act_e1share',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'act_partshare',   index:'act_partshare',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'act_num',   index:'act_num',  resizable : true, align:'center',    width:'100px' },
             { name:'act_status',   index:'act_status',  resizable : true, align:'center',    width:'100px' },

        ],
         sortname: 'act_yearmonth'
        ,autowidth : true
        ,shrinkToFit: false
        ,sortorder: "desc"
    };
    settleHistoryList = $("#settleHistoryListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function actYearMonthFormat(cellvalue, options, rowObjec){
	var dateFormat = rowObjec.act_yearmonth;
	var year;
	var month;
	var day;
	var date;
	if(dateFormat !=null){

		if(dateFormat.length==6){
			year = dateFormat.substring(0,4);
			month = dateFormat.substring(4,6);
			date = year+'<spring:message code="M01062" />' + month +'<spring:message code="M01061" />';
		}
	}
	return date;
}

function actStartDtFormat(cellvalue, options, rowObjec){
	var dateFormat = rowObjec.act_start_dt;
	var year;
	var month;
	var day;
	var date;
	if(dateFormat !=null){
		if(dateFormat.length==8){
			year = dateFormat.substring(0,4);
			month = dateFormat.substring(4,6);
			day = dateFormat.substring(6,8);
			date = year + "-" + month + "-" + day;
		}
	}
	return date;
}

function actEndDtFormat(cellvalue, options, rowObjec){
	var dateFormat = rowObjec.act_end_dt;
	var year;
	var month;
	var day;
	var date;
	if(dateFormat !=null){
		if(dateFormat.length==8){
			year = dateFormat.substring(0,4);
			month = dateFormat.substring(4,6);
			day = dateFormat.substring(6,8);
			date = year + "-" + month + "-" + day;
		}
	}
	return date;
}

//공통 조회 호출
function settleHistoryListSearch() {
/* 	if($("#startYM").val()==""){
		$.ifvCallValidationBox($("#startYM"),
		"<spring:message code='C00024'/>");
		return;
	}
	if($("#endYM").val()==""){
		$.ifvCallValidationBox($("#endYM"),
		"<spring:message code='C00024'/>");
		return;
	} */
    $.fn.ifvmSubmitSearchCondition("insureContListSearchList", getSettleHistoryListSearch);
}

//고객 상세 이동
function settleDtl(actHeadObj) {
    qtjs.href('<ifvm:url name="settleHistoryDetail"/>' + '?actYearMonth=' + actHeadObj.actYearMonth +"&&actnum="+actHeadObj.actnum);
}

function getStartYm(){
	var result  = new Array();
	var date = new Date();
	var year  = date.getFullYear();
	var month = date.getMonth()+1; // 0부터 시작하므로 1더함 더함
	var monthText;
	result.push({yearMonth : "" ,yearMonthText: "=="+'<spring:message code="L02040" />'+"=="});
	for( i=0; i<12; i++){
		if(month-i==0){
			year = year-1;
			monthText = "12";
		}else{
			monthText = month-i;
			if(monthText<0){
				monthText = monthText+12;
			}
			if (("" + monthText).length == 1) {
				monthText = "0" + monthText;
				}else{
				monthText= "" + monthText;
			}
		}
		result.push({yearMonth: year+""+monthText ,
					yearMonthText: year+'<spring:message code="M01062" />'+monthText+'<spring:message code="M01061" />'});
	}
	var temp = $("#startYMTemp").tmpl(result);
	$("#startYM").append(temp);
}

function getEndYm(){
	var result  = new Array();
	var date = new Date();
	var year  = date.getFullYear();
	var month = date.getMonth()+1; // 0부터 시작하므로 1더함 더함
	var monthText;
	result.push({yearMonth : "" ,yearMonthText: "=="+'<spring:message code="L02041" />'+"=="});
	for( i=0; i<12; i++){
		if(month-i==0){
			year = year-1;
			monthText = "12";
		}else{
			monthText = month-i;
			if(monthText<0){
				monthText = monthText+12;
			}
			if (("" + monthText).length == 1) {
				monthText = "0" + monthText;
				}else{
				monthText= "" + monthText;
				}
			}
		result.push({yearMonth: year+""+monthText ,
					yearMonthText: year+'<spring:message code="M01062" />'+monthText+'<spring:message code="M01061" />'});
	}
	var temp = $("#endYMTemp").tmpl(result);
	$("#endYM").append(temp);
}

function ymSelectChangeFn(){
	$("#startYM").change(function(){
		if($(this).val()!="" && $("#endYM").val() !=""){
			if($(this).val()>$("#endYM").val()){
				alert('<spring:message code="L01983" />');
				$(this).find("option:eq(12)").prop("selected", true);
			}
		}
	});
	$("#endYM").change(function(){
		if($(this).val()!="" && $("#startYM").val() !=""){
			if($(this).val()<$("#startYM").val()){
				alert('<spring:message code="L01984" />');
				$(this).find("option:eq(1)").prop("selected", true);
			}
		}
	});
}

$(document).ready(function() {
//	$("#settleHistoryListGrid").ifvGrid({ jqGridOption : {} });
    getStartYm();
    getEndYm();
    getSettleHistoryListSearch();
    ymSelectChangeFn();
/*     $("#startYM").change(function(){
    	settleHistoryListSearch();
    	    });
    	  */


});
</script>



<script id="startYMTemp" type="text/x-jquery-tmpl">
<option value="${'${'}yearMonth}">${'${'}yearMonthText}</option>
</script>


<script id="endYMTemp" type="text/x-jquery-tmpl">
<option value="${'${'}yearMonth}">${'${'}yearMonthText}</option>
</script>


<div class="page-title">
    <h1>
        <spring:message code="L01876" />
        &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>


</div>


	<div class="form-horizontal underline top_well" id="searchFormArea" >
		<div class="row">
    	<ifvm:inputNew type="select" id="startYM" maxLength="50"  dto="startYM"  required="true"  labelClass="0" conClass="2" />
    	<ifvm:inputNew type="select" id="endYM" maxLength="50"  dto="endYM"  required="true"   labelClass="0" conClass="2" />
    	<ifvm:inputNew type="button" btnFunc="settleHistoryListSearch" btnType="search" text="L00081" />
   	</div>
   </div>


<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload2('settleHistoryListGrid')" />
        </div>
    </div>
    <div id="settleHistoryListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="emptyDialog" class="popup_container"></div>


