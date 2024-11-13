<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="itemCodeListGrid" class="white_bg grid_bd0"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="selectItemBtn" objCode="searchItemCodeSelect_OBJ">
		<spring:message code="M00131" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="closeItemPopBtn" objCode="searchItemCodeClose_OBJ">
		<spring:message code="M01322" />
	</button>
</div>

<script type="text/javascript">
var fieldRid = null;
var itemCodeList;
var code ="", mark="";

//클럽목록 조회 리스트
function itemCodeListSearch() {
	
	var ejGridOption = {
		serializeGridData : function(data) {
			data.groupCode = "LOY_CUST_ITEM_TYPE_CD";
			return data;
		},
		rowSelected : function (args) {
			fieldRid = args.data.codeId;
			code = args.data.codeName;
			mark = args.data.markName;
        },
        recordDoubleClick : function (args) {
			$("#columnNm").val(args.data.codeName);
			$("#fieldDesc").val(args.data.markName);
        	$.fn.ifvmPopupClose();
		},
        dataUrl : '<ifvm:action name="getItemCodeList"/>',
		columns : [
			 {
				field : 'seq', headerText : '<spring:message code="L02560"/>',  textAlign : 'center', customAttributes :{searchable : false}
			 },{
				field : 'codeName', headerText : '코드명',  textAlign : 'center', customAttributes :{searchable : false}
			}, {
				field : 'markName', headerText : '이름',  textAlign : 'center', customAttributes :{searchable : true}
			},{
				field : 'type', headerText : '<spring:message code="L00155"/>',  textAlign : 'center', customAttributes :{index : 'type'}
			}, {
				field : 'codeId', headerText : 'id', visible : false,
			} ],
		 requestGridData : {
			rows : 10,
			sidx : 'seq',
			sord : 'asc'
		},
		rowList : [10],
		radio : true
	};

	itemCodeList = $("#itemCodeListGrid").ifvsfGrid({ejGridOption: ejGridOption});
}



$(document).ready(function(){
	
	itemCodeListSearch();
	
	$("#selectItemBtn").click(function(){
		if(fieldRid == null){
			alert('<spring:message code="M00499"/>')
		}else{
			$("#columnNm").val(code);
			$("#fieldDesc").val(mark);
        	$.fn.ifvmPopupClose();
		}
	});
	
	$("#closeItemPopBtn").click(function(){
    	$.fn.ifvmPopupClose();
	});
	
});

</script>