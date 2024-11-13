<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tierListGrid, ridTier, tierNm,tmpSeqNo,modifyTierDate;

function getTierList(){
    var ejGridOption = {
       	rowSelected : function(args){
            var data = args.data;
            ridTier = data.rid;
            tierNm = data.tierNm;
            tmpSeqNo = data.seqNo;
            modifyTierDate = data.modifyTierDate;
       	},recordDoubleClick : function(row) {
       		selectTier();
        },
      	serializeGridData : function( data ) {
      		if(tierGrpRid != null){
      			data.tierGrpRid = tierGrpRid;
      		}
            return data;
       	},
        dataUrl : '<ifvm:action name="getCommTierListPop"/>',

        columns : [
        	{
      		  field : 'seqNo', headerText : '순서', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'tierTypeCd', headerText : '등급코드', textAlign : 'center', headerTextAlign : 'center', textAlign : 'center' , customAttributes : {index : 'tierTypeCd'}
    	  },{
    		  field : 'tierNm', headerText : '등급명', headerTextAlign : 'center', textAlign : 'left',  width:'200px' ,customAttributes :{searchable : true}
    	  },{
    		  field : 'baseTierYn', headerText : '기본등급', headerTextAlign : 'center', textAlign : 'center' , customAttributes :{searchable : true}
    	  },{
    		  field : 'createBy', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'createDate', headerText : '등록일자',width:'130px', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false
    	  },{
    		  field : 'modifyTierDate', headerText : 'modifyTierDate',visible : false
    	  }
        ],
        requestGridData : {
           sidx: '1',
           sord : 'ASC'
        },
        radio : true,
    };
    tierListGrid = $("#tierListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}


function selectTier() {
	 $("#tierNm").val(tierNm);
     $("#ridTier").val(ridTier);
     $("#modifyTierNm").val(tierNm);
     $("#modifyTierDate").val(modifyTierDate);
     modifySeqNo = tmpSeqNo;
     ridTier = ridTier;
     $.fn.ifvmPopupClose();
}

$(document).ready(function(){
	getTierList();
	
	//선택 클릭시
    $('#selectBtn').on('click', function(){
    	selectTier();
    });
	
  	//취소 클릭시
    $('#cancelBtn').on('click', function(){
    	$.fn.ifvmPopupClose();
    });
});
</script>


<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="tierListGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectBtn" objCode="tierPopSelectBtn_OBJ"><spring:message code="L00123"/></button>
	    <button class="btn btn-sm btn_lightGray2" id="cancelBtn" objCode="tierPopCancelBtn_OBJ"><spring:message code="L00124"/></button>
	</div>
</div>

