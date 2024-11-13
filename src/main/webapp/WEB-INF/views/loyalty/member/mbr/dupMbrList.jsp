<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">
var dupInfoList;
function dupMbrList() {
	var ejGridOption = {
		isHorizontalScroll: true,
		loadComplete : function(obj){
        	//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
    		//$.fn.ifvmComCondLogging("DUB_MBR_01", dupInfoList.opt.data.records);
		},
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
		dataUrl : '<ifvm:action name="getDupMbrList"/>',
		columns : [
		{
			field : 'memcreDt', headerText : '<spring:message code="D10087"/>', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {//
				index : 'wmd.MEM_CREATEDATETIME'
			}
		}, {
			field : 'mbrStCd', headerText : '<spring:message code="L01244"/>',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {//
				index : 'c1.mark_name'
			}
		},{
			field : 'wpRid', headerText : '<spring:message code="D10220"/>',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'wmd.OLD_ID'
			}
		},{
			field : 'custNm', headerText : '<spring:message code="L00320"/>',headerTextAlign : 'center',
			customAttributes : {
				index : 'wmd.CUST_NM'
			}
		},{
			field : 'hpNo', headerText : '<spring:message code="L00840"/>',headerTextAlign : 'center',textAlign : 'right',
			customAttributes : {
				index : 'wmd.HHP_NO'
			}
		},{
			field : 'emailaddr', headerText : '<spring:message code="L00879"/>',headerTextAlign : 'center',
			customAttributes : {
				index : 'wmd.EMAIL_ADDR'
			}
		},{
			field : 'birthDt', headerText : '<spring:message code="L01147"/>',headerTextAlign : 'center',
			customAttributes : {
				index : 'wmd.BIRTH_DT'
			}
		},{
			field : 'usePnt', headerText : '사용가능 포인트',headerTextAlign : 'center',
			customAttributes : {
				sortable : false,   //해당 레코드 정렬 막기
				index : ''
			}
		},{
			field : 'chnlAgreSms', headerText : '<spring:message code="L00517"/>',headerTextAlign : 'center',
			customAttributes : {
				index : 'wmd.CHNL_AGRE_SMS'
			}
		},{
			field : 'chnlAgreSmsDt', headerText : '<spring:message code="D10218"/>',headerTextAlign : 'center',
			customAttributes : {
				index : 'wmd.CHNL_AGRE_SMS_DT'
			}
		},{
			field : 'chnlAgrePush', headerText : '<spring:message code="L02308"/>',headerTextAlign : 'center',
			customAttributes : {
				index : 'wmd.CHNL_AGRE_PUSH'
			}
		},{
			field : 'chnlAgrePushDt', headerText : '<spring:message code="D10219"/>',headerTextAlign : 'center',
			customAttributes : {
				index : 'wmd.CHNL_AGRE_PUSH_DT'
			}
		},{
			field : 'mktAgrUse', headerText : '<spring:message code="L00327"/>',headerTextAlign : 'center',
			customAttributes : {
				index : 'wmd.MKT_AGRE_USE'
			}
		},{
			field : 'svrLastDt', headerText : '마지막서비스 일시',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'wmd.SVR_LAST_DT'
			}
		},{
			field : 'leaveDt', headerText : '<spring:message code="L00716"/>',headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'wmd.LEAVE_DATE'
			}
		},{
			field : 'ridMbr', headerText : 'ridMbr',visible: false,
			customAttributes : {
				index : '',
			}
		} ,{
			field : 'ridCust', headerText : 'ridCust', visible: false,
			customAttributes : {
				index : '',
			}
		}],
		requestGridData : {
			nd : new Date().getTime(),
			rows : 10,
			sidx : 'wmd.HHP_NO',
			sord : 'desc',
			_search : false
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true,
		tempId : 'ifvGridSimplePageTemplete2'
	};

	dupInfoList = $("#dupInfoListGrid").ifvsfGrid({
		ejGridOption : ejGridOption
	});
}

//공통 조회 조건 목록 설정
function ListSearchInit(gridId) {
	$.fn.ifvmSetCommonCondList("ListSearchList", "DUB_MBR_01",gridId);
}
//공통 조회 호출
function ListSearch() {
	$.fn.ifvmSubmitSearchCondition("ListSearchList", dupMbrList);
}
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(dupInfoList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = dupInfoList.opt.gridControl.getSelectedRecords()[0].ridMbr;
//     	v_rid = mbrListGrid.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearDupMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = dupInfoList.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.rows[0].custNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hpNo'), result.rows[0].hpNo);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('emailaddr'), result.rows[0].emailAddr);
        });
    }
}



$(document).ready(function() {
	$.ifvmLnbSetting('dupMbrList');
	ListSearchInit();
	//공통 조회 조건 목록 설정
	dupMbrList();

  	//조회
    $('#ListSearchBtn').on('click', function(){
    	ListSearch();
    });

//     //초기화
    $("#SearchInitBtn").on('click', function(){
    	ListSearchInit('dupInfoListGrid');
    });
    //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });

});
</script>

<div class="page-title">
	<h1>
		<spring:message code="D10216"/>
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="ListSearchBtn" objCode="dupListSearchBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="SearchInitBtn" objCode="dupSearchInitBtn_OBJ">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="ListSearchList">
	</div>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L00930" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="clearMaskBtn"  text="D10091" objCode="dupclearMaskBtn_OBJ"/>
		</div>
	</div>
	<div id="dupInfoListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="jobDetailTabArea">
