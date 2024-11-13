<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="chnlListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnChnlSave" objCode="offerLoyChnlSave_OBJ">
		<spring:message code="O00058" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnChnlCancel" objCode="offerLoyChnlCancel_OBJ">
		<spring:message code="O00059" />
	</button>
</div>

<script type="text/javascript">
	
	var chnlListGrid = null;
	var chnlRid = null;
	var chnlNm = null;
	var chnlNo = null;
	
	function programListSetting(){
		var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				chnlRid = data.rid;
				chnlNm  = data.chnlNm;
				chnlNo  = data.chnlNo;
	        },
			serializeGridData : function( data ){
				data.chnlSearch = 'Y';
				return data;
			},
	        dataUrl : '<ifvm:action name="getChnlListPage"/>',
	        columns : [
	        	{
					field : 'chnlNo', headerText : '<spring:message code="O00076"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true}
	        	},{
					field : 'chnlNm', headerText : '<spring:message code="O00077"/>', headerTextAlign : 'center', width : '190px', customAttributes : {searchable : true}
				},{
					field : 'statCdNm', headerText : '<spring:message code="O00052"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'statCd'}
				},{
					field : 'chnlTypeCdNm', headerText : '<spring:message code="O00078"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'chnlTypeCd'}
				},{
					field : 'createDate', headerText : '<spring:message code="O00079"/>', headerTextAlign : 'center', textAlign : 'center',
				},{
					field : 'createBy', headerText : '<spring:message code="O00080"/>', headerTextAlign : 'center', textAlign : 'center',
				},{
					field : 'rid', headerText : 'rid',visible : false 
				}
	        ],
	        requestGridData : {
				nd   : new Date().getTime(),
				rows : 10,
				sidx : '1',
				sord : 'desc',
				_search : false,
	        },
	        rowList : [10,25,50,100],
	        radio: true
	      };
		chnlListGrid = $("#chnlListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	};
	
	function checkReload(){
		   $.ifvSyncPostJSON('<ifvm:action name="getOfferDetail"/>', {
				rid : ifvGlobal["offerRid"]
			},function(result){
				 if(result.useChnlLimitYn=="Y"){
					$("#useChnlLimitYn").prop("checked", true); 
				}else if(result.useChnlLimitYn=="N"){
					$("#useChnlLimitYn").prop("checked", false); 
				}
			}); 
	}
	function saveOfferLoyChnl() {
		
		if(chnlListGrid.opt.gridControl.getSelectedRecords().length==0){
			alert('<spring:message code="O00066"/>');
		}else{
			var url = '<ifvm:action name="addOfferJoinChnl"/>';
			var offerRid = ifvGlobal["offerRid"];
			var varData = null;
			varData = {
					ridOfr : offerRid,
					ridChnlM : chnlRid
			};
			
			//등록처리
			$.ifvSyncPostJSON(url, varData, function(result) {
				
				if ($.fn.ifvmIsNotEmpty(result)) {
					
					alert("<spring:message code="O00069" />");
					checkReload();
					//location.reload();
					//clubAttrList._doAjax();
				}
			}, function(result) {
				if (result.message){
					alert(result.message);
						               
				}
				else
					alert("<spring:message code="O00070" />");
			});
			
			$("#popupContainer_closebutton").trigger('click');
			var offerJoinChnlGrid = new OfferJoinChnlList();
			offerJoinChnlGrid.init();
		}
	}
	
	$(document).ready(function() {
		programListSetting();
		
		var ofrGrid= ifvGlobal["offerGrid"];
		
		$("#btnChnlCancel").on('click', function(){
			$("#popupContainer_closebutton").trigger('click');
		}); 
		
		$("#btnChnlSave").click(function() {
			saveOfferLoyChnl();
		});
		
	});

</script>
