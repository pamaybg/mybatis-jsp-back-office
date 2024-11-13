<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var stmpList;

function getStmpListSearch(){
	var ejGridOption = {
		recordDoubleClick : function(args){
			stmpDetailFn(args.data.rid);
        },
        rowSelected : function (data) {
        	setEnableButton();
        },
		serializeGridData : function( data ){
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){

        },
        dataUrl : '<ifvm:action name="getLoyStmpList"/>',
        columns : [
				{
					field : 'stmpNo', headerText : '번호', headerTextAlign : 'center', textAlign : 'left', width : '100px',
					customAttributes : {
					index : 'stmpNo' }
				},{
					field : 'stmpNm', headerText : '스탬프명', headerTextAlign : 'center', textAlign : 'left', width : '160px',
					customAttributes : {
					index : 'stmpNm' }
				},{
					field : 'stmpStartDt', headerText : '시작일', headerTextAlign : 'center', textAlign : 'center', width : '100px',
					customAttributes : {
					index : 'stmpStartDt' }
				},{
					field : 'stmpEndDt', headerText : '종료일', headerTextAlign : 'center', textAlign : 'center', width : '100px',
					customAttributes : {
					index : 'stmpEndDt' }
				},{
					field : 'stmpStatusNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width : '70px',
					customAttributes : {
					index : 'stmpStatusNm' }
				},{
					field : 'stmpProgStatusNm', headerText : '진행상태', headerTextAlign : 'center', textAlign : 'center', width : '70px',
					customAttributes : {
					index : 'stmpProgStatusNm' }
				},{
					field : 'calcTypeCdNm', headerText : '계산유형', headerTextAlign : 'center', textAlign : 'center', width : '70px', format : "{0:n0}",
					customAttributes : {
					index : 'calcTypeCdNm' }
				},{
					field : 'calcTypeSubCdNm', headerText : '계산유형상세', headerTextAlign : 'center', textAlign : 'center', width : '70px', format : "{0:n0}",
					customAttributes : {
					index : 'calcTypeSubCdNm' }
				},{
					field : 'mbrTgtYn', headerText : '특정회원여부', headerTextAlign : 'center', textAlign : 'center', width : '50px',
					customAttributes : {
					index : 'mbrTgtYn' }
				},{
					field : 'stmpCnt', headerText : '갯수', headerTextAlign : 'center', textAlign : 'right', width : '70px', format : "{0:n0}",
					customAttributes : {
					index : 'stmpCnt' }
				},{
					field : 'mbrCnt', headerText : '참여인원', headerTextAlign : 'center', textAlign : 'right', width : '70px', format : "{0:n0}",
					customAttributes : {
					index : 'mbrCnt' }
				},{
					field : 'selfTotAmtSum', headerText : '혜택포인트', headerTextAlign : 'center', textAlign : 'right', width : '70px', format : "{0:n0}",
					customAttributes : {
					index : 'selfTotAmtSum' }
				},{
					field : 'acrlPntSum', headerText : '적립포인트금액', headerTextAlign : 'center', textAlign : 'right', width : '70px', format : "{0:n0}",
					customAttributes : {
					index : 'acrlPntSum' }
				},{
					field : 'rid', headerText : 'rid', headerTextAlign : 'center', textAlign : 'center', visible : false,
					customAttributes : {
					index : 'rid' }
				}
        ],
        radio : true,
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'ls.create_date',
      	  sord : 'desc',
      	  _search : false
        },
//         gridDataInit: false,
    };
	stmpList = $("#stmpListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function stmpListSearchInit() {
    $.fn.ifvmSetCommonCondList("stmpListSearchList","STMP_001",'gridIdstmpListGrid');
}

//공통 조회 호출
function stmpListSearch() {
    $.fn.ifvmSubmitSearchCondition("stmpListSearchList", function(){
    	stmpList.searchGrid({item: requestitem});
    });
}

//스탬프 신규
function stmpDetailFn(rid) {
	var _url = '<ifvm:url name="stmpDetail"/>';
	_url += $.fn.ifvmIsNotEmpty(rid) ? '?rid=' + rid : '';
	qtjs.href(_url);
}

//스탬프 삭제
function removeStmpFn() {
	var _selectedRow = stmpList.opt.gridControl.getSelectedRecords()[0];
	if($.fn.ifvmIsNotEmpty(_selectedRow)) {
		$.ifvPostJSON('<ifvm:action name="removeLoyStmp"/>', {
			rid : _selectedRow.rid
		}, function(result) {
			alert('<spring:message code="L00034"/>');
			stmpList.searchGrid({item: requestitem});
		}, function(result) {
			if(result.message === '1') {
				alert('작업중이 아닌 스탬프는 삭제할 수 없습니다.');
			} else {
				$.errorChecker(result);
			}
		});
	} else {
		alert('<spring:message code="L00066"/>');
	}
}

