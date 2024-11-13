<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
		<spring:message code="O00183" /> &gt; <spring:message code="M00273"/>
    </h1>
</div>

<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="mbrListsearchCondBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="mbrListsearchCondInitBtn_OBJ">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
     <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>

<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span><spring:message code="조회 결과" /></span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnNew" btnFunc="dataSetDetail" btnType="plus" text="L00027" objCode="dataSetMasterListBtnNew_OBJ" />		
	    	<ifvm:inputNew type="button" id="BtnRemove" btnFunc="btnRemoveClick" btnType="minus" text="M01854" objCode="dataSetMasterListBtnRemove_OBJ" />
	    </div>
	</div>
	<div id="dataSetListGrid"></div>
</div>

<script>
var dataSetListGrid;

function getDataSetMasterList(){
	var ejGridOption = {
			recordDoubleClick : function(args){
				var rid = args.data.rid;
				dataSetDetail(rid);
			},
			serializeGridData : function(data){
				if($.fn.ifvmIsNotEmpty(requestitem)){
					data.item = requestitem;
				}
				return data;
			},
	       	rowSelected : function(args){
	       	},
			dataUrl : '<ifvm:action name="getDataSetMasterList"/>',
			columns : [
				{
					field : 'cateCdNm', headerText : '카테고리', headerTextAlign : 'center', textAlign : 'center',
					customAttributes: {searchable : false ,index : 'cateCd'}
				},{
					field : 'dsNm', headerText : '데이터셋명', headerTextAlign : 'center', textAlign : 'left',
					customAttributes: {searchable : true }
				},{
					field : 'objNm', headerText : '오브젝트 이름', headerTextAlign : 'center', textAlign : 'left',
					customAttributes: {searchable : true}
				},{
					field : 'name', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center',
					customAttributes: {index : 'name',searchable : true}
				},{
					field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center',

				},{
					field : 'rid', headerText : 'rid', headerTextAlign : 'center', textAlign : 'center', visible : false,
					customAttributes: {		index : 'rid'	}
				}
			],
			requestGridData : {
				sidx : "createDate",
				sord : 'desc',
			},
			radio : true,
	};
	
	dataSetListGrid = $('#dataSetListGrid').ifvsfGrid({ ejGridOption : ejGridOption});
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","DATASET_LIST",gridId);
}

//공통 조회 호출
function dataSetSearch() {
	$.fn.ifvmSubmitSearchCondition("commSearchList", function(){
		dataSetListGrid.searchGrid({item: requestitem});
    });
}


$(document).ready(function() {
	getDataSetMasterList();
	searchCondInit();
	//조회
    $('#searchCondBtn').on('click', function(){
    	dataSetSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("dataSetListGrid");
    });
});

function btnRemoveClick(){
	if($.fn.ifvmIsEmpty(dataSetListGrid.opt.gridControl.getSelectedRecords()[0])){
		alert('목록을 선택해주세요.');
	}else{
		var rid = dataSetListGrid.opt.gridControl.getSelectedRecords()[0].rid;
		if( confirm('<spring:message code="I01500"/>') == true ){
		$.ifvSyncPostJSON('<ifvm:action name="removeDataSet"/>', {
			rid : rid
	    },function(result){
	    	alert('삭제되었습니다.');
	    	dataSetListGrid._doAjax();
	    },function(result){
	    	alert('삭제 실패하였습니다.');
	    });
		}
	}
		
}

function dataSetDetail(rid) {
	location.href = '<ifvm:url name="dataSetDetail"/>' + '?rid=' + rid;
} 

</script>