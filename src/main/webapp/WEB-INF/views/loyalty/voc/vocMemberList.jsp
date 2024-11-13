<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
//팝업 공통 컨테이너 변수
var popupContainer;

var vocMbrListGrid = null;
var cDialog;
var selectChk = false;

var vocPointAcrlRdmPopObj = null;

function getVocMemberList(){
    var jqGridOption = {
   		serializeGridData : function( data ){
	        if ($.fn.ifvmIsNotEmpty(requestitem)) {
	             data.item = requestitem;
	         }
	         return data;
	    },
        ondblClickRow : function (rowNo) {
        	var data = vocMbrListGrid.opt.grid.getRowData(rowNo);
        	qtjs.href('<ifv:url name="vocMemberDetail"/>' + '?rid=' + data.rid);
        },
    	onSelectRow : function (data) {
    		$("#btnClearMask").prop("disabled", "");
    		$("#btnPointAcrlRdmPopup").prop("disabled", "");
        },
        url : '<ifv:action name="getVocMemberList"/>',
        colNames:[  '<spring:message code="M00849"/>'	// 회원번호
                   ,'<spring:message code="L00435"/>'	// 회원명
                   ,'<spring:message code="L00090"/>'	// 인증상태
                   ,'<spring:message code="L00400"/>'	// 전화번호
                   ,'<spring:message code="L00311"/>'	// 가입일자
                   ,'<spring:message code="L00312"/>'	// 가입채널
                   ,'<spring:message code="L00429"/>'	// 현재등급
                   ,'<spring:message code="L00026"/>'	// 로열티 프로그램
                   ,'rid'
                   ,'ridChnl'
                   ,'chnlNo'
                   ,'identiType'
                   ,'identiVal'
                   ,'mbrStatCd'
                 ],
        colModel:[
            { name:'mbrNo', index:'mbr_no', width:'100px', resizable : false, formatter: goGridRowMbrLink },
            { name:'custNm', index:'hhp_no', width:'100px', resizable : false },
            { name:'mbrStatNm', index:'mbr_stat_nm', width:'100px', resizable : false },
            { name:'hhpNo', index:'hhp_no', width:'100px', resizable : false },
            { name:'joinDate', index:'join_date', width:'100px', resizable : false, align : 'center' },
            { name:'chnlNm', index:'chnl_nm', width:'100px', resizable : false },
            { name:'tierNm', index:'tier_nm', width:'100px', resizable : false },
            { name:'pgmNm', index:'pgm_nm', width:'100px', resizable : false },
            { name:'rid', index:'rid', hidden : true, searchable : false },
            { name:'ridChnl', index:'rid_chnl', hidden : true, searchable : false },
            { name:'chnlNo', index:'chnl_no', hidden : true, searchable : false },
            { name:'identiType', index:'identi_type_cd', hidden : true, searchable : false },
            { name:'identiVal', index:'identi_val', hidden : true, searchable : false },
            { name:'mbrStatCd', index:'mbr_stat_cd', hidden : true, searchable : false }
        ],
        sortname: 'mbr_no desc, cust_nm desc, hhp_no desc',
        sortorder: "",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    vocMbrListGrid = $("#vocMbrListGrid").ifvGrid({ jqGridOption : jqGridOption });
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

function getClearMaskData(){

    var v_rid;
    
    if ($.fn.ifvmIsNotEmpty(vocMbrListGrid.getCheckedGridData()[0])) {
    	v_rid = vocMbrListGrid.getCheckedGridData()[0].rid;

    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {

            $.ifvSyncPostJSON('../member/mbr/clearMaskMbr.do', {
                rid: v_rid
            },
            function(result) {
            	var rowid = vocMbrListGrid.getRadioSelectedRowId();
            	vocMbrListGrid.opt.grid.setCell( rowid, 'custNm' , result.mbrNm );  // 고객명 세팅

            	vocMbrListGrid.opt.grid.setCell( rowid, 'hhpNo' , result.hhpNo ); //

             }
    		, function(result) {
          	  	alert(result.message);

             });

    }
}

//공통 조회 조건 목록 설정
function vocMbrListSearchInit() {
    //$.fn.ifvmSetCommonCondList("searchList","DT-VOC-001","vocMbrListSearchBtn");
}

//공통 조회 호출
function vocMbrListSearch() {
    $.fn.ifvmSubmitSearchCondition("searchList", getVocMemberList);
}

//팝업 종료
function popCancelClose() {
	popupContainer._destroy();
}

//팝업 종료
function popClose() {
	popupContainer._destroy();
	changeContent('mbrPtnTxnHistList', '');
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
		$("#btnClearMask").remove();
	}
}

$(document).ready(function() {
	//마스킹해제 권한 체크
	//checkButtnAuth();
	/**
	 * Page Initiation
	 */
	getVocMemberList();

    //공통 조회 조건 목록 설정
    vocMbrListSearchInit();


	/**
	 * Button Handler Start
	 */
    //조회
    $('#vocMbrListSearchBtn').on('click', function(){
    	vocMbrListSearch();
    });

    //초기화
    $("#vocMbrListSearchInitBtn").on('click', function(){
    	vocMbrListSearchInit();
    });

    //마스킹 해제
    $("#btnClearMask").click(function(){
    	getClearMaskData();
    });

    // 포인트 적립 / 사용 팝업
    $("#btnPointAcrlRdmPopup").click(function(){

    	var selectedRowno = vocMbrListGrid.opt.grid.getGridParam("selrow");
    	var selectedRowObj = vocMbrListGrid.opt.grid.getRowData(selectedRowno);

    	if(selectedRowObj.mbrStatCd != "A"){
    		alert("<spring:message code='L00510'/>");
    		return false;
    	}

    	vocPointAcrlRdmPopObj = selectedRowObj;

   		$("#popupContainer").ifvsfPopup({
   			enableModal : true
   	        ,enableResize: false
   	        ,allowKeyboardNavigation : false
   	        ,contentUrl: '<ifv:url name="vocPointAcrlRdmPop"/>'
   	        ,contentType: "ajax"
   	        ,title: '<spring:message code="L00504" />'
   	        ,width: '700px'
   	        ,close : 'popCancelClose'
   	    });
   		popupContainer = $("#popupContainer").data("ejDialog");
    });
	/**
	 * Button Handler End
	 */
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="L00502" />
        &gt; <spring:message code="L00509" />
    </h1>
</div>

<!-- 조회 -->
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M01004" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="vocMbrListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="L00030" />
            </button>
            <button class="btn btn-sm" id="vocMbrListSearchInitBtn">
                <spring:message code="L00031" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="searchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="L00033" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="btnClearMask" disabled>
                <spring:message code="L00326" />
            </button>
            <button class="btn btn-sm" id="btnPointAcrlRdmPopup" disabled>
                <spring:message code="L00503" />
            </button>
        </div>
    </div>
    <div id="vocMbrListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="popupContainer" class="popup_container"></div>
<div id="offerPopupCon" class="popup_container"></div>