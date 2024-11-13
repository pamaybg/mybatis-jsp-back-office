<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 회원상세화면 이동을 위한 링크에 이용되는 템플릿 -->
<script type="text/x-jsrender" id="loyPurOptionHistListTemplate">
	<a href ="javascript:void(0);" onclick="goMbrDetail('{{:ridMbr}}')"; style="color:#1266FF; text-decoration:underline;">{{:mbrNo}}</span>   
</script>

<script type="text/x-jsrender" id="custNmOptionTemplate">
	{{if mbrStatCd != null}}
		{{if mbrStatCd == 'A'}}
			{{:custNm}}		
		{{/if}}
		{{if mbrStatCd != 'A'}}
			{{:mbrStatCdNm}}
		{{/if}}	
	{{/if}}
</script>

<div class="page-title" >
    <h1>
        <spring:message code="구매 이력(품목)"/>
        &gt; <spring:message code="O00105"/>
    </h1>
</div>

<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="loyPurOptionHistSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="loyPurOptionHistSearchInit_OBJ">
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
        	<ifvm:inputNew type="button" text="M01218" id="purTxnHistExcelList" objCode="loyPurOptionHistExcelDown_OBJ"/>
        	<ifvm:inputNew type="button" text="마스킹해제" nuc="true" id="purClearMask"  btnFunc="purClearMask" objCode="loyPurHistClearMask_OBJ"/>
        	
        </div>
    </div>
    <div id="purTxnOptionHistListGrid" class="white_bg grid_bd0"></div>
</div>		 

<script type="text/javascript">

var returnPage = null;
function gePurOptionTxnHistList(){
    var ejGridOption = {
    	serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
			return data;
		},recordDoubleClick : function(args) {
    	  	var data = args.data.ridMbr ;
      	}, recordClick : function (args) {
            if(args.columnName=='회원번호'){
                var data = args.data.ridMbr ;
                goMbrDetail(data);
            }
        },
        showStackedHeader: true,
        stackedHeaderRows: [{ stackedHeaderColumns:
                [
                    {headerText: "브랜드별 등급",textAlign : 'center',column: "tierDSTNm,tierLCSNm,tierUMBNm,tierDSGNm,tierLCGNm,tierMSWNm"}
                ]
        }],
        dataUrl : '<ifvm:action name="gePurTxnOptionHistList"/>',
        columns : [ 
          {
        	  field : 'prodId', headerText : '상품코드', textAlign : 'center', customAttributes : {index : 'lp.PROD_ID', sortable: false},width:95
      	  }
          ,{
        	  field : 'prodNm', headerText : '상품명', textAlign : 'left', customAttributes : {index : 'lp.PROD_NM', sortable: false},width:400
      	  }
          ,{
                field : 'colorCd', headerText : '컬러',  textAlign : 'center', customAttributes : {index : 'lod.COLOR_CD', sortable: false},width:70
          },
            {
      		  field : 'sizeCd', headerText : '사이즈',  textAlign : 'center', customAttributes : {index : 'lod.SIZE_CD', sortable: false},width:70
      	  }
          ,{
              field : 'chnlNm', headerText : '채널명',  textAlign : 'center', customAttributes : {index : 'llc.chnlNm', sortable: false},width:130
          }
          ,{
        	  field : 'mbrNo', headerText : '회원번호', textAlign : 'center', customAttributes : {index : 'lm.mbrNo', sortable: false},width:100, template: '#loyPurOptionHistListTemplate'
      	  }
          ,{
      		  field : 'custNm', headerText : '회원명', textAlign : 'center', customAttributes : {index : 'lc.custNm', sortable: false},width: 60, template: '#custNmOptionTemplate'
      	  }
          ,{
        	  field : 'custTypeCdNm', headerText : '회원유형', textAlign : 'center', width:85, customAttributes : {index : 'lc.custTypeCd', sortable: false},width: 60
          } 
          ,{
        	  field : 'mbrTypeCdNm', headerText : '상세유형', textAlign : 'center', customAttributes : {index : 'lm.mbrTypeCd', sortable: false}, width: 70
          }
          ,{
              field : 'tierDSTNm', headerText : 'DST',headerTextAlign : 'center', textAlign : 'center' ,width: '50', customAttributes:{index : 'a.tierDST'}
          }
          ,{
              field : 'tierLCSNm', headerText : 'LCS',headerTextAlign : 'center', textAlign : 'center' ,width: '75', customAttributes:{index : 'a.tierLCS'}
          }
          ,{
              field : 'tierUMBNm', headerText : 'UMB',headerTextAlign : 'center', textAlign : 'center' ,width: '50', customAttributes:{index : 'a.tierUMB'}
          }
          ,{
              field : 'tierDSGNm', headerText : 'DSG',headerTextAlign : 'center', textAlign : 'center' ,width: '50', customAttributes:{index : 'a.tierDSG'}
          }
          ,{
              field : 'tierLCGNm', headerText : 'LCG',headerTextAlign : 'center', textAlign : 'center' ,width: '50', customAttributes:{index : 'a.tierLCG'}
          }
          ,{
              field : 'tierMSWNm', headerText : 'MSW',headerTextAlign : 'center', textAlign : 'center' ,width: '50', customAttributes:{index : 'a.tierMSW'}
          }
          ,{
        	  field : 'mbrStatCdNm', headerText : '회원상태', textAlign : 'center', width:85, customAttributes : {index : 'lm.mbrStatCd', sortable: false},width: 60
          } 
          ,{
              field : 'sbscDate', headerText : '가입일시', textAlign : 'center', customAttributes : {index : 'lm.sbscDate', sortable: false},width:150
          }          
          ,{
              field : 'birthDt', headerText : '연령', textAlign : 'center', customAttributes : {index : 'lc.BIRTH_DATE', sortable: false},width:50
          }
          ,{
              field : 'csmPrc', headerText : '정상가',  textAlign : 'right', format : '{0:n0}', customAttributes : {index : 'lod.SIZE_CD', sortable: false},width:95
          }
          ,{
              field : 'saleQty', headerText : '수량',  textAlign : 'center', format : '{0:n0}' , customAttributes : {index : 'lod.CSM_PRC', sortable: false},width:70
          }
          ,{
              field : 'totAmt', headerText : '정상가총액',  textAlign : 'right', format : '{0:n0}', customAttributes : {index : 'lo.CSM_PRC', sortable: false},width:95
          }
          ,{
              field : 'actAmt', headerText : '실결제금액',  textAlign : 'right', format : '{0:n0}', customAttributes : {index : 'lo.SALE_AMT', sortable: false},width:95
          }
          ,{
              field : 'discAmt', headerText : '총할인금액',  textAlign : 'right',  format : '{0:n0}',  customAttributes : {index : 'lo.CSM_PRC', sortable: false},width:95
          }
          ,{
              field : 'milUseAmt', headerText : '사용적립금',  textAlign : 'right', format : '{0:n0}', customAttributes : {index : 'lo.MIL_USE_AMT', sortable: false},width:90
          }
          ,{
    		  field : 'ridMbr', headerText : 'ridMbr',visible : false 
    	  }
          ,{
    		  field : 'ridOrd', headerText : 'ridOrd',visible : false 
    	  }
          ],

        requestGridData : {
      	  sidx : 'lo.CREATE_DATE',
      	  sord : 'desc'

        },
        radio: true,
        gridDataInit: false,
        isHorizontalScroll : true,
        allowResizing: true,
        tempId : 'ifvGridSimplePageTemplete2',
    };
    purTxnOptionHistListGrid = $("#purTxnOptionHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","LOY_PUR_OPTION_LIST",gridId);
    startDateInitialize();
}

