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

//공통 조회 조건 목록 설정
function executivesListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("executivesSearchList", "EXCUTIVES_LIST", gridId);
}
// 공통 조회 호출
function executivesListSearch() {
    $.fn.ifvmSubmitSearchCondition("executivesSearchList", function(bool) {
        bool ? alert('최소 1개의 조회조건을 입력해주세요.') :  executivesListGrid.searchGrid({item: requestitem});
    });
}
//고객 상세 이동
function goMbrDetail(id) {
    //개인정보 조회 이력남기기
    $.fn.ifvmPersonalCondLogPageId("PGM_L_050", true);
	 $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
	 rid : id,
	 mbrNo : ''
	}, function(result){
	 if(result.custTypeCd != null){
	  if(result.custTypeCd == 'C'){
	      //개인정보 조회 이력남기기(법인)
	           qtjs.href('<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid=' + result.mbRid);
	    } else if(result.custTypeCd == 'I' || result.custTypeCd == 'E'|| result.custTypeCd == 'D'|| result.custTypeCd == 'O'|| result.custTypeCd == 'X') {
	      //개인정보 조회 이력남기기(개인/임직원)
	           qtjs.href('<ifvm:url name="eMbrDetailNewPage"/>' + '?rid=' + result.mbRid + '&backPage=executivesList'); 
	    }
	 }
	});
}

function getexecutivesListGrid() {

    var ejGridOption = {
            loadComplete : function(obj){
            },
         recordDoubleClick : function(args) {
                var data = args.data.mbRid ; // ridMbr변수명 확인하기
                goMbrDetail(data);
         },
         recordClick : function (args) {
             if(args.columnName=='회원번호'){
                 var data = args.data.mbRid ;
                 goMbrDetail(data);
             }
         },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        dataUrl : '<ifvm:action name="getexecutivesList"/>',
        columns : [  
            {
                field: 'mbRid', headerText: 'mbRid', visible: false,
         }
         ,{
                field: 'rid', headerText: 'rid', visible: false,
         }
        ,{
            field : 'pgmNm',
            headerText : '<spring:message code="C00168"/>',
            headerTextAlign : 'center',
            width : 110,
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lp.PGM_NM'
            }
        }
        ,{
            field : 'mbrNo',
            headerText : '<spring:message code="L00797"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            template : '#mbrNoTemplate',
            customAttributes : {
                index : 'lm.MBR_NO'
            }
        }
        ,{
            field : 'teamNm',
            headerText : '<spring:message code="L01221"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'llip.TEAM_NM'
            }
        }
        ,{
            field : 'empNo',
            headerText : '<spring:message code="L01323"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lci.EMP_NO'
            }
        }
        ,{
            field : 'statusCdNm',
            headerText : '<spring:message code="O00162"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'llip.STATUS_CD'
            }
        }
        ,{
            field : 'custNm',
            headerText : '<spring:message code="L00435"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lc.CUST_NM'
            }
        }
        ,{
            field : 'hhp',
            headerText : '<spring:message code="L01803"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lc.HHP '
            }
        }
        ,{
            field : 'genCdNm',
            headerText : '<spring:message code="L01143"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lc.GEN_CD'
            }
        }
        ,{
            field : 'mbrStatCdNm',
            headerText : '<spring:message code="L01630"/>',
            headerTextAlign : 'center',
            textAlign : ej.TextAlign.Center,
            customAttributes : {
                index : 'lm.MBR_STAT_CD'
            }
           }
          ,{
              field : 'sbscDate',
              headerText : '<spring:message code="D10087"/>',
              headerTextAlign : 'center',
              textAlign : ej.TextAlign.Center,
              customAttributes : {
                  index : 'lm.SBSC_DATE'
              }
            }
           ,{
                field : 'chnlNm',
                headerText : '<spring:message code="L00312"/>',
                headerTextAlign : 'center',
                width : 110,
                textAlign : ej.TextAlign.Center,
                customAttributes : {
                    index : 'lch.CHNL_NM'
                }
              }
           ,{
               field : 'companyNm',
               headerText : '<spring:message code="O00163"/>',
               headerTextAlign : 'center',
               textAlign : ej.TextAlign.Center,
               customAttributes : {
                   index : 'llip.COMPANY_NM'
               }
             }
        ],
        
        requestGridData : {
            sidx : '12',
            sord : 'desc',
        },
        rowList : [ 10, 25, 50, 100 ],
        gridDataInit: false,
        radio : true,
        tempId : 'ifvGridSimplePageTemplete2'
    };
    executivesListGrid = $("#executivesListGrid").ifvsfGrid({
        ejGridOption : ejGridOption
    });
}

//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(executivesListGrid.opt.gridControl.getSelectedRecords()[0])) {
        v_rid = executivesListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskCustList"/>', {
            rid: v_rid
        },
        function(result) {
            var gridObj = executivesListGrid.opt.gridControl;
            var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
            gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
            gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
        });
    }
}

$(document).ready(function() {
    executivesListSearchInit();
    getexecutivesListGrid();
    // 조회
    $('#executivesBtn').on('click', function() {
        executivesListSearch();
    });
    // 초기화
    $("#executivesInitBtn").on('click', function() {
        executivesListSearchInit('executivesSearchList');
    });
    //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
    
	//엑셀다운로드
    $("#excelDownExecutives").on('click', function() {
        if ($.fn.ifvmIsNotEmpty(executivesListGrid.opt.gridControl.model.dataSource)) {
      		$.ifvExcelDn('<ifvm:action name="getExecutivesListExcelDown"/>','executivesListGrid' );
        } else {
        	alert("다운로드 할 대상을 조회 해주세요.")
        }
    });
    
});
</script>

<div class="page-title" >
    <h1>
        <spring:message code="M03010"/>
        &gt; <spring:message code="M03005"/>
    </h1>
</div>

<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="executivesBtn" objCode="executivesBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="executivesInitBtn" objCode="executivesInitBtn_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
     <div class="well form-horizontal well_bt5" id="executivesSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
                	<!-- 엑셀 다운로드 -->
        	<button class="btn btn-sm" id="excelDownExecutives" objCode="excelDownExecutives_OBJ">
                다운로드</button>
            <button class="btn btn-sm" id="clearMaskBtn" objCode="executivesClearMask_OBJ">
                <spring:message code="L00326"/></button>
        </div>
    </div>
    <div id="executivesListGrid" class="white_bg grid_bd0"></div>
 </div>
