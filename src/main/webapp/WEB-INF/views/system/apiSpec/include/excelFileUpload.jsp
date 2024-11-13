<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/x-jsrender" id="fileLinkTemplate">
	<a href ="javascript:void(0);" name="fileClick"  onclick="fileDown('{{:fileNm}}' , '{{:filePath}}')" style="color:#1266FF; text-decoration:underline;" >{{:filePath}}</a>
</script>

<script type="text/javascript">
var apiSpecFileGrid;

function apiSpecFileList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }
	      		data.rid = rid;
	       	},
	       	rowSelected : function(args){
	       		filerid = args.data.rid;
	       	},
	       	dataUrl : '<ifvm:action name="apiSpecFileList"/>',
	        columns:[ 
	        	  {
		      		  field : 'rid', headerText : 'rid', visible : false /* rid */
		      	  },{
		      		  field : 'fileNm', headerText : '파일이름', headerTextAlign : 'center', textAlign : 'center' /* 파일이름 */
		      	  },{
		      		  field : 'filePath', headerText : '파일 경로', headerTextAlign : 'center', textAlign : 'left', template : "#fileLinkTemplate", 
		      		  customAttributes : {
		      			encColFlag : true} /* 파일 경로 */
		      	  },{
		      		  field : 'createDate', headerText : '생성일시', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : { 
		     			encColFlag : true} /* 생성일시 */
		      	  }
		      	  
	        ],
	        requestGridData : {
		      	  rows : 10,
		      	  sidx : 'createDate',
		      	  sord : 'desc',
		      	  _search : false 
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true,
	        tempId : 'ifvGridSimplePageTemplete2'
	    };
	apiSpecFileGrid = $("#apiSpecFileGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//다운로드
function fileDown(fileNm ,filePath){
     var data={};
     data.fileName = fileNm;
     data.filePath = filePath;

     location.href = '${pageContext.request.contextPath}/system/apiSpec/fileDown.do?fileName='+data.fileName + '&fileUrl='+data.filePath;
}
	


//엑셀 파일 업로드
function fileUploadPopFun(){
	
	fileUploadPop = {
		id : "apiSpecUploadPop",
		pop : function() {
			$("#" + this.id).ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : '<ifvm:url name="apiSpecUploadPop"/>',
				contentType : "ajax",
				title : 'Api 정의서 엑셀업로드',
				width : '400px'
			});
		},
		beforeClose: function(getObj) {
		
		},
		close : function(getObj) {
			if (getObj) {
				this.beforeClose(getObj);
			}
			var _popObj = eval(this.id);
			_popObj._destroy();
			apiSpecFileList();
		}
	};
	
	fileUploadPop.pop();

  }
			
function fileUploadPopClose() {
	apiSpecUploadPop._destroy();
}
//삭제
function fileRemove(){
	var list = apiSpecFileGrid.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(list)) {
		
		var filerid = list[0].rid;

		if(!confirm('<spring:message code="C00079" />')) return;
		$.ifvSyncPostJSON('<ifvm:action name="fileRemove"/>', {
		
			rid : filerid
			
		}, function(result) {
			alert('<spring:message code="M01266" />');
			apiSpecFileList()
		});
			
	} else {
		alert('<spring:message code="E00099" />');
	}
}

$(document).ready(function() {
	
	if (rid == null) {
		$("#fileUploadBtn").prop("disabled", true);
	}
	
	apiSpecFileList();
	//엑셀  파일 업로드
    $('#fileUploadBtn').on('click', function() {
    	fileUploadPopFun();
    });
    $('#fileRemoveBtn').on('click', function() {
    	fileRemove();
    });
});

</script>

<!-- <div id="uploadForm"> -->
    <div class="page_btn_area" id=''>
    	<div class="col-sm-7">
			<span>첨부 문서</span>    
    	</div>
        <div class="col-sm-5 searchbtn_r">
      			<button class="btn btn-sm" id=fileUploadBtn objCode="excelFileUploadFileUpload_OBJ">
				엑셀 업로드
           	   </button>
            	 <button class="btn btn-sm" id=fileRemoveBtn objCode="excelFileUploadFileRemove_OBJ">  
				파일 삭제
            </button>  
        </div>
    </div>
<!--     <div id="apiUploadGrid" class="white_bg grid_bd0"></div> -->
<!-- </div> -->
<div id="apiSpecFileGrid" class="white_bg grid_bd0"></div>

<div id="apiSpecUploadPop" class="popup_container"></div>