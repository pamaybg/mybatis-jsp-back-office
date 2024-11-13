<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

//고객 목록
function getBlackMbrList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			//페이지 설정
			return data;
		},
   		recordDoubleClick : function (args) {
   			var data = args.data.rid;
   	    	blackTxnMbrDetail(data);
        },
        dataUrl : '<ifvm:action name="getBlackMbrList"/>',

        columns : [
        	{
      		  field : 'blackTypeCdNm', headerText : '유형', headerTextAlign : 'center',width : '40px', textAlign : 'center',customAttributes : {index : 'blackTypeCd'}
      	  },{
    		  field : 'custNm', headerText : '고객명', headerTextAlign : 'center', width : '60px',textAlign : 'left'
    	  },{
    		  field : 'birthdt', headerText : '생년월일', headerTextAlign : 'center',width : '60px', textAlign : 'center'
    	  },{
    		  field : 'hhp', headerText : '휴대폰', headerTextAlign : 'center', textAlign : 'left',width : '60px'
    	  },{
    		  field : 'email', headerText : '이메일', headerTextAlign : 'center', textAlign : 'left',width : '70px',
    	  },{
    		  field : 'statCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',width : '40px',customAttributes : {index : 'statCd'}
    	  },{
    		  field : 'sbscPlcyCdNm', headerText : '제한정책', headerTextAlign : 'center', textAlign : 'center',width : '50px',customAttributes : {index : 'sbscPlcyCd'}
    	  },{
    		  field : 'blComment', headerText : '사유', headerTextAlign : 'center', textAlign : 'left',width : '80px',
    	  },{
    		  field : 'createBy', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center',width : '60px',customAttributes : {searchable :true}
    	  },{
    		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center',width : '100px',
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '10',
      	  sord : 'desc',
      	  _search : false,

        },
        gridDataInit: true,
        radio: true,
    };

    blackMbrListGrid = $("#blackMbrListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//채널 상세 이동
function blackTxnMbrDetail(id) {
	qtjs.href('<ifvm:url name="blackMbrDetail"/>' + '?rid=' + id);
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("blackMbrSearchList","BLACK_LIST_MBR",gridId);
}

function blackMbrListSearch() {
	$.fn.ifvmSubmitSearchCondition("blackMbrSearchList", function() {
		blackMbrListGrid.searchGrid({
			item : requestitem
		});
	});
}

//채널삭제
function removeBlackMbr() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(blackMbrListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = blackMbrListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="C00113"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeBlackListMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	blackMbrListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(blackMbrListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = blackMbrListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskBlackListMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = blackMbrListGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('email'), result.unMaskEmail);
        });
    }
}

$(document).ready(function() {
	//공통 조회 조건 목록 설정
    searchCondInit();

  //마스킹해제 권한 체크
    getBlackMbrList();

  //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
  
    //조회
    $('#searchCondBtn').on('click', function(){
    	blackMbrListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("blackMbrListGrid");
    });

    //삭제
    $('#removeBlackMbrBtn').on('click', function(){
    	removeBlackMbr();
    });
    
  //신규 클릭시
    $('#addBlackMbrBtn').on('click', function(){
    	qtjs.href('<ifvm:url name="blackMbrDetail"/>');
    });

});


</script>

<div class="page-title">
    <h1>
        <spring:message code="블랙리스트 회원"/><!-- 회원 -->
        &gt; <spring:message code="조회"/><!-- 고객 -->
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="blackListMbrSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="blackListMbrSearchInit_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="blackMbrSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id="clearMaskBtn" objCode="blackListMbrClearMask_OBJ">
                <spring:message code="마스킹해제"/></button>
        	<button class="btn btn-sm" id="addBlackMbrBtn" objCode="blackListMbrAdd_OBJ">
                <spring:message code="L01169"/></button>
            <button class="btn btn-sm" id="removeBlackMbrBtn" objCode="blackListMbrRemove_OBJ">
                <spring:message code="L00080"/></button>
                
        </div>
    </div>
    <div id="blackMbrListGrid" class="white_bg grid_bd0"></div>
</div>