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

var responseInfoId = '<%= cleanXss(request.getParameter("id")) %>';
var detail = false;  //수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
var validation;
var isValid;

//상세 페이지인지 체크
function idCheck(){
	if(responseInfoId != "null")
	{
		//상세 내용 적용
		$.ifvSyncPostJSON('<ifvm:action name="getResponseInfoDetail"/>', {
			   id : responseInfoId
		}, function(result) {
			    $("#camRspnsCd").val(result.camRspnsCd);
				$("#dpSeq").val(result.dpSeq);
				$("#camRspnsNm").val(result.camRspnsNm);
				$("#spcfChnlRspnsCd").val(result.spcfChnlRspnsCd);
				$("#camRspnsDesc").val(result.camRspnsDesc);
				$('#parRspnsCd').val(result.parRspnsName).text(result.parRspnsCd);
				$("#createBy").val(result.createBy);
				$("#createDate").val(result.createDate);
				$("#modifyBy").val(result.modifyBy);
				$("#modifyDate").val(result.modifyDate);
		});
		detail = true;
	}else{
		//신규
		$('#createBy').val($.ifvmGetUserInfo().empName);
	   	$('#createDate').val($.ifvFormatDate( 'yyyy-mm-dd', new Date()));

	}
}

//저장 버튼클릭 시 동작
function saveResponseInfo() {
	var dpSeq = $('#dpSeq').val();
	isValid = validation.confirm();

	if(isValid && (dpSeq.length == '6')){
		//상세 페이지일 시 수정 작업 동작
		if(detail)
		{
			//반응정보 수정
				$.ifvSyncPostJSON('<ifvm:action name="updateResponseInfo"/>', {
					       id : responseInfoId
					 	 , camRspnsCd : $("#camRspnsCd").val()
						 , dpSeq : $("#dpSeq").val()
						 , camRspnsNm : $("#camRspnsNm").val()
						 , spcfChnlRspnsCd : $("#spcfChnlRspnsCd").val()
						 , camRspnsDesc : $("#camRspnsDesc").val()
						 , parRspnsCd : $('#parRspnsCd').text()
				}, function(result) {
						alert('<spring:message code="M01015"/>');
						qtjs.href('<ifvm:url name="responseInfoList"/>');

				}, function(result) {

						//false 중복
						if(result.errorType == '900001'){
							alert('<spring:message code="M01271"/>');
						}else if(result.errorType == '900002'){
							alert('<spring:message code="M01273"/>');
						}else if(result.errorType == '900003'){
							alert('<spring:message code="M01272"/>');
						}
						else{
							alert('<spring:message code="M01017"/>');
						}
				});

		}
		//상세 페이지가 아닐 시 insert 동작
		else
		{

			//language code
			$.ifvSyncPostJSON('<ifvm:action name="insertResponseInfo"/>', {
						   camRspnsCd : $("#camRspnsCd").val()
						 , dpSeq : $("#dpSeq").val()
						 , camRspnsNm : $("#camRspnsNm").val()
						 , spcfChnlRspnsCd : $("#spcfChnlRspnsCd").val()
						 , camRspnsDesc : $("#camRspnsDesc").val()
						 , parRspnsCd : $('#parRspnsCd').text()
			}, function(result) {
				if(result.success){
					alert('<spring:message code="M01014"/>');
					qtjs.href('<ifvm:url name="responseInfoList"/>');
				}
				else{
					alert('<spring:message code="M01017"/>');
				}
			}, function(result) {

				//false 중복
				if(result.errorType == '900001'){
					alert('<spring:message code="M01271"/>');
				}else if(result.errorType == '900002'){

					alert('<spring:message code="M01273"/>');

				}else if(result.errorType == '900003'){
					alert('<spring:message code="M01272"/>');
				}
				else{
					alert('<spring:message code="M01017"/>');
				}

			});

		}
	}
	else{
		if(dpSeq.length != '6'){
			alert('<spring:message code="M01274"/>');
		}else{
			alert('<spring:message code="M01022"/>');
		}
	}

}

function responseInfoPopupClose() {
	$('#popupContainer').ejDialog('destroy');
}

//목록 돌아가기
function goList() {
	qtjs.href('<ifvm:url name="responseInfoList"/>');
}


$(document).ready(function(){
	$.ifvmLnbSetting('responseInfoListNew');

	$("#btnResponseInfoSave").click(function () {
		saveResponseInfo();
    });
	validation = $("#selectForm").ifvValidation();


	$('#searchResponseInfo').on('click', function() {
		$("#popupContainer").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="responseInfoListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01269"/>',
	        width: 600,
	        close : 'responseInfoPopupClose'
	    });
	});

});

/*로딩 시 세팅해주는 부분.
* 선택구역,반경 등의 Data를 가져와 화면에 뿌려준다.
*/
$(function () {

	//적용 채널조회
	$("#spcfChnlRspnsCd").append($('<option/>').text('<spring:message code="C00137"/>').val(""));

	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_CAM_CHNL_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#mktResponseInfoPropertyTemp").tmpl(result.rows);
		$("#spcfChnlRspnsCd").append(temp);
	});

	idCheck();

});


</script>

<script id="mktResponseInfoPropertyTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
.personal_camRspnsDesc{height:100px;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="M01258"/> &gt;  <spring:message code="M00274"/>( <spring:message code="M00283"/>)
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M01004"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="btnResponseInfoSave" objCode="responseInfoDetailSave_OBJ">
				<i class="glyphicon glyphicon-check"></i>
				<spring:message code="M00573"/>
			</button>
			<ifvm:inputNew type="button" id="goResponseInfoListNew" btnFunc="goList" text="L00824" objCode="goResponseInfoListNew_OBJ"/>
		</div>
	</div>

	<div class="well form-horizontal underline" id="selectForm" >
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M01262"/></label>	<!-- 노출순서 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="dpSeq" maxLength='6' required='true' valiItem ='number'/>
			</div>
			<span class="detail_txt"><spring:message code="M01270"/></span>
		</div>

		<div class="row qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M01259"/></label><!-- 캠페인 반응코드 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="camRspnsCd" maxLength='18' required='true'/>
			</div>
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01260"/></label><!-- 접속 DB테이블 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="camRspnsNm" maxLength='30' required='true'/>
			</div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="M01261"/></label>	<!-- 적용 채널 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="select" id="spcfChnlRspnsCd"/>
			</div>
			<label class="col-xs-2 control-label"><spring:message code="M01263"/></label><!--상위 반응정보코드  -->
			<div class="col-xs-4 control_content">
				<div class="input-group">
					<ifvm:input type="text" disabled="true" id="parRspnsCd"/>
					<span class="input-group-addon" id="searchResponseInfo"><i class="fa fa-search"></i></span>
				</div>
			</div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="M01264"/></label><!-- 설명 -->
			<div class="col-xs-10 control_content">
				<ifvm:input type="textarea" className="personal_camRspnsDesc" id="camRspnsDesc" maxLength='100'/>
			</div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="M00303"/></label><!-- 등록자 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" id="createBy"/>
			</div>
			<label class="col-xs-2 control-label"><spring:message code="M00304"/></label><!-- 등록일시 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" id="createDate"/>
			</div>
		</div>
		<div class="row">
			<label class="col-xs-1 control-label"><spring:message code="M00305"/></label><!-- 변경자 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" id="modifyBy"/>
			</div>
			<label class="col-xs-2 control-label"><spring:message code="M00306"/></label><!-- 변경일시 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" id="modifyDate"/>
			</div>
		</div>
	</div>
</div>

<div id="popupContainer" class="popup_container"></div>
