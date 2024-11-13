<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="fileLinkTemplate">
	<a href ="javascript:void(0);" name="fileClick"  onclick="fileLoaction('{{:confirmDtNm}}', '{{:fileUploadUserRid}}', encodeURIComponent('{{:fileName}}') ,encodeURIComponent('{{:filePath}}'),'{{:rid}}');" style="color:#1266FF; text-decoration:underline;" >{{:fileName}}</a>
</script>

<script type="text/javascript">
var mbrDivList;
var rid ;
var testTab;
var promotionSearchHelpPopup = null;

function getMbrDivSearch(){
    var ejGridOption = {
    	recordDoubleClick : function(args){
        	rid = data.rid;

	      /* var obj = mbrDivList.getRowData()[data-1];
	      rid = obj.rid;
	      pointStandardDtlFn();   // 상세 보기 이벤트 */
        },
        rowSelected : function (args) {
        	rid = args.data.rid;
        	batchResultCd="";
        	var obj={};
        	obj.ridPntUpload = rid
        	obj.batchResultCd = "";
        	upldItemList.searchGrid(obj);

        	//확정여부에 따른 확정,삭제버튼 활성/비활성
        	if(data.confirmDtNm === '확정') {
        		$('#fileUploadDeleteBtn').attr('disabled', true);
        		$('#fileUploadConfirmBtn').attr('disabled', true);
        	} else {
        		$('#fileUploadDeleteBtn').attr('disabled', false);

        		//업로드결과 '성공'인 경우에만 확정버튼 활성화
        		if(data.batchResultCd === 'S') {
	        		$('#fileUploadConfirmBtn').attr('disabled', false);
        		}
        	}
        	/* uploadRslt="";
        	var obj={};
        	obj.parRid = data.rid
        	obj.uploadRslt = "";
        	upldItemList.requestData(obj);
        	$(window).resize(); */
        },
//         ondblClickRow : function(data){
//             var obj = mbrDivList.getRowData()[data-1];
//             rid = obj.rid
//             batchRgstDtl();   // 상세 보기 이벤트
//         },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
//         loadComplete : function(obj){
//         },
        dataUrl : '<ifvm:action name="getMbrDivList"/>',
        columns:[
        /* 	{
	      		  field : 'uploadTypeCdNm', headerText : '<spring:message code="L02356"/>', headerTextAlign : 'center', textAlign: 'center', width : '60px',
	      		  customAttributes : {
	      			  index : 'c1.mark_name' }/*업로드유형 */
	      	//},
        	/* {
	      		  field : 'procTypeCdNm', headerText : '<spring:message code="L02357"/>', headerTextAlign : 'center', textAlign: 'center', width : '60px',
	      		  customAttributes : {
	      			  index : 'c2.mark_name' }/*대상 */
	      	//},
        	{
	      		  field : 'fileUploadDt', headerText : '<spring:message code="L02358"/>', headerTextAlign : 'center', width : '80px',
	      		  customAttributes : {
	      			  index : 'lmu.file_upload_dt' }/*업로드일자 */
	      	},
        	{
	      		  field : 'fileUploadUserRidNm', headerText : '<spring:message code="M00184"/>', headerTextAlign : 'center', width : '60px',
	      		  customAttributes : {
	      			  index : 'emp1.name' }/*등록자 */
	      	},
        	{
	      		  field : 'fileName', headerText : '<spring:message code="L02359"/>', headerTextAlign : 'center', width : '170px', template : "#fileLinkTemplate",
	      		  customAttributes : {
	      			  index : 'lmu.file_name' }/*파일명 */
	      	},
        	{
	      		  field : 'uploadCnt', headerText : '<spring:message code="L02360"/>', headerTextAlign : 'center', textAlign: 'right', width : '60px', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'lmu.upload_cnt' }/*대상건수 */
	      	},

        	{
	      		  field : 'batchResultCdNm', headerText : '<spring:message code="L02363"/>', headerTextAlign : 'center', textAlign: 'center', width : '60px',
	      		  customAttributes : {
	      			  index : 'c3.mark_name' }/*업로드처리결과*/
	      	},

        	{
	      		  field : 'batchErrorDesc', headerText : '<spring:message code="L02365"/>', headerTextAlign : 'center', width : '170px',
	      		  customAttributes : {
	      			  index : 'lmu.batch_error_desc' }/*오류내역*/
	      	},
        	{
	      		  field : 'rid', headerText : 'rid', visible: false,
	      		  customAttributes : {
	      			  index : 'lmu.RID' }/**/
	      	},
        	{
	      		  field : 'uploadTypeCd', headerText : 'uploadTypeCd', visible: false,
	      		  customAttributes : {
	      			  index : 'c1.code_name' }/**/
	      	},
        	{
	      		  field : 'procTypeCd', headerText : 'procTypeCd', visible: false,
	      		  customAttributes : {
	      			  index : 'c2.code_name' }/**/
	      	},
        	{
	      		  field : 'batchResultCd', headerText : 'batchResultCd', visible: false,
	      		  customAttributes : {
	      			  index : 'c3.code_name' }/**/
	      	},
        	{
	      		  field : 'fileUploadUserRid', headerText : 'fileUploadUserRid', visible: false,
	      		  customAttributes : {
	      			  index : 'lmu.file_upload_user_rid' }/**/
	      	},
        	{
	      		  field : 'confirmUserRid', headerText : 'confirmUserRid', visible: false,
	      		  customAttributes : {
	      			  index : 'lmu.confirm_user_rid' }/**/
	      	},
        	{
	      		  field : 'filePath', headerText : 'filePath', visible: false,
	      		  customAttributes : {
	      			  index : 'lmu.file_path' }/**/
	      	},
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lmu.file_upload_dt',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true
    };
    mbrDivList = $("#mbrDivListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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

	//업로드한 사용자만 다운로드 가능.
	if(ifvmUserInfo.id != fileUploadUserRid) {
		alert('등록자만 다운로드 가능합니다.');
		return false;
	}

	 escape(encodeURIComponent(filePath));
     var data={};
     data.fileName = fileNm;
     data.filePath = filePath;
     data.fileRid = fileRid;
     data.fileType = 'loyBatchRgst';
 //    $.fn.ifvmFileDownload (data);
    $.fn.ifvmBatchRgstExcelDownload2(data);
}

//데이터 조회조건 날자 빈값 처리
function InitializeDate(){
	$(".datepicker").val("");
}


//공통 조회 조건 목록 설정
function mbrDivListSearchInit() {
   $.fn.ifvmSetCommonCondList("mbrDivSearch","PLOY_601");
   InitializeDate();
}

//공통 조회 호출
function mbrDivListSearchFn() {mbrDivList
    $.fn.ifvmSubmitSearchCondition("mbrDivSearch", function(){
    	mbrDivList.searchGrid({item: requestitem});
    });
}


function tabContent(){
	testTab = $('#tabContent').DrawTab({
		item: [
			{label:'<spring:message code="L01645"/>' , href: '<ifvm:url name="mbrDivUpldItemListNew"/>' +"?rid="+rid},
		]
	});
}

//업로드한 파일 다운로드
$.fn.ifvmBatchRgstExcelDownload2 = function(data) {
	var inputs = "";
	var url = "/loyalty/batchRgst/gridExcelDown2.do";
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
	var url = "/loyalty/member/mbr/mbrDivUploadexcelSampleDown.do";
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
	data.offerType = "HHP_NO";
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
		            contentUrl: '<ifvm:url name="mbrUploadDetailPop"/>',
		            contentType: "ajax",
		            title: '<spring:message code="L02373" />',
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
 * 업로드파일 삭제
 */
function fileUploadDeleteFn() {
    var dataList = mbrDivList.opt.gridControl.getSelectedRecords();
    if (dataList.length != 0) {
    	if(dataList[0].confirmDtNm == '미확정') {
	        if (confirm('<spring:message code="C00079" />')) {
			    $.ifvPostJSON('<ifvm:action name="deletePntBatchRgstList"/>', {
			    	rid : dataList[0].rid
			    	, fileName : encodeURIComponent(dataList[0].fileName)
			    }, function(result) {
			    	alert('<spring:message code="L00085"/>');

			    	mbrDivList.searchGrid();
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
        width: 1200,
        close : 'promotionSearchHelpPopupClose'
    });
}

/**
 * 캠페인지급유형 참고 팝업 close
 */
function promotionSearchHelpPopupClose() {
	promotionSearchHelpPopup._destroy();
}

$(document).ready(function() {
    //공통 조회 조건 목록 설정
    mbrDivListSearchInit();
     //mbrDivListSearchFn();
    getMbrDivSearch();
    tabContent();

});
</script>

<div class="page-title">
    <h1>
        멤버십 회원 구분 &gt;<spring:message code="L00081"/>
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-5">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-7 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="mbrDivListSearchBtn" btnFunc="mbrDivListSearchFn"/>
            <ifvm:inputNew type="button"   text="M00278"  id="pointStandardSearchInitBtn" btnFunc="mbrDivListSearchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="mbrDivSearch" >
    </div>
</div>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-5">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-7 searchbtn_r">

 			<ifvm:inputNew type="button"   btnType="upload"  	text="L02382"  id="fileUploadBtn" btnFunc="fileUploadFn"/>

 			<ifvm:inputNew type="button"   btnType="download"	text="L02353"  id="mbrExcelSampleDownBtn"  btnFunc="mbrExcelSampleDownFn"/>

 			<ifvm:inputNew type="button"   						text="M00218"  id="fileUploadDeleteBtn"  btnFunc="fileUploadDeleteFn"/>
        </div>
    </div>
    <div id="mbrDivListGrid" class="white_bg grid_bd0"></div>
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