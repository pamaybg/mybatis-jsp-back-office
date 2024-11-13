<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    <div id="mbrCouponHistListGrid"></div>
       
    <div class="pop_btn_area">
		<button class="btn btn-sm btn_gray btn_lightGray2" id="cpnHistListClosePopBtn" objCode="mbrOldCouponClose_OBJ">
			<spring:message code="L01781"/>
		</button>
	</div>
	
 <script id="dcValueTemplate" type="text/x-jquery-tmpl">
	{{if dcUnit != null}}
		{{if dcUnit == '정액' }}
			<div>{{:dcValue}}원</div>
		{{/if}}
		{{if dcUnit == '정률' }}
			<div>{{:dcValue}}%</div>
		{{/if}}
	{{/if}}
</script>

<script type="text/javascript">

function getmbrCouponSearchListPopCon(){

    var ejGridOption = {
    	serializeGridData : function(data) {
		data.ridMbr = mbr_rid;
		data.rid = mbr_rid;
		data.intRidMbr = mbr_rid;
		data.mbrStatCd = $("#mbrStatCd").val();
		return data;
		},
        dataUrl : '<ifvm:action name="getOnlineMallCouponHistList"/>',
        columns : [
        {
            	field : 'cpnNo', headerText : '쿠폰번호', headerTextAlign : 'center', width:'70px', textAlign : 'center', customAttributes :{searchable : true}
         },
        {
        	field : 'cpnKind', headerText : '종류', headerTextAlign : 'center', width:'80px', textAlign : 'center'
         },{
          	field : 'cpnMethod', headerText : '발급방법', headerTextAlign : 'center', width:'70px', textAlign : 'center'
         },{
           	field : 'cpnSummary', headerText : '쿠폰요약설명', headerTextAlign : 'center', width:'90px', textAlign : 'center'
         },{
            	field : 'cpnNm', headerText : '쿠폰명', headerTextAlign : 'center', width:'150px', textAlign : 'left', customAttributes :{searchable : true}
          },{
             	field : 'dcUnit', headerText : '할인유형', headerTextAlign : 'center', width:'70px', textAlign : 'center'
           },{
              	field : 'dcValue', headerText : '할인액(율)', headerTextAlign : 'center', width:'70px', textAlign : 'center', template: "#dcValueTemplate"
           },{
              	field : 'cpnUseYN', headerText : '사용여부', headerTextAlign : 'center', width:'70px', textAlign : 'center'
           },{
              	field : 'regDate', headerText : '등록일자', headerTextAlign : 'center', width:'70px', textAlign : 'center'
           }
        ],

        requestGridData : {
       nd   : new Date().getTime(),
       rows : 10,
       sidx : 'regDate',
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

	getmbrCouponSearchListPopCon();
	//optionField();
	
	$("#cpnHistListClosePopBtn").click(function(){
		mbrCouponListSearchPopClose();
    });



});
</script>
