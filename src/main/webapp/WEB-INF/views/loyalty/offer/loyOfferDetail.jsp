<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>

var loyOfferValidation;

var loyOfferData = {
        expDividList: []        //분담률
        , relCampaignList: []   //관계 캠페인
        , pntDtlList: []        //포인트
//      , cpnDtlList: []        //쿠폰
     , useLmtChnlList: []    //제한채널
//      , useLmtProdList: []    //제한모델
    };

function initLoyOfferDetail() {

	//오퍼비용구분
	$.fn.ifvmSetSelectOptionCommCode("offerCostDivCd", "MKT_OFFER_COST_GBN", null, null, true);

	//오퍼유형
	$.fn.ifvmSetSelectOptionCommCode("offerTypeCd", "OFFER_TYPE_CD", null, null, true);

	//오퍼상세유형
	$.fn.ifvmSetSelectOptionCommCodeSync("offerSubTypeCd", "OFFER_SUB_TYPE_CD", null, "offerTypeCd", true);

	//오퍼상태
	$.fn.ifvmSetSelectOptionCommCode("offerStatusCd", "COMM_STATUS", null, null, true);

	loyOfferValidation = $("#dataForm").ifvValidation();

	//탭 설정
	setLoyOfferTabArea();
}

function initLoyOfferDetailData(id) {
	$.ifvProgressControl(true);

	//캠페인 정보
	getLoyOfferDetail(id);

    setTimeout(function() {

		//탭설정
		setLoyOfferTabArea();

		$.ifvProgressControl(false);
   	},100);
}

//오퍼 상세 조회
function getLoyOfferDetail(rid) {
	var id = rid;

	if ($.fn.ifvmIsEmpty(id)) {
		//오퍼 아이디
		id = '<%= cleanXss(request.getParameter("id")) %>';
    	id = $.fn.ifvmIsEmpty(id) || id == "null" ? '' : id;
	}

	loyOfferData.id = id;

    //오퍼상세
    $.ifvSyncPostJSON('<ifvm:action name="getLoyOfferDetail"/>', {
        id: id
    },
    function(result) {
    	if ($.fn.ifvmIsNotEmpty(result)) {
    		setLoyOfferDetail(result);

    		loyOfferData = result;

			if ($.fn.ifvmIsEmpty(result.expDividList)) {
				loyOfferData.expDividList = [];
			}
			/* 제한 채널 ( 2017. 6. 28. 주석처리 )
             */
			if ($.fn.ifvmIsEmpty(result.useLmtChnlList)) {
				loyOfferData.useLmtChnlList = [];
			}
            /* 제한 모델 ( 2017. 6. 28. 주석처리 )
            if ($.fn.ifvmIsEmpty(result.useLmtProdList)) {
                loyOfferData.useLmtProdList = [];
            }
             */

            if ($.fn.ifvmIsEmpty(result.relCampaignList)) {
				loyOfferData.relCampaignList = [];
			}

			// 포인트
			if ($.fn.ifvmIsEmpty(result.pntDtlList)) {
				loyOfferData.pntDtlList = [];
			}
			/*
			// 쿠폰
			if ($.fn.ifvmIsEmpty(result.cpnDtlList)) {
			    loyOfferData.cpnDtlList = [];
			}
			 */
    	}
    });
}

//오퍼 상세 설정
function setLoyOfferDetail(data) {
	$("#offerNo").val(data.offerNo);
	$("#offerNm").val(data.offerNm);
	$("#offerTypeCd").val(data.offerTypeCd);
	$("#offerTypeCd").change();
	$("#offerSubTypeCd").val(data.offerSubTypeCd);

	$('input:radio[name=offerAplyDdTypeCd]:input[value=' + data.offerAplyDdTypeCd + ']').attr("checked", true);
	$("#offerStatusCd").val(data.offerStatusCd);
	$("#offerCostDivCd").val(data.offerCostDivCd);
}

