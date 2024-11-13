<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="dupCustBtn" objCode="">
			<spring:message code="L02754" />
		</button>
		<button class="btn btn-sm" id="showDetailBtn" objCode="">
			<spring:message code="M00169" />
		</button>
	</div>
</div>
<div id="dupResultListGrid" class="white_bg grid_bd0"></div>

<div id="dupDetailPopContainer" class="popup_container"></div>

<script type="text/x-jsrender" id="tgtCustTemplate">
   <input type="text" style="border: hidden; text-align : center; background-color: white;" value="{{:tgtCustNm}}({{:tgtCustNo}})" disabled="true"/>
</script>
<script type="text/x-jsrender" id="similrCustTemplate">
   <input type="text" style="border: hidden; text-align : center; background-color: white;" value="{{:similrCustNm}}({{:similrCustNo}})"disabled="true"/>
</script>

<script type="text/javascript">
var dupResultRid = null;
var dupResultList;

function dupResultListSearch() {
	var ejGridOption = {
		recordDoubleClick : function(args) {
			var data = args.data;
			dupResultRid = data.rid;
			getDupResultDetailPop(dupResultRid);
		},
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(custDiRid)) {
				data.ridCustDi = custDiRid;
			}
			return data;
		},
		rowSelected : function (args) {
			dupResultRid = args.data.rid;
      },
      dataUrl : '<ifvm:action name="getCustDupRstList"/>',
	  columns : [
		 	{
				field : 'tgtCustNm', headerText : '<spring:message code="D10289"/>',  textAlign : 'center', customAttributes :{index : 'ridTgtCust'}, template: "#tgtCustTemplate" 
			}, {
				field : 'tgtCustNo', headerText : 'tgtCustNo',  visible : false
			}, {
				field : 'similrCustNm', headerText : '<spring:message code="D10290"/>',  textAlign : 'center', customAttributes :{index : 'ridSimileCust'}, template: "#similrCustTemplate"
			}, {
				field : 'similrCustNo', headerText : 'similrCustNo',  visible : false
			}, {
				field : 'score', headerText : '<spring:message code="L02278"/>', textAlign : 'center', customAttributes :{searchable : true}
			}, {
				field : 'mrgTypeCdNm', headerText : '<spring:message code="D10291"/>', textAlign : 'center', customAttributes :{index : 'mrgTypeCd'}
			}, {
				field : 'statCdNm', headerText : '<spring:message code="D10292"/>', textAlign : 'center', customAttributes :{index : 'statCd'}
			}, {
				field : 'createDate', headerText : '<spring:message code="M00222"/>',  textAlign : 'center'
			}, {
				field : 'rid', headerText : 'rid', visible : false
			} ],
		 requestGridData : {
			sidx : 'createDate',
			sord : 'asc'
		},
		rowList : [ 10, 25, 50, 100 ],
		radio : true
	};

	dupResultList = $("#dupResultListGrid").ifvsfGrid({ejGridOption: ejGridOption});
}

function getDupResultDetailPop(rid){
	$("#dupDetailPopContainer").ifvsfPopup({
		enableModal : true,
      enableResize: false,
      contentUrl: '<ifvm:url name="dupRstDetailPop"/>'+ '?dupResultRid=' + rid,
      contentType: "ajax",
      title: '<spring:message code="D10293"/>',
      width: 700,
      close : 'getDupResultPopupClose',
  	open : function(){
  		new ifvm.PopupCenter({
      		popupDivId : 'popupContainer'
      	});
      }
  });
}

function getDupResultPopupClose() {
	dupDetailPopContainer._destroy();
} 


$(document).ready(function(){
	dupResultListSearch();
	
	$("#dupCustBtn").click(function(){
		if(dupResultRid == null){
			alert('<spring:message code="L00066"/>');
		} else{
			var resultCk = confirm("<spring:message code="D10294"/>");
			if(resultCk){
			    $.ifvSyncPostJSON('<ifvm:action name="custMergePrcs"/>',{rid :dupResultRid, ridCustDi :  custDiRid},function(result){
			    	alert('<spring:message code="D10295"/>');
			    	dupResultListSearch();
			    });
			}
		}
	});
	
	$("#showDetailBtn").click(function(){
		if(dupResultRid == null){
			alert('<spring:message code="L00066"/>');
		} else{
			getDupResultDetailPop(dupResultRid);
		}
	});
	
});
</script>

