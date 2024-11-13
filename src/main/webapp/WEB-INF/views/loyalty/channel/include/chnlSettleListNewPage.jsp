<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        	<span><spring:message code="L02784"/></span>
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="addChnlSettle" text="신규" objCode="chnlSettleListNewPageAddChnlSettle_OBJ"/>
			<ifvm:inputNew type="button" id="removeChnlSettle" text="삭제" objCode="chnlSettleListNewRemoveChnlSettle_OBJ"/>
			<ifvm:inputNew type="button" id="chnlSettleHist" text="이력" objCode="chnlSettleListNewPageChnlSettleHist_OBJ"/>
        </div>
    </div>
    <div id="chnlSettleListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="addChnlSettlePop" class="popup_container"></div>
<div id="chnlSettleHistPopup" class="popup_container"></div>

<script type="text/javascript">
var chnlSettleRid;

function getChnlSettleList (){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.chnlRid = channelDetail_rid;
			return data;
		},
		recordDoubleClick : function (args) {
			chnlSettleRid = args.data.rid;
			chnlSettleDetail();
        },rowSelected : function(args){
        	pgmRid = args.data.pgmRid;
       	},
        dataUrl : '<ifvm:action name="getChnlSettleList"/>',

        columns : [
        	{
      		  field : 'pgmNm', headerText : '로열티프로그램명', headerTextAlign : 'center', width:'250px', customAttributes :{searchable : true}
      	  },{
    		  field : 'chnlSettleTypeCdNm', headerText : '정산유형', headerTextAlign : 'center', width:'60px', textAlign : 'center' ,customAttributes : {index : 'chnlSettleTypeCd'}
    	  },{
    		  field : 'hqRate', headerText : '본사분담율', headerTextAlign : 'center', width:'80px', textAlign : 'center'
    	  },{
    		  field : 'chnlRate', headerText : '채널분담율', headerTextAlign : 'center', width:'80px', textAlign : 'center'
    	  },{
    		  field : 'settleStartDate', headerText : '정산율시작일', headerTextAlign : 'center', width:'100px', textAlign : 'center' 
    	  },{
    		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', width:'150px', textAlign : 'center'
    	  },{
    		  field : 'chnlPgmRid', headerText : 'chnlPgmRid',visible : false 
    	  },{
    		  field : 'pgmRid', headerText : 'pgmRid',visible : false 
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
        width: 600,
        close : 'addChnlSettleClosePop'
	});
}

function chnlSettleHistPop() {
	$("#chnlSettleHistPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlSettleHistPopup"/>',
        contentType: "ajax",
        title: '채널 정산 이력 조회',
        width: 930,
        close : 'chnlSettleHistClosePop'
	});
}



function addChnlSettleClosePop() {
	addChnlSettlePop._destroy();
}

function chnlSettleHistClosePop() {
	chnlSettleHistPopup._destroy();
}

function removeChnlSettle() {
	 var v_rid;
	    if ($.fn.ifvmIsNotEmpty(chnlSettleListGrid.opt.gridControl.getSelectedRecords()[0])) {
	    	v_rid = chnlSettleListGrid.opt.gridControl.getSelectedRecords()[0].rid;
	    }
	    else {
	        alert('<spring:message code="C00113"/>');
	    }

	    if ($.fn.ifvmIsNotEmpty(v_rid)) {
	    	if( confirm('<spring:message code="I01500"/>') == true ){
	        $.ifvSyncPostJSON('<ifvm:action name="removeChnlSettle"/>', {
	            rid: v_rid
	        },
	        function(result) {
	        	chnlSettleListGrid._doAjax();
				alert('<spring:message code="I00726"/>');
	        });
	    }
	}
}

$(document).ready(function(){
	getChnlSettleList();
	$("#addChnlSettle").click(function() {
		chnlSettleRid=null;
		addChnlSettlePopup();
	});
	
	$("#chnlSettleHist").click(function() {
		if(chnlSettleListGrid.opt.gridControl.getSelectedRecords().length==0) {
			alert('<spring:message code="I00728"/>');
			return;
		}
		chnlSettleHistPop();
	});
	
	$("#removeChnlSettle").click(function() {
		removeChnlSettle();
	});

});

</script>