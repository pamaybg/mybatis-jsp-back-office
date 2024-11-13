<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}" style="color:#1266FF; text-decoration:underline;" >{{:custNm}}</a>
</script>
<script type="text/x-jsrender" id="chnlLinkTemplate">
		<a href="<ifvm:url name="chnlDetail"/>?rid={{:ridChnl}}" style="color:#1266FF; text-decoration:underline;" >{{:chnlNm}}</a>
</script>

<script type="text/javascript">
var pointManagementList;
var gridIdpointManagementList;
var rid ;

//등급그룹 목록 조회
function getPointManagementList(){
    var ejGridOption = {
    	recordDoubleClick : function(args){
	   		var data = args.data;
	   		rid = data.rid;
	   		pointDtlPop();   // 상세 보기 이벤트


       	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
       	},
        dataUrl : '<ifvm:action name="getPointList"/>',
        columns:[
//         	{
// 	      		  field : 'txnDate', headerText : '<spring:message code="M02016"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'a.txn_date' }//거래일자
// 	      	  },{
// 	      		  field : 'txnTime', headerText : '<spring:message code="M02017"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'a.txn_time' } //거래시간
// 	      	  },
	      	  {
	      		  field : 'custNm', headerText : '<spring:message code="L00435"/>', headerTextAlign : 'center', template: "#mbrLinkTemplate",
	      		  customAttributes : {
	      			  index : 'c.cust_nm' }//회원명
	      	  },
// 	      	  {
// 	      		  field : 'birthDt', headerText : '<spring:message code="M02018"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c.birth_dt' }//생년월일
// 	      	  },
	      	  {
	      		  field : 'mbrStatCd', headerText : '<spring:message code="M02019"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c.MBR_STAT_CD' }//회원상테
	      	  },
// 	      	  {
// 	      		  field : 'pntTxnType1', headerText : '<spring:message code="L00356"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c1.mark_name' }//거래유형
// 	      	  },
	      	  {
	      		  field : 'pntTxnType2', headerText : '<spring:message code="L00350"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c2.mark_name' }//거래 상세 유형
	      	  },{
	      		  field : 'txnAmt', headerText : '<spring:message code="L00355"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.TXN_AMT' }//거래금액
	      	  },{
	      		  field : 'pntAmt', headerText : '<spring:message code="L00422"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.pnt_amt' }//포인트
	      	  },
// 	      	  {
// 	      		  field : 'rcptNo', headerText : '<spring:message code="L00381"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'lmsr.rcpt_no' }/*영수증번호*/
// 	      	  },
	      	  {
	      		  field : 'mbrStatCd', headerText : '<spring:message code="L00351"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c3.mark_name' }/*거래상태*/
	      	  },{
	      		  field : 'apprNo', headerText : '<spring:message code="M00966"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.appr_no' }/*승인번호*/
	      	  },{
	      		  field : 'apprDate', headerText : '<spring:message code="L00376"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.appr_date' }/*승인일자*/
	      	  },{
	      		  field : 'apprTm', headerText : '<spring:message code="L00375"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.appr_tm' }/*승인시간*/
	      	  },{
	      		  field : 'orgnApprNo', headerText : '<spring:message code="M02020"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.orgn_appr_no' }/*원거래승인번호*/
	      	  },{
	      		  field : 'orgnApprDate', headerText : '<spring:message code="M02021"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.orgn_appr_date' }/*원거래승인일자*/
	      	  },
// 	      	  {
// 	      		  field : 'posNo', headerText : '<spring:message code="L00322"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'lmsr.pos_no' }/*단말기번호*/
// 	      	  },
	      	  {
	      		  field : 'chnlNm', headerText : '<spring:message code="M00506"/>', headerTextAlign : 'center',template: "#chnlLinkTemplate",
	      		  customAttributes : {
	      			  index : 'e.CHNL_NM' }/* */
	      	  },{
	      		  field : 'txnUniqNo', headerText : '<spring:message code="L00354"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.txn_uniq_no' }/* */
	      	  },{
	      		  field : 'pgmNm', headerText : '<spring:message code="M01907"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'd.pgm_nm' }/* */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 'lmsr.rid' }/* */
	      	  },{
	      		  field : 'ridPgm', headerText : 'ridPgm',visible : false,
	      		  customAttributes : {
	      			  index : 'lmsr.RID_PGM' }/* */
	      	  },{
	      		  field : 'ridMbr', headerText : 'ridMbr', visible : false,
	      		  customAttributes : {
	      			  index : 'lmsr.rid_mbr' }
	      	  },{
	      		  field : 'ridChnl', headerText : 'ridChnl', visible : false,
	      		  customAttributes : {
	      			  index : 'lmsr.rid_chnl' }
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true,
        	tempId : 'ifvGridOriginTemplete'
    };

    pointManagementList = $("#pointManagementList").ifvsfGrid({ ejGridOption : ejGridOption });
    gridIdpointManagementList = $("#gridIdpointManagementList");
}

//그리드 텍스트 선택시 상세로 이동
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}
function goGridRowChnlLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}
function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}


//공통 조회 조건 목록 설정
function pointManagementListSearchInit() {
    $.fn.ifvmSetCommonCondList("pointSearchList","PLOY_201");
}

//공통 조회 호출
function pointManagementListSearch() {
    $.fn.ifvmSubmitSearchCondition("pointSearchList", getPointManagementList);
}

// 상세 팝업 화면 호출
function pointDtlPop(){

	$("#pointDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="pointDtlPopListNew"/>',
        contentType: "ajax",
        title: '<spring:message code="L00477"/>',
        width: '1000px',
        close : 'pointDtlPopClose'
    });
}

//팝업 닫기
function pointDtlPopClose() {
	pointDialog._destroy();
}


$(document).ready(function() {
    //공통 조회 조건 목록 설정
    pointManagementListSearchInit();

    pointManagementListSearch();
    //조회
    $('#pointManagementListSearchBtn').on('click', function(){
    	pointManagementListSearch();
    });

    //초기화
    $("#pointManagementListSearchInitBtn").on('click', function(){
    	pointManagementListSearchInit();
    });

});

</script>


<div class="page-title">
    <h1>
    <spring:message code="M02022" />
	&gt; <spring:message code="M00135" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="pointManagementListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="pointManagementListSearchInitBtn">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="pointSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="pointManagementList" class="white_bg grid_bd0"></div>
</div>

<div id="pointDialog" class="popup_container"></div>
