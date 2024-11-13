<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 회원번호 값에 걸 링크로 사용할 템플릿 -->
<script type="text/x-jsrender" id="mbrNoTemplate">
	<span style="color:#1266FF; text-decoration:underline;">{{:mbrNo}}</span>
</script>

<script id="secsnResnEtcTemplate" type="text/x-jsrender">
{{if secsnResnEtc != null}}
	{{if secsnResnEtc.length > 6}}
		{{:secsnResnEtc.substring(0,6)+'...'}}
	{{/if}}
	{{if secsnResnEtc.length <= 6}}
		{{:secsnResnEtc}}
	{{/if}}
{{/if}}
</script>

<script id="reSbscResnTemplate" type="text/x-jsrender">
{{if reSbscResn != null}}
	{{if reSbscResn.length > 6}}
		{{:reSbscResn.substring(0,6)+'...'}}
	{{/if}}
	{{if reSbscResn.length <= 6}}
		{{:reSbscResn}}
	{{/if}}
{{/if}}
</script>

<script type="text/javascript">
var returnPage =null;
var dropMbrList;
var gridIddropMbrList;
var rid ;
var rid_cust;
var dropCmt;
var custTypeCd;
var ridMbrSecsn;
//탈회 회원 조회
function getdropMbrListSearch(){
    var ejGridOption = {
    		recordDoubleClick : function(args){
	     	var data = args.data.rid ;
	    	//개인정보 조회 이력남기기
	      	$.fn.ifvmPersonalCondLogPageId("PGM_L_043", true);
	        $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
	            rid : data,
	            mbrNo : ''
	           }, function(result){
	            if(result.custTypeCd != null){
	             if(result.custTypeCd == 'C'){
	                 //개인정보 조회 이력남기기(법인)
	                      qtjs.href('<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid=' + result.mbRid);
	               } else if(result.custTypeCd == 'I' || result.custTypeCd == 'E'|| result.custTypeCd == 'D'|| result.custTypeCd == 'O'|| result.custTypeCd == 'X') {
	                 //개인정보 조회 이력남기기(개인/임직원)
	                      qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid); 
	               }
	            }
	           });
	        dropCancelBtnValidCheck(args.data.ridMbrDrop);
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        rowSelected : function (data) {
        	rid=data.data.rid;
        	ridMbrSecsn=data.data.ridMbrSecsn;
        	rid_cust=data.data.ridCust;
        	custTypeCd=data.data.custTypeCd;
        	//dropCancelBtnValidCheck(data.data.ridMbrDrop);

        },
        recordClick : function (args) {
            if(args.columnName=='회원번호'){
                var data = args.data.rid ; // 여기선 ridMbr값이 rid임
                goMbrDetail(data);
            }
        },
        loadComplete : function(obj){
        	// 회원상세로 들어갈때만 로그저장 하게 바꿈
    		//$.fn.ifvmComCondLogging("PGM_L_043", dropMbrList.opt.data.records);
        },
        dataUrl : '<ifvm:action name="getDropMbrList"/>',
	       columns : [
	       { // 회원번호
       		  field : 'mbrNo', headerText : '<spring:message code="M00688"/>', textAlign : 'center', width: '80px' ,template : '#mbrNoTemplate',
     	  },{
     		  field : 'custTypeCdNm', headerText : '고객유형', headerTextAlign : 'center', textAlign : 'center', width: '50px',customAttributes : {index : 'lc.CUST_TYPE_CD'}
     	  },{
     		  field : 'custNm', headerText : '이름', headerTextAlign : 'center', width: '90px'
     	  },{
     		  field : 'hhp', headerText : '휴대전화번호', headerTextAlign : 'center', width: '85px'
     	  },{
     		  field : 'ciYn', headerText : 'CI값유무', headerTextAlign : 'center',textAlign : 'center', width: '60px'
     	  },{
     		  field : 'bizrNo', headerText : '사업자번호', headerTextAlign : 'center', width: '65px'
     	  },{
     		  field : 'empNo', headerText : '사번', headerTextAlign : 'center', width: '85px'
     	  },{
     		  field : 'secsnResnCdNm', headerText : '탈회사유', headerTextAlign : 'center', width: '90px', customAttributes : {index : 'secsnResnCd'}
     	  },{
     		  field : 'secsnResnEtc', headerText : '탈회사유 상세', headerTextAlign : 'center', width: '100px',  template: '#secsnResnEtcTemplate'
     	  },{
     		  field : 'reSbscResn', headerText : '식별키 삭제 사유', headerTextAlign : 'center', width: '100px', template: '#reSbscResnTemplate'
     	  }
     	  ,{
     		 field : 'secsnDate', headerText : '<spring:message code="L00716"/>', textAlign : 'center', width: '100px'
     	  },{
     		  field : 'ridMbrSecsn', headerText : 'ridMbrSecsn', headerTextAlign : '',visible: false,
     	  },{
    		  field : 'rid', headerText : '회원rid', headerTextAlign : '',visible: false,
     	  },{
    		  field : 'ridCust', headerText : '고객rid', headerTextAlign : '',visible: false,
     	  }
//      	  ,{
//     		  field : 'custTypeCd', headerText : '고객유형', headerTextAlign : '',visible: false,
//      	  }
        ],
              requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'secsnDate',
        	  sord : 'desc',
        	  _search : false
          },
          rowList : [10,25,50,100],
          gridDataInit: false,
          radio: true,
          tempId : 'ifvGridSimplePageTemplete2'
    };

    dropMbrList = $("#dropMbrListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//회원 상세 이동
function goMbrDetail(id){ // id값 : ridMbr
	//개인정보 조회 이력남기기
	$.fn.ifvmPersonalCondLogPageId("PGM_L_043", true); // 탈회 회원 화면 코드 : PGM_L_043
    $.ifvSyncPostJSON('<ifvm:action name="getMbrCustTypeCd"/>',{
     rid : id, // ridMbr을 초기화해준다
     mbrNo : ''
    }, function(result){
     returnPage="dropMbrListNew";
     if(result.custTypeCd != null){
      if(result.custTypeCd == 'C'){
          //개인정보 조회 이력남기기(법인)
          	  qtjs.href('<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid=' + result.mbRid+'&checkBackPage='+returnPage);
        } else if(result.custTypeCd == 'I' || result.custTypeCd == 'E'|| result.custTypeCd == 'D'|| result.custTypeCd == 'O'|| result.custTypeCd == 'X') {
          //개인정보 조회 이력남기기(개인/임직원)
              qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + result.mbRid+'&checkBackPage='+returnPage); 
        }
     }
    });
}// goMbrDetail


