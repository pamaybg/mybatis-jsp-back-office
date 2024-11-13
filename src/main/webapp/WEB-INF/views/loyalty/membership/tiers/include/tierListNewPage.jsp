<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
#tierBnftArea .tab-list {width: 500px !important;}
</style>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="plus" id="addTier" text="신규" objCode="tierListNewAddTier_OBJ"/>
			<ifvm:inputNew type="button" id="modifyTier" text="수정" objCode="tierListNewModifyTier_OBJ"/>
			<ifvm:inputNew type="button" btnType="minus" id="removeTier" text="삭제" objCode="tierListNewRemoveTier_OBJ"/>
        </div>
    </div>
    <div id="tierListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="addTierPop" class="popup_container"></div>

<div id="tierBnftArea">
</div>

<script type="text/javascript">
var tierListGrid;
var tierRid;
var baseTierYn;
var seqNo;
var tabClick=false;


var tierBnftArea = {
    drawTab : function () {
        $("#tierBnftArea").empty();

        $("#tierBnftArea").DrawTab(
            {
                item: items
               /*  [
					{
                          label: '등급별 혜택',
                          href: '<ifvm:url name="tierBnftNew" />'
					},
                ] */
            }
        )
    }
}

function getTierListNewPage(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.tierGroupRid = tierGroupDetail_rid;
			return data;
		},
		rowSelected : function(args){
        	tierRid = args.data.rid;
        	baseTierYn = args.data.baseTierYn;
        	seqNo = args.data.seqNo;
        	tabClick = true;
        	tierBnftArea.drawTab();
       	},
        dataUrl : '<ifvm:action name="getTierListNewPage"/>',

        columns : [
        	{
      		  field : 'seqNo', headerText : '순서', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'tierTypeCd', headerText : '등급코드', textAlign : 'center', headerTextAlign : 'center', textAlign : 'center' , /*customAttributes : {index : 'tierTypeCd'}*/
    	  },{
    		  field : 'tierNm', headerText : '등급명', headerTextAlign : 'center', textAlign : 'left',  width:'200px', textAlign : 'center'  ,customAttributes :{searchable : true}
    	  },{
    		  field : 'baseTierYn', headerText : '기본등급', headerTextAlign : 'center', textAlign : 'center' , customAttributes :{searchable : true}
    	  },{
    		  field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'modifyDate', headerText : '수정일자', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'ASC',
        },
        radio: true
    };

    tierListGrid = $("#tierListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function addTierPopup() {
	$("#addTierPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addTierPop"/>',
        contentType: "ajax",
        title: '등급 신규',
        width: 600,
        close : 'addTierClosePop'
	});
}

function addTierClosePop() {
	addTierPop._destroy();
}

function removeTier() {
	var v_rid;
	/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
		alert("작성중일때만 삭제할수 있습니다.");
		return;
	} */
    if ($.fn.ifvmIsNotEmpty(tierListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = tierListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M00104"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeTier"/>', {
            rid: v_rid
        },
        function(result) {
        	tierListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

$(document).ready(function(){
	getTierListNewPage();
	
	tierBnftArea.drawTab();
	
	$("#addTier").click(function() {
		/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
			alert("작성중일때만 등록할수 있습니다.");
			return;
		} */
		tierRid = null;
		addTierPopup();
	});

	
	$("#removeTier").click(function() {
		removeTier();
	});
	
	$("#modifyTier").click(function() {
		if ($.fn.ifvmIsEmpty(tierListGrid.opt.gridControl.getSelectedRecords()[0])) {
				alert('<spring:message code="C00165"/>');
				return;
		}
		tierRid = tierListGrid.opt.gridControl.getSelectedRecords()[0].rid;
		addTierPopup();
	});

});

</script>