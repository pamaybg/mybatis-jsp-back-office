<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var chnlChangeHistList;
var gridIdchnlChangeHistList;
var rid ;

//변경이력
function getchnlChangeHistListSearch(){
    var ejGridOption = {
   		recordDoubleClick : function(args){
            var data = args.data
            rid = data.rid;
        },
        serializeGridData : function( data ){
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	data.rid = channelDetail_rid;
            return data;
        },
        dataUrl : '<ifvm:action name="getChnlChangeHistList"/>',
        columns:[
        	{
	      		  field : 'createDate', headerText : '<spring:message code="L01386"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.create_date' }/* */
	      	  },{
	      		  field : 'chgItem', headerText : '<spring:message code="L01387"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.chg_item' }/* */
	      	  },{
	      		  field : 'cdNm', headerText : '<spring:message code="L01388"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.cd_nm' }/* */
	      	  },{
	      		  field : 'bchngVal', headerText : '<spring:message code="L01389"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.bchng_val' }/* */
	      	  },{
	      		  field : 'achngVal', headerText : '<spring:message code="L01390"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.achng_val' }/* */
	      	  },{
	      		  field : 'createBy', headerText : '<spring:message code="L01391"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.create_by' }/* */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      		  customAttributes : {
	      			  index : 'a.rid' }/* */
	      	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'a.create_date',
      	  sord : 'desc',
      	  _search : false
        },
        allowScrolling: true,
        rowList : [10,25,50,100],
        autowidth : true ,
    };

    chnlChangeHistList = $("#chnlChangeHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridIdchnlChangeHistList = $("#gridIdchnlChangeHistList");
}

//공통 조회 호출
function chnlChangeHistListSearch() {
    $.fn.ifvmSubmitSearchCondition("chnlChangeHistListSearchList", getchnlChangeHistListSearch);
}

$(document).ready(function() {
    chnlChangeHistListSearch();
});

</script>


<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">

        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="chnlChangeHistListGrid" class="white_bg grid_bd0"></div>
</div>

