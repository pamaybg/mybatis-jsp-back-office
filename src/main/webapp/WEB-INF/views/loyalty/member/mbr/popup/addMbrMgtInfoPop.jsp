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

<!-- [회원관리정보 개발 ] - '신규 화면' -->

<div class="form-horizontal underline top_well" id="mbrMgtInfoAddForm">
	<br>
	<!-- 회원관리 속성 / 관리여부 -->
	<div class="row qt_border">
		<!-- 회원관리 속성  -->
		<label class="col-xs-2 control-label"><span class="asterisk"><!-- * --></span><spring:message code="회원관리 속성"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" id="attrCd" names="attrCd"/>
			<ifvm:inputNew type="hidden" id="attrCdNm"/>
			<ifvm:inputNew type="hidden" id="rid"/>
		</div>
		<!-- 관리여부 -->
		<label class="col-xs-2 control-label"><span class="asterisk"><!-- * --></span><spring:message code="관리여부"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="checkBox" id="mgtYn" names="mgtYn"/>
		</div>
	</div>
	
	<!-- 속성값 / 활동평가 -->
	<div class="row qt_border">
		<!-- 속성값 -->
		<label class="col-xs-2 control-label"><span class="asterisk"><!-- * --></span><spring:message code="속성값"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" id="attrSubCd" names="attrSubCd" dto="attrSubCd" required="true" />
			<ifvm:inputNew type="hidden" id="attrSubCdNm"/>
		</div>
		<!-- 활동평가 -->
		<label class="col-xs-2 control-label"><span class="asterisk"><!-- * --></span><spring:message code="활동평가"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" id="evalCd" names="evalCd" dto="evalCd" required="true"/>
			
			<ifvm:inputNew type="hidden" id="evalCdNm"/>
		</div>
	</div>

	<!-- 등록자 / 등록일자-->
	<div class="row qt_border" id="createByDateContainer">
		<!-- 등록자 -->
		<label class="col-xs-2 control-label"><span class="asterisk"><!-- * --></span><spring:message code="등록자"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="text" id="createBy" disabled="true"/>
		</div>
		<!-- 등록일자 -->
		<label class="col-xs-2 control-label"><span class="asterisk"><!-- * --></span><spring:message code="등록일자"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="date" id="createDate" dto="createDate" required="true" disabled="true"/>
		</div> 
	</div>
	
	<div class="row qt_border"></div>
	
	<!-- 비고 -->
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk"><!-- * --></span><spring:message code="비고"/></label>
		<div class="col-xs-8 control_content">
			<ifvm:inputNew type="textarea" id="comments" names="comments" rows="3" dto="comments" required="true"/>
			<ifvm:inputNew type="hidden" id="ridMbr"/>
			<ifvm:inputNew type="hidden" id="evalCdNm"/>
		</div>
	</div>		
</div><!-- end mbrMgtInfoAddForm -->