//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.rid;
	//개인정보 조회 이력남기기
	$.fn.ifvmPersonalCondLogPageId("PGM_L_043", true);
    var url = '<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + id;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}
//공통 조회 조건 목록 설정
function dropMbrListSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("dropMbrListSearchList","PGM_L_043",gridId);
}

//공통 조회 호출
function dropMbrListSearch() {
     $.fn.ifvmSubmitSearchCondition("dropMbrListSearchList", function (bool){
    	bool ? alert('최소 1개의 조회조건을 입력해주세요.') : dropMbrList.searchGrid({item: requestitem});
     });
}

function dropCancelFn(){
	if($.fn.ifvmIsNotEmpty(rid)){
		$.ifvSyncPostJSON('<ifvm:action name="dropMbrCancel"/>',{
			rid : rid
		}, function(result) {
				alert("탈회 복원 처리 되었습니다. 이제 재가입 가능하실 수 있습니다.");
				getdropMbrListSearch();
		}, function(reuslt){
			alert(result.message);
		});
	}else{
		alert("데이터를 선택 해주세요.");
	}

}

function dropCancelBtnValidCheck(ridMbrDrop){
	if($.fn.ifvmIsNotEmpty(ridMbrDrop)){
		$("#dropCancelBtn").attr("disabled",false);
	}else{
		$("#dropCancelBtn").attr("disabled",true);
	}
}

