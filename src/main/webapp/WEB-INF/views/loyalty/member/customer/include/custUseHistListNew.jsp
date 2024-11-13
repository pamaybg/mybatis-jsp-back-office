<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
	<div class="col-xs-3">
		<span><spring:message code="채널이용내역" /></span>
	</div>
	<div class="col-xs-9 searchbtn_r">
		<ifvm:inputNew type="button" btnFunc="custSrvHistPopup" text="상세" objCode="custUseHistDetail_OBJ"/>
	</div>
</div>
<div id="custSvrHistListGrid" class="white_bg grid_bd0"></div>
<div id="popupContainer" class="popup_container"></div>


<script type="text/javascript">
function getCustSvrHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = custRid;
			return data;
		},
		rowSelected : function(args) {
			
		},
        dataUrl : '<ifvm:action name="getCustSvrHistList"/>',

        columns : [
        	{
      		  field : 'svrTypeCdNm', headerText : '서비스항목', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'svrTypeCd'}
      	  },{
    		  field : 'chnlNo', headerText : '채널코드', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
			  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
    		  field : 'chnlTypeCdNm', headerText : '채널 유형', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'chnlTypeCd'}
    	  },{
    		  field : 'svrDt', headerText : '최종 서비스 이용일', headerTextAlign : 'center', textAlign : 'center', 
    	  },{
    		  field : 'rid', headerText : 'rid', visible : false
    	  }
        ],

        requestGridData : {
      	  sidx : '4',
      	  sord : 'desc',

        },
        gridDataInit: true,
        radio: true
    };

    custSvrHistListGrid = $("#custSvrHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function custSrvHistPopup(){
	
	var checkedList = custSvrHistListGrid.opt.gridControl.getSelectedRecords();
	var url = null;
	if (checkedList.length == 0) {
		alert('<spring:message code="I02051"/>');
	} else {
		var svrType = custSvrHistListGrid.opt.gridControl.getSelectedRecords()[0].svrTypeCd;
        if(svrType  == "WEB"){
            var searchCond = { custRid: custRid };
            $.fn.ifvmSearchHelpOpen(null, searchCond, 'popupContainer', '<ifvm:url name="custWebHistListPop"/>', '<spring:message code="Web 이용내역"/>','1000');
        }else{
            alert("웹이용만 볼 수 있습니다.");
        }
    }
}


$(document).ready(function(){
	getCustSvrHistList();

});

</script>