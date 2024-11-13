<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tiersList;
var tierBnftList;
var tiersRid = null;
var tierBnftRid = null;
var tierNm = null;

//팝업 닫기
function tiersDtlPopClose() {
	popdialog._destroy();
}

// 등급목록 조회
function tiersListInit(){
	var jqGridOption = {
		ondblClickRow : function(data){
   			var data = tiersList.getRowData()[data-1];
			tiersRid = data.rid;
			tiersPopInit();
		},
        onSelectRow : function (data) {
			tiersRid = data.rid;
			tierNm   = data.tierNm;
			tierBnftListInit(tiersRid);
			btnDisabled();
		},
		serializeGridData : function(data){
			data.ridTierGroup = ridTierGroup;
		},
		loadComplete : function(obj){
		},
		url: '<ifvm:action name="getTierDtlList"/>',
	    colNames:[
	              /* '<spring:message code="M01440"/>', */
	              '<spring:message code="M01972"/>'
	              ,'<spring:message code="L00235"/>'
	              ,'<spring:message code="L00236"/>'
	              ,'<spring:message code="L00391"/>'
	              ,'<spring:message code="L00393"/>'
	              ,'<spring:message code="M01973"/>'
	              ,'<spring:message code="L00237"/>'
	              ,'<spring:message code="L00238"/>'
	              ,'rid'
	              ],
	    colModel:[{name:'seqNo', index:'lt.seq_no', resizable : false, align:'center'},
	              {name:'tierCd', index:'lt.tier_cd', resizable : false, align:'center'},
	              {name:'tierNm', index:'lt.tier_nm', resizable : false},
	              {name:'validStartDate', index:'lt.valid_start_date', resizable : false, align:'center'},
	              {name:'validEndDate', index:'lt.valid_end_date', resizable : false, align:'center'},
	              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false},
	              {name:'createBy', index:'e.NAME', resizable : false},
	              {name:'createDate', index:'lt.create_date', resizable : false, align:'center'},
	              {name:'rid', index:'lt.rid', hidden : true}
			      ],
	    sortname: 'lt.seq_no, lt.valid_start_date',
		sortorder: "asc",
	    tempId : 'ifvGridOriginTemplete'
	};
	tiersList = $("#tiersList").ifvGrid({ jqGridOption : jqGridOption });
}

// 등급별 혜택 조회
function tierBnftListInit(tiersRid){
	var jqGridOption = {
        onSelectRow : function (data) {
		},
		serializeGridData : function(data){
			data.tiersRid = tiersRid;
		},
		loadComplete : function(obj){
		},
		url: '<ifvm:action name="getTierBnftList"/>',
	    colNames:[
	              '캠페인번호'
	              ,'캠페인명'
	              ,'오퍼번호'
	              ,'오퍼명'
	              ,'등급혜택명'
	              ,'혜택금액'
	              ,'캠페인 시작일'
	              ,'캠페인 종료일'
	              ,'수정자'
	              ,'수정일시'
	              ],
	    colModel:[
	              {name:'dispNo', index:'a.DISP_NO', resizable : false},
	              {name:'camNm', index:'a.cam_nm', resizable : false},
	              {name:'offerNo', index:'f.OFFER_NO', resizable : false},
	              {name:'offerNm', index:'f.OFFER_NM', resizable : false},
	              {name:'tierBnftNm', index:'a.PNT_ACCNT_CUST_DISP_TXT', resizable : false, width: "180px" },
	              {name:'acrlAmt', index:'b.ACRL_AMT', resizable : false, align:'center'},
	              {name:'validStartDate', index:'a.CAM_START_DD', resizable : false, align:'center'},
	              {name:'validEndDate', index:'a.CAM_END_DD', resizable : false, align:'center'},
	              {name:'modifyBy', index:'e.NAME', resizable : false},
	              {name:'modifyDate', index:'a.MODIFY_DATE', resizable : false, align:'center'},
			      ],
	    sortname: 'a.MODIFY_DATE',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	tierBnftList = $("#tierBnftList").ifvGrid({ jqGridOption : jqGridOption });
}

//등급목록 팝업
function tiersPopInit(){
	$("#popdialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierDtlPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01978" />',
        width: 650,
        close : 'tiersDtlPopClose',
    });
}

//등급별혜택 팝업
function tierBnftPopInit(){
	$("#popdialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierBnftPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01979" />',
        width: 650,
        close : 'tiersDtlPopClose',
    });

}

function btnDisabled(){
	if(tiersRid != null){
		$("#addTierBnftBtn").attr("disabled",false);
	}else{
		$("#addTierBnftBtn").attr("disabled",true);
	}
}

$(document).ready(function(){
	// 등급목록 조회
	tiersListInit();
	tierBnftListInit();

	//타겟 레벨 추가
	$("#addTiersBtn").on("click", function(){
		tiersRid = null;
		tiersPopInit();
	});

	//타겟 레벨 추가
	$("#addTierBnftBtn").on("click", function(){
		tierBnftRid = null;
		tierBnftPopInit();
	});

	// 신규/수정 경우 버튼 disabled
	if(ridTierGroup == null){
		$("#addTiersBtn").attr("disabled",true);
	}else{
		$("#addTiersBtn").attr("disabled",false);
	}
// 	btnDisabled();
});

</script>
<div class="page_btn_area">
	<div class="col-xs-7">
		<spring:message code="M01980" />
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addTiersBtn">
			<i class="fa fa-plus"></i>
			<spring:message code="M01852"/>
		</button>
	</div>
</div>
<div id="tiersList" class="grid_bd0"></div>
<div class="page_btn_area">
	<div class="col-xs-7">
		 <spring:message code="M01979" />
	</div>
	<div class="col-xs-5 searchbtn_r">
	</div>
</div>
<div id="tierBnftList" class="grid_bd0"></div>