//마스크해제 
function clearMaskAction() {
	 var v_rid;
	    if ($.fn.ifvmIsNotEmpty(dropMbrList.opt.gridControl.getSelectedRecords()[0])) {
	    	v_rid = dropMbrList.opt.gridControl.getSelectedRecords()[0].rid;
	    }
	    else {
	        alert('<spring:message code="M02219"/>');
	    }

	    if ($.fn.ifvmIsNotEmpty(v_rid)) {
	        $.ifvSyncPostJSON('<ifvm:action name="clearMaskDrop"/>', {
	        	rid: v_rid
	        },
	        function(result) {
	        	var gridObj = dropMbrList.opt.gridControl;
	        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
	        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
	        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);

	        });
	    }
	}
	
//회원탈퇴
function getDropConfirmMbrPop() {
	
	if (!$.fn.ifvmIsNotEmpty(dropMbrList.opt.gridControl.getSelectedRecords()[0])) {
    	alert('식별키 삭제할 목록을 선택하세요.');
    	return;
    }
	var custTypeCd = dropMbrList.opt.gridControl.getSelectedRecords()[0].custTypeCd;
	if(custTypeCd=='I') {
		var custNm = dropMbrList.opt.gridControl.getSelectedRecords()[0].custNm;
		var hhp = dropMbrList.opt.gridControl.getSelectedRecords()[0].hhp;
		var ciYn = dropMbrList.opt.gridControl.getSelectedRecords()[0].ciYn;
		if(custNm==null && hhp==null && ciYn=='N') {
			alert('삭제할 식별키가 없습니다.');
			return;
		}
	}
	if(custTypeCd=='C') {
		var custNm = dropMbrList.opt.gridControl.getSelectedRecords()[0].custNm;
		var hhp = dropMbrList.opt.gridControl.getSelectedRecords()[0].hhp;
		var bizrNo = dropMbrList.opt.gridControl.getSelectedRecords()[0].bizrNo;
		if(custNm==null && hhp==null && bizrNo==null) {
			alert('삭제할 식별키가 없습니다.');
			return;
		}
	}
	if(custTypeCd=='E') {
		var custNm = dropMbrList.opt.gridControl.getSelectedRecords()[0].custNm;
		var hhp = dropMbrList.opt.gridControl.getSelectedRecords()[0].hhp;
		var empNo = dropMbrList.opt.gridControl.getSelectedRecords()[0].empNo;
		if(custNm==null && hhp==null && empNo==null) {
			alert('삭제할 식별키가 없습니다.');
			return;
		}
	}
	

		$("#dropConfirmMbrPopup").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="dropConfirmMbrPop"/>',
		        contentType: "ajax",
		        title: '회원 식별키 삭제',
		        width: 800,
		        close : 'dropConfirmMbrPoplClose'
		    });
	
}
function dropConfirmMbrPoplClose() {
	dropConfirmMbrPopup._destroy();
}


