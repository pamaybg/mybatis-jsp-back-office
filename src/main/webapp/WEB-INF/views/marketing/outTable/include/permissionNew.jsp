<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var ChnlRelList;
var segColumnId = null;



//조회결과 그리드
function ChnlRelList(){
	var ejGridOption = {
		dataUrl:'<ifvm:action name="getoutchannelrel"/>',
	    columns:[
	    	  {
	      		  field : 'colKorNm', headerText : '<spring:message code="M01146"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'mec.COL_KOR_NM' } //
	      	  },{
	      		  field : 'colEngNm', headerText : '<spring:message code="M01147"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'mec.COL_ENG_NM' } //
	      	  },{
	      		  field : 'colTypeCd', headerText : '<spring:message code="M01148"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'mec.COL_TYPE_CD' } //
	      	  },{
	      		  field : 'flagAtribVal', headerText : '<spring:message code="M01276"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'mec.FLAG_ATRIB_VAL' } //
	      	  },{
	      		  field : 'id', headerText : 'id', visible :false ,
	      		  customAttributes : {
	      			  index : 'meccr.id' } //
	      	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'meccr.create_date',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
		tempId : 'approvalPopTemplete'
	};
	ChnlRelList = $("#ChnlRelList").ifvsfGrid({ ejGridOption : ejGridOption });
}

function columnPopInit(title){
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="permissionColumnPopNew"/>',
        contentType: "ajax",
        title: title,
        width: 720,
        close : 'adminTargetingPopClose'
    });
}

//column list 삭제
function deleteColumnOptionList() {
	var active = 0;
		var checkedList = ChnlRelList.opt.gridControl.getSelectedRecords();
		
		var listFlowIdList = [];
		if(checkedList.length != 0){
			if(confirm('<spring:message code="M00296"/>')){
				for( var i = 0; i < checkedList.length; i++ ){
					listFlowIdList.push( checkedList[i].id );
				}
				$.ifvSyncPostJSON('<ifvm:action name="removeChnlRel"/>',{
					chnlRelId : listFlowIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
// 					ChnlRelList.delCheckedRow();
					ChnlRelList.searchGrid({ chnlId : selectChnlId } );
				});	
			}
		}
		else{
			alert('<spring:message code="M00285"/>');
		}
	
}





$(document).ready(function(){
	ChnlRelList();
	$("#addChnlRelList").on("click", function(){
		if(selectChnlId != null){
			columnPopInit('<spring:message code="M01150" />');
		}
		else{
			alert('<spring:message code="M00004" />');
		}
	});

	$("#delChnlRelList").on("click", function(){
		deleteColumnOptionList();
	});
});

</script>
	
<script id="approvalPopTemplete" type="text/ifvGrid-tmpl">
<div class="ifv_grid_templete">
	{title}
	<div class="grid_con">
		{grid}
	</div>
	<div class="page">
		<div class="total_area">{total}</div>	
	<div>
</div>
</script>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01285"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addChnlRelList" objCode="permissionNewChnlRelAdd_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button> 
		<button class="btn btn-sm" id="delChnlRelList" objCode="permissionNewChnlRelDel_OBJ">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="ChnlRelList" class="grid_bd0 grid_scroll10"></div>
