<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<a style="display:none;" id="downloadLink" href="#" download="#"></a>

<style>
	.well{padding-bottom:5px;}
</style>

<div class="row qt_border"></div>
<!-- 조회조건 -->
<%-- <div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838"/></span>
		</div>
		<!-- 조회버튼, 초기화버튼 -->
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id='authGroupSearchBtn' objCode="contentAuthGroupSearchBtn_OBJ"><i class="fa fa-search"></i>
				<spring:message code="M00273"/>
			</button>
			<button class="btn btn-sm" id='authGroupinitBtn' objCode="contentAuthGroupinitBtn_OBJ">
				<spring:message code="M00278"/>
			</button>
		</div>
	</div>
	
	<div class="well form-horizontal well_bt5" id="commSearchList"></div>
</div> --%>

<!-- 조회결과 -->
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277"/></span>
		</div>
		<%-- <div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="contentNewBtn" objCode="contentNewWBtn_OBJ">
				<i class="fa fa-plus"></i>
				<spring:message code="M00274"/>
			</button>
			<button class="btn btn-sm" id="contentDeleteBtn" objCode="contentDeleteBtn_OBJ">
				<i class="fa fa-minus"></i>
				<spring:message code="M00275"/>
			</button>
		</div> --%>
	</div>
	<div id="contentSearchResult" class="grid_bd0"></div>
</div>

<div id="contentPopupCon" class="popup_container"></div>

<div class="pop_btn_area">
	<!-- 선택 버튼 -->
	<button class="btn btn-sm btn_gray"  id="selectBtn" onclick="selectContent();" objCode="contentListSelect_OBJ">
		<spring:message code="선택" />
	</button> 
	<!-- 닫기 버튼 -->
	<button class="btn btn-sm btn_lightGray2" id="closeBtn" onclick="closeContentPopup();" objCode="contentListClose_OBJ">
		<spring:message code="닫기" />
	</button>
</div>




