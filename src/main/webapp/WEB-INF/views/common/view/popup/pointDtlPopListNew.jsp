<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var pointDtlPopList;
//포인트 상세 내역 그리드 출력
function pointDtlPopList() {

    var ejGridOption = {
        serializeGridData : function(data) {
            data.rid = rid;
            return data;
        },
        dataUrl : '<ifv:action name="getPointDtlPopupList"/>',
        columns:[
        	{
	      		  field : 'camNm', headerText : '<spring:message code="M02619"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 't2.cam_nm' }/*프로모션명 */
// 	      	  },{
// 	      		  field : 'offerNm', headerText : '<spring:message code="M01870"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 't3.offer_nm' }/*오퍼명 */
// 	      	  },{
// 	      		  field : 'offerTypeCdNm', headerText : '<spring:message code="M01872"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 'c1.mark_name' }/*오퍼유형명 */
// 	      	  },{
// 	      		  field : 'validStartDate', headerText : '<spring:message code="L00537"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 't1.valid_start_date' }/*시작일자 */
// 	      	  },{
// 	      		  field : 'validEndDate', headerText : '<spring:message code="L00538"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 't1.valid_end_date' }/*종료일자 */
	      	  },{
	      		  field : 'acrlAmt', headerText : '<spring:message code="M02102"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 't1.acrl_amt' }/*포인트 */
	      	  },{
	      		  field : 'validDate', headerText : '포인트 유효기간', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 't1.VALID_START_DATE' }/*포인트 유효기간*/
// 	      	  },{
// 	      		  field : 'giftPntYn', headerText : '<spring:message code="L00540"/>', headerTextAlign : 'center',
// 	      		  customAttributes : {
// 	      			  index : 't1.gift_pnt_yn' }/*선물가능여부 */
	      	  },{
	      		  field : 'pntAccntBigTypeCdNm', headerText : '지급계정 대분류', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c9.MARK_NAME' }/*지급계정 대분류 */
	      	  },{
	      		  field : 'pntAccntMidTypeCdNm', headerText : '지급계정 중분류', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c10.MARK_NAME' }/*지급계정 중분류*/
	      	  },{
	      		  field : 'pntAccntSmlTypeCdNm', headerText : '지급계정 소분류', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c11.MARK_NAME' }/*지급계정 소분류*/
	      	  },{
	      		  field : 'pntAccntDetailTypeCdNm', headerText : '지급계정 세분류', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'c12.MARK_NAME' }/*지급계정 세분류*/
		      },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 't2.cam_nm',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
    };

    pointDtlPopList = $("#pointDtlPopList").ifvsfGrid({
        ejGridOption : ejGridOption
    });
}

//선물가능여부 출력
function setGiftPntValue (cellValue, options, rowdata) { 
    return cellValue == null && cellValue == "Y" ? '<spring:message code="L00541"/>' : '<spring:message code="L00539"/>';
}

$(document).ready(function() {
    pointDtlPopList();
    $("#btnSelect").on('click', function() {
        pointDataArr = null;
        if (pointDtlPopList.opt.gridControl.getSelectedRecords() == '') {
            alert('<spring:message code="M00285"/>');
        }
        else {
            var dataArr = pointDtlPopList.opt.gridControl.getSelectedRecords();
            // $("#pointNm").val(dataArr[0].pointNm).text(dataArr[0].rid);
            pointDataArr = dataArr;
            pointPopupClose();
        }
    });

    $("#btnCancel").on('click', function() {
        pointDataArr = null;
        pointDtlPopClose();
    });
});
</script>

<div id='pointDtlPopFormArea'>
<!-- 	<div class="pop_inner_wrap"> -->
		<div id="pointDtlPopList" class="grid_bd0 grid_w980"></div>
<!-- 	</div> -->
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_lightGray2" id="btnCancel">         
			<spring:message code="M00441"/>
	    </button>
	</div>
</div>
