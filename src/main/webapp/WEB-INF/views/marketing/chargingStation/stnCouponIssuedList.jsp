<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var couponIssuedGrid;
var couponIssuedGridDiv;

function initCouponIssuedGrid() {

    var jqGridOption = {
        serializeGridData: function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
//         ondblClickRow : function(data) {
//             var rowData = couponIssuedGrid.getRowData()[data-1];
//             if ($.fn.ifvmIsNotEmpty(rowData)) {
//                 qtjs.href('<ifvm:url name="campaignWorkFlow"/>?id=' +rowData.camId);
//             }
//         },
        loadComplete : function(obj) {
        },
        url: '<ifvm:action name="getStnCamCouponIssuedList"/>',
        colNames:[
                  '<spring:message code="L00433"/>', 
                  '<spring:message code="L00435"/>', 
                  '<spring:message code="L00417"/>', 
                  '<spring:message code="M00592"/>', 
                  '<spring:message code="L00938"/>', 
                  '<spring:message code="M01309"/>', 
                  '<spring:message code="M00346"/>', 
                  '<spring:message code="M02420"/>', 
                  '<spring:message code="M02421"/>', 
                  '<spring:message code="M02422"/>', 
                  '<spring:message code="M02423"/>', 
                  '<spring:message code="L01569"/>', 
                  '<spring:message code="M02424"/>', 
                  '<spring:message code="M02425"/>', 
                  'rid', 
                  'camId'
                  ],
        colModel:[
            {name:'mbrNo',       index:'mbr.mbr_no',         resizable : false, align:'center'},
            {name:'custNm',      index:'cust.cust_nm',       resizable : false},
            {name:'dispNo',      index:'cam.disp_no',        resizable : false},
            {name:'camNm',       index:'cam.cam_nm',         resizable : false},
            {name:'chnlNm',      index:'chnl.chnl_nm',       resizable : false},
            {name:'coupnNm',     index:'cpn.coupn_nm',       resizable : false},
            {name:'coupnNo',     index:'cpni.coupn_no',      resizable : false},
            {name:'aplyStartDd', index:'cpni.aply_start_dd', resizable : false, formatter: "date", formatoptions: { newformat: "Y-m-d" }},
            {name:'aplyEndDd',   index:'cpni.aply_end_dd',   resizable : false, formatter: "date", formatoptions: { newformat: "Y-m-d" }},
            {name:'recpYn',      index:'cpni.recp_yn',       resizable : false},
            {name:'recpDt',      index:'cpni.recp_dt',       resizable : false},
            {name:'useYn',       index:'cpni.use_yn',        resizable : false},
            {name:'useDt',       index:'cpni.use_dt',        resizable : false},
            {name:'pwnYn',       index:'cpni.pwn_yn',        resizable : false},
            {name:'rid',         index:'cpni.rid',           hidden : true, searchable : false},
            {name:'camId',       index:'cam.id',             hidden : true, searchable : false},
        ],
        radio : true,
        sortname: 'rid',
        sortorder: 'desc',
    };
    couponIssuedGrid = $("#couponIssuedGridDiv").ifvGrid({ jqGridOption : jqGridOption });
    couponIssuedGridDiv = $("#couponIssuedGridDiv");
}

$(document).ready(function() {
	
    initCouponIssuedGrid();

    // 조회
    $.fn.ifvmSetCommonCondList("couponIssuedSearchList", "STNCAM003");
    
    $("#authGroupSearchBtn").on('click', function() {
        $.fn.ifvmSubmitSearchCondition("couponIssuedSearchList", initCouponIssuedGrid);
    });
    $("#authGroupinitBtn").on('click', function() {
        $.fn.ifvmSetCommonCondList("couponIssuedSearchList", "STNCAM003");
    });

});

</script>

<!-- <div class="page-title"> -->
<!--     <h1> -->
<%--         <spring:message code="M02426" /> --%>
<%--         &gt; <spring:message code="M00273" /> --%>
<!--     </h1> -->
<!-- </div> -->

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="authGroupSearchBtn">
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="authGroupinitBtn">
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
    </div>
    <div id="couponIssuedGridDiv" class="white_bg grid_bd0"></div>     
</div>