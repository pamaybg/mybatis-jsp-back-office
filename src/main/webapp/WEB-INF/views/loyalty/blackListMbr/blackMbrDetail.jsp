<%@ page trimDirectiveWhitespaces="true" %>
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

<div class="page-title">
    <h1>
        <spring:message code="블랙리스트 회원"/>
        &gt;  <spring:message code="M00169"/>
    </h1>
</div>
<div>
	<div class="page_btn_area" id="headForm">
	    <div class="col-xs-7">
	    	<%-- 채널 상세 --%>
	        <span><spring:message code="기본정보"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	        <ifvm:inputNew type="button" id="goSave" btnFunc="blackMbrDetail.save" text="I00745" objCode="blackMbrDetailSave_OBJ"/>
			<ifvm:inputNew type="button" id="goTermsList" btnFunc="blackMbrDetail.goList" text="L00824" objCode="blackMbrDetailList_OBJ"/>
	    </div>
	</div>
	
	<div class="form-horizontal underline top_well" id="blackMbrDetailForm">
		<div class="row  qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="대표프로그램"/></label>
			<div class="col-xs-3 control_content">
				<div class="input-group">
				<ifvm:inputNew type="text" disabled="true" id="pgmNm" dto="pgmNm" required="true"/>
				<span class="input-group-addon" id="pgmPopBtn">
							<a><i class="fa fa-search"></i></a>
						</span>
				</div>
			</div>
			<ifvm:inputNew type="hidden" id="repYnCheck" conClass="1"  disabled="true"/>
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="등록유형"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="select" id="blackTypeCd" dto="blackTypeCd" names="blackTypeCd" required="true"/>
			</div>
			
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="상태"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="select" id="statCd" names="statCd" dto="statCd" required="true"/>
			</div>
		
	
		</div>
		
		<div class="half_wrap top_well">
			<!-- 가치 -->
			<div class="half_content half_left">
				<div class="page_btn_area">
					<div class="col-xs-7">
						<span><spring:message code="고객정보" /></span>
					</div>
				</div>
				<div class="form-horizontal top_well underline">
					<div class="row">
						<label class="col-xs-2 control-label"><spring:message code="고객명"/></label>
						<div class="col-xs-4 control_content">
							<ifvm:inputNew type="text"  id="custNm" dto="custNm"/>
						</div>
						
						<label class="col-xs-2 control-label"><spring:message code="생년월일"/></label>
						<div class="col-xs-4 control_content">
							<ifvm:inputNew type="date" id="birthdt" dto="birthdt" />
						</div>
					</div>
					
					<div class="row">
						<label class="col-xs-2 control-label"><spring:message code="이메일"/></label>
						<div class="col-xs-4 control_content">
							<ifvm:inputNew type="text"  id="email" dto="email"/>
						</div>
						
						<label class="col-xs-2 control-label"><spring:message code="휴대폰"/></label>
						<div class="col-xs-4 control_content">
							<ifvm:inputNew type="text" id="hhp" dto="hhp" />
						</div>
					</div>

				</div>
			</div>
			<!-- 정산 -->
			<div class="half_content half_right">
				<div class="page_btn_area">
					<div class="col-xs-7">
						<span> <spring:message code="제한정책" /></span>
					</div>
				</div>
				<div class="form-horizontal top_well underline">
					<div class="row">
						<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="가입정책"/></label>
						<div class="col-xs-4 control_content">
							<ifvm:inputNew type="select" id="sbscPlcyCd" dto="sbscPlcyCd" names="sbscPlcyCd" required="true"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<br>
		<div class="row qt_border">
				<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="사유"/></label>
				<div class="col-xs-10 control_content">
					<ifvm:inputNew type="textarea" maxLength="150" id="blComment" dto="blComment" required="true" labelClass="2" conClass="20" rows="5"/>
				</div>
			</div> 
		
		</div>


	
</div>


<div id="programPop" class="popup_container"></div>

<script>
var statCd = null;

