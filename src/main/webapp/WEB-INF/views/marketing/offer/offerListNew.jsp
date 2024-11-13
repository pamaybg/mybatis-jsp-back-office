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
        rowSelected : function (selectedData)
        {
            //location.href = '<ifvm:url name="MKTOfferDetail"/>?id='+data.id;
            /* qtjs.href('<ifvm:url name="MKTOfferDetail"/>?id='+selectedData.data.id); */
        },
        recordDoubleClick : function (selectedData) {
        	qtjs.href('<ifvm:url name="MKTOfferDetail"/>?id='+selectedData.data.id);
        },
//         loadComplete : function(obj) {
//         },
        dataUrl: '<ifvm:action name="getListOffer"/>',
        columns:[
        	  {
	      		  field : 'offerNo', headerText : '<spring:message code="M00313"/>', headerTextAlign : 'center', width:'80px', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'mof.offer_no' }/* */
	      	  }, {
	      		  field : 'offerName', headerText : '<spring:message code="M00314"/>', headerTextAlign : 'center', width:'140px',
	      		  customAttributes : {
	      			  index : 'mof.offer_nm' }/* */
	      	  }, {
	      		  field : 'offerTypeCd', headerText : '<spring:message code="M00319"/>', headerTextAlign : 'center', width:'60px',textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c2.mark_name' }/* */
	      	  }, {
	      		  field : 'offerSubTypeNm', headerText : '<spring:message code="M01896"/>', headerTextAlign : 'center',width:'60px',textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c8.mark_name' }/* */
	      	  }, {
	      		  field : 'offerEcnrsDivNm', headerText : '<spring:message code="M02276"/>', headerTextAlign : 'center', width:'40px', textAlign :ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c9.mark_name' }/* */
	      	  }, {
	      		  field : 'offerUseDeskDivNm', headerText : '<spring:message code="M02275"/>', headerTextAlign : 'center', width:'40px',textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c9.mark_name' }/* */
	      	  }, {
	      		  field : 'id', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			searchable : false,
	      			  index : 'lmsr.CARD_NUM' }/* */
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'mof.offer_no',
	      	  sord : 'desc',
	      	  _search : false
	        },
	    rowList : [10,25,50,100],
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
	//var LeftMenuId = $(".leftMenu").find(".active").attr('prognum');

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
        //location.href = '<ifvm:url name="MKTOfferDetail"/>';
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

<div class="well form-horizontal" id="offerRequiredList" ></div>

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