function dropReasonPopAction() {
	  var v_rid;
	
	    if ($.fn.ifvmIsNotEmpty(dropMbrList.opt.gridControl.getSelectedRecords()[0])) {
	    	v_rid = dropMbrList.opt.gridControl.getSelectedRecords()[0].rid;
	    	mbrNo=dropMbrList.opt.gridControl.getSelectedRecords()[0].mbrNo;
	    	custTypeCdNm=dropMbrList.opt.gridControl.getSelectedRecords()[0].custTypeCdNm;
	    	custNm=dropMbrList.opt.gridControl.getSelectedRecords()[0].custNm;
	    	hhp=dropMbrList.opt.gridControl.getSelectedRecords()[0].hhp;
	    	ciYn=dropMbrList.opt.gridControl.getSelectedRecords()[0].ciYn;
	    	bizrNo=dropMbrList.opt.gridControl.getSelectedRecords()[0].bizrNo;
	    	empNo=dropMbrList.opt.gridControl.getSelectedRecords()[0].empNo;
	    	secsnResnCdNm=dropMbrList.opt.gridControl.getSelectedRecords()[0].secsnResnCdNm;
	    	secsnResnEtc=dropMbrList.opt.gridControl.getSelectedRecords()[0].secsnResnEtc;
	    	reSbscResn=dropMbrList.opt.gridControl.getSelectedRecords()[0].reSbscResn;
	    	secsnDate=dropMbrList.opt.gridControl.getSelectedRecords()[0].secsnDate;
	    }
	
	    if ($.fn.ifvmIsNotEmpty(v_rid)) {
	    	 	$("#dropMemPopup").ifvsfPopup({
	   	      	enableModal : true,
	   	        enableResize: false,
	   	        contentUrl: '<ifvm:url name="dropMemPopup"/>',
	   	        contentType: "ajax",
	   	        title: '탈회상세사유',
	   	        width: '1000px',
	   	        close : 'dropMemPopupClose'
	   	   	 });
	    } else {
	    	alert('목록을 선택하세요.');	    
	   	}
	}
	
//미리보기 팝업 닫기
function dropMemPopupClose() {
	dropMemPopup._destroy();
}

function excelDownLoadBtn(){
  	$.ifvExcelDn('<ifvm:action name="dropMbrListExcelDown"/>','dropMbrListGrid');
}

$(document).ready(function() {

    dropMbrListSearchInit();
	getdropMbrListSearch();
    //조회
    $('#dropMbrListSearchBtn').on('click', function(){
     	dropMbrListSearch();
    });

    //초기화
    $("#dropMbrListSearchInitBtn").on('click', function(){
     	dropMbrListSearchInit('dropMbrListGrid');
    });
    
  	//마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
  	
  	//탈회 상세 사유 클릭시 
    $('#dropReasonPopBtn').on('click', function(){
    	dropReasonPopAction();
    });

  //마스킹해제 클릭시
    $('#secsnMbrToSbscAble').on('click', function(){
    	getDropConfirmMbrPop();
    });
  
    //상세 팝업
    $('#dropMbrDetailBtn').on('click', function(){
    	dropReasonPopAction();
    });
    
    //엑셀 다운
    $('#downLoadBtn').on('click', function(){
    	excelDownLoadBtn();
    });
  
});

</script>


<div class="page-title">
    <h1>
    	<spring:message code="L00719" />
 		&gt; <spring:message code="M00135" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" id="dropMbrListSearchBtn" btnType="search" text="L00081" objCode="dropMbrListSearchBtn_OBJ"/>
            <ifvm:inputNew type="button" id="dropMbrListSearchInitBtn" text="L00082" objCode="dropMbrListSearchInitBtn_OBJ"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="dropMbrListSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<button class="btn btn-sm" id="dropMbrDetailBtn" objCode="dropMbrDetailBtn_OBJ">
             	<spring:message code="상세" />
         	</button>
        	<button class="btn btn-sm" id="secsnMbrToSbscAble" objCode="secsnMbrToSbscAbleBtn_OBJ">
             	<spring:message code="식별키삭제" />
         	</button>
	     	<button class="btn btn-sm" id="clearMaskBtn" objCode="dropListclearMaskBtn_OBJ">
             	<spring:message code="L00326" />
         	</button>
        	<button class="btn btn-sm" id="downLoadBtn" objCode="dropMbrListDownLoadBtn_OBJ">
             	<spring:message code="다운로드" />
         	</button>         	
         	<!-- <button class="btn btn-sm" id="dropReasonPopBtn" objCode="dropReasonPopBtn_OBJ">
             탈회상세사유 
         	</button> -->
        </div>
    </div>
    <div id="dropMbrListGrid" class="white_bg grid_bd0"></div>
</div>


<div id="dropConfirmMbrPopup" class="popup_container"></div>
<div id="dropMemPopup" class="popup_container"></div>