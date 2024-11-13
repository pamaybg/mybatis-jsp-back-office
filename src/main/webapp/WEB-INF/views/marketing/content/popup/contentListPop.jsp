<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
$.ifvmLnbSetting('approvalAdminListNew');

var contentSearchResultList; 
var Selectedid = null;
var requestitem = [];
// var filePath;
var obj = null;



function deleteList(fromTbl, toTbl) {
	var active = 0;
	var checkedList = contentSearchResult.opt.gridControl.getSelectedRecords();
	var listFlowIdList = [];
	if(checkedList.length != 0){
		for( var i = 0; i < checkedList.length; i++ ){
				listFlowIdList.push( checkedList[i].id );
		}
		$.ifvSyncPostJSON('<ifvm:action name="removeContent"/>',{
			lisContentFlowId : listFlowIdList
		},function(result) {
			alert('<spring:message code="M00012"/>');
			contentSearchResult.searchGrid();
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
	var filePath = "/" + $("#" + rowId).parent().parent().children().eq(8).text();
	var imagePath = "/" + $("#" + rowId).parent().parent().children().eq(10).text();

	if(filePath.length > 2){
		//첨부 파일 다운
		$('#downloadLink').prop('href', filePath);
		$('#downloadLink').prop('download', $("#" + rowId).parent().parent().children().eq(9).text());
		$('#downloadLink')[0].click(); }
	if(imagePath.length > 2){
		//이미지 보기
		imagePath += $("#" + rowId).parent().parent().children().eq(11).text();
		$("#contentPopupCon").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="MKTAttachImgPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00383"/>',
	        width: 600,
	        close : 'popupClose',
	        params: {
	        	imgPath: imagePath
	        }
		});
	}
}


function contentSearchResultList(){

	var ejGridOption = {
		rowSelected : function(args){
			obj=args.data
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
	    editSettings: {
           	 allowAdding: true
           	,allowDeleting: true
        },
		dataUrl: '<ifvm:action name="getContent"/>',
		columns:[
	    	  {
	      		  field : 'contentsChannel', headerText : '<spring:message code="M00375"/>', headerTextAlign : 'center', width : '50px' ,textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : 'c1.mark_name' }/* */
	      	  },{
	      		  field : 'contentsName', headerText : '<spring:message code="M00376"/>', headerTextAlign : 'center', width : '100px' ,
	      		  customAttributes : {
	      			  index : 'mc.CONTS_NM' }/* */
	      	  },{
	      		  field : 'title', headerText : '<spring:message code="M00377"/>', headerTextAlign : 'center', width : '120px' ,
	      		  customAttributes : {
	      			  index : 'mc.CONTS_TITLE' }/* */
	      	  },{
	      		  field : 'attachment', headerText : '<spring:message code="M00378"/>', headerTextAlign : 'center', width : "30px",textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : '' }/* */
	      	  },{
	      		  field : 'modifyBy', headerText : '<spring:message code="M00379"/>', headerTextAlign : 'center', width : '60px' ,textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : 'c2.name' }/* */
	      	  },{
	      		  field : 'modifyDate', headerText : '<spring:message code="M00380"/>', headerTextAlign : 'center', width : "60px",textAlign : ej.TextAlign.Center ,
	      		  customAttributes : {
	      			  index : 'mc.modify_date' }/* */
	      	  },{
	      		  field : '', headerText : '<spring:message code="M00373"/>', visible :false ,
	      		  customAttributes : {
	      			searchable: false,
	      			  index : '' }/* */
	      	  },{
	      		  field : 'filepath', headerText : 'filepath', visible :false ,
	      		  customAttributes : {
	      			searchable: false,
	      			  index : 'c4.folder' }/* */
	      	  },{
	      		  field : 'realfileName', headerText : 'realfileName', visible :false ,
	      		  customAttributes : {
	      			searchable: false,
	      			  index : 'c4.FILE_NAME' }/* */
	      	  },{
	      		  field : 'imagepath', headerText : 'imagepath', visible :false ,
	      		  customAttributes : {
	      			  index : 'c5.image_folder' }/* */
	      	  },{
	      		  field : 'fileName', headerText : 'fileName', visible :false ,
	      		  customAttributes : {
	      			searchable: false,
	      			  index : 'c5.image_file_name' }/* */
	      	  },{
	      		  field : 'path', headerText : 'path', visible :false ,
	      		  customAttributes : {
	      			searchable: false,
	      			  index : 'c1.ATTRIB01' }/* */
	      	  },{
	      		  field : 'id', headerText : 'id', visible :false ,
	      		  customAttributes : {
	      			searchable: false,
	      			  index : 'mc.id' }/* */
	      	  }
      	],
        queryCellInfo: function(args) {
        	if(!args.data.realfileName && !args.data.imagepath) return;
			if(args.column.field == "attachment"){
				var imgFullPath = "";
				
				var rowRelalId = "attachImgBtn" + args.data.id;
				//이미지 있을 경우
				if(args.data.imagepath)
					imgFullPath = "<ifvm:image name='image_upload'/>";
				//첨부파일 있을 경우
				if(args.data.realfileName)
					imgFullPath = "<ifvm:image name='file_upload'/>";
				
				var tempHtml = '<a href="javascript:attachImgDetailPop(\'' + rowRelalId + '\');" title="downLoad" id="' + rowRelalId + '" class="fileUpload" ">';
				tempHtml += "<img src='" + imgFullPath + "' />";
				tempHtml += '</a>';
				$(args.cell).html(tempHtml);
			}
       },
      	 requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'mc.modify_date',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
//     		multiselect : true,
	};
	contentSearchResult = $("#contentSearchResult").ifvsfGrid({ ejGridOption : ejGridOption });
// 	contentSearchResult.addLocalTr();
}


/* 팝업 닫기 */
function popupClose(){
	contentPopupCon._destroy();
}



function selectTempFn(){
	if(obj!=null){
 		
		tempSearchHelpPop.close(obj);
	}else{
		alert("데이터를 선택해주세요");
	}
}


function closeTempInfoFn(){
	tempSearchHelpPop.close();
	
	
}
$(document).ready(function(){
	
	
	var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
	contentSearchResultList();
	
	//필수 영역 공통 호출
	$("#authGroupSearchBtn").on('click', function(){
    	$.fn.ifvmSubmitSearchCondition("contentRequiredList", contentSearchResultList);
	});
	$.fn.ifvmSetCommonCondList("contentRequiredList",LeftMenuId);
	
	$("#authGroupinitBtn").on('click', function(){
		$.fn.ifvmSetCommonCondList("contentRequiredList",LeftMenuId);
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
// 	$('#attachImgBtn').on('click', function(){
// 		attachImgDetailPop();
// 	});
	
// 	setTimeout(function(){FormatInitSetting(),600});
});
</script>
<a style="display:none;" id="downloadLink" href="#" download="#"></a>

<style>
.well{padding-bottom:5px;}
</style>



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

<div class="well form-horizontal" id="contentRequiredList" >

</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
		
		</div>
	</div>
	<div id="contentSearchResult" class="grid_bd0"></div>
</div>
<div class="pop_btn_area">
			<ifvm:inputNew type="button" btnType="save"  text="M00282"  id="selectTempBtn" btnFunc="selectTempFn"/>
 			<ifvm:inputNew type="button"   text="L00913"  id="closeTempBtn" btnFunc="closeTempInfoFn"/>
</div>

<div id="contentPopupCon" class="popup_container"></div>

