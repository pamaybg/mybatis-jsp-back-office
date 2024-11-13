<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <div id="mbrCouponHistListGrid"></div>
       
    <div class="pop_btn_area">
		<button class="btn btn-sm btn_gray btn_lightGray2" id="cpnHistListClosePopBtn">
			<spring:message code="L01781"/>
		</button>
	</div>
	
 <script id="valueTemplate" type="text/x-jquery-tmpl">
		{{if saleType == 'percent' }}
			<div>{{:valAmt}}%</div>
		{{/if}}
		{{if saleType == 'won' }}
			<div>{{:valAmt}}원</div>
		{{/if}}
</script>

<script type="text/javascript">

function getmbrNewmallCouponList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
		data.ridMbr = mbr_rid;
		return data;
		},
        dataUrl : '<ifvm:action name="getNewMallCouponList"/>',
        columns : [
        {
        	field : 'cpnCtgCdNm', headerText : '쿠폰종류', headerTextAlign : 'center', width:'60px', textAlign : 'center', customAttributes : {index : 'cpnCtgCd'} 
         },{
          	field : 'cpnTypeCdNm', headerText : '발급방법', headerTextAlign : 'center', width:'60px', textAlign : 'center', customAttributes : {index : 'cpnTypeCd'} 
         },{
           	field : 'cpnDesc', headerText : '쿠폰요약설명', headerTextAlign : 'center', width:'110px', textAlign : 'center'
         },{
            	field : 'cpnNm', headerText : '쿠폰명', headerTextAlign : 'center', width:'130px', textAlign : 'left', customAttributes :{searchable : true}
          },{
            	field : 'ofrNo', headerText : '쿠폰마스터번호', headerTextAlign : 'center', width:'80px', textAlign : 'center', customAttributes :{searchable : true, index:'llcmt.SRC_IDX'}
          },{
            	field : 'cpnNo', headerText : '쿠폰번호', headerTextAlign : 'center', width:'60px', textAlign : 'center', customAttributes :{searchable : true, index:'llcmt.SRC_IDX'}
          },{
             	field : 'issuDate', headerText : '발급일자', headerTextAlign : 'center', width:'80px', textAlign : 'center'
           },{
              	field : 'valAmt', headerText : '할인액(율)', headerTextAlign : 'center', width:'70px',format : '{0:n0}', textAlign : 'center', template: "#valueTemplate"
           },{
              	field : 'minPurAmt', headerText : '최소구매금액', headerTextAlign : 'center', width:'90px', textAlign : 'right',format : '{0:n0}'
           },{
              	field : 'maxDcAmt', headerText : '최대할인금액', headerTextAlign : 'center', width:'90px', textAlign : 'right',format : '{0:n0}'
           },{
              	field : 'useStatusNm', headerText : '사용여부', headerTextAlign : 'center', width:'60px', textAlign : 'center', customAttributes : {index : 'useStatus'} 
           },{
              	field : 'useDate', headerText : '사용일자', headerTextAlign : 'center', width:'80px', textAlign : 'center', customAttributes : {index : 'useDate'} 
           }
        ],

        requestGridData : {
       nd   : new Date().getTime(),
       rows : 10,
       sidx : 'issuDate',
       sord : 'desc',
       _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
    };

    mbrCouponSearchListPopCon = $("#mbrCouponHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

/* function optionField(){
	this.optionField= [
		{fieldName:"cpnUseYN", commCode:"LOY_CPN_USE_YN"},
		{fieldName:"cpnKind", commCode:"LOY_CPN_KIND"},
		{fieldName:"cpnMethod", commCode:"LOY_CPN_METHOD"},
		{fieldName:"dcUnit", commCode:"LOY_CPN_DISCOUNT_UNIT"}
	]
}
 */

$(document).ready(function(){

	getmbrNewmallCouponList();
	//optionField();
	
	$("#cpnHistListClosePopBtn").click(function(){
		mbrNewCouponListSearchPopClose();
    });



});
</script>
