<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var clubBenfSearchHelp;
var gridIdclubBenfSearchHelp;
var rid ;
var clubBenfObj=null;
<%-- var prodNm = decodeURIComponent('<%= request.getParameter("prodNm") %>') --%>

//
function getclubBenfSearchHelpSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
        },
        onSelectRow : function (data) {
        	clubBenfObj=data;
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(data){
        },
        url : '<ifvm:action name="getClubBenfSearchList"/>',

        colNames:[
                   '혜택유형',
                   '혜택명',
                   '시작일',
                   '종료일',
                   '등록자',
                   '등록일시',
                   'rid'
                 ],
        colModel:[
                  { name:'typeNm', 			index:'cc1.MARK_NAME',  				width:'170px', 	align: 'center', 		resizable : true, sortable:false },
                  { name:'name', 			index:'lcb.name',  						width:'350px', 	align: 'left', 		resizable : true, sortable:false },
                  { name:'validStartDate', 	index:'lcb.VALID_START_DATE', 	     	width:'100px', 	align: 'center', 	resizable : true, sortable:false  ,formatter:'date', formatoptions:{newformat:"Y-m-d"}},
                  { name:'validEndDate',    index:'lcb.VALID_END_DATE', 		 	width:'100px', 	align: 'center', 	    resizable : true, sortable:false ,formatter:'date', formatoptions:{newformat:"Y-m-d"} },
                  { name:'createBy',  		index:'ce.name', 						width:'100px',	align: 'center', 	resizable : true, sortable:false   },
                  { name:'createDate',    	index:'lcb.CREATE_DATE',   				width:'100px',	align: 'center', 	resizable : true, sortable:false ,formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
                  { name:'rid', 			index:'lcb.RID', 			 	hidden : true },
              ],
        sortname: 'lcb.create_date',
        sortorder: "desc",
        multiselect: true,
    };

    clubBenfSearchHelp = $("#clubBenfSearchHelpGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdclubBenfSearchHelp = $("#gridIdclubBenfSearchHelp");
}


function gridDataSetFlag(cellValue) {
    if (cellValue == '1') return 'Y';
    else return 'N';
}


//공통 조회 조건 목록 설정
function clubBenfSearchHelpSearchInit() {
    $.fn.ifvmSetCommonCondList("clubBenfSearchHelpSearchList","CLUB_BENF");
}

//공통 조회 호출
function clubBenfSearchHelpSearch() {
    $.fn.ifvmSubmitSearchCondition("clubBenfSearchHelpSearchList", getclubBenfSearchHelpSearch);
}



function defaultSearch(){

	 if(typeof clubBenfNm != "undefined" && clubBenfNm != "undefined"
		 && $.fn.ifvmIsNotEmpty(clubBenfNm) && clubBenfNm != "null") {
		 first ='';

		$("#pop_main_div_clubBenf .SearchCondition .searchTextVal option:selected").filter(function(){
			if($(this).attr('joinsrcclm') == "clubBenf_NM"){ $(this).parents('.SearchCondition').find('.changeTypeAreaCode input').val(clubBenfNm)}
			})
		}
}


//선택
function choiceclubBenfFn(){
	if(clubBenfObj!=null){
		clubBenfSearchHelpPop.close(clubBenfObj);
	}else{
		alert('<spring:message code="L01393" />');
	}
}
//닫기
function cancelclubBenfSearchHelpFn(){
	clubBenfSearchHelpPop.close();
}




$(document).ready(function() {

    //공통 조회 조건 목록 설정
    clubBenfSearchHelpSearchInit();
    defaultSearch();
    clubBenfSearchHelpSearch();
    //조회
    $('#clubBenfSearchHelpSearchBtn').on('click', function(){
    	clubBenfSearchHelpSearch();
    });

    //초기화
    $("#clubBenfSearchHelpSearchInitBtn").on('click', function(){
    	clubBenfSearchHelpSearchInit();
    });


    $.ifvEnterSetting(["#clubBenfSearchHelpSearchList input"], function(){
    	clubBenfSearchHelpSearch();
	});

});

</script>

<div id="pop_main_div_clubBenf">
	<div>
	    <div class="page_btn_area">
	        <div class="col-xs-7">
	            <span><spring:message code="L01838" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	            <button class="btn btn-sm" id="clubBenfSearchHelpSearchBtn"><i class="fa fa-search"></i>
	                <spring:message code="M00135" />
	            </button>
	            <button class="btn btn-sm" id="clubBenfSearchHelpSearchInitBtn">
	                <spring:message code="M00278" />
	            </button>
	        </div>
	    </div>
	    <div class="well form-horizontal well_bt5" id="clubBenfSearchHelpSearchList" >
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
	    <div id="clubBenfSearchHelpGrid" class="white_bg grid_bd0"></div>
	</div>


	<div id="emptyDialog" class="popup_container"></div>
	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnType="save"  text="C00038"  id="choiceclubBenfBtn" btnFunc="choiceclubBenfFn"/>
		<ifvm:inputNew type="button"   text="M00441"  id="cancelclubBenfSearchHelpBtn" btnFunc="cancelclubBenfSearchHelpFn"/>
	</div>
</div>
