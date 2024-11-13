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
        	<ifvm:inputNew type="button" btnFunc="addMbrCarHistPopup.pop" text="L00078" btnType="plus"    className="dropHidBtn" />
        </div>
        <script>
        addMbrCarHistPopup = {
        		id  : "mbrCarHistPop",
        		url : '<ifvm:url name="addCarHistPop"/>',
        		pop : function(obj){
        			this.url = '<ifvm:url name="addCarHistPop"/>';
        			if(obj != null){
        				this.url += '?rid='+obj.rid;
        			}
        			$("#"+this.id).ifvsfPopup({
           	            enableModal : true,
           	            enableResize : false,
           	            contentUrl : this.url,
           	            contentType : "ajax",
           	            title : '<spring:message code="L01079"/>', // 차량이력,
           	            width : '900px'
           	        });
        		},
        		beforeClose : function(obj){
        			if(obj != null){
        				mbrCarHist.requestData();
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

    <div id="mbrCarHistListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="mbrCarHistPop" class="popup_container"></div>
<script>
gMbrCarHist  = {
		checkedData : null,
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = gMbrDetail.data.rid;
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     	var data = mbrCarHist.getRowData()[rowNo-1];
		     	gMbrCarHist.checkedData = data;
		     	addMbrCarHistPopup.pop(data);
		     },
		     loadComplete : function(result){

		     	if(typeof(gMbrDetail) != "undefined"){
	        		if(gMbrDetail.data.mbrStatCd == "20"){
	        			$(".dropHidBtn").prop("disabled",true);
	        		}
	        	}
		     	window.top.setParentIframeHeight();
		     },
		     url : '<ifvm:action name="getMbrCarHistList"/>',
		     colNames:[
		               '<spring:message code="L01125"/>',
		               '<spring:message code="L01080"/>',
		               '<spring:message code="L01081"/>',
		               '<spring:message code="L01082"/>',
		               '<spring:message code="L01083"/>',
		               '<spring:message code="L01084"/>',
		               '<spring:message code="L01085"/>',
		               '<spring:message code="L01086"/>',
		               '<spring:message code="L01087"/>',
		               '<spring:message code="L01088"/>',
		               '<spring:message code="L01089"/>',
		               '<spring:message code="L01090"/>',
		               '<spring:message code="L01091"/>',
		               'makr',
		               'carModel',
		               'autoYn',
						'useYn',
						'usePrps',
						'rid'

		             ],
		    colModel:[
		        { name:'regDt', 	    index:'lci.reg_dt', 	width:'120px', 	align: 'center', 	resizable : true,  formatter:'date', formatoptions:{newformat:"Y-m-d"} },
		        { name:'makrCode', 		index:'cc1.mark_name', 	width:'100px', 	align: 'center', 	resizable : true },
		        { name:'carModelCode', 	index:'cc2.mark_name', 	width:'100px', 	align: 'center', 	resizable : true },
		        { name:'carNm', 		index:'lci.car_nm', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'carNo', 	    index:'lci.car_no', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'dspmt', 		index:'lci.dspmt', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'autoYnCode', 	index:'cc3.mark_name', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'useYnCode', 	index:'cc5.mark_name', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'puDd', 			index:'lci.pu_dd', 		width:'120px', 	align: 'center', 	resizable : true ,  formatter:'date', formatoptions:{newformat:"Y-m-d"}},
		        { name:'insurDd', 	    index:'lci.insur_dd', 	width:'120px', 	align: 'center', 	resizable : true ,  formatter:'date', formatoptions:{newformat:"Y-m-d"}},
		        { name:'icom', 			index:'lci.icom', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'mkngYy', 	    index:'lci.mkng_yy', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'usePrpsCode', 	index:'cc4.mark_name', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'makr', 			index:'makr',			hidden:true},
		        { name:'carModel', 		index:'carModel',		hidden:true},
		        { name:'autoYn', 		index:'autoYn',			hidden:true},
		        { name:'useYn', 		index:'useYn',			hidden:true},
		        { name:'usePrps', 		index:'usePrps',		hidden:true},
		        { name:'rid', 			index:'rid',			hidden:true},

		    ],
		     sortname: 'lci.modify_date',
		     autowidth : true ,

		     sortorder: "desc"
		}
}
mbrCarHist = $("#mbrCarHistListGrid").ifvGrid({ jqGridOption : gMbrCarHist.jqGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>