<script>

	$.ifvmLnbSetting('contentListNew');
	
	var contentSearchResultList;
	var Selectedid = null;
	var requestitem = [];
	var contsId;			 // 컨텐츠id 변수
	var	contsNo = null;      // 컨텐츠번호 벼수
	var contentsName = null; // 컨텐츠명 변수
	
	$(document).ready(function(){
	    //공통 조회 조건 목록 설정
	    searchCondInit();
	
	    //초기화
	    $("#searchCondInitBtn").on('click', function(){
	    	searchCondInit('contentSearchResult');
	    });
	
		var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');
		contentSearchResultList();
	
		//필수 영역 공통 호출
		$("#authGroupSearchBtn").on('click', function(){
			contecntSerach();
		});
		$.fn.ifvmSetCommonCondList("contentRequiredList",LeftMenuId);
	
		$("#authGroupinitBtn").on('click', function(){
			searchCondInit('contentSearchResult');
		});
	
		//신규
		$('#contentNewBtn').on('click', function(){
			$("#contentPopupCon").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="MKTContentTypePop"/>',
		        contentType: "ajax",
		        title: '<spring:message code="M00381"/>',
		        width: 1000,
		        close : 'popupClose' });
		});

		//삭제
		$('#contentDeleteBtn').on('click', function(){
			deleteList();
		});
		
	});
	
	
	function deleteList(fromTbl, toTbl) {
		var active = 0;
		var checkedList = contentSearchResult.opt.gridControl.getSelectedRecords();
	// 	var gridContsTypeData = contentSearchResult.opt.gridControl.getSelectedRecords()[0].contsTypeCd
		var listFlowIdList = [];
		if(checkedList.length != 0){
	// 	    if(gridContsTypeData != "noti"){        
					for( var i = 0; i < checkedList.length; i++ ){
							listFlowIdList.push( checkedList[i].id );
					}
					$.ifvSyncPostJSON('<ifvm:action name="removeContent"/>',{
						id : contsId,
						lisContentFlowId : listFlowIdList
					},function(result) {
						alert(result.message);
						contentSearchResult.searchGrid();
					});
	// 	    } else {
	// 	        alert('<spring:message code="M03022"/>');
	// 	    }
		}
		else{
			alert('<spring:message code="M00285"/>');
		}
	}//end deleteList
	
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
	}//end FormatInitSetting
	
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
	}//end attachImgDetailPop
	
	
	//조회결과 그리드
	function contentSearchResultList(){
		var ejGridOption = {
				/* recordDoubleClick : function(row){
				var strArray = row.data.path.split('.jsp');
				//location.href = strArray[0] + '?id='+$("#" + row).children().eq(13).text();
				qtjs.href(strArray[0] + '?id='+row.data.id);
			}, */
			serializeGridData : function( data ){
				if(requestitem != null && requestitem.length > 0){
					data.item = requestitem;
				}
				return data;
			},
			/* loadComplete : function(obj){
				setTimeout(function(){FormatInitSetting(),600});
	
			},	 */
			rowSelected: function(args) {
	 			contsId 	 = args.data.id;
	 			contsNo		 = args.data.contsNo;
	 			contentsName = args.data.contentsName;
			},
			recordDoubleClick: function(args){
				contsId 	 = args.data.id;
	 			contsNo		 = args.data.contsNo;
	 			contentsName = args.data.contentsName;
	 			
				selectContent();
			},
		    /* editSettings: {
	           	 allowAdding: true
	           	,allowDeleting: true
	        }, */
			dataUrl: '<ifvm:action name="getContent"/>',
			columns:[
	              { field : 'contsNo', headerText : '<spring:message code="M03024"/>', headerTextAlign : 'center', width : '70px', textAlign : ej.TextAlign.Center, customAttributes : { index : 'mc.CONTS_NO', searchable : true } }
	             ,{ field : 'contentsChannel', headerText : '<spring:message code="M00375"/>', headerTextAlign : 'center', width : '50px' ,textAlign : ej.TextAlign.Center , customAttributes : { index : 'c1.mark_name' , searchable : true} }
	             ,{ field : 'contentsName', headerText : '<spring:message code="M00376"/>', headerTextAlign : 'center', width : '170px' , customAttributes : { index : 'mc.CONTS_NM' , searchable : true } }
	             /* ,{ field : 'title', headerText : '<spring:message code="M00377"/>', headerTextAlign : 'center', width : '120px' , customAttributes : { index : 'mc.CONTS_TITLE' , searchable : true} }  */
		      	 ,{ field : 'attachment', headerText : '<spring:message code="M00378"/>', headerTextAlign : 'center', width : "30px",textAlign : ej.TextAlign.Center , customAttributes : { sortable : false } }
		         ,{ field : 'contsTypeCd', headerText : '<spring:message code="유형"/>', headerTextAlign : 'center', width : "30px",textAlign : ej.TextAlign.Center }
		      	 ,{ field : 'modifyBy', headerText : '<spring:message code="M00379"/>', headerTextAlign : 'center', width : '60px' ,textAlign : ej.TextAlign.Center, customAttributes : { index : 'c2.name' , searchable : true } }
		      	 ,{ field : 'modifyDate', headerText : '<spring:message code="M00380"/>', headerTextAlign : 'center', width : "60px",textAlign : ej.TextAlign.Center, customAttributes : { index : 'mc.modify_date' } }
		      	 ,{ field : '', headerText : '<spring:message code="M00373"/>', visible :false , customAttributes : { searchable: false, index : '' } }
		      	 ,{ field : 'filepath', headerText : 'filepath', visible :false , customAttributes : { searchable: false, index : 'c4.folder' } }
		      	 ,{ field : 'realfileName', headerText : 'realfileName', visible :false , customAttributes : { searchable: false, index : 'c4.FILE_NAME' } }
		      	 ,{ field : 'imagepath', headerText : 'imagepath', visible :false , customAttributes : { index : 'c5.image_folder' } }
		      	 ,{ field : 'fileName', headerText : 'fileName', visible :false , customAttributes : { searchable: false, index : 'c5.image_file_name' } }
		      	 ,{ field : 'path', headerText : 'path', visible :false , customAttributes : { searchable: false, index : 'c1.ATTRIB01' } }
		      	 ,{ field : 'id', headerText : 'id', visible :false , customAttributes : { searchable: false, index : 'mc.id' } }		      	 
	      	],
	        /* queryCellInfo: function(args) {
	        	if(!args.data.realfileName && !args.data.imagepath) 
	        		return;
	        	
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
	       }, */
	      	 requestGridData : {
		      	  //nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'mc.modify_date',
		      	  sord : 'desc',
		      	  //_search : false
		        },
		        rowList : [10,25,50,100],
		        radio: true,
	//     		multiselect : true,
				tempId: 'ifvGridSimplePageTemplete2'
		};
		
		contentSearchResult = $("#contentSearchResult").ifvsfGrid({ ejGridOption : ejGridOption });
	// 	contentSearchResult.addLocalTr();
	
	}//end contentSearchResultList
	
	
	//공통 조회 조건 목록 설정
	function searchCondInit(gridId) {
	    $.fn.ifvmSetCommonCondList("commSearchList","MKTCTE001",gridId);
	}
	//공통 조회 호출
	function contecntSerach() {
	    $.fn.ifvmSubmitSearchCondition("commSearchList", contentSearchResultList);
	}

	
	// 팝업창 닫기
	function closeContentPopup() {
		commonPopContainer._destroy();
	}
	
	// 컨텐츠 항목 선택 후 이전 창의 필드에 내용 담기 : '컨텐츠명','컨텐츠번호'
	function selectContent() {
		// 이전 필드에 초기화 : contsId contsNo contentsName
		$('#markNm').val(contentsName); // 마크네임에 '컨텐츠명'
		$('#dataVal').val(contsNo);		// 값필드에 '컨텐츠번호'
		
		commonPopContainer._destroy();
	}

</script>
