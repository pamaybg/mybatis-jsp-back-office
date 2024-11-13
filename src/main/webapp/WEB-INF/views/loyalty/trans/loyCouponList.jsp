<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 회원번호 값에 걸 링크로 사용할 템플릿 -->
<script type="text/x-jsrender" id="mbrNoTemplate">
	<span style="color:#1266FF; text-decoration:underline;">{{:mbrNo}}</span>
</script>

<script type="text/x-jsrender" id="custNmTemplate">
	{{if custStatCdNm != null}}
		{{if custStatCdNm == '활성'}}
			{{:custNm}}		
		{{/if}}
		{{if custStatCdNm != '활성'}}
			{{:custStatCdNm}}
		{{/if}}	
	{{/if}}
</script>

<div class="page-title" >
    <h1>
        <spring:message code="쿠폰 이력"/>
        &gt; <spring:message code="조회"/>
    </h1>
</div>

<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="loyCouponListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="loyCouponListSearchInit_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div id="commSearchList" class="well form-horizontal well_bt5"></div>
</div>

<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" id="btnExcelDown"  text="M01218" btnFunc="excelDown" objCode="loyCouponListExcelDown_OBJ"/> <!-- 다운로드 버튼 --> <!-- btnType="save" -->
        </div>
    </div>
    <div id="purTxnHistListGrid" class="white_bg grid_bd0"></div>
</div>		 

<script type="text/javascript">
var returnPage=null;


function getCpnList(){
    var ejGridOption = {
    	serializeGridData : function(data) {
    		if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
	 	recordClick : function (args) {
            if(args.columnName=='회원번호'){
                var data = args.data.ridMbr ; // ridMbr
                goMbrDetail(data);
            }
        },
        dataUrl : '<ifvm:action name="getloyCouponList"/>',
        columns : [
        	{
        	  field : 'ofrNm', headerText : '오퍼명', headerTextAlign : 'center', textAlign : 'left', width: '200px', customAttributes :{searchable : true}
        	
          },{
              field : 'srcType', headerText : '구분', headerTextAlign : 'center', textAlign : 'center', width: '80px', customAttributes :{searchable : true}
          
          },{
      		  field : 'cpnNo', headerText : '쿠폰번호', headerTextAlign : 'center', textAlign : 'center', width: '140px', customAttributes :{searchable : true}

      	  },{
      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center', width : '100px', customAttributes : {searchable : true, index:'lm.mbr_no'}, template: '#mbrNoTemplate'

      	  } ,{
      		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'center', width : '80px', customAttributes : { index:'custNm' }, template: '#custNmTemplate'

      	  },{
      		  field : 'ofrTypeNm', headerText : '유형', headerTextAlign : 'center', textAlign : 'center' , width : '150px',customAttributes :{index : 'ofrType'}

      	  },{
      		  field : 'ofrsubTypeNm', headerText : '상세유형', headerTextAlign : 'center', textAlign : 'center' ,width : '100px', customAttributes : {index : 'ofrsubType'}

      	  },{
      		  field : 'ofrValTypeNm', headerText : '할인유형', headerTextAlign : 'center', textAlign : 'center' ,width : '80', customAttributes : {index : 'ofrValType'}
      	  
      	  },{
      		  field : 'ofrValAmt', headerText : '할인액(율)', headerTextAlign : 'center', textAlign : 'center' ,width : '80px', format: '{0:n0}' // 할인(액/률)
      		  
      	  },{
      		  field : 'cpnIssueDt', headerText : '발급일자', headerTextAlign : 'center', textAlign : 'center', width: '140px'

      	  },{
      		  field : 'cpnStateCdNm', headerText : '사용여부', headerTextAlign : 'center', textAlign : 'center', width: '90px', customAttributes : {index : 'cpnStateCd'}

      	  },{
      		  field : 'cpnLstUsedDt', headerText : '사용일자', headerTextAlign : 'center', textAlign : 'center', width: '140px'

      	  },{
      		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', width : '120px', textAlign : 'center',

      	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  },{
  		  	  field : 'ridMbr', headerText : 'ridMbr', visible : false 
  	  	  },{
  		  	  field : 'custStatCd', headerText : 'custStatCd', visible : false 
  	  	  },{
  		  	  field : 'custStatCdNm', headerText : 'custStatCdNm', visible : false 
  	  	  }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc'

        },
        radio: true,
        gridDataInit: false,
        isHorizontalScroll: true
    };

    purTxnHistListGrid = $("#purTxnHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//회원 상세 이동
function goMbrDetail(id){ // id값 : ridMbr
	//개인정보 조회 이력남기기
	$.fn.ifvmPersonalCondLogPageId("COUPON_LIST", true); // 쿠폰조회 화면 코드
    $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
     rid : id, // ridMbr을 초기화해준다
     mbrNo : ''
    }, function(result){
    	returnPage="loyCouponList";
     if(result.custTypeCd != null){
      if(result.custTypeCd == 'C'){
          //개인정보 조회 이력남기기(법인)
               qtjs.href('<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid=' + result.mbRid+'&checkBackPage='+returnPage);
        } else if(result.custTypeCd == 'I' || result.custTypeCd == 'E'|| result.custTypeCd == 'D'|| result.custTypeCd == 'O'|| result.custTypeCd == 'X') {
          //개인정보 조회 이력남기기(개인/임직원)
               qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid+'&checkBackPage='+returnPage); 
        }
     }
    });
}// goMbrDetail

