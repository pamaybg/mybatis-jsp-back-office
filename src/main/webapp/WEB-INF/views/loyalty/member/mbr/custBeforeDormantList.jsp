<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 회원번호 값에 걸 링크로 사용할 템플릿 -->
<script type="text/x-jsrender" id="mbrNoTemplate">
	<span style="color:#1266FF; text-decoration:underline;">{{:mbrNo}}</span>
</script>

<script type="text/javascript">
var beforeDorMantListGrid = null;
var returnPage=null;


//공통 조회 조건 목록 설정
function beforeDorMantListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("beforeDorMantSearchList", "CUST_BEFORE_DORMANT_LIST", gridId);
    startDateInitialize();
}

//휴면예정자 날짜를 내일로
function startDateInitialize(){
	if($('.SearchCondition').find('.changeTypeAreaCode .end_date input').val()=='') {
		$('.SearchCondition').find('.changeTypeAreaCode .end_date input').val(new Date().toISOString().substring(0,10));
	}
	if($('.SearchCondition').find('.changeTypeAreaCode .start_date input').val()=='') {
		$('.SearchCondition').find('.changeTypeAreaCode .start_date input').val(new Date().toISOString().substring(0,10))
	}
	var EndDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .end_date input').val());
	var startDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .start_date input').val());

	var month = startDate.getMonth();
	var year = startDate.getFullYear();
	var day = startDate.getDate();
	startDate.setHours(0, 0, 0, 0);

	var dates = new Date();
	dates.setYear(year);
	dates.setMonth(month);
	dates.setDate(day+1);
	dates.setHours(0, 0, 0, 0);
	dates = getFormatDate(dates);

	var month2 = EndDate.getMonth();
	var year2 = EndDate.getFullYear();
	var day2 = EndDate.getDate();
	EndDate.setHours(0, 0, 0, 0);

	var dates2 = new Date();
	dates2.setYear(year);
	dates2.setMonth(month);
	dates2.setDate(day+1);
	dates2.setHours(0, 0, 0, 0);
	dates2 = getFormatDate(dates2);

	$('.changeTypeAreaCode .start_date input').val(dates)
	$('.changeTypeAreaCode .end_date input').val(dates2)
}

function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '-' + month + '-' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}

function searchValiCheck(){
	// 밸리데이션 플래그
	var searchValidation = true ;
	
	var todayDate = new Date($.ifvGetTodayDate()); // 오늘 날짜 값 객체
	//var row1StartDate =new Date($('#rows1').find('.changeTypeAreaCode .start_date input').val());// 휴면 안내 발송일

	var row1StartDate =new Date($('#rows1').find('.changeTypeAreaCode .start_date input').val());// 휴면 예정일
	var row1EndDate = new Date($('#rows1').find('.changeTypeAreaCode .end_date input').val());//휴면 예정일
	

	if(row1StartDate < todayDate){ 
		alert('휴면 예정일은 현재일 이후부터 조회 가능합니다.');
		searchValidation = false;
		return;
	}
	

	
	  $.fn.ifvmSubmitSearchCondition("beforeDorMantSearchList", function(bool) {
	        bool ? alert('최소 1개의 조회조건을 입력해주세요.') :  beforeDorMantListGrid.searchGrid({item: requestitem});
	    });
	

}

//고객 상세 이동
function goMbrDetail(id) {
    //개인정보 조회 이력남기기
    $.fn.ifvmPersonalCondLogPageId("CUST_BEFORE_DORMANT_LIST", true);
     $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
     rid : id,
     mbrNo : ''
    }, function(result){
    	returnPage="custBeforeDormantList";
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



function getBeforeDorMantListGrid() {

    var ejGridOption = {
            loadComplete : function(obj){
            },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
            	data.item = requestitem;
            }
            return data;
        },
        recordDoubleClick: function(args){
        	var mbRid = args.data.mbRid;
      	  	var custTypeCdNm = args.data.custTypeCdNm2;
      	  	// 더블클릭 시 해당 회원에 대한 상세페이지로 이동
      	  	goMbrDetail(mbRid);
        },
        recordClick : function (args) {
            if(args.columnName=='회원번호'){
                var data = args.data.mbRid ;
                goMbrDetail(data);
            }
        },
        dataUrl : '<ifvm:action name="getBeforeDorMantList"/>',
        columns : [  //custTypeCdNm2
           {
        	field: 'rid', headerText: 'rid', visible: false, // custRid 부분
        }, {
            field: 'mbRid', headerText: 'mbRid', visible: false, // mbRid 부분(상세페이지로 넘어갈때 필요)
        }, {
            field: 'custTypeCdNm2', headerText: 'custTypeCdNm2', visible: false, // custTypeCdNm2 부분(상세페이지로 넘어갈때 필요)
        }, {
            field : 'mbrNo',
            headerText : '<spring:message code="L02402"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            template : '#mbrNoTemplate',
            customAttributes : {
                index : 'lm.MBR_NO'
            }
        }, {
            field : 'custNm',
            headerText : '<spring:message code="O00164"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center
        }, {
            field : 'birtHdt',
            headerText : '<spring:message code="M02018"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lc.BIRTH_DATE'
            }
        }, {
            field : 'genCdNm',
            headerText : '<spring:message code="M02632"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lc.GEN_CD'
            }
        }, {
            field : 'hhp',
            headerText : '<spring:message code="V00280"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lc.HHP'
            }
        }, {
            field : 'userId',
            headerText : '<spring:message code="L02479"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lcli.USER_ID'
            }
        }, {
            field : 'sbscDate',
            headerText : '<spring:message code="L02807"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lm.SBSC_DATE'
            }
        }
        , {
            field : 'svcDt',
            headerText : '<spring:message code="C00178"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lcsh.svc_Dt'
            }
          }
        //, {
        //    field : 'sendEndDate',
        //    headerText : '<spring:message code="M03021"/>',
        //    headerTextAlign : 'center',
        //    textAlign : ej.TextAlign.Center,
        //    customAttributes : {
        //        index : 'lca.sendEndDate'
        //    }
        //}
        //, {
        //      field : 'expectDormancyDate',
        //      headerText : '<spring:message code="M03008"/>',
        //      headerTextAlign : 'center',
        //      textAlign : ej.TextAlign.Center,
        //      customAttributes : {
        //          index : 'dat.EXPECT_DORMANCY_DT'
        //      }
        //    }
