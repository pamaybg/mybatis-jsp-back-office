<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var dbListPopGrid;
var gridIddbListPopGrid;

/**
 * Import
 */
function getDBListPopGrid() {
    var ejGridOption = {
            serializeGridData : function(data) {
                return data;
            },
            dataUrl : '<ifvm:action name="getDbInformList"/>',
            columns:[
            	{
    	      		  field : 'serviceNm', headerText : '<spring:message code="M01440"/>', headerTextAlign : 'center',
    	      		  customAttributes : {
    	      			  index : 'd.service_nm' }
    	      	  },{
    	      		  field : 'conDbTypeName', headerText : '<spring:message code="M00508"/>', headerTextAlign : 'center',
    	      		  customAttributes : {
    	      			  index : 'c.mark_name' }
    	      	  },{
    	      		  field : 'conIp', headerText : '<spring:message code="M01125"/>', headerTextAlign : 'center',
    	      		  customAttributes : {
    	      			  index : 'd.con_ip' }
    	      	  },{
    	      		  field : 'conPort', headerText : '<spring:message code="M01126"/>', headerTextAlign : 'center',
    	      		  customAttributes : {
    	      			  index : 'd.con_port' }
    	      	  },{
    	      		  field : 'conId', headerText : '<spring:message code="M01127"/>', headerTextAlign : 'center',
    	      		  customAttributes : {
    	      			  index : 'd.con_id' }
    	      	  },{
    	      		  field : 'conUrl', headerText : '<spring:message code="M00471"/>', headerTextAlign : 'center',
    	      		  customAttributes : {
    	      			searchable : false ,
    	      			  index : 'd.con_url' }
    	      	  },{
    	      		  field : 'dbInformId', headerText : 'dbInformId', visible : false ,
    	      		  customAttributes : {
    	      			  index : 'd.id' }
    	      	  },{
    	      		  field : 'conDbType', headerText : 'conDbType', visible : false ,
    	      		  customAttributes : {
    	      			  index : 'd.id' }
    	      	  },
            ],
            requestGridData : {
    	      	  nd   : new Date().getTime(),
    	      	  rows : 10,
    	      	  sidx : 'd.create_date',
    	      	  sord : 'desc',
    	      	  _search : false
    	        },
    	        rowList : [10,25,50,100],
    	        radio: true ,
    	        tempId : 'ifvGridOriginTemplete',
        };

    dbListPopGrid = $("#dbListPopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

$(document).ready(function() {

    getDBListPopGrid();

    // 선택 버튼
    $('#dbSelectBtn').on('click', function() {
        dbSelect();
    });
    // 취소버튼
    $('#dbListCancelBtn').on('click', function() {
        dbListPopupClose();
    });

});

</script>

<div id="dbListPopWrap">
    <div class="pop_inner_wrap">
        <div id="dbListPopGrid" ></div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="dbSelectBtn" objCode="dbSelectBtn_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00282"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="dbListCancelBtn" objCode="dbListCancelBtn_OBJ">
            <spring:message code="M00284"/>
        </button>
    </div>
</div>