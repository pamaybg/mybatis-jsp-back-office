<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondMbrListPopBtn" objCode="searchCondBtn_OBJ" ><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitMbrListPopBtn" objCode="searchCondInitBtn_OBJ" >
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="commSearchMbrListPop" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="clearMaskBtn" objCode="clearMaskBtn_OBJ" >
                <spring:message code="L00326"/></button>
        </div>
    </div>
    <div id="mbrListPopGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
var obj = null;
var mbrListPopGrid;

//권한
var empId;
var empType;
var authType;
var brandCd;

//고객 목록
function getMbrtListPop(){

    var ejGridOption = {
    		loadComplete : function(obj){
        		//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
        		//$.fn.ifvmComCondLogging("LOY_MBR_NEW_LIST", mbrListPopGrid.opt.data.records);
            },
          	serializeGridData : function(data) {
	          	if ($.fn.ifvmIsNotEmpty(requestitem)) {
	    			data.item = requestitem;
	            }
              return data;
          	},
          	recordDoubleClick : function(args) {
        	  	var data = args.data.rid ;
        	  	goMbrDetail(data);
          	},
        dataUrl : '<ifvm:action name="getMbrListNewPage"/>',
        columns: [
      	  /*{
      		  field : 'pgmNm', headerText : '로열티 프로그램', headerTextAlign : 'center', width:'300px'
      	  },*/
      	  {
      		  field : 'mbrNo', headerText : '회원번호',headerTextAlign : 'center', textAlign : 'center'
      	  },
      		{
      		  field : 'custTypeCdNm', headerText : '회원유형', headerTextAlign : 'center', textAlign : 'center' 
      	  },
      	  {
      		  field : 'custNm', headerText : '회원명',headerTextAlign : 'center', textAlign : 'center' 
      	  },
      	  {
      		  field : 'hhp', headerText : '전화번호', headerTextAlign : 'center', textAlign : 'center' 
      	  },
           {
                field : 'maskEmail', headerText : '이메일', headerTextAlign : 'center', textAlign : 'left',customAttributes : {index : 'lc.EMAIL'},width: 180
           },
      	  {
  		      field : 'mbrStatCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center' ,customAttributes : {index : 'mbrStatCd'}
  	  	  },
      	  {
      		  field : 'rid', headerText : 'rid', headerTextAlign : '',visible: false
      	  }

        ],
        requestGridData : {
            empId: empId,
            empType: empType,
            authType: authType,
            brandCd: brandCd,
            sidx : '3',
            sord : 'desc',
            _search : false,
        },
        rowList : [10,25,50,100],
        gridDataInit: false,
      	radio: true,
      	tempId : 'ifvGridSimplePageTemplete2'
    };

    mbrListPopGrid = $("#mbrListPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//고객 상세 이동
function goMbrDetail(id) {
	//개인정보 조회 이력남기기
	$.fn.ifvmPersonalCondLogPageId("LOY_MBR_NEW_LIST", true);
	
    $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
        rid : id,
        mbrNo : ''
       }, function(result){
        if(result.custTypeCd != null){
         if(result.custTypeCd == 'C'){
             //개인정보 조회 이력남기기(법인)
                  location.href = '<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid='+ result.mbRid;
           } else if(result.custTypeCd == 'I' || result.custTypeCd == 'E'|| result.custTypeCd == 'D'|| result.custTypeCd == 'O'|| result.custTypeCd == 'X') {
             //개인정보 조회 이력남기기(개인/임직원)
                  location.href = '<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid; 
           }
        }
       });
    
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchMbrListPop", "ANOTHER_MBR_SELECT_POP", gridId);
}

//공통 조회 호출
function mbrListSearch() {
	$.fn.ifvmSubmitSearchCondition("commSearchMbrListPop",function(bool){
		bool ? alert('최소 1개의 조회조건을 입력해주세요.') : mbrListPopGrid.searchGrid({item: requestitem});
	});
}

//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(mbrListPopGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = mbrListPopGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskListMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = mbrListPopGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
            gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('maskEmail'), result.unMaskEmailAddr);
        });
    }
}

//권한 불러오기(매장 사용자 거르기 위한 용도)
function getAuth() {
    $.ifvSyncPostJSON('<ifvm:action name="selectCampaignAuth"/>', {}, function (result) {
        empId = result.rows[0].empId;
        authType = result.rows[0].authType;
        brandCd = result.rows[0].brandCd;
        empType = result.rows[0].empType;
    });
}

$(document).ready(function() {
	 searchCondInit('mbrListPopGrid');

    getAuth();

	 //마스킹해제 권한 체크
	 getMbrtListPop();
	 
	//조회
	    $('#searchCondMbrListPopBtn').on('click', function(){
	    	mbrListSearch();
	    });

	    //초기화
	    $("#searchCondInitMbrListPopBtn").on('click', function(){
	    	searchCondInit('mbrListPopGrid');
	    });

	    //마스킹해제 클릭시
	    $('#clearMaskBtn').on('click', function(){
	        clearMaskAction();
	    });
	    
});




</script>