<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var mbrTransFer;
var gridIdmbrTransFer;
var pntPreUse;
var pntUse;
var tgtCustNm;

$(document).ready(function() {
    //공통 조회 조건 목록 설정
    mbrTransFerSearchInit();


    getPoinTransMbrSearch();
//     first = 'X';
//     defaultSearch();
//     mbrTransFerSearch();
//     first = '';

//     $("#mbrTransFerSearchList .searchTextVal option:selected").filter(function(){
//     	if($(this).attr('joinsrcclm') != "CUST_NM"){
//     		$(this).parents('.SearchCondition').find('.searchCondition option[value="NOT"]').remove();
//     		$(this).parents('.SearchCondition').find('.searchCondition option[value="LIKE"]').remove();
//     	}
//     })
    //조회
    $('#mbrTransFerSearchBtn').on('click', function(){
     	mbrTransFerSearch();
    });
    //초기화
    $("#mbrTransFerSearchInitBtn").on('click', function(){
     	mbrTransFerSearchInit('mbrTransFerGrid');
    });
    getPoinTransMbrSearch();
    $.ifvEnterSetting(["#mbrTransFerSearchList input"], function(){
    	mbrTransFerSearch();
	});
});

//회원 SearchHelp
function getPoinTransMbrSearch(){
    var ejGridOption = {
        serializeGridData : function(data) {
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
//         onSelectCell : function(data) {
//         	mbrsel_obj	= data;
//         },
//         loadComplete : function(data) {
//         	if (data.rows.length == 1) {
//         		obj = data.rows[0];
//         		choiceMbrFn();
//         	}
//         	defaultSearchClose();
//         },
        dataUrl : '<ifvm:action name="selectTransList"/>',
        columns:[
        	 {
	      		  field : 'mbrStatCd', headerText : '구분', headerTextAlign : 'center', textAlign : 'center', width : '90px',
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : '' }//
	      	  },  {
	      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			sortable : false,
	      			index : '' }//
	      	  },{
	      		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'center', width : '120px',
	      		  customAttributes : {
	      			sortable : false,
	      			  index : '' }//
	      	  },{
	      		  field : 'hhpNo', headerText : '휴대폰', headerTextAlign : 'center', textAlign : 'center', width : '120px',
	      		  customAttributes : {
	      			sortable : false,
	      			index : '' }//
	      	  }, {
	      		  field : 'emailAddr', headerText : '이메일', headerTextAlign : 'center',  width : '160px',
	      		  customAttributes : {
	      			sortable : false,
	      			  index : '' }//
	      	  },  {
	      		  field : 'birthDt', headerText : '생년월일', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			sortable : false,
	      			  index : '' }//
	      	  },  {
	      		  field : 'pntPreUse', headerText : '적립예정포인트', headerTextAlign : 'center', textAlign : 'right', width : '120px', format : '{0:n0}',
	      		  customAttributes : {
	      			sortable : false,
	      			  index : '' }//
	      	  }, {
	      		  field : 'pntUse', headerText : '사용가능포인트', headerTextAlign : 'center', textAlign : 'right', width : '120px', format : '{0:n0}',
	      		  customAttributes : {
	      			sortable : false,
	      			  index : '' }//
	      	  }, {
	      		  field : 'ridMbr', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : '' }//
	      	  }, {
	      		  field : 'cdFlag', headerText : 'cdFlag', visible : false,
	      		  customAttributes : {
	      			  index : '' }//
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
// 	      	  sidx : 'mbrrid',
//               sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true,
	        gridDataInit: false,
      		tempId : 'ifvOnlyGridTemplate'
  	};
    mbrTransFer = $("#mbrTransFerGrid").ifvsfGrid({ ejGridOption : ejGridOption });
//     gridIdmbrTransFer = $("#gridIdmbrTransFer");
//     poinTransMbrPop.resize();
}
//공통 조회 조건 목록 설정
function mbrTransFerSearchInit(gridId) {
    $.fn.ifvmSetCommonCondList("mbrTransFerSearchList","PGM_L_113",gridId);
//     searchInitialize();
}

//공통 조회 호출
function mbrTransFerSearch() {
	 $.fn.ifvmSubmitSearchCondition("mbrTransFerSearchList",function(bool){
		bool ? alert('최소 1개의 조회조건을 입력해주세요.') : mbrTransFer.searchGrid({item: requestitem});
	});



}

//팝업 닫기
function popupClose() {
	popupContainer._destroy();
}

function transferPointConfirmPop(rid,cdFlag){
	var contentUrl = '<ifvm:url name="TransferPointConfirmPop"/>';
	var title ='포인트 이관';

	if(rid != '') contentUrl += '?rid='+rid+'&cdFlag='+cdFlag;

	var popWidth = 600;
	var posx = Math.ceil((window.innerWidth - popWidth)/2);
    $("#transferPointConfirmPopup").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl: contentUrl,
		contentType: "ajax",
		position: {X:posx, Y: 100},
		title: title,
		width: popWidth,
		close : 'popupClose'
    });
}
// //선택
function choiceMbrFn() {
	 var v_rid;
	 var v_cdFlag;
	 if($.fn.ifvmIsNotEmpty(mbrTransFer.opt.gridControl.getSelectedRecords()[0])) {
		 v_rid = mbrTransFer.opt.gridControl.getSelectedRecords()[0].ridMbr;
		 v_cdFlag =mbrTransFer.opt.gridControl.getSelectedRecords()[0].cdFlag;
		 pntPreUse = mbrTransFer.opt.gridControl.getSelectedRecords()[0].pntPreUse;
		 pntUse = mbrTransFer.opt.gridControl.getSelectedRecords()[0].pntUse;
		 tgtCustNm = mbrTransFer.opt.gridControl.getSelectedRecords()[0].custNm;
		 if (v_rid != mbr_rid){
			 transferPointConfirmPop(v_rid,v_cdFlag);
		 }else{
			 alert('이관 대상자와 적립 대상자가 동일인 입니다.')
		 }
	 }
	 else{
		 alert('포인트 이관 대상자를 선택해 주세요.')
	 }

}
function popupClose() {
	transferPointConfirmPopup._destroy();
}

//닫기
function cancelmbrTransFerFn() {
	poinTransMbrPop.close();
}

</script>

<div id="pop_main_div_mbr">
	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <button class="btn btn-sm" id="mbrTransFerSearchBtn"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	            <button class="btn btn-sm" id="mbrTransFerSearchInitBtn">
	                <spring:message code="M00278" />
	            </button>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="mbrTransFerSearchList" ></div>
	</div>

	<div class="page_btn_area" >
		<div class="col-xs-12">* 휴대폰 전체검색시 [-] 없이 입력 후 검색하세요. </div>
<!-- 		<div class="col-xs-12">* 휴대폰 Like 검색은 휴대폰번호 뒷자리 4자리만 검색 가능합니다.</div> -->
	</div>

	<div>
	    <div class="page_btn_area" >
	        <div class="col-xs-7">
	            <span><spring:message code="M00277" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	        </div>
	    </div>
	    <div id="mbrTransFerGrid" class="white_bg grid_bd0"></div>
	</div>

	<div id="emptyDialog" class="popup_container"></div>

	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnType="save"  text="D10225"  id="choiceMbrBtn" btnFunc="choiceMbrFn"/>
		<ifvm:inputNew type="button"   text="M00441"  id="cancelmbrTransFerBtn" btnFunc="cancelmbrTransFerFn"/>
	</div>
</div>
<div id="transferPointConfirmPopup" class="popup_container"></div><!-- 팝업 -->