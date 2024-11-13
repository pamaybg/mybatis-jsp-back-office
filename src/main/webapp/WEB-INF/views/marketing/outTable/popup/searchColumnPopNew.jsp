<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var columnList;
var selectId;

function columnList(){
		var ejGridOption = {
			serializeGridData : function( data ){
				data.chnlId = selectChnlId;
			},
			rowSelected : function (args) {
				selectId = args.data.id
			}, 
			dataUrl:'<ifvm:action name="getpermissionList"/>',
		    columns:[
		    	{
		      		  field : 'colKorNm', headerText : '<spring:message code="M01146"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'COL_KOR_NM' } //
		      	  },{
		      		  field : 'colEngNm', headerText : '<spring:message code="M01147"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'COL_ENG_NM' } //
		      	  },{
		      		  field : 'colTypeCd', headerText : '<spring:message code="M01148"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'c2.mark_name' } //
		      	  },{
		      		  field : 'flagAtribVal', headerText : '<spring:message code="M01276"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'mec.FLAG_ATRIB_VAL' } //
		      	  },{
		      		  field : 'id', headerText : 'id', visible : false ,
		      		  customAttributes : {
		      			  index : 'met.id' } //
		      	  },
            ],
            requestGridData : {
          	  nd   : new Date().getTime(),
          	  rows : 10,
          	  sidx : 'met.modify_date',
          	  sord : 'desc',
          	  _search : false
            },
            rowList : [10,25,50,100],
            radio: true ,
			tempId : 'ifvGridOriginTemplete'
		};
	columnList = $("#columnGridCon").ifvsfGrid({ ejGridOption : ejGridOption });
}


//채널 관계 저장
function setChnlrel(){
	
	var obj = {};
	
	validation = $("#targetTablePopFormArea").ifvValidation();
	
	if(validation.confirm() == true){

		obj.chnlId = selectChnlId;
		obj.columnId = selectId;
		
		$.ifvSyncPostJSON('<ifvm:action name="setChnlRel"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			ChnlRelList.searchGrid( { chnlId : selectChnlId } );
		});
		selectId = null;
		adminTargetingPopClose();
	}
	
}

$(document).ready(function() {
	columnList();
	$("#btnColSave").on('click', function(){
		if(selectId != null) setChnlrel()
		else alert('<spring:message code="M00499"/>')
	    	
	});
	
	$("#btnColcan").on('click', function(){
		adminTargetingPopClose();
	});
});
</script>

<div class="pop_inner_wrap">
	<div id="columnGridCon" class="grid_bd0 grid_w660"></div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnColSave" objCode="searchColumnPopNewSave_OBJ">     
		<i class="glyphicon glyphicon-check" ></i>    
		<spring:message code="M00282"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnColcan" objCode="searchColumnPopNewCancel_OBJ">         
		<spring:message code="M00284"/>
    </button> 
</div>
