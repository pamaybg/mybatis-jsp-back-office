<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var loyOfferRelCampaignListGrid;
var gridIdloyOfferRelCampaignListGrid;
var loyOfferRelCampaignInfoPopupOpenType;
var selLoyOfferRelCampaignData;

function initLoyOfferRelCampaign() {
}

function initLoyOfferRelCampaignData() {
	//그리드 설정
	setLoyOfferRelCampaignListGrid();
}

//대상상품 목록 그리드 설정
function setLoyOfferRelCampaignListGrid(){
	//colnames
	var colNames = [];
	
	//colmodel
	var colModel = [];
	
	//상품별포인트
	colNames.push("<spring:message code='L00268'/>");
	colNames.push("<spring:message code='L00269'/>");
	colNames.push("<spring:message code='L00270'/>");
	colNames.push("<spring:message code='L00271'/>");
	colNames.push("<spring:message code='L00272'/>");
	colNames.push("<spring:message code='L00273'/>");
	colNames.push("<spring:message code='L00274'/>");
	colNames.push("<spring:message code='L00275'/>");
	colNames.push("<spring:message code='L00276'/>");
	colNames.push('rid');
	
	colModel.push({name:'dispNo',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'camNm',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'camTypeNm',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'camStatusNm',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'camStartDd',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'camEndDd',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'createByNm',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'divNm',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'createDate',index:'', width:'100px', align:'center', resizable : false});
	colModel.push({name:'rid', index:'', resizable : false,  hidden : true,  searchable : false});
	
	var jqGridOption = {
 		loadComplete : function(obj){
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'dialog',
				contentsId : 'dialogPopupWrap'
			});
 		},
	    ondblClickRow : function (id) {
        },
	    data: loyOfferData.relCampaignList,
	    datatype: 'clientSide',
	    colNames: colNames,
	    colModel: colModel,
	    rowList : [100000],
	    radio: true,
        tempId : 'ifvGridSimpleTemplete',
	};
	
    loyOfferRelCampaignListGrid = $("#loyOfferRelCampaignListGrid").ifvGrid2({ jqGridOption : jqGridOption });
	gridIdloyOfferRelCampaignListGrid = $("#gridIdloyOfferRelCampaignListGrid");
}

$(document).ready(function() {
	initLoyOfferRelCampaign();
	initLoyOfferRelCampaignData();
});

</script>

<div id="loyOfferRelCampaignWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
        </div>
    </div>
    <div id="loyOfferRelCampaignListGrid" class="white_bg grid_bd0"></div>     
</div>
<div id="loyOfferRelCampaignInfoPopup"></div>
