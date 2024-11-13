<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00599"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
        <ifvm:inputNew type="button" id="addClubOffer"  text="M00163" objCode="addClubOffer_OBJ"/>
        <ifvm:inputNew type="button" id="delClubOffer"  text="M00165" objCode="delClubOffer_OBJ"/>
	</div>
</div>
<div id="clubOfferListGrid"></div>
<div id="clubOfferDetilPopupContainer" class="popup_container"></div>

<script type="text/javascript">
var clubOfferList;
var clubOfferRid = null;

function getClubOfferList(){
	var ejGridOption ={
			recordDoubleClick : function(args){
				var data = args.data;
				getClubOfferDetailPop(args.data.rid);
			},serializeGridData : function(data) {
				data.rid = clubRid;
				return data;
			},rowSelected : function (args) {
				var data = args.data;
				clubOfferRid = data.rid;
        	},
			dataUrl : '<ifvm:action name="getClubOfferList"/>',
			columns : [
				 { 
					 field : 'rid', headerText : 'rid', visible : false
				}, {
					field : 'ofrNo', headerText : '<spring:message code="M00313"/>',  textAlign : 'center', customAttributes : {searchable : true}
				},{
					field : 'ofrNm', headerText : '<spring:message code="M00314"/>', textAlign : 'center', customAttributes : {searchable : true}
				},	{
					field : 'ofrTypeCdNm', headerText : '<spring:message code="L00466"/>',  textAlign : 'center', customAttributes : {index : 'ofrTypeCd'}
				},{
					field : 'bnftTypeCdNm', headerText : '<spring:message code="M02942"/>',  textAlign : 'center', customAttributes : {index : 'bnftTypeCd'}
				},{
					field : 'ofrAmt', headerText : '<spring:message code="O00026"/>',  textAlign : 'center', customAttributes : {searchable : true}, format: '{0:n0}'
				},{
					field : 'acrlCycleTypeCdNm', headerText : '<spring:message code="M00893"/>',  textAlign : 'center', customAttributes : {index : 'acrlCycleTypeCd'}
				},{
					field : 'modifyBy', headerText : '<spring:message code="L00044"/>',  textAlign : 'center'
				},{
					field : 'modifyDate', headerText : '<spring:message code="L02703"/>', textAlign : 'center'
				}],
				requestGridData : {
					sidx : 'ofrNo',
					sord : 'asc',
				},
				rowList : [10, 25, 50, 100],
				radio : true,
	};
	
	clubOfferList = $("#clubOfferListGrid").ifvsfGrid({ejGridOption : ejGridOption});
}

function getClubOfferDetailPop(rid){
	$("#clubOfferDetilPopupContainer").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl: '<ifvm:url name="clubOfferDetailPop"/>'+ '?clubOfferRid=' + rid,
		contentType: "ajax",
        title: '<spring:message code="L02708"/>',
        width: 600,
        close : 'clubOfferDetailPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	});
        }		
	});
}

function clubOfferDetailPopupClose() {
	clubOfferDetilPopupContainer._destroy();
} 

function removeClubOffer(){
	$.ifvSyncPostJSON('<ifvm:action name="removeClubOffer"/>',{
		rid : clubOfferRid
	},function(result){
		alert('<spring:message code="M00590"/>');
		clubOfferList._doAjax();
	});
}

$(document).ready(function(){
	
	getClubOfferList();
	
	$("#addClubOffer").click(function(){
		if(clubRid == 'undefined' || clubRid == null){
			alert('<spring:message code="C00171"/>');
		}else{
			clubOfferRid = null;
			getClubOfferDetailPop();
		}
	});
	
	$("#delClubOffer").click(function(){
		if(clubOfferRid == null){
			alert('<spring:message code="C00113"/>');
		}else{
			removeClubOffer();
		}
	});
});
</script>