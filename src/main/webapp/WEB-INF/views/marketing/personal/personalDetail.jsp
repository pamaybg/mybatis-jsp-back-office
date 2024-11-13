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


var personalid = '<%= cleanXss(request.getParameter("id")) %>';
var detail = false;  //수정 페이지 체크 ture일 시 수정, false일 시 신규 생성 페이지
var validation;
var isValid;





//상세 페이지인지 체크
function idCheck(){
	if(personalid != "null") 
	{		
		//상세 내용 적용
		$.ifvSyncPostJSON('<ifvm:action name="getPersonalDetail"/>', {
			   id : personalid
		}, function(result) {
			    $("#perTypeCd").val(result.perTypeCd);
				$("#dbSchema").val(result.dbSchema);
				$("#tableName").val(result.tableName);
				$("#columnName").val(result.columnName);
				$("#whereSchMemId").val(result.whereSchMemId);
				$("#whereSchPhone").val(result.whereSchPhone);
				$("#description").val(result.perDesc);
				$("#create_by").val(result.createBy);
				$("#createDate").val(result.createDate);
				$("#modify_by").val(result.modifyBy);
				$("#modify_date").val(result.modifyDate);
		});
		detail = true; 	
	}else{
		//신규
	   	$('#create_by').val($.ifvmGetUserInfo().empName);
		$('#createDate').val($.ifvFormatDate( 'yyyy-mm-dd', new Date()));
	}
}



//저장 버튼클릭 시 동작
function savePersonal() {
	
	isValid = validation.confirm();

	if(isValid){
		//상세 페이지일 시 수정 작업 동작
		if(detail)
		{
			//개인화 속성 수정
				$.ifvSyncPostJSON('<ifvm:action name="updatePersonal"/>', {
					       id : personalid
					 	 , perTypeCd : $("#perTypeCd").val()
						 , dbSchema : $("#dbSchema").val()
						 , tableName : $("#tableName").val()
						 , columnName : $("#columnName").val()
						 , whereSchMemId : $("#whereSchMemId").val()
						 , whereSchPhone : $("#whereSchPhone").val()
						 , perDesc : $("#description").val()
				}, function(result) {
					if(result.success){
						alert('<spring:message code="M01015"/>');
					}
					else{
						alert('<spring:message code="M01017"/>');	
					}
					qtjs.href('<ifvm:url name="personalList"/>');
				});
			
		}
		//상세 페이지가 아닐 시 insert 동작
		else
		{
			//language code
			$.ifvSyncPostJSON('<ifvm:action name="addPersonal"/>', {
						   perTypeCd : $("#perTypeCd").val()
						 , dbSchema : $("#dbSchema").val()
						 , tableName : $("#tableName").val()
						 , columnName : $("#columnName").val()
						 , whereSchMemId : $("#whereSchMemId").val()
						 , whereSchPhone : $("#whereSchPhone").val()
						 , perDesc : $("#description").val()
			}, function(result) {
				if(result.success){
					alert('<spring:message code="M01014"/>');
				}
				else{
					alert('<spring:message code="M01017"/>');	
				}
				qtjs.href('<ifvm:url name="personalList"/>');
				
				
			});
		}
	}
	else alert('<spring:message code="M01022"/>')	
	
}



$(document).ready(function(){
	$.ifvmLnbSetting('personalList');
	
	$("#btnPersonalSave").click(function () {
		savePersonal();
    });
	validation = $("#selectForm").ifvValidation();
});

/*로딩 시 세팅해주는 부분. 
* 선택구역,반경 등의 Data를 가져와 화면에 뿌려준다.
*/
$(function () {
	
	//개인화속성 유형 조회 
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_PERSONAL_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#mktPersonalPropertyTemp").tmpl(result.rows);
		$("#perTypeCd").append(temp);
	});
	
	idCheck();
	
});


</script>

<script id="mktPersonalPropertyTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
.personal_description{height:100px;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="M00998"/> &gt;  <spring:message code="M00274"/>( <spring:message code="M00283"/>)
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01004"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="btnPersonalSave">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00573"/>
		</button> 
	</div>
</div>
<div>
	<div class="well form-horizontal underline" id="selectForm" >
		<div class="row  qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00997"/></label>	<!-- 개인화 속성 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="select" id="perTypeCd" required='true'/>
			</div>
		</div> 
		
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00999"/></label><!-- 접속 DB스키마 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="dbSchema" maxLength='30' required='true'/>
			</div>
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01000"/></label><!-- 접속 DB테이블 -->
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" id="tableName" maxLength='30' required='true'/>
			</div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01001"/></label><!-- 접속 DB컬럼 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="columnName" maxLength='30' required='true'/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="M01002"/></label><!-- 조회조건 회원컬럼 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" id="whereSchMemId" maxLength='30' />
			</div>
			<label class="col-xs-2 control-label"><spring:message code="M01003"/></label><!-- 조회조건 전화번호 컬럼-->
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" id="whereSchPhone" maxLength='50'/>
			</div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="M01008"/></label><!-- 설명 -->
			<div class="col-xs-9 control_content">
				<ifvm:input type="textarea" className="personal_description" id="description" maxLength='100'/>
			</div>
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-2 control-label"><spring:message code="M01009"/></label><!-- 등록자 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" id="create_by"/>
			</div>
			<label class="col-xs-2 control-label"><spring:message code="M01011"/></label><!-- 등록일시 -->
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" disabled="true" id="createDate"/>
			</div>
		</div>
		<div class="row">
			<label class="col-xs-2 control-label"><spring:message code="M01012"/></label><!-- 변경자 -->
			<div class="col-xs-4 control_content">
				<ifvm:input type="text" disabled="true" id="modify_by"/>
			</div>
			<label class="col-xs-2 control-label"><spring:message code="M01013"/></label><!-- 변경일시 -->
			<div class="col-xs-3 control_content">
				<ifvm:input type="text" disabled="true" id="modify_date"/>
			</div>
		</div>
		
		
	</div>
</div>
