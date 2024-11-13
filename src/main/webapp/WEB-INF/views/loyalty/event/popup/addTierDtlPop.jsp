<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="tierGrpListGrid"></div>
<div id="tierListGrid"></div>
<!-- <div class="page_btn_area" id="dataSetItemArea">
	<div class="col-xs-7">
		<span>데이터셋 아이템</span>
	</div>
</div> -->
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="tierSelect" objCode="">
		<spring:message code="저장" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="tierCancle" objCode="">
		<spring:message code="M00441" />
	</button>
</div>


<script type="text/javascript">
var tierGrpListGrid;
var tiersGrpRid=null;
var tierRid=null;
function getTierGrpList() {
		var ejGridOption = {
			recordDoubleClick : function(args) {
				var data = args.data;
				rid = data.rid;
				tierGroupDetailNew(rid);
			},
			serializeGridData : function(data) {
				data.evtLimitTier='Y';
				return data;
			},rowSelected : function (args) {
				var data = args.data;
				tiersGrpRid = data.rid;
				getTierListNewPage();
        	},
			loadComplete : function(obj) {
			},
			dataUrl : '<ifvm:action name="getTierGroupListNew"/>',
			columns : [ {
				field : 'pgmNm',
				headerText : '프로그램',
				headerTextAlign : 'center',
				textAlign : 'left',
				width : '150px',
				customAttributes : {
					searchable : true
				}
			}, {
				field : 'tiersGrpNm',
				headerText : '등급그룹명',
				headerTextAlign : 'center',
				textAlign : 'left',
				width : '140px',
				customAttributes : {
					searchable : true
				}
			}, {
				field : 'loyMbrTypeCdNm',
				headerText : '회원유형',
				headerTextAlign : 'center',
				textAlign : 'center',
				width : '100px',
				customAttributes : {
					index : 'loyMbrTypeCd'
				}
			}, {
				field : 'mbrTierColNm',
				headerText : '등급그룹유형',
				headerTextAlign : 'center',
				textAlign : 'center',
				width : '80px',
				customAttributes : {
					index : 'mbrTierCol'
				}
			},  {
				field : 'statCdNm',
				headerText : '상태',
				headerTextAlign : 'center',
				textAlign : 'center',
				width : '80px',
				customAttributes : {
					index : 'statCd'
				}
			},{
				field : 'rid',
				headerText : 'rid',
				visible : false,
			}, ],
			requestGridData : {
				nd : new Date().getTime(),
				rows : 10,
				sidx : '4,1',
				sord : 'desc',
				_search : false
			},
			rowList : [ 10, 25, 50, 100 ],
			radio : true,
		};
		tierGrpListGrid = $("#tierGrpListGrid").ifvsfGrid({
			ejGridOption : ejGridOption
		});
	}

function getTierListNewPage(){
	/* $('#dataSetItemArea').show(); */
    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.tierGroupRid = tiersGrpRid;
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
    		  field : 'tierTypeCd', headerText : '등급코드', textAlign : 'center', headerTextAlign : 'center', textAlign : 'center' , customAttributes : {index : 'tierTypeCd'}
    	  },{
    		  field : 'tierNm', headerText : '등급명', headerTextAlign : 'center', textAlign : 'left',  width:'200px' ,customAttributes :{searchable : true}
    	  },{
    		  field : 'baseTierYn', headerText : '기본등급', headerTextAlign : 'center', textAlign : 'center' , customAttributes :{searchable : true}
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
};

	
$(document).ready(function() {
	getTierGrpList();
	getTierListNewPage();
	$("#tierSelect").on('click', function(){
		if(tierListGrid.opt.gridControl.getSelectedRecords().length == 0){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		$.ifvSyncPostJSON('<ifvm:action name="saveTierLimit"/>',{
    			tierRid : tierRid,
    			eventRid  : eventRid
    	    },function(result){
    	    	if(result.success == true){
    	    		alert('<spring:message code="M00005"/>');
    	    		insertTierPopClose();
    	    		tierLimitGrid._doAjax();
    	    	}
    	    	else{
    				alert('저장에 실패하였습니다.');
    			}
    		});
    	}
	});
	
	$("#tierCancle").on('click', function(){
		insertTierPopClose();
	}); 
});

</script>
