<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="addTierRulePop" class="popup_container"></div>
<div id="addTierGrpDsPop333" class="popup_container"></div>

<div class="page_btn_area" id="tierRuleArea" style="margin-top:15px;">
	<div class="col-xs-7">
		<span><spring:message code="조건 상세" /></span>
	</div>
	
	 <div class="col-sm-5 searchbtn_r">
 <ifvm:inputNew type="button" className="dataAddBtn" id="addTierRuleBtn" btnFunc="addTierRule" text="L00078" btnType="plus" objCode="addTierRuleBtn_OBJ"/>
 <ifvm:inputNew type="button" className="dataDelBtn" id="removeTierRuleBtn" btnFunc="removeTierRule" text="I00888" btnType="minus" objCode="removeTierRuleBtn_OBJ"/>
	</div> 
	
</div>
<div id="tierRuleGridList"></div>

<script type="text/javascript">
var tierRuleRid;
var ridTier;
var tiersRulesTierRid;
var tierGrpDataSetRid;
var tierGrpDataSetItemRid;
function getTierRuleList() {
	 var ejGridOption = {
		    	serializeGridData : function(data) {
		    		data.tierGrpJobRid = tierGrpJobRid;
		    		data.tierBatchJobCd = tierBatchJobCd;
					return data;
				},
				recordDoubleClick : function (args) {
					//tierRuleRid = args.data.rid;
					tiersRulesTierRid = args.data.tiersRulesTierRid;
					/* tierGrpDataSetRid = args.data.tierGrpDataSetRid;
					tierGrpDataSetItemRid = args.data.tierGrpDataSetItemRid; */
					addTierRulePopup();
		        },rowSelected : function(args){
		        	tierRuleRid = args.data.rid;
		        	tiersRulesTierRid = args.data.tiersRulesTierRid;
		       	},
		        dataUrl : '<ifvm:action name="getTierRuleListNew"/>',

		        columns : [
		        	{
			    		  field : 'tierTypeCd', headerText : '등급코드', headerTextAlign : 'center', textAlign : 'center',  width:'100px' , customAttributes :{searchable : true,index : 'tierTypeCd'}
		      	  },{
		      		  field : 'tierNm', headerText : '등급명', headerTextAlign : 'center', width:'90px', textAlign : 'left', customAttributes :{searchable : true,index : 'tierNm'}
		    	  },{
		    		  field : 'condVal', headerText : '조건', textAlign : 'left', width : '650px', headerTextAlign : 'center'
		    	  },{
		    		  field : 'name', headerText : '등록자', textAlign : 'center', width:'130px', headerTextAlign : 'center', textAlign : 'center' ,customAttributes :{searchable : true, index: 'name'}
		    	  },{
		    		  field : 'createDate', headerText : '등록일자', textAlign : 'center', width:'160px', headerTextAlign : 'center', textAlign : 'center' 
		    	  },{
		    		  field : 'tiersRulesTierRid', headerText : 'tiersRulesTierRid',visible : false 
		    	  }
		        ],

		        requestGridData : {
		      	  sidx : '6',
		      	  sord : 'ASC',
		        },
		        radio: true
		    };

	 			tierRuleGridList = $("#tierRuleGridList").ifvsfGrid({ ejGridOption : ejGridOption });
}

function addTierRule() {
	/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
		alert("작성중일때만 등록할수 있습니다.");
		return;
	} */
	if ($.fn.ifvmIsEmpty(tierGroupJobGridList.opt.gridControl.getSelectedRecords()[0])) {
		alert('목록을 선택해주세요.');
		return;
    }
	tierRuleRid = null;
	tiersRulesTierRid = null;
	addTierRulePopup();
}

function addTierRulePopup() {
	$("#addTierRulePop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addTierRulePop"/>',
        contentType: "ajax",
        title: '룰 등록',
        width: 700,
        close : 'addTierRuleClosePopup'
	});
}

function addTierRuleClosePopup() {
	addTierRulePop._destroy();
}

function removeTierRule() {
	/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
		alert("작성중일때만 삭제할수 있습니다.");
		return;
	} */
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(tierRuleGridList.opt.gridControl.getSelectedRecords()[0])) {
    }
    else {
        alert('<spring:message code="M00104"/>');
        return;
    }

    if ($.fn.ifvmIsNotEmpty(tierGrpJobRid || tiersRulesTierRid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeTierRule"/>', {
        	tierGrpJobRid: tierGrpJobRid,
        	tiersRulesTierRid : tiersRulesTierRid
        },
        function(result) {
        	tierRuleGridList._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

$(document).ready(function(){
	getTierRuleList();
});
</script>