var blackMbrDetail_rid = '<%= cleanXss(request.getParameter("rid")) %>';
blackMbrDetail_rid = blackMbrDetail_rid == 'null' ? null : blackMbrDetail_rid;
var blackMbrDetail_isNew = true;  //신규 여부. 신규: true, 수정 : false
var pgmRid = null;
$("#repYnCheck").val('Y');
var blackMbrDetail={
		init : function(){
			$.fn.ifvmSetSelectOptionCommCode("blackTypeCd", "LOY_BLACK_REG_CD", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("statCd", "LOY_BLACK_REG_STAT_CD", null, null, true);
			$.fn.ifvmSetSelectOptionCommCode("sbscPlcyCd", "LOY_BLACK_PLCY_SBSC_CD", null, null, true);
	    	if (blackMbrDetail_rid === null){
	    		blackMbrDetail_isNew = true;
	    	}
			else
				blackMbrDetail_isNew = false;
			if (!blackMbrDetail_isNew) {
				$.ifvSyncPostJSON('<ifvm:action name="getBlackListMbrDetail"/>', {
					rid : blackMbrDetail_rid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#blackMbrDetailForm").dataSetting(result);
						$("#birthdt").val(result.birthdt);
						$("#contents").val(result.contents);
						$("#periodMm").val(result.periodMm);
						pgmRid = result.pgmRid;
						
						var hhp = result.hhp.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
						$("#hhp").val(hhp);
						
					}
				}, function(result) {
					alert(result.message);
				});
			}
		},//INIT END
		save : function(){
			var validation = $("#blackMbrDetailForm").ifvValidation();
			
			//유효성 체크
			if(validation.confirm()){
				if($("#custNm").val()=='' && $("#hhp").val()=='' && $("#email").val()=='' && $("#birthdt").val()=='') {
					alert("최소 1개의 조건을 압력해주세요.(고객명 및 생년월일항목은 2개이상 조건이 필요합니다.)");
					return;
				}
				
				if($("#custNm").val()!='') {
					if($("#hhp").val()=='' && $("#birthdt").val()=='' && $("#email").val()=='') {
						alert("고객명 및 생년월일항목은 2개이상 조건이 필요합니다.");
						return;
					}
				}
				if($("#birthdt").val()!='') {
					if($("#custNm").val()=='' && $("#hhp").val()=='' && $("#email").val()=='') {
						alert("고객명 및 생년월일항목은 2개이상 조건이 필요합니다.");
						return;
					}
				}
				
				
				var url = blackMbrDetail_isNew? '<ifvm:action name="saveBlackMbrDetail"/>' : '<ifvm:action name="modifyBlackMbrDetail"/>';
				var varData = null;
				
				var hhp = $("#hhp").val();
				hhp = hhp.replaceAll("-","");
				var birthdt = $("#birthdt").val();
				birthdt = birthdt.replaceAll("-","");
				var email = $("#email").val();
				email = email.toLowerCase();
				var custNm = $("#custNm").val();
				custNm = custNm.toUpperCase();
				
				varData = $("#blackMbrDetailForm").getSubmitData();
				varData.rid = blackMbrDetail_rid;
				varData.pgmRid = pgmRid;
				varData.blackTypeCd = $("#blackTypeCd").val();
				varData.custNm = custNm;
				varData.birthdt = birthdt;
				varData.hhp = hhp;
				varData.email   = email;
				varData.statCd   = $("#statCd").val();
				varData.sbscPlcyCd   = $("#sbscPlcyCd").val();
				varData.blComment   = $("#blComment").val();

				$.ifvSyncPostJSON(url, varData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
						blackMbrDetail.init();
					}
				}, function(result) {
					alert("<spring:message code="M02248" />");
				});
			 }
		},//SAVE END
		goList : function(){
			qtjs.href('<ifvm:url name="blackListMbr"/>');
		}
	}
	
function pgmPopup() {
	$("#programPop").ifvsfPopup({
		enableModal : true,
	    enableResize: false,
	    contentUrl: '<ifvm:url name="programPgmPop"/>',
	    contentType: "ajax",
	    title: '로열티 프로그램 조회',
	    width: '900px',
	    close : 'pgmClosePop',
	});
}

function pgmClosePop() {
	programPop._destroy();
}


function setValidCalendar() {	
	var birthdt = $("#birthdt");

	//birthdt.val($.ifvGetTodayDate());

	birthdt.ifvDateChecker({
		
	});
}

$(document).ready(function() {
	setValidCalendar();
	
	blackMbrDetail.init();
	
	$('#pgmPopBtn').on('click', function(){
		pgmPopup();
	});
	
	 $("#dayLimitYn").change(function(){
		 if($("#dayLimitYn").is(":checked")){
			 $("#periodMm").attr("disabled",false);
	     }else{
	        $("#periodMm").attr("disabled",true);
	        $("#periodMm").val('');
	     }
	 });  
});

</script>

