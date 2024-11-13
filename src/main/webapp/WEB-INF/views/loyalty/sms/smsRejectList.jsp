<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var smsRejectList;
var gridIdsmsRejectList;
var rid ;
var smsRid ;
//SMS수신거부
function getsmsRejectListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var data = smsRejectList.getRowData()[data-1];
      rid = data.rid;

      smsRejectDetailPopupDtlPop();   // 상세 보기 이벤트


        },
        onSelectRow : function (data) {
        	smsRid = data.rid;
        	fnButtonStatus();
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj){
        	$('#smsUnmaskingBtn').attr('disabled',true);
        },
        url : '<ifvm:action name="getSmsRejectList"/>',
        colNames:[
                   '<spring:message code="L00221" />',
                   '<spring:message code="L00436" />',
                   '<spring:message code="L00660" />',
                   '<spring:message code="I02072" />',
                   '<spring:message code="M01893" />',
                   '<spring:message code="M01813" />',
                   '<spring:message code="L00138" />',

                   'rid'
                 ],
        colModel:[
             { name:'createDate',   index:'a.create_date',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'100px' },
             { name:'mphonNo',   	index:'a.mphon_no',  	resizable : true, align:'center',    width:'100px' },
             { name:'rsn',   		index:'a.rsn',  		resizable : true, align:'center',    width:'100px' },
             { name:'flg',   		index:'a.flag',  		resizable : true, align:'center',    width:'100px' },
             { name:'createBy',   	index:'d.name',  	resizable : true, align:'center',    width:'100px' },
             { name:'modifyDate',   index:'a.modify_date',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'100px' },
             { name:'modifyBy',   	index:'e.name',  	resizable : true, align:'center',    width:'100px' },
             { name:'rid',    index:'a.rid',    hidden : true}
        ],
        sortname: 'a.rid',
        autowidth : true,
        radio : true,
        sortorder: "desc",
        shrinkToFit: false

    };

    smsRejectList = $("#smsRejectListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdsmsRejectList = $("#gridIdsmsRejectList");
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
function smsRejectListSearchInit() {
    $.fn.ifvmSetCommonCondList("smsRejectListSearchList","PGM_L_048");
}

//공통 조회 호출
function smsRejectListSearch() {
    $.fn.ifvmSubmitSearchCondition("smsRejectListSearchList", getsmsRejectListSearch);
}

// 상세 팝업 화면 호출
function smsRejectDetailPopupDtlPop(){

 $("#smsRejectDetailPopupDialog").ifvsfPopup({
  enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="smsRejectDetailPopup"/>' + '?rid=' + rid,
        contentType: "ajax",
        title: '<spring:message code="L02054" />',//SMS 수신거부 신규
        width: '500px',
        close : 'smsRejectDetailPopupPopClose'
    });
}

//팝업 닫기
function smsRejectDetailPopupPopClose() {
 	smsRejectDetailPopupDialog._destroy();
}

//고객 상세 이동
function smsRejectDetailPopupDtl() {
    qtjs.href('<ifvm:url name="smsRejectDetailPopup"/>' + '?rid=' + rid);
}

function fnSmsRejectNew(){

	 $("#smsRejectDetailPopupDialog").ifvsfPopup({
		  enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="smsRejectDetailPopup"/>' ,
		        contentType: "ajax",
		        title: '<spring:message code="L02054" />',//SMS 수신거부 신규
		        width: '500px',
		        close : 'smsRejectDetailPopupPopClose'
		    });

}

function fnButtonStatus(){

	smsRid !=null ? $('#smsUnmaskingBtn').attr('disabled',false) : $('#smsUnmaskingBtn').attr('disabled',true);

}


function fnSmsUnmaskingBtn(){
	if ($.fn.ifvmIsNotEmpty(smsRid)) {
        $.ifvSyncPostJSON('<ifvm:action name="getMasking"/>', {
            rid: smsRid ,
            type: 'sms' ,
            field: 'phone'

        },
        function(result) {
        	if(result.message!=null){
	        	var rowid = smsRejectList.getRadioSelectedRowId();
	        	smsRejectList.opt.grid.setCell( rowid, 'mphonNo' , result.message );
        	}
        });
	}
}
function checkButtnAuth(){
	var isAuth = false;
	var authArr = $.ifvmGetAuthInfo().authList;
	for(var i = 0 ; i < authArr.length ; i++){
		var authObj = authArr[i];
		var authName = authObj.authName;
		if(authName == 'E10010') isAuth = true;
	}
	if(!isAuth){
		$("#smsUnmaskingBtn").remove();
	}
}


$(document).ready(function() {
	//마스킹해제 권한 체크
	//checkButtnAuth();
    //공통 조회 조건 목록 설정
    smsRejectListSearchInit();

    smsRejectListSearch();
    //조회
    $('#smsRejectListSearchBtn').on('click', function(){
     smsRejectListSearch();
    });

    //초기화
    $("#smsRejectListSearchInitBtn").on('click', function(){
     smsRejectListSearchInit();
    });

});

</script>


<div class="page-title">
    <h1>
    	<spring:message code="L00720" />
 		&gt; <spring:message code="M00135" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" id="smsRejectListSearchBtn" btnType="search" text="M00135" />
            <ifvm:inputNew type="button" id="smsRejectListSearchInitBtn" text="M00278" />
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="smsRejectListSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L00084" /><spring:message code="L01258" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="select" text="L00326" id="smsUnmaskingBtn"  btnFunc="fnSmsUnmaskingBtn" objCode="LOY_MAS_012" />
        	<ifvm:inputNew type="button" btnType="plus" text="L00027" id="smsRejectNewButton" btnFunc="fnSmsRejectNew" />
        </div>
    </div>
    <div id="smsRejectListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="smsRejectDetailPopupDialog" class="popup_container"></div>
