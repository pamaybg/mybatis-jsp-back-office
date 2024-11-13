<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
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
<script type="text/javascript">


var mbrGroupList;

var chnlRid= '<%= cleanXss(request.getParameter("chnlRid")) %>'; 


gMbrGroupList = {
	init : function(){
		this.searchInit();
		this.search();

	},
	searchInit : function(){
		$.fn.ifvmSetCommonCondList("mbrGroupListSearchList","PGM_L_034");
	},
	search : function(){
		$.fn.ifvmSubmitSearchCondition("mbrGroupListSearchList", function(){
			mbrGroupList = $("#mbrGroupListGrid").ifvGrid({ jqGridOption : gMbrGroupList.jqGridOption })
		});
	},
	jqGridOption : {
        ondblClickRow : function(data){
	      var data = mbrGroupList.getRowData()[data-1];
	      qtjs.href('<ifvm:url name="mbrGroupDetail"/>' + '?rid=' + data.rid);
        },
        onSelectRow : function (data) {
        },
       serializeGridData : function( data ){
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        if(typeof chnlRid != "undefined" && chnlRid != "null" ){
        	data.chnlRid = chnlRid;
        	chnlRid = "null";
        	
    	}
        
            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getMbrGroupList"/>',
        colNames:[
                   '<spring:message code="M00688" />',
                   '<spring:message code="L00722" />',
                   '<spring:message code="L00557" />',
                   '<spring:message code="L00180" />',
                   '<spring:message code="M02019" />',

                   'rid'
                 ],
        colModel:[
             { name:'mbrNo',   	index:'a.mbr_no',  		resizable : true, align:'center',    width:'50px' },
             { name:'chnlNm',   index:'b.chnl_nm',  	resizable : true, align:'center',    width:'150px' },
             { name:'memDiv',   index:'a.mem_div',  	resizable : true, align:'center',    width:'50px' },
             { name:'tierNm',   index:'c.tier_nm',  	resizable : true, align:'center',    width:'150px' },
             { name:'mbrStat',  index:'d.mark_name',  	resizable : true, align:'center',    width:'50px' },
             { name:'rid',    index:'a.rid',    hidden : true}
        ],
        sortname: 'a.mbr_no',
        autowidth : true ,
        sortorder: "desc",
        shrinkToFit: false
    },
    addMbrGroup : {
    	id:"mbrGroupPop",
    	pop : function(){
			$("#"+this.id).ifvsfPopup({
	            enableModal : true,
	            enableResize : false,
	            contentUrl : '<ifvm:url name="addMbrGroupPop"/>',
	            contentType : "ajax",
	            title : '<spring:message code="L01607"/>', // 단체
	            width : '1000px'
	        });
		},
		beforeClose : function(obj){

		},
		close: function(obj){
			if(obj){
				this.beforeClose(obj)
			}
			var _popObj = eval(this.id)
			_popObj._destroy();
		}

    }
}


$(document).ready(function() {
    gMbrGroupList.init();
});
</script>


<div class="page-title">
    <h1>
	    <spring:message code="L01606" />
	 	&gt; <spring:message code="M00135" />
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" btnFunc="gMbrGroupList.search" btnType="search" text="L00081" objCode="mbrGroupListSearch_OBJ"/>
            <ifvm:inputNew type="button" btnFunc="gMbrGroupList.searchInit" text="L00082" objCode="mbrGroupListInit_OBJ"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="mbrGroupListSearchList" >
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-5">
            <span><spring:message code="M00277" /></span>
        </div>
        <%-- <div class="col-xs-7 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="plus" text="L00027" btnFunc="gMbrGroupList.addMbrGroup.pop"/>
        </div> --%>
    </div>
    <div id="mbrGroupListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="mbrGroupPop" class="popup_container"></div>
