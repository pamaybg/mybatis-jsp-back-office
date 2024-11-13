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
        	<ifvm:inputNew type="button" btnType="plus" text="L01531" id="addMbrGroupUserBtn" btnFunc="addMbrGroupUserPopup.pop" objCode="addMbrGroupUserBtn_OBJ"/>
       	 	<ifvm:inputNew type="button" btnType="select" text="L01510" id="dropMbrGroupUserBtn"  btnFunc="gMbrGroupUserList.dropGroupUser" objCode="dropMbrGroupUserBtn_OBJ"/>
       	 	<script>
		       	 addMbrGroupUserPopup = {
		         		id  : "addMbrGroupUserPop",
		         		pop : function(obj){
		         			$("#"+this.id).ifvsfPopup({
		            	            enableModal : true,
		            	            enableResize : false,
		            	            contentUrl : '<ifvm:url name="addMbrGroupUserPop"/>',
		            	            contentType : "ajax",
		            	            title : '<spring:message code="L01503"/>', // 동호회 회원,
		            	            width : '900px'
		            	        });
		         		},
		         		beforeClose : function(obj){
		         			if(obj != null){
		         				mbrGroupUserList.requestData();
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
    </div>
    <div id="mbrGroupUserListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="addMbrGroupUserPop" class="popup_container"></div>
<script type="text/javascript">
//mbrGroupUserList

gMbrGroupUserList = {
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.ridChnl = gGroupDetail.data.chnlRid
		    	 return data;
		     },
		     onSelectRow : function (data) {
		    	 if(data.activeFlg !="Y"){
		    		 $("#dropMbrGroupUserBtn").prop("disabled",false);
		    	 }
		    	 console.log(data);
	         },
		     loadComplete : function(result){
		    	 if(gGroupDetail.data.memDiv != "G"){
		    		 $("#addMbrGroupUserBtn, #dropMbrGroupUserBtn").prop('disabled',true);
		    	 }
		    	 $("#dropMbrGroupUserBtn").prop('disabled',true);
		     },
		     url : '<ifvm:action name="getMbrGroupUserList"/>',
		     colNames:[
		               '<spring:message code="L01505"/>',
		               '<spring:message code="L01506"/>',
		               '<spring:message code="L01507"/>',
		               '<spring:message code="L01508"/>',
		               '<spring:message code="L01509"/>',
		               'ridCust',
		               'ridMbr',
		               'ridChnl'
		             ],
		    colModel:[
		        { name:'mbrNo', 	    index:'lm.mbr_no', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'custNm', 	    index:'lc.cust_nm ', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'regDt', 		index:'lcm.reg_dt', 			width:'100px', 	align: 'center', 	resizable : true, 	formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
		        { name:'delDt', 	    index:'lcm.del_dt ', 			width:'100px', 	align: 'center', 	resizable : true,	formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"} },
		        { name:'activeFlg', 	index:'lcm.active_flg', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'ridCust', 	   	index:'lm.rid_cust', 			hidden:true },
		        { name:'ridMbr', 	   	index:'lm.rid', 				hidden:true },
		        { name:'ridChnl', 	   	index:'lcn.rid', 				hidden:true },
		    ],
		     sortname: 'lcm.create_date',
		     autowidth : true ,
		     sortorder: "desc",
		     
		     radio: true
		},
		init : function (){
			mbrGroupUserList = $("#mbrGroupUserListGrid").ifvGrid({ jqGridOption : gMbrGroupUserList.jqGridOption });
		},
		dropGroupUser : function(){
			var data = {
					ridChnl : mbrGroupUserList.getCheckedGridData()[0].ridChnl,
					ridMbr : mbrGroupUserList.getCheckedGridData()[0].ridMbr
			}
			$.ifvSyncPostJSON('<ifvm:action name="dropMbrGroupUser"/>', data , function(result) {

	        	alert('<spring:message code="L01824"/>');
	        	mbrGroupUserList.requestData();
	        }, function(result){
	        	alert(result.message);
	        })
		}

}
gMbrGroupUserList.init();


</script>






