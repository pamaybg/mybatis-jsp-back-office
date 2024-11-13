<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 회원번호 값에 걸 링크로 사용할 템플릿 -->
<script type="text/x-jsrender" id="mbrNoTemplate">
	<span style="color:#1266FF; text-decoration:underline;">{{:mbrNo}}</span>
</script>

<script id="custNmTemplate" type="text/x-jsrender">
	{{if custStatCdNm != null}}
		{{if custStatCdNm == '활성'}}
			{{:custNm}}		
		{{/if}}
		{{if custStatCdNm != '활성'}}
			{{:custStatCdNm}}
		{{/if}}	
	{{/if}}
</script>

<script type="text/javascript">
var NegativeAccListGrid = null;
var dataInitFlag = false; // dataInitFlag 는 디폴트로 false 로 한다
var returnPage=null;
/* 날짜 객체 받아서 문자열로 리턴하는 함수 */
function getDateStr(myDate){
    var beforeGetDay = ( myDate.getDate() < 10 ? '0' : '') +  myDate.getDate()
    return (myDate.getFullYear() + '-' + (myDate.getMonth() + 1) + '-' + beforeGetDay) ;
}
/* 오늘로부터 3개월전 날짜 반환 */
function tLastMonth(endD) {
  var d = new Date(endD)
  var monthOfYear = d.getMonth()
  d.setMonth(monthOfYear - 2)
  return getDateStr(d)
}
 
function setCalendar() {
    $('#count').val(null);

    var startDate = $('#startDt');
    var endDate = $('#endDt');
    //오늘날짜
    startDate.val($.ifvGetTodayDate());
    //오늘부터 3개월 뒤
    startDate.val($.ifvGetNewDate('m', -2).newDateS);
    
    endDate.val($.ifvGetTodayDate());

    startDate.ifvDateChecker({
     maxDate : endDate
    });

    endDate.ifvDateChecker({
     minDate : startDate
    });
}

function setCalendarInit() {
    $('#count').val(null);

    var startDate = $('#startDt');
    var endDate = $('#endDt');
    //오늘날짜
    startDate.val($.ifvGetTodayDate());
    //오늘부터 3개월 뒤
    startDate.val($.ifvGetNewDate('m', -2).newDateS);
    
    endDate.val($.ifvGetTodayDate());
}

function searchDate(){
    var startDt = $('#startDt').val();
    var endDt = $('#endDt').val();
    
    var tLastMt = tLastMonth(endDt);

    var startDte  = new Date(startDt);
    var endDte   = new Date(endDt); 
    var tLastMte = new Date(tLastMt);
            
    if(startDt != "" && endDt != ""){
        if( +startDte >= +tLastMte ){
        	// 일 적립횟수 값을 확인한다: 2 이상 입력해야 조회되도록
        	if($('#count').val() > 1) {
        		dataInitFlag = true; // gridDataInit의 설정을 true로 들어가도록 관련 flag를 조정
        		getNegativeAccListGrid(startDt, endDt);	
        	} else {
        		alert('일 적립 횟수를 2 이상으로 입력 하십시오.');
        		return;
        	}
        } else {
            alert('최대 3개월 까지만 조회가 가능합니다. ');
        }
    }else{
        alert('<spring:message code="L01859"/>');
    }
}

