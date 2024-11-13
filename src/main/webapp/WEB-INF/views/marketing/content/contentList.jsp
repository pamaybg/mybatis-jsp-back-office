<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
$.ifvmLnbSetting('contentList');

var contentSearchResultList; 
var Selectedid = null;
var requestitem = [];
var filePath;


//첨부 문서 기본 형식
function attachmentFormat(cellValue, options, rowdata) {
	
	var imgFullPath = "";
	var rowRelalId = "attachImgBtn" + options.rowId;
	imgFullPath += "<ifvm:image name='image_upload'/>";

	var tempHtml = '<a href="javascript:attachImgDetailPop(' + rowRelalId + ');" title="downLoad" id="' + rowRelalId + '" class="fileUpload" ">';
	tempHtml += "<img src='" + imgFullPath + "' />";
	tempHtml += '</a>';
	
	return tempHtml; 
}

function deleteList(fromTbl, toTbl) {
	var active = 0;
	var checkedList = contentSearchResult.getCheckedList();
	var listFlowIdList = [];
	if(checkedList.length != 0){
		for( var i = 0; i < checkedList.length; i++ ){
				listFlowIdList.push( checkedList[i].id );
		}
		$.ifvSyncPostJSON('<ifvm:action name="removeContent"/>',{
			lisContentFlowId : listFlowIdList
		},function(result) {
			alert('<spring:message code="M00012"/>');
			contentSearchResult.delCheckedRow();
		});	
	}
	else{
		alert('<spring:message code="M00285"/>'); 
	}
}

//이미지 인지 파일인지 구분하여 세팅하여 주기
function FormatInitSetting() {
	var count = $("#contentSearchResult").find('tr').length -1
	var imgFullPath = "";
	for(var i =1;i<count;i++){ 
		var filecheck  =  $("#attachImgBtn" + i).parent().parent().children().eq(8).text();
		var imagecheck = $("#attachImgBtn" + i).parent().parent().children().eq(10).text();
		if(filecheck.length < 2 && imagecheck.length < 2){
			imgFullPath = '';
			$("#attachImgBtn" + i).children().attr('src','');
			//$("#attachImgBtn" + 1).text('')
		}
		else{
			//이미지 있을 경우
			if(imagecheck.length > 1){
				imgFullPath = "<ifvm:image name='image_upload'/>";
				$("#attachImgBtn" + i).children().attr('src',imgFullPath); }
			//첨부파일 있을 경우
			if(filecheck.length > 1){
				imgFullPath = "<ifvm:image name='file_upload'/>";
			    $("#attachImgBtn" + i).children().attr('src',imgFullPath); }
		}
	}
}

//첨부 클릭시 실행
function attachImgDetailPop(rowId){
	filePath = "/" + $("#" + rowId.id).parent().parent().children().eq(8).text();
	imagePath = "/" + $("#" + rowId.id).parent().parent().children().eq(10).text();
	
	if(filePath.length > 2){
		//첨부 파일 다운	
		$('#downloadLink').prop('href', filePath); 
		$('#downloadLink').prop('download', $("#" + rowId.id).parent().parent().children().eq(9).text());
		$('#downloadLink')[0].click(); }
	if(imagePath.length > 2){
		//이미지 보기
		imagePath += $("#" + rowId.id).parent().parent().children().eq(11).text();
		$("#contentPopupCon").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="MKTAttachImgPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00383"/>',
	        width: 600,
	        close : 'popupClose' });
	}
}


