<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var batchRegistList;
var rid ;
var testTab;

function getBatchRegistSearch(){
    var ejGridOption = {
        rowSelected : function (args) {
        	rid = args.data.rid;
        	upldItemSearchInit()
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        dataUrl : '<ifvm:action name="getUnSubExcelUploadList"/>',
        columns:[
        	{
	      		  field : 'fileUpldDt', headerText : '파일 업로드 일자', headerTextAlign : 'center', textAlign: 'center', width : '80px',
	      	},
	      	{
	      		  field : 'fileNm', headerText : '파일명', headerTextAlign : 'center', textAlign: 'left', width : '160px',
	      	},
        	{
	      		  field : 'fileTotCnt', headerText : '파일업로드 총건수', headerTextAlign : 'center', textAlign: 'right', width : '80px', format : '{0:n0}',
	      	},
        	{
	      		  field : 'fileUpldSucesCnt', headerText : '파일업로드 성공건수', headerTextAlign : 'center', textAlign: 'right', width : '80px', format : '{0:n0}',
	      	},
        	{
	      		  field : 'fileUpldFailCnt', headerText : '파일업로드 실패건수', headerTextAlign : 'center', textAlign: 'right', width : '80px', format : '{0:n0}',
	      	},
        	{
	      		  field : 'pointTrtStatus', headerText : '처리상태', headerTextAlign : 'center', textAlign: 'left', width : '60px',
	      	},
        	{
	      		  field : 'ridUpldEmp', headerText : '처리자', headerTextAlign : 'center', textAlign: 'left', width : '80px', 
	      	},
        	{
	      		  field : 'rid', headerText : '', headerTextAlign : 'center', width : '60px', textAlign: 'right', visible:false,
	      	},
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'fileUpldDt',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
    };
    batchRegistList = $("#batchRegistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//데이터 조회조건 날자 빈값 처리
function InitializeDate(){
	$(".datepicker").val("");
}


//공통 조회 조건 목록 설정
function batchRegistListSearchInit() {
   $.fn.ifvmSetCommonCondList("batchRegistSearch","SMS_UNSUB_ULOAD");
   InitializeDate();
}

//공통 조회 호출
function batchRegistListSearchFn() {
    $.fn.ifvmSubmitSearchCondition("batchRegistSearch", getBatchRegistSearch);
}

function tabContent(){
	testTab = $('#tabContent').DrawTab({
		item: [
			{label:'업로드 상세' , href: '<ifvm:url name="smsUpldItemList"/>' +"?rid="+rid},
		]
	});
}

/**
 * 파일업로드
 */
function fileUploadFn(){
	fileUploadPop ={
		        id : "excelFileUploadPop"
		    };
	fileUploadPop.popup = function (){
			 fileUploadPop.pop = $('#'+fileUploadPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="smsExcelFileUploadPop"/>',
		            contentType: "ajax",
		            title: '파일업로드',
		            width: "700px"
		        });
		};
		fileUploadPop.beforeClose = function (obj) {
		};
		fileUploadPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 fileUploadPop.popup();
}

/**
 * 업로드파일 확정처리
 */
function fileUploadConfirmFn() {
    var dataList = batchRegistList.opt.gridControl.getSelectedRecords();
    if (dataList.length != 0) {
		if (confirm('등록한 엑셀정보를 등록 하시겠습니까?')) {
			$.ifvPostJSON('<ifvm:action name="callUnSubscribeSms"/>', {
				ridPar : rid
			 }, function(result) {
			    	alert('<spring:message code="I00741"/>');

			    	batchRegistList.searchGrid();
					upldItemList.searchGrid();
			    });
	        }
    } else {
    	alert('<spring:message code="L00066"/>');
    };
}


$(document).ready(function() {
    //공통 조회 조건 목록 설정
    batchRegistListSearchInit();
    batchRegistListSearchFn();
    getBatchRegistSearch();
    tabContent();

});
</script>

<div class="page-title">
    <h1>
        <spring:message code="080수신자거부 관리" /> &gt; <spring:message code="조회" />
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-5">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-7 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="batchRegistListSearchBtn" btnFunc="batchRegistListSearchFn" objCode="smsUnSubUploadSearch_OBJ"/>
            <ifvm:inputNew type="button"   text="M00278"  id="pointStandardSearchInitBtn" btnFunc="batchRegistListSearchInit" objCode="smsUnSubUploadInit_OBJ"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="batchRegistSearch" >
    </div>
</div>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-5">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-7 searchbtn_r">
 			<ifvm:inputNew type="button"   btnType="save"  	text="M01858"  id="fileUploadBtn" btnFunc="fileUploadFn" objCode="smsUnSubUploadFileUpload_OBJ"/>
 			<ifvm:inputNew type="button"   btnType="upload"	text="적용"  id="fileUploadConfirmBtn" btnFunc="fileUploadConfirmFn" nuc="true" objCode="smsUnSubUploadConfirm_OBJ"/>
        </div>
    </div>
    <div id="batchRegistListGrid" class="white_bg grid_bd0"></div>
</div>


<div id="testViewListTabArea">
 <div class="btn-group btn-group-justified" id="tabType">
 </div>
 <!-- 탭 컨텐츠 -->
 <div id="tabArea">
	<div id="tabContent" ></div>
 </div>

</div>

<div id="excelFileUploadPop" class="popup_container"></div>
