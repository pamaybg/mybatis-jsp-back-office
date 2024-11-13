<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
	<h1>
		<spring:message code="O00186" />
		&gt; <spring:message code="D10049" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="custDiListSearchBtn" objCode="custDiListSearchBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="custDiListSearchInitBtn" objCode="custDiListInitBtn_OBJ">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="custDiSearchrList">
	</div>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="custDiNewBtn" objCode="custDiNewBtn_OBJ">
				<spring:message code="L00027" />
			</button>
			<button class="btn btn-sm" id="custDiDelBtn" objCode="custDiDelBtn_OBJ">
				<spring:message code="M01854" />
			</button>
		</div>
	</div>
	<div id="custDiListGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
var custDiList;
var rid;

//고객식별목록 조회 리스트
function getCustDiListSearch() {
	
	var ejGridOption = {
		recordDoubleClick : function(args) {
			var data = args.data;
			rid = data.rid;
			moveCustDiDetail(rid);
		},
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
		rowSelected : function (args) {
			rid = args.data.rid;
        },
        dataUrl : '<ifvm:action name="getCustDiList"/>',
		columns : [
		 	{
		 		field : 'rid', headerText : 'rid', visible : false
			}, {
				field : 'pgmNm', headerText : '<spring:message code="대표 프로그램"/>',  textAlign : 'center', customAttributes :{searchable : true},
			}, {
				field : 'diNm', headerText : '<spring:message code="L02749"/>',  textAlign : 'left', customAttributes :{searchable : true}, width : '28%'
			}, {
				field : 'custType', headerText : '<spring:message code="M02328"/>', textAlign : 'center', customAttributes :{index : 'custTypeCd'}
			}, {
				field : 'certType', headerText : '<spring:message code="L02750"/>',  textAlign : 'center', customAttributes : { index : 'certTypeCd' }
			}, {
				field : 'actYn', headerText : '<spring:message code="M01139"/>', textAlign : 'center', customAttributes :{searchable : true}
			}, {
				field : 'createBy', headerText : '<spring:message code="M00221"/>', textAlign : 'center'
			},{
				field : 'createDate', headerText : '<spring:message code="M00222"/>',  textAlign : 'center'
			} ],
		 requestGridData : {
			sidx : '6',
			sord : 'asc'
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true
	};

	custDiList = $("#custDiListGrid").ifvsfGrid({ejGridOption: ejGridOption});
}

//공통 조회 조건 목록 설정
function custDiListSearchInit(gridId) {
	$.fn.ifvmSetCommonCondList("custDiSearchrList", "LOY_CUST_DI_LIST", gridId);
}

//공통 조회 호출
function custDiListSearch() {
	$.fn.ifvmSubmitSearchCondition("custDiSearchrList", getCustDiListSearch);
}

//상세 이동
function moveCustDiDetail() {
	qtjs.href('<ifvm:url name="custDiDetail"/>' + '?rid=' + rid);
}

/**
 * 신규
 */
function custDiListNew() {
	qtjs.href('<ifvm:url name="custDiDetail"/>');
}

/**
 * 삭제
 */
function custDiListDelete() {
	if(confirm('<spring:message code="M00127"/>')) {
		$.ifvSyncPostJSON('<ifvm:action name="removeCustDi"/>', {
			rid : rid
		}, function(result) {
			alert('<spring:message code="M00255"/>');
			custDiList._doAjax();
		});
	}
}

$(document).ready(function() {

	custDiListSearch();
	
	custDiListSearchInit();
 	//조회
	$('#custDiListSearchBtn').on('click', function() {
		custDiListSearch();
	});

	//초기화
	$("#custDiListSearchInitBtn").on('click', function() {
		custDiListSearchInit('custDiList');
	});

	//신규
	$("#custDiNewBtn").on('click', function() {
		rid = null;
		custDiListNew();
	});
	
	//삭제
	$("#custDiDelBtn").on('click', function() {
		custDiListDelete();
	});
	
});
</script>