<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

//고객 목록
function getChnlList(){

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
   	    	custDetail(data);
        },
        dataUrl : '<ifvm:action name="getChnlListPage"/>',

        columns : [
        	{
              field : 'chnlNo', headerText : '채널번호', headerTextAlign : 'center',width : '10%', textAlign : 'center', customAttributes : {searchable : true}
      	  },{
    		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', width : '20%', customAttributes : {searchable : true}
    	  },{
              field : 'brdNm', headerText : '브랜드', headerTextAlign : 'center',width : '12%', textAlign : 'center', customAttributes : {searchable : true, index:'lbc.BRD_NM'}
          },{
    		  field : 'chnlTypeCdNm', headerText : '채널유형', headerTextAlign : 'center',width : '8%', textAlign : 'center', customAttributes : {index : 'chnlTypeCd'}
    	  },{
    		  field : 'chnlSubTypeCdNm', headerText : '채널서브유형', headerTextAlign : 'center',width : '8%', textAlign : 'center', customAttributes : {index : 'chnlSubTypeCd'}
    	  },{
    		  field : 'statCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',width : '8%', customAttributes : {index : 'statCd'}
    	  },{
    		  field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center', textAlign : 'center',width : '10%',
    	  },{
    		  field : 'modifyDate', headerText : '수정일자', headerTextAlign : 'center', textAlign : 'center',width : '10%',
          },{
    		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center',width : '12%',
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'statCd, chnlTypeCd', 
      	  sord : 'desc',
      	  _search : false,

        },
        gridDataInit: true,
        radio: true,
    };

    chnlListGrid = $("#chnlListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//채널 상세 이동
function custDetail(id) {
	qtjs.href('<ifvm:url name="chnlDetailNewPage"/>' + '?rid=' + id);
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("ChnlSearchList","LOYALTY_CHANNEL_LIST",gridId);
}

function chnlListSearch() {
	$.fn.ifvmSubmitSearchCondition("ChnlSearchList", function() {
		chnlListGrid.searchGrid({
			item : requestitem
		});
	});
}

//채널삭제
function removeChnlBtn() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(chnlListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = chnlListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="C00113"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeChnlChannel"/>', {
            rid: v_rid
        },
        function(result) {
        	chnlListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

function uploadPopClose(){
    $.fn.ifvmPopupClose();
}

$(document).ready(function() {
	//공통 조회 조건 목록 설정
    searchCondInit();

  //마스킹해제 권한 체크
    getChnlList();

    //조회
    $('#searchCondBtn').on('click', function(){
    	chnlListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("chnlListGrid");
    });

    //마스킹해제 클릭시
    $('#removeChnlBtn').on('click', function(){
    	removeChnlBtn();
    });
    
  //신규 클릭시
    $('#addChnlBtn').on('click', function(){
    	qtjs.href('<ifvm:url name="chnlDetailNewPage"/>');
    });
  
    // 공통조회 조건 '상태' 가 '활성'으로 기본적으로 선택된 채로 조회된다
    //$("select option[value='A']").attr("selected", true);
    //$("#searchCondBtn").trigger("click");
    
    
    //엑셀 다운로드
    $('#excelChnlBtn').on('click', function(){
		//$.ifvExcelDn('<ifvm:action name="excelDownChannel"/>','chnlListGrid');
        $.ifvDBExcelDn('<ifvm:action name="excelDownChannel"/>',$("#excelChnlBtn").attr("objcode"))
    });

    //엑셀 파일업로드
    $("#excelUploadBtn").on('click', function(){
        $("#popupContainer").ifvsfPopup({
            enableModal : true,
            enableResize: false,
            contentUrl: '<ifvm:url name="chnlListExcelUploadPop"/>',
            contentType: "ajax",
            title: '채널 엑셀업로드',
            width: '600px',
            close : 'uploadPopClose'
        });
    });
  

});


</script>

<div class="page-title">
    <h1>
        <spring:message code="채널"/><!-- 회원 -->
        &gt; <spring:message code="조회"/><!-- 고객 -->
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="channelListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="channelListSearchInit_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="ChnlSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelUploadBtn" objCode="channelListNewPageExcelUploadBtn_OBJ">
                파일업로드
            </button>
            <button class="btn btn-sm" id="excelChnlBtn" objCode="channalListNewPageExcelDownloadBtn_OBJ">
                엑셀다운로드</button>
        	<button class="btn btn-sm" id="addChnlBtn" objCode="channalListNewPageAddChnlBtn_OBJ">
                <spring:message code="L01169"/></button>
            <button class="btn btn-sm" id="removeChnlBtn" objCode="channalListNewPageRemoveChnlBtn_OBJ">
                <spring:message code="L00080"/></button>
        </div>
    </div>
    <div id="chnlListGrid" class="white_bg grid_bd0"></div>
</div>
<div id=popupContainer class="popup_container"></div>