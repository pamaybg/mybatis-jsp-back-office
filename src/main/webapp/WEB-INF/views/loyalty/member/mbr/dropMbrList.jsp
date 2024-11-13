<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var dropMbrList;
var gridIddropMbrList;
var rid ;

//탈회 회원 조회
function getdropMbrListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
	      var data = dropMbrList.getRowData()[data-1];
	      qtjs.href('<ifvm:url name="mbrDetailNew"/>' + '?rid='+data.rid);
        },
        onSelectRow : function (data) {
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getDropMbrList"/>',
        colNames:[
                   '<spring:message code="M00688" />',
                   '<spring:message code="L00557" />',
                   '<spring:message code="L00180" />',
                   '<spring:message code="L00716" />',
                   '<spring:message code="L00717" />',
                   '<spring:message code="L00718" />',
                   'rid'
                 ],
        colModel:[
             { name:'mbrNo',   index:'a.mbr_no',  resizable : true, align:'center',    width:'100px', formatter: goGridRowMbrLink },
             { name:'memDiv',   index:'a.mem_div',  resizable : true, align:'center',    width:'100px' },
             { name:'tierNm',   index:'b.tier_nm',  resizable : true, align:'center',    width:'100px' },
             { name:'leaveDate',   index:'a.leave_date',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'100px' },
             { name:'e1MemYn',   index:'a.mem_yn',  resizable : true, align:'center',    width:'100px' },
             { name:'webMemYn',   index:'a.wb_mem_yn',  resizable : true, align:'center',    width:'100px' },
             { name:'rid',    index:'a.rid',    hidden : true}
        ],
        sortname: 'a.rid',
        autowidth : true , sortorder: "desc",
        shrinkToFit: false
    };

    dropMbrList = $("#dropMbrListGrid").ifvGrid({ jqGridOption : jqGridOption });
}
//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.rid;
    var url = '<ifvm:url name="mbrDetailNew"/>' + '?rid=' + id;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}
//공통 조회 조건 목록 설정
function dropMbrListSearchInit() {
    $.fn.ifvmSetCommonCondList("dropMbrListSearchList","PGM_L_043");
}

//공통 조회 호출
function dropMbrListSearch() {
    $.fn.ifvmSubmitSearchCondition("dropMbrListSearchList", getdropMbrListSearch);
}



$(document).ready(function() {
    //공통 조회 조건 목록 설정
    dropMbrListSearchInit();

    dropMbrListSearch();
    //조회
    $('#dropMbrListSearchBtn').on('click', function(){
     dropMbrListSearch();
    });

    //초기화
    $("#dropMbrListSearchInitBtn").on('click', function(){
     dropMbrListSearchInit();
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
        	<ifvm:inputNew type="button" id="dropMbrListSearchBtn" btnType="search" text="L00081" />
            <ifvm:inputNew type="button" id="dropMbrListSearchInitBtn" text="L00082" />
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
        </div>
    </div>
    <div id="dropMbrListGrid" class="white_bg grid_bd0"></div>
</div>

