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
			<ifvm:inputNew type="hidden" id="loyaltyPgmNo"/> 
		</div>
		<!-- <input type="button" value="testBtn" onClick="alert('mgRid: '+mgRid);"/> -->
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
	var pgmNm = null;
	var ridPgm = null;
	var ctg1Cd = null;
	var ctg2Cd = null;
	var plcyCdWhenAdd = null;
	var useYn = null;
	var contents = null;
	
	
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
	
	
	// 실제로 저장 수행
	function executeSave() {
		// 전역에 있는 newFlag변수 보고 신규/수정 상황인지 판별
		var url = '<ifvm:action name="addOperationPolicy"/>';
		
		// 값이 차있는 엘리먼트들을 변수에 초기화
		//pgm_nm = $('#loyaltyPgmNm').val();
		ridPgm = $('#loyaltyPgmRid').val();
		ctg1Cd = $('#category1').val();
		ctg2Cd = $('#category2').val();
		plcyCdWhenAdd = $('#oprPolicy').val();
		useYn = $('#useYn').val();
		contents = $('#description').val();			 
		
		
		// 서버로 보내줄 데이터를 담는 객체 varData 선언
		var varData = null;
		varData = {
			//pgm_nm : this.pgn_nm,
			ridPgm : ridPgm,
			ctg1Cd : ctg1Cd,
			ctg2Cd : ctg2Cd,
			plcyCd : plcyCdWhenAdd,
			useYn : useYn,
			contents: contents
		};
								
		// ifv방식으로 서버와 통신(POST방식으로 전송, JSON형태 이용)
		$.ifvSyncPostJSON(url, varData, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) { 
				alert('<spring:message code="C00094"/>'); // 저장되었습니다
				// 등록 팝업창 닫기
				addPopClose();

				// newFlag 변수를 다시 디폴트로 false화
				newFlag = false;
			}
		}, function(result) { // 실패했을 경우
			if (result.message != null) // 메세지 있으면 메세지 표사
				alert(result.message);
			else						// 메세지도 없으면 그냥 실패 메세지 표시
				alert('<spring:message code="M02248"/>');
		});
		
		// 새로고침
		mainGridList._doAjax();
		/* (아래 처리 없이도, loadComplete에서 로드컴플리트 시 index[0] 쨰의 레코드 선택 코드로 인해 하위그리드들은 자동으로 적절하게 출력된다)
		callSubGrid1List(null);       // 서브그리드1(정책속성값 그리드) 처음 로드
		callSubGrid2List(null, null); // 서브그리드2(세부사항 그리드) 처음 로드 */
	}//end executeSave
	
	
	// 저장 요청 수행
	function saveOprPlcy() {
		var validation = validateForm();  // 유효성 검사 : 결과로 true/false
		
		if(!validation) {
			alert('필수항목들을 입력해주세요');	
		} else {
			executeSave();
		}
	} //end saveOprPlcy
	

	// 로열티 프로그램 리스트 팝업 실핼
 	function loyaltyListPopup() {
 	    //var targetFields = { name : "loyaltyPgm", rid : "offerRid" };
 	    $.fn.ifvmSearchHelpOpen(null, null, 'loyaltyPopContainer', '<ifvm:url name="loyaltyListPop"/>', '로열티 프로그램');	 
 	}	

	
	
	$(document).ready(function() {
		// 공통코드 연결					//  (적용대상필드id값 , 적용할 공통코드값, ?,?, 활성화여부)
		$.fn.ifvmSetSelectOptionCommCode("category1", "LOY_OPR_PLCY_CTG_1_CD", null, null, true);            // 분류  코드 연결
		// 종속관계 공통코드 연결                               //(적용대상필드id값 , 적용할 공통코드값, ?, 상위필드의val()값, 상위필드id값, 활성화여부)
		$.fn.ifvmSetSelectOptionCommCodeSync("category2", "LOY_OPR_PLCY_CTG_2_CD", null, "category1", true); // 분류상세  코드 연결		 
		$.fn.ifvmSetSelectOptionCommCodeSync("oprPolicy", "LOY_OPR_PLCY_CD", null, "category2", true);       // 정책명 코드 연결
		$.fn.ifvmSetSelectOptionCommCode("useYn", "COM_STAT_TYPE_3_CD", null, null, true);					 // 사용여부 코드 연결
		
		// 로열티 프로그램 찾기 클릭 시
		$("#loyaltySearchPopBtn").click(function(){
			loyaltyListPopup();
		});
		// 저장 버튼 클릭 시
		$("#saveOprPlcy").click(function() {
 			saveOprPlcy();
		});
		// 닫기 버튼 클릭 시
		$("#closeThisPopBtn").click(function() {
			addPopClose();
		});

	});
	
</script>