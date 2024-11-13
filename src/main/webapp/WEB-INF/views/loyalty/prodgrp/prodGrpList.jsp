<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
        <spring:message code="상품군 관리"/><!-- 회원 -->
        &gt; <spring:message code="조회"/><!-- 고객 -->
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="prodGrpListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="prodGrpListSearchInit_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<button class="btn btn-sm" id="addProdGrpBtn" objCode="prodGrpListAdd_OBJ">
                <spring:message code="L01169"/></button>
            <button class="btn btn-sm" id="removeProdGrpBtn" objCode="prodGrpListRemove_OBJ">
                <spring:message code="L00080"/></button>
        </div>
    </div>
    <div id="prodGrpGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
var prodGrpGrid = null;
//고객 목록
function getprodGrpList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			//페이지 설정
			return data;
		},
   		recordDoubleClick : function (args) {
   			var data = args.data.rid ;
   	    	prodGrpDetail(data);
        },

        dataUrl : '<ifvm:action name="getProdGrpList"/>',

        columns : [
        	{
      		  field : 'tgtGrpNo', headerText : '번호', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'tgtGrpNm', headerText : '상품군 명', headerTextAlign : 'center',customAttributes :{searchable : true}
    	  },{
    		  field : 'tgtTypeCdNm', headerText : '유형', headerTextAlign : 'center',textAlign : 'center',customAttributes :{index : 'tgtTypeCd'}
    	  },{
    		  field : 'statCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',customAttributes :{index : 'statCd'}
    	  },{
    		  field : 'name', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
    		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center',
    	  } ,{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
    	  }
        ],

        requestGridData : {
      	  sidx : '7',
      	  sord : 'desc',

        },
        rowList : [10,25,50,100],
        radio: true,
    };

    prodGrpGrid = $("#prodGrpGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","PRODGRP_LIST",gridId);
}

//공통 조회 호출
function prodGrpListSearch() {
	$.fn.ifvmSubmitSearchCondition("commSearchList", function(){
		prodGrpGrid.searchGrid({item: requestitem});
    });
	
}


//고객 상세 이동
function prodGrpDetail(id) {
	qtjs.href('<ifvm:url name="prodGrpDetail"/>' + '?rid=' + id);
}

function removeProdGrp() {
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(prodGrpGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = prodGrpGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="삭제할 목록을 클릭해주세요."/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeProdGrp"/>', {
            rid: v_rid
        },
        function(result) {
        	prodGrpGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

$(document).ready(function() {
	 searchCondInit();

	 //마스킹해제 권한 체크
	 getprodGrpList();
	 
	//조회
	 $('#searchCondBtn').on('click', function(){
		 prodGrpListSearch();
	 });

	 //초기화
	 $("#searchCondInitBtn").on('click', function(){
	 	searchCondInit("prodGrpGrid");
	 });
	 
	 $('#removeProdGrpBtn').on('click', function(){
		 removeProdGrp();
	 });
	    
	  //신규 클릭시
	 $('#addProdGrpBtn').on('click', function(){
	   	 qtjs.href('<ifvm:url name="prodGrpDetail"/>');
	 });
	 
});




</script>