<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="addDataSetItem" text="신규" objCode="addDataSetItem_OBJ"/>
			<ifvm:inputNew type="button" id="modifyDataSetItem" text="수정" objCode="modifyDataSetItem_OBJ"/>
			<ifvm:inputNew type="button" id="removeDataSetItem" text="삭제" objCode="removeDataSetItem_OBJ"/>
        </div>
    </div>
    <div id="dataSetItemGrid" class="white_bg grid_bd0"></div>
</div>

<div id="addDataSetItemPop" class="popup_container"></div>

<script type="text/javascript">
var dataSetItemRid = null;

function getDataSetItem(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.dataSetRid = dataSet_rid;
			return data;
		},
		rowSelected : function(args){
			dataSetItemRid = args.data.rid;
       	},
        dataUrl : '<ifvm:action name="getDataSetItem"/>',

        columns : [
        	{
				field : 'fieldNm', headerText : '컬럼명', headerTextAlign : 'center', textAlign : 'left',
				customAttributes: {searchable : true }
			},{
				field : 'fieldDesc', headerText : '설명', headerTextAlign : 'center', textAlign : 'left',
				customAttributes: {searchable : true}
			},{
				field : 'name', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center',
				customAttributes: {index : 'name'}
			},{
				field : 'createDate', headerText : '등록일시', headerTextAlign : 'center', textAlign : 'center',

			},{
				field : 'rid', headerText : 'rid', headerTextAlign : 'center', textAlign : 'center', visible : false,
				customAttributes: {		index : 'rid'	}
			}
        ],

        requestGridData : {
      	  sidx : '4',
      	  sord : 'desc',
        },
        radio: true
    };

    dataSetItemGrid = $("#dataSetItemGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function addDataSetItemPopup() {
	$("#addDataSetItemPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addDataSetItemPop"/>',
        contentType: "ajax",
        title: '아이템 신규',
        width: 600,
        close : 'addDataSetItemClose'
	});
}

function addDataSetItemClose() {
	addDataSetItemPop._destroy();
}

function removeDataSetItem() {
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(dataSetItemGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = dataSetItemGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M00104"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeDataSetItem"/>', {
            rid: v_rid
        },
        function(result) {
        	dataSetItemGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

$(document).ready(function(){
	getDataSetItem();
	
	$("#addDataSetItem").click(function() {
		dataSetItemRid = null;

        if(dataSet_rid == null || dataSet_rid === ""){
            alert('데이터셋을 저장해주세요.')
        } else{
            addDataSetItemPopup();
        }

	});
	
	$("#modifyDataSetItem").click(function() {
		if ($.fn.ifvmIsEmpty(dataSetItemGrid.opt.gridControl.getSelectedRecords()[0])) {
			alert('<spring:message code="C00165"/>');
			return;
		}
		
		addDataSetItemPopup();
	});
	
	$("#removeDataSetItem").click(function() {
		removeDataSetItem();
	});

});

</script>