<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="content_pop_wrap">
    <div id="promListGridDialog" class="white_bg grid_bd0"></div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="savePromBtn" objCode="kprPromListSave_OBJ">         
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="M00282"/>
    </button> 
    <button class="btn btn-sm btn_lightGray2" id="promPopCloseBtn" objCode="kprPromListClose_OBJ">         
        <spring:message code="M00284"/>
    </button> 
</div>


<script type="text/javascript">


var promListGrid;
var chnlCd = null;
<%-- var contsId = '<%= request.getParameter("id") %>'; --%>

function getPromList(){
    var ejGridOption = {
    	serializeGridData : function(data) {
			//data.chnlCd = $('#chnlCd').val();
    		return data;
		},rowSelected : function(args){
			rid=args.data.rid;
		},
        dataUrl : '<ifvm:action name="getKprPromList"/>',
        columns : [
        	{
      		  field : 'promCd', headerText : '프로모션코드', headerTextAlign : 'center', textAlign : 'center',
      		  customAttributes : {
      			  index : '1'
      		  }
      	  },{
      		  field : 'promNm', headerText : '프로모션명', headerTextAlign : 'center', textAlign : 'center',
      		  customAttributes : { searchable : true,
      			  index : 'chnlNm'
      		  }
      	  },{
      		  field : 'ridProm', headerText : 'ridProm', headerTextAlign : '' ,visible: false,
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

    promListGrid = $("#promListGridDialog").ifvsfGrid({ ejGridOption : ejGridOption });
}

function saveProm(){
	var selectedData = promListGrid.opt.gridControl.getSelectedRecords()[0];
	$('#promNm').val(selectedData.promNm);
	$('#ridProm').val(selectedData.ridProm);
	promListPopClose();
}


$(document).ready(function() {
	
	getPromList();
	
	$('#promPopCloseBtn').on('click', function(){
    	promListPopClose();
    });
	
	$('#savePromBtn').on('click', function(){
    	saveProm();
    });
	


});
</script>


