<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/x-jsrender" id="execStatFormatter">
	{{if rst == ""}}
		<span style="color:#FFA500;">●</span>
	{{/if}}
	{{if rst == "S"}}
		<span style="color:#0000FF;">●</span>
	{{/if}}
	{{if rst == "F"}}
		<span style="color:#FF0000;">●</span>
	{{/if}}
</script>

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
			field : 'createDt', headerText : '생성일시', headerTextAlign : 'center',textAlign : 'center', 
			customAttributes : {index : 'A.CREATE_DATE', sortable: false}, visible : false
		},  {
			field : 'trNo', headerText : '거래번호', headerTextAlign : 'center', width : '10%',
			customAttributes : { index : 'A.TR_NO',title : '{{:trNo}}',searchable : true, sortable: false}
		}, {
			field : 'typeNo', headerText : 'API NO', headerTextAlign : 'center',textAlign : ej.TextAlign.Center, width : '6%',
			customAttributes : {index : 'A.API_NO', searchable : true, sortable: false}
		},{
			field : 'apiNm', headerText : 'API 명', headerTextAlign : 'center',textAlign : 'left', 
			customAttributes : {index : 'las.API_NM', sortable: false}, width : '10%',
		}, /* {
			field : 'logType', headerText : '로그유형', headerTextAlign : 'center',textAlign : ej.TextAlign.Center, visible : false,
			customAttributes : {index : 'A.LOG_TYPE', searchable : true}
		}, */  /* {
			field : 'reqTrTime', headerText : '요청시간',headerTextAlign : 'center',textAlign : ej.TextAlign.Center, visible : false,
			customAttributes : {index : 'A.TR_TIME'	}
		}, */{
			field : 'storeCd', headerText : '채널',headerTextAlign : 'center',textAlign : 'center', width : '6%',
			customAttributes : {index : 'A.CHNL_NO', searchable : true, sortable: false}
		},{
			field : 'reqTrDt', headerText : '요청일자',headerTextAlign : 'center',textAlign : ej.TextAlign.Center, width : '8%',
			customAttributes : {index : 'A.TR_DT', sortable: false}
		},/* {
			field : 'blogType', headerText : '로그유형',headerTextAlign : 'center',textAlign : ej.TextAlign.Center, visible : false,
			customAttributes : {index : 'B.LOG_TYPE'}
		}, *//* {
			field : 'btypeNo', headerText : '응답유형',headerTextAlign : 'center',textAlign : 'center', visible : false,
			customAttributes : {index : 'B.TYPE_NO'}
		}, */{
			field : 'resSendDt', headerText : '응답일자',headerTextAlign : 'center',textAlign : 'center', width : '8%',
			customAttributes : {index : 'B.TR_DT', sortable: false}
		},/* {
			field : 'resSendTime', headerText : '응답시간',headerTextAlign : 'center',textAlign : 'right',visible : false,
			customAttributes : {index : 'B.TR_TIME'	}
		}, */{
			field : 'actTime', headerText : '소요시간(초)', headerTextAlign : 'center',textAlign : 'right', width : '5%',customAttributes : { sortable: false}
		},{
			field : 'rst', headerText : '결과',headerTextAlign : 'center', template : "#execStatFormatter", textAlign : 'center', width : '3%',
			customAttributes : {index : 'B.RST', sortable: false}
		},{
			field : 'rstMsg', headerText : '결과메시지',headerTextAlign : 'center',textAlign : 'center', width : '12%',
			customAttributes : {index : 'c2.MARK_NAME', sortable: false	}
		},{
			field : 'rstMsg', headerText : '(결과메시지)', headerTextAlign : 'center',textAlign : 'center', visible : false,
			customAttributes : {index : 'B.RST_MSG', sortable: false}
		} ],
		requestGridData : {
			nd : new Date().getTime(),
			rows : 10,
			_search : false,
			sidx : 'seqNo',
			sord : 'desc'
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true,
		gridDataInit: false,
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
	                	{label: '전송메시지', href: '<ifvm:url name='reqData' />'},
	                	{label: '상세로그', href: '<ifvm:url name='dblogList' />'}
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
	$.fn.ifvmSubmitSearchCondition_NoAllSearch("ListSearchList", function() {
  		if ($.fn.ifvmIsNotEmpty(requestitem)) {
  			vocInfoList.searchGrid({item: requestitem});
    	} else {
    		alert('최소 1개의 조회조건을 입력해주세요.');
    	}
    });
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
    
    //조회 클릭
    $("#ListSearchBtn").trigger("click");

});
</script>

<div class="page-title">
	<h1>
		<spring:message code="API로그(전체)" /> &gt; <spring:message code="조회" />
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="ListSearchBtn" objCode="batchLogListSearch_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="SearchInitBtn" objCode="batchLogListInit_OBJ">
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
