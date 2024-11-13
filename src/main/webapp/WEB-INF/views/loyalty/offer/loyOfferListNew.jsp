<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
.well{padding-bottom:5px;}
</style>

<script>
var offerListGrid;

$(document).ready(function() {
	//공통조회조건 설정
	offerListSearchInit();

	//그리드 설정
	setOfferListGrid();

	$("#offerListSearchInitBtn").on('click', function(){
		offerListSearchInit('offerListGrid');
	})
});

//공통 조회 조건 목록 설정
function offerListSearchInit(gridId) {
	$.fn.ifvmSetCommonCondList("offerListSearchList", "ANL_SEG_001",gridId);
}

//공통 조회 호출
function offerListSearch() {
	$.fn.ifvmSubmitSearchCondition("offerListSearchList", setOfferListGrid);
}

//삭제
function deleteOffer() {
    if (offerListGrid.opt.gridControl.getSelectedRecords().length == 0) {
        // 목록을 선택하세요
        alert('<spring:message code="M01051"/>');
    }
    else {
        // 삭제하시겠습니까?
        if (confirm('<spring:message code="M01053"/>')) {

            var checkId = null;
            $(offerListGrid.opt.gridControl.getSelectedRecords()).each(function(index, item) {
                checkId = item.id;
            });

            $.ifvSyncPostJSON('<ifvm:action name="removeOffer"/>', {
                id : checkId
            }, function(result) {
                alert('<spring:message code="M01049"/>');
                setOfferListGrid();
            });
        }
    }
}

//조회결과 그리드
function setOfferListGrid() {

    var ejGridOption = {
        serializeGridData : function (data) {
            data.type = 'LOY';
            if (requestitem != null && requestitem.length > 0) {
                data.item = requestitem;
            }
            return data;
        },
        recordDoubleClick : function (selectedData) {
        	qtjs.href('<ifvm:url name="loyOfferDetailNew"/>?id='+selectedData.data.id);
        },
        dataUrl: '<ifvm:action name="getLoyOfferMstList"/>',
        columns:[
        	     {
	      		  field : 'offerNo', headerText : '<spring:message code="M00313"/>', headerTextAlign : 'center', width:'80px', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'mom.offer_no' }/* */
	      	  }, {
	      		  field : 'offerNm', headerText : '<spring:message code="M00314"/>', headerTextAlign : 'center', width:'140px',
	      		  customAttributes : {
	      			  index : 'mom.offer_nm' }/* */
	      	  }, {
	      		  field : 'offerStatusNm', headerText : '<spring:message code="M00317"/>', headerTextAlign : 'center', width:'60px',textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c4.mark_nam' }/* */
	      	  }, {
	      		  field : 'offerCostDivNm', headerText : '<spring:message code="M00318"/>', headerTextAlign : 'center',width:'60px',textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c1.mark_name' }/* */
	      	  }, {
	      		  field : 'offerTypeNm', headerText : '<spring:message code="M00319"/>', headerTextAlign : 'center', width:'40px', textAlign :ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c2.mark_name' }/* */
	      	  }, {
	      		  field : 'createByNm', headerText : '<spring:message code="M00325"/>', headerTextAlign : 'center', width:'40px',textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'e1.name' }/* */
	      	  }, {
	      		  field : 'createDate', headerText : '<spring:message code="M00326"/>', headerTextAlign : 'center', width:'40px',textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'mom.modify_date' }/* */
	      	  }, {
	      		  field : 'id', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			searchable : false,
	      			  index : 'mom.id' }/* */
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'mom.offer_no',
	      	  sord : 'desc',
	      	  _search : false
	        },
	    rowList : [10,25,50,100],
		radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    offerListGrid = $("#offerListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function goOfferNew() {
    goOfferDetail('');
}

//오퍼 상세 이동
function goOfferDetail(id) {
    qtjs.href('<ifvm:url name="loyOfferDetailNew"/>' + '?id=' + id);
}

</script>

<div class="page-title">
	<h1>
		<spring:message code="M00308"/>&gt;  <spring:message code="M00273"/>
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00310"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" btnFunc="offerListSearch" text="M00273" />
		<ifvm:inputNew type="button" id="offerListSearchInitBtn" text="M00311" />
	</div>
</div>
<div class="well form-horizontal" id="offerListSearchList" >
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00312"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnFunc="goOfferNew" text="M00274" />
			<ifvm:inputNew type="button" btnFunc="deleteOffer" text="M00165" />
		</div>
	</div>
	<div id="offerListGrid" class="grid_bd0"></div>
</div>