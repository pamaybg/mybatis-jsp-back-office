<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 회원상세화면 이동을 위한 링크에 이용되는 템플릿 -->
<script type="text/x-jsrender" id="loyProdRevwHistListTemplate">
	<a href ="javascript:void(0);" onclick="goMbrDetail('{{:ridMbr}}')"; style="color:#1266FF; text-decoration:underline;">{{:mbrNo}}</span>   
</script>

<script id="subjectDataTemplate" type="text/x-jsrender">
{{if subject != null}}
	{{if subject.length > 20}}
		{{:subject.substring(0,20)+'...'}}
	{{/if}}
	{{if subject.length <= 20}}
		{{:subject}}
	{{/if}}
{{/if}}
</script>

<script type="text/x-jsrender" id="custNmProdRevwTemplate">
	{{if custStatCd != null}}
		{{if custStatCd == 'A'}}
			{{:custNm}}		
		{{/if}}
		{{if custStatCd != 'A'}}
			{{:custStatCdNm}}
		{{/if}}	
	{{/if}}
</script>

<div class="page-title" >
    <h1>
        <spring:message code="O00214"/>
        &gt; <spring:message code="O00105"/>
    </h1>
</div>

<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="mbrListsearchCondBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="mbrListsearchCondInitBtn_OBJ">
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
        	<ifvm:inputNew type="button" text="상세보기" nuc="true" id="prodRevwDetailPopBtn" objCode="loyProdRevwHistClearMask_OBJ"/>
        	<ifvm:inputNew type="button" text="M01218" id="prodRevwHistExcelList" objCode="loyProdRevwHistExcelDown_OBJ"/>
        	<ifvm:inputNew type="button" text="마스킹해제" nuc="true" id="prodRevwClearMask"  btnFunc="prodRevwClearMask" objCode="loyProdRevwHistClearMask_OBJ"/>
        </div>
    </div>
    <div id="prodRevwHistListGrid" class="white_bg grid_bd0"></div>
</div>		 
   
<div id="prodRevwDetailPopup"></div>
<script type="text/javascript">

