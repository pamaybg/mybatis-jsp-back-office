<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var chnlSubList;
var gridIdchnlSubList;
var rid ;

//하위가맹점
function getchnlSubListSearch(){
    var jqGridOption = {
        ondblClickRow : function(data){
      var data = chnlSubList.getRowData()[data-1];
      rid = data.rid;

      //emptyDtlPop();   // 상세 보기 이벤트


        },
        onSelectRow : function (data) {
        },
       serializeGridData : function( data ){
    	   data.rid = channelDetail_rid;
           return data;
        },
        loadComplete : function(obj){
        },
        url : '<ifvm:action name="getChnlSubList"/>',
        colNames:[
                   '<spring:message code="L00733" />',
                   '<spring:message code="L00734" />',
                   '<spring:message code="L00565" />',
                   '<spring:message code="L00735" />',
                   '<spring:message code="L00736" />',
                   '<spring:message code="L00597" />',
                   '<spring:message code="L00737" />',
                   '<spring:message code="L00400" />',
                   '<spring:message code="L00383" />',
                   '<spring:message code="M00574" />',
                   '<spring:message code="L00624" />',
                   '<spring:message code="L00625" />',
                   '<spring:message code="L00622" />',
                   '<spring:message code="L00623" />',
                   'rid'
                 ],
        colModel:[
             { name:'lowMbrbsCd',   	index:'b.low_mbrbs_cd', 	resizable : true, align:'center',    width:'90px' },
             { name:'chnlNo',   		index:'b.chnl_no',  		resizable : true, align:'center',    width:'100px' },
             { name:'chnlNm',   		index:'b.chnl_nm',  		resizable : true, align:'center',    width:'100px' },
             { name:'pointContType',	index:'e.mark_name',  		resizable : true, align:'center',    width:'100px' },
             { name:'mbrbsStatus',  	index:'b.mbrbs_status_cd',  resizable : true, align:'center',    width:'70px' },
             { name:'bizrNo',   		index:'b.bizr_no',  		resizable : true, align:'center',    width:'100px' },
             { name:'reprNm',   		index:'b.repr_nm',  		resizable : true, align:'center',    width:'100px' },
             { name:'telNo',   			index:'b.tel_no',  			resizable : true, align:'center',    width:'100px', formatter :  setTelno},
             { name:'zipCd',   			index:'b.zip_cd',  			resizable : true, align:'center',    width:'70px' },
             { name:'adrDtl',   		index:'b.adr_dtl',  		resizable : true, align:'center',    width:'200px' },
             { name:'acrlRuleCd',   	index:'c.rule_cd',  		resizable : true, align:'center',    width:'70px' },
             { name:'acrlRuleTypeCd',   index:'c.rule_type_cd',  	resizable : true, align:'center',    width:'100px' },
             { name:'adjRuleCd',   		index:'d.rule_cd',  		resizable : true, align:'center',    width:'70px' },
             { name:'adjRuleTypeCd',   	index:'d.rule_type_cd',  	resizable : true, align:'center',    width:'150px' },

             { name:'rid',    index:'a.rid',    hidden : true}
        ],
        sortname: 'a.rid',
        autowidth : true ,

        sortorder: "desc"
    };

    chnlSubList = $("#chnlSubListGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdchnlSubList = $("#gridIdchnlSubList");
}
function autoHypenPhone(str){
	str = str.replace(/[^0-9]/g, '');
	var tmp = '';
	  if( str.length < 4){
	    return str;
	  }else if(str.length < 7){
	    tmp += str.substr(0, 3);
	    tmp += '-';
	    tmp += str.substr(3);
	    return tmp;
	  }else if(str.length < 10){
		  if(str.substr(0, 2)=="02"){
			  tmp += str.substr(0, 2);
			  tmp += '-';
			  tmp += str.substr(2, 3);
			  tmp += '-';
			  tmp += str.substr(5);
			  return tmp;
		  }else{
			  tmp += str.substr(0, 3);
			  tmp += '-';
			  tmp += str.substr(3, 3);
			  tmp += '-';
			  tmp += str.substr(6);
			  return tmp;
		  }
	  }else{
		  if(str.substr(0, 2)=="02"){
			  tmp += str.substr(0, 2);
			  tmp += '-';
			  tmp += str.substr(2, 4);
			  tmp += '-';
			  tmp += str.substr(6);
			  return tmp;
		  }else{
			  tmp += str.substr(0, 3);
			  tmp += '-';
			  tmp += str.substr(3, 4);
			  tmp += '-';
			  tmp += str.substr(7);
			  return tmp;
		  }

	  }
	  return str;
}

function setTelno(cellvalue, options, rowObjec){
    var telNo = rowObjec.telNo;
    var rtnVal= null;
    if(telNo){
		rtnVal = autoHypenPhone(telNo);
    }else{
    	rtnVal = "";
    }

    return rtnVal;
}



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

