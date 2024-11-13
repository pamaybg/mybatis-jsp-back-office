<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
   <div class="page_btn_area">
        <div class="col-xs-7">
		<span><spring:message code="변경 이력" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn" objCode="mbrChangeHistSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="chngHistDetailBtn" objCode="mbrChangeHisthDetail_OBJ">
                <spring:message code="L00079"/> <!-- 상세 -->
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn" objCode="mbrChangeHistSearchInit_OBJ">
                <spring:message code="L00082"/>
            </button>
            <button class="btn btn-sm" id="searchMbrDorHistBtn" objCode="mbrChangeHistDorHist_OBJ">
                <spring:message code="휴면이력"/>
            </button>
        </div>
    </div>
     <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>

<div id="mbrAlterHistListGrid" class="white_bg grid_bd0"></div>
<div id="chngHistDetailPopContainer" class="popup_container"></div>
<div id="mbrDorHistPop" class="popup_container"></div> 
  
<script id="bChngDataTemplate" type="text/x-jsrender">
{{if bchngData != null}}
	{{if bchngData.length > 20}}
		{{:bchngData.substring(0,20)+'...'}}
	{{/if}}
	{{if bchngData.length <= 20}}
		{{:bchngData}}
	{{/if}}
{{/if}}
</script>
<script id="aChngDataTemplate" type="text/x-jsrender">
{{if achngData != null}}
	{{if achngData.length > 20}}
		{{:achngData.substring(0,20)+'...'}}
	{{/if}}
	{{if achngData.length <= 20}}
		{{:achngData}}
	{{/if}}
{{/if}}
</script>
 
<script type="text/javascript">
function getAlterHistList(){
	
	 var ejGridOption = {
	        serializeGridData : function(data) {
	            data.rid = mbr_rid;
	            data.pgmNo = pgmNo;
	            data.custTypeCd = $("#custTypeCd").val();
	            return data;
	        },
	        dataUrl : '<ifvm:action name="getMbrChangeHistList"/>',
	        columns : [
	            {
                  field : 'createDate', headerText : '변경일자', headerTextAlign : 'center',  width: '10%', textAlign : 'center'
	          },{
	              field : 'chgCol', headerText : '변경컬럼', headerTextAlign : 'center',  width: '10%', textAlign : 'center',customAttributes : {index : 'chgCol'}
	          },{
	              field : 'bchngData', headerText : '변경전', headerTextAlign : 'center',  textAlign : 'left', customAttributes : {index : 'bchngData'}, template: '#bChngDataTemplate'
	          },{
	              field : 'achngData', headerText : '변경후', headerTextAlign : 'center',   textAlign : 'left', customAttributes : {index : 'achngData'}, template: '#aChngDataTemplate'
	          },{
	              field : 'rMark', headerText : '비고', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'rMark'}
	          },{
	              field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center', textAlign : 'center',  width: '10%', customAttributes : {index : 'modifyBy'}
	          },{
	              field : 'modifyDate', headerText : '수정일자', headerTextAlign : 'center', textAlign : 'center',width: '10%'
	          }
	        ],
	        requestGridData : {
	            nd   : new Date().getTime(),
	            rows : 10,
	            sidx : 'createDate',
	            sord : 'desc',
	            _search : false,

	        },
	        rowList : [10,25,50,100],
	        radio: true,
	        isHorizontalScroll: true,
	        tempId : 'ifvGridSimplePageTemplete'
	    };
	 
	 mbrAlterHistListGrid = $("#mbrAlterHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {

    $.fn.ifvmSetCommonCondList("commSearchList","MBR_CHANGE_HIST_LIST_NEW",gridId);
}

//공통 조회 호출
function searchCondBtn() {
	
	$.fn.ifvmSubmitSearchCondition("commSearchList", function(){
		mbrAlterHistListGrid.searchGrid({item: requestitem});
    });
}

function searchMbrDorHist() {
	
	$("#mbrDorHistPop").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="mbrDorHistPopup"/>',
        contentType : "ajax",
        title : "<spring:message code="휴면 이력"/>",
        width : '800px',
        close : 'mbrDorHistPopClose',
     });
}

function mbrDorHistPopClose() {
	mbrDorHistPop._destroy();
}

// 변경이력 상세 팝업
function openChngHistDetailPop(data){
	var url = '<ifvm:url name="mbrChngHistDetailPop"/>';
	// GET방식으로 팝업에 데이터 전송
	var createDate = data.createDate;
	var chgColNm = data.chgColNm;
	var bchngData = data.bchngData;
	var achngData = data.achngData;
	var rMark = data.rMark;
	var modifyBy = data.modifyBy;
	
	url += '?createDate='+createDate+'&&chgColNm='+chgColNm+'&&bchngData='+bchngData
			+'&&achngData='+achngData+'&&rMark='+rMark+'&&modifyBy='+modifyBy ;
	
	$('#chngHistDetailPopContainer').ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: url,
		contentType: 'ajax',
		title: '변경이력 상세',
		width: '800px',
		close: 'closeChngHistDetailPop'
	});
}


$(document).ready(function(){
	getAlterHistList();

	searchCondInit();
	
	//조회
    $('#searchCondBtn').on('click', function(){
    	searchCondBtn();
    });
	 //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("mbrListGrid");
    });
  	//휴면이력
    $('#searchMbrDorHistBtn').on('click', function(){
    	searchMbrDorHist();
    });
	//상세
    $("#chngHistDetailBtn").on('click', function(){
    	var selectedRecordData = mbrAlterHistListGrid.opt.gridControl.getSelectedRecords()[0];
		if(typeof selectedRecordData == 'undefined') { // selectedRecordData == null || 
			alert("상세를 확인할 변경이력을 선택해주세요.");
			return;
		}    	
    	openChngHistDetailPop(selectedRecordData);
    });
});

</script>