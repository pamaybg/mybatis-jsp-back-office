<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var unRgstCardUploadList;
var rid ;
var testTab;
function getunRgstCardSearch(){
    var jqGridOption = {
        onSelectRow : function (data) {
        	rid=data.rid;
        	uploadRslt="";
        	var obj={};
        	obj.parRid = data.rid
        	obj.uploadRslt = "";
        	unRgstCardUpldItemList.requestData(obj);
        	$(window).resize();
        	var fileNm = data.fileNm;
     //   	qtjs.href(data.filePath);
        	 //upldItemSearch();
        },
        ondblClickRow : function(data){
            var obj = unRgstCardUploadList.getRowData()[data-1];
            rid = obj.rid
            unRgstCardUploadDtlFn();   // 상세 보기 이벤트
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getUnRgstCardUploadList"/>',
        colNames:[
                   '<spring:message code="L01624" />',  /*업로드일시 */
                   '<spring:message code="L01626" />',  /*파일명*/
                   '<spring:message code="L01627" />',  /*업로드성공건수 */
                   '<spring:message code="L01628" />',  /*업로드실패건수 */
                   '<spring:message code="L01629" />',  /*업로드 처리자*/
                   '<spring:message code="L01630" />',  /*처리상태*/
                   '<spring:message code="L01636" />',  /*승인자명*/
                   '<spring:message code="L01637" />',  /*승인처리일시*/
                   '<spring:message code="L01638" />',  /*성공건수*/
                   '<spring:message code="L01639" />',  /*실패건수*/

                   'rid',
                   'filePath'
                 ],
        colModel:[
             { name:'fileUpldDt',   	index:'a.FILE_UPLD_DT',  		resizable : true, align:'center',   width:'150px' , formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
             { name:'fileNm',   		index:'a.FILE_NM',  			resizable : true, align:'left',     width:'350px' ,formatter: excelDownLink   },
             { name:'fileUpldSucesCnt', index:'a.FILE_UPLD_SUCES_CNT',resizable : true, align:'right',  	width:'90px' ,formatter :'integer'},
             { name:'fileUpldFailCnt',  index:'a.FILE_UPLD_FAIL_CNT', resizable : true, align:'right',    width:'90px',formatter :'integer' },
             { name:'custNm',   		index:'e1.NAME',  				resizable : true, align:'center',   width:'80px' },
             { name:'pointTrtStauts',   index:'cc1.MARK_NAME',  		resizable : true, align:'center',   width:'80px' },
             { name:'ridApv',   		index:'e2.NAME',  				resizable : true, align:'center',   width:'80px' },
             { name:'apvTrtDt',   		index:'a.APV_TRT_DT',  		resizable : true, align:'center',   width:'140px', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"} },
             { name:'pointSucesCnt',   	index:'a.PRE_SAVE_SUCES_CNT',  	resizable : true, align:'right',    width:'90px',formatter :'integer' },
             { name:'pointFailCnt',   	index:'a.PRE_SAVE_FAIL_CNT',  	resizable : true, align:'right',    width:'90px' ,formatter :'integer'},

             { name:'rid',    			index:'a.RID',    		hidden : true},
             { name:'filePath',    		index:'a.FILE_PATH',    	hidden : true},
        ],
        sortname: 'a.FILE_UPLD_DT',
		sortorder: "desc",
    };
    unRgstCardUploadList = $("#unRgstCardUploadListGrid").ifvGrid({ jqGridOption : jqGridOption });
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

    // var tag = '<a href ="javascript:void(0);" name="fileClick"  onclick = "fileLoaction(\''+fileNm +'\' ,\''+ filePath +'\');" style="color:#1266FF; text-decoration:underline;" >' + fileNm + '</a>';
     var tag = '<a href ="javascript:void(0);" name="fileClick"  onclick = "fileLoaction(\''+encodeURI(encodeURIComponent(fileNm)) +'\' ,\''+ encodeURI(encodeURIComponent(filePath)) +'\'  ,\''+fileRid+'\'   );" style="color:#1266FF; text-decoration:underline;" >' + fileNm + '</a>';

    //  var tag = '<a href =javascript:fileLoaction('+filePath+')    style="color:#1266FF; text-decoration:underline;" >' + fileNm + '</a>';
   //  var tag = '<a href ="javascript:void(0)" name="fileClick"  onclick = "alert()"; return false;"   style="color:#1266FF; text-decoration:underline;" >' + fileNm + '</a>';
//     var tag = '<a href ="#" name="fileClick"  onclick = "location.herf='+D:\quintet-eclipse-mars2\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp2\wtpwebapps\iCignal-Marketing-2.0-E1-TEST\resources\UploadFile\membership\해당업무\a2545f48df0a11e7b2bd002248056f2a.xls+'" style="color:#1266FF; text-decoration:underline;" >' + fileNm + '</a>';

	var div = '<div id= "excelDown">'+fileNm+'</div>'
return tag;
}

function fileLoaction(fileNm ,filePath ,fileRid){
	 escape(encodeURIComponent(filePath));
     var data={};
     data.fileName = fileNm;
     data.filePath = filePath;
     data.fileRid = fileRid;
 //    $.fn.ifvmFileDownload (data);
    $.fn.ifvmBatchRgstExcelDownload(data);
}

//데이터 조회조건 날자 빈값 처리
function InitializeDate(){
	$(".datepicker").val("");
}


//공통 조회 조건 목록 설정
function unRgstCardUploadListSearchInit() {
   $.fn.ifvmSetCommonCondList("unRgstCardSearch","PGM_L_054");
   InitializeDate();
}

//공통 조회 호출
function unRgstCardUploadListSearchFn() {
    $.fn.ifvmSubmitSearchCondition("unRgstCardSearch", getunRgstCardSearch);
}

function unRgstCardUploadDtlFn(){
 	var url = '<ifvm:url name="unRgstCardUploadDetail"/>';
 	if(rid !=null){
 		url = url + '?rid=' + rid;
 	}
 	qtjs.href(url);
}

function tabContent(){
	testTab = $('#tabContent').DrawTab({
		item: [
			{label:'<spring:message code="L01645"/>' , href: '<ifvm:url name="unRgstCardUpldItemList"/>' +"?rid="+rid},
		]
	});
}

function excelSampleDownFn(){
	 $.ifvSyncPostJSON('<ifvm:action name="excelSampleDown"/>' ,
			 { offerType : "CARD" },
			 function(result){
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
		            contentUrl: '<ifvm:url name="unRgstExcelFileUploadPop"/>',
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
    unRgstCardUploadListSearchInit();
    unRgstCardUploadListSearchFn();
    tabContent();

});
</script>

<div class="page-title">
    <h1>
        <spring:message code="L02064" />
        &gt;<spring:message code="L00081"/>
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="unRgstCardUploadListSearchBtn" btnFunc="unRgstCardUploadListSearchFn" objCode="unRgstCardUploadListSearchBtn_OBJ"/>
            <ifvm:inputNew type="button"   text="M00278"  id="pointStandardSearchInitBtn" btnFunc="unRgstCardUploadListSearchInit" objCode="unUploadpointStandardSearchInitBtn_OBJ"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="unRgstCardSearch" >
    </div>
</div>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button"   btnType="upload"  text="L01642"  id="fileUploadBtn" btnFunc="fileUploadFn" objCode="unUploadfileUploadBtn_OBJ"/>

 			<ifvm:inputNew type="button"   btnType="download"	text="L02063"  id="excelSampleDownBtn" btnFunc="excelSampleDownFn" objCode="unUploadexcelSampleDownBtn_OBJ"/>
        </div>
    </div>
    <div id="unRgstCardUploadListGrid" class="white_bg grid_bd0"></div>
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
