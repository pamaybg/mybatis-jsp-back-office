<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">




var regNumber = /[^0-9]/g;
gSimpleMemRegList = {
		init : function(){
			this.searchInit();
			//this.loadData();
			this.search();
		},
		searchInit : function(){
			$.fn.ifvmSetCommonCondList("batchRegistSearch","PGM_L_106");
			$(".SearchCondition .searchTextVal option:selected").filter(function(){
				if($(this).attr('joinsrcclm') != 'CHNL_NM' ){
					$(this).parents('.SearchCondition').find('.searchCondition option[value="LIKE"]').remove()
				}
				if($(this).attr('joinsrcclm') == 'ACTIVE_FLG' ){
					$(this).parents('.SearchCondition').find('.changeTypeAreaCode option[value="N"]').prop('selected',true);
				}
			})
			$(".SearchCondition .searchCondition option[value='NOT']").remove();

			//$(".datepicker").val("");
		},
		loadData : function(){
			simpleMemRegList = $("#simpleMemRegListGrid").ifvsfGrid({ ejGridOption : gSimpleMemRegList.ejGridOption });
		},
		moveDetail : function(id){
			qtjs.href('<ifvm:url name="simpleMemRegDetailNew"/>' + '?rid=' + id);
		},
		search : function(){
			$.fn.ifvmSubmitSearchCondition("batchRegistSearch", function(){
				simpleMemRegList=$("#simpleMemRegListGrid").ifvsfGrid({ ejGridOption : gSimpleMemRegList.ejGridOption })
			});
		},
		ejGridOption : {
			recordDoubleClick : function(args){
			      var obj = args.data ;
			      rid = obj.rid;
	        },
// 	        onSelectRow : function (data) {
// 	        	 //upldItemSearch();
// 	        },
	        recordDoubleClick : function(args){
	            var obj = args.data ;
	            gSimpleMemRegList.moveDetail(obj.rid);
	        },
	       serializeGridData : function( data ){
		       if ($.fn.ifvmIsNotEmpty(requestitem)) {
		    	   	for(var i=0; i<requestitem.length ; i++){
		    	   		if(requestitem[i].whereVal !="" && requestitem[i].srcCol=="CARD_NUM"){
		    	   			//requestitem[i].whereVal= requestitem[i].whereVal.replaceAll("-","");
		        			requestitem[i].whereVal= requestitem[i].whereVal.replaceAll(regNumber,"");
	            		}
		    	   	}
		       		data.item = requestitem;
		       }
		       return data;
	        },
	        loadComplete : function(obj){
	        	console.log(obj);
	        },
	        dataUrl : '<ifvm:action name="getSimpleMemRegList"/>',
	        columns:[
	          {
	      		  field : 'cardNum', headerText : '<spring:message code="L01728"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.CARD_NUM' }/*카드번호 */
	      	  },{
	      		  field : 'userName', headerText : '<spring:message code="L01731"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.USER_NAME' }/*카드수령인 */
	      	  },{
	      		  field : 'chnlNm', headerText : '<spring:message code="L00938"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lc.CHNL_NM' }/*스토어명 */
	      	  },{
	      		  field : 'cntcDeskArdySbscYn', headerText : '<spring:message code="L01732"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.CNTC_DESK_ARDY_SBSC_YN' }/*연락처 가입여부 */
	      	  },{
	      		  field : 'cardGetDate', headerText : '<spring:message code="L01733"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.CARD_GET_DATE' }/*카드수령일*/
	      	  },{
	      		  field : 'telTchYn', headerText : '<spring:message code="L01734"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.TEL_TCH_YN' }/*전화접촉여부*/
	      	  },{
	      		  field : 'telTchDt', headerText : '<spring:message code="L01735"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.TEL_TCH_DT' }/*전화접촉일시*/
	      	  },{
	      		  field : 'telTchDiv', headerText : '<spring:message code="L01736"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.telTchDiv' }/*전화접촉구분*/
	      	  },{
	      		  field : 'telTchSBst', headerText : '<spring:message code="L01754"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.telTchSBst' }/*전화접촉내용*/
	      	  },{
	      		  field : 'trmlSmplRegFlg', headerText : '<spring:message code="L01738"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.TRML_SMPL_REG_FLG' }/*간편회원등록여부*/
	      	  },{
	      		  field : 'trmlSmplRegDt', headerText : '<spring:message code="L01739"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lmsr.TRML_SMPL_REG_DT' }/*간편회원등록일시*/
	      	  },{
	      		  field : 'activeFlg', headerText : '<spring:message code="L02017"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lcri.ACTIVE_FLG' }/*카드 등록 여부*/
	      	  },{
	      		  field : 'rid', headerText : 'rid', headerTextAlign : '', visible : false,
	      		  customAttributes : {
	      			  index : 'lmsr.rid' } /*rid*/
	      	  }
	        ],
	        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'lmsr.TRML_SMPL_REG_DT',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
	        
	    }

}

$(document).ready(function() {
  	gSimpleMemRegList.init();
});
</script>

<div class="page-title">
    <h1>
        <spring:message code="L01760" />
        &gt;<spring:message code="L00081"/>
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"   btnFunc="gSimpleMemRegList.search"/>
            <ifvm:inputNew type="button"   text="M00278"  btnFunc="gSimpleMemRegList.searchInit"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="batchRegistSearch" >
    </div>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="simpleMemRegListGrid" class="white_bg grid_bd0"></div>
</div>


<div id="excelFileUploadPop" class="popup_container"></div>
