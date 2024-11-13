<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
#indexFormArea {width: 100%;}
#indexAreaContent {width: 100%;}
#indexAreaContent:after {content: ""; clear: both; display: block;}
</style>

<script type="text/javascript">
var idxNm = null;
var tblSpaceNm = null;
var unqYn = null;

var indexListURL = '<ifvm:url name="indexList"/>';		//서브젝트 에어리어
var indexColListURL = '<ifvm:url name="indexColList"/>';		//필드 

function appendPage(type) {
	var url = '';
	
	switch( type ){
		case 'indexList' :
			url = this.indexListURL;
			break;
		case 'indexColList' :
			url = this.indexColListURL;
			break;
		default :
	break;
	};
	
	var fileName = url.split('/').pop();
	$.ifvCachedHtml( url ).done( function(script, textStatus){
		if(type == 'indexList' ) $("#indexList").append( script );  
		else if(type == 'indexColList' ) $("#indexColList").append( script );
		if( window[fileName + '_init'] != null ) window[fileName + '_init']();
	});
}

// 고급설정 팝업 열기
function idxAdvancePopOpen() {
    $("#dialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="idxAdvancePop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01586" />',
        width: 500,
        close : 'tableMstPopClose'
    });
}

// 인덱스생성 팝업 열기
function idxCreatPopOpen() {
    $("#dialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="idxCreatPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01592" />',
        width: 500,
        close : 'tableMstPopClose'
    });
}

$(document).ready(function() {
	dbTypeCheck(); // 오라클인경우 고급설정 활성화
	
	$("#indexList").empty();
	$("#indexColList").empty();
	$("#indexList").html('');
	$("#indexColList").html('');

	appendPage('indexList'); 
	appendPage('indexColList');
	
    //고급설정
    $('#idxAdvanceBtn').on('click', function(){
    	if(idxId != null){ 
    		idxAdvancePopOpen();
    	}else{ 		
    		alert('<spring:message code="M00004" />');
    	}
    });
    
    //인덱스생성
    $("#idxCreatBtn").on('click', function(){
    	if(idxId != null){ 
    		idxCreatPopOpen();
    	}else{ 		
    		alert('<spring:message code="M00004" />');
    	}
    });
});

</script>

<%-- <div class="page_btn_area">
    <div class="col-xs-7">
    </div>
    <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id="idxAdvanceBtn">
            <spring:message code="M01570" />
        </button> 
        <button class="btn btn-sm" id="idxCreatBtn">
            <spring:message code="M01592" />
        </button> 
    </div>
</div> --%>
<!-- <div style="width: 100%; height: 15px;"></div> -->
<div id='indexFormArea'>
		<div id="indexAreaContent">
			<div class="col-xs-6">
			<div  id="indexList"></div>
			</div>
			<div class="col-xs-6 pl10">
			<div id="indexColList"></div>		
			</div>
		</div> 
</div>
