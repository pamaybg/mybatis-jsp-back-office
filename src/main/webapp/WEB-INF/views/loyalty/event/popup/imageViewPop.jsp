<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>
var path =  '<%= cleanXss(request.getParameter("path")) %>';

if(path == "null") path = null;

function ImgViewPopInit() {

	var html = "URL이 올바르지 않습니다.";
	
	if (path != null) {		
		
		var fileType = path.substr(path.lastIndexOf('.')).toLowerCase();
		
		// youtube
		if (path.indexOf("youtube") > 0) {
			html = '<iframe width="100%" src="' + path + '" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>';
		} 
		
		// 동영상
		else if(fileType != ".jpg" && fileType != ".png" &&  fileType != ".gif" &&  fileType != ".bmp" && fileType != ".jpeg") {
			html = '<video width="100%" class="share-glo-image" style="background-image: path();" src="' + path + '" autoplay="autoplay" controls="controls" />'; 
		}
		
		// 이미지
		else {
			html = '<img width="100%" id="imgView" src="' + path + '" controls="controls"/>';
		}
	} else {
		eventImageViewPopupClose();
		alert("URL이 올바르지 않습니다.");
	}
	 
	 $("#imgViewPopArea").html(html);
}

//이미지 다운로드
function btnSaveClick(){

    var downFileNm = path.substr(path.lastIndexOf('/')).toLowerCase().split('/')[1];
    
    var data = { fileUrl : encodeURI(encodeURI(path)), fileName : encodeURI(encodeURI(downFileNm)) };
    location.href = '${pageContext.request.contextPath}/loyalty/event/imageViewDown?fileName=' + data.fileName + '&fileUrl=' + data.fileUrl;    
    //qtjs.href('<ifvm:url name="imageViewDown"/>' + '?fileName=' + data.fileName + '&fileUrl=' + data.fileUrl+ '&email=' + email+ '&date=' + date);
}

//팝업 닫기
function btnCloseClick(){
	imgViewPopupClose();
};
	
$(document).ready(function(){
	ImgViewPopInit();
});

</script>

<div id='imageViewPop'>
	<div class="pop_inner_wrap form-horizontal" id="imgViewPopArea"  style='background-color:black'>
	</div>
	<div class="pop_btn_area"><!-- 하단 -->
	    <ifvm:inputNew type="button" id="btnSave" btnFunc="btnSaveClick" btnType="save" text="L02536" /><!-- 다운로드 -->
		<ifvm:inputNew type="button" id="btnClose" btnFunc="btnCloseClick" btnType="" text="L00913" /><!-- 닫기 -->
	</div>
</div>