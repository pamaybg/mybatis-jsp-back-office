<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
gTmCampaignList = {
		init : function(){
			this.searchInit();
			//this.loadData();
			this.search();
		},
		searchInit : function(){
			$.fn.ifvmSetCommonCondList("tmCampaignSearch","PGM_V_010");
		},
		loadData : function(){
			tmCampaignList = $("#tmCampaignListGrid").ifvGrid({ jqGridOption : gTmCampaignList.jqGridOption });
		},
		moveDetail : function(id){
			qtjs.href('<ifvm:url name="tmCampaignDetail"/>' + '?camRid=' + id);
		},
		search : function(){
			$.fn.ifvmSubmitSearchCondition("tmCampaignSearch", function(){
				tmCampaignList=$("#tmCampaignListGrid").ifvGrid({ jqGridOption : gTmCampaignList.jqGridOption })
			});
		},
		assignConsultant : {
			id : "assignConsultantPop",
			pop : function(){
				var checkedList = tmCampaignList.getCheckedList();
				if(checkedList.length == 0){
					alert('<spring:message code="L01393" />');
					return;
				}
				$("#"+this.id).ifvsfPopup({
		            enableModal : true,
		            enableResize : false,
		            contentUrl : '<ifvm:url name="assignConsultantPop"/>'+'?camRid='+checkedList[0].camRid,
		            contentType : "ajax",
		            title : '<spring:message code="V00268"/>', // 상담원 할당,
		            width : '800px'
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
		},
		jqGridOption : {
			ondblClickRow : function(data){
			      var obj = tmCampaignList.getRowData()[data-1];
			      rid = obj.rid;
	        },
	        onSelectRow : function (data) {
	        	 //upldItemSearch();
	        },
	        ondblClickRow : function(data){
	            var obj = tmCampaignList.getRowData()[data-1];
	            gTmCampaignList.moveDetail(obj.camRid);
	        },
	       serializeGridData : function( data ){
		       if ($.fn.ifvmIsNotEmpty(requestitem)) {
		       }
		       return data;
	        },
	        loadComplete : function(obj){
	        },
	        url : '<ifvm:action name="getTmCampaignList"/>',
	        colNames:[
	                   '<spring:message code="V00256" />',  /*캠페인번호 */
	                   '<spring:message code="V00257" />',  /*캠페인명 */
	                   '<spring:message code="V00258" />',  /*시작일 */
	                   '<spring:message code="V00259" />',  /*종료일 */
	                   '<spring:message code="V00260" />',  /*상태*/
	                   '<spring:message code="V00261" />',  /*유형*/
	                   '<spring:message code="V00262" />',  /*캠페인범위*/
	                   '<spring:message code="V00263" />',  /*기획자*/
	                   '<spring:message code="V00264" />',  /*전체 TM 수*/
	                   '<spring:message code="V00265" />',  /*미할당 TM 수*/
	                   '<spring:message code="V00266" />',  /*완료 건수*/
	                   '<spring:message code="V00267" />',  /*미완료 건수*/
	                   'camRid'
	                 ],
	        colModel:[
				 { name:'dispNo',   		index:'mcm.DISP_NO',  			resizable : true, align:'center',  	width:'80px' },
	             { name:'camNm',   			index:'mcm.cam_nm',  			resizable : true, align:'center',   width:'140px'},
	             { name:'camStartDd',   	index:'mcm.CAM_START_DD',  		resizable : true, align:'center',  	width:'100px',	formatter:'date', formatoptions:{newformat:"Y-m-d"}  },
	             { name:'camEndDd',   		index:'mcm.CAM_END_DD',  		resizable : true, align:'center',   width:'100px',	formatter:'date', formatoptions:{newformat:"Y-m-d"} },
	             { name:'campaignStatus',   index:'cc.MARK_NAME ',  		resizable : true, align:'center',   width:'180px' },
	             { name:'campaignType',   	index:'cc2.MARK_NAME ',  		resizable : true, align:'center',   width:'80px' },
	             //{ name:'camScopeTypeCd',   index:'mcm.cam_scope_type_cd',  resizable : true, align:'center',   width:'140px'},
	             { name:'camScopeType',   	index:'cc3.MARK_NAME',  		resizable : true, align:'center',   width:'80px' },
	             { name:'camPlner',   		index:'e.NAME',  				resizable : true, align:'center',   width:'110px' },
	             { name:'totTmCnt',   		index:'', 		resizable : true, align:'center',   width:'80px', sortable : false},
	             { name:'unAsnTmCnt',   	index:'',  		resizable : true, align:'center',   width:'80px', sortable : false},
	             { name:'complCnt',   		index:'',  		resizable : true, align:'center',   width:'80px', sortable : false},
	             { name:'unComplCnt',   	index:'',  		resizable : true, align:'center',   width:'80px', sortable : false},

	             { name:'camRid',    index:'mcm.id',    hidden : true},
	        ],
	        sortname: 'mcm.create_date',
			autowidth : true , sortorder: "desc",
			shrinkToFit: false,
			radio : true
	    }

}

$(document).ready(function() {
  	gTmCampaignList.init();
});
</script>

<div class="page-title">
    <h1>
        <spring:message code="V00255" />
        &gt;<spring:message code="L00081"/>
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"   btnFunc="gTmCampaignList.search"/>
            <ifvm:inputNew type="button"   text="M00278"  btnFunc="gTmCampaignList.searchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="tmCampaignSearch" >
    </div>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button"   text="V00268"  btnFunc="gTmCampaignList.assignConsultant.pop"/>
        </div>
    </div>
    <div id="tmCampaignListGrid" class="white_bg grid_bd0"></div>
</div>


<div id="assignConsultantPop" class="popup_container"></div>
