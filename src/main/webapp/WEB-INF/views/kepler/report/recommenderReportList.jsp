<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 특정 추천인으로 인해 가입한 회원들정보(피추천인들) 상세로 이동하는 링크 효과 -->
<script type="text/x-jsrender" id="recommendedOneTemplate">
	<span style="color:#1266FF; text-decoration:underline;">{{:recommCount}}</span>
</script>
<!-- 회원번호 클릭 시 해당 회원 상세정보로 이동하는 링크 효과 -->
<script type="text/x-jsrender" id="mbrDetailTemplate">
	<span style="color:#1266FF; text-decoration:underline;">{{:mbrNo}}</span>
</script> 
<script type="text/x-jsrender" id="recommenderNmTemplate">
	{{if custStatCdNm == '활성'}}
		{{:recommenderNm}}		
	{{/if}}
	{{if custStatCdNm != '활성'}}
		{{:custStatCdNm}}
	{{/if}}	
</script>

<div class="page-title">
    <h1>
    	정형 Report &gt; 추천인 현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<!-- 조회 버튼 -->
            <button class="btn btn-sm" id="reportSearchBtn" objCode="recommendSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <!-- 초기화 버튼 -->
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="recommendSearchInit_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
	</div>
	<div class="form-horizontal underline top_well"	id="reportSearchCondition">
		<div class="row qt_border">
			<ifvm:inputNew type="dateTerm" startDto="startDt" endDto="endDt" startId="startDt" endId="endDt" label="추천기간" labelClass="1" conClass="4" required="true"/> 
			<ifvm:inputNew type="select" id="mbrType" names="mbrType" dto="mbrType" label="통합회원유형" labelClass="1" conClass="2" />
		 </div>
		 <div class="row qt_border">
		 	<ifvm:inputNew type="select" id="mbrMgtAttr" names="mbrMgtAttr" dto="mbrMgtAttr" label="회원관리속성" labelClass="1" conClass="2"/>
			<ifvm:inputNew type="select" id="mbrMgtAttrVal" names="mbrMgtAttrVal" dto="mbrMgtAttrVal" conClass="2" /> <!-- 회원관리속성값 -->
			<ifvm:inputNew type="text" id="mbrNm" names="mbrNm" dto="mbrNm" label="회원명" labelClass="1" conClass="2"/>
		</div>
	 </div>
</div>

<%-- 그리드 영역 --%>
<div>
    <div class="page_btn_area" >
		<!-- 조회결괴 -->
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelExportBtn" objCode="recommendExcel_OBJ">
                <spring:message code="M01218" /> <!-- 다운로드 -->
            </button>
            <button class="btn btn-sm" id="clearMaskBtn" objCode="recommendClearMask_OBJ">
                <spring:message code="마스킹해제" /> <!-- 다운로드 -->
            </button>
        </div>
    </div>
    <!-- 그리드 리스트 컨테이너 -->
   <div id="recommReportListContainer" class="white_bg grid_bd0"></div>
</div>
<div id="popupContainer" class="popup_container"></div>


