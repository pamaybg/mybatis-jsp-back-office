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
			tmCampaignList = $("#tmCampaignListGrid").ifvsfGrid({ ejGridOption : gTmCampaignList.ejGridOption });
		},
		moveDetail : function(id){
			qtjs.href('<ifvm:url name="tmCampaignDetail"/>' + '?camRid=' + id);
		},
		search : function(){
			$.fn.ifvmSubmitSearchCondition("tmCampaignSearch", function(){
				tmCampaignList=$("#tmCampaignListGrid").ifvsfGrid({ ejGridOption : gTmCampaignList.ejGridOption })
			});
		},
		assignConsultant : {
			id : "assignConsultantPop",
			pop : function(){
				var checkedList = tmCampaignList.opt.gridControl.getSelectedRecords();
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
		ejGridOption : {
			rowSelected : function(args){
			      var obj = args.data;
			      rid = obj.rid;
	        },
	        recordDoubleClick : function(args){
	            var obj = args.data
	            gTmCampaignList.moveDetail(obj.camRid);
	        },
	       serializeGridData : function( data ){
		       if ($.fn.ifvmIsNotEmpty(requestitem)) {
		       }
		       return data;
	        },
	        dataUrl : '<ifvm:action name="getTmCampaignList"/>',
	        columns:[
	        	{
		      		  field : 'dispNo', headerText : '<spring:message code="V00256"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'mcm.DISP_NO' }/*캠페인번호 */
		      	  },{
		      		  field : 'camNm', headerText : '<spring:message code="V00257"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'mcm.cam_nm' }/*캠페인명 */
		      	  },{
		      		  field : 'camStartDd', headerText : '<spring:message code="V00258"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'mcm.CAM_START_DD' }/*시작일 */
		      	  },{
		      		  field : 'camEndDd', headerText : '<spring:message code="V00259"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'mcm.CAM_END_DD' }/*종료일 */
		      	  },{
		      		  field : 'campaignStatus', headerText : '<spring:message code="V00260"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'cc.MARK_NAME' }/*상태 */
		      	  },{
		      		  field : 'campaignType', headerText : '<spring:message code="V00261"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'cc2.MARK_NAME' }/*유형 */
		      	  },{
		      		  field : 'camScopeType', headerText : '<spring:message code="V00262"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'cc3.MARK_NAME' }/*캠페인범위 */
		      	  },{
		      		  field : 'camPlner', headerText : '<spring:message code="V00263"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : 'lmsr.NAME' }/*기획자 */
		      	  },{
		      		  field : 'totTmCnt', headerText : '<spring:message code="V00264"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : '' ,
		      			  sortable : false}/*전체 TM 수 */
		      	  },{
		      		  field : 'unAsnTmCnt', headerText : '<spring:message code="V00265"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : '' ,
		      			  sortable : false}/*미할당 TM 수 */
		      	  },{
		      		  field : 'complCnt', headerText : '<spring:message code="V00266"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : '' ,
		      			  sortable : false}/*완료 건수 */
		      	  },{
		      		  field : 'unComplCnt', headerText : '<spring:message code="V00267"/>', headerTextAlign : 'center',
		      		  customAttributes : {
		      			  index : '', 
		      			  sortable : false}/*미완료 건수 */
		      			  
		      	  },{
		      		  field : 'camRid', headerText : 'camRid', visible : false ,
		      		  customAttributes : {
		      			  index : 'mcm.id' }/*camRid */
		      	  }
	        ],
	        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'mcm.create_date',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
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
