<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <div class="page_btn_area" >
    <div class="col-xs-7">
	</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="tierHistDetailPopBtn" text="사유"  objCode="tierHistListPopDetail_OBJ"/>
        </div>
    </div>
    <div id="mbrTierHistList" class="white_bg grid_bd0"></div>
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
	<button class="btn btn-sm btn_gray btn_lightGray2" id="modifyTierCancel" objCode="tierHistListPopCancel_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>
<div id="tierHistDetailPop" class="popup_container"></div>

<script type="text/javascript">
var mbrTierHistList = null;
var tierHistRid = null;
function getTierHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.tierGrpRid = tierGrpRid;
			data.tierRid = tierRid;
			data.rid = mbr_rid;
			return data;
		},rowSelected : function(args){
			tierHistRid = args.data.rid;
       	},
		dataUrl : '<ifvm:action name="getMbrTierHistListNew"/>',

        columns : [
        	{
      		  field : 'tierGrpNm', headerText : '등급그룹',width:'10px', headerTextAlign : 'center', width:'180px', textAlign : 'left', customAttributes :{searchable : true, index : 'ltg.TIERS_GRP_NM'}
      	  },{
    		  field : 'tierNm', headerText : '등급',width:'80px', headerTextAlign : 'center', textAlign : 'left', customAttributes :{searchable : true}
    	  },{
    		  field : 'tierTypeCd', headerText : '등급코드',width:'60px', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
      		  field : 'tierChgTypeCdNm', headerText : '유형',width:'70px', headerTextAlign : 'center', textAlign : 'center',customAttributes :{index : 'tierChgTypeCd'}
      	  },{
      		  field : 'tierChgRstCdNm', headerText : '결과',width:'80px', headerTextAlign : 'center', textAlign : 'center',customAttributes :{index : 'tierChgRstCd'}
      	  },{
      		  field : 'tierMnlReasonCdNm', headerText : '변경 사유',width:'70px', headerTextAlign : 'center', textAlign : 'center',customAttributes :{index : 'tierMnlReasonCd'}
    	  },{
    		  field : 'createBy', headerText : '등록자',width:'90px', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'createDate',width:'150px', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'tierGrpRid', headerText : 'tierGrpRid',visible : false 
    	  },{
    		  field : 'tierRid', headerText : 'tierRid',visible : false 
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  },{
    		  field : 'validHistYn', headerText : 'validHistYn',visible : false 
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '8,12',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
    };
    mbrTierHistList = $("#mbrTierHistList").ifvsfGrid({ ejGridOption : ejGridOption });
}

function tierHistDetailPopup() {
	if ($.fn.ifvmIsEmpty(mbrTierHistList.opt.gridControl.getSelectedRecords()[0])) {
		 alert('<spring:message code="목록을 선택해주세요."/>');
		 return;
   }
	$("#tierHistDetailPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierHistDetailPop"/>',
        contentType: "ajax",
        title: '등급 사유',
        width: 800,
        close : 'tierHistDetailClosePop'
	});
}

function tierHistDetailClosePop() {
	tierHistDetailPop._destroy();
}

$(document).ready(function(){
	getTierHistList();
	
	$("#modifyTierCancel").click(function(){
		tierHistListClosePop();
	});
	
	$("#tierHistDetailPopBtn").click(function(){
		tierHistDetailPopup();
	});
});

</script>