<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var indicatorList;
var actYearMonth ;
var actnum;
var actHeadObj={};
var showSum = false;
function getIndicatorListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
        },
        onSelectRow : function (data) {
        },
        serializeGridData : function( data ){
			var submitData = {};
			submitData = $("#searchFormArea").getSubmitData();
			submitData.startYM = $("#startYM").val().replaceAll("-","");
			submitData.endYM = $("#endYM").val().replaceAll("-","");
			if($("#dealYn").prop("checked")){
				submitData.dealYn = "Y";
			}else{
				submitData.dealYn = "N";
			}
			if($("#sumYn").prop("checked")){
				submitData.sumYn = "Y";
				showSum = false;
			}else{
				submitData.sumYn = "N";
				showSum = true;
			}
			data = submitData;
            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getIndicatorList"/>',
        colNames:[
                   '<spring:message code="L02068" />',  /* 년월 */
                   '<spring:message code="L02069" />',  /* 관할부서 */
                   '<spring:message code="L02070" />',  /* 거래처구분 */
                   '<spring:message code="L02071" />',	/* 운영인 */
                   '<spring:message code="L02072" />',	/* 거래처코드 */

                   '<spring:message code="L02130" />',	/* 업종 */
                   '<spring:message code="L02073" />',	/* 거래처명 */
                   '<spring:message code="L02074" />',	/* 출하량 */
                   '<spring:message code="L02075" />',	/* 판매일보 출하량  */

                   '<spring:message code="L02131" />',	/* 출하량 법인택시  */
                   '<spring:message code="L02132" />',	/* 출하량 개인택시  */
                   '<spring:message code="L02133" />',	/* 출하량 비택시  */
                   '<spring:message code="L02134" />',	/* 최초출하년월  */
                   '<spring:message code="L02135" />',	/* 최종출하년월  */

                   '<spring:message code="L02076" />',	/* 오카 판매량  */

                   '<spring:message code="L02136" />',	/* 오카판매량 택시  */
                   '<spring:message code="L02137" />',	/* 오카판매량 비택시  */
                   '<spring:message code="L02138" />',	/* 오카우수회원 판매량 택시  */
                   '<spring:message code="L02139" />',	/* 오카우수회원 판매량 비택시  */
                   '<spring:message code="L02183" />',	/* 오카판매량 미등록  */

                   '<spring:message code="L02077" />',	/* 오카 거래회원수  */

                   '<spring:message code="L02140" />',	/* 오카거래회원수 택시  */
                   '<spring:message code="L02141" />',	/* 오카 거래회원수 비택시  */
                   '<spring:message code="L02142" />',	/* 오카 거래회원수 미등록  */

                   '<spring:message code="L02078" />',	/* 오카 우수회원수  */

                   '<spring:message code="L02143" />',	/* 오카 우수회원수 택시  */
                   '<spring:message code="L02144" />',	/* 오카 우수회원수  비택시*/

                   '<spring:message code="L02079" />',	/* 오카 신규회원수 */

                   '<spring:message code="L02145" />',	/* 오카 신규회원수 택시 */
                   '<spring:message code="L02146" />',	/* 오카 신규회원수 비택시 */

                   '<spring:message code="L02080" />',	/* 제휴카드 판매량  */

                   '<spring:message code="L02147" />',	/* 제휴카드판매량 택시  */
                   '<spring:message code="L02148" />',	/* 제휴카드판매량 비택시  */
                   '<spring:message code="L02149" />',	/* 제휴카드판매량 현대  */
                   '<spring:message code="L02150" />',	/* 제휴카드판매량 롯데  */
                   '<spring:message code="L02151" />',	/* 제휴카드판매량 롯데일반  */
                   '<spring:message code="L02152" />',	/* 제휴카드판매량 롯데개인  */
                   '<spring:message code="L02153" />',	/* 제휴카드판매량 IBK  */
                   '<spring:message code="L02154" />',	/* 제휴카드판매량 KB  */
                   '<spring:message code="L02155" />',	/* 제휴카드판매량 우리  */

                   '<spring:message code="L02081" />',	/* 제휴카드 거래회원수 */

                   '<spring:message code="L02156" />',	/* 제휴카드거래회원수 택시 */
                   '<spring:message code="L02157" />',	/* 제휴카드거래회원수 비택시 */
                   '<spring:message code="L02158" />',	/* 제휴카드거래회원수 현대 */
                   '<spring:message code="L02159" />',	/* 제휴카드거래회원수 롯데 */
                   '<spring:message code="L02160" />',	/* 제휴카드거래회원수 롯데일반 */
                   '<spring:message code="L02161" />',	/* 제휴카드거래회원수 롯데개인 */
                   '<spring:message code="L02162" />',	/* 제휴카드거래회원수 IBK */
                   '<spring:message code="L02163" />',	/* 제휴카드거래회원수 KB */
                   '<spring:message code="L02164" />',	/* 제휴카드거래회원수 우리 */

                   '<spring:message code="L02082" />',	/* 제휴카드 신규회원수  */

                   '<spring:message code="L02165" />',	/* 제휴카드신규회원수 택시  */
                   '<spring:message code="L02166" />',	/* 제휴카드신규회원수 비택시  */
                   '<spring:message code="L02167" />',	/* 제휴카드신규회원수 현대  */
                   '<spring:message code="L02168" />',	/* 제휴카드신규회원수 롯데  */
                   '<spring:message code="L02169" />',	/* 제휴카드신규회원수 롯데일반  */
                   '<spring:message code="L02170" />',	/* 제휴카드신규회원수 롯데개인  */
                   '<spring:message code="L02171" />',	/* 제휴카드신규회원수 IBK  */
                   '<spring:message code="L02172" />',	/* 제휴카드신규회원수 KB  */
                   '<spring:message code="L02173" />',	/* 제휴카드신규회원수 우리  */

                   '<spring:message code="L02083" />',	/* 오카비율(%)  */
                   '<spring:message code="L02084" />',	/* 톤당 거래회원  */
                   '<spring:message code="L02085" />',	/* 톤당 신규회원  */
                   '<spring:message code="L02086" />',	/* 톤당 우수회원  */
                   '<spring:message code="L02087" />',	/* 제휴카드비율(%)  */

                   '<spring:message code="L02174" />',	/* 톤당제휴카드 거래회원  */
                   '<spring:message code="L02175" />',	/* 톤당제휴카드 신규회원  */
                   '<spring:message code="L02176" />',	/* 세차기  */
                   '<spring:message code="L02177" />',	/* 오렌지매니저  */
                   '<spring:message code="L02178" />',	/* 세차수익 (자동세차기)  */
                   '<spring:message code="L02179" />',	/* 코너수익 (셀프세차,오렌지서비스)  */
                   '<spring:message code="L02180" />',	/* SMS 동의회원  */
                   '<spring:message code="L02181" />',	/* EMAIL 동의회원  */
                   '<spring:message code="L02182" />',	/* APP사용 거래회원  */

                 ],
        colModel:[
             { name:'yyyymm',   			index:'yyyymm',  resizable : true, align:'center',    width:'100px' ,hidden : true },
             { name:'dept_nm',   			index:'dept_nm',  resizable : true, align:'center',    width:'100px' },
             { name:'cust_type',   			index:'cust_type',  resizable : true, align:'center',    width:'100px' },
             { name:'t_owner_nm',   		index:'t_owner_nm',  resizable : true, align:'center',    width:'100px'  },
             { name:'cust_id',   			index:'cust_id',  resizable : true, align:'center' ,  width:'100px' },
             { name:'fs_type',   			index:'fs_type',  resizable : true, align:'center' ,  width:'100px' },
             { name:'cust_nm',   			index:'cust_nm',  resizable : true, align:'center' ,  width:'100px' },
             { name:'supply_amt',   		index:'supply_amt',  resizable : true, align:'right',    width:'100px',formatter:'integer'},
             { name:'sale_daily_supply_amt',index:'sale_daily_supply_amt',  resizable : true, align:'right',    width:'100px',formatter:'integer' },

             { name:'corporatetaxi_fillqty',index:'corporatetaxi_fillqty',  resizable : true, align:'right',    width:'100px',formatter:'integer' },
             { name:'privatetaxi_fillqty',	index:'privatetaxi_fillqty',  resizable : true, align:'right',    width:'100px',formatter:'integer' },
             { name:'nontaxi_fillqty',		index:'nontaxi_fillqty',  resizable : true, align:'right',    width:'100px',formatter:'integer' },
             { name:'first_fill_yyyymm',	index:'first_fill_yyyymm',  resizable : true, align:'center',    width:'100px' },
             { name:'last_fill_yyyymm',		index:'last_fill_yyyymm',  resizable : true, align:'center',    width:'100px' },

             { name:'oc_fill_vol',   		index:'oc_fill_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'oc_taxi_fill_vol',   	index:'oc_taxi_fill_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'oc_nor_fill_vol',   	index:'oc_nor_fill_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'oc_taxi_exc_fill_vol', index:'oc_taxi_exc_fill_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'oc_nor_exc_fill_vol',  index:'oc_nor_exc_fill_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'oc_unreg_fill_vol',   	index:'oc_unreg_fill_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'oc_mem_tran_cnt',   	index:'oc_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'taxi_mem_tran_cnt ',   index:'taxi_mem_tran_cnt ',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'nor_mem_tran_cnt',   	index:'nor_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'unreg_mem_tran_cnt',   index:'unreg_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'station_exc_cnt',   	index:'station_exc_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'station_taxi_exc_cnt', index:'station_taxi_exc_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'station_nor_exc_cnt',  index:'station_nor_exc_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'new_oc_mem_cnt',   	index:'new_oc_mem_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'new_oc_taxi_mem_cnt',  index:'new_oc_taxi_mem_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'new_oc_nor_mem_cnt',   index:'new_oc_nor_mem_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'corp_fill_vol',   		index:'corp_fill_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'corp_taxi_fill_vol',   index:'corp_taxi_fill_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'corp_nor_fill_vol',   	index:'corp_nor_fill_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'hc_vol',   			index:'hc_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'lc_vol',   			index:'lc_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'lc_normal_vol',   		index:'lc_normal_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'lc_taxi_vol',   		index:'lc_taxi_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'ibk_vol',   			index:'ibk_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'kb_vol',   			index:'kb_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'wc_vol',   			index:'wc_vol',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'corp_mem_tran_cnt',   	index:'corp_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'corp_taxi_mem_tran_cnt',   index:'corp_taxi_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'corp_nor_mem_tran_cnt',   	index:'corp_nor_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'corp_nor_mem_tran_cnt',   	index:'corp_nor_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'lc_mem_tran_cnt',   		index:'lc_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'lc_nor_mem_tran_cnt',   	index:'lc_nor_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'lc_taxi_mem_tran_cnt',   	index:'lc_taxi_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'ibk_mem_tran_cnt',   		index:'ibk_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'kb_mem_tran_cnt',   		index:'kb_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'wc_mem_tran_cnt',   		index:'wc_mem_tran_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'new_all_corp_cnt',   	index:'new_all_corp_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'new_taxi_corp_cnt',   	index:'new_taxi_corp_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'new_nor_corp_cnt',   	index:'new_nor_corp_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'new_hc_cnt',   		index:'new_hc_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'new_lc_cnt',   		index:'new_lc_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'new_lc_nor_cnt ',   	index:'new_lc_nor_cnt ',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'new_lc_txi_cnt',   	index:'new_lc_txi_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'new_ibk_cnt',   		index:'new_ibk_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'new_kb_cnt',   		index:'new_kb_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'new_wc_cnt',   		index:'new_wc_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},

             { name:'oc_rate',   			index:'oc_rate',  resizable : true, align:'right',    width:'100px' ,formatter:'number'},
             { name:'oc_tran_mem_t_rate',   index:'oc_tran_mem_t_rate',  resizable : true, align:'right',    width:'100px' ,formatter:'number'},
             { name:'oc_new_mem_t_rate',   	index:'oc_new_mem_t_rate',  resizable : true, align:'right',    width:'100px' ,formatter:'number'},
             { name:'oc_exc_mem_t_rate',   	index:'oc_exc_mem_t_rate',  resizable : true, align:'right',    width:'100px' ,formatter:'number'},
             { name:'corp_rate',   			index:'corp_rate',  resizable : true, align:'right',    width:'100px' ,formatter:'number'},

             { name:'corp_tran_mem_t_rate', index:'corp_tran_mem_t_rate',  resizable : true, align:'right',    width:'100px' ,formatter:'number'},
             { name:'corp_new_mem_t_rate',  index:'corp_new_mem_t_rate',  resizable : true, align:'right',    width:'100px' ,formatter:'number'},
             { name:'car_wash_machine_yn',  index:'car_wash_machine_yn',  resizable : true, align:'right',    width:'100px' },
             { name:'orange_manager_nm',   	index:'orange_manager_nm',  resizable : true, align:'right',    width:'100px' },
             { name:'carwashamt',   		index:'carwashamt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'corneramt',   			index:'corneramt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'sms_cnt',   			index:'sms_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'email_cnt',   			index:'email_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
             { name:'app_cnt',   			index:'app_cnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},


        ],
         sortname: 'yyyymm'
        ,autowidth : true
        ,shrinkToFit: false
        ,sortorder: "desc"
    };
    if($("#sumYn").prop("checked")){
    	jqGridOption.colModel[0].hidden = false;
    }

    indicatorList = $("#indicatorListGrid").ifvGrid({ jqGridOption : jqGridOption });
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

function getJisaNm(){
	$.ifvSyncPostJSON('<ifvm:action name="getJisaNm"/>', {
	}, function(result) {
		$("#deptNm").append("<option value = ''></option>" );
		for(var i=0; i<result.length ; i++){
			$("#deptNm").append("<option value = '"+result[i].tjisanm+"'> "+result[i].tjisanm+" </option>" )
		}

	})
}

function getAccntTypeNm(){
	$.ifvSyncPostJSON('<ifvm:action name="getAccntTypeNm"/>', {
	}, function(result) {
		for(var i=0; i<result.length ; i++){
			$("#custType").append("<option value = '"+result[i].taccnttypenm+"'> "+result[i].taccnttypenm+" </option>" )
		}
	})

}

function getFsTypeNm(){
	$("#fsType").append("<option value = ''>  </option>" );
	$("#fsType").append("<option value = '겸업'> 겸업 </option>" );
	$("#fsType").append("<option value = '자동차'> 자동차 </option>" );
	$("#fsType").append("<option value = '용기'> 용기 </option>" );
}

//공통 조회 호출
function indicatorListSearch() {
 	if($("#startYM").val()==""){
		$.ifvCallValidationBox($("#startYM"),
		"<spring:message code='C00024'/>");
		return;
	}
	if($("#endYM").val()==""){
		$.ifvCallValidationBox($("#endYM"),
		"<spring:message code='C00024'/>");
		return;
	}
	var start , end;
	start = $("#startYM").val().replaceAll("-","");
	end = $("#endYM").val().replaceAll("-","");
	if(start>end){
		alert('<spring:message code="L01983" />');
		return;
	}

    $.fn.ifvmSubmitSearchCondition("insureContListSearchList", getIndicatorListSearch);
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
	result.push({yearMonth : "" ,yearMonthText: "=="+'<spring:message code="L02088" />'+"=="});
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
	result.push({yearMonth : "" ,yearMonthText: "=="+'<spring:message code="L02089" />'+"=="});
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

/* function ymSelectChangeFn(){
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
} */

function indicatorListSearchInit(){
	$($('#searchFormArea').find('input')).each(function(index, item){
		$(this).val("");
		if($(this).attr('type')=="checkbox"){
			if($(this).prop("checked")){
				$(this).attr('checked', false);
			}
		}
	});
	$($('#searchFormArea').find('select')).each(function(index, item){
		$(this).val("");
	});

}

function selectBoxChangeFn(){
	$("#deptNm").change(function(){
		$("#custId").val("");
		$("#custNm").val("");
	})
}

function channelSearchFn(){
	if($("#deptNm").val()==""){
		alert('<spring:message code="L02103" />');
		return ;
	}

	channelSearchHelpPopOpen('<ifvm:url name="ocaChannelSearchHelp"/>' + '?ouTypeCd=' + 'ALL&divNm='+encodeURI(encodeURIComponent($("#deptNm").val())));
}

function channelSearchHelpPopOpen(url){
	channelSearchHelpPop ={
	        id : "channelSearchPopDiv"
	    };
channelSearchHelpPop.popup = function (){
	channelSearchHelpPop.pop = $('#'+channelSearchHelpPop.id).ifvsfPopup({
	            enableModal: true,
	            enableResize: false,
	            contentUrl: url,
	            contentType: "ajax",
	            title: "<spring:message code='L00987'/>",
	            width: "700px"
	        });
	};
	channelSearchHelpPop.beforeClose = function (obj) {
	};
	channelSearchHelpPop.close = function (obj) {
		 if(obj!=null || typeof obj!="undefined"){
	         	$("#custNm").val(obj.chnlNm);
	        	$("#custId").val(obj.chnlNo);
	    /*     	$("#ridChnl").val(obj.rid); */
	        }
	        this.beforeClose(obj);
	        channelSearchPopDiv._destroy();
	 };
	channelSearchHelpPop.popup();
}


$(document).ready(function() {
	getJisaNm();
	getAccntTypeNm();
	getFsTypeNm();
	selectBoxChangeFn();
	var date = new Date();
	var year  = date.getFullYear();
	var month = date.getMonth()+1; // 0부터 시작하므로 1더함 더함
	if (("" + month).length == 1) {
		month = "0" + month;
	}else{
		month= "" + month;
	}
	var dateText = year + month;
	$("#startYM, #endYM").val(dateText);
    /* getStartYm();
    getEndYm(); */
    getIndicatorListSearch();
    //ymSelectChangeFn();
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
    	<spring:message code="L02090" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnFunc="indicatorListSearch" btnType="search" text="L00081" />
                   <ifvm:inputNew type="button"   text="M00278"  id="indicatorListSearchInitBtn" btnFunc="indicatorListSearchInit"/>
        </div>
    </div>


</div>


	<div class="form-horizontal underline top_well" id="searchFormArea" >
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="L02091"/></label>
	    	<ifvm:inputNew type="text" id="startYM" maxLength="7"  dto="startYM"  required="true"  labelClass="0" conClass="1" />
	    	<ifvm:inputNew type="text" id="endYM" maxLength="7"  dto="endYM"  required="true"   labelClass="0" conClass="1" />


			<ifvm:inputNew type="select" id="custType" maxLength="50"  dto="custType"   label="L02106" labelClass="1" conClass="2" />
 	    	<ifvm:inputNew type="select" id="fsType" maxLength="50"  dto="fsType"   label="L02100" labelClass="1" conClass="2" />



	    	<%-- <ifvm:inputNew type="button" btnFunc="indicatorListSearch" btnType="search" text="L00081" /> --%>
   		</div>
   		<div class="row qt_border">
   		 	<ifvm:inputNew type="select" id="deptNm" maxLength="50"  dto="deptNm"   label="L02069" labelClass="1" conClass="2" />
   			<ifvm:inputNew type="search" id="custNm|channelSearchBtn"  dto="custNm" names="custNm" hidId="custId" hidDto="custId"
				   btnFunc="channelSearchFn"  label="L02073"  labelClass="1" conClass="2" />
   			<ifvm:inputNew type="singleCheckbox" id="dealYn" label="L02105" values="1" labelClass="1" conClass="2" checked="false" />
			<ifvm:inputNew type="singleCheckbox" id="sumYn" label="L02104" values="1" labelClass="1" conClass="1" checked="false" />
			<ifvm:inputNew type="onlyLabel" label="L02129" labelClass="1"  /><!--(단위: 톤,명,%) -->

<%-- 			<ifvm:inputNew type="text" id="custNm" maxLength="50"  dto="custNm"   label="L00938" labelClass="1" conClass="2"  disabled="true"/> --%>
<%-- 			<ifvm:inputNew type="text" id="custId" maxLength="50"  dto="custId"   label="L00937" labelClass="1" conClass="2" />
			<ifvm:inputNew type="text" id="custNm" maxLength="50"  dto="custNm"   label="L00938" labelClass="3" conClass="2" />  --%>

	    	<%-- <ifvm:inputNew type="button" btnFunc="indicatorListSearch" btnType="search" text="L00081" /> --%>
   		</div>
   </div>


<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L00930" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<%-- <ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('indicatorListGrid')" /> --%>
        </div>
    </div>
    <div id="indicatorListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="emptyDialog" class="popup_container"></div>
<div id="channelSearchPopDiv" class="popup_container"></div>

