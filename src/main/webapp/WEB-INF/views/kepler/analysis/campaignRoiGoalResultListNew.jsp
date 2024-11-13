<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script>

var campaignRoiGoalResultListData = [];

function setDropDownOption() {
	//ajax 통신 가정
	var optionArr1 = [
        {codeName: "NA", markName: "전체"},
        {codeName: "1", markName: "응모"},
        {codeName: "2", markName: "오퍼"},
        {codeName: "3", markName: "안내"},
    ];

	var optionArr2 = [
        {codeName: "NA", markName: "전체"},
        {codeName: "1", markName: "자동"},
        {codeName: "2", markName: "수동"},
    ];

	var option1 = $('#commCodeSelectTemplate').tmpl(optionArr1);
	$('#type1').append(option1);

	var option2 = $('#commCodeSelectTemplate').tmpl(optionArr2);
	$('#type2').append(option2);
}

function setCalendar() {
	 var startDate = $('#termStartDate');
	 var endDate = $('#termEndDate');
	 //오늘날짜
	 startDate.val($.ifvGetTodayDate());
	 //오늘부터 한달 뒤
	 endDate.val($.ifvGetNewDate('m', +1).newDateS);

	 //설정
	 startDate.ifvDateChecker({
	  maxDate : endDate
	 });

	 endDate.ifvDateChecker({
	  minDate : startDate
	 });
}

function getCamRoiGoalResultListData() {

//     var groupHeaderObj = {
//  	   useColSpanStyle: true,
// 	   groupHeaders:[
// 			{startColumnName: 'rsltRespCnt',   numberOfColumns: 2, titleText: '반응'},
//  			{startColumnName: 'rsltAppliCnt',  numberOfColumns: 2, titleText: '응모'},
// 			{startColumnName: 'rsltWinnerCnt', numberOfColumns: 2, titleText: '당첨'}
// 	   ]
//    };

    var ejGridOption = {
    		
//     		https://js.syncfusion.com/demos/web/#!/bootstrap/grid/columns/stackedheader 참고 
    	showStackedHeader:true,
   		stackedHeaderRows:[
   			{stackedHeaderColumns:[
   				{headerText:'기본정보',column:'roiType, roiSubType, camStartDd, camEndDd, camNm, rsltTgtCnt'}
   			   ,{headerText:'반응',column:'rsltRespCnt, rsltRespPct'}
   			   ,{headerText:'응모',column:'rsltAppliCnt, rsltAppliPct'}
   			   ,{headerText:'당첨',column:'rsltWinnerCnt, rsltWinnerPct'}
			]}
		],
    	serializeGridData: function(data) {
            return data;
        },
        onSelectCell: function(data) {
        },
        loadComplete: function(obj) {
        },
		searchInit : function(){//초기화
			$("#comSearchArea input").val("");
			this.setMaskingBtn();
		},
		actionComplete: function (args) { 
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[0]).addClass("over");
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[5]).addClass("over");
		},
		dataUrl: '<ifvm:action name="getCampaignRoiGoalResultList"/>',
        columns:[
        	  {
	      		  field : 'roiType', headerText : '형태', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'roiSubType', headerText : '형태2', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'camStartDd', headerText : '개시', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'camEndDd', headerText : '종료', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'camNm', headerText : '캠페인명', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'rsltTgtCnt', headerText : '대상자', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'rsltRespCnt', headerText : '반응인원', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'rsltRespPct', headerText : '반응률', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'rsltAppliCnt', headerText : '응모인원', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'rsltAppliPct', headerText : '응모율', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'rsltWinnerCnt', headerText : '당첨인원', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'rsltWinnerPct', headerText : '당첨율', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'rsltGoalVal', headerText : '목표달성율', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'roi', headerText : 'ROI', visible : false ,
	      		  customAttributes : {
	      			sortable : false,
	      			  index : '' }/**/
	      	  }
		],
		requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 't1.cam_start_dd',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true 
	};
	campaignResultListGrid = $('#analysisCampaignResultList').ifvsfGrid({ejGridOption: ejGridOption});
// 	campaignResultListGrid.opt.grid.jqGrid('setGroupHeaders', groupHeaderObj);
}

function setPercent(data) {
    var rtnValue = Math.round(data);
	return rtnValue + ' %';
}

/**
 *
 */
function formatRoiType(data) {
    var rtnValue = '';
	switch (data) {
	case '1':
		rtnValue = '응모';
	    break;
	case '2':
		rtnValue = '오퍼';
	    break;
	case '3':
		rtnValue = '안내';
	    break;
	}
	return rtnValue;
}

/**
 *
 */
function formatRoiSubType(data) {
    var rtnValue = '';
	switch (data) {
	case '1':
		rtnValue = '자동';
	    break;
	case '2':
		rtnValue = '수동';
	    break;
	}
	return rtnValue;
}

function openEventResultAnalysisPop() {

	$('#eventResultAnalysisPop').ifvsfPopup({
		enableModal : true,
		enableResize : false,
		contentUrl : '<ifvm:url name="eventResultAnalysisPop"/>',
		contentType : "ajax",
		title : '이벤트 성과분석',
		width : '1200px',
		maxHeight: null,

	});
}

$(document).ready(function() {

    setDropDownOption();
    setCalendar();

    getCamRoiGoalResultListData();

});


</script>


<div class="page_btn_area">
	<div class="col-xs-2">
		<span>캠페인 결과 및 성과</span>
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" id="campaignRoiGoalResultListSearchBtn" objCode="campaignRoiGoalResultListSearchBtn_OBJ" text="L00030" btnType="search"/>
	</div>
</div>
<div class="well form-horizontal underline" id="comSearchArea">
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="type1" dto="type1" label="유형1" labelClass="1" conClass="1" nuc="true"/>
		<ifvm:inputNew type="select" id="type2" dto="type2" label="유형2" labelClass="1" conClass="1" nuc="true"/>
		<ifvm:inputNew type="dateTerm" startDto="termStartDate" endDto="termEndDate" startId="termStartDate" endId="termEndDate" required="true" label="기간" labelClass="1" conClass="3" nuc="true" />
	</div>
</div>
<div class="page_btn_area">
	<div class="col-xs-2">
		<span>조회결과</span>
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" text="이벤트결과상세분석" nuc="true" btnFunc="openEventResultAnalysisPop" id="openEventResultAnalysisBtn" objCode="openEventResultAnalysisBtn_OBJ"/>
	</div>
</div>
<div>
    <div id="analysisCampaignResultList" class="white_bg grid_bd0"></div>
</div>
<div id="eventResultAnalysisPop" class="popup_container"></div>
<script>


// $(document).ready(function() {
// 	setDropDownOption();
// 	setCalendar();
// 	makeGrid();
// });

</script>