<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
	<h1>
		<spring:message code="M02216" />
		&gt; <spring:message code="D10049" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="clubListSearchBtn" objCode="clubListSearch_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="clubListSearchInitBtn" objCode="clubListSearchInit_OBJ">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="clubListSearchList">
	</div>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="clubListNewBtn" objCode="clubListAdd_OBJ">
				<spring:message code="L00027" />
			</button>
			<button class="btn btn-sm" id="clubListDelBtn" objCode="clubListDel_OBJ">
				<spring:message code="M01854" />
			</button>
		</div>
	</div>
	<div id="clubListGrid" class="white_bg grid_bd0"></div>
</div>
<script type="text/javascript">
var clubList;
var rid;

// 클럽목록 조회 리스트
function getClubListSearch() {
	
	var ejGridOption = {
		recordDoubleClick : function(args) {
			var data = args.data;
			rid = data.rid;
			moveClubDetail(rid);
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
        dataUrl : '<ifvm:action name="getClubList"/>',
		columns : [
		 	{
				field : 'pgmNm', headerText : '<spring:message code="M00774"/>',  textAlign : 'left', customAttributes :{searchable : true}
			}, {
				field : 'clubNo', headerText : '<spring:message code="L02692"/>',  textAlign : 'center', customAttributes :{searchable : true}, width : '130px'
			}, {
				field : 'clubNm', headerText : '<spring:message code="L02693"/>', textAlign : 'left', customAttributes :{searchable : true}
			}, {
				field : 'ctgCdNm', headerText : '<spring:message code="M00180"/>',  textAlign : 'center', customAttributes : { index : 'ctgCd'}, width : '140px'
			}, {
				field : 'clubStatCdNm', headerText : '<spring:message code="M00245"/>',  textAlign : 'center', customAttributes : { index : 'clubStatCd'}, width : '140px'
			}, {
				field : 'atchYn', headerText : '<spring:message code="L02694"/>', textAlign : 'center', customAttributes :{searchable : true}, width : '120px'
			}, {
				field : 'createBy', headerText : '<spring:message code="M00221"/>',  textAlign : 'center', width : '170px'
			}, {
				field : 'createDate', headerText : '<spring:message code="M00222"/>',  textAlign : 'center', width : '170px'
			}, {
				field : 'rid', headerText : 'rid', visible : false,
			} ],
		 requestGridData : {
			sidx : 'clubNo',
			sord : 'asc'
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true
		/* tempId : 'ifvGridNotSearchTemplete' */
	};

	clubList = $("#clubListGrid").ifvsfGrid({ejGridOption: ejGridOption});
}

//공통 조회 조건 목록 설정
function clubListSearchInit(gridId) {
	$.fn.ifvmSetCommonCondList("clubListSearchList", "CLUB_LIST", gridId);
}

//공통 조회 호출
function clubListSearch() {
	$.fn.ifvmSubmitSearchCondition("clubListSearchList", getClubListSearch);
}

//클럽 상세 이동
function moveClubDetail() {
	qtjs.href('<ifvm:url name="clubDetail"/>' + '?rid=' + rid);
}

/**
 * 클럽 신규생성
 */
function clubListNew() {
	qtjs.href('<ifvm:url name="clubDetail"/>');
}

/**
 * 클럽 삭제
 */
function clubListDelete() {
	if(confirm('<spring:message code="M00127"/>')) {
		$.ifvSyncPostJSON('<ifvm:action name="removeClub"/>', {
			rid : rid
		}, function(result) {
			alert('<spring:message code="M00255"/>');
			clubList._doAjax();
		});
	}
}

$(document).ready(function() {

	//공통 조회 조건 목록 설정
	clubListSearchInit();

	clubListSearch();
	//조회
	$('#clubListSearchBtn').on('click', function() {
		clubListSearch();
	});

	//초기화
	$("#clubListSearchInitBtn").on('click', function() {
		clubListSearchInit('clubList');
	});

	//신규
	$("#clubListNewBtn").on('click', function() {
		rid = null;
		clubListNew();
	});
	
	//삭제
	$("#clubListDelBtn").on('click', function() {
		clubListDelete();
	});

});
</script>