<script type="text/javascript">
	var recommReportListObj = null;
	var gridDataInitFlag = false;
	// 초대회원 리스트 조회할 때 사용할 날짜값 변수
	var popupStartDt = null;
	var popupEndDt = null;
	
	
	//고객 상세 이동
	function goMbrDetail(rid,custTypeCd) {
	    if(custTypeCd == 'C'){
	        $.fn.ifvmPersonalCondLogPageId("LOY_MBR_NEW_LIST", true); //개인정보 조회 이력남기기(법인)
	        qtjs.href('<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid=' + rid);
	      } else if(custTypeCd == 'I' || custTypeCd == 'E'|| custTypeCd == 'D'|| custTypeCd == 'O'|| custTypeCd == 'X') {
	          $.fn.ifvmPersonalCondLogPageId("LOY_MBR_NEW_LIST", true); //개인정보 조회 이력남기기(개인/임직원)
	          qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + rid); 
	      }
	}
	
	// 추천자가 추천해왔던 사람들(피추천인)의 리스트 팝업 열기
	function openRecommPersonListPop(varData){
		var url = '<ifvm:url name="recommendedPersonListPop"/>';
		url += '?rcmmdNo='+varData.rcmmdNo+'&&startDt='+varData.startDt+'&&endDt='+varData.endDt;
		
		$("#popupContainer").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: url,
	        contentType: "ajax",
	        title: '피추천인 리스트',
	        width: 1000,
	        close : 'closePopup'
		});
	}
	
	// 리스트 내용을 엑셀다운로드 처리
	function recommenderListExcelDown() {
		$.ifvExcelDn('/kepler/report/getRecommListExcelDown.do','recommReportListContainer');
	}
	
	function getRecommReportList(varData) {
		var ejGridOption = {
		    	serializeGridData : function(data) {
		    		if(varData != null) {
		    			data.startDt 	 = varData.startDt;
			    		data.endDt	 	 = varData.endDt;
			    		data.mbrType 	 = varData.mbrType;
			    		data.mbrMgtAttr  = varData.mbrMgtAttr;
			    		data.mbrMgtAttrVal = varData.mbrMgtAttrVal;   
			    		data.mbrNm 	 	 = varData.mbrNm;
		    		}
		    		return data;
				},
                loadComplete : function(obj){},
				rowSelected : function(args) {},
				recordDoubleClick: function(args){
					if(args.columnName == '추천회원수') {
						var varData = {
							rcmmdNo : args.data.mbrNo,
							startDt : popupStartDt,
							endDt   : popupEndDt
						};
						openRecommPersonListPop(varData);
					}
					if(args.columnName == '회원번호') {
						// 회원상세페이지로 이동
						var ridMbr = args.data.ridMbr;
						var custTypeCd = args.data.custTypeCd;
						goMbrDetail(ridMbr,custTypeCd);
					}
				},
				recordClick : function(args){
					if(args.columnName == '추천회원수') {
						// 피추천인 리스트 확인
						var varData = {
								rcmmdNo : args.data.custNo,
								startDt : popupStartDt,
								endDt   : popupEndDt
							};
							openRecommPersonListPop(varData);
					}
					if(args.columnName == '회원번호') {
						// 회원상세페이지로 이동
						var ridMbr = args.data.ridMbr;
						var custTypeCd = args.data.custTypeCd;
						goMbrDetail(ridMbr,custTypeCd);
					}
				},
		       	dataUrl: '<ifvm:action name="getRecommReportList"/>',
                columns: [
                	  { field: 'ranking', headerText: '순위', width: '35px', textAlign : 'center' }
                	 ,{ field: 'mbrNo', headerText: '회원번호', width: '50px', textAlign : 'left', customAttributes : {index : 'mbrNo', searchable : true}, template : '#mbrDetailTemplate' }
                     ,{ field: 'custTypeCdNm', headerText: '회원유형', width: '50px', textAlign : 'center', customAttributes : {index : 'custTypeCdNm' } }
                     ,{ field: 'recommenderNm', headerText: '회원명', width: '50px',textAlign : 'center', customAttributes: {index : 'recommenderNmUnmasked' }, template: '#recommenderNmTemplate' }
                     ,{ field: 'custStatCdNm', headerText: '회원상태', width: '50px', textAlign : 'center', customAttributes : {index : 'custStatCdNm' } }
                	 ,{ field: 'tierNm', headerText: '등급', width: '50px',textAlign : 'center', customAttributes: {index : 'tierNm', searchable : true} }
                	 ,{ field: 'webId', headerText: '웹ID', width: '75px', customAttributes: { index : 'webId' } }
                	 ,{ field: 'genCdNm', headerText: '성별', width: '30px', textAlign : 'center' }
                	 ,{ field: 'hhp', headerText: '휴대폰번호', width: '50px',textAlign : 'left', customAttributes: {index : 'hhp' } }
                	 ,{ field: 'email', headerText: '이메일', width: '75px', customAttributes: { index: 'email' } }
                	 ,{ field: 'recommCount', headerText: '추천회원수', width: '50px', textAlign : 'center', template : '#recommendedOneTemplate' }
                	 ,{ field: 'accumulPointAmt', headerText: '추천 적립금(누적)', width: '60px',textAlign : 'right', format: '{0:n0}' }
                	 ,{ field: 'agreYn', headerText: 'SMS동의여부', width: '50px', textAlign : 'center' }
                	 ,{ field: 'ridMbr', headerText: 'ridM br', visible: false }
                	 ,{ field: 'custTypeCd', headerText: 'custTypeCd', visible: false }
                	 ,{ field: 'custNo', headerText: 'custNo', visible: false }
                	 ,{ field: 'custStatCd', headerText: 'custStatCd', visible: false }
                	 ,{ field: 'custStatCdNm', headerText: 'custStatCdNm', visible: false }
                ],
                requestGridData: {
                    sidx: 'ranking',
                    sord: 'asc'
                },
//                 gridDataInit: gridDataInitFlag,
                radio: true,
                //tempId: 'ifvGridSimplePageTemplete2'
	    };
		
		recommReportListObj = $("#recommReportListContainer").ifvsfGrid({ ejGridOption : ejGridOption });
	}// getRecommReportList
	
	// 추천기간 조회 필드에 값 설정
	function setCalendar() {
		var startDate = $('#startDt');
		var endDate = $('#endDt');
		//오늘날짜로 초기화
		startDate.val($.ifvGetTodayDate()); 
		endDate.val($.ifvGetTodayDate());
		// 시작일은 3달 전으로 다시 맞춰주기
		startDate.val($.ifvGetNewDate('m', -0).newDateS); // .newDateS : 날짜를 얻은후 '-'를 붙인 날짜값으로 반환  
		// ifv프레임웍의 ifvDateChecker를 호출해 적용 및 제약설정 넣어주기
		startDate.ifvDateChecker({
			maxDate : endDate
		});
		endDate.ifvDateChecker({
			minDate : startDate
		});
	}
	
	// 조회조건들(추천기간 필드) 유효성 검사
	function validateCondFields(){
		var flag = true;
		// 추천기간 필드를 검사
		if( $('#startDt').val() == null || $('#endDt').val() == null
				|| $('#startDt').val() == '' || $('#endDt').val() == '' ) {
			alert('추천기간을 완전히 입력해주세요');
			flag = false;
		}
		return flag;
	}
	
	// 조회 필드들 초기화
	function recommReportSearchInit(){
		// 추천기간 필드 원래설정대로 초기화
		$('#startDt').val($.ifvGetNewDate('m',-0).newDateS); 
		$('#endDt').val($.ifvGetTodayDate());
		// 나머지 필드들 공란으로 초기화
		$('#mbrType').val(null);
		$('#mbrMgtAttr').val(null);	
		$('#mbrMgtAttrVal').val(null);	
		$('#mbrNm').val(null);
	}// recommReportSearchInit
	
	// 조회조건에 따라 추천인 리포트를 조회하기
	function recommReportSearch() {
		if(!validateCondFields()) { // 유효성검사 결과 false
			return;
		} else { // 유효성검사 결과 true
			var varData = {
				startDt	 	   : $('#startDt').val(), 
				endDt   	   : $('#endDt').val(),
				mbrType 	   : $('#mbrType').val(),
				mbrMgtAttr     : $('#mbrMgtAttr').val(),	
				mbrMgtAttrVal  : $('#mbrMgtAttrVal').val(),	
				mbrNm		   : $('#mbrNm').val()
			};
			// 차후 초대회원 리스트를 조회할 때 날짜기준으로 쓰기 위해, 여기서 쓴 날짜값을 미리 전역에 초기화
			popupStartDt = varData.startDt;
			popupEndDt = varData.endDt;
			// gridDataInit 표식을 true 로 변경
			gridDataInitFlag = true;
			// 리스트 호출 및 그리드 구성
			getRecommReportList(varData);
		}
	}// recommReportSearch
	
	//마스크해제
	function clearMaskAction() {
	    var v_rid;
	    if ($.fn.ifvmIsNotEmpty(recommReportListObj.opt.gridControl.getSelectedRecords()[0])) {
	    	v_rid = recommReportListObj.opt.gridControl.getSelectedRecords()[0].ridMbr;
	    }
	    else {
	        alert('<spring:message code="M02219"/>');
	    }

	    if ($.fn.ifvmIsNotEmpty(v_rid)) {
	        $.ifvSyncPostJSON('<ifvm:action name="clearMaskListMbr"/>', {
	            rid: v_rid
	        },
	        function(result) {
	        	var gridObj = recommReportListObj.opt.gridControl;
	        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
	        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('recommenderNm'), result.unMaskCustNm);
	        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
	            gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('webId'), result.unMaskEmail);
	            gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('email'), result.unMaskEmailAddr);
	        });
	    }
	}


	$(document).ready(function(){
		// 추천기간 필드 초기화
		setCalendar();
		
		recommReportSearch();
		
		// select박스들에 공통코드목록들 연동
		$.fn.ifvmSetSelectOptionCommCode("mbrType", "LOY_CUST_TYPE_CD", null, null, false);
		$.fn.ifvmSetSelectOptionCommCode("mbrMgtAttr", "LOY_MBR_MGT_ATTR_CD", null, null, false);
		$.fn.ifvmSetSelectOptionCommCodeSync("mbrMgtAttrVal", "LOY_MBR_MGT_ATTR_SUB_CD", null, "mbrMgtAttr", true);
		
		// 조회 버튼 클릭 시 내용 조회 발동
		$('#reportSearchBtn').click(function(){
			recommReportSearch(); 
		});
		// 초기화 버튼 클릭 시 초기화
		$('#reportSearchInitBtn').click(function(){
			recommReportSearchInit();
		});
		// 다운로드 버튼 클릭 시
		$('#excelExportBtn').click(function(){
			recommenderListExcelDown();
		});
		
		//마스킹해제 클릭시
	    $('#clearMaskBtn').on('click', function(){
	        clearMaskAction();
	    });
	});
	
</script>

