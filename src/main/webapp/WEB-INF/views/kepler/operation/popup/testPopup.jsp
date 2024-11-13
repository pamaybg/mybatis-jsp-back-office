<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
	/*$(function() {
		$("#btnNext").click(function() {		
			  $(".data_upload_flow > li.on + li")		  
					 .addClass("on")
			  });
		$("#btnPrev").click(function() {		
			  $(".data_upload_flow > li.on + li.on").eq(-1)
					 .removeClass("on")
			  });	
	});*/
	
	$(function() {
		   $('#btnPrev').on('click', function() {
		      if($('.data_upload_flow > li.on').prev().length < 1) return;
		      $('.data_upload_flow > li.on').removeClass('on').prev().addClass('on');
		   });

		   $('#btnNext').on('click', function() {
		      if($('.data_upload_flow > li.on').next().length < 1) return;
		      $('.data_upload_flow > li.on').next().addClass('on');
		   });
		});	
</script>

<style type="text/css">
	.flow_viewbox{
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
		margin-right:20px;		
		background:#ffffff;
		border:1px solid #c1cece;
		border-radius:5px;
		text-align:center;
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
	
</style>

<div class="pop_inner_wrap">	
	<div class="flow_viewbox">
		<ul id="test1" class="data_upload_flow">
			<li class="on"><div class="ico_1st"></div><span>임포트 유형선택</span></li>
			<li class=""><div class="ico_2nd"></div><span>파일 찾기</span></li>
			<li class=""><div class="ico_3rd"></div><span>컬럼매핑</span></li>
			<li class=""><div class="ico_4th"></div><span>임시저장확인</span></li>
			<li class=""><div class="ico_5th"></div><span>최종적용</span></li>
		</ul>
	</div>
	<div class="form flow_form">
		<div class="description_title">임포트 유형을 선택하세요.</div>	
		<div class="form-horizontal">
		  	<!--<ifvm:input type="radioType" id="test" text="M00310|M00310|M00310"/>--> 
			<span class="iradioType">
	            <label for="test">            	
	                <input type="radio" id="test" value="">Initial Insert(모든 데이터를 삭제 후, insert합니다.)</label>
	        </span>	
	    </div>
	 	<div class="form-horizontal">   
			<span class="iradioType">
	            <label for="test2">            	
	                <input type="radio" id="test2" value="">Additional Insert(데이터를 추가로 insert합니다.)</label>
	        </span>	 
		</div>
	 	<div class="form-horizontal">   
			<span class="iradioType">
	            <label for="test3">            	
	                <input type="radio" id="test3" value="">Update(각 테이블의 키 값 기준으로 update합니다.)</label>
	        </span>	 
		</div>		
	</div>	
	<!--<div class="form flow_form">
		<div class="description_title">파일 유형 및 업로드 할 파일을 선택하세요.</div>	
		<div class="row qt_border form-horizontal">
		     <div class="col-xs-2"><label class="control-label"><span class="asterisk">*</span>파일 유형</label></div>
		     <div class="col-xs-4">
		     	<div class="control_content">	
		     		<select id="searchType" class=""> 
		     		</select>      		
		      	</div>
	    	 </div>	
	    </div>		
		<div class="row qt_border form-horizontal">
		     <div class="col-xs-2"><label class="control-label"><span class="asterisk">*</span>파일 경로</label></div>
		     <div class="col-xs-6">
		     	<div class="control_content">
		      		<input type="text" id="subjectAreaNm" required="" maxlength="50">	      		
		      	</div>
	    	 </div>
	    	 <div class="col-xs-2">
				<button class="btn_Load row_btn" id="">
					<img src=${pageContext.request.contextPath}/resources/images/marketing/common/ico_search.png alt="">				
				찾아보기</button>	
	    	 </div>	    	
	    </div>
		</div>	
	</div>	-->	
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnPrev">     
		<i class="fa fa-arrow-left"></i>    
		이전
	</button> 
	<button class="btn btn-sm btn_gray" id="btnNext">     
		<i class="fa fa-arrow-right"></i>    
		다음
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnColcan">         
		<spring:message code="C00040"/>
    </button>     
</div>