function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}

//판매일자 startDate를 3개월 날짜값으로 초기화해주기
function startDateInitialize(){
	var EndDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .end_date input').val());
	
	var month = EndDate.getMonth();
	var year = EndDate.getFullYear();
	var day = EndDate.getDate();
	EndDate.setHours(0, 0, 0, 0);

	var dates = new Date();
	dates.setYear(year);
	dates.setMonth(month);
	dates.setDate(day-10);
	dates.setHours(0, 0, 0, 0);
	dates = getFormatDate(dates);
	
	$('.changeTypeAreaCode .start_date input').val(dates)
}

//공통 조회 호출
function purTxnOptionHistListSearch() {
    var searchValidation =true ;
    //판매일자 여부 확인
    if($.fn.ifvmIsEmpty($('.SearchCondition').find('.changeTypeAreaCode .start_date input').val())){
        alert('판매일자를 입력해주세요.');
        return;
    }
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
    d.setMonth(month-3);
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
              purTxnOptionHistListGrid.searchGrid({
                    item : requestitem
                });
            });
    }else{
        alert('최소 1개의 조회조건을 입력해주세요.');
        return;
    }
    
}//end purTxnHistListSearch


//고객 상세 이동
function goMbrDetail(id) { 
	//개인정보 조회 이력남기기
	$.fn.ifvmPersonalCondLogPageId("LOY_PUR_OPTION_LIST", true);
     $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
     rid : id,
     mbrNo : ''
    }, function(result){
    	returnPage="loyPurOptionHistList";
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


//마스크해제
function purClearMask() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(purTxnOptionHistListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = purTxnOptionHistListGrid.opt.gridControl.getSelectedRecords()[0].ridOrd;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearPutTxnMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = purTxnOptionHistListGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
        });
    }
}


$(document).ready(function(){	
	searchCondInit();
	
	gePurOptionTxnHistList();
	
	//조회
    $('#searchCondBtn').on('click', function(){
    	purTxnOptionHistListSearch();
    });
	
  //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("purTxnOptionHistListGrid");
    });

    //엑셀다운로드
    $('#purTxnHistExcelList').on('click', function(){
        if ($.fn.ifvmIsNotEmpty(purTxnOptionHistListGrid.opt.gridControl.model.dataSource)) {
            $.ifvDBExcelDnSeo('<ifvm:action name="purTxnOptionHistExcelList"/>','purTxnOptionHistListGrid',"loyPurOptionHistExcelDown_OBJ");
        } else {
            alert("다운로드 할 대상을 조회 해주세요.")
        }
    });
});

</script>