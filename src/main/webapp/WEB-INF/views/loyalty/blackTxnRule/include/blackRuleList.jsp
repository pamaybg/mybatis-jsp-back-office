<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        	<span><spring:message code="이상거래 룰"/></span>
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="addBlackRuleBtn" text="신규" objCode="blackRuleListAdd_OBJ"/>
			<ifvm:inputNew type="button" id="removeBlackRuleBtn" text="삭제" objCode="blackRuleListRemove_OBJ"/>
        </div>
    </div>
    <div id="blackRuleList" class="white_bg grid_bd0"></div>
</div>

<div id="addBlackRuleDetailPop" class="popup_container"></div>

<script type="text/javascript">
var blackRuleRid;

function getBlackRuleListTab (){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.blackTxnRid = blackRuleDetail_rid;
			return data;
		},
		recordDoubleClick : function (args) {
			blackRuleRid = args.data.rid;
			addBlackRulePopup();
        },rowSelected : function(args){
        	blackRuleRid = args.data.rid;
       	},
        dataUrl : '<ifvm:action name="getBlackRuleListTab"/>',

        columns : [
        	{
      		  field : 'baseTypeNm', headerText : '기준유형',textAlign : 'center' , headerTextAlign : 'center', width:'60px',customAttributes : {index : 'baseType'}
      	  },{
    		  field : 'gtOrEt', headerText : '횟수', headerTextAlign : 'center', width:'60px', textAlign : 'right' ,customAttributes : {searchable : true}
    	  },{
    		  field : 'basDayCnt', headerText : '기준(일/월)', headerTextAlign : 'center', width:'60px', textAlign : 'right'
    	  },{
    		  field : 'basDayMmCdNm', headerText : '추출기간', headerTextAlign : 'center', width:'60px', textAlign : 'center' ,customAttributes : {index : 'basDayMmCd'}
    	  },{
    		  field : 'calc', headerText : '기준 정책', headerTextAlign : 'center', width:'180px', textAlign : 'center'
    	  },{
    		  field : 'createBy', headerText : '등록자', headerTextAlign : 'center', width:'80px', textAlign : 'center',customAttributes : {searchable : true}
    	  },{
    		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', width:'100px', textAlign : 'center'
    	  },{
    		  field : 'blackTxnRid', headerText : 'blackTxnRid',visible : false 
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '7',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    blackRuleList = $("#blackRuleList").ifvsfGrid({ ejGridOption : ejGridOption });
}


function addBlackRulePopup() {
	$("#addBlackRuleDetailPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addBlackRuleDetailPop"/>',
        contentType: "ajax",
        title: '이상거래룰 등록',
        width: 800,
        close : 'addBlackRuleDetailClosePop'
	});
}
function addBlackRuleDetailClosePop() {
	addBlackRuleDetailPop._destroy();
}

function removeBlackRule() {
	 var v_rid;
	    if ($.fn.ifvmIsNotEmpty(blackRuleList.opt.gridControl.getSelectedRecords()[0])) {
	    	v_rid = blackRuleList.opt.gridControl.getSelectedRecords()[0].rid;
	    }
	    else {
	        alert('<spring:message code="M02219"/>');
	    }

	    if ($.fn.ifvmIsNotEmpty(v_rid)) {
	    	if( confirm('<spring:message code="I01500"/>') == true ){
	        $.ifvSyncPostJSON('<ifvm:action name="removeBlackRule"/>', {
	            rid: v_rid
	        },
	        function(result) {
	        	blackRuleList._doAjax();
				alert('<spring:message code="I00726"/>');
	        });
	    }
	}
}

$(document).ready(function(){
	getBlackRuleListTab();
	
	$("#addBlackRuleBtn").click(function() {
		if(statCd=='A') {
			alert("비활성일때만 신규가 가능합니다.");
			return;
		} 
		blackRuleRid=null;
		addBlackRulePopup();
	});
	
	
	$("#removeBlackRuleBtn").click(function() {
		if(statCd=='A') {
			alert("비활성일때만 삭제가 가능합니다.");
			return;
		} 
		removeBlackRule();
	});

});

</script>