//탭 설정
function setLoyOfferTabArea() {

	$("#loyOfferTabArea").ejTab({
	    dataType: "html",
	    contentType: "html",
	    async: false
	});

	//포인트관리 그리드 설정
	if (typeof setLoyOfferPntDtlListGrid == "function") {
		setLoyOfferPntDtlListGrid();
	}

	/*
	//제한모델 그리드 설정 ( 2017. 6. 28. 주석처리 )
	if (typeof setLoyOfferUseLmtProdListGrid == "function") {
		setLoyOfferUseLmtProdListGrid();
	}
	*/
	/* */
	//제한채널 그리드 설정 ( 2017. 6. 28. 주석처리 )
	if (typeof initLoyOfferUseLmtChnlData == "function") {
		initLoyOfferUseLmtChnlData();
	}


	//분담률 그리드 설정
	if (typeof setLoyOfferExpDividListGrid == "function") {
		setLoyOfferExpDividListGrid();
	}

	//관계캠페인 그리드 설정
	if (typeof setLoyOfferRelCampaignListGrid == "function") {
		setLoyOfferRelCampaignListGrid();
	}
}

//오퍼 저장
function loyOfferSave() {
	if (loyOfferValidation.confirm()) {
		//
		$.ifvProgressControl(true);

		//오퍼일련번호
		loyOfferData.offerNo = $("#offerNo").val();

		//오퍼명
		loyOfferData.offerNm = $("#offerNm").val();

		//오퍼유형
		loyOfferData.offerTypeCd = $("#offerTypeCd").val();
		loyOfferData.offerTypeNm = $("#offerTypeCd option:selected").text();

		//오퍼유형상세
		loyOfferData.offerSubTypeCd = $("#offerSubTypeCd").val();
		loyOfferData.offerSubTypeNm = $("#offerSubTypeCd option:selected").text();

		//상태
		loyOfferData.offerStatusCd = $("#offerStatusCd").val();
		loyOfferData.offerStatusNm = $("#offerStatusCd option:selected").text();

		//오퍼비용구분
		loyOfferData.offerCostDivCd = $("#offerCostDivCd").val();
		loyOfferData.offerCostDivNm = $("#offerCostDivCd option:selected").text();

		//할인금액
        loyOfferData.dcAmt = 0;

		//오퍼 구분(마케팅/로얄티)
		loyOfferData.type = 'LOY';

		//해당 오퍼를 사용하는 활성 캠페인이 존재하는가?
        if (fnCheckActCamUsingOffer(loyOfferData.id) == true) {
            alert("<spring:message code='M02210'/>");
        }
		//오퍼 저장
        else {
    	    $.ifvSyncPostJSON('<ifvm:action name="saveLoyOffer"/>', loyOfferData,
       	    function(result) {
       	        if ($.fn.ifvmIsNotEmpty(result)) {

    	   	 	   	if (typeof addNewBenefitsOffer == "function" || typeof editBenefitsOffer == "function") {

    	   	 	   		alert("<spring:message code='M01857'/>");

    	   	 	   		$.ifvProgressControl(false);

    	   	 	   		var obj = {
    	   	 	   			  offerNo: loyOfferData.offerNo
    	   	 	   			, offerName: loyOfferData.offerNm
    	   	 	   			, applyStrDate: loyOfferData.aplyStartDd
    	   	 	   			, applyEndDate: loyOfferData.aplyEndDd
    	   	 	   			, commStatus: loyOfferData.offerStatusNm
    	   	 	   			, mktOfferCostGbn: loyOfferData.offerCostDivNm
    	   	 	   			, offerTypeCd: loyOfferData.offerTypeNm
    	   	 	   			, offerSubTypeCd: loyOfferData.offerSubTypeCd
    	   	 	   			, discountType: loyOfferData.dcTypeNm
    	   	 	   		};

    	   	 	   		if ($.fn.ifvmIsEmpty(loyOfferData.id)) {
    						obj.offerId = result.message;
    						obj.id = result.message;

    		   	 	   		//혜택 목록추가
    		   		    	addNewBenefitsOffer(obj);
    	   	 	   		}
    	   	 	   		else {
    		   	 	   		obj.offerId = result.message;
    						obj.id = result.message;

    						//혜택 목록수정
    						editBenefitsOffer(obj);
    	   	 	   		}

    	   		    	//팝업 닫기
    	   		        benefitsOfferListPopClose();
    	   		   	}
    	   	 	   	else {
    	   	        	//데이터 재구성
    	   	        	initLoyOfferDetailData(result.message);

    	   	        	alert("<spring:message code='M01857'/>");
    	   		   	}
       	        }
       	    });
        }
	   	$.ifvProgressControl(false);
	}
}

