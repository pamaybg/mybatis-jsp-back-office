<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>

<div class="content_pop_wrap">
    <div id="ofrListGridDialog" class="white_bg grid_bd0"></div>
</div>
<div class="pop_btn_area">
    <button class="btn btn-sm btn_gray" id="saveOfrBtn" objCode="ofrListPopupSaveBtn_OBJ">         
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="M00282"/>
    </button> 
    <button class="btn btn-sm btn_lightGray2" id="ofrPopCloseBtn" objCode="ofrListPopuClosepBtn_OBJ">         
        <spring:message code="M00284"/>
    </button> 
</div>


<script type="text/javascript">


var ofrListGrid;
var ridOfr;
var contsId = '<%= cleanXss(request.getParameter("id")) %>';

function getOfrList(){
    var ejGridOption = {
    	serializeGridData : function(data) {

    		return data;
		},rowSelected : function(args){
			ridOfr=args.data.rid;
		},
        dataUrl : '<ifvm:action name="getCpnList"/>',
        columns : [
        	{
      		  field : 'ofrNo', headerText : '오퍼번호', headerTextAlign : 'center', textAlign : 'center',
      		  customAttributes : { searchable : true
      		  }
      	  },{
      		  field : 'ofrNm', headerText : '오퍼명', headerTextAlign : 'center', textAlign : 'center', width : '30%',
      		  customAttributes : { searchable : true
      		  }
      	  },{
                field : 'ofrValAmt', headerText : '할인액', headerTextAlign : 'center', textAlign : 'center',
                customAttributes : { searchable : true
                }
            },{
                field : 'useMinPurAmt', headerText : '최소구매금액', headerTextAlign : 'center', textAlign : 'center',
                customAttributes : { searchable : true
                }
            },{
                field : 'useMaxDcAmt', headerText : '최대할인금액', headerTextAlign : 'center', textAlign : 'center',
                customAttributes : { searchable : true
                }
            },/*{
      		  field : 'ofrSubTypeNm', headerText : '오퍼유형', headerTextAlign : 'center', textAlign : 'center'
      	  },*//* {
      		  field : 'validDate', headerText : '유효기간', headerTextAlign : 'center', textAlign : 'center',
      		  customAttributes : {
      			  index : '3'
      		  }
      	  }, */{
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
        radio: true,
    };

    ofrListGrid = $("#ofrListGridDialog").ifvsfGrid({ ejGridOption : ejGridOption });
}

function saveContsOfr(){
	var selectedData = ofrListGrid.opt.gridControl.getSelectedRecords()[0];
	$('#ofrNm').val(selectedData.ofrNm);
	$('#ridOfr').val(selectedData.rid);
	ofrListPopClose();
}


$(document).ready(function() {

	$('#ofrPopCloseBtn').on('click', function(){
    	ofrListPopClose();
    });
	
	$('#saveOfrBtn').on('click', function(){
    	saveContsOfr();
    });
	
	getOfrList();

});
</script>


