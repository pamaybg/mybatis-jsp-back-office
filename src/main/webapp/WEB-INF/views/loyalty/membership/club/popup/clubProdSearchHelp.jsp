<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script type="text/javascript">
var prodSearchHelp;
var gridIdprodSearchHelp;
var rid ;
var prodObj=null;
var catNm = decodeURIComponent('<%= cleanXss(request.getParameter("catNm")) %>');

//
function getprodSearchHelpSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var data = prodSearchHelp.getRowData()[data-1];
      rid = data.rid;

      //emptyDtlPop();   // 상세 보기 이벤트


        },
        onSelectRow : function (data) {
        	prodObj=data;
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(data){
         	if(data.rows.length==1){
        		prodObj = data.rows[0];
        		choiceProdFn();
        	}
        	defaultSearchClose();
        },
        url : '<ifvm:action name="getClubProdSearchHelp"/>',
        colNames:[
                   '<spring:message code="L00291" />',
                   '<spring:message code="L00792" />',
                   '<spring:message code="L00793" />',
                   '<spring:message code="L00795" />',
                   'rid',
                   'ridProdCat'
                 ],
        colModel:[
             { name:'catNm',   index:'lpc.CAT_NM',  resizable : true, align:'center',    width:'100px' },
             { name:'prodId',   index:'a.prod_id',  resizable : true, align:'center',    width:'100px' },
             { name:'prodNm',   index:'a.prod_nm',  resizable : true, align:'left',    width:'250px' },
             { name:'desc1',   index:'a.desc1',  resizable : true, align:'center',    width:'100px' },
             { name:'rid',    index:'a.rid',    hidden : true},
             { name:'ridProdCat',    index:'lpc.RID',    hidden : true}
        ],
        radio : true,
        sortname: 'lpc.CAT_NM',
        sortorder: "desc",

    };

    prodSearchHelp = $("#prodSearchHelpGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdprodSearchHelp = $("#gridIdprodSearchHelp");
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    return tag;
}

function goGridRowChnlLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}

function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    return tag;
}


//공통 조회 조건 목록 설정
function prodSearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("prodSearchHelpSearchList","PLOY_022");
}

//공통 조회 호출
function prodSearchHelpSearch() {
    $.fn.ifvmSubmitSearchCondition("prodSearchHelpSearchList", getprodSearchHelpSearch);
}

// 상세 팝업 화면 호출
function emptyDtlPop(){

 $("#emptyDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="empty"/>',
        contentType: "ajax",
        title: 'empty',
        width: "1000px",
        close : 'emptyPopClose'
    });
}

//팝업 닫기
function emptyPopClose() {
	emptyDialog._destroy();
}

//고객 상세 이동
function emptyDtl() {
    qtjs.href('<ifvm:url name="empty"/>' + '?rid=' + rid);
}

function defaultSearch(){
	 if(typeof catNm != "undefined" && catNm != "undefined"
		 && $.fn.ifvmIsNotEmpty(catNm) && catNm != "null") {
		 first ='';

		$("#pop_main_div_prod .SearchCondition .searchTextVal option:selected").filter(function(){
			if($(this).attr('joinsrcclm') == "CAT_NM"){ $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(catNm)}
			})

		}



}
function defaultSearchClose(){
	 if(typeof prodNm != "undefined" && prodNm != "undefined"  && $.fn.ifvmIsNotEmpty(prodNm) && prodNm != "null") {
		if(prodSearchHelp.getRowData().length==1){
			prodSearchHelpPop.close(prodSearchHelp.getRowDatas(1));
		}
		prodNm = "null";
	 }


}


//선택
function choiceProdFn(){
	if(prodObj==null){
		alert('<spring:message code="L01393" />');
		return;
	}
	prodSearchHelpPopSave(prodObj);
}
//닫기
function cancelProdSearchHelpFn(){
	prodSearchHelpPop.close();
}




$(document).ready(function() {

    //공통 조회 조건 목록 설정
    prodSearchHelpSearchInit();
    defaultSearch();
    prodSearchHelpSearch();
    //조회
    $('#prodSearchHelpSearchBtn').on('click', function(){
     prodSearchHelpSearch();
    });

    //초기화
    $("#prodSearchHelpSearchInitBtn").on('click', function(){
     prodSearchHelpSearchInit();
    });


    $.ifvEnterSetting(["#prodSearchHelpSearchList input"], function(){
    	prodSearchHelpSearch();
	});


});

</script>


<div id="pop_main_div_prod">
	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <button class="btn btn-sm" id="prodSearchHelpSearchBtn"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	            <button class="btn btn-sm" id="prodSearchHelpSearchInitBtn">
	                <spring:message code="M00278" />
	            </button>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="prodSearchHelpSearchList" >
	    </div>
	</div>

	<div>
	    <div class="page_btn_area" >
	        <div class="col-xs-7">
	            <span><spring:message code="M00277" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	        </div>
	    </div>
	    <div id="prodSearchHelpGrid" class="white_bg grid_bd0"></div>
	</div>


	<div id="emptyDialog" class="popup_container"></div>
	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceProdBtn" btnFunc="choiceProdFn"/>
		<ifvm:inputNew type="button"   text="M00441"  id="cancelProdSearchHelpBtn" btnFunc="cancelProdSearchHelpFn"/>
	</div>
</div>