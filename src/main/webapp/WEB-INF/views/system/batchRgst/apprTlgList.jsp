<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">
var vocInfoList;
var resData =null; //응답전문
var reqData =null; //요청전문
var trNum =null;
//포인트 소멸자  조회
function aprLogList() {
	var ejGridOption = {
		isHorizontalScroll: true,
		rowSelected : function(args) {
			trNum=args.data.trNo;
			resData=args.data.resMsg;
			reqData=args.data.reqMsg;
            jobTabApp.drawTab();
		},
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
		dataUrl : '<ifvm:action name="setBatchLog"/>',
		columns : [
		{
			field : 'createDt', headerText : '생성일시', headerTextAlign : 'center',textAlign : 'center', width:'130px',
			customAttributes : {//
				index : 'A.CREATE_DATE'
			}
		}, {
			field : 'trNo', headerText : '거래번호', headerTextAlign : 'center',width:'170px',
			customAttributes : { //
				index : 'A.TR_NO',
				title : '{{:trNo}}'
			}
		}, {
			field : 'logType', headerText : '로그유형', headerTextAlign : 'center',textAlign : ej.TextAlign.Center, visible : false,
			customAttributes : {//
				index : 'A.LOG_TYPE'
			}
		}, {
			field : 'typeNo', headerText : '요청유형', headerTextAlign : 'center',textAlign : ej.TextAlign.Center, width:'60px',
			customAttributes : {//
				index : 'A.TYPE_NO'
			}
		}, {
			field : 'telNm', headerText : '전문유형명', headerTextAlign : 'center',textAlign : 'center',width:'100px',
			customAttributes : {//
				index : 'c.MARK_NAME'
			}
		}, {
			field : 'reqTrDt', headerText : '요청일자',headerTextAlign : 'center',textAlign : ej.TextAlign.Center, width:'130px',
			customAttributes : {//
				index : 'A.TR_DT'
			}
		}, {
			field : 'reqTrTime', headerText : '요청시간',headerTextAlign : 'center',textAlign : ej.TextAlign.Center, visible : false,
			customAttributes : {//
				index : 'A.TR_TIME'
			}
		},{
			field : 'storeCd', headerText : '매장코드',headerTextAlign : 'center',textAlign : 'center',width:'60px',
			customAttributes : {//
				index : 'A.STORE_CD'
			}
		},{
			field : 'storeNm', headerText : '매장명',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {//
				index : 'C.CHNL_NM'
			}
		},{
			field : 'posCd', headerText : '포스코드',headerTextAlign : 'center',textAlign : 'center',width:'60px',
			customAttributes : {//
				index : 'A.POS_CD'
			}
		},{
			field : 'reqMsg', headerText : '요청전문',headerTextAlign : 'center', visible : false,
			customAttributes : {
				index : 'A.MSG'
			}
		},{
			field : 'blogType', headerText : '로그유형',headerTextAlign : 'center',textAlign : ej.TextAlign.Center, visible : false,
			customAttributes : {
				index : 'B.LOG_TYPE'
			}
		},{
			field : 'btypeNo', headerText : '응답유형',headerTextAlign : 'center',textAlign : 'center', width:'50px',
			customAttributes : {
				index : 'B.TYPE_NO'
			}
		},{
			field : 'resSendDt', headerText : '응답일자',headerTextAlign : 'center',textAlign : 'center', width:'130px',
			customAttributes : {
				index : 'B.TR_DT'
			}
		},{
			field : 'resSendTime', headerText : '응답시간',headerTextAlign : 'center',textAlign : 'right',visible : false,
			customAttributes : {
				index : 'B.TR_TIME'
			}
		},{
			field : 'resMsg', headerText : '응답전문',headerTextAlign : 'center', visible : false, textAlign : 'center',
			customAttributes : {
				index : 'B.MSG'
			}
		},{
			field : 'rst', headerText : '결과',headerTextAlign : 'center', template : "#execStatFormatter", textAlign : 'center',width:'50px',
			customAttributes : {
				index : 'B.RST'
			}
		},{
			field : 'rstCd', headerText : '결과명',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'c2.MARK_NAME'
			}
		},{
			field : 'rstMsg', headerText : '결과메시지', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'B.RST_MSG'
			}
		},{
			field : 'actTime', headerText : '수행시간(초)', headerTextAlign : 'center',textAlign : 'right',width:'70px',
			customAttributes : {
				index : '',
			}
		} ],
		requestGridData : {
			nd : new Date().getTime(),
			rows : 10,
			sidx : 'A.CREATE_DATE',
			sord : 'desc',
			_search : false
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true,
		tempId :'ifvGridOriginTemplete'
	};

	vocInfoList = $("#vocInfoListGrid").ifvsfGrid({
		ejGridOption : ejGridOption
	});
}

var jobTabApp = {
	    drawTab : function () {
	        $("#jobDetailTabArea").empty();

	        $("#jobDetailTabArea").DrawTab(
	            {
	                item: [
	                	{label: '전문', href: '<ifvm:url name='reqData' />'},
	                	{label: '실행서버로그', href: '<ifvm:url name='dblogList' />'}
	                ]
	            }
	        )
	    }
	}
//공통 조회 조건 목록 설정
function ListSearchInit() {
	$.fn.ifvmSetCommonCondList("ListSearchList", "APR_SERVER_LOG");
}
//공통 조회 호출
function ListSearch() {
	var rstdDate;
	var rendDate;
    $.fn.ifvmSubmitSearchCondition_NoAllSearch("ListSearchList", function() {
    	if ($.fn.ifvmIsNotEmpty(requestitem)) {
    		for(var i=0;i<requestitem.length;i++){
    			var getTrNo =requestitem[i].comTgCol
    			if(getTrNo=='CREATE_DATE'){
    				rstdDate =requestitem[i].startDate;
    				rendDate =requestitem[i].endDate;
    			break;
    			}
    		}
    		var g=rstdDate.split(" ");
    		var d=g[0].split("-");
    		var t=g[1].split(":");
    		var sdate1 = new Date(d[0],(d[1]-1),d[2],t[0],t[1],t[2]);

    		var g1=rendDate.split(" ");
    		var d1=g1[0].split("-");
    		var t1=g1[1].split(":");
    		var sdate2 = new Date(d1[0],(d1[1]-1),d1[2],t1[0],t1[1],t1[2]);

    		var a = (sdate2.getTime()-sdate1.getTime())/(1000*60*60*24);
    		if(a>=1){
    			alert('시작날짜와 종료날짜가 같아야 합니다.');
    			return;
    		}
    		vocInfoList.searchGrid({item: requestitem});
    	} else {
    		alert('최소 1개의 조회조건을 입력해주세요.');
    	}
    });
	resData =null; //응답전문
	reqData =null; //요청전문
	trNum =null;
	$("#jobDetailTabArea").empty();
}



$(document).ready(function() {
	$.ifvmLnbSetting('batchLogList');
	ListSearchInit();
	//공통 조회 조건 목록 설정
	aprLogList();

  	//조회
    $('#ListSearchBtn').on('click', function(){
    	ListSearch();
    });

    //초기화
    $("#SearchInitBtn").on('click', function(){
    	ListSearchInit();
    });

});
</script>

<div class="page-title">
	<h1>
		승인서버 전체 로그
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="ListSearchBtn">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="SearchInitBtn">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="ListSearchList">
	</div>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L00930" /></span>
		</div>
	</div>
	<div id="vocInfoListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="jobDetailTabArea">
