<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
	<h1>
		<spring:message code="관리자 알림내역" />
		&gt; <spring:message code="조회" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="systemAlertListSearchBtn" objCode="systemAlertListSearch_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="systemAlertListSearchInitBtn" objCode="systemAlertListSearchInit_OBJ">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="systemAlertListSearchList">
	</div>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00277" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="systemAlertDetail" objCode="systemAlertDetail_OBJ">
				<spring:message code="상세" />
			</button>
		</div>
	</div>
	<div id="systemAlertListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="popupContainer" class="popup_container"></div>

<script type="text/javascript">
var systemAlertList;
var rid;

// 클럽목록 조회 리스트
function getSystemAlertListSearch() {
	
	var ejGridOption = {
   		recordDoubleClick : function(args){
    		var dataArr = systemAlertList.opt.gridControl.getSelectedRecords();
    		getSystemAlertDetail(dataArr.rid);
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
        dataUrl : '<ifvm:action name="getSystemAlertList"/>',
		columns : [
		 	{
				field : 'createDate', headerText : '<spring:message code="발생일자"/>',  textAlign : 'center'
			}, {
				field : 'alertTypeCdNm', headerText : '<spring:message code="알림유형"/>',  textAlign : 'center', customAttributes : { index : 'alertTypeCd'}
			}, {
				field : 'title', headerText : '<spring:message code="제목"/>',width:'230px' , textAlign : 'left', customAttributes :{searchable : true}
			}
			// , {
			<%--	field : 'emailSndYnNm', headerText : '<spring:message code="이메일발송여부"/>',  textAlign : 'center', customAttributes : { index : 'emailSndYn'}--%>
			// }, {
			<%--	field : 'emailSndStatCdNm', headerText : '<spring:message code="이메일발송상태"/>',  textAlign : 'center', customAttributes : { index : 'emailSndStatCd'}--%>
			// }
			// , {
			<%--	field : 'smsSndYnNm', headerText : '<spring:message code="SMS발송여부"/>', textAlign : 'center', customAttributes : { index : 'smsSndYn'}--%>
			// }, {
			<%--	field : 'smsSndStatCdNm', headerText : '<spring:message code="SMS발송상태"/>',  textAlign : 'center', customAttributes : { index : 'smsSndStatCd'}--%>
			// }
			, {
				field : 'srcSystemNm', headerText : '<spring:message code="발생시스템"/>',  textAlign : 'center', customAttributes : { index : 'srcSystem'}
			}, {
				field : 'rid', headerText : 'rid', visible : false,
			} ],
		 requestGridData : {
			sidx : 'createDate',
			sord : 'desc'
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true
		/* tempId : 'ifvGridNotSearchTemplete' */
	};

	systemAlertList = $("#systemAlertListGrid").ifvsfGrid({ejGridOption: ejGridOption});
}

//공통 조회 조건 목록 설정
function systemAlertListSearchInit(gridId) {
	$.fn.ifvmSetCommonCondList("systemAlertListSearchList", "SYS_ALERT_LIST", gridId);
}

//공통 조회 호출
function systemAlertListSearch() {
	$.fn.ifvmSubmitSearchCondition("systemAlertListSearchList", getSystemAlertListSearch);
}

function getSystemAlertDetail(rid){
	$("#popupContainer").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl: '<ifvm:url name="systemAlertDetailPop"/>'+ '?rid=' + rid,
		contentType: "ajax",
        title: '<spring:message code="관리자 알림내역 상세"/>',
        width: 900,
        close : 'popupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	});
        }		
	});
}

function popupClose() {
	popupContainer._destroy();
} 

$(document).ready(function() {

	//공통 조회 조건 목록 설정
	systemAlertListSearchInit();

	systemAlertListSearch();
	//조회
	$('#systemAlertListSearchBtn').on('click', function() {
		systemAlertListSearch();
	});

	//초기화
	$("#systemAlertListSearchInitBtn").on('click', function() {
		systemAlertListSearchInit('systemAlertList');
	});
	
	//상세
	$("#systemAlertDetail").on('click', function() {
		if(rid == null){
			alert("목록을 선택하세요.")
		}else{
			getSystemAlertDetail();
		}
	});


});
</script>