<div class="pop_btn_area">
	<!-- 저장 버튼 -->
	<button class="btn btn-sm btn_gray" id="btnSave" objCode="addMbrMgtInfoSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<!-- 닫기 버튼 -->
	<button class="btn btn-sm btn_gray" id="btnClose" objCode="addMbrMgtInfoClose_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<script>
	// 수정 상황 시, 수정 대상 레코드의 rid값으로 GET방식으로 날라온 rid값
	var updateTargetRid = '<%= cleanXss(request.getParameter("rid")) %>';
	// form 데이터를 담을 변수
	var attrCd = null;	
	var mgtYn = null;	
	var attrSubCd = null; 
	var evalCd = null;
	var comments = null;
	var ridMbr = null;
	// 2차 유효성검사(회원관리속성-속성값)의 결과(true/false)를 표시할 변수
	var validation2Result = null;
	
	// 입력 폼 필드의 유효성 검사 (신규/수정 시 유효성검사 대상 필드들은 모두 동일하다)
	function validateForm() {
		// 관리여부 체크박스항목이 체크되어 있는지 확인
		mgtYn = document.getElementById('mgtYn').checked; // true/false가 리턴
		if(mgtYn) {
			mgtYn = 'Y';  // Y로 초기화
		} else {
			mgtYn = 'N';  // N으로 초기화
		}
		
		// form의 필드들이 모두 적절한 상태인지 확인 (비고 (comments)란은 내용이 없어도 무방함)
		if(    ( $('#attrCd').val() 			!= null   &&   $('#attrCd').val() 		!= '' ) 		
			&& ( $('#attrSubCd').val()  		!= null   &&   $('#attrSubCd').val()	!= '' )
			&& ( $('#evalCd').val()     		!= null   &&   $('#evalCd').val()   	!= '' ) 
			&& ( mgtYn				     		!= null   &&   mgtYn			    	!= '' )  )
		{
			return true;
		} else {
			return false;
		}
	}//end validateForm
	
	// '회원관리속성 - 속성값' 중복여부 유효성 검사(테이블 내의 기존 레코드들과 비교해서)
	function checkAttrCdAttrSubCd() {
		// 화면필드의 값들을 전역 변수에 초기화
		attrCd	   = $('#attrCd').val();
		attrSubCd  = $('#attrSubCd').val();
		
		var url = '<ifvm:action name="checkAttrCdAttrSubCd"/>';
		var varData = {
			attrCd    : attrCd, 
			attrSubCd : attrSubCd
		};
		// 서버 통신
		$.ifvSyncPostJSON(url, varData, function(result){ // success(true) 시
			if($.fn.ifvmIsNotEmpty(result)) {
				validation2Result = true;			
			}
		},function(result){ // success(false) 시
			if(result.message != null) {
				//alert(result.message);
				validation2Result = false;
			} else {
				//alert('<spring:message code="동일한 회원관리속성-속성값이 이미 존재하고 있습니다."/>');
				validation2Result = false;
			}
		});
		return validation2Result;
	}//end checkAttrCdAttrSubCd
	
	// 실제로 저장 수행
	function executeNewSave() {
		var url = '<ifvm:action name="addMbrMgtInfo"/>';
		// 값이 차있는 엘리먼트들을 변수에 초기화(mgtYn은 앞서 validateForm()를 거쳐 이미 전역에서 초기화 되어있는 상태)
		attrCd	   = $('#attrCd').val();
		attrSubCd  = $('#attrSubCd').val();
		evalCd 	   = $('#evalCd').val();
		comments   = $('#comments').val();
		// 서버로 보낼 데이터 초기화
		var varData = {
				ridMbr		: memberRid,	// 첫 페이지(mbrMgtInfoList.jsp)에 있는 전역변수 memberRid값도 포함시킨다(ridMbr)
				attrCd 	  	: attrCd,
				mgtYn		: mgtYn,
				attrSubCd	: attrSubCd,
				evalCd 		: evalCd,
				comments 	: comments
		};
		// 서버 통신
		$.ifvSyncPostJSON(url, varData, function(result) { // 성공 시
			if($.fn.ifvmIsNotEmpty(result)) { 
				alert('<spring:message code="C00094"/>'); // 저장되었습니다
				// 등록 팝업창 닫기
				closeAddMbrMgtInfoPopup();
				// newFlag 변수를 null로 다시 초기화
				newFlag = null;
			}
		}, function(result) { // 실패 시
			if(result.message != null) // 메세지 있으면 메세지 표사
				alert(result.message);
			else						// 메세지도 없으면 그냥 실패 메세지 표시
				alert('<spring:message code="M02248"/>');
		});
		// 새로고침
		mbrMgtInfoListGrid._doAjax();
	}//end executeNewSave
	
	// 수정사항 저장 시행
	function executeUpdate(rid){
		// 수정 명령 url 		
		var url = '<ifvm:action name="updateMbrMgtInfo"/>';
		// 필드에 있는 데이터를 변수 안으로 초기화 (mgtYn은 앞서 validateForm()때 이미 전역에 초기화 된 상태)
	   	attrCd		 = $('#attrCd').val();
		attrSubCd 	 = $('#attrSubCd').val();
		evalCd 		 = $('#evalCd').val();
		comments 	 = $('#comments').val();
		ridMbr 		 = $('#ridMbr').val();
		// 서버로 보내줄 데이터를 담는 객체 varData 선언 
		var varData = {
				rid    		: rid,			// 수정 대상의 rid
				attrCd      : attrCd,
				mgtYn		: mgtYn,
				ridMbr		: ridMbr,		// 회원 그 자체의 rid(이전의 memberRid였던 값)
				attrSubCd 	: attrSubCd,
				evalCd 		: evalCd,
				comments 	: comments
		};
		// 서버 통신
		$.ifvSyncPostJSON(url, varData, function(result){ // 성공 시
			if($.fn.ifvmIsNotEmpty(result)) { 
				alert('<spring:message code="수정되었습니다."/>');
				closeAddMbrMgtInfoPopup(); // 팝업창 닫기
			}
			console.log('result가 리턴되지 않았음');
		}, function(result){ // 실패 시
			if(result.message != null) // 메세지 있으면 메세지 표시
				alert('error: '+result.message);
			else						// 메세지도 없으면 그냥 실패 메세지 표시
				alert('<spring:message code="M02248"/>');
		});
		// 새로고침 // 해당페이지는 여러페이지들이 앞서 물려있으므로, 그 통째로 리로드하는 것보다 자기자신탭만 '다시 클릭'되도록 하기
		mbrMgtInfoListGrid._doAjax();
		// 클릭한 행의 rid로서 값이 초기화되어있었던 rowRid변수를 null로 다시 초기화
		rowRid = null;
	}//end executeUpdate
	
	// 수정 시 수정할 항목 필드들 내용을 로드하는 함수
	function loadFieldContents(rid){ // 수정할 필드내용들을 로드해 집어넣어놓는다
		var url = '<ifvm:action name="getMbrMgtInfoBeforeUpdate"/>';
		var varData = {
				rid : rid
		};
		// 서버 통신
		$.ifvSyncPostJSON(url, varData, function(result){ // 성공 시
			// 테이블에서 받아온 mgtYn이 Y/N 이냐에 따라 true/false로 바꿔넣어준다
		    if(result.mgtYn=='Y'){
		    	mgtYn = 'Y';
		    	$("input:checkbox[id='mgtYn']").prop("checked", true);
		    } 
		    if(result.mgtYn=='N'){
		    	mgtYn = 'N';
		    	$("input:checkbox[id='mgtYn']").prop("checked", false);
		    }

		    // 리턴받아온 데이터들을 필드들에 초기화해넣는다
			$('#attrCd').val(result.attrCd);
			// attrCd필드에 동기화되어 있는 필드 attrSubCd이기 때문에, attrCd필드값 초기화 된 후 한번 더 ifvmSetSelectOptionCommCodeSync처리를 해주고 난 후, 값을 넣는다
			$.fn.ifvmSetSelectOptionCommCodeSync("attrSubCd", "LOY_MBR_MGT_ATTR_SUB_CD", null, "attrCd", true); 
			$('#attrSubCd').val(result.attrSubCd);
			$('#evalCd').val(result.evalCd);
			$('#createBy').val(result.createBy);
			$('#createDate').val(result.createDate);
			$('#comments').val(result.comments);
			// 화면에 직접적으로 표시되지는 않지만, 만약에 나중에 필요할경우를 위해 가져온 값들 hidden객체안에 초기화
			$('#rid').val(result.rid);
			$('#createBy').val(result.createBy);
			$('#ridMbr').val(result.ridMbr);
			$('#attrCdNm').val(result.attrCdNm);
			$('#attrSubCdNm').val(result.attrSubCdNm);
			$('#evalCdNm').val(result.evalCdNm);
			
		}, function(result){ // 실패 시
			if(result.messages != null) {
				alert(result.message);
			} else {
				alert('<spring:message code="수정할 데이터 로드 실패"/>');
			} 
		});
	}//end loadFieldContents
	
	//저장 요청 수행
	function saveStart() {
		// 입력form에 대한 유효성 검사 : true/false
// 		var validation1 = validateForm();
// 		var validation2 = null;
		
		/* 입력 폼에 대한 유효성 검사 
		  => 신규/수정 둘 다 공통으로 거쳐야 하는 것은 validation1 이다.
			 / validation2는 '신규'경우만 거친다  ('수정'떄는 회원관리속성,속성값이 변경되지 않으므로 validation2가 불필요)	*/
// 		if(!validation1) {
// 			alert('항목들을 제대로 입력해주세요');
// 			return;
// 		}
		// 신규  or 수정 판별
		if(newFlag == false && (updateTargetRid != null && updateTargetRid != '')) { // 수정 상황
			executeUpdate(updateTargetRid); // 수정 저장
		 } else { // 신규 상황
// 			validation2 = checkAttrCdAttrSubCd();
// 			if(!validation2) { // 회원관리속성-속성값 에 대한 유효성 검사
// 				alert("동일한 속성이 이미 존재 합니다.");
// 				return;
// 			}
			executeNewSave();  // 신규저장	
		 }
	}//end saveStart
	
	// 신규팝업창 닫기
	function closeAddMbrMgtInfoPopup(){
		addMbrMgtInfoPopupContainer._destroy();
	}

	
	$(document).ready(function() {
		// 공통코드 연결				     	
		$.fn.ifvmSetSelectOptionCommCode("attrCd", "LOY_MBR_MGT_ATTR_CD", null, null, true); // (fieldName, commCode, option, null, isFirstLowBlank);
		$.fn.ifvmSetSelectOptionCommCodeSync("attrSubCd", "LOY_MBR_MGT_ATTR_SUB_CD", null, "attrCd", true); // (fieldName, commCode, option, parField, isFirstLowBlank);
		$.fn.ifvmSetSelectOptionCommCode("evalCd", "LOY_MBR_ACT_EVAL_CD", null, null, false);
		
		// 신규/수정 중 어느 경우냐에 따라 화면을 다르게 구성한다
		if(newFlag == false && (updateTargetRid != null && updateTargetRid != '')) { // 수정 상황
			// 수정할 각 필드항목들의 기존내용들 로드
			loadFieldContents(updateTargetRid);
			// 회원관리속성필드, 속성값필드 비활성화
			$('#attrCd').attr('disabled', true);
			$('#attrSubCd').attr('disabled', true);
		} else { // 신규 상황
			$('#createByDateContainer').hide(); // 등록자,등록일자 필드 감춘다
		} 
		
	    $('#mgtYn').change(function(){
	    	if($("#mgtYn").is(":checked")==true)mgtYn = 'Y';
	    	if($("#mgtYn").is(":checked")==false)mgtYn = 'N';

		});
		
		// 저장 버튼 클릭 시
		$("#btnSave").click(function() {
 			saveStart();
		});
		// 닫기 버튼 클릭 시
		$("#btnClose").click(function() {
			closeAddMbrMgtInfoPopup();
		});

	});
	
</script>