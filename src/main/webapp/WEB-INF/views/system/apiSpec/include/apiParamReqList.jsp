<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page_btn_area">
   	<div class="col-sm-7">
		<span>필드</span>    
   	</div>
     <div class="col-sm-5 searchbtn_r">
   			<button class="btn btn-sm" id="addNewParam" objCode="addNewParam_OBJ"><spring:message code="신규"/></button>
         	 <button class="btn btn-sm" id="removeParam" objCode="removeParam_OBJ"><spring:message code="삭제"/></button>  
     </div>
   </div>
<div id="apiParamListGrid" class="white_bg grid_bd0"></div>




<div id="popupContainer" class="popup_container"></div>

<script type="text/javascript">


var apiParamGrid = function(){
	var _rid = rid;
    var _apiParamRid = null;
    var _ParamNo = null;
    var apiParamList;
    
    this.apiParamList = null,
	this.getRid = function(){
		return _rid;
	},
    this.getApiParamRid = function () {
        return _apiParamRid;
    },
    this.setApiParamRid= function (apiParamRid) {
    	_apiParamRid = apiParamRid;
    },
    this.getParamNo = function () {
        return _ParamNo;
    },
    this.setParamNo = function (ParamNo) {
    	_ParamNo = ParamNo;
    },
	this.init = function(){
		this.setGridDataLoad();
		this.action();
	},
	this.setGridDataLoad = function(){
		var _serializeGridData = function(data) {
			//data.paramSubTypeCd = 'REQ_PARAM';
        	data.rid = rid;
            return data;
        };
        
        var _rowSelected = function(args){
        	var _data = args.data;
        	
            this.setApiParamRid(_data.rid);
            this.setParamNo(_data.ParamNo);
        };
        var _recordDoubleClick = function(args){
        	/* var _data = args.data;
            this.setapiParamRid(_data.rid);
            this.setParamNo(_data.ParamNo); */
        	apiParamReqRid = args.data.rid;
            /* ifvGlobal['apiParamNew'] = apiParamListNew; */
            paramSubTypeCd = args.data.paramSubTypeCd;
        	$.fn.ifvmPopupOpen('popupContainer',  this.getRid() ,
		            '<ifvm:url name="apiParamReqDetail"/>', 'request', 800);
        };
        var ejGridOption = {
        		serializeGridData : _serializeGridData.bind(this),
        		rowSelected: _rowSelected.bind(this),
        		recordDoubleClick: _recordDoubleClick.bind(this),
				dataUrl : '<ifvm:action name="getApiParamList"/>',
				columns : [ {
					field : 'rid', visible : false
				},{
					field : 'seqNo', headerText : '<spring:message code="순서"/>', width:'40px',textAlign : 'center',customAttributes : { searchable : true }
				},{
					field : 'paramSubTypeCdNm', headerText : '<spring:message code="유형"/>',width:'120px', textAlign : 'center',customAttributes : { index : 'paramSubTypeCd' }
				},{
					field : 'paramNm', headerText : '<spring:message code="필드"/>', width:'190px',textAlign : 'center', customAttributes : { searchable : true }
				},{
					field : 'paramDesc', headerText : '<spring:message code="필드명"/>', width:'120px',textAlign : 'center', customAttributes : { searchable : true }
				},{
					field : 'dataTypeCdNm', headerText : '<spring:message code="데이터유형"/>',width:'90px', textAlign : 'center', customAttributes : { index : 'dataTypeCd' }
				},{
					field : 'dataFormat', headerText : '<spring:message code="데이터형식"/>',width:'80px', textAlign : 'center'
				},{
					field : 'requriedYn', headerText : '<spring:message code="필수여부"/>', width:'60px',textAlign : 'center'
				},{
					field : 'addDesc', headerText : '<spring:message code="설명"/>', width:'120px',textAlign : 'left', customAttributes : { index : 'lap.ADD_DESC' }
				},{
					field : 'createBy', headerText : '<spring:message code="등록자"/>',width:'130px', textAlign : 'center', customAttributes : { index : 'lap.CREATE_BY' }
				},{
					field : 'createDate', headerText : '<spring:message code="등록일자"/>',width:'130px', textAlign : 'center', customAttributes : { index : 'lap.CREATE_DATE' }
				},{
					field : 'rid', headerText : 'rid', visible : false
				}],
				requestGridData : {
					/* sidx : 'createDate' */
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
        
        this.apiParamList = $("#apiParamListGrid").ifvsfGrid({
			ejGridOption : ejGridOption
		});
	},
	this.removeapiParam = function(){
		
		if(this.apiParamList.opt.gridControl.getSelectedRecords().length==0){
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
				$.ifvSyncPostJSON('<ifvm:action name="removeApiParam"/>',
						{rid : this.getApiParamRid()}, _success.bind(this), _fail);
			}
		}
	},
	this.action = function(){
		
		$("#addNewParam").click(function(){
			apiParamReqRid=null;
			/* ifvGlobal['apiParamNew'] = apiParamListNew; */
			$.fn.ifvmPopupOpen('popupContainer',  this.getRid() ,
		            '<ifvm:url name="apiParamReqDetail"/>', '요청 파라미터', 800);
		}.bind(this));
		
		$("#removeParam").click(function(){
			this.removeapiParam();
		}.bind(this));
	},
	this.close = function(){
		$.fn.ifvmPopupClose();
	}
}




$(document).ready(function(){
	
	var apiParamListNew = new apiParamGrid();
	ifvGlobal['apiParamNew'] = apiParamListNew;
	apiParamListNew.init();
	

});
</script>