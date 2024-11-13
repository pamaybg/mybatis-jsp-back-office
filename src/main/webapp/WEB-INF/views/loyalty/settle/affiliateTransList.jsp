<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var affiliateTransList;
var actYearMonth ;
var prRid = "";
function getAffiliateTransListSearch(){
    var jqGridOption = {
        onSelectRow : function (data) {
        	prRid = data.prRid
        	getAffiliateTransDtlListSearch();

        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	var obj ={};
        	var startYm = $("#startYM").val();
        	if(startYm==""){
        		startYm="1";
        	}

        	obj = dateValSetting(startYm);
        	data.startDt = obj.startDt
        	data.endDt = obj.endDt
            return data;
        },
        loadComplete : function(obj){
        	prRid="";
        	getAffiliateTransDtlListSearch();
        	setAffiliateTransGridTotal(obj.expandObj);
        },
        url : '<ifvm:action name="getAffiliateTransList"/>',
        colNames:[
                   '<spring:message code="L01919" />',  /* 가맹점코드 */
                   '<spring:message code="L01920" />',  /* 가맹점상호 */
                   '<spring:message code="L00614" />',  /* 가맹점약호 */
                   '<spring:message code="L01921" />',	/* 사업자번호 */
                   '<spring:message code="L01922" />',	/* 가맹점상태 */
                   '<spring:message code="L01923" />',	/* 총 적립금액 */
                   '<spring:message code="L01924" />',	/* 총 사용금액 */
                   'prRid',
                 ],
        colModel:[
                  { name:'chnlNo',   	index:'TT2.CHNL_NO',  resizable : true, align:'center',    width:'100px' },
                  { name:'chnlNm',   	index:'TT2.CHNL_NM',  resizable : true, align:'center',    width:'100px'  },
                  { name:'mbrbsCdadd',  index:'TT2.MBRBS_CDADD',  resizable : true, align:'center' ,  width:'100px' },
                  { name:'bizrNo',   	index:'TT2.BIZR_NO',  resizable : true, align:'center' ,  width:'100px' },
                  { name:'mbrbsStatusCd',   index:'cc.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
                  { name:'acrl',   		index:'acrl',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
                  { name:'rdm',   		index:'rdm',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
                  { name:'prRid',   	index:'TT1.PR_RID', hidden : true},
                 ],
         sortname: 'chnlNo'
         ,autowidth : true
         ,sortorder: "desc"
         ,radio : true
         ,footerrow: true
         ,userDataOnFooter : true,
         shrinkToFit: false
    };


    affiliateTransList = $("#affiliateTransListGrid").ifvGrid({ jqGridOption : jqGridOption });
}


function setAffiliateTransGridTotal(result){
/*  	var obj ={};
	var startYm = $("#startYM").val();
	if(startYm==""){
		startYm="1";
	} */

/* 	obj = dateValSetting(startYm); */
	affiliateTransList.setFooter({"chnlNo" : "Total", "rdm" :  Math.round(Number(result.rdmSum)) , "acrl" :  Math.round(Number(result.acrlSum)) });

/*
	obj.affiliateGridDiv ="head";  //그리드 헤드 조건부 표시  합계 조회시 사용
 	$.ifvPostJSON('<ifvm:action name="getAffiliateSum"/>', obj, function(result) {
 		console.log(result.rdmSum);
 		affiliateTransList.setFooter({"chnlNo" : "Total", "rdm" :  Math.round(Number(result.rdmSum)) , "acrl" :  Math.round(Number(result.acrlSum)) });
 	});
 */}
function dateValSetting(date){
	var firstDay="01";
	var startDt = date+firstDay;
	var endYear = parseInt(date.substring(0,4)); //2017
	var endMonth = date.substring(4,6); //01
	var endDt;
	var dateObj={};
	if(date.substring(4,6)=="12"){
		endYear =   endYear+1;
		endMonth = firstDay;
	}else{
		var month = parseInt(endMonth)+1
		if(month<10){
			endMonth = "0"+month;
		}else{
			endMonth = month.toString();
		}
	}
	endDt = endYear.toString()+endMonth+firstDay;
	dateObj.startDt = startDt;
	dateObj.endDt = endDt;
	return dateObj;
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
function affiliateTransListSearch() {
    $.fn.ifvmSubmitSearchCondition("affiliateTransListGrid", getAffiliateTransListSearch);
}

//고객 상세 이동
function settleDtl(actYearMonth) {
    qtjs.href('<ifvm:url name="settleHistoryDetail"/>' + '?actYearMonth=' + actYearMonth);
}

function getStartYm(){
	var result  = new Array();
	var date = new Date();
	var year  = date.getFullYear();
	var month = date.getMonth()+1; // 0부터 시작하므로 1더함 더함
	var monthText;
	result.push({yearMonth : "" ,yearMonthText: "=="+'<spring:message code="L02038" />'+"=="});
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

var affiliateTransDtlList;

function getAffiliateTransDtlListSearch(){
    var jqGridOption = {
        onSelectRow : function (data) {
        },
       serializeGridData : function( data ){
	        if ($.fn.ifvmIsNotEmpty(requestitem)) {
	            data.item = requestitem;
	        }
      		var obj ={};
      		if(prRid==""){
      			prRid="a";
      		}
    		var startYm = $("#startYM").val();
	    	obj = dateValSetting(startYm);
	    	data.startDt = obj.startDt
	    	data.endDt = obj.endDt
	    	data.prRid = prRid;
            return data;
        },
        loadComplete : function(obj){
        	setAffiliateTransDetailGridTotal();
        },
        url : '<ifvm:action name="getAffiliateTransDtlList"/>',
        colNames:[
                   '<spring:message code="L01925" />',  /* 가맹점명 */
                   //REQ_M103
                   '<spring:message code="L00995" />',  /* 승인번호 */
                   '<spring:message code="L01926" />',  /* 승인일자 */
                   '<spring:message code="L01927" />',  /* 회원명 */
                   '<spring:message code="L01928" />',	/* 카드번호 */
                   '<spring:message code="L01929" />',	/* 제품명 */
                   '<spring:message code="L01930" />',	/* 거래상세유형 */
                   '<spring:message code="L01931" />',	/* 포인트 */
                   'rid',	/* rid*/
                 ],
        colModel:[
                  { name:'chnlNm',   index:'T2.CHNL_NM',  resizable : true, align:'center',   width:'100px' /* ,formatter : actYearMonthFormat */ },
                  //REQ_M103
                  { name:'apprNo',   index:'T1.APPR_NO',  resizable : true, align:'center',   width:'100px'  },
                  { name:'apprDt',   index:'T1.APPR_DT',  resizable : true, align:'center',   width:'100px' ,formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
                  { name:'mbrNm',    index:'mbrNm',  	  resizable : true, align:'center',   width:'100px'  },
                  { name:'cardNum',  index:'T1.CARD_NUM', resizable : true, align:'center' ,  width:'100px' },
                  { name:'prodNm',   index:'prodNm',  	  resizable : true, align:'center' ,  width:'100px' },
                  { name:'txnSubType',   index:'txnSubType',  resizable : true, align:'center',    width:'100px'},
                  { name:'pnt',   index:'pnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
                  { name:'rid',   index:'T1.rid', hidden:true},
             ],
          sortname: 'chnlNm'
         ,autowidth : true
         ,sortorder: "desc"
         ,footerrow: true
         ,userDataOnFooter : true,
         shrinkToFit: false
    };



    affiliateTransDtlList = $("#affiliateTransDtlListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function setAffiliateTransDetailGridTotal(){
 	var obj ={};
	if(prRid==""){
			prRid="a";
	}
	var startYm = $("#startYM").val();
	if(startYm==""){
		startYm="1";
	}
	obj = dateValSetting(startYm);
	obj.affiliateGridDiv ="detail";  //그리드 detail 조건부 표시  합계 조회시 사용
	obj.prRid = prRid;
 	$.ifvPostJSON('<ifvm:action name="getAffiliateSum"/>', obj, function(result) {
 		affiliateTransDtlList.setFooter({"chnlNm" : "Total", "pnt" :  Math.round(Number(result.pntSum)) });
 	});
}

var jqGridOptionInit = {
	    colNames:[
                  '<spring:message code="L01919" />',  /* 가맹점코드 */
                  '<spring:message code="L01920" />',  /* 가맹점상호 */
                  '<spring:message code="L00614" />',  /* 가맹점약호 */
                  '<spring:message code="L01921" />',	/* 사업자번호 */
                  '<spring:message code="L01922" />',	/* 가맹점상태 */
                  '<spring:message code="L01923" />',	/* 총 적립금액 */
                  '<spring:message code="L01924" />',	/* 총 사용금액 */
                  'prRid',
                ],
       colModel:[
                 { name:'chnlNo',   index:'TT2.CHNL_NO',  resizable : true, align:'center',    width:'100px' },
                 { name:'chnlNm',   index:'TT2.CHNL_NM',  resizable : true, align:'center',    width:'100px'  },
                 { name:'mbrbsCdadd',   index:'TT2.MBRBS_CDADD',  resizable : true, align:'center' ,  width:'100px' },
                 { name:'bizrNo',   index:'TT2.BIZR_NO',  resizable : true, align:'center' ,  width:'100px' },
                 { name:'mbrbsStatusCd',   index:'cc.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
                 { name:'acrl',   index:'acrl',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
                 { name:'rdm',   index:'rdm',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
                 { name:'prRid',   index:'TT1.PR_RID', hidden : true},
                ],
      dataType:"clientSide",
      data : {}
	}

var jqGridOptionDtlInit = {
        colNames:[
                  '<spring:message code="L01925" />',  /* 가맹점명 */
                  '<spring:message code="L01926" />',  /* 승인일자 */
                  '<spring:message code="L01927" />',  /* 회원명 */
                  '<spring:message code="L01928" />',	/* 카드번호 */
                  '<spring:message code="L01929" />',	/* 제품명 */
                  '<spring:message code="L01930" />',	/* 거래상세유형 */
                  '<spring:message code="L01931" />',	/* 포인트 */
                  'rid',	/* rid*/
                ],
       colModel:[
                 { name:'chnlNm',   index:'T2.CHNL_NM',  resizable : true, align:'center',    width:'100px' /* ,formatter : actYearMonthFormat */ },
                 { name:'apprDt',   index:'T1.APPR_DT',  resizable : true, align:'center',    width:'100px' ,formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
                 { name:'mbrNm',   index:'mbrNm',  resizable : true, align:'center',    width:'100px'  },
                 { name:'cardNum',   index:'T1.CARD_NUM',  resizable : true, align:'center' ,  width:'100px' },
                 { name:'prodNm',   index:'prodNm',  resizable : true, align:'center' ,  width:'100px' },
                 { name:'txnSubType',   index:'txnSubType',  resizable : true, align:'center',    width:'100px'},
                 { name:'pnt',   index:'pnt',  resizable : true, align:'right',    width:'100px' ,formatter:'integer'},
                 { name:'rid',   index:'T1.rid', hidden:true},
            ],
      dataType:"clientSide",
      data : {}
	}

$(document).ready(function() {
    getStartYm();
    $("#affiliateTransListGrid").ifvGrid({ jqGridOption : jqGridOptionInit });
    $("#affiliateTransDtlListGrid").ifvGrid({ jqGridOption : jqGridOptionDtlInit });
	//$("#affiliateTransListGrid").ifvGrid({ jqGridOption : {} });
    //$("#affiliateTransDtlListGrid").ifvGrid({ jqGridOption : {} });
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
       	<spring:message code="L01932" />
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
    	<ifvm:inputNew type="button" btnFunc="affiliateTransListSearch" btnType="search" text="L00081" />
    	</div>
   </div>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L01933" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload2('affiliateTransListGrid')" />
        </div>
    </div>
    <div id="affiliateTransListGrid" class="white_bg grid_bd0"></div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L01934" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload2('affiliateTransDtlListGrid')" />
        </div>
    </div>
    <div id="affiliateTransDtlListGrid" class="white_bg grid_bd0"></div>
</div>

