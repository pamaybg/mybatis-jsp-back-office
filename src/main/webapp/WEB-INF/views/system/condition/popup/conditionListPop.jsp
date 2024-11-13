<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
#conditionListPopView{display:none;}
</style>

<script>
var conditionListPopGrid; 
var conditionDetailPopGrid; 

var conditionListViewPopGrid;

var isNew = true;
/* var viewIsNew = true; */

/* 조건 목록 */
function conditionListPopGrid(){
	var jqGridOption = {
		onSelectRow : function (data) {
			conditionGroupName = data.groupName;
			conditionGroupCode = data.groupCode;
			conditionDetailPopGrid.requestData( { groupCode : data.groupCode} );
		},
		loadComplete : function(obj){
			//최초 popup 높이를 잡기 위해서 그리드생성 완료 후 다음 그리드 생성
			if(isNew){
				conditionDetailPopGrid();	
				isNew = false;
			}
		},
	    url:'<ifvm:action name="getDropDownList"/>',
	    colNames:['<spring:message code="M00544"/>',
	              '<spring:message code="M00545"/>'],
	    colModel:[
	        {name:'groupName',index:'group_name', resizable : false},
	        {name:'groupCode',index:'group_code', resizable : false}
	    ],
	    autowidth:true,
	    sortname: 'group_name',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete',
	    caption: '<spring:message code="M00543"/>',
	    rowList: '5'
	};
	conditionListPopGrid = $("#conditionListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

/* 조건 상세 */
function conditionDetailPopGrid(){
	var jqGridOption = {
		loadComplete : function(obj){
			//popup 높이 맞추기
			if(isNew == false){
				new ifvm.PopupHeight({
					popupDivId : 'popupContainer',
					contentsId : 'conditionListPopCon'
				});
			}
		},
	    url:'<ifvm:action name="groupDetailList"/>',
	    colNames:['<spring:message code="M00547"/>',
	              '<spring:message code="M00548"/>'],
	    colModel:[
	        {name:'codeName',index:'code_name', resizable : false},
	        {name:'markName',index:'mark_name', resizable : false}
	    ],
	    autowidth:true,
	    sortname: 'create_date',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete',
	    caption: '<spring:message code="M00546"/>',
	    rowList: '5'
	};
	conditionDetailPopGrid = $("#conditionDetailPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function conditionListViewPopGrid(){

    var ejGridOption = {
    	rowSelected : function(args) {
    		conditionViewCode = args.data.tblEngNm;
	    	},
    	
        dataUrl : '<ifvm:action name="getBaseTableList"/>',

        columns : [
        	{
      		  field : 'tblEngNm', headerText : '<spring:message code="M00519"/>', customAttributes : {searchable : true}
      	  },{
    		  field : 'tblKorNm', headerText : '<spring:message code="M00535"/>',  customAttributes : { searchable : true}
    	  }
      	,{
      		field : 'id', headerText : 'id', visible : false
  	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '2,1',
      	  sord : 'ASC',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    conditionListViewPopGrid = $("#conditionListViewPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	conditionListPopGrid();
	
	$('#conditionPopSelectBtn').on('click', function(){
		ddlValTypeCd = 'CC';
		$("#ddlValTypeCd").val(ddlValTypeCd);
		$("#droupDownCode").val(conditionGroupCode);
		$('#dropDownCodeName').val('');
		$('#dropDownMarkName').val('');
		$("#dropDownListCodeName").hide();
		ddlVwCnCol = null;
		ddlVwMnCol = null;
		popupClose();
	});
	
	$('#conditionPopCancelBtn').on('click', function(){
		popupClose();
	});
	
	$("input:radio[id=groupCode]").click(function() {
		$("#conditionListPopView").hide();
		$("#conditionListPopCon").show();
		conditionListPopGrid();
	});
	
	$("input:radio[id=view]").click(function() {
		$("#conditionListPopCon").hide();
		$("#conditionListPopView").show();
		conditionListViewPopGrid();
	});

	$("#conditionViewPopSelectBtn").on("click", function(){
		if(conditionListViewPopGrid.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		ddlValTypeCd = 'VIEW';
    		$("#ddlValTypeCd").val(ddlValTypeCd);
    		var dataArr = conditionListViewPopGrid.opt.gridControl.getSelectedRecords();
    		$('#droupDownCode').val(dataArr[0].tblEngNm);
    		$('#dropDownCodeName').val('');
    		$('#dropDownMarkName').val('');
    		$("#dropDownListCodeName").show();
    		$("#dropDownListMarkName").show();
    		ddlVwCnCol = null;
    		ddlVwMnCol = null;

    		conditionGroupCode=dataArr[0].tblEngNm;
    		
    		popupClose();
    	}
	});
	
	$("#conditionViewPopCancelBtn").on("click", function(){
		popupClose();
	});


});
</script>
<br>

<div class="row qt_border">
            <label class="col-xs-3 control-label"><spring:message code="드롭다운 유형 선택"/></label>
            <div class="col-xs-9 control_content">
            	<label class="col-xs-3 control-label">
            	<spring:message code="공통코드"/>
            	&nbsp;
                    <ifvm:input type="radio" names="radio" values="R" checked="true" id="groupCode" />
                </label>
        		<label class="col-xs-4 control-label" >
        		<spring:message code="사용자 정의 테이블"/>&nbsp;
        		&nbsp;
                    <ifvm:input type="radio" names="radio" values="R" id="view" />
                </label>
            </div>
        </div>

<div id="conditionListPopCon">
	<div class="pop_inner_wrap">
		<div id="conditionListPopGrid" class="con_size"></div>
		<!-- <div id="conditionDetailPopGrid" class="con_size"></div> -->
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="conditionPopSelectBtn" objCode="conditionListPopSelect_OBJ">  
			<i class="glyphicon glyphicon-check"></i>        
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="conditionPopCancelBtn" objCode="conditionListPopCancel_OBJ">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>

<div id="conditionListPopView">
	<div class="pop_inner_wrap">
		<div id="conditionListViewPopGrid" class="con_size"></div>
		<div id="conditionDetailViewPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="conditionViewPopSelectBtn" objCode="conditionListPopSelect_OBJ">  
			<i class="glyphicon glyphicon-check"></i>        
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="conditionViewPopCancelBtn" objCode="conditionListPopCancel_OBJ">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>