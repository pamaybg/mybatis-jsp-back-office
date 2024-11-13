<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script type="text/javascript">

// 현재 페이지
var pageNum = 1;
// 총 페이지
var totalPageCnt = 1;
// 전체 데이터 개수
var totalCnt = 0;
//페이징 row
const pagingRow = 10;
//더 조회할 데이터가 있는지 여부
var isLast = false;

//반려할 데이터의 id
var elecAprvId = '';
var seq = '';
var apvrTypeCd = '';
var recordRid = '';
var itemId = '';
var camNm = '';

// 페이징 변수 초기화
function initalPagingValues () {
	pageNum = 1;
	totalPageCnt = 1;
	totalCnt = 0;
	isLast = false;
}

// 파라미터 변수 초기화
function initialParamValues () {
	elecAprvId = '';
	seq = '';
	apvrTypeCd = '';
	recordRid = '';
	itemId = '';
	camNm = '';
}

// 모달 옵션 셋팅
function setModalOptions () {
	$.modal.defaults = {
	  closeExisting: false, // 기존에 존재하던 팝업 닫기
	  escapeClose: false, // esc 키로 팝업 닫기
	  clickClose: false,  // overlay 영역 클릭시 팝업 닫기
	  showClose: false // 디폴트 close 버튼 보이기
	};
}

// 리스트 조회
function getList () {
	const url = '${pageContext.request.contextPath}/mobile/getCampaginApprovalReqList.do'
	var jsonData = {
		nd: new Date().getTime(),
    rows: pagingRow,
    page: pageNum,
    sidx: "mcm.modify_date",
    sord: "desc"
	};
	function successCallback (result) {
		totalPageCnt = result.total;
		totalCnt = result.records;
		// 전체 총 개수 셋팅
		$('#totalCnt').text(result.records);
		var template = totalCnt === 0 ? $('#emptyTemplate').tmpl() : $('#approvalReqListTemplate').tmpl(result.rows);
		$('.list-container').append(template);
	}
	$.ifvPostJSON(url, jsonData, successCallback, handleError);
}

function reloadList () {
	$('.list-container').empty();
	initalPagingValues();
	getList();
}

// 승인 요청
function approvalReq () {
	const url = '${pageContext.request.contextPath}/mobile/setCampaginApproval.do'
	var jsonData = {
		elecAprvId: elecAprvId,
		seq: seq,
		apvrTypeCd: apvrTypeCd,
		recordRid: recordRid,
		itemId: itemId,
		camNm: camNm
	};
	function successCallback (result) {
		// 파라미터에 사용된 데이터 초기화
		initialParamValues();
		closeApprovalPopup();
		// 다이얼로그 열기
		var handleConfirm = function () {
			closeModalsAndReload();
		}
		openDialog('승인 되었습니다.', handleConfirm);
	}
	$.ifvSyncPostJSON(url, jsonData, successCallback, handleError, '', '', handleError);
}

//반려
function rejectReq () {
	// 빈 값 체크
	if(!$('#modalTextarea').val()) {
		var handleConfirm = function () {
			closeModalById('dialog');
		}
		openDialog('반려 사유를 입력해주세요.', handleConfirm);
		return
	}
	const url = '${pageContext.request.contextPath}/mobile/setCampaginReject.do'
	var jsonData = {
		rejectDesc: $('#modalTextarea').val(),
		elecAprvId: elecAprvId,
		seq: seq,
		apvrTypeCd: apvrTypeCd,
		recordRid: recordRid,
		itemId: itemId,
		camNm: camNm

	};
	function successCallback (result) {
		initialParamValues();
		closeRejectPopup();
		var handleConfirm = function () {
			closeModalsAndReload();
		}
		openDialog('반려 되었습니다.', handleConfirm);
	}
	$.ifvSyncPostJSON(url, jsonData, successCallback, handleError, '', '', handleError);
}

function openRejectPopup (event) {
	elecAprvId = $(event.target).data().id;
	seq = $(event.target).data().seq;
	apvrTypeCd = $(event.target).data().apvrtypecd;
	recordRid = $(event.target).data().recordrid;
	itemId = $(event.target).data().itemid;
	camNm = $(event.target).data().camnm;
	$('#rejectModal').modal();
}

// 특정 id 값을 가진 modal 창 닫기
function closeModalById (id) {
	if($.modal.getCurrent() && $.modal.getCurrent().$elm[0].id === id) {
		$.modal.close();
	}
}

function openArrovalDialog (event) {
	elecAprvId = $(event.target).data().id;
	seq = $(event.target).data().seq;
	apvrTypeCd = $(event.target).data().apvrtypecd;
	recordRid = $(event.target).data().recordrid;
	itemId = $(event.target).data().itemid;
	camNm = $(event.target).data().camnm;
	$('#approvalModal').modal();
}

function closeRejectPopup () {
	// textarea reset
	$('#modalTextarea').val('');
	initialParamValues();
	$.modal.close();
};

function closeApprovalPopup () {
	initialParamValues();
	$.modal.close();
};

