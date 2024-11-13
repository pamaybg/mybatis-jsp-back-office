<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <div class="page_btn_area" >
    <div class="col-xs-7">
	</div>
    </div>
    <div id="mbrDorHistList" class="white_bg grid_bd0"></div>
<%-- <div class="form-horizontal underline top_well" id="chnlSettleAddForm">
<br>
	<div class="row qt_border">
				<ifvm:inputNew type="textarea" maxLength="150" id="tierMnlReasonDesc" disabled="true" dto="tierMnlReasonDesc" label="변경사유" labelClass="2" conClass="9" rows="5"/>
	
	</div>

	<div class="row qt_border">
				<ifvm:inputNew type="text" id="approvalResNm" names="approvalResNm" label="결제요청자" disabled="true" labelClass="2" conClass="3" />
				<ifvm:inputNew type="text" id="approvalResDate" names="approvalResDate" label="결재요청일자" disabled="true" labelClass="2" conClass="3" />
				
	</div>
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="approvalReqNm" names="approvalReqNm" label="승인자"  disabled="true" labelClass="2" conClass="3" />
				<ifvm:inputNew type="text" id="approvalReqNm" names="approvalReqDate" label="승인일자" disabled="true" labelClass="2" conClass="3" />
	</div>

</div> --%>
<div class="pop_btn_area">

	<!-- 닫기 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="mbrDorHistPopCancle" objCode="mbrDorHistPopCancle_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>
<div id="tierHistDetailPop" class="popup_container"></div>

<script type="text/javascript">
var mbrDorHistList = null;
function getMbrDorHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.rid = mbr_rid;
			return data;
		},rowSelected : function(args){
       	},
		dataUrl : '<ifvm:action name="getMbrDorHistList"/>',

        columns : [
        	{
        	  field : 'dorHistTypeCdNm', headerText : '유형', headerTextAlign : 'center', textAlign : 'center',width:'80px', customAttributes :{index : 'dorHistTypeCd'}
        	  },{
      		  field : 'dorProcTypeCdNm', headerText : '처리유형', headerTextAlign : 'center', textAlign : 'center',width:'80px', customAttributes :{index : 'dorProcTypeCd'}
      	  },{
      		  field : 'regDate', headerText : '처리일', headerTextAlign : 'center', textAlign : 'center' ,width:'80px',
      	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '3',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
        tempId : 'ifvGridSimplePageTemplete'
    };
    mbrDorHistList = $("#mbrDorHistList").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	getMbrDorHistList();
	
	$("#mbrDorHistPopCancle").click(function(){
		mbrDorHistPopClose();
	});
	
});

</script>