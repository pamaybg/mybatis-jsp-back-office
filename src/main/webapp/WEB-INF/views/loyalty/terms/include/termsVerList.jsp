<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02325" /></span> <a><i
			class="helpBtn" style="vertical-align: middle;">
				<div class="helptxt" style="display: none;">
					<spring:message code="D10282" />
				</div>
		</i></a>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" id="addNewVersion" text="V00002" objCode="termsVerListAddNewVersion_OBJ" />
		<ifvm:inputNew type="button" btnType="minus" id="delVersion" text="C00163" objCode="termsVerListDelVersion_OBJ" />
		<ifvm:inputNew type="button" id="verDetail" text="I00195" objCode="termsVerListVerDetail_OBJ" />
	</div>
</div>
<div id="termsVerListGrid"></div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="D10090" /></span> <a><i
			class="helpBtn" style="vertical-align: middle;">
				<div class="helptxt" style="display: none;">
					<spring:message code="D10284" />
				</div>
		</i></a>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" id="addLoyPgm" text="V00002" objCode="termsVerListAddLoyPgm_OBJ" />
		<ifvm:inputNew type="button" btnType="minus" id="delLoyPgm" text="C00163" objCode="termsVerListDelLoyPgm_OBJ" />
	</div>
</div>
<div id="loyaltyProgramListGrid"></div>
<div id="termsLoyPgmPopupContainer" class="popup_container"></div>
<div id="termsVersionPopupContainer" class="popup_container"></div>

<style>
.helpBtn {
	background-image: url("/resources/images/icons/btn_help.png");
	background-repeat: no-repeat;
	background-position: center center;
	padding-left: 30px;
	vertical-align: middle;
	width: 17px;
	height: 17px;
	line-height: 17px;
}
</style>

<script type="text/javascript">
var termsVerList;
var parRid = $.ifvGetParam('rid');
var verRid = null;
var loyaltyProgramList;
var pgmRid = null;


function getTermsVerList() {
	var ejGridOption = {
/* 		recordDoubleClick : function(args) {
			var data = args.data;
			verRid = data.verRid;
			getVersionPop(verRid);
		}, */
		serializeGridData : function(data) {
			data.rid = parRid;
			return data;
		}, rowSelected : function (args) {
			 verRid = args.data.verRid;
			 getLoyaltyProgramList(verRid);
        },
        loadComplete : function(obj){
            termsVerList.opt.gridControl.selectRows(0);
        },
		dataUrl : '<ifvm:action name="getTermsVerList"/>',
		columns : [
		{
			field : 'ver', headerText : '<spring:message code="L02685"/>', textAlign : 'center', format : '{0:n1}'
		}, {
			field : 'requiredYn', headerText : '<spring:message code="Q00029"/>', textAlign : 'center'
		}, {
			field : 'startDate', headerText : '<spring:message code="M00329"/>', textAlign : 'center'
		},{
			field : 'createBy', headerText : '<spring:message code="M00303"/>', textAlign : 'center'
		},{
			field : 'createDate', headerText : '<spring:message code="M00222"/>', textAlign : 'center'
		}, {
			field : 'verRid', headerText : 'verRid', visible : false
		} ],
		requestGridData : {
			nd : new Date().getTime(),
			rows : 10,
			sidx : '1',
			sord : 'desc',
			_search : false
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true,
		tempId : 'ifvGridNotSearchTemplete'
	};

	termsVerList = $("#termsVerListGrid").ifvsfGrid({ejGridOption : ejGridOption});
	
}

function getVersionPop(verRid){
	$("#termsVersionPopupContainer").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="termsVersionPop"/>'+ '?verRid=' + verRid,
        contentType: "ajax",
        title: '<spring:message code="L02321"/>',
        width: 1000,
        close : 'termsVersionPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	})
        }
    });
}

function termsVersionPopupClose() {
	termsVersionPopupContainer._destroy();
} 

function removeVersion(){
	
	$.ifvSyncPostJSON('<ifvm:action name="removeTermsVersion"/>',{
		parRid : parRid,
		rid : verRid
	},
	function(result) {
		alert('<spring:message code="M00003"/>');
		termsVerList._doAjax();
	});
}

