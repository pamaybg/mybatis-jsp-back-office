<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var pageNum = 1;	
var fileUpload1URL = '<ifvm:url name="fileUpload1"/>';		//임포트 유형 선택
var fileUpload2URL = '<ifvm:url name="fileUpload2"/>';		//파일 찾기
var fileUpload3URL = '<ifvm:url name="fileUpload3"/>';		//컬럼 매핑
var fileUpload4URL = '<ifvm:url name="fileUpload4"/>';		//임시저장 확인
var fileUpload5URL = '<ifvm:url name="fileUpload5"/>';		//최종 적용
var excelHeader;
var formData = new FormData();
var importType = "A";
var gridIdcolumMappingGrid;
var fvIds = [];
var columMappingGrid;
var excelUpResultGrid;
var excelUpfinalGrid;
var failCnt = 0;
var excelColList = [];
var dataIDs;
var fileName;
var excelHeader = null;

// 화면 표시 
function appendPage(type) {
	$("#fileUpContent").empty();
	$("#fileUpContent").html('');
	var url = '';
	
	switch( type ){
		case 'fileUpload1' :
			url = this.fileUpload1URL;
			break;
		case 'fileUpload2' :
			url = this.fileUpload2URL;
			break;
		case 'fileUpload3' :
			url = this.fileUpload3URL;
			break;
		case 'fileUpload4' :
			url = this.fileUpload4URL;
			break;
		case 'fileUpload5' :
			url = this.fileUpload5URL;
			break;
		default :
	break;
	};
	
	var fileName = url.split('/').pop();
	$.ifvCachedHtml( url ).done( function(script, textStatus){
		if(type == 'fileUpload1') $("#fileUpContent").append( script );  
		else if(type == 'fileUpload2') $("#fileUpContent").append( script );
		else  $("#fileUpContent").append( script );
		
		if( window[fileName + '_init'] != null ) window[fileName + '_init']();
	});
}
// 이전 버튼 disabled
function prevDisable(){
	if(pageNum == 1){
		$("#btnPrev").attr("disabled",true);
	}else{
		$("#btnPrev").attr("disabled",false);
	}
}
// 오류내역확인 팝업
function uploadErrorPop(){
	 $("#dialogErrorPop").ifvsfPopup({
	 	 enableModal : true,
	     enableResize: false,
	     contentUrl: '<ifvm:url name="uploadErrorPop"/>',
	     contentType: "ajax",
	     title: '<spring:message code="M01766"/>',
	     width: 800,
	     close : 'upErrorPopClose' 
	 });
}

