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
			simpleMemRegList = $("#simpleMemRegListGrid").ifvGrid({ jqGridOption : gSimpleMemRegList.jqGridOption });
		},
		moveDetail : function(id){
			qtjs.href('<ifvm:url name="simpleMemRegDetail"/>' + '?rid=' + id);
		},
		search : function(){
			$.fn.ifvmSubmitSearchCondition("batchRegistSearch", function(){
				simpleMemRegList=$("#simpleMemRegListGrid").ifvGrid({ jqGridOption : gSimpleMemRegList.jqGridOption })
			});
		},
		jqGridOption : {
			ondblClickRow : function(data){
			      var obj = simpleMemRegList.getRowData()[data-1];
			      rid = obj.rid;
	        },
	        onSelectRow : function (data) {
	        	 //upldItemSearch();
	        },
	        ondblClickRow : function(data){
	            var obj = simpleMemRegList.getRowData()[data-1];
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
	        url : '<ifvm:action name="getSimpleMemRegList"/>',
	        colNames:[
	                   '<spring:message code="L01728" />',  /*카드번호 */
	                   '<spring:message code="L01731" />',  /*카드수령인 */
	                   '<spring:message code="L00938" />',  /*충전소명 */
	                   '<spring:message code="L01732" />',  /*연락처 가입여부 */
	                   '<spring:message code="L01733" />',  /*카드수령일*/
	                   '<spring:message code="L01734" />',  /*전화접촉여부*/
	                   '<spring:message code="L01735" />',  /*전화접촉일시*/
	                   '<spring:message code="L01736" />',  /*전화접촉구분*/
	                   '<spring:message code="L01754" />',  /*전화접촉내용*/
	                //   '<spring:message code="L01737" />',  /*SMS전송결과*/
	                   '<spring:message code="L01738" />',  /*간편회원등록여부*/
	                   '<spring:message code="L01739" />',  /*간편회원등록일시*/
	                   '<spring:message code="L02017" />',  /*카드 등록 여부*/
	                   'rid',
	                 ],
	        colModel:[
	             { name:'cardNum',   index:'lmsr.CARD_NUM',  resizable : true, align:'center',    width:'140px'},
	             { name:'userName',   index:'lmsr.USER_NAME',  resizable : true, align:'center',  width:'80px' },
	             { name: 'chnlNm',   index:'lc.CHNL_NM',  resizable : true, align:'center',  width:'120px' },
	             { name:'cntcDeskArdySbscYn',   index:'lmsr.CNTC_DESK_ARDY_SBSC_YN',  resizable : true, align:'center',    width:'80px'},
	             { name:'cardGetDate',   index:'lmsr.CARD_GET_DATE',  resizable : true, align:'center',    width:'140px' ,formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"} },
	             { name:'telTchYn',   index:'lmsr.TEL_TCH_YN',  resizable : true, align:'center',    width:'80px' },
	             { name:'telTchDt',   index:'lmsr.TEL_TCH_DT',  resizable : true, align:'center',    width:'140px',formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"} },
	             { name:'telTchDiv',   index:'lmsr.telTchDiv',  resizable : true, align:'center',    width:'80px' },
	             { name:'telTchSBst',   index:'lmsr.telTchSBst',  resizable : true, align:'center',    width:'180px' },
	          //   { name:'smsTrmReslt',   index:'lmsr.SMS_TRM_RESLT',  resizable : true, align:'center',    width:'110px' },
	             { name:'trmlSmplRegFlg',   index:'lmsr.TRML_SMPL_REG_FLG',  resizable : true, align:'center',    width:'80px' },
	             { name:'trmlSmplRegDt',   index:'lmsr.TRML_SMPL_REG_DT',  resizable : true, align:'center',    width:'100px', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"} },
	             { name:'activeFlg',   index:'lcri.ACTIVE_FLG',  resizable : true, align:'center',    width:'80px' ,	sortable: false},

	             { name:'rid',    index:'lmsr.rid',    hidden : true},
	        ],
	        sortname: 'lmsr.TRML_SMPL_REG_DT',
			autowidth : true , sortorder: "desc",
			shrinkToFit: false
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
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"   btnFunc="gSimpleMemRegList.search" objCode="simpleMemRegisterSearch_OBJ"/>
            <ifvm:inputNew type="button"   text="M00278"  btnFunc="gSimpleMemRegList.searchInit" objCode="simpleMemRegistersearchInit_OBJ"/>
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
