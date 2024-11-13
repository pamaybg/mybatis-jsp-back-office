<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<style>
	.helpBtn {
		background-image: url("/resources/images/icons/btn_help.png");
		background-repeat:no-repeat;
    	background-position:center center;
    	padding-left: 30px;
    	vertical-align: middle;
    	width: 17px;
    	height: 17px;
    	line-height: 17px;
	}
</style>
	
<div class="page_btn_area">
	<div class="col-xs-8">
		<div class="col-xs-1" id="tiersCondNm"></div>
		<i id="helpBtn" class="helpBtn" style="vertical-align: middle;">
			<div class="helptxt" style="display:none;">
				 매년 1월 1일 재산정합니다. 기준정책 미 부합시 직전 하위 등급으로 하향됩니다.
			</div>
		</i>
	</div>
	<div class="col-xs-4 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" 	id="openTiersCondPopBtn"	text="M01852" btnFunc="tiersCondObj.initTierCondDetailPop" objCode="openTiersCondPopBtn_OBJ"/>
       	<ifvm:inputNew type="button" btnType="minus" 	id="removeTiersCondBtn"		text="M01854" btnFunc="tiersCondObj.removeTiersCond" objCode="removeTiersCondBtn_OBJ"/>
	</div>
</div>
<div id="tiersCondList" class="grid_bd0"></div>

<div id="tierCondDetailPop" class="popup_container"></div>

<script>
var tiersCondList;
var tiersCondType='<%= cleanXss(request.getParameter("type")) %>';

var tiersCondObj = {
	initTiersCondList : function() {
		var ejGridOption = {
			recordDoubleClick : function(args){
	   			tiersCondObj.initTierCondDetailPop(args.data.rid);
			},
			serializeGridData : function(data){
				data.ridTierGroup = ridTierGroup;
				data.type = tiersCondType;
			},
			dataUrl: '<ifvm:action name="getTierCondList"/>',
			columns:[
				  {
		      		  field : 'tierCd', headerText : '<spring:message code="L00235"/>', headerTextAlign : 'center', textAlign : 'left', width:'80px',
		      	  },{
		      		  field : 'tierNm', headerText : '<spring:message code="L00236"/>', headerTextAlign : 'center', textAlign : 'left', width:'80px',
		      	  },{
		      		  field : 'tierCdStatCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      	  },{
		      		  field : 'sectStartValStr', headerText : '기준 정책', headerTextAlign : 'center', textAlign : 'left', width:'160px',
		      	  },{
		      		  field : 'modifyBy', headerText : '<spring:message code="L00044"/>', headerTextAlign : 'center', textAlign : 'left', width:'80px',
		      	  },{
		      		  field : 'modifyDate', headerText : '<spring:message code="L00043"/>', headerTextAlign : 'center', textAlign : 'center', width:'80px',
		      	  },{
		      		  field : 'rid', headerText : 'rid', visible : false,
		      	  },
	        ],
	        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'modifyDate',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
			radio:true,
		};
		tiersCondList = $("#tiersCondList").ifvsfGrid({ ejGridOption : ejGridOption });
	}
	//승급룰 삭제
	, removeTiersCond : function() {
		var _selectedRow = tiersCondList.opt.gridControl.getSelectedRecords()[0];
		if($.fn.ifvmIsNotEmpty(_selectedRow)) {
			if(confirm('<spring:message code="M00296"/>')){
				$.ifvSyncPostJSON('<ifvm:action name="removeTiersCondAll"/>', {				
					ridTier	: _selectedRow.rid
					, type : tiersCondType
				}, function(result) {
					alert('<spring:message code="M00622"/>');
					tiersCondList.searchGrid();
				});
			}
		} else {
			alert('<spring:message code="L00066"/>');
		}
	}
	//승급룰 상세팝업
	, initTierCondDetailPop : function(ridTier) {
		
		var _ridTier = ridTier;
		_ridTier = $.fn.ifvmIsEmpty(_ridTier) ? 'null' : _ridTier;
				
		$("#tierCondDetailPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="tiersCondDetailPop"/>?ridTier=' + _ridTier + '&type=' + tiersCondType,
	        contentType: "ajax",
	        title: '승급룰 상세',
	        width: '800px',
	    });
	}
}
 
$(document).ready(function(){
	tiersCondObj.initTiersCondList();
	
	if(ridTierGroup != null){ 
		$("#openTiersCondPopBtn").attr("disabled",false);
		$("#removeTiersCondBtn").attr("disabled",false);
	}else{ 
		$("#openTiersCondPopBtn").attr("disabled",true);
		$("#removeTiersCondBtn").attr("disabled",true);
	}
	
	if(tiersCondType == 'UP') {
		$("#tiersCondNm").text('승급 룰');
		$("#helpBtn").hide();
	} else {
		$("#tiersCondNm").text('하향 룰');
		$("#helpBtn").show();
	}
	
	 $('.helpBtn').setupHelpMessage();
});

</script>