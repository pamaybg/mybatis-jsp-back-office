<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var tierGrpListGrid;
var rid;
var status = "I";

//등급그룹 목록 조회
function getTierGrpList(){
    var jqGridOption = {
       	ondblClickRow : function(data){
       		var data = tierGrpListGrid.getRowData()[data-1];
       		rid = data.rid;
       		status = "U";
    		location.href = '<ifvm:url name="tierGroupDtl"/>?rid='+rid+"&status="+status;
       	},
        onSelectRow : function (data) {
       	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
       	},
       	loadComplete : function(obj){
       		var cnt = obj.rows.length;
       	},
        url : '<ifvm:action name="getTierGroupList"/>',
        colNames:[
                   '<spring:message code="M02006" />',
                   '<spring:message code="M02013" />',
                   '<spring:message code="M02008" />',
                   '<spring:message code="M02010" />',
                   '<spring:message code="M02011" />',
                   '<spring:message code="M01131"/>',
                   '<spring:message code="M01132"/>',
                   'rid',
                   'ridTierDflt'
                 ],
        colModel:[
            { name:'tierGrpNm', index:'ltg.tier_grp_nm', resizable : false },
            { name:'tierNm', index:'lt.tier_nm', resizable : false },
            { name:'tierupCyclMmVal', index:'ltg.tierup_cycl_mm_val', resizable : false, align:'center' },
            { name:'validPeriodMmVal', index:'ltg.valid_period_mm_val', resizable : false, align:'center'},
            { name:'rsltExtrPeriodMmVal', index:'ltg.rslt_extr_period_mm_val', resizable : false, align:'center'},
            { name:'createBy', index:'e.NAME', resizable : false},
            { name:'createDate', index:'ltg.create_date', resizable : false, align:'center'},
            { name:'rid', index:'ltg.rid', hidden : true},
            { name:'ridTierDflt', index:'ltg.rid_tier_dflt', hidden : true }
        ],
        sortname: 'ltg.create_date',
        sortorder: "desc",
        radio : true,
        tempId : 'ifvGridOriginTemplete'
    };

    tierGrpListGrid = $("#tierGrpListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//공통 조회 조건 목록 설정
function tierGrpListSearchInit() {
    $.fn.ifvmSetCommonCondList("tierGrpSearchList","PLOY_101");
}

//공통 조회 호출
function tierGrpListSearch() {
    $.fn.ifvmSubmitSearchCondition("tierGrpSearchList", getTierGrpList);
}

//삭제
function removeTier() {

	if($.fn.ifvmIsNotEmpty(tierGrpListGrid)) {
		var delList = tierGrpListGrid.getCheckedList();
		if($.fn.ifvmIsNotEmpty(delList)) {
			if(!confirm('<spring:message code="M00127" />')) return;

			$.ifvSyncPostJSON('<ifvm:action name="removeTierGrp"/>', {
				rid: delList[0].rid
			}, function(result) {
					alert('<spring:message code="M01266" />');
					getTierGrpList( );
			});
		} else {
			alert('<spring:message code="M00108"/>');
		}
	} else {
		alert('<spring:message code="M00108"/>');
	}
}



$(document).ready(function() {
	getTierGrpList();

    //공통 조회 조건 목록 설정
    tierGrpListSearchInit();

    //조회
    $('#tierGrpListSearchBtn').on('click', function(){
    	tierGrpListSearch();
    });

    //초기화
    $("#tierGrpListSearchInitBtn").on('click', function(){
    	tierGrpListSearchInit();
    });

    //신규 클릭시
    $('#tierGrpNewBtn').on('click', function(){
    	rid = null;
    	status = "I";
    	location.href = '<ifvm:url name="tierGroupDtl"/>?status='+status;
    });

    //삭제
    $("#tierGrpDelBtn").on('click', function(){
    	removeTier();
    });

});

</script>

<div class="page-title">
    <h1>
    등급 &gt; 조회
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00276" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="tierGrpListSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="tierGrpListSearchInitBtn">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="tierGrpSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <!-- 신규 -->
            <button class="btn btn-sm" id="tierGrpNewBtn"><i class="fa fa-plus"></i>
                <spring:message code="M00136" />
            </button>
            <!-- 삭제 -->
            <button class="btn btn-sm" id="tierGrpDelBtn"><i class="fa fa-minus"></i>
                <spring:message code="M00218" />
            </button>
        </div>
    </div>
    <div id="tierGrpListGrid" class="white_bg grid_bd0"></div>
</div>
