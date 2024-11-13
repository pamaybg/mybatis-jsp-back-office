<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="addTierGrpDsPop" class="popup_container"></div>


<div class="page_btn_area" id="tiergrpDsArea" style="margin-top:15px;">
	<div class="col-xs-7">
		<span><spring:message code="기준 데이터셋" /></span>
	</div>
	
	 <div class="col-sm-5 searchbtn_r">
 <ifvm:inputNew type="button" className="dataAddBtn" id="addTierGrpDsBtn" btnFunc="addTierGrpDs" text="L00078" btnType="plus" objCode="addTierGrpDsBtn_OBJ"/>
 <ifvm:inputNew type="button" className="dataDelBtn" id="removeTierGrpDsBtn" btnFunc="removeTierGrpDs" text="I00888" btnType="minus" objCode="removeTierGrpDsBtn_OBJ"/>
	</div> 
	
</div>
<div id="tierGrpDsGridList"></div>

<script type="text/javascript">
var tierGrpDsRid;
var tiersDataSetItemRid;
function getTieGrpDsList() {
	 var ejGridOption = {
		    	serializeGridData : function(data) {
		    		data.tierGrpJobRid = tierGrpJobRid;
		    		data.tierBatchJobCd = tierBatchJobCd;
					return data;
				},
				recordDoubleClick : function (args) {
					tierGrpDsRid = args.data.rid;
					addTierGrpDsPopup();
		        },rowSelected : function(args){
		        	tierGrpDsRid = args.data.rid;
		       	},
		        dataUrl : '<ifvm:action name="getTierGrpDsListNew"/>',

		        columns : [
		        	{
		      		  field : 'dsNm', headerText : '데이터셋명', headerTextAlign : 'center', textAlign : 'left',  width:'20%', customAttributes :{searchable : true}
		      	  },{
		    		  field : 'objNm', headerText : '오브젝트명', headerTextAlign : 'center', textAlign : 'left',  width:'30%' ,customAttributes :{searchable : true}
		    	  },{
		    		  field : 'extRange', headerText : '추출범위', textAlign : 'center', headerTextAlign : 'center',  width:'12%'
		    	  },{
		    		  field : 'createBy', headerText : '등록자', textAlign : 'center', headerTextAlign : 'center' ,  width:'15%'
		    	  },{
		    		  field : 'createDate', headerText : '등록일시', textAlign : 'center', headerTextAlign : 'center',  width:'15%'
		    	  },{
		    		  field : 'rid', headerText : 'rid',visible : false 
		    	  }
		        ],

		        requestGridData : {
		      	  sidx : '1',
		      	  sord : 'desc',
		      	  
		        },
		        radio: true
		    };

	 		tierGrpDsGridList = $("#tierGrpDsGridList").ifvsfGrid({ ejGridOption : ejGridOption });
}

function addTierGrpDs() {
	/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
		alert("작성중일때만 등록할수 있습니다.");
		return;
	} */
	if ($.fn.ifvmIsEmpty(tierGroupJobGridList.opt.gridControl.getSelectedRecords()[0])) {
		alert('목록을 선택해주세요.');
		return;
    }
	tierGrpDsRid = null;
	addTierGrpDsPopup();
}

function addTierGrpDsPopup() {
	$("#addTierGrpDsPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addTierGrpDsPop"/>',
        contentType: "ajax",
        title: '기준정보 등록',
        width: 700,
        close : 'addTierGrpDsClosePopup'
	});
}

function addTierGrpDsClosePopup() {
	addTierGrpDsPop._destroy();
}

function removeTierGrpDs() {
	/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
		alert("작성중일때만 삭제할수 있습니다.");
		return;
	} */
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(tierGrpDsGridList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = tierGrpDsGridList.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M00104"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeTierGrpDs"/>', {
            rid: v_rid
        },
        function(result) {
        	tierGrpDsGridList._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

$(document).ready(function(){
	getTieGrpDsList();
});
</script>