//로열티 프로그램
function getLoyaltyProgramList(verRid){
	var ejGridOption ={
			recordDoubleClick : function(args){
				var data = args.data;
				pgmRid = data.rid;
				getLoyPgmPop(pgmRid);
			}, serializeGridData : function(data) {
				data.rid = verRid;
				return data;
			},rowSelected : function (args) {
				var data = args.data;
				pgmRid = data.rid;
        },
        loadComplete : function(obj){
            loyaltyProgramList.opt.gridControl.selectRows(0);
        },
			dataUrl : '<ifvm:action name="getTermsLoyPgmList"/>',
			columns : [
				 {
					field : 'pgmNo', headerText : '<spring:message code="D10271"/>',  textAlign : 'center', customAttributes :{searchable : true}
				},	{
					field : 'pgmNm', headerText : '<spring:message code="L00037"/>',  textAlign : 'center', customAttributes :{searchable : true}
				},	{
					field : 'useYn', headerText : '<spring:message code="L01681"/>',  textAlign : 'center', customAttributes : { index : 'useYnCd'}
				},{
					field : 'createBy', headerText : '<spring:message code="M00303"/>',  textAlign : 'center'
				},{
					field : 'createDate', headerText : '<spring:message code="M00222"/>',  textAlign : 'center'
				},{
					field : 'modifyBy', headerText : '<spring:message code="L01604"/>',  textAlign : 'center'
				},{
					field : 'modifyDate', headerText : '<spring:message code="L02703"/>',  textAlign : 'center'
				},{ 
					 field : 'rid', headerText : 'rid', visible : false
				}],
				requestGridData : {
					nd : new Date().getTime(),
					rows : 10,
					sidx : '4',
					sord : 'desc',
					_search : false
				},
				rowList : [10, 25, 50, 100],
				radio : true,
	};
	
	loyaltyProgramList = $("#loyaltyProgramListGrid").ifvsfGrid({ejGridOption : ejGridOption});
}

function getLoyPgmPop(pgmRid){
	$("#termsLoyPgmPopupContainer").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="termsLoyPgmPop"/>'+ '?pgmRid=' + pgmRid, 
        contentType: "ajax",
        title: '<spring:message code="D10090"/>',
        width: 900,
        close : 'termsLoyPgmPopupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'popupContainer'
        	})
        }
    });
}

function termsLoyPgmPopupClose() {
	termsLoyPgmPopupContainer._destroy();
}

function removeLoyPgm(){
	
	$.ifvSyncPostJSON('<ifvm:action name="removeTermsLoyPgm"/>',{
		verRid : verRid,
		rid : pgmRid,
	},
	function(result) {
		alert('<spring:message code="M00003"/>');
		loyaltyProgramList._doAjax();
	});
}

$(document).ready(function(){
	getTermsVerList();
	getLoyaltyProgramList();
	
 	//신규
	$('#addNewVersion').on('click', function(){
		verRid = null;
		if(parRid == null){
			alert('<spring:message code="C00171"/>');
		}else{
			getVersionPop();
		}
	}); 
 	
 	//삭제
 	$("#delVersion").on('click', function() {
 	    if (confirm('<spring:message code="M01053"/>')) {

	 		if(verRid == null){
	 			alert('<spring:message code="C00113"/>');
	 		}else{
				if(realStatCd == 'W'){
					removeVersion();
				}else{
					alert('<spring:message code="M02941"/>');
				}
	 		}
 	    }
	}); 
 	
 	//버전 상세
 	$("#verDetail").on('click', function() {
 		if(verRid == null){
 			alert('<spring:message code="C00172"/>');
 		}else{
 			getVersionPop(verRid);
 		}
	}); 
 	
 	//프로그램 신규
	$("#addLoyPgm").click(function(){
		pgmRid = null;
		if(verRid == null){
			alert('<spring:message code="C00172"/>');
		}else{
			getLoyPgmPop();
		}
	});
 	
 	//프로그램 삭제
	$("#delLoyPgm").click(function(){
	       if (confirm('<spring:message code="M01053"/>')) {

				if(verRid == null){
					alert('<spring:message code="C00172"/>');
				}else{
					if(pgmRid == null){
						alert('<spring:message code="C00173"/>');
					}else{
						if(realStatCd == 'W'){
							removeLoyPgm();
						}else{
							alert('<spring:message code="M02941"/>');
						}
					}
				}
	       }
	});
 	
 	

	$('.helpBtn').setupHelpMessage();
});

</script>