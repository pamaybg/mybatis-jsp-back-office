<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="content_pop_wrap">
    <div id="camListGridDialog" class="white_bg grid_bd0"></div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="saveCamBtn" objCode="kprCamListPopSave_OBJ">         
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="M00282"/>
    </button> 
    <button class="btn btn-sm btn_lightGray2" id="chnlPopCloseBtn" objCode="kprCamListPopClose_OBJ">         
        <spring:message code="M00284"/>
    </button> 
</div>


<script type="text/javascript">


var camListGrid;
var chnlCd = null;
<%-- var contsId = '<%= request.getParameter("id") %>'; --%>

function getCamList(){
    var ejGridOption = {
    	serializeGridData : function(data) {
    		return data;
		},rowSelected : function(args){
			rid=args.data.rid;
		},
        dataUrl : '<ifvm:action name="getKprCamlList"/>',
        columns : [
        	{
      		  field : 'camNo', headerText : '캠페인번호', headerTextAlign : 'center', textAlign : 'center',
      		  customAttributes : {
      			  index : '1'
      		  }
      	  },{
      		  field : 'camNm', headerText : '캠페인명', headerTextAlign : 'center', textAlign : 'center',
      		  customAttributes : { searchable : true,
      			  index : 'camNm'
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

    camListGrid = $("#camListGridDialog").ifvsfGrid({ ejGridOption : ejGridOption });
}

function saveCam(){
	var selectedData = camListGrid.opt.gridControl.getSelectedRecords()[0];
	$('#camNm').val(selectedData.camNm);
	$('#rid').val(selectedData.rid);
	camListPopClose();
}


$(document).ready(function() {
	
	getCamList();
	
	$('#chnlPopCloseBtn').on('click', function(){
    	camListPopClose();
    });
	
	$('#saveCamBtn').on('click', function(){
    	saveCam();
    });
	


});
</script>


