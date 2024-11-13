<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var stmpStoreList;
var stmpStoreNewPop;

function getStmpStoreList(){
    var ejGridOption = {
//         onSelectRow : function (data) {
//         },
       serializeGridData : function( data ){
			data.ridStmp = ridStmp;
			return data;
        },
//         loadComplete : function(obj){
//         },
        dataUrl : '<ifvm:action name="getLoyStmpStoreList"/>',
        columns:[
        	{
	      		  field : 'chnlNo', headerText : '채널번호', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 'lc.CHNL_NO' }
	      	  },{
	      		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 'lc.CHNL_NM' }
	      	  },{
	      		  field : 'chnlTypeCdNm', headerText : '유형', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'c1.MARK_NAME' }
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 'lss.rid' }
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'lss.MODIFY_DATE',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
    };
    stmpStoreList = $("#stmpStoreListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//선택한 스탬프 적용채널 삭제
function stmpStoreRemove() {
	var _selectedRows = stmpStoreList.opt.gridControl.getSelectedRecords();
	if($.fn.ifvmIsNotEmpty(_selectedRows)) {
		$.ifvSyncPostJSON('<ifvm:action name="removeLoyStmpStore"/>', {
			ridStmp : ridStmp
			, selRows : _selectedRows
		}, function(result) {
			alert('<spring:message code="L00034"/>');
			stmpStoreList.searchGrid({});
		});
	} else {
		alert('<spring:message code="L00066"/>');
	}
}

//업로드 버튼 클릭 시
function stmpStoreUploadClick() {
	$('#hideFile').trigger('click');
}

//스탬프 적용채널 업로드
function stmpStoreUpload() {
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
				url : '<ifvm:action name="excelUploadStmpStoreTemplate"/>',
				data : formData,
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
					//업로드 실패
					if (!data.success) {
						alert('실패하였습니다. 관리자에게 문의해주세요.');
						stmpStoreList.searchGrid({item: requestitem});
					} 
					//업로드 성공
					else {
						alert("<spring:message code='L00076'/>"); //저장되었습니다.
						stmpStoreList.searchGrid({item: requestitem});
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
function stmpStoreTmplDown() {
	$.ifvProgressControl(true);
	$.get("<ifvm:action name='excelDownloadChannelTemplate'/>",
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
			location.href = "<ifvm:action name='excelDownloadChannelTemplate'/>";
			$.ifvProgressControl(false);
		}
	});
}

//저장된 적용 채널 모두 삭제
function stmpStoreReset() {
	if(confirm("<spring:message code='I01500'/>")) {
		$.ifvSyncPostJSON('<ifvm:action name="removeLoyStmpStore"/>', {
			ridStmp : ridStmp
		}, function(result) {
			alert('<spring:message code="L00034"/>');
			stmpStoreList.searchGrid({item: requestitem});
		}, function(result) {
			if(result.message === '1') {
				alert('활성된 스탬프는 삭제할 수 없습니다.');
			} else {
				alert('삭제할 수 없습니다. 관리자에게 문의해주세요.');
			}
		});
	}
}

//채널 단일 신규
function stmpStoreNew() {
    $("#stmpStoreNewPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="stmpStorePop"/>',
        contentType: "ajax",
        title: '<spring:message code="L00162"/>',
        width: '500px',
        close : 'stmpStoreNewPopClose'
    });
}

//채널 단일 신규 팝업 닫기
function stmpStoreNewPopClose() {
	stmpStoreNewPop._destroy();
}

$(document).ready(function() {
	
	$.ifvmLnbSetting('stmpList');
	
	getStmpStoreList();
	
	//엑셀업로드 파일 선택 시
	$("#hideFile").on("change", function() {
		stmpStoreUpload();
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
 			<ifvm:inputNew type="button" text="L00027" id="stmpStoreNewBtn" btnFunc="stmpStoreNew" objCode="stmpStoreNewBtn_OBJ"/>	<!-- 채널 삭제 -->
 			<ifvm:inputNew type="button" text="L00029" id="stmpStoreRemoveBtn" btnFunc="stmpStoreRemove" objCode="stmpStoreRemoveBtn_OBJ"/>	<!-- 채널 삭제 -->
 			<ifvm:inputNew type="button" text="M01858" id="stmpStoreUploadBtn" btnFunc="stmpStoreUploadClick" objCode="stmpStoreUploadBtn_OBJ"/>  <!-- 채널 업로드 -->
 			<ifvm:inputNew type="button" text="다운로드" nuc="true" id="stmpStoreListDownBtn" btnFunc="stmpStoreListExcel" objCode="stmpStoreListDownBtn_OBJ"/> <!-- 업로드한 목록 다운로드 -->
 			<ifvm:inputNew type="button" text="M01748" id="stmpStoreTmplDownBtn" btnFunc="stmpStoreTmplDown" objCode="stmpStoreTmplDownBtn_OBJ"/> <!-- 채널 전체 목록 다운로드 -->
            <ifvm:input type="file" id="hideFile" />
 			<ifvm:inputNew type="button" text="L00031" id="stmpStoreResetBtn" btnFunc="stmpStoreReset" objCode="stmpStoreResetBtn_OBJ"/> <!-- 채널 전체 목록 다운로드 -->
        </div>
    </div>
    <div id="stmpStoreListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="stmpStoreNewPop" class="popup_container"></div>
