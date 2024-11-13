<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var mbrRenameReqList;
var gridIdmbrRenameReqList;
var rid ;

//
function getmbrRenameReqListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var data = mbrRenameReqList.getRowData()[data-1];
      rid = data.rid;

      mbrRenameReqDetailDtlPop();   // 상세 보기 이벤트

      rid = null;

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
        url : '<ifvm:action name="getMbrRenameReqList"/>',
        colNames:[
                   '<spring:message code="L00796" />',
                   '<spring:message code="L00797" />',
                   '<spring:message code="L00798" />',
                   '<spring:message code="L00799" />',
                   '<spring:message code="L00800" />',
                   '<spring:message code="L00802" />',
                   '<spring:message code="L00803" />',
                   '<spring:message code="L00804" />',

                   'rid'
                 ],
        colModel:[
             { name:'createDate',   index:'a.create_date',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'100px' },
             { name:'mbrNo',   		index:'b.mbr_no',  		resizable : true, align:'center',    width:'100px', formatter: goGridRowMbrLink },
             { name:'oldName',   	index:'a.old_name',  	resizable : true, align:'center',    width:'100px' },
             { name:'remark',   	index:'a.rmark',  		resizable : true, align:'center',    width:'200px' },
             { name:'newName',   	index:'a.new_name',  	resizable : true, align:'center',    width:'100px' },
             { name:'renmYn',   	index:'a.renm_yn',  	resizable : true, align:'center',    width:'100px' },
             { name:'modifyDate',   index:'a.modify_date',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'100px' },
             { name:'empName',   	index:'c.name',  		resizable : true, align:'center',    width:'100px' },

             { name:'rid',    index:'a.rid',    hidden : true}
        ],
        sortname: 'a.modify_date',
        autowidth : true ,

        sortorder: "desc"
    };

    mbrRenameReqList = $("#mbrRenameReqListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdmbrRenameReqList = $("#gridIdmbrRenameReqList");
}
//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}

//공통 조회 조건 목록 설정
function mbrRenameReqListSearchInit() {
    $.fn.ifvmSetCommonCondList("mbrRenameReqListSearchList","PGM_L_047");
}

//공통 조회 호출
function mbrRenameReqListSearch() {
    $.fn.ifvmSubmitSearchCondition("mbrRenameReqListSearchList", getmbrRenameReqListSearch);
}

// 상세 팝업 화면 호출
function mbrRenameReqDetailDtlPop(){

 $("#mbrRenameReqDetailDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrRenameReqDetail"/>' + '?rid=' + rid,
        contentType: "ajax",
        title: '<spring:message code="L00806" />',
        width: '1000px',
        close : 'mbrRenameReqDetailPopClose'
    });
}

//팝업 닫기
function mbrRenameReqDetailPopClose() {

	$('#mbrRenameReqDetailDialog').data('ejDialog')._destroy();
   //$('#mbrRenameReqDetailDialog').ejDialog('destroy');
 //리스트 재 조회
 mbrRenameReqListSearch();
}

//고객 상세 이동
function mbrRenameReqDetailDtl() {
    qtjs.href('<ifvm:url name="mbrRenameReqDetail"/>' + '?rid=' + rid);
}



$(document).ready(function() {
    //공통 조회 조건 목록 설정
    mbrRenameReqListSearchInit();

    mbrRenameReqListSearch();
    //조회
    $('#mbrRenameReqListSearchBtn').on('click', function(){
     mbrRenameReqListSearch();
    });

    //초기화
    $("#mbrRenameReqListSearchInitBtn").on('click', function(){
     mbrRenameReqListSearchInit();
    });

});

</script>


<div class="page-title">
    <h1>
    <spring:message code="L00806" />
	&gt; <spring:message code="M00135" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" id="mbrRenameReqListSearchBtn" btnType="search" text="L00081" />
            <ifvm:inputNew type="button" id="mbrRenameReqListSearchInitBtn" text="L00082" />
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="mbrRenameReqListSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
         <div class="col-xs-7">
            <span><spring:message code="L00084" /><spring:message code="L01258" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">

        	<ifvm:inputNew type="button" btnType="plus" text="L00027" id="renameNewButton" btnFunc="mbrRenameReqDetailDtlPop" />
        </div>
    </div>
    <div id="mbrRenameReqListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="mbrRenameReqDetailDialog" class="popup_container"></div>