$(document).ready(function() {
	$("#fileUpPopFormArea").ifvValidation();
	$("#btnPrev").attr("disabled",true);
	
	/* 취소 */
	$("#btnCancle").on('click', function(){
		fileUpPopClose();
	});

	/* 뒤로 */
	$("#btnPrev").on('click', function(){
		if( $.fn.ifvmIsNotEmpty( pageNum ) ) {
			pageNum = --pageNum;
			
			prevDisable();
			$('#fileUpContent').hide();
			if(pageNum == 1){
				$('#fileUpContent').show();
				$('#btnCancle').show();
				$('#btnPrev').show();
				$('#btnNext').show();
				$('#btnTemp').hide();
				$('#btnFinal').hide();
				$('#btnConf').hide();
				$('#btnError').hide();
				appendPage('fileUpload1');
			}else if(pageNum == 2){
				$('#fileUpContent').show();
				$('#btnCancle').show();
				$('#btnPrev').show();
				$('#btnNext').show();
				$('#btnTemp').hide();
				$('#btnFinal').hide();
				$('#btnConf').hide();
				$('#btnError').hide();
				appendPage('fileUpload2');
			}else if(pageNum == 3){
				$('#fileUpContent').show();
				$('#btnCancle').show();
				$('#btnPrev').show();
				$('#btnNext').hide();
				$('#btnTemp').show();
				$('#btnFinal').hide();
				$('#btnConf').hide();
				$('#btnError').hide();
				appendPage('fileUpload3');
			}else if(pageNum == 4){
				$('#fileUpContent').show();
				$('#btnCancle').show();
				$('#btnPrev').show();
				$('#btnNext').hide();
				$('#btnTemp').hide();
				$('#btnFinal').show();
				$('#btnConf').hide();
				$('#btnError').show();
				appendPage('fileUpload4');
			}else if(pageNum == 5){
				$('#fileUpContent').show();
				$('#btnCancle').show();
				$('#btnPrev').show();
				$('#btnTemp').hide();
				$('#btnNext').hide();
				$('#btnFinal').show();
				$('#btnConf').hide();
				$('#btnError').show();
				appendPage('fileUpload5');
			}
		}
	});
	// 오류내역 확인버튼
	$("#btnError").on('click', function(){
		uploadErrorPop();
	});
	// 임시저장 버튼
	$("#btnTemp").on('click', function(){
		$("#btnNext").trigger("click");
	});
	// 최종확인 버튼
	$("#btnFinal").on('click', function(){
		$("#btnNext").trigger("click");
	});
	// 확인버튼
	$("#btnConf").on('click', function(){
		$("#btnNext").trigger("click");
	});
	
	/* 다음 */
	$("#btnNext").on('click', function(){
		if( $.fn.ifvmIsNotEmpty( pageNum ) ) {
			pageNum = ++pageNum;
			
			prevDisable();
			$('#fileUpContent').hide();
			if(pageNum == 1){
				$('#fileUpContent').show();
				$('#btnCancle').show();
				$('#btnNext').show();
				$('#btnTemp').hide();
				$('#btnPrev').show();
				$('#btnFinal').hide();
				$('#btnConf').hide();
				$('#btnError').hide();
				appendPage('fileUpload1');
				if($('#fileupload-flow > li.on').next().length < 1) return;
			    $('#fileupload-flow > li.on').next().addClass('on');
			}else if(pageNum == 2){
				$('#fileUpContent').show();
				$('#btnCancle').show();
				$('#btnNext').show();
				$('#btnTemp').hide();
				$('#btnPrev').show();
				$('#btnFinal').hide();
				$('#btnConf').hide();
				$('#btnError').hide();
				appendPage('fileUpload2');
				if($('#fileupload-flow > li.on').next().length < 1) return;
			    $('#fileupload-flow > li.on').next().addClass('on');
			}else if(pageNum == 3){
				if(excelHeader == null){
					alert('<spring:message code="M00686"/>');	
					pageNum = 2;
					$('#fileUpContent').show();
					appendPage('fileUpload2');
					return;
				}else{
					$('#fileUpContent').show();
					$('#btnCancle').show();
					$('#btnNext').hide();
					$('#btnTemp').show();
					$('#btnPrev').show();
					$('#btnFinal').hide();
					$('#btnConf').hide();
					$('#btnError').hide();
					appendPage('fileUpload3');
					if($('#fileupload-flow > li.on').next().length < 1) return;
				    $('#fileupload-flow > li.on').next().addClass('on');
				}
			}else if(pageNum == 4){
 				if(confirm('<spring:message code="M01785"/>')){ 
					excelMapping(); // 임시테이블 저장
					$('#fileUpContent').show();
					$('#btnCancle').show();
					$('#btnNext').hide();
					$('#btnTemp').hide();
					$('#btnPrev').show();
					$('#btnFinal').show();
					$('#btnConf').hide();
					$('#btnError').show();
					appendPage('fileUpload4');
					if($('#fileupload-flow > li.on').next().length < 1) return;
				    $('#fileupload-flow > li.on').next().addClass('on');
				}else{
					pageNum = 3;
					$('#fileUpContent').show();
					appendPage('fileUpload3');
				} 
			}else if(pageNum == 5){
				if(confirm('<spring:message code="M01769"/>')){
					setReExcelUpload(); // 메인테이블 저장
					$('#fileUpContent').show();
					$('#btnCancle').hide();
					$('#btnPrev').show();
					$('#btnNext').hide();
					$('#btnTemp').hide();
					$('#btnFinal').hide();
					$('#btnConf').show();
					$('#btnError').show();
					appendPage('fileUpload5');
					if($('#fileupload-flow > li.on').next().length < 1) return;
				    $('#fileupload-flow > li.on').next().addClass('on');
				 }else{
					pageNum = 4;
					$('#fileUpContent').show();
					appendPage('fileUpload4');
					getExcelUpResultList();
				 } 
			}else if(pageNum == 6){
				fileUpPopClose();
			}
			
		}
	});
	
	if( $.fn.ifvmIsNotEmpty( tableNm ) ) {
		$("#fileUpContent").empty();
		$("#fileUpContent").html('');
		
		$('#fileUpContent').show();
		appendPage('fileUpload1');
	}
});

$(function() {
	   $('#btnPrev').on('click', function() {
	      if($('#fileupload-flow > li.on').prev().length < 1) return;
	      $('#fileupload-flow > li.on').removeClass('on').prev().addClass('on');
	   });
});

