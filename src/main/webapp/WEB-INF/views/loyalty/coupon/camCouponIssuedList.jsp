<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var couponIssuedGrid;
var couponIssuedCountGrid;

function initCouponIssuedGrid() {

	var ejGridOption = {
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
			
			return data;
		},
		recordDoubleClick : function (args) {
			var camId = args.data.camId;
			qtjs.href('<ifvm:url name="campaignWorkFlow"/>?type=MKT&id=' +camId);
		},
		loadComplete : function(args) {
			initCouponIssuedCountGrid();
		},
	    dataUrl: '<ifvm:action name="getCamCouponIssuedList"/>',
	    columns:[
	    	  {
	      		  field : 'mbrNo', headerText : '<spring:message code="L00433"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'mbr.mbr_no' }
	      	  },{
	      		  field : 'ecommMbrNo', headerText : '<spring:message code="L02512"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'mbr.ECOMM_MBR_NO' }
	      	  },{
	      		  field : 'custNm', headerText : '<spring:message code="L00435"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'cust.cust_nm' }
	      	  },{
	      		  field : 'dispNo', headerText : '<spring:message code="L00417"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'cam.disp_no' }
	      	  },{
	      		  field : 'camNm', headerText : '<spring:message code="M00592"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Left,
	      		  customAttributes : {
	      			  index : 'cam.cam_nm' }
	      	  },{
	      		  field : 'coupnNm', headerText : '<spring:message code="M01309"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Left,
	      		  customAttributes : {
	      			  index : 'cpn.coupn_nm' }
	      	  },{
	      		  field : 'selfTotAmt', headerText : '<spring:message code="L02454"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'offer.self_tot_amt' }
	      	  },{
	      		  field : 'coupnNo', headerText : '<spring:message code="M00346"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'cpni.coupn_no' }
	      	  },{
	      		  field : 'aplyStartDd', headerText : '<spring:message code="M02420"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'cpni.aply_start_dd' }
	      	  },{
	      		  field : 'aplyEndDd', headerText : '<spring:message code="M02421"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'cpni.aply_end_dd' }
	      	  },{
	      		  field : 'recpYn', headerText : '<spring:message code="M02422"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'cpni.recp_yn' }
	      	  },{
	      		  field : 'recpDt', headerText : '<spring:message code="M02423"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'cpni.recp_dt' }
	      	  },{
	      		  field : 'useYn', headerText : '<spring:message code="L01569"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'cpni.use_yn' }
	      	  },{
	      		  field : 'useDt', headerText : '<spring:message code="M02424"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'cpni.use_dt' }
	      	  },{
	      		  field : 'rid', headerText : 'rid', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, visible : false ,
	      		  customAttributes : {
	      			  index : 'cpni.rid' }
	      	  },{
	      		  field : 'camId', headerText : 'camId', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, visible : false ,
	      		  customAttributes : {
	      			  index : 'cam.id' }
	      	  },
		],
		requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	    	  sidx : 'cpni.coupn_no',
	    	  sord : 'desc',
	    	  _search : false
	      },
	      rowList : [10,25,50,100],
	      radio: true,
		  tempId : 'ifvGridNotSearchTemplete',
	};
	
	couponIssuedGrid = $("#couponIssuedGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function initCouponIssuedCountGrid() {

	var ejGridOption = {
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
			
			return data;
		},
	    dataUrl: '<ifvm:action name="getCamCouponCount"/>',
	    columns:[
	    	  {
	      		  field : 'coupnCnt', headerText : '<spring:message code="L02450"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'coupnCnt' }
	      	  },{
	      		  field : 'recpCnt', headerText : '<spring:message code="L02451"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'recpCnt' }
	      	  },{
	      		  field : 'useCnt', headerText : '<spring:message code="L02452"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'useCnt' }
	      	  },{
	      		  field : 'pnt', headerText : '<spring:message code="L02453"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'pnt' }
	      	  }
		],
		requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	    	  sidx : '1',
	    	  sord : 'desc',
	    	  _search : false
	      },
	      rowList : [10,25,50,100],
	      radio: false,
		  tempId : 'ifvGridSimpleTemplete2',
	};
	
	couponIssuedCountGrid = $("#couponIssuedCountGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function() {
    
    initCouponIssuedGrid();

    // 조회
    $.fn.ifvmSetCommonCondList("couponIssuedSearchList", "CAM_COUPON_01");
    
    $("#camCouponIssuedSearchBtn").on('click', function() {
        $.fn.ifvmSubmitSearchCondition("couponIssuedSearchList", initCouponIssuedGrid);
    });
    
    $("#camCouponIssuedinitBtn").on('click', function() {
        $.fn.ifvmSetCommonCondList("couponIssuedSearchList", "CAM_COUPON_01");
    });
    
    $("#camCouponIssuedExcelExportBtn").on('click', function() {
    	$.ifvExcelDn('<ifvm:action name="getCamCouponIssuedListExport"/>','couponIssuedGrid');
    });
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="M02426" />
        &gt; <spring:message code="M00273" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="camCouponIssuedSearchBtn" objCode="camCouponIssuedSearchBtn_OBJ">
                <i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="camCouponIssuedinitBtn" objCode="camCouponIssuedinitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="couponIssuedSearchList"></div>
</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="camCouponIssuedExcelExportBtn" objCode="camCouponIssuedExcelExportBtn_OBJ">
                <i class="fa fa-search"></i>
                <spring:message code="M01356" />
            </button>
        </div>
    </div>
    <div id="couponIssuedCountGrid" class="white_bg grid_bd0"></div>
    <div id="couponIssuedGrid" class="white_bg grid_bd0"></div>
</div>