// 회원 상세 이동
function goMbrDetail(id){ // id값 : ridMbr
	//개인정보 조회 이력남기기
	$.fn.ifvmPersonalCondLogPageId("NEGATIVEACC_LIST", true);
    $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
     rid : id, // ridMbr을 초기화해준다
     mbrNo : ''
    }, function(result){
    	returnPage="negativeAcc";
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

// 그리드리스트 조회 및 출력
function getNegativeAccListGrid(startDt,endDt) {

    var ejGridOption = {
        serializeGridData : function(data) {
            data.strDt = $('#startDt').val();
            data.endDt = $('#endDt').val();
            if($('#count').val() != null && $('#count').val() != ''){
                data.dayCnt = $('#count').val();
            } /* else {
                $('#count').val(1);
                data.dayCnt = $('#count').val();
            } */
            return data;
        },
        recordClick : function (args) {
            if(args.columnName=='회원번호'){
                var data = args.data.ridMbr ;
                goMbrDetail(data);
            }
        },
        dataUrl : '<ifvm:action name="getNegativeAccList"/>',
        columns : [  
         {
                field: 'ridMbr', headerText: 'ridMbr', visible: false,
         }
        ,{
            field : 'apprDate',
            headerText : '<spring:message code="O00172"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lpt.APPR_DATE'
            }
        }, {
            field : 'mbrNo',
            headerText : '<spring:message code="L00690"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            template : '#mbrNoTemplate',
            customAttributes : {
                index : 'mbrNo'
            }
        }, {
            field : 'custNm',
            headerText : '<spring:message code="L00798"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            template: '#custNmTemplate',
            customAttributes : {
                index : 'custNm'
            }
        }, {
            field : 'genCdNm',
            headerText : '<spring:message code="L01143"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'genCd'
            }
        }, {
            field : 'mobilePhone',
            headerText : '<spring:message code="L01803"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'mobilePhone'
            }
        }, {
            field : 'chnlNo',
            headerText : '<spring:message code="L00287"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
            	searchable: true,
                index : 'chnlNo'
            }
        }, {
            field : 'chnlNm',
            headerText : '<spring:message code="L00288"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
            	searchable: true,
               	index : 'chnlNm'
            }
        }
        , {
            field : 'cnt',
            headerText : '<spring:message code="L02415"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'cnt'
            }
          }
        , {
            field : 'custStatCd',
            headerText : 'custStatCd',
            visible: false
          }
        , {
            field : 'custStatCdNm',
            headerText : 'custStatCdNm',
            visible: false
          }
        ],
        
        requestGridData : {
            sidx : '1',
            sord : 'desc',
        },
        rowList : [ 10, 25, 50, 100 ],
        radio : true,
        gridDataInit: dataInitFlag ? true : false
        //tempId : 'ifvGridSimplePageTemplete2'
    };
    NegativeAccListGrid = $("#NegativeAccListGrid").ifvsfGrid({
        ejGridOption : ejGridOption
    });
}
//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(NegativeAccListGrid.opt.gridControl.getSelectedRecords()[0])) {
        v_rid = NegativeAccListGrid.opt.gridControl.getSelectedRecords()[0].ridMbr;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskNegativeAccList"/>', {
            rid: v_rid
        },
        function(result) {
            var gridObj = NegativeAccListGrid.opt.gridControl;
            var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
            gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
            gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('mobilePhone'), result.unMaskHhp);
        });
    }
}

function NegativeAccExcelListFun() {
    $.ifvExcelDn('<ifvm:action name="negativeAccListExcelList"/>','NegativeAccListGrid');
}

$(document).ready(function() {
    setCalendar();
    
    getNegativeAccListGrid();
    // 조회
    $('#searchNegativeAccBtn').on('click', function() {
        searchDate();
    });
    // 초기화
    $("#searchNegativeAccInitBtn").on('click', function() {
        setCalendarInit();
    });
//     마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
    
});
</script>

<div class="page-title" >
    <h1>
        <spring:message code="O00174"/>
        &gt; <spring:message code="M03005"/>
    </h1>
</div>

<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchNegativeAccBtn" objCode="negativeAccSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchNegativeAccInitBtn" objCode="negativeAccSearchInit_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
        <div class="row">
            <br>
            <div class = "col-xs-12">
                          <ifvm:inputNew type="dateTerm" startDto="startDt" endDto="endDt" startId="startDt" endId="endDt"  label="매출일자" labelClass="1" conClass="6"  /> 
                          <ifvm:inputNew type="number" id="count" label="일 적립횟수" labelClass="1" conClass="1" />
                          <div style="font:13px NotoSans; margin:0px 0px 5px; padding:4px 5px 0px 0px;">이상</div>
            </div>
         </div>
         <br>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<!-- 마스킹해제 -->
        	<button class="btn btn-sm" id="clearMaskBtn" objCode="NegativeAccMaskClear_OBJ">
        		<spring:message code="L00326"/>
        	</button>
        	<!-- 다운로드 --> 
            <ifvm:inputNew type="button" id="NegativeAccExcelList" btnFunc="NegativeAccExcelListFun" text="M01218" objCode="NegativeAccExcelListFun_OBJ"/>
        </div>
    </div>
    <div id="NegativeAccListGrid" class="white_bg grid_bd0"></div>
 </div>

