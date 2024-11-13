<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

/** 
 * 채널목록 조회
 */
function getuseDeskChannelList() {
    
    var ejGridOption = {
   		recordDoubleClick : function(args) {
            var data = args.data;
            rid = data.rid;
        },
//         onSelectRow : function(data) {
//         },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
//         loadComplete : function(obj) {
//         },
        dataUrl : '<ifvm:action name="getChannelList"/>',
        columns:[ 
        	{ type:"checkbox", width: 50},
        	{
        		  field : 'ouTypeCd', headerText : '<spring:message code="L00630"/>', headerTextAlign : 'center',
        		  customAttributes : {
        			  searchable : false,
        			  index : 'a.ou_type_cd' } //
        	  },{
          		  field : 'chnlNo', headerText : '<spring:message code="L00564"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.chnl_no' } //
          	  },{
          		  field : 'chnlNm', headerText : '<spring:message code="V00022"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'a.chnl_nm' } //
          	  },{
          		  field : 'stnMgmtDiv', headerText : '<spring:message code="M02283"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'e.div_nm' } //
          	  },{
          		  field : 'parChnlNm', headerText : '<spring:message code="L00621"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'b.chnl_nm' } //
          	  },{
          		  field : 'pointContType', headerText : '<spring:message code="L00626"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  searchable : false,
          			  index : 'g.mark_name' } //
          	  },{
          		  field : 'rid', headerText : 'rid', visible : false ,
          		  customAttributes : {
          			  index : 'a.rid' } //
          	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'a.rid',
      	  sord : 'desc',
      	  _search : false
        },
        
        rowList : [10,25,50,100],
//         radio: true,
  	    tempId : 'ifvGridOriginTemplete'
//         multiselect: true, 
    };

    useDeskChannelList = $("#useDeskChannelListGrid").ifvsfGrid({
        ejGridOption : ejGridOption
    });
    gridIduseDeskChannelList = $("#useDeskChannelListGrid");
    gridIduseDeskChannelList.resize();
}

$(document).ready(function() {
    getuseDeskChannelList();
    
    // 추가
    $("#useDeskAddBtn").on("click", function() {
        useDeskAdd();
    });
    
    // 취소 
    $("#useDeskPopCancelBtn").on("click", function() {
        useDeskPopClose();
    });
    
});

</script>

<div id="useDeskPopWrap">
    <div class="pop_inner_wrap form-horizontal" id="useDeskPop" >
        <div id="useDeskChannelListGrid"></div>
    </div>
    
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="useDeskAddBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2" id="useDeskPopCancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>
<div id="loyChannelListPopup"></div>