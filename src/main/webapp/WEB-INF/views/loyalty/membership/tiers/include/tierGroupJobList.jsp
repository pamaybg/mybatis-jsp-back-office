<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
#tierGrpDsArea .tab-list {width: 500px !important;}
</style>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="plus" id="addTierGroupJob" text="신규" objCode="addTierGroupJob_OBJ"/>
			<ifvm:inputNew type="button" id="modifyTierGroupJob" text="수정" objCode="modifyTierGroupJob_OBJ"/>
			<ifvm:inputNew type="button" btnType="minus" id="removeTierGroupJob" text="삭제" objCode="removeTierGroupJob_OBJ"/>
        </div>
    </div>
    <div id="tierGroupJobGridList" class="white_bg grid_bd0"></div>
</div>

<div id="addTierGroupJobPop" class="popup_container"></div>

<div id="tierGrpDsArea">
</div>

<script type="text/javascript">
var tierGroupJobGridList;
var tierGrpJobRid;
var tierBatchJobCd='';
var groupTabCheck = false;


/* var items = [];
var pgmObject = [];

<c:forEach items="${pgmChild}" var="info2">
var json = new Object();
json.pgmRid="${info2.pgmRid}";
json.url="${info2.url}";
pgmObject.push(json);
</c:forEach>

for(var i=0;i<pgmObject.length;i++) {
	var arr = pgmObject[i].url.replace(".jsp","");
	var rowData = {
			label : '<spring:message code="등급"/>',
			href : '<ifvm:url name="'+arr+'"/>',
	};
	items.push(rowData);
} */

var tierGrpDsArea = {
    drawTab : function () {
        $("#tierGrpDsArea").empty();

        $("#tierGrpDsArea").DrawTab(
            {
                item: items
                /* [
					{
                          label: '기준 정보',
                          href: '<ifvm:url name="tierGrpDsListNew" />'
					},
					{
                          label: '룰',
                          href: '<ifvm:url name="tierRuleListNew" />'
					},
                ] */
            }
        )
    }
}

function getTierGroupJobList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.tierGroupRid = tierGroupDetail_rid;
			return data;
		},
		rowSelected : function(args){
			tierGrpJobRid = args.data.rid;
			tierBatchJobCd = args.data.tierBatchJobCd;
			groupTabCheck=true;
			tierGrpDsArea.drawTab();
		},
       	
        dataUrl : '<ifvm:action name="getTierGroupJobList"/>',

        columns : [
        	{
      		  field : 'tierBatchJobCdNm', headerText : '유형', headerTextAlign : 'center', width:'80px', textAlign : 'center', customAttributes : {index : 'tierBatchJobCd'}
      	  },{
    		  field : 'execCycle', headerText : '실행 주기', headerTextAlign : 'center',  width:'80px',textAlign : 'center', customAttributes : {index : 'execCycle'}
    	  },{
    		  field : 'execMm', headerText : '실행 월', headerTextAlign : 'center',  width:'230px'
    	  },{
    		  field : 'useYn', headerText : '사용여부', textAlign : 'center',  width:'80px',headerTextAlign : 'center', textAlign : 'center' , customAttributes :{searchable : true}
    	  },{
    		  field : 'name', headerText : '등록자', textAlign : 'center',  width:'80px',headerTextAlign : 'center', textAlign : 'center' , customAttributes :{searchable : true}
    	  },{
    		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center',  width:'100px', textAlign : 'center'
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  },{
    		  field : 'tierBatchJobCd', headerText : 'tierBatchJobCd',visible : false 
    	  }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc',
        },
        radio: true
    };

    tierGroupJobGridList = $("#tierGroupJobGridList").ifvsfGrid({ ejGridOption : ejGridOption });
}

function addTierGrpJobPopup() {
	$("#addTierGroupJobPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addTierGroupJobPop"/>',
        contentType: "ajax",
        title: '심사정책 등록',
        width: 700,
        close : 'addTierGrpJobClosePop'
	});
}

function addTierGrpJobClosePop() {
	addTierGroupJobPop._destroy();
}

function removeTierGrpJob() {
	/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
		alert("작성중일때만 삭제할수 있습니다.");
		return;
	} */
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(tierGroupJobGridList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = tierGroupJobGridList.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M00104"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeTierGrpJob"/>', {
            rid: v_rid
        },
        function(result) {
        	tierGroupJobGridList._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

$(document).ready(function(){
	getTierGroupJobList();
	
	tierGrpDsArea.drawTab();
	
	$("#addTierGroupJob").click(function() {
		/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
			alert("작성중일때만 등록할수 있습니다.");
			return;
		} */
		tierGrpJobRid = null;
		addTierGrpJobPopup();
	});

	
	$("#removeTierGroupJob").click(function() {
		removeTierGrpJob();
	});
	
	$("#modifyTierGroupJob").click(function() {
		if ($.fn.ifvmIsEmpty(tierGroupJobGridList.opt.gridControl.getSelectedRecords()[0])) {
			alert('<spring:message code="C00165"/>');
			return;
		}
		tierGrpJobRid = tierGroupJobGridList.opt.gridControl.getSelectedRecords()[0].rid;
		addTierGrpJobPopup();
	});

});

</script>