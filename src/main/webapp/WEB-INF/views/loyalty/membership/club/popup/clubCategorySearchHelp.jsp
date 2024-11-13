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

var clubCategorySearchHelp;
var gridIdclubCategorySearchHelp;
var rid ;
var clubCategoryObj=null;
var clubCategoryNm = decodeURIComponent('<%= cleanXss(request.getParameter("clubCategoryNm")) %>')

//
function getclubCategorySearchHelpSearch(){
	var jqGridOption = {
	       	ondblClickRow : function(data){
	       		var data = categoryListGrid.getRowData()[data-1];
	       		rid = data.rid;
	       		catId = data.catId;
	       		categoryDtlPop();
	       	},

	        onSelectRow : function (data) {
	        	clubCategoryObj=data;
	       	},
	      	serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	                data.item = requestitem;
	            }
	            return data;
	       	},
	       	loadComplete : function(obj){
	       	},
	        url : '<ifvm:action name="getCategoryList"/>',
	        colNames:[
	                   '<spring:message code="M01962" />',
	                   '<spring:message code="L00291" />',
	                   '<spring:message code="M01964" />',
	                   '<spring:message code="M00184" />',
	                   '<spring:message code="M00185" />',
	                   'rid'
	                 ],
	        colModel:[
	            { name:'catId', index:'lpc.cat_id', align:'center', resizable : false },
	            { name:'catNm', index:'lpc.cat_nm', align:'center', resizable : false },
	            { name:'catDesctxt', index:'lpc.cat_desctxt', resizable : false},
	            { name:'createBy', index:'e.NAME', align:'center',  resizable : false},
	            { name:'createDate', index:'lpc.create_date', resizable : false, align:'center'},
	            { name:'rid', index:'lpc.rid', hidden : true}
	        ],
	        sortname: 'lp.create_date',
	        sortorder: "desc",
	        radio : true,
	    };

	clubCategorySearchHelp = $("#clubCategorySearchHelpGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdclubCategorySearchHelp = $("#gridIdclubCategorySearchHelp");
}



//공통 조회 조건 목록 설정
function clubCategorySearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("clubCategorySearchHelpSearchList","PLOY_024");
}

//공통 조회 호출
function clubCategorySearchHelpSearch() {
    $.fn.ifvmSubmitSearchCondition("clubCategorySearchHelpSearchList", getclubCategorySearchHelpSearch);
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


	 if(typeof clubCategoryNm != "undefined" && clubCategoryNm != "undefined"
		 && $.fn.ifvmIsNotEmpty(clubCategoryNm) && clubCategoryNm != "null") {
		 first ='';

		$("#pop_main_div_clubCategory .SearchCondition .searchTextVal option:selected").filter(function(){
			if($(this).attr('joinsrcclm') == "clubCategory_NM"){ $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(clubCategoryNm)}
			})

		}



}
function defaultSearchClose(){
	 if(typeof clubCategoryNm != "undefined" && clubCategoryNm != "undefined"  && $.fn.ifvmIsNotEmpty(clubCategoryNm) && clubCategoryNm != "null") {
		if(clubCategorySearchHelp.getRowData().length==1){
			clubCategorySearchHelpPop.close(clubCategorySearchHelp.getRowDatas(1));
		}
		clubCategoryNm = "null";
	 }


}


//선택
function choiceclubCategoryFn(){
	if(clubCategoryObj==null){
		alert('<spring:message code="L01393" />');
		return;
	}
	clubCategorySearchHelpPopSave(clubCategoryObj);
}
//닫기
function cancelclubCategorySearchHelpFn(){
	clubCategorySearchHelpPop.close();
}




$(document).ready(function() {

    //공통 조회 조건 목록 설정
    clubCategorySearchHelpSearchInit();
    defaultSearch();
    clubCategorySearchHelpSearch();
    //조회
    $('#clubCategorySearchHelpSearchBtn').on('click', function(){
    	clubCategorySearchHelpSearch();
    });

    //초기화
    $("#clubCategorySearchHelpSearchInitBtn").on('click', function(){
    	clubCategorySearchHelpSearchInit();
    });


    $.ifvEnterSetting(["#clubCategorySearchHelpSearchList input"], function(){
    	clubCategorySearchHelpSearch();
	});


});

</script>


<div id="pop_main_div_clubCategory">
	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <button class="btn btn-sm" id="clubCategorySearchHelpSearchBtn"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	            <button class="btn btn-sm" id="clubCategorySearchHelpSearchInitBtn">
	                <spring:message code="M00278" />
	            </button>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="clubCategorySearchHelpSearchList" >
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
	    <div id="clubCategorySearchHelpGrid" class="white_bg grid_bd0"></div>
	</div>


	<div id="emptyDialog" class="popup_container"></div>
	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceclubCategoryBtn" btnFunc="choiceclubCategoryFn"/>
		<ifvm:inputNew type="button"   text="M00441"  id="cancelclubCategorySearchHelpBtn" btnFunc="cancelclubCategorySearchHelpFn"/>
	</div>
</div>
