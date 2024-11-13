<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- [회원관리정보] 탭 화면 -->

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="특별회원 이력" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<%--<ifvm:inputNew type="button" text="신규"  id="btnAddMbrMgtInfo" btnFunc="addMbrMgtInfoPopup" objCode="mbrMgtInfoListAdd_OBJ"/> --%><!--  objCode="pntBatchRgstListNewUpload_OBJ" -->
		<!-- 수정 기능은 recordDoubleClick 시 발동한다 (하지만 주석처리를 했다. hr.noh)-->
		<ifvm:inputNew type="button" text="이력" nuc="true" id="btnMbrMgtInfoHist"  btnFunc="mbrMgtInfoHistPopup" objCode="mbrMgtInfoListHist_OBJ"/> <!--  objCode="mbrPoinGiftBtn_OBJ" -->
		<%--<ifvm:inputNew type="button" text="삭제" nuc="true" id="btnDeleteMbrMgtInfo" btnFunc="deleteMbrMgtInfo" objCode="mbrMgtInfoListDelete_OBJ"/>--%> <!--  objCode="vocPointButton_obj" -->
    </div>
</div>

<!-- 회원관리정보 리스트 그리드 컨테이너 -->
<div id="mbrMgtInfoListGridContainer" class="white_bg grid_bd0"></div>
<!-- 신규 팝업 컨테이너 / 수정 팝업 컨테이너 (공통으로 사용)-->
<div id="addMbrMgtInfoPopupContainer"></div>
<!-- 이력 팝업 컨테이너 -->
<div id="mbrMgtInfoHistPopupContainer"></div>


