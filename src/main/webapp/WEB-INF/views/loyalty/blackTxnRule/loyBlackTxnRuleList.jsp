<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

//고객 목록
function getBlackRuleList(){

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
   	    	blackTxnRuleDetail(data);
        },
        dataUrl : '<ifvm:action name="getBlackRuleList"/>',

        columns : [
        	{
    		  field : 'blCd', headerText : '이상거래번호', headerTextAlign : 'center', width : '50px',textAlign : 'center', customAttributes : {searchable : true}
    	  },{
    		  field : 'blNm', headerText : '이상거래명', headerTextAlign : 'center',width : '80px', textAlign : 'left', customAttributes : {searchable : true}
    	  },{
      		  field : 'pgmNm', headerText : '프로그램', headerTextAlign : 'center',width : '70px', textAlign : 'center', customAttributes : {searchable : true}
      	  },{
      		  field : 'fraudTypeCdNm', headerText : '유형', headerTextAlign : 'center',width : '70px', textAlign : 'center', customAttributes : {index : 'fraudTypeCd'}
      	  },{
      		  field : 'fraudSubTypeCdNm', headerText : '세부유형', headerTextAlign : 'center',width : '70px', textAlign : 'center', customAttributes : {index : 'fraudSubTypeCdNm'}
      	  },{
    		  field : 'statCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',width : '30px', customAttributes : {index : 'statCd'}
    	  },{
    		  field : 'createBy', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center',width : '50px',
    	  },{
    		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center',width : '60px',
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '6',
      	  sord : 'desc',
      	  _search : false,

        },
        gridDataInit: true,
        radio: true,
    };

    blackRuleListGrid = $("#blackRuleListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//채널 상세 이동
function blackTxnRuleDetail(id) {
	qtjs.href('<ifvm:url name="blackRuleDetail"/>' + '?rid=' + id);
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("blackRuleSearchList","LOY_BLACK_TXN_RULE_LIST",gridId);
}

function blackRuleListSearch() {
	$.fn.ifvmSubmitSearchCondition("blackRuleSearchList", function() {
		blackRuleListGrid.searchGrid({
			item : requestitem
		});
	});
}

//채널삭제
function removeBalckRule() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(blackRuleListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = blackRuleListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="C00113"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeBlackMst"/>', {
            rid: v_rid
        },
        function(result) {
        	blackRuleListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

$(document).ready(function() {
	//공통 조회 조건 목록 설정
    searchCondInit();

  //마스킹해제 권한 체크
    getBlackRuleList();


    //조회
    $('#searchCondBtn').on('click', function(){
    	blackRuleListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("blackRuleListGrid");
    });

    //삭제
    $('#removeBalckRuleBtn').on('click', function(){
    	removeBalckRule();
    });
    
  //신규 클릭시
    $('#addBlackRuleBtn').on('click', function(){
    	qtjs.href('<ifvm:url name="blackRuleDetail"/>');
    });

});


</script>

<div class="page-title">
    <h1>
        <spring:message code="이상거래정책"/><!-- 회원 -->
        &gt; <spring:message code="조회"/><!-- 고객 -->
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="loyBlackTxnRuleSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="loyBlackTxnRuleSearchInit_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="blackRuleSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<button class="btn btn-sm" id="addBlackRuleBtn" objCode="loyBlackTxnRuleAdd_OBJ">
                <spring:message code="L01169"/></button>
            <button class="btn btn-sm" id="removeBalckRuleBtn" objCode="loyBlackTxnRuleRemove_OBJ">
                <spring:message code="L00080"/></button>
        </div>
    </div>
    <div id="blackRuleListGrid" class="white_bg grid_bd0"></div>
</div>