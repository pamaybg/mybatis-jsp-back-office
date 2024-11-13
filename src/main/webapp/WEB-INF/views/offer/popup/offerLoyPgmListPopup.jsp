<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="programListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnPgmSave" objCode="offerLoyPgmListSave_OBJ">
		<spring:message code="O00058" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnPgmCancel" objCode="offerLoyPgmListCancel_OBJ">
		<spring:message code="O00059" />
	</button>
</div>

<script type="text/javascript">
	var isNew;
	var loyProgramList = null;
	var pgmRid = null;
	var pgmNm = null;
	var pgmNo = null;
	
	function programListSetting(){
		var ejGridOption = {
			rowSelected : function (args) {
				var data = args.data;
				pgmRid = data.rid;
				pgmNm  = data.pgmNm;
				pgmNo  = data.pgmNo;
	        },
			serializeGridData : function( data ){
				
				return data;
			},
	        dataUrl : '<ifvm:action name="getLoyPgmListNew"/>',
	        columns:[
	        	{
	        		field : 'pgmNo', headerText : '프로그램 번호', textAlign : 'center', width : '60px',  customAttributes :{searchable : true}
	        	},{
	          		field : 'pgmNm', headerText : '프로그램명', width : '150px', customAttributes :{searchable : true}
	          	},{
	          		field : 'rid', headerText : 'rid',visible : false 
	          	},
	        ],
	        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : '3',
	      	  sord : 'ASC',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
	      };
		loyProgramList = $("#programListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	};
	
	
	function saveOfferLoyPgm() {
		if (ofrJoinPgmRid === null)
			isNew = true;
		else
			isNew = false;
		
		if(loyProgramList.opt.gridControl.getSelectedRecords().length==0){
			alert('<spring:message code="O00066"/>');
		} else {
			var url = isNew? '<ifvm:action name="addOfferJoinPgm"/>' : '<ifvm:action name="modifyOfferJoinPgm"/>';
			var offerRid = ifvGlobal["offerRid"];
			var varData = null;
			varData = {
					rid : ofrJoinPgmRid,
					ridOfr : offerRid,
					ridPgm : pgmRid
			};
			
			//등록처리
			$.ifvSyncPostJSON(url, varData, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="O00069" />");
				}
			}, function(result) {
				if (result.message)
					alert(result.message);
				else
					alert("<spring:message code="O00070" />");
			});
			
			$.fn.ifvmPopupClose();
			var offerJoinPgmGrid = new OfferJoinPgmList();
			offerJoinPgmGrid.init();
		}
	}
	
	$(document).ready(function() {
		programListSetting();
	
		$("#btnPgmCancel").on('click', function(){
			$.fn.ifvmPopupClose();
		}); 
		
		$("#btnPgmSave").click(function() {
			saveOfferLoyPgm();
		});
		
	});

</script>
