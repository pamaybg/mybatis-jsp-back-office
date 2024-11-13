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
var dorMantListGrid = null;
var returnPage =null;

//공통 조회 조건 목록 설정
function dorMantListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("dorMantSearchList", "CUST_DORMANT_LIST", gridId);
    searchInitialize();
}
// 공통 조회 호출
function dorMantListSearch() {
	
   $.fn.ifvmSubmitSearchCondition("dorMantSearchList", function(bool) {
        bool ? alert('최소 1개의 조회조건을 입력해주세요.') :  dorMantListGrid.searchGrid({item: requestitem});
    });
}

function searchInitialize(){
    //$(".datepicker").val("");
}

//회원 상세 이동
function goMbrDetail(id){ // id값 : mbRid
	//개인정보 조회 이력남기기
	$.fn.ifvmPersonalCondLogPageId("CUST_DORMANT_LIST", true); // 휴면 회원 화면 코드 : CUST_DORMANT_LIST
    $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
     rid : id, // ridMbr을 초기화해준다
     mbrNo : ''
    }, function(result){
    
    returnPage="custDormantList";
     if(result.custTypeCd != null){
      if(result.custTypeCd == 'C'){
          //개인정보 조회 이력남기기(법인)
               qtjs.href('<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid=' + result.mbRid +'&checkBackPage='+returnPage);
        } else if(result.custTypeCd == 'I' || result.custTypeCd == 'E'|| result.custTypeCd == 'D'|| result.custTypeCd == 'O'|| result.custTypeCd == 'X') {
          //개인정보 조회 이력남기기(개인/임직원)
               qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid+'&checkBackPage='+ returnPage); 
        }
     }
    });
}// goMbrDetail


function getDorMantListGrid() {

    var ejGridOption = {
            loadComplete : function(obj){
            },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        recordClick : function (args) {
            if(args.columnName=='회원번호'){
                var data = args.data.mbRid ;
                goMbrDetail(data);
            }
        },
        dataUrl : '<ifvm:action name="getDorMantList"/>',
        columns : [  
        {
            field : 'mbrNo',
            headerText : '<spring:message code="L02402"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            template: '#mbrNoTemplate',
            customAttributes : {
                index : 'lm.MBR_NO'
            }
        },{
            field : 'mbrTypeCdNm',
            headerText : '<spring:message code="회원유형"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lm.MBR_TYPE_CD'
            }
        },{
            field : 'custTypeCdNm',
            headerText : '<spring:message code="고객유형"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lc.CUST_TYPE_CD'
            }
        }, {
            field : 'custNm',
            headerText : '<spring:message code="O00164"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center
        }
        , {
            field : 'hhp',
            headerText : '<spring:message code="V00280"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'dc.HHP'
            }
        }, {
            field : 'userId',
            headerText : '<spring:message code="L02479"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'dcli.USER_ID'
            }
        }, {
            field : 'sbscDate',
            headerText : '<spring:message code="L02807"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lm.SBSC_DATE'
            }
        }, {
            field : 'drmncyDate',
            headerText : '<spring:message code="M03006"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lc.DRMNCY_DATE'
            }
          }
        ],
        
        requestGridData : {
            sidx : '1',
            sord : 'desc',
        },
        rowList : [ 10, 25, 50, 100 ],
        gridDataInit: false, // 추가
        radio : true,
        tempId : 'ifvGridSimplePageTemplete2'
    };
    dorMantListGrid = $("#dorMantListGrid").ifvsfGrid({
        ejGridOption : ejGridOption
    });
}

$(document).ready(function() {
    dorMantListSearchInit();
    getDorMantListGrid();
    // 조회
    $('#searchDorMantBtn').on('click', function() {
        dorMantListSearch();
    });
    // 초기화
    $("#searchDorMantInitBtn").on('click', function() {
        dorMantListSearchInit('dorMantListGrid');
    });
    $(".col-xs-2 cal_scd end_date").attr("readonly", true);
});
</script>

<div class="page-title" >
    <h1>
        <spring:message code="O00189"/>
        &gt; <spring:message code="M03005"/>
    </h1>
</div>

<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchDorMantBtn" objCode="mbrListSearchDorMantBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchDorMantInitBtn" objCode="mbrListSearchDorMantInitBtn_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
     <div class="well form-horizontal well_bt5" id="dorMantSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
    </div>
    <div id="dorMantListGrid" class="white_bg grid_bd0"></div>
 </div>
