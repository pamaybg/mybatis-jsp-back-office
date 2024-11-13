<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var chnlStlInfoList;
var gridIdchnlStlInfoList;
var rid ;

//사용 기준정보
function getchnlStlInfoListSearch(){
    var ejGridOption = {
   		recordDoubleClick : function(args){
            var data = args.data;
            rid = data.rid;
        },
        serializeGridData : function( data ){
    	   data.rid = channelDetail_rid;
           return data;
        },
        dataUrl : '<ifvm:action name="getChnlStlInfoList"/>',
        columns :[
        	{
	      		  field : 'mbrDivCd', headerText : '<spring:message code="L00557"/>', headerTextAlign : 'center', width:'100px',
	      		  customAttributes : {
	      			  index : 'd.mark_name' }/* */
	      	  },{
	      		  field : 'adjustDivCd', headerText : '<spring:message code="L00745"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'e.mark_name' }/* */
	      	  },{
	      		  field : 'adjustMethCd', headerText : '<spring:message code="L00746"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'f.mark_name' }/* */
	      	  },{
	      		  field : 'e1ShrexpnsRate', headerText : '<spring:message code="L00747"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'c.shrexpns_rate' }/* */
	      	  },{
	      		  field : 'partnerShrexpnsRate', headerText : '<spring:message code="L00748"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'c.partner_shrexpns_rate' }/* */
	      	  },{
	      		  field : 'grntMinAmt', headerText : '<spring:message code="L00749"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'c.grnt_min_amt' }/* */
	      	  },{
	      		  field : 'activeYn', headerText : '<spring:message code="M01139"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'c.active_yn' }/* */
	      	  },{
	      		  field : 'aplyStartDd', headerText : '<spring:message code="M00466"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'c.aply_start_dd' }/* */
	      	  },{
	      		  field : 'aplyEndDd', headerText : '<spring:message code="M00467"/>', headerTextAlign : 'center',width:'100px',
	      		  customAttributes : {
	      			  index : 'c.aply_end_dd' }/* */
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false ,
	      		  customAttributes : {
	      			  index : 'a.rid' }/* */
	      	  },
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'a.rid',
      	  sord : 'desc',
      	  _search : false
        },
        allowScrolling: true,
        rowList : [10,25,50,100],
    };
    

    chnlStlInfoList = $("#chnlStlInfoListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    gridIdchnlStlInfoList = $("#gridIdchnlStlInfoList");
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}
function goGridRowChnlLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}
function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';

    return tag;
}

//공통 조회 호출
function chnlStlInfoListSearch() {
    $.fn.ifvmSubmitSearchCondition("chnlStlInfoListSearchList", getchnlStlInfoListSearch);
}

function numberCommaForamtter(cellvalue, options, rowObjec){
    var pnt = rowObjec.acrlPntLmt;
    if (pnt!=null) {
        pnt = Math.round(pnt).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    } else {
        pnt='';
    }
    return pnt;
}

$(document).ready(function() {
    chnlStlInfoListSearch();
});

</script>


<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">

        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    </div>
    <div id="chnlStlInfoListGrid" class="white_bg grid_bd0"></div>
</div>

