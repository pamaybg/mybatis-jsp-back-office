<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tierupMatrixList;
var tierupMatrixRid;

//팝업 닫기
function tiersDtlPopClose() {
	popdialog._destroy();
}


//타겟 레벨 삭제
function removeTierup(){
	var selectData = tierupMatrixList.getCheckedGridData();
	ridTierupMatrix = [];

	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(confirm('<spring:message code="M00296"/>')){
			for(var i=0; i<selectData.length; i++){
				ridTierupMatrix.push(selectData[i].rid);
			}
			$.ifvSyncPostJSON('<ifvm:action name="removeTierupMatrix"/>',{
				ridTierupMatrix	: ridTierupMatrix, ridTierGroup : ridTierGroup
			},function(result) {
				alert('<spring:message code="M00622"/>');
				tierupMatrixListInit();
			});
		}
	}
}


function tierupMatrixListInit(){
	var jqGridOption = {
		ondblClickRow : function(data){
   			var data = tierupMatrixList.getRowData()[data-1];
   			tierupMatrixRid = data.rid;
   			tierupMatrixPopInit();
		},
        onSelectRow : function (data) {
		},
		serializeGridData : function(data){
			data.ridTierGroup = rid;
		},
		loadComplete : function(obj){
		},
		url: '<ifvm:action name="getTierUpMatrixList"/>',
	    colNames:[
	              '<spring:message code="M01981" />'
	              ,'<spring:message code="M01982" />'
	              ,'<spring:message code="M01983" />'
	              ,'<spring:message code="M01984" />'
	              ,'<spring:message code="M01859"/>'
	              ,'<spring:message code="M01860"/>'
	              ,'rid'
	              ],
	    colModel:[{name:'ridTierCurNm', index:'lt1.tier_nm', resizable : false},
	              {name:'ridTierNextNm', index:'lt2.tier_nm', resizable : false},
	              {name:'tierupStatNm', index:'c.mark_name', resizable : false},
	              {name:'tierupVal', index:'', width: "450px", resizable : true},
	              {name:'createBy', index:'e.NAME', resizable : false},
	              {name:'createDate', index:'ltm.create_date', align:'center', resizable : false },
	              {name:'rid', index:'ltm.rid', hidden : true}
			      ],
		radio:true,
	     sortname: 'ltm.create_date',
		 sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	tierupMatrixList = $("#tierupMatrixList").ifvGrid({ jqGridOption : jqGridOption });
}

//팝업.
function tierupMatrixPopInit(){
	$("#popdialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierUpMatrixPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01985" />',
        width: 650,
        close : 'tiersDtlPopClose',
    });
}


$(document).ready(function(){
	tierupMatrixListInit();

	//추가
	$("#addTierupBtn").on("click", function(){
		tierupMatrixRid = null;
		tierupMatrixPopInit();
	});

	//채널삭제
	$("#delTierupBtn").on("click", function(){
		removeTierup();
	});

	if(ridTierGroup != null){
		$("#addTierupBtn").attr("disabled",false);
		$("#delTierupBtn").attr("disabled",false);
	}else{
		$("#addTierupBtn").attr("disabled",true);
		$("#delTierupBtn").attr("disabled",true);
	}

});

</script>

<div class="page_btn_area">
	<div class="col-xs-7">
		 <spring:message code="M01986" />
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addTierupBtn">
			<i class="fa fa-plus"></i>
			<spring:message code="M01852"/>
		</button>
		<button class="btn btn-sm" id="delTierupBtn">
			<i class="fa fa-minus"></i>
			<spring:message code="M01854"/>
		</button>
	</div>
</div>
<div id="tierupMatrixList" class="grid_bd0"></div>

