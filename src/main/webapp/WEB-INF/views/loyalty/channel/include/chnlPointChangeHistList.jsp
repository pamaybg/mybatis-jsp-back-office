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
    var jqGridOption = {
        ondblClickRow : function(data) {
            var data = chnlPointChangeHistList.getRowData()[data-1];
            rid = data.rid;
        },
        onSelectRow : function(data) {
        },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	data.rid = channelDetail_rid;
            return data;
        },
        loadComplete : function(obj) {
        },
        url : '<ifvm:action name="getChnlPointChangeHistList"/>',
        colNames:[
                   '<spring:message code="L01395" />',
                   '<spring:message code="L01396" />',
                   '<spring:message code="L01397" />',
                   '<spring:message code="L01398" />',
                   '<spring:message code="L01399" />',
                   '<spring:message code="L01400" />',
                   '<spring:message code="L01401" />',
                   'rid'
                 ],
        colModel:[
             { name:'startDd',   index:'a.start_dd',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'100px' },
             { name:'endDd',   index:'a.end_dd',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'100px' },
             { name:'acrlRuleCd',   index:'b.rule_cd',  resizable : true, align:'center',    width:'100px' },
             { name:'acrlRuleTypeCd',   index:'b.rule_type_cd',  resizable : true, align:'center',    width:'100px' },
             { name:'adjRuleCd',   index:'c.rule_cd',  resizable : true, align:'center',    width:'100px' },
             { name:'adjRuleTypeCd',   index:'c.rule_type_cd',  resizable : true, align:'center',    width:'100px' },
             { name:'createBy',   index:'d.user_id',  resizable : true, align:'center',    width:'100px' },
             { name:'rid',    index:'a.rid',    hidden : true}
        ],
        sortname: 'a.start_dd',
        autowidth : true ,
        
        sortorder: "desc"
    };

    chnlPointChangeHistList = $("#chnlPointChangeHistListGrid").ifvGrid({ jqGridOption : jqGridOption });
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

