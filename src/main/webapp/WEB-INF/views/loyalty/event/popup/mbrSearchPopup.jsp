<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var mbrSearchHelp;
var mbrsel_obj=null;
var first;
<%-- var mbrNo = decodeURIComponent('<%= request.getParameter("mbrNo") %>'); --%>
<%-- var mbrNm = decodeURIComponent('<%= request.getParameter("mbrNm") %>'); --%>
var obj = null;

$(document).ready(function() {
    //공통 조회 조건 목록 설정

    mbrSearchHelpSearchInit();
    getMbrSearchHelpSearch();


    /* $("#mbrSearchHelpSearchList .searchTextVal option:selected").filter(function(){
    	if($(this).attr('joinsrcclm') != "CUST_NM"){
    		$(this).parents('.SearchCondition').find('.searchCondition option[value="NOT"]').remove();
    		$(this).parents('.SearchCondition').find('.searchCondition option[value="LIKE"]').remove();
    	}
    }) */
    //조회
    $('#mbrSearchHelpSearchBtn').on('click', function(){
     	mbrSearchHelpSearch();
    });

    //초기화
    $("#mbrSearchHelpSearchInitBtn").on('click', function(){
     	mbrSearchHelpSearchInit();
    });

  /*   $.ifvEnterSetting(["#mbrSearchHelpSearchList input"], function(){
    	mbrSearchHelpSearch(first);
	}); */
});

//회원 SearchHelp
function getMbrSearchHelpSearch(){
    var ejGridOption = {
    	recordDoubleClick : function(data){
	      var data = mbrSearchHelp.getRowData()[data-1];
	      obj = data.data;
  		  choiceMbrFn();
        },
        rowSelected : function (data) {
        	obj = data.data;
        },
        serializeGridData : function(data) {
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
        	    data.hhpSearhFlag = "N";
            	for(var i = 0; i < requestitem.length; i++) {
            		//핸드폰 번호 암호화해서 조회하기
            		if (requestitem[i].srcCol == "HHP_NO"  && requestitem[i].whereVal != "") {
            			requestitem[i].whereVal= requestitem[i].whereVal.replaceAll("-", "");

        		    	data.hhpSearhFlag = "Y";
        		    	data.hhpSearhOpType = requestitem[i].operationType;
        		    	data.hhpSearhValue = requestitem[i].whereVal;

        		    	requestitem[i].whereVal = "";
            		}
            	}
                data.item = requestitem;
                data.first = first;
            }
            return data;
        },
        loadComplete : function(data) {
        	
        	//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
    		//$.fn.ifvmComCondLogging("PLOY_006", mbrSearchHelp.getRowData().length);
        	
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
		  },{
			  field : 'custRid', visible: false
		  },{
			  field : 'unMaskCustNm', visible: false
		  },{
			  field : 'unMaskHhp', visible: false
		  },{
			  field : 'unMaskEmail', visible: false
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
    mbrSearchHelp = $("#mbrSearchHelpGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}
//생년월일 구분자 추가
function insertDot(cellvalue, options, rowObject){
	if(cellvalue){
		return cellvalue.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
	}
	else{
		return "";
	}
}
//공통 조회 조건 목록 설정
function mbrSearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("mbrSearchHelpSearchList","LOY_MBR_NEW_LIST");
}

//공통 조회 호출
function mbrSearchHelpSearch() {
	$.fn.ifvmSubmitSearchCondition("mbrSearchHelpSearchList",function(bool){
 		bool ? alert('최소 1개의 조회조건을 입력해주세요.') : mbrSearchHelp.searchGrid({item: requestitem});
 	});
}

//팝업 닫기
function emptyPopClose() {
 $('#emptyDialog').ejDialog('destroy');
}

function retrunMbr() {
	gMbrSearchHelp.close();
}

/* function defaultSearch() {

    if (typeof mbrNo != "undefined" && mbrNo != "undefined" && $.fn.ifvmIsNotEmpty(mbrNm) && mbrNo != "null") {
        first = '';

        $("#pop_main_div_mbr .SearchCondition .searchTextVal option:selected").filter(function() {
            if ($(this).attr('joinsrcclm') == "MBR_NO") {
                $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(mbrNo)
            }
        });
    }

    if (typeof mbrNm != "undefined" && mbrNm != "undefined" && $.fn.ifvmIsNotEmpty(mbrNm) && mbrNm != "null") {
        first = '';

        $("#pop_main_div_mbr .SearchCondition .searchTextVal option:selected").filter(function() {
            if ($(this).attr('joinsrcclm') == "CUST_NM") {
                $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(mbrNm)
            }
        });
    }
} */

/* function defaultSearchClose() {
    if (typeof mbrNo != "undefined" && mbrNo != "undefined" && $.fn.ifvmIsNotEmpty(mbrNo) && mbrNo != "null") {
        if (mbrSearchHelp.getRowData().length == 1) {
            mbrSearchHelpPop.close(mbrSearchHelp.getRowDatas(1));
        }
        mbrNo = "null";
    }

    if (typeof mbrNm != "undefined" && mbrNm != "undefined" && $.fn.ifvmIsNotEmpty(mbrNm) && mbrNm != "null") {
        if (mbrSearchHelp.getRowData().length == 1) {
            mbrSearchHelpPop.close(mbrSearchHelp.getRowDatas(1));
        }
        mbrNm = "null";
    }
} */

//선택
function choiceMbrFn() {
	if (obj != null) {
		mbrsel_obj = obj;
		validWinnerTransfer(mbrsel_obj);
		requestitem = null;
		mbrSearchHelpPop.close();
	}
	else {
		alert('<spring:message code="L01393" />');
		return;
	}
}

//당첨자 중복체크
function validWinnerTransfer(mbrsel_obj){
	if(mbrsel_obj != null){
		$.ifvSyncPostJSON('<ifvm:action name="validWinnerTransfer"/>',{
			mbrNo : mbrsel_obj.mbrNo,
			rid : eventRid
		},function(result){
			insertEvtWinner(mbrsel_obj);
		},function(result){
			alert('이미 당첨된 회원입니다.');
			requestitem = null;
		});
	}else{
		alert('목록을 선택해주세요.');
	}
}

//당첨자 저장
function insertEvtWinner(mbrsel_obj){
	$.ifvSyncPostJSON('<ifvm:action name="insertEvtWinner"/>',{
		ridMbr : mbrsel_obj.rid,
		mbrNo : mbrsel_obj.mbrNo,
		rid : eventRid
	},function(result){
		if(result.success == true){
			alert('저장되었습니다.');			
		}
	});
}

//닫기
function cancelMbrSearchHelpFn() {
	requestitem = null;
	mbrSearchHelpPop.close();
}

</script>

<div id="pop_main_div_mbr">
	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <button class="btn btn-sm" id="mbrSearchHelpSearchBtn"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	            <button class="btn btn-sm" id="mbrSearchHelpSearchInitBtn">
	                <spring:message code="M00278" />
	            </button>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="mbrSearchHelpSearchList" ></div>
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
	    <div id="mbrSearchHelpGrid"></div>
	</div>

	<div id="emptyDialog" class="popup_container"></div>

	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceMbrBtn" btnFunc="choiceMbrFn"/>
		<ifvm:inputNew type="button"   text="M00441"  id="cancelMbrSearchHelpBtn" btnFunc="cancelMbrSearchHelpFn"/>
	</div>
</div>