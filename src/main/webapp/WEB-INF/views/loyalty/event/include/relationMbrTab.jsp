<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrLinkTemplate">
		<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:mbrRid}}" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>
<script type="text/javascript">
var relationMbrList;

function getRelationMbrList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		data.rid = storeRid;
	            return data;
	       	},
	       	rowSelected : function(args){
	       	},
	       	dataUrl : '<ifvm:action name="getRelationMbrList"/>',
	        columns:[ 
	        	  {
		      		  field : 'mbrRid', headerText : 'rid', visible : false,
		      		  customAttributes : {
		      			  index : 'mbrRid' }/* rid */
		      	  },{
		      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center', width:'80px',template: "#mbrLinkTemplate",
		      		  customAttributes : {
		      			  index : 'lm.MBR_NO'} /* 회원번호 */
		      	  },{
		      		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'custNm'} /* 회원명 */
		      	  },{
		      		  field : 'hhpNo', headerText : '전화번호', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : 'hhpNo'} /* 전화번호 */
		      	  },{
		      		  field : 'webId', headerText : '웹아이디', headerTextAlign : 'center', textAlign : 'center',  width:'100px',
		      		  customAttributes : {
		      			  index : 'lm.WEB_ID'}/* 웹아이디 */
		      	  },{
		      		  field : 'mbrStatus', headerText : '회원상태', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      		  customAttributes : {
		      			  index : "c1.MARK_NAME" }/* 회원상태 */
		      	  }
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : "lm.MBR_NO",
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true,
	        tempId : 'ifvGridSimplePageTemplete'
	    };
	relationMbrList = $("#getRelationMbrGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//마스킹해제
function clearRelationMaskAction() {
    var v_rid;
    if ($.fn.ifvmIsNotEmpty(relationMbrList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = relationMbrList.opt.gridControl.getSelectedRecords()[0].mbrRid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
        $.ifvSyncPostJSON('<ifvm:action name="getRelationClearMask"/>', {
            rid: v_rid
        },
        function(result) {
        	var gridObj = relationMbrList.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhpNo'),  result.hhpNo);
        });
    }
}

$(document).ready(function() {
	getRelationMbrList();
});

</script>

<div id="">
    <div class="page_btn_area" id=''>
    	<div class="col-sm-7">
    	</div>
        <div class="col-sm-5 searchbtn_r">
       		 <ifvm:inputNew type="button" text="D10091" id="relationMaskBtn" btnFunc="clearRelationMaskAction" />
        </div>
    </div>
</div>
<div id="getRelationMbrGrid" class="white_bg grid_bd0"></div>
