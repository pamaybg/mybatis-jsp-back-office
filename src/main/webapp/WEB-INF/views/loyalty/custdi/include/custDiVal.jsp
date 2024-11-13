<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
	</div>
	<div class="col-xs-5 searchbtn_r">
		<!-- 신규버튼 -->
		<button class="btn btn-sm" id="addCustDiValBtn" objCode="addCustDiValBtn_OBJ">
			<spring:message code="L00078" />
		</button>
		<!-- 삭제버튼 -->
		<button class="btn btn-sm" id="delCustDiValBtn" objCode="delCustDiValBtn_OBJ">
			<spring:message code="M00218" />
		</button>
	</div>
</div>
<div id="custDiValListGrid" class="white_bg grid_bd0"></div>
<div id=custDiValDetailPopupContainer class="popup_container"></div>
<script type="text/javascript">
var diValRid = null;
var custDiValList;

//클럽목록 조회 리스트
function custDiValListSearch() {
	
	var ejGridOption = {
		recordDoubleClick : function(args) {
			var data = args.data;
			diValRid = data.rid;
			getCustDiValDetailPop(diValRid);
		},
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			data.ridCustDi = custDiRid;
			return data;
		},
		rowSelected : function (args) {
			diValRid = args.data.rid;
        },
        dataUrl : '<ifvm:action name="getCustDiValList"/>',
		columns : [
			{
				field : 'seq', headerText : '<spring:message code="순서"/>',  textAlign : 'center', customAttributes :{searchable : true}, width : '15%'
			}, {
				field : 'field', headerText : '<spring:message code="항목명"/>',  textAlign : 'center', customAttributes :{index : 'fieldCd'}
			}, {
				field : 'fieldCd', headerText : '<spring:message code="항목 코드"/>',  textAlign : 'center'
			},  {
				field : 'createBy', headerText : '<spring:message code="M00221"/>', textAlign : 'center'
			}, {
				field : 'createDate', headerText : '<spring:message code="M00222"/>',  textAlign : 'center'
			}, {
				field : 'rid', headerText : 'rid', visible : false,
			} ],
		 requestGridData : {
			sidx : 'seq',
			sord : 'asc'
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true
	};

	custDiValList = $("#custDiValListGrid").ifvsfGrid({ejGridOption: ejGridOption});
}

function getCustDiValDetailPop(rid){
	$("#custDiValDetailPopupContainer").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="custDiValPop"/>'+ '?diValRid=' + rid,
        contentType: "ajax",
        title: '<spring:message code="L02756"/>',
        width: 500,
        close : 'getCustDiValDetailPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	});
        }
    });
}

function getCustDiValDetailPopupClose() {
	custDiValDetailPopupContainer._destroy();
} 

function romoveCustDiVal(){
	if(diValRid == null){
		alert('<spring:message code="C00113"/>');
	}else{
		$.ifvSyncPostJSON('<ifvm:action name="removeCustDiVal"/>',{rid : diValRid},function(result){
			alert('<spring:message code="L00034"/>');
			custDiValList._doAjax();
		});
	}
}

/* function checkDetailState(){
	if(custDiRid == undefined || custDiRid == null){
		custDiValListSearch();
		$("#addCustDiValBtn").attr("disabled",true)
		$("#delCustDiValBtn").attr("disabled",true)
	}else{
		custDiValListSearch();
	}
} */
$(document).ready(function(){
	
	custDiValListSearch();
	
	$("#addCustDiValBtn").click(function(){
		if(custDiRid == undefined || custDiRid == null){
			alert('<spring:message code="C00174"/>');
		}else{
			diValRid = null;
			getCustDiValDetailPop();
		}
	});
	
	$("#delCustDiValBtn").click(function(){
		romoveCustDiVal();
	});
	
});
</script>