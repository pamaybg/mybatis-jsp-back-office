<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
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
var htmlStore; //html 형식 저장소
var memName = [];
var functionCheck = 0;
var titleVal;
var htmlVal;
var conid = '<%= cleanXss(request.getParameter("id")) %>';

//iCIGNAL 이미지 세팅
var backImagePop;

//iCIGNAL 이미지 세팅
function backImagePopSetting(){
	var _this = this;
	var tmpArr = new Array();
	for( var i = 0; i<15; i++ ){
		tmpArr.push({ index : i });
	}
	var template = $('#logoImageTemplatePop2').tmpl(tmpArr);
	$("#backImagePop").append(template);
	
	backImagePop = new ifvMultiUpLoader({
		container : $("#backImagePop"),
		uploadBtn : $('#logoUploadPop2'),
		tempUpLoadFormId : 'logoUploadFormPop2',
		tempUploadBtnId : 'logoUploadPop2',
		imgId : 'logoImgPop2',
		btnConId : 'logoPostPopPicBtns2',
		imgContainerId : 'logoImgContainerPop2',
		rotationBtnId : 'logoImgRotation2',
		deleteBtnId : 'logoImgDelPop2',
		progressId : 'progress2',
		/* tempImgUrl : '${pageContext.request.contextPath}/resources/images/beacon/store/ico_bg_camera.gif', */
		tempUploadIE : '<ifvm:action name="tempUploadIE"/>',
		'maxNumber' : 15,
		'tempImgWidth' : 96, 
		'tempImgHeight' : 96,
		width:96,
		errFunc : function(type){
			var str = null;
			if( type == "maxNumber" ){
				str = '<spring:message code="M02143"/>';
			}else{
				str = '<spring:message code="M02144"/>';
			}
			new ifvConfirm({
				btnTxt1 : '확인',
				btnTxt2 : false,
				isSuccess : false,
				text : str
			});
		}
	}); 
};

//상세페이지 체크
function getFacebookData(){
	
	if(conid != "null") 
	{
		$.ifvSyncPostJSON('<ifvm:action name="selectFacebookDtlList"/>', {
			   id : conid
		},function(result) {
			
			$("#contentsNamePop").val(result.contentsName);
			$('#htmlContentsAreaPop').val(result.contents);
			if(result.imageUrl != ''){
				backImagePop.setImgArrList(result.images);
			}	
		});
	}
}
//
function getPersonalFeed(){
	FB.api("/258516327949553_260431931091326",{
		"access_token" : acesToken
	}
	,function (response){
		
		/* for(var i=0; i<response.data.length; i++){
			//obectId(postId)
			if(response.data[i].id == '258516327949553_260431931091326'){
				alert(response.data[i].message);
			}
		} */
		
	});
}

/* function getFacebook(){
	https://graph.facebook.com/앱ID/posts?access_token=토큰&callback=?";
	$.getJSON(url,function(json){
	    var html = "<ul>";
	 	//페이스북 json구조 하나의 object -> data,data,data....
		$.each(json.data,function(i,fb){
		    if(fb.story != undefined)
		    {
		    	html += "<li>" + fb.story + "</li>";
		    }
			if(fb.message != undefined)
			{
				html += "<li>" + fb.message + "</li>";
			}
			if(fb.description != undefined)
			{
			    html += "<li>" + fb.description + "</li>";
			}
			if(fb.picture != undefined && fb.link != undefined)
			{
				html += "<a href='" + fb.link + "'><img src='" + fb.picture + "'/></a>";
			}
		});
		html += "</ul>";
		$('.facebookfeed').html(html);
	});
}; */

$(document).ready(function(){
	backImagePopSetting();
	
	getFacebookData();
	
	getPersonalFeed();
});
</script>

<script id="logoImageTemplatePop2" type="text/x-jquery-tmpl">
<div id='logoImgContainerPop2${'${'}index}' class="image_box" seq='${'${'}index}' isBind='false' RotateAngle='0' >
	<form id='logoUploadFormPop2${'${'}index}' method="POST" enctype="multipart/form-data" style="float: left;">
	</form>
	<img id='logoImgPop2${'${'}index}' width="96px" height="96px" class="handle" />
</div>
</script>

<%-- <div class="content_pop_wrap">
	<div class="pop_inner_wrap form-horizontal">
		<div class="row qt_border">
			<ifvm:input type="text" required="true" id="contentsNamePop" maxLength="30" disabled="disabled"/>	
		</div>
		<div class="row qt_border">
			<textarea id="htmlContentsAreaPop" rows="8"></textarea>				
		</div>
		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="M02146"/></label>
			<div class="col-sm-10" style="font-size:0; line-height:0;">
				<div class="picture_area" id="backImagePop">
				</div>
			</div> 
		</div>
	</div>
</div> --%>

<div>
	<div class="well form-horizontal content_textImage_con">
		<div class="phoneImage">
			<div class="sms_kinds"><spring:message code="M02141"/></div>
			<div class="phoneWrap">
				<ifvm:input type="text" id="contentsNamePop" placeholder="M00394" maxLength="50"/>
				<div id="sortable">
					<div class="textareaBox">
						<ifvm:input type="textarea" className="sms_phone_area" id="htmlContentsAreaPop"/>
					</div>
					<div class="imageBox">
						<div class="picture_area" id="backImagePop">
						</div>
					</div>
				</div>					
			</div>
		</div>
	</div>
</div>