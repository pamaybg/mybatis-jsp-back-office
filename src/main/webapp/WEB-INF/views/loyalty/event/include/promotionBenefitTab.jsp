<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var promotionBenefitGrid;

function getPromotionBenefitList(){
	var ejGridOption = {
	      	serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }
	      		data.rid = storeRid;
	            return data;
	       	},
	       	rowSelected : function(args){
	       	},
	       	dataUrl : '<ifvm:action name="getPromotionBenefitList"/>',
	        columns:[ 
	        	  {
		      		  field : 'rid', headerText : 'rid', visible : false,
		      		  customAttributes : {
		      			  index : 'lsp.RID' }/* rid */
		      	  },{
		      		  field : 'dispNo', headerText : 'ID', headerTextAlign : 'center', textAlign : 'center', width:'80px' ,
		      		  customAttributes : {
		      			  index : 'mcm.dispNo'} /* ID */
		      	  },{
		      		  field : 'camNm', headerText : '혜택명', headerTextAlign : 'center', textAlign : 'left', width:'200px' ,
		      		  customAttributes : {
		      			  index : 'mcm.CAM_NM'} /* 프로모션명 */
		      	  },{
		      		  field : 'benefitType', headerText : '혜택유형', headerTextAlign : 'center', textAlign : 'center', width:'50px' ,
		      		  customAttributes : {
		      			  index : 'cc1.MARK_NAME'} /* 혜택유형 */
		      	  },{
		      		  field : 'totAmt', headerText : '금액', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width:'80px' ,
		      		  customAttributes : {
		      			  index : 'mom.SELF_TOT_AMT'}/* 금액 */
		      	  },{
		      		  field : 'startDt', headerText : '시작일', headerTextAlign : 'center', textAlign : 'center', width:'80px' ,
		      		  customAttributes : {
		      			  index : 'mcm.CAM_START_DD' }/* 시작일 */
		      	  },{
		      		  field : 'endDt', headerText : '종료일', headerTextAlign : 'center', textAlign : 'center', width:'80px' ,
		      		  customAttributes : {
		      			  index : 'mcm.CAM_END_DD' }/* 종료일 */
		      	  }
	        ],
	        requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'mcm.DISP_NO',
		      	  sord : 'desc',
		      	  _search : false
		    },
		    rowList : [10,25,50,100],
	        autowidth : true ,
	        radio : true,
	        tempId : 'ifvGridSimplePageTemplete'
	    };
	promotionBenefitGrid = $("#promotionBenefitGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function promotionPopUp() {
    $("#popupContainer").ifvsfPopup({
      enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="storePromotionPop"/>',
        contentType: "ajax",
        title: '프로모션',
        width: '1000px',
        close : 'promotionPopUpClose'
    });
}

//프로모션 팝업 닫기
function promotionPopUpClose() {
	popupContainer._destroy();
}

function deleteStorePromotion(){
	rid = promotionBenefitGrid.opt.gridControl.getSelectedRecords()[0].rid;
	$.ifvSyncPostJSON('<ifvm:action name="deleteEventStorePnt"/>',{
	    rid : rid
	},function(result){
		getPromotionBenefitList();
	});
}

$(document).ready(function() {
	
	getPromotionBenefitList();
	
	storeTypeCheck();//스토어 유형별 validcheck
	
	$('#benefitNewBtn').on('click',function(){
		promotionPopUp()
	});
	
 	$('#benefitDelBtn').on('click', function(){
 		if(promotionBenefitGrid.opt.gridControl.getSelectedRecords()[0] == null){
    		alert('<spring:message code="L00117"/>');
    	}else{
    		deleteStorePromotion();
    	}
	});
});

</script>

<div id="evtApplicantForm">
    <div class="page_btn_area" id=''>
    	<div class="col-sm-7">
			<span>※ 일반정보를 저장후 혜택등록이 가능합니다.</span>    
    	</div>
        <div class="col-sm-5 searchbtn_r">
        	<button class="btn btn-sm" id="benefitNewBtn">
            	신규
            </button>
        	<button class="btn btn-sm" id="benefitDelBtn">
            	삭제
            </button>
        </div>
    </div>
    <div id="promotionBenefitGrid" class="white_bg grid_bd0"></div>
</div>
<div id="ImgViewPop" class="popup_container">
</div><!-- 팝업 -->