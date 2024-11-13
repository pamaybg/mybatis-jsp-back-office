<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var userMainPop;
var segmentPopupCon;
var targetLevelId;
var newSegFlag = false;

function userLevelInit(){
 	$.ifvSyncPostJSON('<ifvm:action name="getTargetLevelList"/>',
			{}, 	 
			function(result){
				$(result.rows).each(function(index, item){						
					temp = $("#userLevelTemp").tmpl(item);
					$("#userLevelArea").append(temp);
				});	   	 
			}
	);
}
function userMainPopClose() {
	userMainPop._destroy();
}
$(document).ready(function() {
	//사용자 타겟레벨 리스트 초기화
	userLevelInit();
	
	$("#userListBtn").on("click", function(){
		$("#userMainPop").ejDialog({
    		enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="segmentSearchPop"/>',
            contentType: "ajax",
            title: '<spring:message code="M01229"/>',
            width: 600,
            close : 'userMainPopClose',
            beforeOpen: function(args) {
            },
            open: function (args) {
            }
        });
		
		userMainPop = $('#userMainPop').data("ejDialog");
	});
	
});

//타겟 레벨 선택 이벤트
function clickTargetLevel(id){
	
	
	//팝업 분기
	newSegFlag = false;
	
	//선택한 타겟 레벨 id저장
	targetLevelId = id;
	
	
	$("#segmentPopupCon").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="segmentNewNamePop"/>',
        contentType: "ajax",
        title: '<spring:message code="M00666"/>',
        width: 400,
        close : 'segmentPopupClose'
    });
	
	segmentPopupCon = $("#segmentPopupCon").data("ejDialog");
	
}
function segmentPopupClose(){
	segmentPopupCon.destroy();
}


</script>



<script id="userLevelTemp" type="text/x-jquery-tmpl">
<div class="subject_label_item">
	<div class="circle_box" id="${'${'}targetLevelId}" onclick="clickTargetLevel(id)">
		<div class="circle_level">
			<span>${'${'}targetLevelNm}</span>
		</div>
	</div>
	<p class="txt_level_desc">${'${'}targetDesc}</p>
</div>
</script>


<style>
html, body{background:#fff;}
</style>

<div>
	<div class="page-title">
		<h1>
			<spring:message code="M01220"/>
		</h1>
	</div>
	<div class="user_main_area">
		<div class="main_area main1">
			<p class="user_txt user_tit"><spring:message code="M01221"/></p>
			<p class="user_txt user_desc"><spring:message code="M01222"/></p>
			<button class="user_btn_list" id="userListBtn">
				<spring:message code="M01223"/>
			</button>
		</div>
		<div class="main_area main2">
			<p class="user_txt user_tit"><spring:message code="M01224"/></p>
			<p class="user_txt user_desc"><spring:message code="M01225"/></p>
			<div class="subject_label_wrap" id="userLevelArea">
				
			</div>
		</div>
	</div>
</div>

<div id="segmentPopupCon" class="popup_container"></div>
<div id="userMainPop" class="popup_container"></div>