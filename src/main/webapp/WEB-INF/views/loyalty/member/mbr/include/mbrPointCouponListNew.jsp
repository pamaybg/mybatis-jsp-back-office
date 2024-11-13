<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-5">
        </div>
        <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="pointInfoPopBtn" text="유의사항 조회" nuc="true" btnFunc="mbrPointCouponObj.openPointCouponPop"/>
        </div>
    </div>
    <div id="mbrPointCouponListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="pointCouponPop" class="popup_container"></div>

<script type="text/javascript">

var mbrPointCouponList;

var mbrPointCouponObj = {
	//스탬프 이력 그리드
	initMbrPointCouponList : function(data) {
		var ejGridOption = {
	       	serializeGridData : function(data) {
	       	data.ridMbr = gMbrDetail.data.rid;
	       	},
	        dataUrl : '<ifvm:action name="getMbrPointCouponList"/>',
	        columns:[
	        		{
	         		  field : 'couponNm', headerText : '포인트 쿠폰명', headerTextAlign : 'center', textAlign : 'left', width : '200px',
	         		  customAttributes : {
	         			  index : 'couponNm' }
	         	  },{
	         		  field : 'useStartDt', headerText : '쿠폰 유효시작일', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	         		  customAttributes : {
	         			  index : 'useStartDt' }
	         	  },{
	         		  field : 'useEndDt', headerText : '쿠폰 유효종료일', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	         		  customAttributes : {
	         			  index : 'useEndDt' }
	         	  },{
	         		  field : 'selfTotAmt', headerText : '혜택포인트', headerTextAlign : 'center', textAlign : 'right', width : '100px',  format : '{0:n0}',
	         		  customAttributes : {
	         			  index : 'selfTotAmt' }
	         	  },{
	         		  field : 'useYn', headerText : '사용여부', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	         		  customAttributes : {
	         			  index : 'useYn' }
	         	  },{
	         		  field : 'recpDt', headerText : '쿠폰 발행일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	         		  customAttributes : {
	         			  index : 'recpDt' }
	         	  },{
	         		  field : 'pointDt', headerText : '포인트 전환일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	         		  customAttributes : {
	         			  index : 'pointDt' }
	         	  },{
	         		  field : 'pointStartDt', headerText : '포인트 유효 시작일', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	         		  customAttributes : {
	         			  index : 'pointStartDt' }
	         	  },{
	         		  field : 'pointEndDt', headerText : '포인트 유효 종료일', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	         		  customAttributes : {
	         			  index : 'pointEndDt' }
	         	  },{
		      		  field : 'coupnRid', headerText : 'coupnRid', visible : false ,
		      		  customAttributes : {
		      			searchable : false,
		      			  index : 'coupnRid' }/* */
		      	  },
	         ],
	         requestGridData : {
	        	 nd   : new Date().getTime(),
	        	 rows : 10,
	        	 sidx : 'recpDt',
	        	 sord : 'desc',
	        	 _search : false
			},
			radio : true
	    }

		mbrPointCouponList = $("#mbrPointCouponListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	},
	//포인트쿠폰 유의사항 팝업
	openPointCouponPop : function(data) {
		var _selectedRow = mbrPointCouponList.opt.gridControl.getSelectedRecords()[0];
		if($.fn.ifvmIsNotEmpty(_selectedRow)) {
			$("#pointCouponPop").ifvsfPopup({
				enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="mbrPointCouponPop"/>?coupnRid=' + _selectedRow.coupnRid,
		        contentType: "ajax",
		        title: '포인트쿠폰 유의사항',
		        width: 370,
		        close : 'pointCouponPopClose'
		    });
		} else {
			alert('<spring:message code="L00066"/>');
		}
	},
}

function pointCouponPopClose() {
	pointCouponPop._destroy();
}
$(document).ready(function(){
	mbrPointCouponObj.initMbrPointCouponList();
	window.top.setParentIframeHeight();
});

</script>