<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var affiliateTransList;
var affiliateTransDtlList;
var actYearMonth ;
var prRid = "";

function affiliateTransListSearchInit(){
    var ejGridOption = {
        rowSelected : function (args) {
         	prRid = args.data.prRid
         	getAffiliateTransDtlListSearch();
        },
        loadComplete : function(grid, obj){
         	prRid="";
        	setAffiliateTransGridTotal(obj.expandObj);
        },
        dataUrl : '<ifvm:action name="getAffiliateTransList"/>',
        columns:[
        	  {
	      		  field : 'chnlNo', headerText : '<spring:message code="L01919"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'TT2.CHNL_NO' }/*가맹점코드 */
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="L01920"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'TT2.CHNL_NM' }/*가맹점상호 */
	      	  },{
	      		  field : 'mbrbsCdadd', headerText : '<spring:message code="L00614"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'TT2.MBRBS_CDADD' }/*가맹점약호 */
	      	  },{
	      		  field : 'bizrNo', headerText : '<spring:message code="L01921"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'TT2.BIZR_NO' }/*사업자번호 */
	      	  },{
	      		  field : 'mbrbsStatusCd', headerText : '<spring:message code="L01922"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable: false,
	      			  index : 'cc.MARK_NAME' }/*가맹점상태 */
	      	  },{
	      		  field : 'acrl', headerText : '<spring:message code="L01923"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'acrl' }/*적립금액 */
	      	  },{
	      		  field : 'rdm', headerText : '<spring:message code="L01924"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'rdm' }/*사용금액 */
	      	  },{
	      		  field : 'prRid', headerText : 'prRid', visible : false ,
	      		  customAttributes : {
	      			  index : 'TT1.PR_RID' }/* */
	      	  },
          ],
          requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'TT2.CHNL_NO',
        	  sord : 'desc',
        	  _search : false
          },
          showSummary:true,
          summaryRows: [
        	    {title: "Total"
        	    , summaryColumns: [
        	    		{summaryType: ej.Grid.SummaryType.Custom
         	    		, customSummaryValue: 0
        	    		, displayColumn: "rdm"},
        	    		{summaryType: ej.Grid.SummaryType.Custom
            	    	, customSummaryValue: 0
           	    		, displayColumn: "acrl"} 
        	    	]
        	    }
			],
          gridDataInit: false,
          rowList : [10,25,50,100],
    };


    affiliateTransList = $("#affiliateTransListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function setAffiliateTransGridTotal(result){
	if(result) {
		affiliateTransList.find('.e-gridSummaryRows').children('td').eq(5).text(Math.round(Number(result.acrlSum)));
		affiliateTransList.find('.e-gridSummaryRows').children('td').eq(6).text(Math.round(Number(result.rdmSum)));
	} else {
		affiliateTransList.find('.e-gridSummaryRows').children('td').eq(5).text('');
		affiliateTransList.find('.e-gridSummaryRows').children('td').eq(6).text('');
	}
}


function getAffiliateTransListSearch() {
	var data = {page: 1};
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

	affiliateTransList.searchGrid(data);
	affiliateTransDtlList.opt.gridControl.dataSource([]);
	affiliateTransDtlList.emptyMsgDiv.show();
	
}

function affiliateTransDtlListSearchInit() {
	var ejGridOption = {
        loadComplete : function(obj){
          	setAffiliateTransDetailGridTotal();
        },
        dataUrl : '<ifvm:action name="getAffiliateTransDtlList"/>',
        columns:[
        		{
	      		  field : 'chnlNm', headerText : '<spring:message code="L01925"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'T2.CHNL_NM' }/*가맹점명 */
	      	  },{
	      		  field : 'apprNo', headerText : '<spring:message code="L00995"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'T1.APPR_NO' }/*승인번호 */
	      	  },{
	      		  field : 'apprDt', headerText : '<spring:message code="L01926"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'T1.APPR_DT' }/*승인일자 */
	      	  },{
	      		  field : 'mbrNm', headerText : '<spring:message code="L01927"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'mbrNm' }/*회원명 */
	      	  },{
	      		  field : 'cardNum', headerText : '<spring:message code="L01728"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'T1.CARD_NUM' }/*카드번호 */
	      	  },{
	      		  field : 'prodNm', headerText : '<spring:message code="L01929"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'prodNm' }/*제품명 */
	      	  },{
	      		  field : 'txnSubType', headerText : '<spring:message code="L01730"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'txnSubType' }/*거래상세유형 */
	      	  },{
	      		  field : 'pnt', headerText : '<spring:message code="L01731"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'pnt' }/*포인트 */
	      	  },{
	      		  field : 'rid', headerText : 'rid',  visible : false ,
	      		  customAttributes : {
	      			  index : 'T1.rid' }/*rid */
	      	  },
         ],
         requestGridData : {
       	  nd   : new Date().getTime(),
       	  rows : 10,
       	  sidx : 'chnlNm',
       	  sord : 'desc',
       	  _search : false
         },
         showSummary:true,
         summaryRows: [
       	    {title: "Total"
       	    , summaryColumns: [
       	    		{summaryType: ej.Grid.SummaryType.Custom
        	    	, customSummaryValue: 0
       	    		, displayColumn: "pnt"}
       	    	]
       	    }
		 ],
         rowList : [10,25,50,100],
         gridDataInit: false
    };

    affiliateTransDtlList = $("#affiliateTransDtlListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function getAffiliateTransDtlListSearch(){
	var data = {page: 1};
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
	affiliateTransDtlList.searchGrid(data);
}

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
 		if(result && result.pntSum)
 			affiliateTransDtlList.find('.e-gridSummaryRows').children('td').eq(7).text(result.pntSum);
 		else
 			affiliateTransDtlList.find('.e-gridSummaryRows').children('td').eq(7).text('');
 	});
}

$(document).ready(function() {
    getStartYm();
    affiliateTransListSearchInit();
    affiliateTransDtlListSearchInit();
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
        an>&gt;<spring:message code="L00081"/>
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
        	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('affiliateTransListGrid')" />
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
        	<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('affiliateTransDtlListGrid')" />
        </div>
    </div>
    <div id="affiliateTransDtlListGrid" class="white_bg grid_bd0"></div>
</div>

