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
    var jqGridOption = {
        ondblClickRow : function(data){
            var data = chnlChangeHistList.getRowData()[data-1];
            rid = data.rid;
        },
        onSelectRow : function (data) {
        },
        serializeGridData : function( data ){
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
        	data.rid = channelDetail_rid;
            return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getChnlChangeHistList"/>',
        colNames:[
                   '<spring:message code="L01386" />',
                   '<spring:message code="L01387" />',
                   '<spring:message code="L01388" />',
                   '<spring:message code="L01389" />',
                   '<spring:message code="L01390" />',
                   '<spring:message code="L01391" />',
                   'rid'
                 ],
        colModel:[
             { name:'createDate',   index:'a.create_date',  resizable : true, align:'center',  formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'100px' },
             { name:'chgItem',   index:'a.chg_item',  resizable : true, align:'center',    width:'100px' },
             { name:'cdNm',   index:'a.cd_nm',  resizable : true, align:'center',    width:'100px' },
             { name:'bchngVal',   index:'a.bchng_val',  resizable : true, align:'center',    width:'100px' },
             { name:'achngVal',   index:'a.achng_val',  resizable : true, align:'center',    width:'100px' },
             { name:'createBy',   index:'a.create_by',  resizable : true, align:'center',    width:'100px' },
             { name:'rid',    index:'a.rid',    hidden : true}
        ],
        sortname: 'a.create_date',
        autowidth : true ,
        
        sortorder: "desc"
    };

    chnlChangeHistList = $("#chnlChangeHistListGrid").ifvGrid({ jqGridOption : jqGridOption });
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

