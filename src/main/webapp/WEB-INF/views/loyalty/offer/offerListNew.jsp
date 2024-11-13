<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

$.ifvmLnbSetting('offerListNew');

var offerSearchResult;
var parId = null;
var requestitem = [];

//조회결과 그리드
function offerSearchResultList() {

    var ejGridOption = {
        serializeGridData : function( data ) {
            data.type = 'MKT';
            if (requestitem != null && requestitem.length > 0) {
                data.item = requestitem;
            }
            return data;
        },
        recordDoubleClick : function (selectedData) {
        	qtjs.href('<ifvm:url name="MKTOfferDetail"/>?id='+selectedData.data.id);
        },
        dataUrl: '<ifvm:action name="getListOffer"/>',
        columns:[
        	  {
	      		  field : 'offerNo', headerText : '<spring:message code="M00313"/>', width:'80px', textAlign : 'center',
	      		  customAttributes : {
	      			  searchable: true }
	      	  }, {
	      		  field : 'offerName', headerText : '<spring:message code="M00314"/>', width:'140px',
	      		  customAttributes : {
	      			searchable: true }
	      	  }, {
	      		  field : 'offerTypeCd', headerText : '<spring:message code="M00319"/>', width:'60px',textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'offerType' }
	      	  }, {
	      		  field : 'offerSubTypeNm', headerText : '<spring:message code="M01896"/>', width:'60px',textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'offerSubTypeCd' }
	      	  }, {
	      		  field : 'offerEcnrsDivNm', headerText : '<spring:message code="M02276"/>', width:'40px', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'offerEcnrsDivCd' }
	      	  }, {
	      		  field : 'offerUseDeskDivNm', headerText : '<spring:message code="M02275"/>', width:'40px',textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'offerUseDeskDivCd' }
	      	  }, {
	      		  field : 'id', headerText : 'id', visible : false
	      	  },
        ],
        requestGridData : {
	      	  sidx : 'offerNo',
	        },
		radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    offerSearchResult = $("#offerSearchResult").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회 조건 목록 설정
function searchCondInit(gridId) {
    $.fn.ifvmSetCommonCondList("commSearchList","MKTOFR001",gridId);
}

//공통 조회 호출
function offerSerach() {
    $.fn.ifvmSubmitSearchCondition("commSearchList", offerSearchResultList);
}

$(document).ready(function() {

    //공통 조회 조건 목록 설정
    searchCondInit();

    //오퍼목록 조회
	offerSearchResultList();

    //조회
    $("#authGroupSearchBtn").on('click', function(){
        //조회 호출
        offerSerach();
    });

    //조회 초기화
    $("#authGroupinitBtn").on('click', function(){
    	searchCondInit('offerSearchResult');
    });

    //신규
    $('#offerNewBtn').on('click', function() {
        qtjs.href('<ifvm:url name="MKTOfferDevDetail"/>');
    });

    // 삭제
    $('#offerDeleteBtn').on('click', function(){
        if (offerSearchResult.opt.gridControl.getSelectedRecords().length==0) {
            // 목록을 선택하세요
            alert('<spring:message code="M01051"/>');
        }
        else {
            // 삭제하시겠습니까?
            if (confirm('<spring:message code="M01053"/>')) {

                var checkId = null;
                $(offerSearchResult.opt.gridControl.getSelectedRecords()).each(function(index, item) {
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
        <spring:message code="M00308"/> &gt;  <spring:message code="M00273"/>
    </h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id='authGroupSearchBtn' objCode="offerAuthGroupSearchBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="M00273" />
			</button>
			<button class="btn btn-sm" id='authGroupinitBtn' objCode="offerAuthGroupinitBtn_OBJ">
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
            <button class="btn btn-sm" id="offerNewBtn" objCode="offerNewBtn_OBJ">
                <spring:message code="M00274"/>
            </button>
            <button class="btn btn-sm" id="offerDeleteBtn" objCode="offerDeleteBtn_OBJ">
                <spring:message code="M00165"/>
            </button>
        </div>
    </div>
    <div id="offerSearchResult" class="grid_bd0"></div>
</div>
