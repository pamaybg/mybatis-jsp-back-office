<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="brandListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnSelect" objCode="brandPopbtnSelect_OBJ">
		<i class="glyphicon glyphicon-check" ></i>
		<spring:message code="M00282"/>
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="brandPopbtnCancel">
		<spring:message code="M00284"/>
	</button>
</div>

<script type="text/javascript">
	var brandPopList = null;
	var brdId;
	var brdNm;

	function brandListSetting(){
		var ejGridOption = {
			recordDoubleClick : function(args){
				$('#brdId').val(brdId);
				$('#brdNm').val(brdNm);
				$('#brdRid').val(brdRid);
				$.fn.ifvmPopupClose();
			},
			rowSelected : function (args) {
				var data = args.data;
				brdRid = data.rid;
				brdId  = data.brdId;
				brdNm  = data.brdNm;
			},
			serializeGridData : function( data ){

				return data;
			},
			dataUrl: '<ifvm:action name="getBrandList"/>',
			columns: [
				{
					field: 'brdId', headerText: '<spring:message code="M01957"/>', textAlign: 'center', customAttributes: {searchable: true}
				}, {
					field: 'brdNm', headerText: '<spring:message code="L00290"/>', textAlign: 'center', customAttributes: {searchable: true}
				}, {
					field: 'brdDescTxt', headerText: '<spring:message code="L00219"/>', textAlign: 'left'
				},{
					field: 'rid', headerText: 'rid', visible: false
				}, {
					field: 'pgmRid', headerText: 'pgmRid', visible: false
				}
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
		brandPopList = $("#brandListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	};


	$(document).ready(function() {
		brandListSetting();

		$("#btnSelect").on('click', function(){
			if(brandPopList.opt.gridControl.getSelectedRecords().length==0){
				alert('<spring:message code="M00285"/>');
			}else {
				$('#brdId').val(brdId);
				$('#brdNm').val(brdNm);
				$('#brdRid').val(brdRid);
				$.fn.ifvmPopupClose();
			}
		});

		$("#btnCancel").on('click', function(){
			$.fn.ifvmPopupClose();
		});
	});

</script>