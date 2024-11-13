<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 <script id="requiredYnTemp" type="text/x-jquery-tmpl">
{{if  requiredYn=="Y" }}
	<div style="color:#FF0000";>{{:requiredYn}}</div>
{{else}}
	{{:requiredYn}}
{{/if}}
</script>

 <script id="encodeYnTemp" type="text/x-jquery-tmpl">
{{if  encodeYn=="Y" }}
	<div style="color:#FF0000";>{{:encodeYn}}</div>
{{else}}
	{{:encodeYn}}
{{/if}}
</script>

<div id="custItemConfTabArea"></div>

<div class="page-title">
	<h1>
		<spring:message code="L02782" />
		&gt; <spring:message code="M00568" />
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00276" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="searchCustItemConfBtn" objCode="searchCustItemConfBtn_OBJ"><i class="fa fa-search"></i>
				<spring:message code="M00568" />
			</button>
			<button class="btn btn-sm" id="resetCustItemConfBtn" objCode="resetCustItemConfBtn_OBJ">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="custitemSearchList"></div>

</div>

<!--조회결과-->
<div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="L02782"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" text="M01852" id="addCustItemConfBtn" objCode="addCustItemConfBtn_OBJ"/>
		<ifvm:inputNew type="button" btnType="minus" text="M01854" id="delCustItemConfBtn" objCode="delCustItemConfBtn_OBJ"/>
	</div>
</div>

<div id="custItemConfListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="itemConfpopupContainer" class="popup_container"></div>
<script type="text/javascript">
var itemRid = null;
var custItemConfList;

//개인고객수집 정보 목록 리스트
function custItemConfListSearch() {
	
	var ejGridOption = {
		serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
		rowSelected : function (args) {
			var rid = args.data.rid;
			ifvGlobal["custDiValRid"] = rid;
			itemRid = rid;
		},
		recordDoubleClick : function(args) {
			var rid = args.data.rid;
			ifvGlobal["custDiValRid"] = rid;
			itemRid = rid;
			getCustItemConfDetailPop();
		},
        dataUrl : '<ifvm:action name="getCustItemConfList"/>',
		columns : [
			{
				field : 'pgmNm', headerText : '<spring:message code="M00774"/>',  textAlign : 'center' , customAttributes :{searchable : true}
			},{
				field : 'custType', headerText : '<spring:message code="M02630"/>',  textAlign : 'center', customAttributes :{index : 'custTypeCdNm', searchable : true } // custTypeCdNm
			},{
				field : 'fieldDesc', headerText : '<spring:message code="L02601"/>',  textAlign : 'center' // , customAttributes :{searchable : true}
			}, {
				field : 'fieldNm', headerText : '<spring:message code="필드명"/>',  textAlign : 'center' //, customAttributes :{searchable : true}
			},{
				field : 'columnNm', headerText : '<spring:message code="컬럼명"/>',  textAlign : 'center' //, customAttributes :{searchable : true}
			},{
				field : 'requiredYn', headerText : '<spring:message code="L02707"/>',  textAlign : 'center', template: "#requiredYnTemp" // , customAttributes :{searchable : true}
			},{
				field : 'encodeYn', headerText : '<spring:message code="암호화여부"/>',  textAlign : 'center', template: "#encodeYnTemp" //, customAttributes :{searchable : true}
			},{
				field : 'fieldValCd', headerText : '<spring:message code="필드값유형"/>',  textAlign : 'center', customAttributes :{index : 'fieldValCdNm'}
			},{
				field : 'grpCdNm', headerText : '<spring:message code="그룹코드명"/>',  textAlign : 'center' //, customAttributes :{searchable : true}
			},{
				field : 'createDate', headerText : '<spring:message code="M00222"/>',  textAlign : 'center'
			}, {
				field : 'rid', headerText : 'rid', visible : false,
			} ],
		 requestGridData : {
			sidx : 'createDate',
			sord : 'desc'
		 },
		tempId : 'ifvGridNotSearchTemplete',
		radio : true
	};

	custItemConfList = $("#custItemConfListGrid").ifvsfGrid({ejGridOption: ejGridOption});
}

function getCustItemConfDetailPop(){
	$("#itemConfpopupContainer").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="custItemConfPop"/>',
        contentType: "ajax",
        title: '<spring:message code="L02760"/>',
        width: 600,
        close : 'popupClose',
    	open : function(){
    		new ifvm.PopupCenter({
        		popupDivId : 'itemConfpopupClose'
        	});
        }
    });
}

function itemConfpopupClose() {
	itemConfpopupContainer._destroy();
} 

function romoveCustItemConf(){
	if(itemRid == null){
		alert('<spring:message code="C00113"/>');
	}else{
		if(confirm('<spring:message code="M00127"/>')){
			$.ifvSyncPostJSON('<ifvm:action name="removeCustItemConf"/>',{rid : itemRid},function(result){
				alert('<spring:message code="L00034"/>');
				custItemConfList._doAjax();
			});
		}
	}
}

//공통 조회 조건 목록 설정
function ConListSearchInit(gridId) {
	$.fn.ifvmSetCommonCondList("custitemSearchList", "CUST_ITEM_CONF_LIST", gridId);
}

// 공통 조회 호출
function ConListSearch() {
	$.fn.ifvmSubmitSearchCondition("custitemSearchList", function() {
		custItemConfList.searchGrid({
			item : requestitem
		});
	});
}

$(document).ready(function(){
	ConListSearchInit();
	custItemConfListSearch();
	$("#addCustItemConfBtn").click(function(){
		itemRid = null;
		ifvGlobal["custDiValRid"] = null;
		getCustItemConfDetailPop();
	});
	
	$("#delCustItemConfBtn").click(function(){
		romoveCustItemConf();
	});

	//조회
	$('#searchCustItemConfBtn').on('click', function() {
		ConListSearch();
	});
	//초기화
	$('#resetCustItemConfBtn').on('click', function() {
		ConListSearchInit('custItemConfListGrid');
	});

});
</script>