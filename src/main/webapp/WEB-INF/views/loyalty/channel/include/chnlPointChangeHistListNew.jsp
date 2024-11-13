<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var chnlPointChangeHistList;
var gridIdchnlPointChangeHistList;
var rid ;

//정산기준 변경이력
function getchnlPointChangeHistListSearch() {
    var ejGridOption = {
  		recordDoubleClick : function(args) {
            var data = args.data
            rid = data.rid;
        },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	data.rid = channelDetail_rid;
            return data;
        },
        dataUrl : '<ifvm:action name="getChnlPointChangeHistList"/>',
        columns:[
        	{
	      		  field : 'startDd', headerText : '<spring:message code="L01395"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.start_dd' }/* */
	      	  },{
	      		  field : 'endDd', headerText : '<spring:message code="L01396"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'a.end_dd' }/* */
	      	  },{
	      		  field : 'acrlRuleCd', headerText : '<spring:message code="L01397"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'b.rule_cd' }/* */
	      	  },{
	      		  field : 'acrlRuleTypeCd', headerText : '<spring:message code="L01398"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'b.rule_type_cd' }/* */
	      	  },{
	      		  field : 'adjRuleCd', headerText : '<spring:message code="L01399"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c.rule_cd' }/* */
	      	  },{
	      		  field : 'adjRuleTypeCd', headerText : '<spring:message code="L01400"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c.rule_type_cd' }/* */
	      	  },{
	      		  field : 'createBy', headerText : '<spring:message code="L01401"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'd.user_id' }/* */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      		  customAttributes : {
	      			  index : 'a.rid' }/* */
	      	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'a.start_dd',
      	  sord : 'desc',
      	  _search : false
        },
        allowScrolling: true,
        rowList : [10,25,50,100],
        sortorder: "desc"
    };

    chnlPointChangeHistList = $("#chnlPointChangeHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridIdchnlPointChangeHistList = $("#gridIdchnlPointChangeHistList");
}

//공통 조회 호출
function chnlPointChangeHistListSearch() {
    $.fn.ifvmSubmitSearchCondition("chnlPointChangeHistListSearchList", getchnlPointChangeHistListSearch);
}

$(document).ready(function() {
    chnlPointChangeHistListSearch();
});

</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">

        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="chnlPointChangeHistListGrid" class="white_bg grid_bd0"></div>
</div>

