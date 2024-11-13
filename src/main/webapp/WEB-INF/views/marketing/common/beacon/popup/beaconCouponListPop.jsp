<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 

<script type="text/javascript">

var beaconCouponListGrid;

//팝업 설정
function beaconCouponListInit(){
	
	var jqGridOption = {
		onSelectCell : function (data) {
		    
		},
		serializeGridData : function( data ){
			return data;
		},
        url : '<ifvm:action name="getCommonBeaconCouponList"/>',
        colNames:[ '쿠폰명',
		           '사용기간',
		           '제한 발급 수',
		           '총 발급 수',
		           '적용점포수',
		           /* '상태', */
		           '스토어명',
		           'couponId'
		         ],
        colModel:[
            { name:'couponName', index:'couponName', width: '200px' },
            { name:'availableFinishDate', index:'availableFinishDate', align: 'center', width: '200px', formatter: dateFomatter },
            { name:'limitCnt', index:'limitCnt', align: 'right', width: '90px' },
            { name:'issueCnt', index:'issueCnt', align: 'right', width: '90px' },
            { name:'applyCnt', index:'applyCnt', align: 'right', width: '90px' },
            /* { name:'couponStatus', index:'couponStatus', align: 'center', width: '80px' }, */
            { name:'accountName', index:'accountName', align: 'left', width: '200px' },
            { name:'couponId', index:'couponId', hidden : true }
        ],
		   
        sortname: 'availableStartDate',
        sortorder: "desc",
        tempId : "ifvGridOriginTemplete",
        caption: '<spring:message code="M01313" />',
        radio : true,
    };
	
	beaconCouponListGrid = $("#beaconCouponListGrid").ifvGrid({ jqGridOption : jqGridOption }); 
};

//발급기간 설정
function dateFomatter(cellvalue, options, rowObject){
	return $.ifvFormatDate( 'yyyy-mm-dd', rowObject.availableStartDate ) + ' ~ ' + $.ifvFormatDate( 'yyyy-mm-dd', rowObject.availableFinishDate );
};

$(document).ready(function(){
    beaconCouponListInit();	
	
	//선택 클릭시
    $("#beaconCouponListPopSelectBtn").on('click', function(){
        beaconCouponListPopSelectSet();
        
        beaconCouponListPopClose();
    });
	
	
	//취소 클릭시
    $("#sbeaconCouponListPopCloseBtn").on('click', function(){
        beaconCouponListPopClose();	
    });
});

</script>


<div id="beaconCouponListPopWrap">
	<div class="pop_inner_wrap">
		<div id="beaconCouponListGrid" class=""></div>
	</div>	
			
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="beaconCouponListPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="sbeaconCouponListPopCloseBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>