function scrollEvent () {
	var scrollTarget = $('.mobile-body'); // scroll 타겟
	var contentsHeight = $('.main-container').outerHeight() // 컨텐츠 전체 height
	var headerHeight = $('.mobile-header').outerHeight() // header height
	scrollTarget.scroll(function () {
		if (scrollTarget.scrollTop() > ($('.main-container').outerHeight() - headerHeight) * 0.7) {
	    if(pageNum < totalPageCnt && !isLast) {
	    	pageNum++;
	    	getList()
	    } else {
	    	isLast = true
	    }
    }
	})
};

function openDialog (msg, handleConfirm) {
	$('#dialog').find('.msg').text(msg)
	if(handleConfirm) {
		$('#confirmBtn').on('click', function () {
			 handleConfirm()
		})
	}
	$('#dialog').modal({
		 closeExisting: false
	});
}

function closeModalsAndReload () {
	$.modal.close();
	// 데이터 재조회
	reloadList();
}

function handleError () {
	$('#errorDialog').modal()
}

$(document).ready(function() {
	setModalOptions();
	scrollEvent();
	getList();
});

</script>
<script id="emptyTemplate" type="text/x-jquery-tmpl">
	<h3 class="empty-msg">데이터가 없습니다.</h3>
</script>
<script id="approvalReqListTemplate" type="text/x-jquery-tmpl">
<div class="list-wrap" data-id="\${elecAprvId}">
	<div class="main">
		<div class="header">
			<h3 class="title">
				\${camNm}
			</h3>
			<div class="info">
					요청자명: \${reqName}\${reqHhp}
			</div>
			<div class="info">
			    캠페인 결재 요청일: \${createDate}
			</div>
			<div class="info">
			    캠페인 실행 예정일: \${exeDt}
			</div>
    </div>
	<div class="contents">
		<h3 class="title">발송 내용</h3>
		<div class="info">
			<div class="channel">
				채널 &nbsp;
				<span class="data" style="color: #FF0000;">\${exeChnlTypeCd}</span>
			</div>
			<div class="counts">
				대상자수&nbsp;
				<span class="data" style="color: #FF0000;">\${camTgtCnt}</span>
			</div>
		</div>
		{{if imagePath}}
			<img class="img" src="<%=com.icignal.common.util.CommonUtil.getInstance().getImageServerUrl()%>/\${imagePath}" alt="image" />
		{{/if}}
		<div class="conts">\${contsSbst}</div>
	</div>
  </div>
	<div class="footer">
		<button type="button" class="btn negative" onClick="openRejectPopup(event)" data-id="\${elecAprvId}"  data-seq="\${seq}" data-apvrTypeCd="\${apvrTypeCd}" data-recordRid="\${recordRid}" data-itemId="\${itemId}" data-camNm="\${camNm}">반려</button>
		<button type="button" class="btn positive" onClick="openArrovalDialog(event)" data-id="\${elecAprvId}" data-seq="\${seq}" data-apvrTypeCd="\${apvrTypeCd}" data-recordRid="\${recordRid}" data-itemId="\${itemId}" data-camNm="\${camNm}">승인</button>
  	</div>
 </div>
</div>
</script>

<div class="mobile-body">
	<div class="main-container">
		<div class="title-area">
  	<div class="title">
    	결재 대기
  	</div>
  	<div class="count-area">
    	<div class="counts" id="totalCnt"></div>건
  	</div>
	</div>
	<div class="list-container"></div>
</div>
<!-- Modal HTML embedded directly into document -->
<div id="rejectModal" class="modal">
	<div class="mobile-modal-container">
		<div class="mobile-modal-header">
			<h3><span class="icon"></span>반려 사유</h3>
		</div>
		<div class="mobile-modal-contents">
			<textarea id="modalTextarea"></textarea>
		</div>
	</div>
	<div class="mobile-modal-footer">
			<button type="button" class="close" onClick="closeRejectPopup()">취소</button>
			<button type="button" class="confirm" onClick="rejectReq()">확인</button>
		</div>
</div>

<div id="approvalModal" class="modal">
	<div class="mobile-dialog-container">
		<div class="mobile-dialog-contents">
			<div class="msg">승인하시겠습니까?</div>
		</div>
	</div>
	<div class="mobile-modal-footer">
			<button type="button" class="close" onClick="closeApprovalPopup()">취소</button>
			<button type="button" class="confirm" onClick="approvalReq()">확인</button>
		</div>
</div>

<div id="dialog" class="modal">
	<div class="mobile-dialog-container">
		<div class="mobile-dialog-contents">
			<div class="msg"></div>
		</div>
	</div>
	<div class="mobile-dialog-footer">
		<button type="button" id="confirmBtn" class="confirm">확인</button>
	</div>
</div>

<div id="errorDialog" class="modal">
	<div class="mobile-dialog-container">
		<div class="mobile-dialog-contents">
			<div class="msg">문제가 발생했습니다.</div>
			<div class="msg">잠시 후 다시 시도해주세요.</div>
		</div>
	</div>
	<div class="mobile-dialog-footer">
		<button type="button" class="confirm" onClick="closeModalsAndReload()">확인</button>
	</div>
</div>