<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <%-- <div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="agreHistbtn" text="이력" btnFunc="" objCode=""/>
        </div> --%>
    </div>
    <div id="mbrCouponTxnHistListGrid" class="white_bg grid_bd0"></div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="closePopBtn" objCode="mbrCouponTxnHistClose_OBJ">
		<spring:message code="L00941" />
	</button>
</div>


<script type="text/javascript">
function getMbrCouponHistList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbrCouponRid;
			return data;
		},
        dataUrl : '<ifvm:action name="getMbrCouponTxnHistList"/>',

        columns : [
        	{
        		  field : 'cpnNo', headerText : '쿠폰번호', headerTextAlign : 'center', textAlign : 'center', width: '120px'
        	  },
        	{
      		  field : 'chnlTxnNo', headerText : '거래번호', headerTextAlign : 'center', textAlign : 'center', width: '220px'
      	  },{
    		  field : 'cpnOccurDt', headerText : '거래일시', headerTextAlign : 'center', textAlign : 'center', width: '140px'
    	  },
          {
    		  field : 'cpnTxnStateCdNm', headerText : '쿠폰 상태', headerTextAlign : 'center', textAlign : 'center', width: '65px'
    	  },{
    		  field : 'cpnUseChnlNo', headerText : '채널번호', headerTextAlign : 'center', textAlign : 'center', width: '75px'
    	  },{
    		  field : 'cpnUseChnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign : 'center', width: '95px'
    	  },{
    		  field : 'ridCpnTxn', headerText : '원거래번호', headerTextAlign : 'center', textAlign : 'center', width: '155px'
    	  },{
    		  field : 'createBy', headerText : '처리자', headerTextAlign : 'center', textAlign : 'center', width: '125px'
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'lcmh.CREATE_DATE',
      	  sord : 'desc',
      	  _search : false

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: false,
        tempId : 'ifvGridSimplePageTemplete2'
    };

    mbrCouponTxnHistListGrid = $("#mbrCouponTxnHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	getMbrCouponHistList();
	$("#closePopBtn").click(function(){
		mbrCouponTxnListPopClose();
    });
});

</script>