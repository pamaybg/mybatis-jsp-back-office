<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var chnlListPopGrid;
var dataId = "";

function chnlListPopGrid(){
	var jqGridOption = {
		onSelectRow : function (data) {
			dataId = "";
			dataId = data.rid;
		},
	    url:'<ifvm:action name="getChnlList"/>',
	    colNames:[
                  '<spring:message code="L00128"/>',
                  '<spring:message code="L00129"/>',
                  '<spring:message code="L00132"/>',
                  '<spring:message code="L00133"/>',
                  '<spring:message code="L00336"/>',
                  '<spring:message code="L00130"/>',
                  '<spring:message code="L00410"/>',
                  '<spring:message code="L00131"/>',
                  '<spring:message code="L00090"/>',
                  'rid'
                ],
	    colModel:[
	              { name:'chnlNo', 			index:'a.chnl_no', 			width:'80px', 		align: 'center', 	resizable : false },
	              { name:'chnlNm', 			index:'a.chnl_nm', 			width:'150px', 		align: 'left', 	    resizable : true  },
	              { name:'chnlTypeNm', 		index:'e.mark_name', 		width:'100px', 		align: 'left', 		resizable : true  },
	              { name:'chnlTypeSubNm', 	index:'f.mark_name', 	    width:'100px', 		align: 'left', 		resizable : true  },
	              { name:'parChnlNo', 		index:'c.chnl_no', 		    width:'80px', 		align: 'center', 	resizable : true  },
	              { name:'parChnlNm',     	index:'c.chnl_nm',          width:'150px', 		align: 'left', 		resizable : true  },
	              { name:'topChnlNo', 		index:'d.chnl_no', 		    width:'100px', 		align: 'center', 	resizable : true  },
	              { name:'topChnlNm',     	index:'d.chnl_nm',          width:'150px', 		align: 'left', 		resizable : true  },
	              { name:'chnlStatNm',    	index:'g.mark_name',        width:'80px', 		align: 'center', 	resizable : false },
	              { name:'rid', 			index:'a.rid', 				hidden : true }
	          ],
	          sortname: 'a.rid',
	          sortorder: "desc",
	          radio: true,
	          tempId : 'ifvGridOriginTemplete'
        };
	chnlListPopGrid = $("#chnlListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function() {
    chnlListPopGrid();

    // 저장 클릭시
    $('#chnlListPopSaveBtn').on('click', function() {
        if (chnlListPopGrid.getCheckedGridData() == '') {
            alert('<spring:message code="M00285"/>');
        }
        else {
        	if(offerid != null && offerid != "" && offerid != "null"){
        		$.ifvSyncPostJSON('<ifvm:action name="insertOfferChnl"/>',{
            		rid : dataId
            		, offerid : offerid
            	},function(result) {
            		if(result.message == '1'){
            			applyChannelList();
                        formNewPopClose();
            		}else if(result.message == '2'){
            			alert('<spring:message code="M02250"/>');
            		}else{
            			alert('<spring:message code="M02248"/>');
            		}
            	});
        	}else{
        		alert('<spring:message code="M02249"/>');
        	}
        }
    });

    // 취소 클릭시
    $('#chnlListPopCancelBtn').on('click', function() {
    	formNewPopClose();
    });
});

</script>

<div id="chnlListPopCon">
	<div class="pop_inner_wrap">
		<div id="chnlListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="chnlListPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button>
	    <button class="btn btn-sm btn_lightGray2" id="chnlListPopCancelBtn">
	        <spring:message code="M00284"/>
	    </button>
	</div>
</div>