<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/x-jsrender" id="fileLinkTemplate">
	<a href ="javascript:void(0);" name="fileClick"  onclick="fileLoaction('{{:fileNm}}' ,'{{:filePath}}','{{:rid}}');" style="color:#1266FF; text-decoration:underline;" >{{:fileNm}}</a>
</script>
<script type="text/javascript">
var batchRegistList;
var rid ;
var testTab;
function getBatchRegistSearch(){
    var ejGridOption = {
        rowSelected : function (args) {
        	rid=args.data.rid;
        	uploadRslt="";
        	var obj={};
        	obj.parRid = args.data.rid
        	obj.uploadRslt = "";
        	upldItemList.searchGrid(obj);
        	$(window).resize();
        	var fileNm = args.data.fileNm;
        },
        recordDoubleClick : function(args){
            var obj = args.data ; 
            rid = obj.rid
            batchRgstDtl();   // 상세 보기 이벤트
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        dataUrl : '<ifvm:action name="getBatchRgstList"/>',
        columns:[
        	{
	      		  field : 'fileUpldDt', headerText : '<spring:message code="L01624"/>', headerTextAlign : 'center', width : '140px' /*업로드일시 */
	      	  },
	      	  {
	      		  field : 'fileNm', headerText : '<spring:message code="L01626"/>', headerTextAlign : 'center', template : "#fileLinkTemplate" ,width : '170px' /*파일명 */
	      	  },{
	      		  field : 'fileUpldSucesCnt', headerText : '<spring:message code="L01627"/>', headerTextAlign : 'center' /*업로드성공 */
	      	  },{
	      		  field : 'fileUpldFailCnt', headerText : '<spring:message code="L01628"/>', headerTextAlign : 'center' /*업로드실패 */
	      	  },{
	      		  field : 'custNm', headerText : '<spring:message code="L01629"/>', headerTextAlign : 'center' /*업로드 처리자 */
	      	  },{
	      		  field : 'pointTrtStauts', headerText : '<spring:message code="L01630"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'pointTrtStautsCd' }/*처리상태 */
	      	  },
	      	  {
	      		  field : 'acuRdn', headerText : '<spring:message code="L01633"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'acuRdnCd' }/*적립/차감사유 */
	      	  },{
	      		  field : 'ridActcSbst', headerText : '<spring:message code="L01634"/>', headerTextAlign : 'center' /*검수자명 */
	      	  },{
	      		  field : 'actcTrtDt', headerText : '<spring:message code="L01635"/>', headerTextAlign : 'center' /*검수처리일시 */
	      	  },{
	      		  field : 'ridApv', headerText : '<spring:message code="L01636"/>', headerTextAlign : 'center' /*승인자명 */
	      	  },{
	      		  field : 'apvTrtDt', headerText : '<spring:message code="L01637"/>', headerTextAlign : 'center' /*승인처리일시 */
	      	  },{
	      		  field : 'pointSucesCnt', headerText : '<spring:message code="L01638"/>', headerTextAlign : 'center' /*성공건수 */
	      	  },{
	      		  field : 'pointFailCnt', headerText : '<spring:message code="L01639"/>', headerTextAlign : 'center' /*실패건수 */
	      	  },{
	      		  field : 'ridPointEmp', headerText : '<spring:message code="L01640"/>', headerTextAlign : 'center' /*스탬프처리자 */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible: false /*rid */
	      	  },{
	      		  field : 'filePath', headerText : 'filePath' ,visible: false /*filePath */
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

function excelDownLink(cellvalue, options, rowObjec){
	//filepath를 받아와서 엑셀 파일읽고 쓰기
	//파일명을 구한후 service단에서 excelwrite를통해 파일명 재지정후 파일 다운로드
     var fileNm = rowObjec.fileNm;
     var filePath = rowObjec.filePath;
     var fileRid = rowObjec.rid;
     var data={};
     data.fileName = fileNm;
     data.filePath = filePath;
     var tag = '<a href ="javascript:void(0);" name="fileClick"  onclick = "fileLoaction(\''+encodeURI(encodeURIComponent(fileNm)) +'\' ,\''+ encodeURI(encodeURIComponent(filePath)) +'\'  ,\''+fileRid+'\'   );" style="color:#1266FF; text-decoration:underline;" >' + fileNm + '</a>';

	var div = '<div id= "excelDown">'+fileNm+'</div>'
return tag;
}

function fileLoaction(fileNm ,filePath ,fileRid){
	 var fp = encodeURI(encodeURIComponent(filePath));
	 escape(encodeURIComponent(fp));
     var data={};
     data.fileName = encodeURI(encodeURIComponent(fileNm));
     data.filePath = fp;
     data.fileRid = fileRid;
    $.fn.ifvmBatchRgstExcelDownload(data);
}

//데이터 조회조건 날자 빈값 처리
function InitializeDate(){
	$(".datepicker").val("");
}


//공통 조회 조건 목록 설정
function batchRegistListSearchInit() {
   $.fn.ifvmSetCommonCondList("batchRegistSearch","PGM_L_054");
   InitializeDate();
}

//공통 조회 호출
function batchRegistListSearchFn() {
    $.fn.ifvmSubmitSearchCondition("batchRegistSearch", getBatchRegistSearch);
}

function batchRgstDtl(){
 	var url = '<ifvm:url name="batchRgstDetail"/>';
 	if(rid !=null){
 		url = url + '?rid=' + rid;
 	}
 	qtjs.href(url);
}

function tabContent(){
	testTab = $('#tabContent').DrawTab({
		item: [
			{label:'<spring:message code="L01645"/>' , href: '<ifvm:url name="upldItemListNew"/>' +"?rid="+rid},
		]
	});
}

function pntExcelSampleDownFn(){
	 $.ifvSyncPostJSON('<ifvm:action name="excelSampleDown"/>' ,
			 { offerType : "PNT" },
			 function(result){
				 qtjs.href(result.message);
		     },function(result){
	 			alert('<spring:message code="L02032"/>');
 			 });
}

function stampExcelSampleDownFn(){
	  $.ifvSyncPostJSON('<ifvm:action name="excelSampleDown"/>' ,
				 { offerType : "STMP" },
				 function(result){
			 		 var url ="/resources/file/sample/";
					 var fileNm = encodeURI('<spring:message code="L02033"/>');
					 var file=".xls";
					 url = url+ fileNm + file;
					 qtjs.href(result.message);
			     },function(result){
		 			alert('<spring:message code="L02032"/>');
	 			 });
}

function fileUploadFn(){
	fileUploadPop ={
		        id : "excelFileUploadPop"
		    };
	fileUploadPop.popup = function (){
			 fileUploadPop.pop = $('#'+fileUploadPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="excelFileUploadPop"/>',
		            contentType: "ajax",
		            title: '<spring:message code="L01690" />',
		            width: "500px"
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

$(document).ready(function() {
    //공통 조회 조건 목록 설정
    batchRegistListSearchInit();
    batchRegistListSearchFn();
    tabContent();

});
</script>

<div class="page-title">
    <h1>
        <spring:message code="L01641" />
        &gt;<spring:message code="L00081"/>
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="batchRegistListSearchBtn" btnFunc="batchRegistListSearchFn"/>
            <ifvm:inputNew type="button"   text="M00278"  id="pointStandardSearchInitBtn" btnFunc="batchRegistListSearchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="batchRegistSearch" >
    </div>
</div>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button"   btnType="upload"  text="L01642"  id="fileUploadBtn" btnFunc="fileUploadFn"/>

 			<ifvm:inputNew type="button"   btnType="download"	text="L01643"  id="pntExcelSampleDownBtn" btnFunc="pntExcelSampleDownFn"/>
 			<ifvm:inputNew type="button"   btnType="download"	text="L01644"  id="stampExcelSampleDownBtn" btnFunc="stampExcelSampleDownFn"/>
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