<script>
	// 현재 회원의 회원유형 정보
	var memberTypeCd = null;
	// 팝업 시 '신규'상황  or '수정'상황 인지에 대한 flag 변수 (true - 신규 / false - 수정)
	var newFlag = null;
	// 본 화면이 실행되기 전, 이를 실행한 이전 화면에서 탭 클릭 시 받아온 '회원에 대한 rid'값
	var memberRid = null;
	// 그리드 리스트에서 선택된 레코드항목(row)의 rid
	var rowRid = null; 
	// 회원관리정보 그리드리스트 변수
	var mbrMgtInfoListGrid = null; 
	
	// 신규 팝업 함수
	function addMbrMgtInfoPopup() {
		if(memberTypeCd == 'M3') { // 회원유형이 'M3(통합고객)'일 경우에만 기능 이용이 가능하다
			newFlag = true;  // '신규' 상황
			// 신규 팝업 호출
			$("#addMbrMgtInfoPopupContainer").ifvsfPopup({
		        enableModal : true,
		        enableResize : false,
		        contentUrl : '<ifvm:url name="addMbrMgtInfoPop"/>',
		        contentType : "ajax",
		        title : '<spring:message code="회원관리정보 등록"/>',
		        width : '1000px',
		        close : 'closeAddMbrMgtInfoPopup',
		    });	
		} else {
			alert('통합고객일 경우에만 가능합니다.');
		}
	}//end addMbrMgtInfoPopup
	
	// 수정 팝업 함수
	function updateMbrMgtInfoPopup(rid){
		// 수정 팝업은 'recordDoubleClick'시에만 무조건 실행되니, rowRid가 null인지 체크할 필요가 없다.
		newFlag = false;     // '수정'상황
		// 수정할 대상 건의 rid를 팝업호출주소에 반영(GET방식)
		var url = '<ifvm:url name="addMbrMgtInfoPop"/>' ;
		url += '?rid='+rid;
		// 팝업 호출 : 신규팝업화면과 같은 화면안에서 수정이 이뤄진다
		$("#addMbrMgtInfoPopupContainer").ifvsfPopup({
	        enableModal : true,
	        enableResize : false,
	        contentUrl : url, 
	        contentType : "ajax",
	        title : '<spring:message code="회원관리정보 수정"/>',
	        width : '1000px',
	        close : 'closeAddMbrMgtInfoPopup',
	     });
	}//end updateMbrMgtInfoPopup
	
	// 이력 팝업 함수
	function mbrMgtInfoHistPopup(){
		// 이력을 봐볼 row가 선택되었는지 체크 : rowRid
		if(rowRid == null || rowRid == '') {
			alert("이력을 확인할 항목을 선택해주세요.");
			return;
		}
		// 수정할 대상 건의 rid를 팝업호출주소에 반영(GET방식)
		var url = '<ifvm:url name="mbrMgtInfoHistPop"/>';
		url += '?recordRid='+rowRid;
		// 이력 팝업 띄우기
		$("#mbrMgtInfoHistPopupContainer").ifvsfPopup({
	        enableModal : true,
	        enableResize : false,
	        contentUrl : url,
	        contentType : "ajax",
	        title : '<spring:message code="특별회원 이력"/>',
	        width : '1000px',
	        close : 'closeMbrMgtInfoHistPopup',
	     });
	}//end mbrMgtInfoHistPopup
	
	// 항목 삭제 하기
	function deleteMbrMgtInfo() {
		// 항목선택여부 검사
		if(rowRid == null || rowRid == '') {
			alert('삭제할 항목을 선택해주세요.');
			return;
		}
		var confirmYn = confirm("해당 항목을 삭제하시겠습니까?"); // true/false 로 반환
		if(!confirmYn) {
			return;
		}
			
		// 삭제 준비
		var url = '<ifvm:action name="deleteMbrMgtInfo"/>';
		var varData = {        // 서버로 보낼 객체에 초기회
			rid : rowRid	   // 삭제처리 할 레코드의 rid를 초기화	
		};
		// 서버 통신
		$.ifvSyncPostJSON(url, varData, function(result){ // 통신 성공시
			//mbrPointHistListGrid._doAjax(); <----[Q.]
			alert('<spring:message code="삭제 되었습니다"/>');
		},function(result) { // 통신 실패시
			if($.fn.ifvmIsNotEmpty(result.message)) {
				alert(result.message);
				return;
			} else {
				if(result.message != null) {
					alert(result.message);
				} else {
					alert('<spring:message code="삭제에 실패했습니다"/>');	
				}
			}
		});
		// 새로고침: 해당 그리드부분만 부분적으로 reload처리해서 새로고침되도록 하는 처리 : 그리드변수._doAjax()
		mbrMgtInfoListGrid._doAjax();
		// 클릭한 행의 rid로서 값이 초기화되어있었던 rowRid변수를 null로 다시 초기화
		rowRid = null;
	}//end deleteMbrMgtInfo
	
	
	// '특정 회원에 대한' 회원정보관리 그리드 리스트 구성 함수
	function getMbrMgtInfoList(memberRid) {
		
	    var ejGridOption = {
	    	serializeGridData : function(data) {
	    		data.ridMbr = memberRid;
				return data;
			},
			rowSelected : function(args) {
				rowRid = args.data.rid; // 선택한 row에 대한 rid를 가져와 rowRid에 초기화 => '수정','삭제','이력 조회' 시에 사용됨.
	    	},
	    	recordDoubleClick : function(args){
	    		//rowRid = args.data.rid; // 선택한 row에 대한 rid를 가져와 rowRid에 초기화 => '수정','삭제','이력 조회' 시에 사용됨.
	    		//updateMbrMgtInfoPopup(rowRid);  // 해당 건을 더블클릭 시 수정을 실행한다.
	    	},
	        dataUrl : '<ifvm:action name="getMbrMgtInfoList"/>',
	        columns : [  
	      	  	  { field: 'attrCdNm', headerText: '회원관리 속성', width: '100px', textAlign : 'center', customAttributes: { searchable: true, index: 'attrCd' } }
	      	  	/*, { field: 'attrSubCdNm', headerText: '속성값', width: '80px', textAlign : 'center', customAttributes: { searchable: true, index: 'attrSubCdNm' } }*/
	        	, { field: 'mgtYn', headerText: '관리여부', width: '50px', textAlign : 'center', customAttributes: { searchable: false, index: 'mgtYn'} }
	        	/*, { field: 'evalCdNm', headerText: '활동평가', width: '50px', textAlign : 'center', customAttributes: { searchable: true, index: 'evalCdNm' } }*/
	        	, { field: 'createBy', headerText: '등록자', width: '80px', textAlign : 'center' }
				, { field: 'createDate', headerText: '등록일자', width: '100px', textAlign : 'center' }
				, { field: 'modifyBy', headerText: '수정자', width: '80px',  textAlign : 'center' }
	        	, { field: 'modifyDate', headerText: '수정일자', width: '100px', textAlign : 'center' }
	        	, { field: 'xExpreDt', headerText: '만료일자', width: '100px', textAlign : 'center' }
	        	, { field: 'rid', headerText: 'rid', visible: false }
	          ],
			// 그리드 데이터 정렬 조건 부여
	        requestGridData : {
	      	  sidx : 'createDate',
	      	  sord : 'desc'
	        },
	        // 그리드 데이터 초기부터 출력될지 여부 설정
	        gridDataInit: true,
	        radio: true,
	        //tempId: 'ifvGridSimplePageTemplete2'
	    };//end ejGridOption
	
	    mbrMgtInfoListGrid = $("#mbrMgtInfoListGridContainer").ifvsfGrid({ ejGridOption : ejGridOption });
	}//end getMbrMgtInfoList
	
	
	// 시행
	$(document).ready(function(){
		// 이 페이지의 이전화면(mbrDetailNewPage.jsp)에 있던, 이전 페이지 전역에 있는 mbrTypeCd변수값을 가져와 여기에서의 memberTypeCd에 초기화
		memberTypeCd = mbrTypeCd;
		// 이 페이지의 이전화면(mbrDetailNewPage.jsp)에 있던, 이전 페이지 전역에 있는 mbr_rid변수값을 가져와 여기에서의 memberRid에 초기화
		memberRid = mbr_rid;
		
		getMbrMgtInfoList(memberRid);	
	});

</script>
