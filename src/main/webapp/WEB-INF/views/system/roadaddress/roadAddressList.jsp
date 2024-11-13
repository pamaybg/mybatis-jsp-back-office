<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
        <spring:message code="도로명 주소 관리"/>
        &gt; <spring:message code="조회"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
    	<!-- 조회조건 -->
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<!-- 조회 버튼-->
            <button class="btn btn-sm" id="searchCondBtn" objCode="searchCondBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <!-- 초기화 버튼 -->
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="searchCondInitBtn_OBJ" >
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <!-- 시도,시군구,법정동명 등 조회조건 담는 div 컨테이너 -->
    <div class="well form-horizontal well_bt5" id="roadAddressSearchBox" >
    </div>
</div>

<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        
        <div class="col-xs-5 searchbtn_r">
        	<!-- 주소 업로드 버튼-->
        	<button class="btn btn-sm" id="uploadAddressBtn" objCode="uploadAddressBtn_OBJ"> <!-- objCode="channalListNewPageAddChnlBtn_OBJ" -->
                <spring:message code="O00165"/></button>
            <!-- 양식 다운로드 버튼-->
            <button class="btn btn-sm" id="downloadTempleteBtn" objCode="downloadTempleteBtn_OBJ"> <!-- objCode="channalListNewPageRemoveChnlBtn_OBJ" -->
                <spring:message code="O00166"/></button>
        </div>
    </div>
    <!-- 주소엑셀업로드 팝업 창 컨테이너 -->
    <div id="roadAddressExcelUploadPop" class="popup_container"></div>
   
   	<div>
   		<!-- 도움말   --> 
		<div id="helpWord">
   			<p style="padding:5px 0 0 20px; color:gray;">
   				*파일업로드시 사용되는 법정동코드 데이터는 행정표준코드관리시스템 (https://www.code.go.kr/stdcode/regCodeL.do) -> 법정동코드전체자료 에서 다운 받을 수 있습니다.
   			</p>
   		</div>
   		
   		<!-- 법정동 주소 업로드 조회 결과 -->
   		<div id="roadAddressListGrid" class="white_bg grid_bd0"></div>
   	</div>
    
</div>


<script type="text/javascript">

	// ejGridOption의 설정내용을 다 받아 그리드화면 화 될 객체 roadAddressListGrid객체는 전역으로 빼놓아야 한다.
	var roadAddressListGrid = null;
	
	function getRoadAddressList(){
	    var ejGridOption = {
	    	//초기 설정값되어있는걸 세팅
	    	serializeGridData : function(data) { 
				if ($.fn.ifvmIsNotEmpty(requestitem)) {
					data.item = requestitem;
				}
				return data;
			},
	   		recordDoubleClick : function (args) {
	   			/* var data = args.data.rid;
	   	    	custDetail(data); */
	        },
	        dataUrl : '<ifvm:action name="getRoadAddressList"/>',
			// 화면에 출력될 칼럼들 속성
	        columns : [
	        	 { // 시도
		    	  	field : 'sido', headerText : '시도', headerTextAlign : 'center', width : '30px', textAlign : 'center', customAttributes : {index : 'bc.sido', searchable : true}
	        	}      	 
	        	,{ // 시군구
		    	  	field : 'sigungu', headerText : '시군구', headerTextAlign : 'center', width : '30px', textAlign : 'center', customAttributes : {index : 'bc.sigungu', searchable : true}
		      	}
	        	,{ // 법정동명
	    		  	field : 'code_nm', headerText : '법정동명', headerTextAlign : 'center', width : '100px', customAttributes : {searchable : true} 
	    	    }
	        	,{ // 법정동코드
	      		  	field : 'code', headerText : '법정동코드', headerTextAlign : 'center', width : '30px', textAlign : 'center'
	      	    }
	        	,{ // 폐지여부
	    		  	field : 'del_flag', headerText : '폐지여부', headerTextAlign : 'center', width : '50px', textAlign : 'center'
	    	    }
	        	,{ //RID
	    		  	field : 'rid', headerText : 'rid', visible : false 
	    	    }
	        ],	
	        
	        requestGridData : {
	      	  rows : 10,
	      	  sidx : 'bc.sido, bc.sigungu',  // 'bc.code'  /'bc.sido, bc.sigungu' // sql문에서 무슨칼럼을 기준으로 order by 해 줄 건지 지정
	      	  sord : 'asc', // order by 의 오름차순(asc)
	      	  _search : false	
	        },
	        
	        gridDataInit: true, // 처음 화면 들가자마자 데이터를 바로 보여줄것인지 or 아닌지 를 지정하는 설정
	        radio: true, // 라디오 선택버튼 둘건지 지정
	        tempId : 'ifvGridSimplePageTemplete' // 본문화면에서 '검색창'이 딸려 있지 않은 템플릿(심플템플릿)을 사용한다고 지정 // ifvGridSimplePageTemplete2 는 검색창이 딸려있음(이게 default)
	        		
	    };
		// 처리결과를 담을 div 컨테이너(#roadAddressListGrid)에 결과를 담는다
	    roadAddressListGrid = $("#roadAddressListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	}

	
	//'공통 조회 조건' 목록 설정 : "iCIGIANL에 등록되어 있는 특정 프로그램과 매핑되어 있는 '공통조회조건(검색조건)'을 가져온다
	function searchCondInit(gridId) { 
	    $.fn.ifvmSetCommonCondList("roadAddressSearchBox", "ROAD_ADDRESS_MGM", gridId); // 여기서 이 gridId는 초기화 관련된 것 
	}
	// 조회조건에서 설정한 조건대로 검색을 수행한다
	function roadAddressListSearch() {
		$.fn.ifvmSubmitSearchCondition("roadAddressSearchBox", function() {
			roadAddressListGrid.searchGrid({item : requestitem
			});
		});
	}
	
	// 클릭시 엑셀업로드 용 모달팝업 뜸
	function excelUploadRoadAddress() {
		$("#roadAddressExcelUploadPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="roadAddressExcelUploadPop"/>',
	        contentType: "ajax",
	        title: '엑셀 업로드',
	        width: 600,
	        close : 'roadAddressExcelUploadClosePop' // close마크버튼(X버튼)눌렀을 때
		});
	}
	
	// 엑셀업로드용 모달팝업 종료 하기
	function roadAddressExcelUploadClosePop() {
		roadAddressExcelUploadPop._destroy();
	}
	
	//샘플양식 다운로드
	function excelSampleRoadAddress(){
		var data = {}; // data란 배열변수 선언
		data.offerType = "ROAD_ADDR"; // 배열변수 data안에 offerType 객체 선언 후 'ROAD_ADDR'키워드를 담는다 
				 
		$.fn.ifvmBatchRgstExcelSampleDown2(data); // 양식 다운로드 함수 호출
	}

	//샘플데이터 다운로드
	$.fn.ifvmBatchRgstExcelSampleDown2 = function(data) {
		var inputs = "";
		var url = "/system/batchRgst/excelSampleDown2.do";
		var method = "post"
			//data를 입력받음
			if( data ){
				if ($.fn.ifvmIsNotEmpty(data.offerType)) {
					inputs += '<input type="hidden" name="offerType" value="'+ data.offerType +'" />';

					// request를 보낸다.
					jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
					.appendTo('body').submit().remove();
				}
			};
	};
		
	$(document).ready(function() {
		getRoadAddressList(); // 페이지 나오자마자 도로명주소데이터 리스트 출력
		searchCondInit(); // 조회조건부에 공통코드 연동
			    	 
	    // 조회
	    $('#searchCondBtn').on('click', function(){
	    	roadAddressListSearch();
	    });
	
	    // 초기화
	    $("#searchCondInitBtn").on('click', function(){
	    	searchCondInit("roadAddressListGrid");
	    });
	
	    // 주소 업로드 버튼 클릭
	    $('#uploadAddressBtn').on('click', function(){
	    	excelUploadRoadAddress(); // 주소 업로드 팝업창 오픈 함수
	    });
	    
	    // 양식 다운로드 버튼클릭  
	    $('#downloadTempleteBtn').on('click', function(){
	    	excelSampleRoadAddress(); // 엑셀 샘플 양식 다운로드 함수
	    });
	   
	});

</script>