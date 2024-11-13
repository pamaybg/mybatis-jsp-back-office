<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="addChnlSettle" text="신규" btnFunc="" objCode=""/>
			<ifvm:inputNew type="button" id="chnlSettleHist" text="이력" btnFunc="" objCode=""/>
        </div>
    </div>
    <div id="chnlSettleListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="addChnlSettlePop" class="popup_container"></div>
<div id="chnlSettleHistPop" class="popup_container"></div>

<script type="text/javascript">
var chnlSettleRid;

function getChnlSettleList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.chnlRid = channelDetail_rid;
			return data;
		},
		recordDoubleClick : function (args) {
   			chnlSettleRid = args.data.rid;
   	    	chnlSettleDetail();
        },
        dataUrl : '<ifvm:action name="getChnlSettleList"/>',

        columns : [
        	{
      		  field : 'pgmNm', headerText : '로열티프로그램명', headerTextAlign : 'center', width:'300px', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'chnlSettleTypeCdNm', headerText : '정산유형', headerTextAlign : 'center', textAlign : 'center' , customAttributes : { index : 'chnlSettleTypeCd'}
    	  },{
    		  field : 'hqRate', headerText : '본사분담율(%)', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'chnlRate', headerText : '채널분담율(%)', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'settleStartDate', headerText : '정산윻시작일', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
    		  field : 'createDate', headerText : '등록일시', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'chnlPgmRid', headerText : 'chnlPgmRid',visible : false 
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '6',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    chnlSettleListGrid = $("#chnlSettleListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function chnlSettleDetail() {
	addChnlSettlePopup();
}

function addChnlSettlePopup() {
	$("#addChnlSettlePop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addChnlSettlePop"/>',
        contentType: "ajax",
        title: '채널 정산 신규 등록',
        width: 800,
        close : 'addChnlSettleClosePop'
	});
}

function chnlSettleHistPopup() {
	$("#chnlSettleHistPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlSettleHistPop"/>',
        contentType: "ajax",
        title: '채널 정산 이력 조회',
        width: 870,
        close : 'chnlSettleHistClosePop'
	});
}

function addChnlSettleClosePop() {
	addChnlSettlePop._destroy();
}

function chnlSettleHistClosePop() {
	chnlSettleHistPop._destroy();
}

$(document).ready(function(){
	getChnlSettleList();
	
	$("#addChnlSettle").click(function() {
		chnlPgmRid = null;
		addChnlSettlePopup();
	});
	
	$("#chnlSettleHist").click(function() {
		if(chnlSettleListGrid.opt.gridControl.getSelectedRecords().length==0) {
			alert('<spring:message code="I00728"/>');
			return;
		}
		chnlSettleHistPopup();
	});

});

</script>