//           , {
//                 field : 'createDate',
//                 headerText : '<spring:message code="M03009"/>',
//                 headerTextAlign : 'center',
//                 textAlign : ej.TextAlign.Center,
//                 customAttributes : {
//                     index : 'dc.CREATE_DATE'
//                 }
//               }
        ],
        
        requestGridData : {

            sidx : 'lcsh.svc_dt',
            sord : 'desc',
        },
        rowList : [ 10, 25, 50, 100 ],
        gridDataInit: false,
        radio : true,
        tempId : 'ifvGridSimplePageTemplete2'
    };
    beforeDorMantListGrid = $("#beforeDorMantListGrid").ifvsfGrid({
        ejGridOption : ejGridOption
    });
}
//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(beforeDorMantListGrid.opt.gridControl.getSelectedRecords()[0])) {
        v_rid = beforeDorMantListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskCustList"/>', {
            rid: v_rid
        },
        function(result) {
            var gridObj = beforeDorMantListGrid.opt.gridControl;
            var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
            gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
            gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
            gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('userId'), result.unMaskUserId);
        });
    }
}


$(document).ready(function() {
    beforeDorMantListSearchInit();
    getBeforeDorMantListGrid();
    
	//var row1StartDate =new Date($('#rows1').find('.changeTypeAreaCode .start_date input').val());// 휴면 안내 발송일
	//var afterMonth =new Date();
	//휴면 안내 발송일 + 30일
	//afterMonth= new Date(afterMonth.setDate(row1StartDate.getDate()+30)); //+30일
	
	//$('#rows1').find('.changeTypeAreaCode .start_date input').val(afterMonth.format('yyyy-mm-dd'));
	//$('#rows1').find('.changeTypeAreaCode .end_date input').val(afterMonth.format('yyyy-mm-dd'));
	
    
	
    // 조회
    $('#searchBeforeDorMantBtn').on('click', function() {
          searchValiCheck();
    });
    // 초기화
    $("#searchBeforeDorMantInitBtn").on('click', function() {
        beforeDorMantListSearchInit('dorMantListGrid');
    });
    //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
});
</script>

<div class="page-title" >
    <h1>
        <spring:message code="M03020"/>
        &gt; <spring:message code="M03005"/>
    </h1>
</div>

<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchBeforeDorMantBtn" objCode="mbrListSearchDorMantBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchBeforeDorMantInitBtn" objCode="mbrListSearchDorMantInitBtn_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
     <div class="well form-horizontal well_bt5" id="beforeDorMantSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
                <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="clearMaskBtn" objCode="custListMaskClear_OBJ">
                <spring:message code="L00326"/></button>
        </div>
    </div>
<!--     <div class="row"> -->
<!--             <br> -->
<!--             <div class = "col-xs-8"> -->
<%--                           <ifvm:inputNew type="dateTerm" startDto="startDt" endDto="endDt" startId="startDt" endId="endDt" required="false" label="M03008" labelClass="2" conClass="5" />  --%>
<!--                           <div class="col-xs-4 control_content"> -->
<%--                                   <ifvm:inputNew type="button" id="searchBtn"  text="M00096" objCode="" /> --%>
<!--                           </div> -->
<!--             </div> -->
<!--     </div> -->
    <div id="beforeDorMantListGrid" class="white_bg grid_bd0"></div>
 </div>

