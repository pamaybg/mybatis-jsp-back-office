<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
	#loyaltyPgm { width: 130px; }
</style>

<div class="form-horizontal underline top_well" id="oprPlcyAddForm">
	<br>
	<!-- 로열티 프로그램 -->
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="로열티프로그램"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:inputNew type="text" id="loyaltyPgmNm" names="loyaltyPgmNm" conClass="9" disabled="true"/>
			<span class="input-group-addon" style="padding:6px;" id="loyaltySearchPopBtn">
				<a><i class="fa fa-search"></i></a>
			</span>
			<ifvm:inputNew type="hidden" id="loyaltyPgmRid"/>
		</div>
	</div>
	
	<!-- 분류, 분류상세 -->
	<div class="row qt_border">
		<!-- 분류 -->
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="분류"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" id="category1" names="category1" dto="category1" required="true" />
		</div>
		<!-- 분류상세 -->
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>분류상세</label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" id="category2" names="category2" dto="category2" required="true"/>
		</div>
	</div>

	<!-- 정책명, 사용여부 -->
	<div class="row qt_border">
		<!-- 정책명 -->
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>정책명</label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" id="oprPolicy" names="oprPolicy" dto="oprPolicy" required="true"/>
		</div>
		<!-- 사용여부 -->
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>사용여부</label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" id="useYn" names="useYn" dto="tierBnftGiveCycleCd" required="true" />
		</div> 
	</div>
	
	<div class="row qt_border"></div>
	
	<!-- 설명 -->
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk"><!-- * --></span>설명</label>
		<div class="col-xs-8 control_content">
			<ifvm:inputNew type="textarea" id="description" names="description" rows="5" dto="description" required="true"/>
		</div>
	</div> 
		
</div><!-- end oprPlcyAddForm -->

<div class="pop_btn_area">
	<!-- 저장 버튼 -->
	<button class="btn btn-sm btn_gray" id="saveOprPlcy" objCode="addOperationPolicyPopSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<!-- 닫기 버튼 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="closeThisPopBtn" objCode="addOperationPolicyPopClose_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<div id="loyaltyPopContainer" class="popup_container"></div>



