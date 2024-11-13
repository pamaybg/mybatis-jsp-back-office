<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal top_well underline">
   <div class="page_btn_area">
	   <div class="col-xs-7">
	   </div>
       <div class="col-xs-5 searchbtn_r">
           <button class="btn btn-sm" id="searchCondBtn" objCode="searchFamilyMbrSearch_OBJ"><i class="fa fa-search"></i>
               <spring:message code="L00081"/>
           </button>
           <button class="btn btn-sm" id="searchCondInitBtn" objCode="searchFamilyMbrSearchInit_OBJ">
               <spring:message code="L00082"/>
           </button>
           <button class="btn btn-sm" id="clearMaskBtn" objCode="searchFamilyMbrClearMask_OBJ">
           	<spring:message code="L00326"/>
           </button>
       </div>
   	</div>
   	<div class="well form-horizontal well_bt5" id="commSearchList" ></div>
</div>
<div id="mbrListPopGrid"></div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="selectMbrBtn" objCode="searchFamilyMbrSelect_OBJ">
        <i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00123"/>
    </button>
    <button class="btn btn-sm btn_lightGray2" id="cancelPopBtn" objCode="searchFamilyMbrCancel_OBJ">
    <spring:message code="L00124"/>
    </button>
</div>


<script type="text/javascript">
var mbrListPopGrid;

function getMbrList(){
	var ejGridOption = {
        loadComplete : function(obj){
    		//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
    		//$.fn.ifvmComCondLogging("LOY_MBR_NEW_LIST", mbrListPopGrid.opt.data.records);
        },
		serializeGridData : function(data) {
			data.ridPgm = $("#loyPgmRid").val();
			return data;
		},recordDoubleClick : function(args){
			var data = args.data;
		},rowSelected : function (args) {
			var data = args.data;
    	},
	    dataUrl : '<ifvm:action name="getMbrListPop"/>',
	    columns : [
	    	{
	  		  field : 'mbrNo', headerText : '회원번호', textAlign : 'center', customAttributes : { searchable : true }
	  	  },{
			  field : 'custNm', headerText : '회원명',  textAlign : 'center',customAttributes : { searchable : true }
		  },{
			  field : 'hhp', headerText : '전화번호',  textAlign : 'center',customAttributes : { searchable : true }
		  },{
			  field : 'email', headerText : '이메일',  textAlign : 'center',customAttributes : { searchable : true }
		  },{
			  field : 'mbrTypeCdNm', headerText : '유형',  textAlign : 'center', customAttributes : { index : 'mbrTypeCd' }
		  },{
			  field : 'mbrStatCdNm', headerText : '상태',  textAlign : 'center', customAttributes : { index : 'mbrStatCd' }, visible : false
		  },{
			  field : 'sbscDate', headerText : '가입일',  textAlign : 'center', customAttributes : { searchable : true }, visible : false
		  },{
			  field : 'ridsbscChnl', headerText : '가입채널', customAttributes : { searchable : true }, visible : false
		  }, {
			  field : 'createDate', headerText : '등록일시',  textAlign : 'center', visible : false
		  },{
			  field : 'rid', visible: false
		  }
	    ],
	    requestGridData : {
	  	  nd   : new Date().getTime(),
	  	  rows : 10,
	  	  sidx : '1',
	  	  sord : 'desc',
	  	  _search : false,
	    },
	    rowList : [10,25,50,100],
	    gridDataInit: false,
	    radio: true,
	    tempId : 'ifvGridSimplePageTemplete'
	};
	mbrListPopGrid = $("#mbrListPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


//마스크해제
 function clearMaskAction() {
  var v_rid;
  if ($.fn.ifvmIsNotEmpty(mbrListPopGrid.opt.gridControl.getSelectedRecords()[0])) {
  	v_rid = mbrListPopGrid.opt.gridControl.getSelectedRecords()[0].rid;
  }
  else {
      alert('<spring:message code="M02219"/>');
  }
  if ($.fn.ifvmIsNotEmpty(v_rid)) {
      $.ifvSyncPostJSON('<ifvm:action name="clearMaskMbrNew"/>', {
          rid: v_rid
      },
      function(result) {
      	var gridObj = mbrListPopGrid.opt.gridControl;
      	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.hhp);
      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('email'), result.email);
      });
  }
}

//공통 조회 조건 목록 설정
 function searchCondInit(gridId) {
     $.fn.ifvmSetCommonCondList("commSearchList","LOY_MBR_NEW_LIST",gridId);
 }

 //공통 조회 호출
 function mbrListSearch() {
 	$.fn.ifvmSubmitSearchCondition("commSearchList",function(bool){
 		bool ? alert('최소 1개의 조회조건을 입력해주세요.') : mbrListPopGrid.searchGrid({item: requestitem});
 	});
 }

$(document).ready(function(){
	searchCondInit();
	getMbrList();
	
  	//조회
    $('#searchCondBtn').on('click', function(){
    	mbrListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit("mbrListPopGrid");
    });
	
  	//취소 클릭시
    $('#cancelPopBtn').on('click', function(){
    	searchCondInit("mbrListPopGrid");
    	$.fn.ifvmPopupClose();
    });

	//선택 클릭시
    $('#selectMbrBtn').on('click', function(){

    	if(mbrListPopGrid.opt.gridControl.getSelectedRecords() == ''){
    		alert('<spring:message code="L00117"/>');
    	}else {
    		var dataArr = mbrListPopGrid.opt.gridControl.getSelectedRecords();
    		$("#mbrNoF").val(dataArr[0].mbrNo);
    		$("#custNmF").val(dataArr[0].custNm);
    		searchCondInit("mbrListPopGrid");
    		$.fn.ifvmPopupClose();
    	}
    }); 

    //마스킹해제 클릭시
   $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });

});
</script>
