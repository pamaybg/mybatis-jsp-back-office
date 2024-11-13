<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="chnlListGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnChnlSave" objCode="">
		<spring:message code="O00058" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnChnlCancel" objCode="">
		<spring:message code="O00059" />
	</button>
</div>

<script type="text/javascript">

var apiChnlList = function(){
	var chnlListGrid;
	var _chnlRid = null;
	this.setChnlRid = function(chnlRid){
		_chnlRid = chnlRid;
	},
	this.getChnlRid = function(){
		return _chnlRid;
	},
	this.init = function(){
		this.setGirdAndDataLoad();
		this.action();
	},
	this.setGirdAndDataLoad = function(){
		var _rowSelected = function(args){
			var _data = args.data;
			this.setChnlRid(_data.rid);
		};
		
		var ejGridOption = {
				rowSelected : _rowSelected.bind(this),
				serializeGridData : function( data ){ 
					data.chnlSearch = 'Y';
					return data; 
				},
		        dataUrl : '<ifvm:action name="getChnlListPage"/>',
		        columns : [
		        	{
						field : 'chnlNo', headerText : '<spring:message code="O00076"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true}
		        	},{
						field : 'chnlNm', headerText : '<spring:message code="O00077"/>', headerTextAlign : 'center', width : '190px', customAttributes : {searchable : true}
					},{
						field : 'statCdNm', headerText : '<spring:message code="O00052"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'statCd'}
					},{
						field : 'chnlTypeCdNm', headerText : '<spring:message code="O00078"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {index : 'chnlTypeCd'}
					},{
						field : 'createDate', headerText : '<spring:message code="O00079"/>', headerTextAlign : 'center', textAlign : 'center',
					},{
						field : 'createBy', headerText : '<spring:message code="O00080"/>', headerTextAlign : 'center', textAlign : 'center',
					},{
						field : 'rid', headerText : 'rid',visible : false 
					}
		        ],
		        requestGridData : {
					sidx : 'chnlNo',
					sord : 'asc',
		        },
		        radio: true
		      };
		
			chnlListGrid = $("#chnlListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	},
	this.rgstApiChnl = function(){
		if(chnlListGrid.opt.gridControl.getSelectedRecords().length==0){
			alert('<spring:message code="O00066"/>');
		}else{
			var _url = '<ifvm:action name="apiSpecJoinChnl"/>';
			var _varData  = {
					apiSpecRid : rid,
					chnlRid : this.getChnlRid()
			};
			
			$.ifvSyncPostJSON(_url, _varData, function(result) {
				if (result.message) alert(result.message);
				else alert("<spring:message code="등록 되었습니다." />");
				$.fn.ifvmPopupClose();
				var apiChnlListNew = new apiChnlGrid();
				apiChnlListNew.init();
			}, function(result) {
				if (result.message) alert(result.message);
				else alert("<spring:message code="정상적으로 등록되지 않았습니다." />");
			}.bind(this));
			
		}
	},
	this.action = function(){
		
		$("#btnChnlSave").click(function(){
			this.rgstApiChnl();
		}.bind(this));
		
		$("#btnChnlCancel").click(function(){
			$.fn.ifvmPopupClose();
		}.bind(this));
	}
}
	

$(document).ready(function(){
	
	var apiChnlListNew = new apiChnlList();
	apiChnlListNew.init();
});
</script>