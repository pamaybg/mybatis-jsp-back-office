<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var camCouponGrid;
var camCouponGridDiv;

/** 
 * 쿠폰 목록 조회
 */
function getStoreChnlGrid() {
    
    var jqGridOption = {
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj) {
        },
        url : '<ifvm:action name="getCampaignCouponList"/>',
        colNames:[ 
            '<spring:message code="M02380" />',
            '<spring:message code="M00347" />',
            '<spring:message code="M01304" />',
            '<spring:message code="M01304" />',
            'coupnImgTypeCd',
            'coupnDesc',
            'coupnUseGdnc1',
            'coupnUseGdnc2',
            'coupnUseGdnc3',
            'coupnUseGdnc4',
            'coupnUseGdnc5',
            'coupnUseGdnc6',
            'coupnUseGdnc7',
            'coupnUseGdnc8',
            'coupnUseGdnc9',
            'coupnUseGdnc10',
            'rid',
        ],
        colModel:[
             { name:'coupnNo',        index:'t1.coupn_no',          resizable : false, align:'center', width:'100px' }, //쿠폰번호          
             { name:'coupnNm',        index:'t1.coupn_nm',          resizable : false, align:'center', width:'100px' }, //쿠폰명            
             { name:'useStartDt',     index:'t1.useStartDt',        resizable : false, align:'center', width:'100px', formatter:"date" , formatoptions:{ newformat:"Y-m-d"} }, //사용시작일시      
             { name:'useEndDt',       index:'t1.use_start_dt',      resizable : false, align:'center', width:'100px', formatter:"date" , formatoptions:{ newformat:"Y-m-d"} }, //사용종료일시      
             { name:'coupnImgTypeCd', index:'t1.coupn_img_type_cd', hidden : true, searchable : false },                //쿠폰이미지유형코드
             { name:'coupnDesc',      index:'t1.coupn_desc',        hidden : true, searchable : false },                //쿠폰설명          
             { name:'coupnUseGdnc1',  index:'t1.coupn_use_gdnc1',   hidden : true, searchable : false },                //쿠폰 사용안내1    
             { name:'coupnUseGdnc2',  index:'t1.coupn_use_gdnc2',   hidden : true, searchable : false },                //쿠폰 사용안내2    
             { name:'coupnUseGdnc3',  index:'t1.coupn_use_gdnc3',   hidden : true, searchable : false },                //쿠폰 사용안내3    
             { name:'coupnUseGdnc4',  index:'t1.coupn_use_gdnc4',   hidden : true, searchable : false },                //쿠폰 사용안내4    
             { name:'coupnUseGdnc5',  index:'t1.coupn_use_gdnc5',   hidden : true, searchable : false },                //쿠폰 사용안내5    
             { name:'coupnUseGdnc6',  index:'t1.coupn_use_gdnc6',   hidden : true, searchable : false },                //쿠폰 사용안내6    
             { name:'coupnUseGdnc7',  index:'t1.coupn_use_gdnc7',   hidden : true, searchable : false },                //쿠폰 사용안내7    
             { name:'coupnUseGdnc8',  index:'t1.coupn_use_gdnc8',   hidden : true, searchable : false },                //쿠폰 사용안내8    
             { name:'coupnUseGdnc9',  index:'t1.coupn_use_gdnc9',   hidden : true, searchable : false },                //쿠폰 사용안내9    
             { name:'coupnUseGdnc10', index:'t1.coupn_use_gdnc10',  hidden : true, searchable : false },                //쿠폰 사용안내100  
             { name:'rid',            index:'t1.rid',               hidden : true, searchable : false },                //RID
        ],
        sortname : 't1.rid',
        sortorder : "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete',
    };

    camCouponGrid = $("#camCouponGridDiv").ifvGrid({
        jqGridOption : jqGridOption
    });
    camCouponGridDiv = $("#camCouponGridDiv");
    camCouponGridDiv.resize();
}

/**
 * 선택한 쿠폰 복사
 */
function copyCouponDetail() {
    var len = camCouponGrid.getCheckedList();
    if (len.length > 0) {

        // 데이터 복사 
        var data = camCouponGrid.getCheckedList()[0];
        
        if ($.fn.ifvmIsEmpty(campaignCoupon) == false) {
            data.rid = campaignCoupon.rid;
            data.coupnNo = campaignCoupon.coupnNo;
        }
        else {
            data.rid = null;
            data.coupnNo = null;
        }
        
        campaignCoupon = data;
        camCoupon_setDetil(true);
        
        // 팝업 종료
        camCouponListPopupClose();
    }
}

$(document).ready(function() {
    
    getStoreChnlGrid();
    
    // 선택 버튼
    $('#camCouponCopyBtn').on('click', function() {
        copyCouponDetail();
    });
    
    // 닫기 버튼
    $('#camCouponListPopCancelBtn').on('click', function() {
        camCouponListPopupClose();
    });
});
    
</script>

<div id="useDeskPopWrap">
    <div class="pop_inner_wrap form-horizontal" id="camCouponListPop" >
        <div id="camCouponGridDiv"></div>
    </div>
    
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="camCouponCopyBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2" id="camCouponListPopCancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>