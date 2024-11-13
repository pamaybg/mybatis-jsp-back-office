<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<script type="text/javascript">
var dormancyUserList;
//포인트 소멸자  조회
function getDromancyList() {
	var ejGridOption = {
// 		recordDoubleClick : function(args) {
// 			var data = args.data;
// 			rid = data.rid;
// 		},
		loadComplete : function(obj){
        	//로그 저장
    		//$.fn.ifvmComCondLogging("DORMAN_01", dormancyUserList.opt.data.records);
		},
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
		dataUrl : '<ifvm:action name="getDormancyList"/>',
		columns : [
		{
			field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'DOR.MBR_NO', sortable: false
			}
		},/* {
			field : 'ecommMbrNo', headerText : 'ECOM회원번호', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'DOR.ECOMM_MBR_NO', sortable: false
			}
		}, */ {
			field : 'custNm', headerText : '회원명', headerTextAlign : 'center',textAlign : 'left',
			customAttributes : {
				index : 'DOR.CUST_NM', sortable: false
			}
		}, {
			field : 'birthDt', headerText : '생년월일', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'dmi.birth_dt', sortable: false
			}
		}, {
			field : 'genGbnCdNm', headerText : '성별', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'c1.mark_name', sortable: false
			}
		}, {
			field : 'hhpNo', headerText : '핸드폰번호', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'dmi.hhp_no', sortable: false
			}
		}, {
			field : 'emailAddr', headerText : '이메일', headerTextAlign : 'center',textAlign : 'left',
			customAttributes : {
				index : 'dmi.email_addr', sortable: false,searchable: false,
			}
		}, {
			field : 'appr1Zip', headerText : '우편번호', headerTextAlign : 'center',textAlign : 'left',
			customAttributes : {
				index : 'dmi.appr1_zip', sortable: false,searchable: false,
			}
		}, {
			field : 'appr1Dflt', headerText : '주소1', headerTextAlign : 'center',textAlign : 'left',
			customAttributes : {
				index : 'dmi.appr1_dflt', sortable: false,searchable: false,
			}
		}, {
			field : 'appr1Dtl', headerText : '주소2', headerTextAlign : 'center',visible : false,
			customAttributes : {
				index : 'dmi.appr1_dtl', sortable: false, searchable: false,
			}
		}, {
			field : 'mbrLockDt', headerText : '휴면 전환일', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'lm.MBR_LOCK_DT', sortable: false,searchable: false,
			}
		}, {
			field : 'svrLastMbr', headerText : '최종 접속 일시', headerTextAlign : 'center',textAlign : 'center',
			customAttributes : {
				index : 'lm.SVR_LAST_DT', sortable: false,searchable: false,
			}
		}, {
			field : 'chnlNm', headerText : '최종 접속 채널',headerTextAlign : 'center',
			customAttributes : {
				index : 'lc.CHNL_NM', sortable: false, searchable: false,
			}
		}, {
			field : 'rid', headerText : 'rid', visible : false,
			customAttributes : {
				index : 'lm.RID'
			}
		} ],
		requestGridData : {
			nd : new Date().getTime(),
			rows : 10,
// 			sidx : 'lm.MBR_NO',
// 			sord : 'asc',
			_search : false
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true,
		gridDataInit: false,
		tempId : 'ifvGridSimplePageTemplete2'
	};

	dormancyUserList = $("#dormancyListGrid").ifvsfGrid({
		ejGridOption : ejGridOption
	});
}

//공통 조회 조건 목록 설정
function termsListSearchInit(gridId) {
	$.fn.ifvmSetCommonCondList("TermsListSearchList", "DORMAN_01",gridId);
}

 //공통 조회 호출
function dormancyListSearch() {
	$.fn.ifvmSubmitSearchCondition("TermsListSearchList",function(bool){
		bool ? alert('최소 1개의 조회조건을 입력해주세요.') :	dormancyUserList.searchGrid({item: requestitem});
	});

}
//마스크해제
function clearMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(dormancyUserList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = dormancyUserList.opt.gridControl.getSelectedRecords()[0].rid;
//     	v_rid = mbrListGrid.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="selectCustNm"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = dormancyUserList.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('emailAddr'), result.emailAddr);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhpNo'), result.hhpNo);
        });
    }
}
function activeMbrAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(dormancyUserList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = dormancyUserList.opt.gridControl.getSelectedRecords()[0].rid;
//     	v_rid = mbrListGrid.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="activeDorMbr"/>', {
            rid: v_rid
        },
        function(result) {
        	alert('휴면해제 처리되었습니다.');
        	getDromancyList();
        });
    }
}
$(document).ready(function() {
	$.ifvmLnbSetting('dormancyUser');

	//공통 조회 조건 목록 설정
	termsListSearchInit();
	getDromancyList();
// 	dormancyListSearch();
	//조회
	$('#ListSearchBtn').on('click', function() {
		dormancyListSearch();
	});

	//초기화
	$("#channelListSearchInitBtn").on('click', function() {
		termsListSearchInit('dormancyListGrid');
	});

	  //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });

	  //마스킹해제 클릭시
    $('#dorMbrActiveBtn').on('click', function(){
    	activeMbrAction();
    });
});
</script>

<!-- <style> -->
<!-- /* #hideFile { */ -->
<!-- /* 	display: none */ -->
<!-- /* } */ -->
<!-- </style> -->

<div class="page-title">
	<h1>
		휴면 대상자 조회
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="ListSearchBtn" objCode="domancyListSearchBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" id="channelListSearchInitBtn" objCode="dochannelListSearchInitBtn_OBJ">
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
			<span><spring:message code="L00930" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="clearMaskBtn"  text="D10091" objCode="domancyclearMaskBtn_OBJ"/>
			<ifvm:inputNew type="button" id="dorMbrActiveBtn"  text="휴면 해제" objCode="dorMbrActiveBtn_OBJ" nuc="true"/>
		</div>

	</div>
	<div id="dormancyListGrid" class="white_bg grid_bd0"></div>
</div>
