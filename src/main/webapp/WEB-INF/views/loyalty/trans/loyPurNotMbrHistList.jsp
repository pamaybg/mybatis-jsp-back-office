<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page-title" >
    <h1>
        <spring:message code="비회원 구매 이력"/>
        &gt; <spring:message code="조회"/>
    </h1>
</div>

<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="loyPurNotMbrHistSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="loyPurNotMbrHistSearchInit_OBJ">
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
        	<!-- 마스킹해제 -->
        	<ifvm:inputNew type="button" text="M01218" id="purTxnHistExcelList"  btnFunc="purTxnHistExcelList" objCode="loyPurNotMbrExcelDown_OBJ"/>
       </div>
    </div>
    <div id="purTxnNotMbrHistListGrid" class="white_bg grid_bd0"></div>
</div>		 

<script type="text/javascript">

function gePurTxnHistList(){
    var ejGridOption = {
    	serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
			return data;
		},
        dataUrl : '<ifvm:action name="getPurNotMbrTxnHistList"/>',
        columns : [
          {
        	  field : 'sellDate', headerText : '판매일자', textAlign : 'center', customAttributes : {index : 'sellDate', sortable: false},width:130
      	  }
          ,{
        	  field : 'srcTypeNm', headerText : '구분', textAlign : 'center', customAttributes : {index : 'srcType', sortable: false},width:80
      	  }
          ,{
              field : 'chnlNm', headerText : '채널명', textAlign : 'center', customAttributes : {index : 'chnlNm', sortable: false},width:140
          }
          ,{
              field : 'billNo', headerText : '주문번호',  textAlign : 'center', customAttributes :{index : 'billNo', sortable: false},width:170
          }
          ,{
      		  field : 'sellTypeCdNm', headerText : '판매구분',  textAlign : 'center', customAttributes : {index : 'sellTypeCd', sortable: false},width:73
      	  }
          ,{
              field : 'sellAmt', headerText : '판매금액',  format : '{0:n0}', textAlign : 'right', customAttributes : {index : 'sellAmt', sortable: false},width:83
          }
          ,{
              field : 'discntAmt', headerText : '할인금액',  textAlign : 'right', format : '{0:n0}', customAttributes : {index : 'discntAmt', sortable: false},width:83
          }
          ,{
              field : 'settleAmt', headerText : '최종결제금액',  textAlign : 'right',  format : '{0:n0}',  customAttributes : {index : 'settleAmt', sortable: false},width:83
          }
//           ,{
//       		  field : 'createDate', headerText : '등록일자',  textAlign : 'center', customAttributes : {index : 'llo.CREATE_DATE'},width:137
//       	  }
          ,{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
          ,{
    		  field : 'ridMbr', headerText : 'ridMbr',visible : false 
    	  }
          ,{
              field : 'ridCus', headerText : 'ridMbr',visible : false 
          }
          ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc'

        },
        radio: true,
        gridDataInit: false,
        isHorizontalScroll : true,
        allowResizing: true,
        tempId : 'ifvGridNoneLeftTemplete'

    };

    purTxnNotMbrHistListGrid = $("#purTxnNotMbrHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","LOY_PUR_NOTMBR_HIST_LIST",gridId);
    searchInitialize();
    
}

function searchInitialize(){
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

// 날짜 조회조건 빈칸여부 체크 로직
function searchBlankCheck(){
	var blankCheck=false;
	var searchCondSize= $('.changeTypeAreaCode').size();
	var displayRowNum=[];
	var txnCheck=0;
	$($('.row.qt_border.SearchCondition')).each(function(index,item){
		if($("#rows"+index).css("display") !="none"){
			
			if($("#rows"+index).children(".changeTypeAreaCode").find('.smart-form').size()!=0){ //date
				if($("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_frt.start_date").children(".smart-form").children(".input").children("input").val() !=""
					&& $("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_scd.end_date").children(".smart-form").children(".input").children("input").val() !="" ){
					txnCheck++;
				}
			}
			if($("#rows"+index+ " .searchTextVal option:selected").attr('joinsrcclm')=="TXN_NUM"){
				if($("#rows"+index+ " .changeTypeAreaCode input").val()!=""){
					txnCheck++;
				}
			}
		}
	})  //빈값 처리
	if(txnCheck>0){
		blankCheck=true;
	}
	return blankCheck;
}

//공통 조회 호출
function purTxnHistListSearch() {
    
    var searchValidation =true ;

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
    
    if(searchValidation){
          $.fn.ifvmSubmitSearchCondition("commSearchList", function() {
              purTxnNotMbrHistListGrid.searchGrid({
                    item : requestitem
                });
            });
    }else{
        alert('최소 1개의 조회조건을 입력해주세요.');
        return;
    }
	
}//end purTxnHistListSearch


function purTxnHistExcelList() {
	$.ifvExcelDn('<ifvm:action name="purTxnNotMbrHistExcelList"/>','purTxnNotMbrHistListGrid');
}


$(document).ready(function(){	
	searchCondInit();
	
	gePurTxnHistList();
	
	//조회
    $('#searchCondBtn').on('click', function(){
    	purTxnHistListSearch();
    });
	
  //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("purTxnNotMbrHistListGrid");
    });


});

</script>