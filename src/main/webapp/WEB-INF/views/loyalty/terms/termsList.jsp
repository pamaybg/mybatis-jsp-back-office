<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
	<h1>
		<spring:message code="L02319" />
		&gt; <spring:message code="M00135" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="channelListSearchBtn" objCode="termsListSearch_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="channelListSearchInitBtn" objCode="termsListInit_OBJ">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="TermsListSearchList">
	</div>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="termsListNewBtn" objCode="termsListAdd_OBJ">
				<i class="fa fa-plus"></i>
				<spring:message code="L00027" />
			</button>
			<button class="btn btn-sm" id="termsListDelBtn" objCode="termsListDelBtn_OBJ">
				<i class="fa fa-minus"></i>
				<spring:message code="M01854" />
			</button>
			<button class="btn btn-sm" id="termsDetailInfoBtn" objCode="termsListDetailInfo_OBJ">
				<spring:message code="L02332" />
			</button>
		</div>
	</div>
	<div id="termsListGrid" class="white_bg grid_bd0"></div>
</div>
<script type="text/javascript">
var termsList;
var gridTermsList;
var rid;

// 약관목록 조회 리스트
function getTermsListSearch() {

	var columns = [
			{
			field : 'termsNo', headerText : '표시순서', textAlign : 'center',width:64,
			customAttributes: {index: 'termsTypeCd'}
			},
		 	{
				field : 'termsType', headerText : '<spring:message code="L02323"/>', textAlign : 'center',width:64,
				customAttributes: {index: 'termsTypeCd'}
			}
		 	, {
				field : 'termsNm', headerText : '<spring:message code="L02324"/>', textAlign : 'center',width:383, 
				customAttributes: {index: 'termsTypeSubCd'}
			}
			, {
				field : 'statCdNm', headerText : '<spring:message code="C00125"/>', textAlign : 'center',width:64,
				customAttributes: {index: 'statCd'}
			}, {
				field : 'createBy', headerText : '<spring:message code="M00221"/>',  textAlign : 'center',width:123,
			}, {
				field : 'createDate', headerText : '<spring:message code="M00222"/>',  textAlign : 'center',width:127,
			}, {
				field : 'modifyBy', headerText : '<spring:message code="L01604"/>', textAlign : 'center',width:141,
			},{
				field : 'modifyDate', headerText : '<spring:message code="L02703"/>', textAlign : 'center',width:127,
			}, {
				field : 'rid', headerText : 'rid', visible : false,
			}, {
				field : 'termRid', headerText : 'termRid', visible : false,
			} ];
	
	var ejGridOption = {
		recordDoubleClick : function(args) {
			var data = args.data;
			rid = data.rid;
			termsDetailDtl(rid);
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
		columns,
		requestGridData : {
			nd : new Date().getTime(),
			rows : 10,
			sidx : 'termsTypeCd',
			sord : 'asc',
			_search : false
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true,
		tempId : 'ifvGridNotSearchTemplete',
		dataUrl : '<ifvm:action name="getTermsList"/>'
	};

	termsList = $("#termsListGrid").ifvsfGrid({ejGridOption: ejGridOption});
	gridTermsList = $("#gridTermsList");
}

//공통 조회 조건 목록 설정
function termsListSearchInit(gridId) {
	$.fn.ifvmSetCommonCondList("TermsListSearchList", "TERMS_001", gridId);
}

//공통 조회 호출
function termsListSearch() {
	$.fn.ifvmSubmitSearchCondition("TermsListSearchList", getTermsListSearch);
}
function popupCenter(href, w, h) {
    var xPos = (document.body.offsetWidth/2) - (w/2); // 가운데 정렬
    xPos += window.screenLeft; // 듀얼 모니터일 때
    var yPos = (document.body.offsetHeight/2) - (h/2);

    window.open(href, "pop_name", "width="+w+", height="+h+", left="+xPos+", top="+yPos+", menubar=yes, status=yes, titlebar=yes, resizable=yes");
}
// 상세 팝업 화면 호출
function termsDetailInfoPop() {
	var t_rid;
	 if($(termsList.opt.gridControl.getSelectedRecords()).length==0){
		   alert('<spring:message code="M01051"/>');
	 }else{
		 t_rid = termsList.opt.gridControl.getSelectedRecords()[0].rid;
		 $.ifvSyncPostJSON('<ifvm:action name="getTermsInfoDetail"/>', {
			 rid : t_rid
		 },function(result){
			 var popUrl= '<ifvm:url name="termsInfoPop"/>?rid='+t_rid;
			    var xPos = (document.body.offsetWidth/2) - (900/2); // 가운데 정렬
			    xPos += window.screenLeft; // 듀얼 모니터일 때
			    var yPos = (document.body.offsetHeight/2) - (800/2);
			 var popOption ="width=900, height=800, left="+ xPos +" ,top="+ yPos +" , resizable=no, scrollbars=no, status=no";
			window.open(popUrl,"약관내용",popOption);
		 },function(result){
			 alert(result.message);
		 });
	 }
}

//약관 상세 이동
function termsDetailDtl() {
	qtjs.href('<ifvm:url name="termsDetailList"/>' + '?rid=' + rid);
}

/**
 * 약관 신규생성
 */
function termslListNew() {
	qtjs.href('<ifvm:url name="termsDetailList"/>');
}

/**
 * 약관 삭제
 */
function termsListDelete() {
	if(confirm('<spring:message code="M00127"/>')) {
		$.ifvSyncPostJSON('<ifvm:action name="removeTermsList"/>', {
			rid : rid
		}, function(result) {
			alert('<spring:message code="M00255"/>');
			termsList._doAjax();
		});
	}
}

$(document).ready(function() {
	$.ifvmLnbSetting('termslList');

	//공통 조회 조건 목록 설정
	termsListSearchInit();

	termsListSearch();
	//조회
	$('#channelListSearchBtn').on('click', function() {
		termsListSearch();
	});

	//초기화
	$("#channelListSearchInitBtn").on('click', function() {
		termsListSearchInit('termsList');
	});

	//신규
	$("#termsListNewBtn").on('click', function() {
		termslListNew();
	});
	
	//삭제
	$("#termsListDelBtn").on('click', function() {
		if(rid == null){
			alert('<spring:message code="C00113"/>');
		}else{
			termsListDelete();
		}
	});

	//팝업
	$("#termsDetailInfoBtn").on('click', function() {
		termsDetailInfoPop();
	});
});
</script>
