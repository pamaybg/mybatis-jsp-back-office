<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var stmpMbrTgtList;

function getStmpMbrTgtList(){
    var ejGridOption = {
//         onSelectRow : function (data) {
//         },
       serializeGridData : function( data ){
			data.ridStmp = ridStmp;
			return data;
        },
//         loadComplete : function(obj){
//         },
        dataUrl : '<ifvm:action name="getLoyStmpMbrTgtList"/>',
        columns:[
        	{
	      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 't1.mbrNo' }
	      	  },{
	      		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 'lc.CUST_NM' }
	      	  },{
	      		  field : 'mbrStatCdNm', headerText : '회원상태', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'c1.MARK_NAME' }
	      	  },{
	      		  field : 'mbrLockYn', headerText : '휴면여부', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'lm.MBR_LOCK_YN' }
	      	  },{
	      		  field : 'createDate', headerText : '생성일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 't1.createDate' }
	      	  },{
	      		  field : 'name', headerText : '생성자', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 'emp.NAME' }
	      	  },{
	      		  field : 'rid', headerText : 'rid', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'lsm.RID' }
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 't1.createDate',
	      	  sord : 'asc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
    };
    stmpMbrTgtList = $("#stmpMbrTgtListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//스탬프 참여회원목록 엑셀 다운로드
function stmpMbrTgtListExcel() {
	$.ifvExcelDn('<ifvm:action name="excelDownLoyStmpMbrTgtList"/>','stmpMbrTgtListGrid');
}

//업로드 버튼 클릭 시
function stmpMbrTgtUploadClick() {
	$('#hideFile').trigger('click');
}

//스탬프 적용채널 업로드
function stmpMbrTgtUpload() {
	var validationCheck = false;

	// 파일 확장자 check
	if ($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'csv') {
		validationCheck = true;
	}
	if ($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xlsx'
			|| $("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xls') {
		validationCheck = true;
	}

	if (validationCheck) {
		$.ifvProgressControl(true);

		if (($("#hideFile")[0].files[0].type.split('/')[1] == 'vnd.ms-excel')
				|| $("#hideFile")[0].files[0].type.split('/')[1] == 'vnd.openxmlformats-officedocument.spreadsheetml.sheet') {

			var formData = new FormData();
			formData.append("file", $("#hideFile")[0].files[0]); //파일업로드
			formData.append("ridStmp", ridStmp); //스탬프 아이디

			$.ajax({
				url : '<ifvm:action name="excelUploadStmpMbrTgtTemplate"/>',
				data : formData,
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
					//업로드 실패
					if (!data.success) {
						alert('실패하였습니다. 관리자에게 문의해주세요.');
						stmpMbrTgtList.searchGrid();
					} 
					//업로드 성공
					else {
						alert("<spring:message code='L00076'/>"); //저장되었습니다.
						stmpMbrTgtList.searchGrid();
						$.ifvProgressControl(false);
					}
				}
			});
		} else {
			alert("<spring:message code='M00703'/>");
			$("#hideFile").removeAttr("value");
		}
		//초기화
		$("#hideFile").val("");
	} else {
		alert("<spring:message code='M00703'/>");
		$("#hideFile").removeAttr("value");
	}
}

//스탬프 참여회원목록 엑셀 다운로드
function stmpStoreListExcel() {
	$.ifvExcelDn('<ifvm:action name="excelDownLoyStmpStoreList"/>','stmpStoreListGrid');
}

/**
 * 템플릿 다운로드
 * 채널 전체 목록을 엑셀로 다운로드한다.
 */
function stmpMbrTgtTmplDown() {
	$.ifvProgressControl(true);
	$.get("<ifvm:action name='excelDownloadMbrTgtTemplate'/>",
	function(result) {
		if ($.type(result) === "object") {
			if ($.fn.ifvmIsEmpty(result.message)) {
				$.errorChecker(result);
				$.ifvProgressControl(false);
			} else {
				alert(result.message);
				$.ifvProgressControl(false);
			}
		} else {
			location.href = "<ifvm:action name='excelDownloadMbrTgtTemplate'/>";
			$.ifvProgressControl(false);
		}
	});
}

//저장된 적용 채널 모두 삭제
function stmpMbrTgtReset() {
	if(confirm("<spring:message code='I01500'/>")) {
		$.ifvSyncPostJSON('<ifvm:action name="removeLoyStmpMbrTgt"/>', {
			ridStmp : ridStmp
		}, function(result) {
			alert('<spring:message code="L00034"/>');
			stmpMbrTgtList.searchGrid();
		}, function(result) {
			if(result.message === '1') {
				alert('활성된 스탬프는 삭제할 수 없습니다.');
			} else {
				alert('삭제할 수 없습니다. 관리자에게 문의해주세요.');
			}
		});
	}
}

//특정회원 신규 팝업 닫기
function stmpMbrTgtNewPopClose() {
	stmpMbrTgtNewPop._destroy();
}

//특정회원 신규 팝업
function stmpMbrTgtNew() {
    $("#stmpMbrTgtNewPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrSearchHelpStmp"/>',
        contentType: "ajax",
        title: '회원검색',
        width: '800px',
        close : 'stmpMbrTgtNewPopClose'
    });
}

//특정회원 삭제
function stmpMbrTgtRemove() {
	var _selectedRows = stmpMbrTgtList.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(_selectedRows)) {
		$.ifvSyncPostJSON('<ifvm:action name="removeLoyStmpMbrTgt2"/>', {
			ridStmp : ridStmp
			, selRows : _selectedRows
		}, function(result) {
			alert('<spring:message code="L00034"/>');
			stmpMbrTgtList.searchGrid({});
		});
	} else {
		alert('<spring:message code="L00066"/>');
	}
}

$(document).ready(function() {

	$.ifvmLnbSetting('stmpList');

	getStmpMbrTgtList();
	
	
	//엑셀업로드 파일 선택 시
	$("#hideFile").on("change", function() {
		stmpMbrTgtUpload();
	});
});
</script>

<style>
#hideFile {
	display: none
}
</style>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button" text="L00027" id="stmpMbrTgtNewBtn" btnFunc="stmpMbrTgtNew" objCode="stmpMbrTgtNew_OBJ"/>
 			<ifvm:inputNew type="button" text="L00029" id="stmpMbrTgtRemoveBtn" btnFunc="stmpMbrTgtRemove" objCode="stmpMbrTgtRemove_OBJ"/>
 			<ifvm:inputNew type="button" text="M01858" id="stmpMbrTgtUploadBtn" btnFunc="stmpMbrTgtUploadClick" objCode="stmpMbrTgtUploadClick_OBJ"/>
 			<ifvm:inputNew type="button" text="다운로드" nuc="true" id="stmpMbrTgtListDownBtn" btnFunc="stmpMbrTgtListExcel" objCode="stmpMbrTgtListExcel_OBJ"/> 
 			<ifvm:inputNew type="button" text="M01748" id="stmpMbrTgtTmplDownBtn" btnFunc="stmpMbrTgtTmplDown" objCode="stmpMbrTgtTmplDown_OBJ"/>
 			<ifvm:input type="file" id="hideFile" />
 			<ifvm:inputNew type="button" text="L00031" id="stmpMbrTgtResetBtn" btnFunc="stmpMbrTgtReset" objCode="stmpMbrTgtReset_OBJ"/>
        </div>
    </div>
    <div id="stmpMbrTgtListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="stmpMbrTgtNewPop" class="popup_container"></div>
