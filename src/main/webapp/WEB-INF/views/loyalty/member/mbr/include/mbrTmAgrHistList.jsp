<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        	<span><spring:message code="L01258" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnFunc="addTmAgeHistPopup.pop" text="L00078" btnType="plus"   className="dropHidBtn"/>
        </div>
        <script>
        addTmAgeHistPopup = {
        		id  : "mbrTmAgrPop",
        		url : '<ifvm:url name="addTmAgrPop"/>',
        		pop : function(obj){
        			this.url = '<ifvm:url name="addTmAgrPop"/>';
        			if(obj != null){
        				this.url += '?rid='+obj.rid;
        			}
        			$("#"+this.id).ifvsfPopup({
           	            enableModal : true,
           	            enableResize : false,
           	            contentUrl : this.url,
           	            contentType : "ajax",
           	            title : '<spring:message code="L01806"/>', // 제휴 TM 동의이력,
           	            width : '900px'
           	        });
        		},
        		beforeClose : function(obj){
        			if(obj != null){
        				mbrTmAgrList.requestData();
        			}
        		},
        		close : function(obj){
        			if(obj){
        				this.beforeClose(obj)
        			}
        			var _popObj = eval(this.id)
        			_popObj._destroy();
        		}
        }
        </script>
    </div>

    <div id="mbrTmHistListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="mbrTmAgrPop" class="popup_container"></div>
<script>
gMbrTmHistList  = {
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = gMbrDetail.data.rid;
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		    	 var data = mbrTmAgrList.getRowData()[rowNo-1];
			     	console.log(data);
			     	addTmAgeHistPopup.pop(data);
		     },
		     loadComplete : function(result){

		     	if(typeof(gMbrDetail) != "undefined"){
	        		if(gMbrDetail.data.mbrStatCd == "20"){
	        			$(".dropHidBtn").prop("disabled",true);
	        		}
	        	}
		     },
		     url : '<ifvm:action name="getMbrTmAtrHistList"/>',
		     colNames:[
		               '<spring:message code="L01807"/>',
		               '<spring:message code="L01808"/>',
		               '<spring:message code="L01809"/>',
		               '<spring:message code="L01810"/>',
		               '<spring:message code="L01811"/>',
		               '<spring:message code="L01812"/>',
		               '<spring:message code="L01813"/>',
		               '<spring:message code="L01814"/>',
		               '<spring:message code="L01815"/>',
		               '<spring:message code="L01816"/>',
		               'rid'
		             ],
		    colModel:[
		        { name:'cprtType', 	    	index:'lct.cprt_type', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'cprtCmpnDiv', 		index:'lct.cprt_cmpn_div', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'tmAgreeYn', 		index:'lct.tm_agree_yn', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'tmAgreeRcpChnl', 	index:'lct.tm_agree_rcp_chnl', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'tmAgreeDd', 	    index:'lct.tm_agree_dd ', 		width:'80px', 	align: 'center', 	resizable : true ,  formatter:'date', formatoptions:{newformat:"Y-m-d"} },
		        { name:'ridCam', 	    	index:'lct.rid_cam', 			width:'80px', 	align: 'center', 	resizable : true ,  formatter:'date', formatoptions:{newformat:"Y-m-d"} },
		        { name:'memCntcDesk', 		index:'lct.mem_cntc_desk', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'chnlNo', 			index:'lct.chnl_no', 			width:'100px', 	align: 'center', 	resizable : true },
		        { name:'rmark', 			index:'lct.rmark', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'cprtCmpnTrmDt', 	index:'lct.cprt_cmpn_trm_dt', 	width:'80px', 	align: 'center', 	resizable : true ,  formatter:'date', formatoptions:{newformat:"Y-m-d"} },
		        { name:'rid', 				index:'lct.rid', 				hidden : true},
		    ],
		     sortname: 'lct.create_date',
		     autowidth : true ,
		     sortorder: "desc",
		     shrinkToFit: false
		}
}

mbrTmAgrList = $("#mbrTmHistListGrid").ifvGrid({ jqGridOption : gMbrTmHistList.jqGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>