<script type="text/javascript">
	//준비
	var rid = null;
	var pgmNm = null;
	var ridPgm = null;
	var ctg1Cd = null;
	var ctg2Cd = null;
	var plcyCdWhenUpdate = null;
	var useYn = null;
	var contents = null;
	
	
	// 수정을 위해 기존데이터 불러오는 함수 
	function getOprPlcyPopData() {
		// 기존 내용 한번  얻어와서 화면에 뿌러주기(수정할수있도록)
		var url = '<ifvm:action name="getOperationPolicyPop"/>';
		var varData = {
				rid : mgRid	
		};
		$.ifvSyncPostJSON(url,varData, function(result) { // 서버에서 mgRid값에 해당하는 데이터 로드해서 이곳의 엘리먼트에 초기화해놓기
			$("#loyaltyPgmNm").val(result.pgmNm);
			 // 스트링 값이라 select객체안으로 안들어가고 있다.
			$("#category1").val(result.ctg1Cd); //고지 및 알림
			//종속관계가 있는 공통코드를 연결한 필드는 수정 시 로드를 할 때에, 공통코드연결작업처리를 다시 해줄 필요가 있다, 그 후 로드값을 해당각필드에 배정한다
		    $.fn.ifvmSetSelectOptionCommCodeSync("category2", "LOY_OPR_PLCY_CTG_2_CD", $("#category1").val(), "category1", true);
			$("#category2").val(result.ctg2Cd);
			$.fn.ifvmSetSelectOptionCommCodeSync("oprPolicy", "LOY_OPR_PLCY_CD", $("category2").val(), "category2", true);
			$('#oprPolicy').val(result.plcyCd);
			$("#useYn").val(result.useYn);
			$("#description").val(result.contents);
			$("#loyaltyPgmRid").val(result.ridPgm);
		});
	}//end getOprPlcyPopData
	
	// 로열티 프로그램 리스트 팝업 실핼
 	function loyaltyListPopup() {
 	    $.fn.ifvmSearchHelpOpen(null, null, 'loyaltyPopContainer', '<ifvm:url name="loyaltyListPop"/>', '로열티 프로그램');	 
 	}	
	
	// 입력 폼 유효성 검사 
	function validateForm() {
		// form 의 필드들이 모두 적절한 상태인지 확인
		if(    //$('#loyaltyPgmNm').val()
			   ( $('#loyaltyPgmRid').val() != null   &&   $('#loyaltyPgmRid').val() != '' ) 
			&& ( $('#category1').val()     != null   &&   $('#category1').val()     != '' )
			&& ( $('#category2').val()     != null   &&   $('#category2').val()     != '' )
			&& ( $('#oprPolicy').val()     != null   &&   $('#oprPolicy').val()     != '' )
			&& ( $('#useYn').val()         != null   &&   $('#useYn').val()         != '' )
			/* && ( $('#description').val()   != null   &&   $('#description').val()   != '' ) */
																							) {
			return true;
		} else {
			return false;
		}
	}//end validateForm
	
	
	// 수정 작업 시행
	function executeUpdate() {
			var url = '<ifvm:action name="updateOperationPolicy"/>';
			rid      = mgRid;
			ridPgm   = $('#loyaltyPgmRid').val();
			ctg1Cd   = $('#category1').val();
			ctg2Cd   = $('#category2').val();
			plcyCdWhenUpdate   = $('#oprPolicy').val();
			useYn    = $('#useYn').val();
			contents = $('#description').val();
			
			// 서버로 보내줄 데이터를 담는 객체 varData 선언
			var varData = {
				rid     : rid,
				ridPgm  : ridPgm,
				ctg1Cd  : ctg1Cd,
				ctg2Cd  : ctg2Cd,
				plcyCd  : plcyCdWhenUpdate,
				useYn   : useYn,
				contents: contents
			};
			
			// ifv방식으로 서버와 통신(POST방식으로 전송, JSON형태 이용)
			$.ifvSyncPostJSON(url, varData, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) { 
					alert('<spring:message code="C00094"/>'); // 저장되었습니다
					// 등록 팝업창 닫기
					updatePopClose();
				}
			}, function(result) { // 실패했을 경우
				if (result.message != null) // 메세지 있으면 메세지 표사
					alert(result.message);
				else						// 메세지도 없으면 그냥 실패 메세지 표시
					alert('<spring:message code="M02248"/>');
			});
			
			// 새로고침
			mainGridList._doAjax();
	} //end executeUpdate
	
	
	// 저장 요청 수행
	function updateOprPlcy() {
		var validation = validateForm();  // 유효성 검사 : 결과로 true/false
		
		if(!validation) {
			alert('필수항목들을 입력해주세요');	
		} else {
			executeUpdate();
		}
	} //end updateOprPlcy
	
		
	$(document).ready(function() {
		// 공통코드 연결  
		$.fn.ifvmSetSelectOptionCommCode("category1", "LOY_OPR_PLCY_CTG_1_CD", null, null, true);            // 분류  코드 연결		
		$.fn.ifvmSetSelectOptionCommCodeSync("category2", "LOY_OPR_PLCY_CTG_2_CD", null, "category1", true); // 분류상세  코드 연결		 
		$.fn.ifvmSetSelectOptionCommCodeSync("oprPolicy", "LOY_OPR_PLCY_CD", null, "category2", true);       // 정책명 코드 연결
		$.fn.ifvmSetSelectOptionCommCode("useYn", "COM_STAT_TYPE_3_CD", null, null, true);					 // 사용여부 코드 연결
		
		//$.fn.ifvmSetSelectOptionCommCodeSync("promTypeLv2Cd", "PROM_TYPE_LV2", $("#promTypeLv1Cd").val(), "promTypeLv1Cd", false);
		
		// 수정대상 값들 로드되게 한다
		getOprPlcyPopData();
		
		// 로열티 프로그램 찾기 클릭 시
		$("#loyaltySearchPopBtn").click(function(){
			loyaltyListPopup();
		});
		// 저장 버튼 클릭 시
		$("#saveOprPlcy").click(function() {
 			updateOprPlcy();
		});
		// 닫기 버튼 클릭 시
		$("#closeThisPopBtn").click(function() {
			updatePopClose();
		});

		
		
	});
</script>