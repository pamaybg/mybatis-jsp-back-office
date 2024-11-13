<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="fileLinkTemplate">
	<a href ="javascript:void(0);" name="fileClick"  onclick="fileLoaction('{{:confirmDtNm}}', '{{:fileUploadUserRid}}', encodeURIComponent('{{:fileName}}') ,encodeURIComponent('{{:filePath}}'),'{{:rid}}');" style="color:#1266FF; text-decoration:underline;" >{{:fileName}}</a>
</script>

<script type="text/javascript">
var batchRegistList;
var rid ;
var testTab;
var promotionSearchHelpPopup = null;

function getBatchRegistSearch(){
    var ejGridOption = {
    	recordDoubleClick : function(args){
        	rid = data.rid;

	     // 상세 보기 이벤트 */
        },
        rowSelected : function (args) {
        	rid = args.data.rid;
        	batchResultCd="";
        	var obj={};
        	obj.ridPntUpload = rid
        	obj.batchResultCd = "";
        	upldItemList.searchGrid(obj);
			if(args.data.procTypeCdNm==='적립') {
				$('#fileUploadUseConfirmBtn').attr('disabled', true);
				if(args.data.confirmDtNm === '확정') {
	        		$('#fileUploadDeleteBtn').attr('disabled', true);
	        		$('#fileUploadConfirmBtn').attr('disabled', true);
	        	} else {
	        		$('#fileUploadDeleteBtn').attr('disabled', false);

	        		//업로드결과 '성공'인 경우에만 확정버튼 활성화
	        		if(args.data.batchResultCd === 'S') {
		        		$('#fileUploadConfirmBtn').attr('disabled', false);
	        		}
	        	}
			} else if(args.data.procTypeCdNm==='사용') {
				$('#fileUploadConfirmBtn').attr('disabled', true);
				if(args.data.confirmDtNm === '확정') {
	        		$('#fileUploadDeleteBtn').attr('disabled', true);
	        		$('#fileUploadUseConfirmBtn').attr('disabled', true);
	        	} else {
	        		$('#fileUploadUseConfirmBtn').attr('disabled', false);

	        		//업로드결과 '성공'인 경우에만 확정버튼 활성화
	        		if(args.data.batchResultCd === 'S') {
	        			$('#fileUploadUseConfirmBtn').attr('disabled', false);
	        		}
	        	}
			}
        	
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        dataUrl : '<ifvm:action name="getPntBatchRgstList"/>',
        columns:[
        	{
	      		  field : 'uploadTypeCdNm', headerText : '<spring:message code="L02356"/>', headerTextAlign : 'center', textAlign: 'center', width : '70px' /*업로드유형 */
	      	},
        	{
	      		  field : 'procTypeCdNm', headerText : '<spring:message code="거래유형"/>', headerTextAlign : 'center', textAlign: 'center', width : '60px', /*대상 */
	      	},
	      	{
	      		  field : 'procDtlTypeCdNm', headerText : '<spring:message code="거래상세유형"/>', headerTextAlign : 'center', textAlign: 'center', width : '85px', /*대상 */customAttributes :{index:'procDtlTypeCd'}
	      	},
        	{
	      		  field : 'fileName', headerText : '<spring:message code="L02359"/>', headerTextAlign : 'center', width : '170px', template : "#fileLinkTemplate", /*파일명 */ customAttributes :{searchable : true}
	      	},
        	{
	      		  field : 'uploadCnt', headerText : '<spring:message code="L02360"/>', headerTextAlign : 'center', textAlign: 'right', width : '60px', format : '{0:n0}' /*대상건수 */, customAttributes :{searchable : true}
	      	},
        	{
	      		  field : 'batchSuccessCnt', headerText : '성공건수', headerTextAlign : 'center', width : '60px', textAlign: 'right', format : '{0:n0}', /*적립성공건수 */ customAttributes :{searchable : true}
	      	},
        	{
	      		  field : 'batchFailCnt', headerText : '실패건수', headerTextAlign : 'center', width : '60px', textAlign: 'right', format : '{0:n0}', /*적립실패건수 */ customAttributes :{searchable : true}
	      	},
        	{
	      		  field : 'totalAcrlAmt', headerText : '총 포인트 금액', headerTextAlign : 'center', width : '85px', textAlign: 'right', format : '{0:n0}', /*총 지급포인트 */
	      	},
        	{
	      		  field : 'batchResultCdNm', headerText : '<spring:message code="M02361"/>', headerTextAlign : 'center', textAlign: 'center', width : '60px', /*업로드처리결과 -> 결과*/
	      	},
        	{
	      		  field : 'confirmDtNm', headerText : '<spring:message code="L02364"/>', headerTextAlign : 'center', textAlign: 'center', width : '60px', /*확정여부*/
	      	},
        	{
	      		  field : 'batchErrorDesc', headerText : '<spring:message code="L02365"/>', headerTextAlign : 'center', width : '150px', /*오류내역*/
	      	},
	      	{
	      		  field : 'fileUploadDt', headerText : '<spring:message code="L02358"/>', headerTextAlign : 'center', width : '90px', /*업로드일자 */
	      	},
      		{
	      		  field : 'fileUploadUserRidNm', headerText : '<spring:message code="M00184"/>', headerTextAlign : 'center', width : '60px', /*등록자 */ customAttributes :{searchable : true,index:'emp2.name'}
	      	},
        	{
	      		  field : 'rid', headerText : 'rid', visible: false,
	      	},
        	{
	      		  field : 'uploadTypeCd', headerText : 'uploadTypeCd', visible: false,
	      	},
        	{
	      		  field : 'procTypeCd', headerText : 'procTypeCd', visible: false,
	      	},
        	{
	      		  field : 'batchResultCd', headerText : 'batchResultCd', visible: false,
	      	},
        	{
	      		  field : 'fileUploadUserRid', headerText : 'fileUploadUserRid', visible: false,
	      	},
        	{
	      		  field : 'confirmUserRid', headerText : 'confirmUserRid', visible: false,
	      	},
        	{
	      		  field : 'filePath', headerText : 'filePath', visible: false,
	      	},
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'fileUploadDt',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
    };
    batchRegistList = $("#batchRegistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function excelDownLink(cellvalue, options, rowObjec){
	//filepath를 받아와서 엑셀 파일읽고 쓰기
	//파일명을 구한후 service단에서 excelwrite를통해 파일명 재지정후 파일 다운로드
     var fileNm = rowObjec.fileName;
     var filePath = rowObjec.filePath;
     var fileRid = rowObjec.rid;
     var data={};
     data.fileName = fileNm;
     data.filePath = filePath;
     var tag = '<a href ="javascript:void(0);" name="fileClick"  onclick = "fileLoaction(\''+/* encodeURI( */encodeURIComponent(fileNm)/* ) */ +'\' ,\''+ /* encodeURI( */encodeURIComponent(filePath)/* ) */ +'\'  ,\''+fileRid+'\'   );" style="color:#1266FF; text-decoration:underline;" >' + fileNm + '</a>';

	var div = '<div id= "excelDown">'+fileNm+'</div>'
return tag;
}

function fileLoaction(confirmDtNm, fileUploadUserRid, fileNm ,filePath ,fileRid){

	//미확정 상태만 다운로드 가능.
	if(confirmDtNm === '확정') {
		alert('확정되지 않은 파일만 다운로드 가능합니다.');
		return false;
	}
	
	if(ifvmUserInfo.id === 'A24767206434005584') {
		
	}

	//업로드한 사용자만 다운로드 가능.
	else if(ifvmUserInfo.id != fileUploadUserRid) {
		alert('등록자만 다운로드 가능합니다.');
		return false;
	}

	 escape(encodeURIComponent(filePath));
     var data={};
     data.fileName = fileNm;
     data.filePath = filePath;
     data.fileRid = fileRid;
     data.fileType = 'loyBatchRgst';
    //$.fn.ifvmBatchRgstExcelDownload2(data);
}

//데이터 조회조건 날자 빈값 처리
function InitializeDate(){
	$(".datepicker").val("");
}


//공통 조회 조건 목록 설정
function batchRegistListSearchInit() {
   $.fn.ifvmSetCommonCondList("batchRegistSearch","PLOY_601");
   //InitializeDate();
}

//공통 조회 호출
function batchRegistListSearchFn() {batchRegistList
    $.fn.ifvmSubmitSearchCondition("batchRegistSearch", function(){
    	batchRegistList.searchGrid({item: requestitem});
    });
}

function tabContent(){
	testTab = $('#tabContent').DrawTab({
		item: items
		/* [
			{label:'<spring:message code="L01645"/>' , href: '<ifvm:url name="pntUpldItemList"/>' +"?rid="+rid},
		] */
	});
}

//업로드한 파일 다운로드
$.fn.ifvmBatchRgstExcelDownload2 = function(data) {
	var inputs = "";
	var url = "/system/batchRgst/gridExcelDown2.do";
	var method = "post"
		//data를 입력받음
		if( data ){
			if ($.fn.ifvmIsNotEmpty(data.fileName) && $.fn.ifvmIsNotEmpty(data.filePath)) {
				inputs += '<input type="hidden" name="fileName" value="'+ data.fileName +'" />';
				inputs += '<input type="hidden" name="filePath" value="'+ data.filePath +'" />';
				inputs += '<input type="hidden" name="rid" value="'+ data.fileRid +'" />';
				inputs += '<input type="hidden" name="fileType" value="'+ data.fileType +'" />';

				// request를 보낸다.
				jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
				.appendTo('body').submit().remove();
			}
		};
};


//샘플데이터 다운로드
$.fn.ifvmBatchRgstExcelSampleDown2 = function(data) {
	var inputs = "";
	var url = "/system/batchRgst/excelSampleDown2.do";
	var method = "post"
		//data를 입력받음
		if( data ){
			if ($.fn.ifvmIsNotEmpty(data.offerType)) {
				inputs += '<input type="hidden" name="offerType" value="'+ data.offerType +'" />';

				// request를 보낸다.
				jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
				.appendTo('body').submit().remove();
			}
		};
};

/**
 * 회원샘플다운로드
 */
function mbrExcelSampleDownFn(){
	var data = {};
	data.offerType = "TARGET_MEMBER";
	$.fn.ifvmBatchRgstExcelSampleDown2(data);
}

/**
 * 이벤트샘플다운로드
 */
function eventExcelSampleDownFn(){
	var data = {};
	data.offerType = "TARGET_EVENT";
	$.fn.ifvmBatchRgstExcelSampleDown2(data);
}

/**
 * 직원샘플다운로드
 */
function empExcelSampleDownFn(){
	var data = {};
	data.offerType = "TARGET_EMP";
	$.fn.ifvmBatchRgstExcelSampleDown2(data);
}


/**
 * 회원샘플다운로드
 */
function mbrCIExcelSampleDownFn(){
	var data = {};
	data.offerType = "TARGET_MEMBER_CI";
	$.fn.ifvmBatchRgstExcelSampleDown2(data);
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
		            contentUrl: '<ifvm:url name="pntBatchRgstDetailPop"/>',
		            contentType: "ajax",
		            title: '<spring:message code="L02373" />',
		            width: "800px"
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
    	if(dataList[0].confirmDtNm == '미확정') {
	        if (confirm('등록한 엑셀 정보를 수동 일괄 적립하시겠습니까?')) {
			    $.ifvPostJSON('<ifvm:action name="confirmPntBatchRgstList"/>', {
			    	rid : dataList[0].rid
			    }, function(result) {
			    	alert('<spring:message code="L02375"/>');

			    	batchRegistList.searchGrid();
					upldItemList.searchGrid();

			    }, function(result) {
			    	$.errorChecker(result);
			    });
	        }
    	} else {
    		alert('<spring:message code="L02376"/>');
    	}
    } else {
    	alert('<spring:message code="L00066"/>');
    };
}

/**
 * 업로드파일 사용확정처리
 */
function fileUploadUseConfirm() {
    var dataList = batchRegistList.opt.gridControl.getSelectedRecords();
    if (dataList.length != 0) {
    	if(dataList[0].confirmDtNm == '미확정') {
	        if (confirm('등록한 엑셀 정보를 수동 일괄 사용하시겠습니까?')) {
			    $.ifvPostJSON('<ifvm:action name="useConfirmPntBatchRgstList"/>', {
			    	rid : dataList[0].rid
			    }, function(result) {
			    	alert('<spring:message code="L02375"/>');

			    	batchRegistList.searchGrid();
					upldItemList.searchGrid();

			    }, function(result) {
			    	$.errorChecker(result);
			    });
	        }
    	} else {
    		alert('<spring:message code="L02376"/>');
    	}
    } else {
    	alert('<spring:message code="L00066"/>');
    };
}

/**
 * 업로드파일 삭제
 */
function fileUploadDeleteFn() {
    var dataList = batchRegistList.opt.gridControl.getSelectedRecords();
    if (dataList.length != 0) {
    	if(dataList[0].confirmDtNm == '미확정') {
	        if (confirm('<spring:message code="C00079" />')) {
			    $.ifvPostJSON('<ifvm:action name="deletePntBatchRgstList"/>', {
			    	rid : dataList[0].rid
			    	, fileName : encodeURIComponent(dataList[0].fileName)
			    }, function(result) {
			    	alert('<spring:message code="L00085"/>');

			    	batchRegistList.searchGrid();
					upldItemList.searchGrid();

			    }, function(result) {
			    	if(result.errorType == 1) {
				    	alert('<spring:message code="L02377"/>');
			    	} else {
			    		$.errorChecker(result);
			    	}
			    });
	        }
    	} else {
			alert('<spring:message code="L02376"/>');
    	}
    } else {
    	alert('<spring:message code="L00066"/>');
    };
}

/**
 * 캠페인지급유형 참고 팝업 open
 */
function promotionSearchFn() {
	$("#promotionSearchHelpPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="promotionSearchHelpNew"/>',
        contentType: "ajax",
        title: '프로모션 캠페인 목록 조회',
        width: 1400,
        close : 'promotionSearchHelpPopupClose'
    });
}

/**
 * 캠페인지급유형 참고 팝업 close
 */
function promotionSearchHelpPopupClose() {
	promotionSearchHelpPopup._destroy();
}

/* function blackRuleTest() {
        $.ifvSyncPostJSON('<ifvm:action name="blackRuleTest"/>', {
            
        },
        function(result) {
        	batchRegistList._doAjax();
			alert('<spring:message code="이상정책 실행완료"/>');
        },function(result) {
        	if($.fn.ifvmIsNotEmpty(result.message)) {
        		alert(result.message);
        		return;
        	}
        });
} */

$(document).ready(function() {
    //공통 조회 조건 목록 설정
    batchRegistListSearchInit();
    getBatchRegistSearch();
    tabContent();

});
</script>

<div class="page-title">
    <h1>
    	<spring:message code="포인트 수동일괄등록"/> &gt; <spring:message code="L00081"/>
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-5">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-7 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="batchRegistListSearchBtn" btnFunc="batchRegistListSearchFn" objCode="pntBatchRgstListSearch_OBJ"/>
            <ifvm:inputNew type="button"   text="M00278"  id="pointStandardSearchInitBtn" btnFunc="batchRegistListSearchInit" objCode="pntBatchRgstListSearchInit_OBJ"/>
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


			<%-- <ifvm:inputNew type="button"   btnType="upload"  	text="이상거래 심사(시연용)"  id="fileUploadBtn" btnFunc="blackRuleTest" objCode="pntBatchRgstListNewUpload_OBJ"/> --%>
 			<ifvm:inputNew type="button"   btnType="upload"  	text="L02382"  id="fileUploadBtn" btnFunc="fileUploadFn" objCode="pntBatchRgstListNewUpload_OBJ"/>

 			<ifvm:inputNew type="button"   btnType="download"	text="L02353"  id="mbrExcelSampleDownBtn"  btnFunc="mbrExcelSampleDownFn" objCode="pntBatchRgstListNewDown_OBJ"/>


 			<ifvm:inputNew type="button"   btnType="save"		text="적립확정"  id="fileUploadConfirmBtn" btnFunc="fileUploadConfirmFn" nuc="true" objCode="pntBatchRgstListNewConfirm_OBJ"/>
 			 <ifvm:inputNew type="button"   btnType="save"		text="사용확정"  id="fileUploadUseConfirmBtn" btnFunc="fileUploadUseConfirm" nuc="true" objCode="pntBatchRgstListNewConfirm_OBJ"/>
 			<ifvm:inputNew type="button"   						text="M00218"  id="fileUploadDeleteBtn"  btnFunc="fileUploadDeleteFn" objCode="pntBatchRgstListNewDelete_OBJ"/>
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
<div id="promotionSearchHelpPopup" class="popup_container"></div>