//스탬프 활성
function activeStmpFn() {
	var _selectedRow = stmpList.opt.gridControl.getSelectedRecords()[0];
	if($.fn.ifvmIsNotEmpty(_selectedRow)) {
		if(confirm('해당 스탬프는 행사기간동안 모바일APP에 노출됩니다.\n진행하시겠습니까?')) {
			$.ifvPostJSON('<ifvm:action name="activeStmp"/>', {
				rid : _selectedRow.rid
			}, function(result) {
				alert('<spring:message code="M00106"/>');
				stmpList.searchGrid({item: requestitem});
			}, function(result) {
				if(result.message === '0') {
					alert('구간별 스탬프가 존재하지 않습니다.');
				} else if(result.message === '1') {
					alert('구간별 스탬프들의 구매금액은 구매횟수 최소금액보다 커야합니다.');
				} else if(result.message === '2') {
					alert('최소 1개의 캠페인이 등록되어 있어야 합니다.');
				} else if(result.message === '3') {
					alert('등록된 캠페인의 상태가 활성중이 아닙니다.');
				} else if(result.message === '4') {
					alert('스탬프 행사기간이 등록된 캠페인 기간을 벗어났습니다.');
				} else if(result.message === '5') {
					alert('구간별 스탬프들의 구매금액은 이전 구간의 금액보다 커야합니다.');
				} else if(result.message === '6') {
					alert('구간별 스탬프들의 방문횟수는 이전 구간의 구매횟수보다 커야합니다.');
				} else if(result.message === '7') {
					alert('적용채널이 존재하지 않습니다.');
				} else if(result.message === '8') {
					alert('특정회원이 존재하지 않습니다.');
				} else {
					$.errorChecker(result);
				}
			});
		}
	} else {
		alert('<spring:message code="L00066"/>');
	}
}

//스탬프 비활성
function inactiveStmpFn() {
	var _selectedRow = stmpList.opt.gridControl.getSelectedRecords()[0];
	if($.fn.ifvmIsNotEmpty(_selectedRow)) {
		$.ifvPostJSON('<ifvm:action name="inactiveStmp"/>', {
			rid : _selectedRow.rid
		}, function(result) {
			alert('<spring:message code="M00106"/>');
			stmpList.searchGrid({item: requestitem});
		}, function(result) {
			if(result.message === '1') {
				alert('활성중인 스탬프가 아닙니다.');
			} else {
				$.errorChecker(result);
			}
		});
	} else {
		alert('<spring:message code="L00066"/>');
	}
}

function setEnableButton() {
	var _selectedRow = stmpList.opt.gridControl.getSelectedRecords()[0];

	//작업중
	if(_selectedRow.stmpStatus === 'W') {
		$("#removeStmpBtn").removeAttr('disabled');
		$("#inactiveStmpBtn").attr('disabled', true);
		$("#activeStmpBtn").removeAttr('disabled');

	}
	//활성
	else if(_selectedRow.stmpStatus === 'A') {
		$("#removeStmpBtn").attr('disabled', true);
		$("#inactiveStmpBtn").removeAttr('disabled');
		$("#activeStmpBtn").attr('disabled', true);

	}
	//비활성
	else if(_selectedRow.stmpStatus === 'I') {
		$("#removeStmpBtn").attr('disabled', true);
		$("#inactiveStmpBtn").attr('disabled', true);
		$("#activeStmpBtn").removeAttr('disabled');
	}
}

$(document).ready(function() {

	$.ifvmLnbSetting('stmpList');

	stmpListSearchInit();
	getStmpListSearch();
});
</script>

<div class="page-title">
    <h1>
        스탬프 기획 &gt;<spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  	text="M00135"  id="stmpListSearchBtn" 		btnFunc="stmpListSearch"/>
            <ifvm:inputNew type="button"   					text="M00278"  id="stmpListSearchInitBtn" 	btnFunc="stmpListSearchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="stmpListSearchList">
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="plus" 							text="L00027" btnFunc="stmpDetailFn"/>
        	<ifvm:inputNew type="button" btnType="minus" 	id="removeStmpBtn"		text="L02218" btnFunc="removeStmpFn"/>
        	<ifvm:inputNew type="button" btnType="save" 	id="inactiveStmpBtn"	text="M02873" btnFunc="inactiveStmpFn"/>
        	<ifvm:inputNew type="button" btnType="save" 	id="activeStmpBtn"		text="M02628" btnFunc="activeStmpFn"/>
        </div>
    </div>
    <div id="stmpListGrid" class="white_bg grid_bd0"></div>
</div>