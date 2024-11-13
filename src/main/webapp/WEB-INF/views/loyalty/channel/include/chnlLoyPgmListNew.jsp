<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        <span><spring:message code="L02701"/></span>
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="addChnlLoyPgm" text="신규" objCode="chnlLoyPgmListNewAddChnlLoyPgm_OBJ"/>
			<ifvm:inputNew type="button" id="removeChnlLoyPgm" text="삭제" objCode="chnlLoyPgmListNewRemoveChnlLoyPgm_OBJ"/>
			<ifvm:inputNew type="button" id="chnlLoyPgmHistHist" text="이력" objCode="chnlLoyPgmListNewChnlLoyPgmHistHist_OBJ"/>
        </div>
    </div>
    <div id="chnlLoyPgmListGrid" class="white_bg grid_bd0"></div>
	<div id="addChnlLoyPgmPop" class="popup_container"></div>
	<div id="chnlLoyPgmHistPop" class="popup_container"></div>
</div>


<script type="text/javascript">
var pgmRid;
var chnlPgmRid;
var rid;
function getChnlLoyPgmList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.chnlRid = channelDetail_rid;
			return data;
		},
		recordDoubleClick : function (args) {
			rid = args.data.rid;
   			pgmRid = args.data.pgmRid;
   			chnlPgmRid = args.data.rid;
   	    	chnlLoyPgmDetail(pgmRid);
        },rowSelected : function(args){
        	pgmRid = args.data.pgmRid;
       	},
        dataUrl : '<ifvm:action name="getChnlLoyPgmList"/>',

        columns : [
        	{
      		  field : 'pgmNo', headerText : '프로그램ID', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'pgmNm', headerText : '프로그램명', headerTextAlign : 'center', width:'300px' ,customAttributes :{searchable : true}
    	  },{
    		  field : 'useYn', headerText : '사용여부', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'pntAcrlYn', headerText : '포인트적립', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'pntRdmYn', headerText : '포인트사용', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'evtYn', headerText : '이벤트참여', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'pgmRid', headerText : 'pgmRid',visible : false 
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '1',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    chnlLoyPgmListGrid = $("#chnlLoyPgmListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function chnlLoyPgmDetail(pgmRid) {
	addChnlLoyPgmPopup();
}

function addChnlLoyPgmPopup() {
	$("#addChnlLoyPgmPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addChnlLoyPgmPop"/>',
        contentType: "ajax",
        title: '로열티 프로그램 신규',
        width: 600,
        close : 'addChnlLoyPgmClosePop'
	});
}

function chnlLoyPgmHistPopup() {
	$("#chnlLoyPgmHistPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlLoyPgmHistPop"/>',
        contentType: "ajax",
        title: '채널 프로그램 이력',
        width: 1000,
        close : 'chnlLoyPgmHistClosePop'
	});
}

function addChnlLoyPgmClosePop() {
	addChnlLoyPgmPop._destroy();
}

function chnlLoyPgmHistClosePop() {
	chnlLoyPgmHistPop._destroy();
}

function removeChnlLoyPgm() {
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(chnlLoyPgmListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = chnlLoyPgmListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeChnlLoyPgm"/>', {
            rid: v_rid
        },
        function(result) {
        	chnlLoyPgmListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

$(document).ready(function(){
	getChnlLoyPgmList();
	$("#addChnlLoyPgm").click(function() {
		pgmRid=null;
		chnlPgmRid=null;
		addChnlLoyPgmPopup();
	});
	
	$("#chnlLoyPgmHistHist").click(function() {
		if(chnlLoyPgmListGrid.opt.gridControl.getSelectedRecords().length==0) {
			alert('<spring:message code="I00728"/>');
			return;
		}
		chnlLoyPgmHistPopup();
	});
	
	$("#removeChnlLoyPgm").click(function() {
		removeChnlLoyPgm();
	});

});

</script>