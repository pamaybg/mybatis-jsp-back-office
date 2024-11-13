<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tierGrpListGrid, ridTier, tierNm;

function getTierGrpList(){
    var ejGridOption = {
       	rowSelected : function(args){
            var data = args.data;
            ridTier = data.rid;
            tierNm = data.tierGrpNm;
       	},
      	serializeGridData : function( data ) {
            return data;
       	},
       	dataUrl : '<ifvm:action name="getTierGroupListNew"/>',
        columns:[
        	{
	      		  field : 'pgmNm', headerText : '프로그램', headerTextAlign : 'center', textAlign : 'left', width:'120px', customAttributes : {searchable : true}
	      	  },{
	      		  field : 'tiersGrpNm', headerText : '등급그룹명', headerTextAlign : 'center', textAlign : 'left', width:'120px', customAttributes : {searchable : true}
	      	  },{
	      		  field : 'loyMbrTypeCdNm', headerText : '회원유형', headerTextAlign : 'center', textAlign : 'center', width:'80px', customAttributes : {index : 'loyMbrTypeCd'}
	      	  },{
	      		  field : 'vaildStartDt', headerText : '유효시작일', headerTextAlign : 'center', textAlign : 'center', width:'80px'
	      	  },{
	      		  field : 'mbrTierColNm', headerText : '등급그룹유형', headerTextAlign : 'center', textAlign : 'center', width:'80px', customAttributes : {index : 'mbrTierCol'}
	      	  },{
	      		  field : 'statCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width:'80px', customAttributes : {index : 'statCd'}
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      	  },
        ],
        requestGridData : {
           sidx: 'pgmNm'
        },
        radio : true,
    };
    tierGrpListGrid = $("#tierGrpListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


$(document).ready(function(){
	getTierGrpList();
	
	//선택 클릭시
    $('#selectBtn').on('click', function(){
        $("#tierNm").val(tierNm);
        $("#ridTier").val(rid);
    });
	
  	//취소 클릭시
    $('#cancelBtn').on('click', function(){
    	$.fn.ifvmPopupClose();
    });
});
</script>

<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="tierGrpListGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectBtn"><spring:message code="L00123"/></button>
	    <button class="btn btn-sm btn_lightGray2" id="cancelBtn"><spring:message code="L00124"/></button>
	</div>
</div>

