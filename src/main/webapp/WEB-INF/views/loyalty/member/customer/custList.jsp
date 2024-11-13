<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var custListGrid;

$(document).ready(function() {
	//공통 조회 조건 목록 설정
    searchCondInit();

  	//마스킹해제 권한 체크
	//checkButtnAuth();

  	//고객관리 목록 조회
    getCustList();

    //조회
    $('#searchCondBtn').on('click', function(){
    	custListSearch();
    });

    //초기화
    $("#searchCondInitBtn").on('click', function(){
    	searchCondInit();
    });

    //신규 클릭시
    $('#addBtn').on('click', function(){
    	qtjs.href('<ifvm:url name="custDetail"/>');
    });

    //삭제 클릭시
    $('#removeBtn').on('click', function(){
        removeAction();
    });


    //마스킹해제 클릭시
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });

});

//공통 조회 조건 목록 설정
function searchCondInit() {
  $.fn.ifvmSetCommonCondList("commSearchList","PLOY_003");
}

//공통 조회 호출
function custListSearch() {
  $.fn.ifvmSubmitSearchCondition("commSearchList", getCustList);
}

//고객 목록
function getCustList(page) {

    var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;

    var jqGridOption = {
        serializeGridData : function(data){
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            //    alert("data.item: " + data.item);
            }
        	//페이지 설정
        	data.page = page;
            return data;
        },
        ondblClickRow : function (rowNo) {
        	var data = custListGrid.getRowData()[rowNo-1];

        	goCustDetail(data.rid);
        },

        url : '<ifvm:action name="getCustList"/>',
        colNames:[ //고객명,식별값 유형,식별값, 고객 유형, '실명인증여부', '실명인증일자','생성자','최종수정일','수정자' , 'rid'
                   '<spring:message code="L00320"/>',
                   '<spring:message code="L00343"/>',
                   '<spring:message code="L00342"/>',
                   '<spring:message code="L00318"/>',
                   '<spring:message code="L00344"/>',
                   '<spring:message code="L00345"/>',
                   '<spring:message code="L00094"/>',
                   '<spring:message code="L00095"/>' ,
                   'rid'
                 ],
        colModel:[
            { name:'custNm', 		 index:'a.cust_nm_decoding', 	width:'80px', 	align: 'left', 	    resizable : true },
            { name:'identiTypeNm', 	 index:'cd.mark_name', 	        width:'120px', 	align: 'center', 	resizable : false },
            { name:'identiVal', 	 index:'a.identi_val_decoding', width:'200px', 	align: 'left', 		resizable : true },
            { name:'custTypeNm', 	 index:'cd1.mark_name', 	    width:'50px', 	align: 'center', 	resizable : false },
            { name:'realnmCertiYn',  index:'a.realnm_certi_yn',     width:'90px', 	align: 'center', 	resizable : false },
            { name:'realnmCertiDate',index:'a.realnm_certi_date',   width:'90px', 	align: 'center', 	resizable : false },
            { name:'modifyDate', 	 index:'a.modify_date', 	    width:'90px', 	align: 'center', 	resizable : false },
            { name:'modifyBy', 		 index:'em1.name', 		        width:'110px', 	align: 'center', 	resizable : false },
            { name:'rid', 			 index:'a.rid', 				hidden : true }
        ],
        sortname: 'a.create_date',
        autowidth : true , sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };

    custListGrid = $("#custListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//고객 상세 이동
function goCustDetail(id) {
    qtjs.href('<ifvm:url name="custDetail"/>' + '?rid=' + id);
}

/*
//그리드 텍스트 선택시 상세로 이동
 function goGridRowLink(cellvalue, options, rowObjec){
    var id = rowObjec.rid;
    var url = '<ifvm:url name="custDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" >' + cellvalue + '</a>';

    return tag                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ;
}
 */

//삭제
function removeAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(custListGrid.getCheckedGridData()[0])) {
    	v_rid = custListGrid.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M00108"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        if (confirm('<spring:message code="L00086"/>')) {
            $.ifvProgressControl(true);

            // 삭제
            $.ifvPostJSON('<ifvm:action name="removeCust"/>', {
                rid: v_rid
            },
            function(result) {
                alert('<spring:message code="L00085"/>');

                //고객 목록
                getCustList(getGridPage());

                $.ifvProgressControl(false);
            },
            function(result) {
                $.errorChecker(result);
                $.ifvProgressControl(false);
            });
        }
    }
}

//마스크해제
function clearMaskAction() {

    var v_rid;
    if ($.fn.ifvmIsNotEmpty(custListGrid.getCheckedGridData()[0])) {
    	v_rid = custListGrid.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskCust"/>', {
            rid: v_rid
        },
        function(result) {
        	var rowid = custListGrid.getRadioSelectedRowId();
            custListGrid.opt.grid.setCell( rowid, 'custNm' , result.custNm );  // 고객명 세팅
            custListGrid.opt.grid.setCell( rowid, 'identiVal' , result.identiVal ); //식별값 세팅
        });
    }
}

//페이지 구하기
function getGridPage() {
    var rtnVal = 1;
    var page = custListGrid.opt.data.page;
    var total = custListGrid.opt.data.records;

    if (total % page > 0) {
        rtnVal = page;
    }
    return rtnVal;
}

function checkButtnAuth() {
    var isAuth = false;
    var authArr = $.ifvmGetAuthInfo().authList;
    for (var i = 0; i < authArr.length; i++) {
        var authObj = authArr[i];
        var authName = authObj.authName;
        if (authName == 'E10010') isAuth = true;
    }
    if (!isAuth) {
        $("#clearMaskBtn").remove();
    }
}
</script>

<div class="page-title">
    <h1>
        <spring:message code="L00431"/><!-- 회원 -->
        &gt; <spring:message code="L00316"/><!-- 고객 -->
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchCondBtn"><i class="fa fa-search"></i>
                <spring:message code="L00081"/>
            </button>
            <button class="btn btn-sm" id="searchCondInitBtn">
                <spring:message code="L00082"/>
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="commSearchList" >
    </div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="L00084"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <%-- 신규 버튼 --%>
            <button class="btn btn-sm" id="addBtn">
                <i class="fa fa-plus"></i>
                <spring:message code="L00078"/></button>
            <%-- 삭제 버튼 --%>
            <%--
            <button class="btn btn-sm" id="removeBtn">
                <i class="fa fa-minus"></i>
                <spring:message code="L00080"/>
            </button>
             --%>
            <%-- 마스킹해제 버튼 --%>
            <%--
            <button class="btn btn-sm" id="clearMaskBtn">
                <spring:message code="L00326"/>
            </button>
             --%>
        </div>
    </div>
    <div id="custListGrid" class="white_bg grid_bd0"></div>
</div>