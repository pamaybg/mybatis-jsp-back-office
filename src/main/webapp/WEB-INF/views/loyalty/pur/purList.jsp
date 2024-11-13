<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<script type="text/javascript">

var purList;
var rid = null;

function getPurSearch() {
    var ejGridOption = {
        rowSelected : function (data) {
        	rid = data.rid;
        },
       serializeGridData : function(data) {
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){
        },
        dataUrl : '<ifvm:action name="getPurList"/>',
        columns:[
	          {
	      		  field : 'txnUniqNo',
	      		  headerText : '구매번호',
	      		  headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lp.txn_uniq_no' }
	      	  },{
	      		  field : 'slDate',
	      		  headerText : '구매일자',
	      		  headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lp.sl_date' }
	      	  },{
	      		  field : 'mbrNo',
	      		  headerText : '회원번호',
	      		  headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lp.mbr_no' }
	      	  },{
	      		  field : 'custNm',
	      		  headerText : '회원명',
	      		  headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lc.cust_nm' }
	      	  },{
	      		  field : 'payAmt',
	      		  headerText : '결제금액',
	      		  headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lp.pay_amt' }
	      	  },{
	      		  field : 'chnlNo',
	      		  headerText : '채널번호',
	      		  headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lp.chnl_no' }
	      	  },{
	      		  field : 'chnlNm',
	      		  headerText : '채널명',
	      		  headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'lch.chnl_nm' }
	      	  },{
	      		  field : 'purStat',
	      		  headerText : '구매상태',
	      		  headerTextAlign : 'center',
	      		  customAttributes : {
	      			sortable : false,
	      			index : 'cc1.mark_name' }
	      	  },{
	      		  field : 'payMethd',
	      		  headerText : '결제수단',
	      		  headerTextAlign : 'center',
	      		  customAttributes : {
	      			  sortable : false,
	      			  index : 'cc2.mark_name' }
	      	  },{
	      		  field : 'ridPur',
	      		  headerText : 'ridPur',
	      		  visible : false, 
	      		  customAttributes : {
	      			  index : 'lp.rid' }
	      	  },{
	      		  field : 'ridPurPay',
	      		  headerText : 'ridPurPay',
	      		  visible : false ,
	      		  customAttributes : {
	      			  index : 'lpp.rid' }
	      	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lp.sl_date',
      	  sord : 'desc',
      	  _search : false
        },
        gridDataInit: false,
        rowList : [10,25,50,100],
        radio: true
    };
    purList = $("#purListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function purListSearchInit() {
    $.fn.ifvmSetCommonCondList("purSearchCond", "DEMO_PUR_LIST");
    searchInitialize();
}

function searchInitialize() {
	//$(".SearchCondition .searchCondition option[value='LIKE']").remove();
	$(".SearchCondition .searchCondition option[value='NOT']").remove();
	$(".datepicker").val("");
}

function commSearchEventFn() {
    $('.itemPlusBtn').live('click', function() {
   		searchInitialize();
    })
    $('.itemMinusBtn').live('click', function() {
   	 	searchInitialize();
    })
    $('.searchTextVal').live('change', function() {
   		searchInitialize();
    });
}

//공통 조회 호출
function purListSearch() {
	var searchValidation =true ;

	if(!dateCondUniqueCheck()) {
		alert('<spring:message code="L02016" />');
		searchValidation=false;
	}

	if(searchValidation) {
	    $.fn.ifvmSubmitSearchCondition("purSearchCond", function() {
	    	purList.searchGrid({item: requestitem});
	    });
	} else {
		$("#purListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	}
}

//누락포인트 조정 팝업
function missingPointAcrlPop() {
	$("#missingPointAcrlDialog").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: '<ifvm:url name="missingPointAcrlPop"/>',
		contentType: "ajax",
		title: '누락포인트 조정',
		width: '700px',
		close: 'missingPointAcrlPopClose'
	});
}

//팝업 닫기
function missingPointAcrlPopClose() {
	missingPointAcrlDialog._destroy();
}

function dateCondUniqueCheck() {
	var uniqueCheck = [];
	var uniqueValid=true;
	$(".SearchCondition .searchTextVal option:selected").filter(function(){
		if(  $(this).val()=="DATE" &&   $(this).parents('.SearchCondition').css("display")	!="none"){
			$(this).attr('joinsrcclm');
			uniqueCheck.push($(this).attr('joinsrcclm'));
		}
	})
	for(var i=0; i<uniqueCheck.length; i++){
		for(var j=0; j<i;j++){
			if(uniqueCheck[i]==uniqueCheck[j]){
				uniqueValid=false;
			}
		}
	}
	return uniqueValid;
}

$(document).ready(function() {
    //공통 조회조건 목록 설정
    purListSearchInit();
    
    //구매목록 그리드 설정
	getPurSearch();
    
    //포인트 상세팝업 호출
    $("#missingPointAcrlPopBtn").on("click",function(){
    	//if(rid!=null){
    		missingPointAcrlPop();
    	//}else{
    		//alert('<spring:message code="L01820" />');
    	//}
    });
    
    //공통 조회조건 추가 제어 기능
    commSearchEventFn();
});

</script>

<div class="page-title">
    <h1>
        구매 리스트 &gt;&nbsp;&nbsp;&nbsp;조회
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="purListSearchBtn" btnFunc="purListSearch"/>
            <ifvm:inputNew type="button"   text="M00278"  id="purListSearchInitBtn" btnFunc="purListSearchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="purSearchCond">
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L00084" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search" text="누락포인트 조정" nuc="true" id="missingPointAcrlPopBtn" disabled="true" />
        </div>
    </div>
    <div id="purListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="missingPointAcrlDialog" class="popup_container"></div>