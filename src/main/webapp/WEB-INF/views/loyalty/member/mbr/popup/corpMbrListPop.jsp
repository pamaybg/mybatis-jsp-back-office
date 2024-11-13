<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal top_well">
    <div class="page_btn_area">
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCorpCondBtn" ><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCorpCondInitBtn" >
                <spring:message code="L00082"/>
            </button>
            <%-- <button class="btn btn-sm" id="clearCorpMaskBtn" >
                <spring:message code="L00326"/>
            </button> --%>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="corpCustSearchList" >
	</div>
</div>
<div id="mbrListPopGrid" ></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="selectCorpBtn" objCode="">
		<spring:message code="선택" />
	</button> 
	<button class="btn btn-sm btn_gray"  id="closeCorpPopBtn" objCode="">
		<spring:message code="L00941" />
	</button> 
</div>

<script type="text/javascript">
var mbrListPopGrid;
var mbrNo;
var mbrNm;
var mbrRid;

function getCorpMbrListPop(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
   		recordDoubleClick : function (args) {
   			var data = args.data;
   			mbrNo = data.mbrNo;
   			mbrNm = data.custNm;
   			mbrRid = data.rid;
        },
        rowSelected : function (args) {
			var data = args.data;
			mbrNo = data.mbrNo;
			mbrNm = data.custNm;
   			mbrRid = data.rid;
    	},
        loadComplete : function(obj){
    		//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
    		//$.fn.ifvmComCondLogging("LOY_MBR_NEW_LIST", mbrListPopGrid.opt.data.records);
        },
        dataUrl : '<ifvm:action name="getCorpMbrListPop"/>',
        columns : [
        	{
      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center',
      	  },{
    		  field : 'custNm', headerText : '회원명', textAlign : 'center',
    	  },{
    		  field : 'bizrNo', headerText : '법인(단체)번호', textAlign : 'center',
    	  },{
    		  field : 'mbrStatCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',
    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '1',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: false,
        radio: true,
        tempId : 'ifvGridSimplePageTemplete'
    };

    mbrListPopGrid = $("#mbrListPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("corpCustSearchList","LOY_MBR_NEW_LIST",gridId);
    //LOY_MBR_NEW_LIST , CORP_CUST_LIST
}

//공통 조회 호출
function mbrListSearch() {
	$.fn.ifvmSubmitSearchCondition("corpCustSearchList",function(bool){
		bool ? alert('최소 1개의 조회조건을 입력해주세요.') : mbrListPopGrid.searchGrid({item: requestitem});
	});
}

//마스크해제
/* function clearMaskAction() {
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
        });
    }
} */

$(document).ready(function() {
    searchCondInit();
    getCorpMbrListPop();

	
    //조회
    $('#searchCorpCondBtn').on('click', function(){
    	mbrListSearch();
    });

    //초기화
    $("#searchCorpCondInitBtn").on('click', function(){
    	searchCondInit("mbrListPopGrid");
    });

    //마스킹해제 클릭시
    /* $('#clearCorpMaskBtn').on('click', function(){
        clearMaskAction();
    }); */
    
    $('#selectCorpBtn').on('click', function(){
    	$("#mbrCNo").val(mbrNo);
    	$("#mbrCNm").val(mbrNm);
    	$("#mbrCRid").val(mbrRid);
    	searchCondInit("mbrListPopGrid");
    	$.fn.ifvmPopupClose();
    });
    
    $('#closeCorpPopBtn').on('click', function(){
    	searchCondInit("mbrListPopGrid");
    	$.fn.ifvmPopupClose();
    });

});

</script>
