<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

$.ifvmLnbSetting('offerList');

var offerSearchResult;
var parId = null;
var requestitem = [];

//조회결과 그리드
function offerSearchResultList() {

    var jqGridOption = {
        serializeGridData : function( data ) {
            data.type = 'MKT';
            if (requestitem != null && requestitem.length > 0) {
                data.item = requestitem;
            }
            return data;
        },
        onSelectCell : function (data) {
            //location.href = '<ifvm:url name="MKTOfferDetail"/>?id='+data.id;
            qtjs.href('<ifvm:url name="MKTOfferDetail"/>?id='+data.id);
        },
        loadComplete : function(obj) {
        },
        url: '<ifvm:action name="getListOffer"/>',
        colNames:[
                  '<spring:message code="M00313"/>',
                  '<spring:message code="M00314"/>',
                  '<spring:message code="M00319"/>',
                  '<spring:message code="M01896"/>',
                  '<spring:message code="M02276"/>',
                  '<spring:message code="M02275"/>',
                  'id'
                  ],
        colModel:[
            {name:'offerNo',index:'mof.offer_no', resizable : false},
            {name:'offerName',index:'mof.offer_nm', resizable : false},
            {name:'offerTypeCd',index:'c2.mark_name', resizable : false},
            {name:'offerSubTypeNm',index:'c8.mark_name', resizable : false},
            {name:'offerEcnrsDivNm',index:'c9.mark_name', resizable : false},
            {name:'offerUseDeskDivNm',index:'c9.mark_name', resizable : false},
            {name:'id', index:'mof.id', resizable : false,  hidden : true,  searchable : false}
        ],
        radio: true,
        sortname: 'mof.offer_no',
        sortorder: "desc",
        tempId : 'ifvGridOriginTemplete'
    };
    offerSearchResult = $("#offerSearchResult").ifvGrid({ jqGridOption : jqGridOption });
}

//공통 조회 조건 목록 설정
function searchCondInit() {
    $.fn.ifvmSetCommonCondList("commSearchList","MKTOFR001");
}

//공통 조회 호출
function offerSerach() {
    $.fn.ifvmSubmitSearchCondition("commSearchList", offerSearchResultList);
}


$(document).ready(function(){
	
    //공통 조회 조건 목록 설정
    searchCondInit();
    


     offerSearchResultList();
     var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');

    //조회
    $("#authGroupSearchBtn").on('click', function(){
        //조회 호출
        offerSerach();

    });
    
    //조회 초기화
    $("#authGroupinitBtn").on('click', function(){
    	searchCondInit();
    });



    //신규
    $('#offerNewBtn').on('click', function(){
        //location.href = '<ifvm:url name="MKTOfferDetail"/>';
        qtjs.href('<ifvm:url name="MKTOfferDetail"/>');
    });
    
    // 삭제 
    $('#offerDeleteBtn').on('click', function(){
        if ($(offerSearchResult.getCheckedGridData()).length == 0) {
            // 목록을 선택하세요
            alert('<spring:message code="M01051"/>');
        }
        else {
            // 삭제하시겠습니까?
            if (confirm('<spring:message code="M01053"/>')) {

                var checkId = null;
                $(offerSearchResult.getCheckedGridData()).each(function(index, item) {
                    checkId = item.id;
                });
                
                $.ifvSyncPostJSON('<ifvm:action name="removeOffer"/>', {
                    id : checkId
                }, function(result) {
                    alert('<spring:message code="M01049"/>');
                    offerSearchResultList();
                });
            }
        }
    });

});

</script>

<script id="offerListTextTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
    <ifvm:input type="text" />
</div>
</script>

<script id="offerListSelectTemp" type="text/x-jquery-tmpl">
<div class="col-xs-2">
    <ifvm:input type="select" id="SelectListValue"/>
</div>
</script>

<style>
.well{padding-bottom:5px;}
</style>

<div class="page-title">
    <h1>
        <spring:message code="M00308"/>&gt;  <spring:message code="M00273"/>
    </h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id='authGroupSearchBtn'>
				<i class="fa fa-search"></i>
				<spring:message code="M00273" />
			</button>
			<button class="btn btn-sm" id='authGroupinitBtn'>
				<spring:message code="M00311" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="commSearchList"></div>
</div>

<div class="well form-horizontal" id="offerRequiredList" >

</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00312"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="offerNewBtn">
                <spring:message code="M00274"/>
            </button>
            <button class="btn btn-sm" id="offerDeleteBtn">
                <spring:message code="M00165"/>
            </button>
        </div>
    </div>
    <div id="offerSearchResult" class="grid_bd0"></div>
</div>
