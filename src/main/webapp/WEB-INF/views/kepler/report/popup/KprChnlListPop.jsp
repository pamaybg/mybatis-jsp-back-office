<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="content_pop_wrap">
    <div id="chnlListGridDialog" class="white_bg grid_bd0"></div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="saveChnlBtn" objCode="kprChnlListPopSave_OBJ">         
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="M00282"/>
    </button> 
    <button class="btn btn-sm btn_lightGray2" id="chnlPopCloseBtn" objCode="kprChnlListPopClose_OBJ">         
        <spring:message code="M00284"/>
    </button> 
</div>


<script type="text/javascript">


var chnlListGrid;
var chnlCd = null;
<%-- var contsId = '<%= request.getParameter("id") %>'; --%>

function getChnlList(){
    var ejGridOption = {
    	serializeGridData : function(data) {
			data.chnlTypeRid = chnl_Type_Rid;
			data.chnlSubTypeCd =chnl_SubType_Cd;
			data.chnlType = $("#chnlType").val();
			
    		return data;
		},rowSelected : function(args){
			rid=args.data.rid;
		},
        dataUrl : '<ifvm:action name="getKprChnlList"/>',
        columns : [
        	{
      		  field : 'chnlNo', headerText : '채널번호', headerTextAlign : 'center', textAlign : 'center',
      		  customAttributes : {
      			  index : '1'
      		  }
      	  },{
      		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign : 'center',
      		  customAttributes : { searchable : true,
      			  index : 'chnlNm'
      		  }
      	  },{
      		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
      		  customAttributes : {
      			  index : ''
      		  }
      	  } 
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'create_date',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        tempId: 'ifvGridOriginTemplete4',
        radio: true,
    };

    chnlListGrid = $("#chnlListGridDialog").ifvsfGrid({ ejGridOption : ejGridOption });
}

function saveChnl(){
	var selectedData = chnlListGrid.opt.gridControl.getSelectedRecords()[0];
	$('#chnlNm').val(selectedData.chnlNm);
	$('#rid').val(selectedData.rid);
	chnlListPopClose();
}


$(document).ready(function() {
	
	getChnlList();
	
	$('#chnlPopCloseBtn').on('click', function(){
    	chnlListPopClose();
    });
	
	$('#saveChnlBtn').on('click', function(){
    	saveChnl();
    });
	


});
</script>