//조회결과 그리드
function contentSearchResultList(){
	
	var jqGridOption = {
		ondblClickRow : function(row){
			var strArray = ($("#" + row).children().eq(12).text()).split('.jsp');
			//location.href = strArray[0] + '?id='+$("#" + row).children().eq(13).text();
			qtjs.href(strArray[0] + '?id='+$("#" + row).children().eq(13).text());
		},
		serializeGridData : function( data ){
			if(requestitem != null && requestitem.length > 0){
				data.item = requestitem;
			}
			return data;
		},		
		loadComplete : function(obj){
			setTimeout(function(){FormatInitSetting(),600});
			
		},
		url: '<ifvm:action name="getContent"/>',
	    colNames:[
	              '<spring:message code="M00375"/>', 
	              '<spring:message code="M00376"/>', 
	              '<spring:message code="M00377"/>', 
	              '<spring:message code="M00378"/>',
	              '<spring:message code="M00379"/>',
	              '<spring:message code="M00380"/>',
	              '<spring:message code="M00373"/>',
	              'filepath',
	              'realfileName',
	              'imagepath',
	              'fileName',
	              'path', 
	              'id',
	              ],
	    colModel:[
				  {name:'contentsChannel', 	index:'c1.mark_name', 	resizable : false, width: 120},
				  {name:'contentsName',		index:'mc.CONTS_NM',	resizable : false},
				  {name:'title',			index:'mc.CONTS_TITLE', resizable : false},
				  {name:'',					index:'', 				resizable : false, formatter: attachmentFormat, align:'center', width:60, searchable : false, sortable : false,
					  cellattr: function() {
	                        return 'title=""';
	                  }},
				  {name:'modifyBy',		index:'c2.name', 			resizable: false, width: 120}, 
			      {name:'modifyDate',	index:'mc.modify_date', 	resizable: false, width: 120},
			      {name:'', 			index:'', 					resizable: false, hidden: true, searchable: false},
			      {name:'filepath',		index:'c4.folder', 			resizable: false, hidden: true, searchable: false},
			      {name:'realfileName',	index:'c4.FILE_NAME', 		resizable: false, hidden: true, searchable: false},
			      {name:'imagepath',	index:'c5.image_folder', 	resizable: false, hidden: true, searchable: false},
			      {name:'fileName',		index:'c5.image_file_name', resizable: false, hidden: true, searchable: false},
			      {name:'path',			index:'c1.ATTRIB01', 		resizable: false, hidden: true, searchable: false},
			      {name:'id', 			index:'mc.id', 				resizable: false, hidden: true, searchable: false},
			      ],  
	    multiselect : true,
	    sortname: 'mc.modify_date',
		sortorder: "desc",
	};
	contentSearchResult = $("#contentSearchResult").ifvGrid({ jqGridOption : jqGridOption });
	contentSearchResult.addLocalTr();
}

//공통 조회 조건 목록 설정
function searchCondInit() {
    $.fn.ifvmSetCommonCondList("commSearchList","MKTCTE001");
}

//공통 조회 호출
function contecntSerach() {
    $.fn.ifvmSubmitSearchCondition("commSearchList", contentSearchResultList);
}


/* 팝업 닫기 */
function popupClose(){
	contentPopupCon._destroy();
}

$(document).ready(function(){
	
    //공통 조회 조건 목록 설정
    searchCondInit();
    
    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit();
    });
    
	var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	contentSearchResultList();
	
	//필수 영역 공통 호출
	$("#authGroupSearchBtn").on('click', function(){
		contecntSerach();
//     	$.fn.ifvmSubmitSearchCondition("contentRequiredList", contentSearchResultList);
	});
	$.fn.ifvmSetCommonCondList("contentRequiredList",LeftMenuId);
	
	$("#authGroupinitBtn").on('click', function(){
		searchCondInit();
// 		$.fn.ifvmSetCommonCondList("contentRequiredList",LeftMenuId);
	});
	
	//신규
	$('#contentNewBtn').on('click', function(){
		$("#contentPopupCon").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="MKTContentTypePop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00381"/>',
	        width: 600,
	        close : 'popupClose' });
	});
	
	//삭제
	$('#contentDelBtn').on('click', function(){
		$.ifvSyncPostJSON('<ifvm:action name="removeContent"/>',{
			id : Selectedid
			, mktOfferCostGbn : ''
		},function(result) {
			alert('<spring:message code="M00622"/>');
		});
	});
	
	$('#delete').on('click', function(){
		deleteList()
	});
	
	//첨부
	$('#attachImgBtn').on('click', function(){
		attachImgDetailPop();
	});
	
	setTimeout(function(){FormatInitSetting(),600});
});
</script>
<a style="display:none;" id="downloadLink" href="#" download="#"></a>

<style>
.well{padding-bottom:5px;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="M00372"/> &gt;  <spring:message code="M00273"/>
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L01838"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id='authGroupSearchBtn'><i class="fa fa-search"></i>
			<spring:message code="M00273"/>
		</button> 
		<button class="btn btn-sm" id='authGroupinitBtn'>
			<spring:message code="M00278"/>
		</button> 
	</div>
</div>
     <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
<div class="well form-horizontal" id="contentRequiredList" >

</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="contentNewBtn">         
				<i class="fa fa-plus"></i>    
				<spring:message code="M00274"/>
			</button> 
			<button class="btn btn-sm" id="delete">         
				<i class="fa fa-minus"></i>    
				<spring:message code="M00275"/>
			</button> 
		</div>
	</div>
	<div id="contentSearchResult" class="grid_bd0"></div>
</div>

<div id="contentPopupCon" class="popup_container"></div>

