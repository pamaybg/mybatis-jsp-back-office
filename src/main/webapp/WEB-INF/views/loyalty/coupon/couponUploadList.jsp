<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div id="pop_main_div_offer">

<div class="page-title" >
    <h1>
        트랜잭션 관리
        &gt; 쿠폰 업로드
    </h1>
</div>

<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" ><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
     <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" text="쿠폰 업로드" nuc="true" id="mbrCouponUploadBtn"  btnFunc="mbrCouponUploadFn" />
		<ifvm:inputNew type="button" text="쿠폰 업로드 샘플 파일" nuc="true" id="mbrCouponUpldSampleBtn"  btnFunc="mbrCouponUpldSampleFn" />
        </div>
    </div>
    <div id="couponUploadListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="couponUploadPop" class="popup_container"></div>
</div>

<!-- 회원가입 팝업 -->
<div id=addNewCumstContainer class="popup_container"></div>


<script type="text/javascript">
var couponUploadListGrid = null;
var newCustNo = null;
//고객 목록
function getCouponUploadList() {

  	var ejGridOption = {
        loadComplete : function(obj){
    		//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
    		//$.fn.ifvmComCondLogging("TEST_001", couponUploadListGrid.opt.data.records);
        },
      	serializeGridData : function(data) {

      	if ($.fn.ifvmIsNotEmpty(requestitem)) {
			data.item = requestitem;
        }
          return data;
      	},
      	recordDoubleClick : function(args) {
    	  	var data = args.data.rid ;
      	},
      	dataUrl : '<ifvm:action name="getCouponUploadList"/>',
      	columns: [
    	  {
		      field : 'createDate', headerText : '생성일자', headerTextAlign : 'center', textAlign : 'center' ,
	  	  },
    	  {
    		  field : 'fileName', headerText : '파일명',headerTextAlign : 'center',
    	  },{
    		  field : 'filePath', headerText : '파일경로',headerTextAlign : 'center',
    	  },
    	  {
    		  field : 'rid', headerText : 'rid', headerTextAlign : '',visible: false,
    	  }

      ],
      	requestGridData : {
    	  	sidx 	: 'createDate',
    	  	sord 	: 'desc'
      	},
      	rowList : [10,25,50,100],
      	gridDataInit: false,
      	radio: true,
      	tempId : 'ifvGridSimplePageTemplete2'
 	};

  	couponUploadListGrid = $("#couponUploadListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//고객 상세 이동

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","TEST_001");
}

//공통 조회 호출
function couponUploadListSearch() {
	$.fn.ifvmSubmitSearchCondition_NoAllSearch("commSearchList", function() {
    	if ($.fn.ifvmIsNotEmpty(requestitem)) {
    		couponUploadListGrid.searchGrid({item: requestitem});
	//     		getCustList);
    	} else {
    		alert('최소 1개의 조회조건을 입력해주세요.');
    	}
    });
}




function couponUploadPopClose() {
	couponUploadPop._destroy();
}

function mbrCouponUploadFn(){
	$("#couponUploadPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="couponUploadPop"/>',
        contentType: "ajax",
        title: '쿠폰 업로드',
        width: 1000,
        close : 'couponUploadPopClose'
    });

}

function mbrCouponUpldSampleFn(){
	var url = "/loyalty/coupon/couponExcelSampleDown.do";
	var method = "post"
	jQuery('<form action="'+ url +'" method="'+ (method||'post') +'"> </form>').appendTo('body').submit().remove();
}



$(document).ready(function() {
    //공통 조회 조건 목록 설정2
    searchCondInit();

    getCouponUploadList();

  	//조회
    $('#searchCondBtn').on('click', function(){
    	couponUploadListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("couponUploadListGrid");
    });

    //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
    });

    //회원가입
    $('#addNewMemBtn').on('click', function(){
    	addNewCustomer();
    });

});

</script>