//날짜데이터 형식 함수
function getFormatDate(date){
    var year = date.getFullYear();            //yyyy
    var month = (1 + date.getMonth());        //M
    month = month >= 10 ? month : '0'+month;  //month 두자리로 저장
    var day = date.getDate();                 //d
    day = day >= 10 ? day : '0'+day;          //day 두자리로 저장
    
    return  year+'-'+month+'-'+day; 	      //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}
//거래일자 startDate를 3개월 날짜값으로 초기화해주기
function startDateInitialize(){ 
	var EndDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .end_date input').val());
	
	var month = EndDate.getMonth();
	var year = EndDate.getFullYear();
	var day = EndDate.getDate();
	EndDate.setHours(0, 0, 0, 0);

	var dates = new Date();
    dates.setYear(year);
    dates.setMonth(month-2);
    dates.setDate(day);
    dates.setHours(0, 0, 0, 0);
	dates = getFormatDate(dates);
	
	$('.changeTypeAreaCode .start_date input').val(dates)
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","COUPON_LIST",gridId);
    startDateInitialize();
}

//공통 조회 호출
function optionField(){
	this.optionFields = [
        { fieldName: "ofrType", commCode: "LOY_OFR_TYPE"},
        { fieldName: "ofrsubType", commCode: "LOY_OFR_SUB_TYPE"},
        { fieldName: "ofrValType", commCode: "LOY_OFR_VAL_TYPE"},
      ]
}

// 쿠폰 이력리스트 조회 출력
function purTxnHistListSearch() {
	// 밸리데이션 플래그
	var searchValidation = true ;

	var startDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .start_date input').val());
	var EndDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .end_date input').val());
	var todayDate = new Date($.ifvGetTodayDate()); // 오늘 날짜 값 객체
	startDate.setHours(0, 0, 0, 0);
	EndDate.setHours(0, 0, 0, 0);
	todayDate.setHours(0, 0, 0, 0);

    var year = EndDate.getFullYear();
    var month = EndDate.getMonth();
    var day = EndDate.getDate();
	var d = new Date(); // 3개월 전 기준 날짜 d
    d.setHours(0, 0, 0, 0);
	
    d.setYear(year);
    d.setMonth(month-2);
    d.setDate(day); 
	
	if(startDate < d){ // 시작날짜가 3개월전을 초과 시
        alert('최대 3개월 까지만 조회가 가능합니다.');
		searchValidation = false;
		return;
	}
	
	if(startDate > todayDate){ // 시작날짜가 오늘을 초과 시
		alert('현재일까지만 조회가능합니다.');
		searchValidation = false;
		return;
	}
	
	if(EndDate > todayDate){ // 끝 날짜가 오늘을 초과 시
		alert('현재일까지만 조회가능합니다.');
		searchValidation = false;
		return;
	}
	
    $.fn.ifvmSubmitSearchCondition_NoAllSearch("commSearchList", function() {
		if ($.fn.ifvmIsNotEmpty(requestitem)) {
			purTxnHistListGrid.searchGrid({ item : requestitem });
		} else {
			alert('최소 1개의 조회조건을 입력해주세요.');
		}
	});
}

//엑셀 다운
function excelDown() {
	$.ifvExcelDn('/loyalty/trans/cpnHistListExcel.do','purTxnHistListGrid');
}

//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(purTxnHistListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = purTxnHistListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearPutTxnMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = purTxnHistListGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
        });
    }
}


$(document).ready(function(){	
	optionField();
	searchCondInit();

	getCpnList();
	
	//조회
    $('#searchCondBtn').on('click', function(){
    	// 조회 눌렀을 시 발생할 처리건 부분
    	purTxnHistListSearch();
    });
	
  //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("purTxnHistListGrid");
    });


});

</script>