<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var stmpItemList;

function getStmpItemList(){
    var ejGridOption = {
    	recordDoubleClick : function (args) {
    		var stmpStatus = $('#stmpStatus').val();
    		if(stmpStatus != 'A') {
	    		goStmpItemDetailPop();
    		}
        },
       serializeGridData : function( data ){
			data.ridStmp = ridStmp;
			return data;
        },
//         loadComplete : function(obj){
//         },
        dataUrl : '<ifvm:action name="getLoyStmpItemList"/>',
        columns:[
        	{
	      		  field : 'itemNo', headerText : '번호', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'lsi.ITEM_NO' }
	      	  },{
	      		  field : 'stmpAmt', headerText : '구매금액', headerTextAlign : 'center', textAlign : 'right', width : '100px', format : "{0:n0}",
	      		  customAttributes : {
	      			  index : 'lsi.STMP_AMT' }
	      	  },{
	      		  field : 'stmpCnt', headerText : '구매횟수', headerTextAlign : 'center', textAlign : 'right', width : '100px', format : "{0:n0}",
	      		  customAttributes : {
	      			  index : 'lsi.STMP_CNT' }
	      	  },{
	      		  field : 'camNo', headerText : '캠페인코드', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'lsi.CAM_NO' }
	      	  },{
	      		  field : 'camNm', headerText : '캠페인명', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 'mcm.CAM_NM' }
	      	  },{
	      		  field : 'itemBnftNm', headerText : '혜택명', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 'itemBnftNm', searchable : false, sortable : false }
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 'lsi.rid' }
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'lsi.ITEM_NO',
	      	  sord : 'asc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
    };
    stmpItemList = $("#stmpItemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//스탬프아이템 상세 팝업 호출
function goStmpItemDetailPop() {
	var _selectedRow = stmpItemList.opt.gridControl.getSelectedRecords()[0];
	if($.fn.ifvmIsNotEmpty(_selectedRow)) {
		$("#stmpItemDetailPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="stmpItemDetailPop"/>?rid=' + _selectedRow.rid,
	        contentType: "ajax",
	        title: '구간별 스탬프 상세',
	        width: 600,
	        close : 'stmpItemDetailPopClose'
	    });
	}
}

function stmpItemDetailPopClose() {
	stmpItemDetailPop._destroy();
}

$(document).ready(function() {

	$.ifvmLnbSetting('stmpList');

	setEnableInputAtDetail();
	getStmpItemList();
});
</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button" text="M00259"  id="stmpItemDetailBtn" btnFunc="goStmpItemDetailPop" objCode="stmpItemDetailBtn_OBJ"/>
<%--  			<ifvm:inputNew type="button" btnType="search" text="혜택조회" nuc="true" id="campaignListBtn" btnFunc="goCampaginList"/> --%>
        </div>
    </div>
    <div id="stmpItemListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="stmpItemDetailPop" class="popup_container"></div>