</script>
<style type="text/css">
	.flow_viewbox{
		width:760px;	
		padding:15px;
		background:#f8f8f8;
		border:1px solid #dbdbdb;
		margin-bottom:30px;		
	}
	.flow_form  .description_title {
		font-weight:bold;
		margin-bottom:10px;
	}
	.flow_form {
		margin-bottom:20px;
	}
	
	.flow_viewbox > ul {
		overflow:hidden;
		margin:0;
	}
	.data_upload_flow > li {
		display:inline-block;
		position:relative;
		float:left;
		width:130px;
		height:78px;
		margin-right:19px;		
		background:#ffffff;
		border:1px solid #c1cece;
		border-radius:5px;
		text-align:center;
		transition:background 0.5s ease;
	}
	.data_upload_flow > li:after{
		content:'';
		display:inline-block;	
		position:absolute;	
		width:20px;
		height:20px;
		top:50%;
		right:-20px;
		margin-top:-10px;
		background-image:url("${pageContext.request.contextPath}/resources/images/kepler/analytics/ico_pop_dataimport.png");
		background-repeat:no-repeat;
		background-position:-11px -295px;
	}	
	.data_upload_flow > li.on:after{
		background-position:-89px -295px;		
	}	
	.data_upload_flow > li:last-child:after{
		display:none;
	}
	.data_upload_flow > li > div {
		display:block;
		width:75px;
		height:50px;
		margin:0 auto;
		background-image:url("${pageContext.request.contextPath}/resources/images/kepler/analytics/ico_pop_dataimport.png");
		background-repeat:no-repeat;
	}	
	.data_upload_flow > li > div.ico_1st{background-position:6px -4px;}	
	.data_upload_flow > li.on > div.ico_1st{background-position:-74px -4px;}	
	.data_upload_flow > li > div.ico_2nd{background-position:6px -57px;}	
	.data_upload_flow > li.on > div.ico_2nd{background-position:-74px -57px;}	
	.data_upload_flow > li > div.ico_3rd{background-position:-2px -110px;}	
	.data_upload_flow > li.on > div.ico_3rd{background-position:-82px -110px;}	
	.data_upload_flow > li > div.ico_4th{background-position:6px -172px;}	
	.data_upload_flow > li.on > div.ico_4th{background-position:-74px -172px;}		
	.data_upload_flow > li > div.ico_5th{background-position:6px -231px;}	
	.data_upload_flow > li.on > div.ico_5th{background-position:-74px -231px;}	
											
	.data_upload_flow > li > span {
		font-size:12px;
		font-weight:bold;
		color:#888888;
	}	
	.data_upload_flow > li.on{
		background:#55a9d0;
		border:1px solid #3388b0;
	}
	.data_upload_flow > li.on > span{
		color:#FFFFFF;
	}	
	.data_upload_flow > li:last-child{
		margin-right:0;
	}
	.pop_btn_area {
		padding:8px 20px;
		overflow:hidden;
	}
	.float_l {float:left;}
	.float_r {float:right;}
	
	#btnFinal{display: none;}
	#btnConf{display: none;}
	#btnTemp{display: none;}
	#btnError{display: none; margin-left:4px;}
</style>

<div class="pop_inner_wrap">	
	<div class="flow_viewbox">
		<ul id="fileupload-flow" class="data_upload_flow">
			<li class="on"><div class="ico_1st"></div><span><spring:message code="M01761"/></span></li>
			<li class=""><div class="ico_2nd"></div><span><spring:message code="M01762"/></span></li>
			<li class=""><div class="ico_3rd"></div><span><spring:message code="M01763"/></span></li>
			<li class=""><div class="ico_4th"></div><span><spring:message code="M01764"/></span></li>
			<li class=""><div class="ico_5th"></div><span><spring:message code="M01765"/></span></li>
		</ul>
	</div>
	<div class="form flow_form">
		<div id="fileUpContent"></div>
    </div>
</div>
<div class="pop_btn_area">
	
    <button class="btn btn-sm btn_lightGray2 float_l" id="btnCancle">         
		<spring:message code="M00284"/>
    </button> 
    <button class="btn btn-sm btn_gray float_l" id="btnError">         
		<spring:message code="M01767"/>
    </button> 
    <div class="float_r">
		<button class="btn btn-sm btn_gray" id="btnPrev">         
			<i class="fa fa-arrow-left"></i>
			<spring:message code="M00101"/>
	    </button>  
		<button class="btn btn-sm btn_gray" id="btnNext">         
			<spring:message code="M00100"/>
			<i class="fa fa-arrow-right"></i>
	    </button>
		<button class="btn btn-sm btn_gray" id="btnTemp">         
			<spring:message code="M01784"/>
			<i class="fa fa-arrow-right"></i>
	    </button>  
		<button class="btn btn-sm btn_gray" id="btnFinal">         
			<i class="fa fa-check-square-o"></i>
			<spring:message code="M01765"/>
	    </button>  
		<button class="btn btn-sm btn_gray" id="btnConf">         
			<spring:message code="M00279"/>
	    </button> 
	    
    </div>
</div>
