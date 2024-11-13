<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="setTelno">
</script>


<script type="text/javascript">
var chnlSubList;
var gridIdchnlSubList;
var rid ;

//하위가맹점
function getchnlSubListSearch(){
    var ejGridOption = {
		recordDoubleClick : function(args){
     		 var data = args.data ;
     		 rid = data.rid;
      //emptyDtlPop();   // 상세 보기 이벤트
        },
       serializeGridData : function( data ){
    	   data.rid = channelDetail_rid;
           return data;
        },
        dataUrl : '<ifvm:action name="getChnlSubList"/>',
        columns:[
        	 {
	      		  field : 'lowMbrbsCd', headerText : '<spring:message code="L00733"/>', headerTextAlign : 'center', width:'90px',
	      		  customAttributes : {
	      			  index : 'b.low_mbrbs_cd' }/* */
	      	  }, {
	      		  field : 'chnlNo', headerText : '<spring:message code="L00734"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'b.chnl_no' }/* */
	      	  }, {
	      		  field : 'chnlNm', headerText : '<spring:message code="L00565"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'b.chnl_nm' }/* */
	      	  }, {
	      		  field : 'pointContType', headerText : '<spring:message code="L00735"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'e.mark_name' }/* */
	      	  }, {
	      		  field : 'mbrbsStatus', headerText : '<spring:message code="L00736"/>', headerTextAlign : 'center',width:'70px',
	      		  customAttributes : {
	      			  index : 'b.mbrbs_status_cd' }/* */
	      	  }, {
	      		  field : 'bizrNo', headerText : '<spring:message code="L00597"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'b.bizr_no' }/* */
	      	  }, {
	      		  field : 'reprNm', headerText : '<spring:message code="L00737"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'b.repr_nm' }/* */
	      	  }, {
	      		  field : 'telNo', headerText : '<spring:message code="L00400"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'b.tel_no' }/* */
	      	  }, {
	      		  field : 'zipCd', headerText : '<spring:message code="L00383"/>', headerTextAlign : 'center',width:'70px',
	      		  customAttributes : {
	      			  index : 'b.zip_cd' }/* */
	      	  }, {
	      		  field : 'adrDtl', headerText : '<spring:message code="M00574"/>', headerTextAlign : 'center',width:'200px',
	      		  customAttributes : {
	      			  index : 'b.adr_dtl' }/* */
	      	  }, {
	      		  field : 'acrlRuleCd', headerText : '<spring:message code="L00624"/>', headerTextAlign : 'center',width:'70px',
	      		  customAttributes : {
	      			  index : 'c.rule_cd' }/* */
	      	  }, {
	      		  field : 'acrlRuleTypeCd', headerText : '<spring:message code="L00625"/>', headerTextAlign : 'center',width:'90px',
	      		  customAttributes : {
	      			  index : 'c.rule_type_cd' }/* */
	      	  }, {
	      		  field : 'adjRuleCd', headerText : '<spring:message code="L00622"/>', headerTextAlign : 'center',width:'70px',
	      		  customAttributes : {
	      			  index : 'd.rule_cd' }/* */
	      	  }, {
	      		  field : 'adjRuleTypeCd', headerText : '<spring:message code="L00623"/>', headerTextAlign : 'center',width:'150px',
	      		  customAttributes : {
	      			  index : 'd.rule_type_cd' }/* */
	      	  }, {
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      		  customAttributes : {
	      			  index : 'a.rid' }/* */
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'a.rid',
      	  sord : 'desc',
      	  _search : false
        },
        allowScrolling: true,
        editSettings: {allowEditing: true},
        rowList : [10,25,50,100],
        sortname: 'a.rid',
    };

    chnlSubList = $("#chnlSubListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridIdchnlSubList = $("#gridIdchnlSubList");
}
// function autoHypenPhone(str){
// 	str = str.replace(/[^0-9]/g, '');
// 	var tmp = '';
// 	  if( str.length < 4){
// 	    return str;
// 	  }else if(str.length < 7){
// 	    tmp += str.substr(0, 3);
// 	    tmp += '-';
// 	    tmp += str.substr(3);
// 	    return tmp;
// 	  }else if(str.length < 10){
// 		  if(str.substr(0, 2)=="02"){
// 			  tmp += str.substr(0, 2);
// 			  tmp += '-';
// 			  tmp += str.substr(2, 3);
// 			  tmp += '-';
// 			  tmp += str.substr(5);
// 			  return tmp;
// 		  }else{
// 			  tmp += str.substr(0, 3);
// 			  tmp += '-';
// 			  tmp += str.substr(3, 3);
// 			  tmp += '-';
// 			  tmp += str.substr(6);
// 			  return tmp;
// 		  }
// 	  }else{
// 		  if(str.substr(0, 2)=="02"){
// 			  tmp += str.substr(0, 2);
// 			  tmp += '-';
// 			  tmp += str.substr(2, 4);
// 			  tmp += '-';
// 			  tmp += str.substr(6);
// 			  return tmp;
// 		  }else{
// 			  tmp += str.substr(0, 3);
// 			  tmp += '-';
// 			  tmp += str.substr(3, 4);
// 			  tmp += '-';
// 			  tmp += str.substr(7);
// 			  return tmp;
// 		  }

// 	  }
// 	  return str;
// }

// function setTelno(cellvalue, options, rowObjec){
//     var telNo = rowObjec.telNo;
//     var rtnVal= null;
//     if(telNo){
// 		rtnVal = autoHypenPhone(telNo);
//     }else{
//     	rtnVal = "";
//     }

//     return rtnVal;
// }



//공통 조회 호출
function chnlSubListSearch() {
    $.fn.ifvmSubmitSearchCondition("chnlSubListSearchList", getchnlSubListSearch);
}


$(document).ready(function() {


    chnlSubListSearch();
    //조회
    $('#chnlSubListSearchBtn').on('click', function(){
     chnlSubListSearch();
    });



});

</script>



<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">

        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="chnlSubListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="emptyDialog" class="popup_container"></div>