function fnCheckActCamUsingOffer(getOfferRid) {

    var rtnFlag = false; // 상태 = 해당 캠페인 없음

    $.ifvSyncPostJSON('<ifvm:action name="checkActCamUsingOffer"/>', {
        id : getOfferRid
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {

            // 사용중인 활성화된 캠페인이 있을때 : 수정, 삭제 불가
            if (Number(result) > 0) {
                rtnFlag = true;
            }
        }
    });

    return rtnFlag;
}

//목록이동
function goloyOfferList() {
	var url = '<ifvm:url name="loyOfferList"/>';
    qtjs.href(url);
}

$(function() {

    $.ifvmLnbSetting('loyOfferList');

	initLoyOfferDetail();
	initLoyOfferDetailData();

	//저장
	$('#loyOfferSaveBtn').on('click', function() {
		loyOfferSave();
    });

	//목록
	$('#loyOfferListBtn').on('click', function() {
		goloyOfferList();
    });

});

</script>


<div class="page-title">
	<h1>
		<spring:message code="M00308"/>&gt;  <spring:message code="M00274"/>
	</h1>
</div>

<div class="page_btn_area" id="headForm">
	<div class="col-xs-7">
		<span><spring:message code="M00327"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
        <%-- 저장버튼 --%>
		<button class="btn btn-sm" id="loyOfferSaveBtn">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00573"/>
		</button>
        <%-- 목록버튼 --%>
		<button class="btn btn-sm" id="loyOfferListBtn">
            <spring:message code="M00002" />
        </button>
	</div>
</div>

<div class="well form-horizontal underline top_well" id="dataForm" >
	<div class="row  qt_border">
        <%-- 오퍼 번호 --%>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00313"/></label>
		<div class="col-xs-4 control_content">
			<ifvm:input type="text" disabled="true" id="offerNo"/>
			<span class="detail_txt"><spring:message code="M00328"/></span>
		</div>
        <%-- 오퍼명 --%>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00314"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="text" required="true" id="offerNm" maxLength="30"/>
		</div>
	</div>
	<div class="row qt_border">
        <%-- 오퍼비용구분 --%>
        <label class="col-xs-2 control-label"><spring:message code="M00331"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="offerCostDivCd" names="offerCostDivCd" />
        </div>
        <%-- 상태 --%>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01848"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:input type="select" required="true" id="offerStatusCd" names="offerStatusCd" />
		</div>
	</div>
    <div class="row">
        <%-- 오퍼분류 --%>
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00332"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" required="true" id="offerTypeCd" names="offerTypeCd" />
        </div>
        <%-- 오퍼분류상세 --%>
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01896"/></label>
        <div class="col-xs-3 control_content">
            <ifvm:input type="select" required="true" id="offerSubTypeCd" names="offerSubTypeCd" />
        </div>
    </div>
</div>

<div id="loyOfferTabArea">
	<ul>
		<li><a href="<ifvm:url name='loyOfferPntDtlInclude'/>"><spring:message code='L00239'/></a></li>
        <%--
		<li><a href="<ifvm:url name='loyOfferCpnDtlInclude'/>"><spring:message code='L00527'/></a></li>
         --%>
        <%-- 제한모델 & 제한채널 ( 2017. 6. 28. 주석처리 )
		 --%>
		<li><a href="<ifvm:url name='loyOfferUseLmtProdInclude'/>"><spring:message code='L00240'/></a></li>
		<li><a href="<ifvm:url name='loyOfferUseLmtChnlInclude'/>"><spring:message code='L00241'/></a></li>
        <li><a href="<ifvm:url name='loyOfferExpDividInclude'/>"><spring:message code='L00242'/></a></li>
		<li><a href="<ifvm:url name='loyOfferRelCampaignInclude'/>"><spring:message code='L00243'/></a></li>
	</ul>
</div>
