<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="D10262"/></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
        <ifvm:inputNew type="button" id="addClubAttr"  text="M00163" objCode="addClubAttr_OBJ"/>
        <ifvm:inputNew type="button" id="delClubAttr"  text="M00165" objCode="delClubAttr_OBJ"/>
	</div>
</div>
<div id="clubAttrListGrid"></div>
<div id="clubDetailPopupContainer" class="popup_container"></div>

<script type="text/javascript">
var clubAttrList;
var clubAttrRid = null;

function getClubAttrList(){
	var ejGridOption ={
			recordDoubleClick : function(args){
				var data = args.data;
				getClubAttrDetailPop(args.data.rid);
			},serializeGridData : function(data) {
				data.rid = clubRid;
				return data;
			},rowSelected : function (args) {
				var data = args.data;
				clubAttrRid = data.rid;
        	},
			dataUrl : '<ifvm:action name="getClubAttrList"/>',
			columns : [
				 { 
					 field : 'rid', headerText : 'rid', visible : false
				}, {
					field : 'fieldTypeCdNm', headerText : '<spring:message code="L02702"/>', textAlign : 'center', customAttributes : {index : "fieldTypeCd"}
				},{
					field : 'codeNm', headerText : '<spring:message code="Q02900"/>', textAlign : 'center', customAttributes : {index : "code"}
				},	{
					field : 'val', headerText : '<spring:message code="D10249"/>', textAlign : 'center', customAttributes : {searchable : true}
				},	{
					field : 'modifyBy', headerText : '<spring:message code="L00044"/>', textAlign : 'center'
				}, {
					field : 'modifyDate', headerText : '<spring:message code="L02703"/>', textAlign : 'center'
				}],
				requestGridData : {
					sidx : '6',
				},
				rowList : [10, 25, 50, 100],
				radio : true,
	};
	
	clubAttrList = $("#clubAttrListGrid").ifvsfGrid({ejGridOption : ejGridOption});
}


function getClubAttrDetailPop(clubAttrRid){
	$("#clubDetailPopupContainer").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="clubAttrDetailPop"/>'+ '?clubAttrRid=' + clubAttrRid,
        contentType: "ajax",
        title: '<spring:message code="D10262"/>',
        width: 900,
        close : 'clubAttrDetailPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	});
        }
    });
}

function clubAttrDetailPopupClose() {
	clubDetailPopupContainer._destroy();
} 

function removeClubAttr(){
	$.ifvSyncPostJSON('<ifvm:action name="removeClubAttr"/>',{
		rid : clubAttrRid
	},function(result){
		alert('<spring:message code="M00003"/>');
		clubAttrList._doAjax();
	});
}

$(document).ready(function(){

	
	getClubAttrList();
	
	$("#addClubAttr").click(function(){
		if(clubRid == 'undefined' || clubRid == null){
			alert('<spring:message code="C00171"/>');
			//$("#addClubAttr").attr("disabled",true);
			//$("#delClubAttr").attr("disabled",true);
		}else{
			clubAttrRid = null;
			getClubAttrDetailPop();
		}
	});
	
	$("#delClubAttr").click(function(){
		if(clubAttrRid == null){
			alert('<spring:message code="C00113"/>');
		}else{
			removeClubAttr();
		}
	});
	
});
</script>