<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="page_btn_area">
   	<div class="col-sm-7">
		<span>채널</span>    
   	</div>
     <div class="col-sm-5 searchbtn_r">
   			<button class="btn btn-sm" id="copyChnl" objCode=""><spring:message code="복사"/></button>
   			<button class="btn btn-sm" id="addNewChnl" objCode=""><spring:message code="신규"/></button>
         	 <button class="btn btn-sm" id="removeChnl" objCode=""><spring:message code="삭제"/></button>  
     </div>
   </div>
<div id="apiChnlListGrid" class="white_bg grid_bd0"></div>
<div id="popupContainer" class="popup_container"></div>

<script type="text/javascript">

var apiChnlGrid = function(){
	var _rid = rid;
    var _apiChnlRid = null;
    var _chnlNo = null;
    var apiChnlList;
    
    this.apiChnlList = null,
	this.getRid = function(){
		return _rid;
	},
    this.getApiChnlRid = function () {
        return _apiChnlRid;
    },
    this.setApiChnlRid= function (apiChnlRid) {
    	_apiChnlRid = apiChnlRid;
    },
    this.getChnlNo = function () {
        return _chnlNo;
    },
    this.setChnlNo = function (chnlNo) {
    	_chnlNo = chnlNo;
    },
	this.init = function(){
		this.setGridDataLoad();
		this.action();
	},
	this.setGridDataLoad = function(){
		var _serializeGridData = function(data) {
        	data.rid = this.getRid();
            return data;
        };
        
        var _rowSelected = function(args){
        	var _data = args.data;
            this.setApiChnlRid(_data.rid);
            this.setChnlNo(_data.chnlNo);
        };
        var ejGridOption = {
        		serializeGridData : _serializeGridData.bind(this),
        		rowSelected: _rowSelected.bind(this),
				dataUrl : '<ifvm:action name="getApiChnlList"/>',
				columns : [ {
					field : 'rid', visible : false
				},{
					field : 'chnlNo', headerText : '<spring:message code="채널번호"/>', textAlign : 'center',customAttributes : { searchable : true }
				},{
					field : 'chnlNm', headerText : '<spring:message code="채널명"/>', textAlign : 'center', customAttributes : { searchable : true }
				},{
					field : 'chnlTypeCdNm', headerText : '<spring:message code="채널유형"/>', textAlign : 'center', customAttributes : { index : 'chnlTypeCd' }
				},{
					field : 'statCdNm', headerText : '<spring:message code="상태"/>', textAlign : 'center', customAttributes : { index : 'statCd' }
				},{
					field : 'createBy', headerText : '<spring:message code="등록자"/>', textAlign : 'center'
				},{
					field : 'createDate', headerText : '<spring:message code="등록일자"/>', textAlign : 'center'
				},{
					field : 'rid', headerText : 'id', visible : false
				}],
				requestGridData : {
					sidx : 'createDate'
					 /* rows : 10,
			      	  sidx : 'createDate',
			      	  sord : 'desc',
			      	  _search : false  */
				},
				radio : true,
				/* rowList : [10,25,50,100],
		        autowidth : true ,
		        radio : true,
		        tempId : 'ifvGridSimplePageTemplete2' */
        }
        
        this.apiChnlList = $("#apiChnlListGrid").ifvsfGrid({
			ejGridOption : ejGridOption
		});
	},
	this.removeApiChnl = function(){
		
		if(this.apiChnlList.opt.gridControl.getSelectedRecords().length==0){
			alert('<spring:message code="O00066"/>');
		}else{
			
			var _success = function () {
	               $.ifvProgressControl(false);
	               setTimeout(`alert('<spring:message code="L00085"/>')`, 0);
	               this.setGridDataLoad();
	           };
	
	        var _fail = function (result) {
	            $.ifvProgressControl(false);
	            if(result.message) setTimeout(`alert(result.message)`, 0);
	            else setTimeout(`alert("정상적으로 삭제되지 않았습니다.")`, 0);
	        };
	
			if(confirm("삭제 하시겠습니까?")){
				$.ifvProgressControl(true);
				$.ifvSyncPostJSON('<ifvm:action name="removeApiChnl"/>',
						{rid : this.getApiChnlRid()}, _success.bind(this), _fail);
			}
		}
	},
	this.action = function(){
		
		$("#copyChnl").click(function(){
			$.fn.ifvmPopupOpen('popupContainer',  this.getRid() ,
		            '<ifvm:url name="apiSpecListPop"/>', 'API 목록', 800);
		}.bind(this));
		
		$("#addNewChnl").click(function(){
			$.fn.ifvmPopupOpen('popupContainer',  this.getRid() ,
		            '<ifvm:url name="apiChnlJoinPop"/>', '채널', 800);
		}.bind(this));
		
		$("#removeChnl").click(function(){
			this.removeApiChnl();
		}.bind(this));
	},
	this.close = function(){
		$.fn.ifvPopupClose();
	}
}

$(document).ready(function(){
	var apiChnlListNew = new apiChnlGrid();
	apiChnlListNew.init();
});
</script>