var returnPage = null;
function geProdRevwHistList(){
    var ejGridOption = {
    	serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
			return data;
		},recordDoubleClick : function(args) {
    	  	var data = args.data.ridMbr ;
    	  	var dataArr = prodRevwHistListGrid.opt.gridControl.getSelectedRecords();
    	  	prodRevwDetailPop(dataArr.rid);
      	}, recordClick : function (args) {
            if(args.columnName=='회원번호'){
                var data = args.data.ridMbr ;
                goMbrDetail(data);
            }
        },rowSelected : function(args) {
            rid = args.data.rid;
        },
        dataUrl : '<ifvm:action name="geProdRevwHistList"/>',
        columns : [ 
          {
        	  field : 'rDate', headerText : '등록일', textAlign : 'center', customAttributes : {index : 'T1.R_DATE', sortable: false},width:130
      	  }
          ,{
        	  field : 'mbrNo', headerText : '회원번호', textAlign : 'center', customAttributes : {index : 'T1.MSEQ', sortable: false},width:80, template: '#loyProdRevwHistListTemplate'
      	  }
          ,{
        	  field : 'custNm', headerText : '회원명', textAlign : 'left', customAttributes : {index : 'T6.CUST_NM', sortable: false},width:90
      	  }
          ,{
              field : 'hhp', headerText : '전화번호', textAlign : 'left', customAttributes : {index : 'T6.HHP', sortable: false},width:90
          }
          ,{
        	  field : 'mbrTypeCdNm', headerText : '회원유형', textAlign : 'center', width:85, customAttributes : {index : 'T5.MBR_TYPE_CD', sortable: false},width: 60
          }  
          ,{
        	  field : 'sbscTypeCdNm', headerText : '가입유형', textAlign : 'center', width:85, customAttributes : {index : 'T5.SBSC_TYPE_CD', sortable: false},width: 60
          } 
          ,{
        	  field : 'custStatCdNm', headerText : '상태', textAlign : 'center', width:85, customAttributes : {index : 'T6.CUST_STAT_CD', sortable: false},width: 60
          }
          ,{
        	  field : 'reviewTypeCdNm', headerText : '상품구분', textAlign : 'center', width:105, customAttributes : {index : 'T1.REVIEW_TYPE_CD', sortable: false}
          },
          {
        	  field : 'catNm', headerText : '카테고리명',width:'90px', headerTextAlign : 'center', textAlign: 'left', customAttributes : {index : 'T7.CAT_NM',searchable : true}
          },
          {
        	  field : 'parCatNm', headerText : '상위카테고리명',width:'110px', headerTextAlign : 'center', textAlign: 'center', customAttributes : {index : 'T8.CAT_NM',searchable : true}
          },
          {
      		  field : 'mmGroup', headerText : '글로벌 카테고리',  textAlign : 'center', customAttributes : {index : 'mmGroup', sortable: false},width:140
      	  },
          {
        	  field : 'prodNo', headerText : '자재코드',width:'90px', headerTextAlign : 'center', textAlign: 'center', customAttributes : {index : 'T2.PROD_ID',searchable : true}
          },
          {
        	  field : 'goodsCode', headerText : '상품코드',width:'90px', headerTextAlign : 'center', textAlign: 'center', customAttributes : {index : 'lpx.GOODS_CODE',searchable : true}
          }
          ,{
              field : 'prodNm', headerText : '상품명',width:'260px',textAlign : 'left', headerTextAlign : 'center',customAttributes : {index : 'T2.DESC1',searchable : true}
          }
          ,{
              field : 'subject', headerText : '제목',width:'230px',textAlign : 'left', headerTextAlign : 'center',customAttributes : {index : 'T1.SUBJECT',searchable : true} , template: '#subjectDataTemplate'
          }
          ,{
              field : 'score', headerText : '점수',width:'40px',textAlign : 'center', headerTextAlign : 'center',customAttributes : {index : 'T1.SCORE'}
          }
          ,{
              field : 'uploadImgPathYn', headerText : '포토여부',width:'60px',textAlign : 'center', headerTextAlign : 'center',customAttributes : {index : 'T1.UPLOAD_IMG_PATH'}
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
        allowResizing: true,
        isHorizontalScroll : true,
        tempId : 'ifvGridNoneLeftTemplete'
    };
    prodRevwHistListGrid = $("#prodRevwHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


   



//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","PROD_REVW_LIST",gridId);
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
	dates.setMonth(month-2);
	dates.setDate(day);
	dates.setHours(0, 0, 0, 0);
	dates = getFormatDate(dates);
	
	$('.changeTypeAreaCode .start_date input').val(dates)
}

//공통 조회 호출
function prodRevwHistListSearch() {
    
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
        	  prodRevwHistListGrid.searchGrid({
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
	$.fn.ifvmPersonalCondLogPageId("PROD_REVW_LIST", true);
     $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
     rid : id,
     mbrNo : ''
    }, function(result){
    	returnPage="loyProdRevwHistList";
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
function prodRevwClearMask() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(prodRevwHistListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = prodRevwHistListGrid.opt.gridControl.getSelectedRecords()[0].ridMbr;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskListMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = prodRevwHistListGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
        });
    }
}

function prodRevwDetailPop(rid){
	$("#prodRevwDetailPopup").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="prodRevwDetailPop"/>'+ '?rid=' + rid,
        contentType : "ajax",
        title : "<spring:message code="상품평 리뷰 상세"/>",
        width : '1000px',
        close : 'prodRevwDetailPopClose',
     });
}

function prodRevwDetailPopClose(){
	prodRevwDetailPopup._destroy();
}



$(document).ready(function(){	
	searchCondInit();
	
	geProdRevwHistList();
	
	//조회
    $('#searchCondBtn').on('click', function(){
    	prodRevwHistListSearch();
    });
	
  //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("prodRevwHistListGrid");
    });
    
   //엑셀다운로드
    $('#prodRevwHistExcelList').on('click', function(){
    	$.ifvDBExcelDnSeo('<ifvm:action name="prodRevwHistExcelList"/>','prodRevwHistListGrid',"loyProdRevwHistExcelDown_OBJ");
    });
    
  //상세
  //상세
	$("#prodRevwDetailPopBtn").on('click', function() {
		if(rid == null){
			alert("목록을 선택하세요.")
		}else{
			prodRevwDetailPop();
		}
	});
     
});

</script>