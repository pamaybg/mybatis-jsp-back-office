<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="templateFileDown">
	<a href="<ifvm:action name="tempFileDownload"/>?templateFile={{:templateFile}}" style="color:#1266FF; text-decoration:underline;" >{{:templateFile}}</a>
</script>
<script type="text/javascript">

var pgmId = pgmId;
var rid = null; //엑셀 rid
var dRid = null; //엑셀 셀 rid
var templateFile = null;
var ridExcelH = null;

function ExcelDownloadListGrid() {
	var ejGridOption = {
			serializeGridData : function (data) {
				$('#dataMapList').hide();
		        $('#dataMapListCon').hide();
				data.pgmId = pgmId;
				return data;
			},
			rowSelected : function(args) {
				rid = args.data.rid;
				templateFile = args.data.templateFile;
				dataMapList(rid);
			},
			dataUrl : '<ifvm:action name="getExcelDownloadList"/>',
			columns:[
	        	{
	        		  field : 'pgmId', headerText : '<spring:message code="I02044"/>', visible : false ,
	        	  },{
	          		  field : 'excelSeq', headerText : '<spring:message code="D10263"/>', textAlign : 'center',  width : 120, customAttributes :{searchable : true}
	          	  },{
	          		  field : 'title', headerText : '<spring:message code="M02509"/>',  textAlign : 'center', customAttributes :{searchable : true}
	          	  },{
	          		  field : 'excelCreateType', headerText : '<spring:message code="D10264"/>', textAlign : 'center', customAttributes :{index : 'excelCreateTypeCd'}
	          	  },{
	          		  field : 'templateFile', headerText : '<spring:message code="D10265"/>', template: "#templateFileDown", customAttributes :{searchable : true}
	          	  },{
	          		  field : 'objCode', headerText : '<spring:message code="I02100"/>', textAlign : 'center', customAttributes :{index : 'objcode'}
	          	  },{
	          		  field : 'rid', headerText : 'rid',visible : false,
	          	  }
	        ],
	        requestGridData : {
	        	  nd   : new Date().getTime(),
	        	  rows : 10,
	        	  sidx : 'excelSeq',
	        	  sord : 'asc',
	        	  _search : false
	          },
	           rowList : [10,25,50,100],
	          radio : true,
	          rowList: $.ifvmGetSelectBoxNum(),
	    };
	ExcelDownloadListCon = $("#ExcelDownloadListCon").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

function programDelExcelFileBtn() {
	if(ExcelDownloadListCon.opt.gridControl.getSelectedRecords().length==0){
		alert('<spring:message code="M00285"/>');
	} else {
		if( confirm('<spring:message code="I01500"/>') == true ) {
		$.ifvSyncPostJSON('<ifvm:action name="deleteExcelFile"/>', {
			rid : rid,
			templateFile : templateFile
		}, function(result) {
			if ($.fn.ifvmIsNotEmpty(result)) {
	            if (result.success == true) {
	                alert('<spring:message code="M00622"/>');
	                ExcelDownloadListCon._doAjax();
	            }
	            ExcelDownloadListGrid();
	           
	        }
		});
	}
  }
}

function programExcelListPop(title) {
	$("#addExcelFilePopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addExcelFilePop"/>',
        contentType: "ajax",
        title: title,
        width: '620px',
        close : 'addExcelFilePopupClose'
	});
}

function addExcelFilePopupClose() {
	addExcelFilePopup._destroy();
}


////////////////데이터 매핑 룰////////////////////////
function dataMapList(rid){
	
	$('#dataMapList').show();
	$('#dataMapListCon').show();
	
	var ejGridOption = {
		serializeGridData : function( data ){
			data.ridExcelH = rid;
			return data;
		},
		rowSelected : function(args){
			dRid = args.data.rid;
		},

        dataUrl : '<ifvm:action name="getDataMapList"/>',
        columns:[
        	 {
         		  field : 'headNm', headerText : '<spring:message code="D10268"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true}
         	  }, {
          		  field : 'excelCell', headerText : '<spring:message code="D10266"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true}
          	  }, {
          		  field : 'dataField', headerText : '<spring:message code="D10267"/>', headerTextAlign : 'center', textAlign : 'center', customAttributes : {searchable : true}
          	  }, {
          		  field : 'rid', headerText : 'rid', visible : false ,
          	  }
        ],
        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'headNm',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
        radio: true,
        tempId: 'ifvGridOriginTemplete',
        ajaxGridOptions :{async : true}
    };
	dataMapListCon = $("#dataMapListCon").ifvsfGrid({ ejGridOption : ejGridOption });
};

function ExcelDataMapPop(title) {
	$("#ExcelDataMapPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="ExcelDataMapPopup"/>',
        contentType: "ajax",
        title: title,
        width: '620px',
        close : 'ExcelDataMapPopupClose'
	});
}

function ExcelDataMapPopupClose() {
	ExcelDataMapPopup._destroy();
}
function deleteDataMap(){
	var checked = dataMapListCon.opt.gridControl.getSelectedRecords();
	if ($.fn.ifvmIsNotEmpty(checked)){
		
		if( confirm('<spring:message code="I01500"/>') == true ){
		
			$.ifvSyncPostJSON('<ifvm:action name="deleteDataMap"/>',{
				rid : checked[0].rid
			},
			function(result) {
				alert('<spring:message code="I00726"/>');
			});
		}
	}else{
		alert('<spring:message code="I00728"/>');
	}
	
	dataMapList(rid);
}


$(document).ready(function(){

	$('#dataMapList').hide();
	$('#dataMapListCon').hide();
	
	ExcelDownloadListGrid();
	
	$("#programAddExcelFileBtn").click(function(){
		rid = null;
		programExcelListPop('엑셀 파일 생성 등록');
	});
	
	$("#programDelExcelFileBtn").click(function(){
		programDelExcelFileBtn();
	});

	//수정
	$("#programUpdateExcelFileBtn").on("click", function(){
		if(rid == null){
			alert('<spring:message code="I00728"/>');
		}else{
			programExcelListPop('엑셀 파일 생성 수정');
		}
	});

	///////////////////데이터매핑///////////////////
	$("#insertData").click(function(){
		dRid = null;
		ExcelDataMapPop('데이터 매핑 등록');
	});
	
	$("#deleteData").click(function(){
		deleteDataMap();
	});

	//수정
	$("#modifyData").on("click", function(){
		if(dRid == null){
			alert('<spring:message code="I00728"/>');
		}else{
			ExcelDataMapPop('데이터 매핑 수정');
		}
	});
	
	
});

</script>

<div class="page_btn_area" id="ExcelDownloadListGrid">
	<div class="col-xs-7"></div>
	<div class="col-sm-5 searchbtn_r">
 		<ifvm:inputNew type="button" className="dataAddlBtn" id="programAddExcelFileBtn"  text="I00887" btnType="plus" objCode="programAddExcelFileBtn_OBJ"/>
 		<ifvm:inputNew type="button" className="dataUpdateBtn" id="programUpdateExcelFileBtn"  text="수정" objCode="programModifyExcelFileBtn_OBJ"/>
 		<ifvm:inputNew type="button" className="dataDelBtn" id="programDelExcelFileBtn"  text="I00888" btnType="minus" objCode="programDelExcelFileBtn_OBJ"/>
	</div>
</div>
<div id="ExcelDownloadListCon"></div>
<div class="page_btn_area" id="dataMapList">
	<div class="col-sm-7">
		<span>데이터 매핑 룰</span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" id="insertData"  text="M00571" btnType="plus" objCode="excelDownloadListInsertData_OBJ"/>
		<ifvm:inputNew type="button" id="modifyData"  text="M00283" objCode="excelDownloadListModifyData_OBJ"/>
		<ifvm:inputNew type="button" id="deleteData"  text="M00572" btnType="minus" objCode="excelDownloadListDelData_OBJ"/>
	</div>
</div>
<div id="dataMapListCon" class="grid_bd0"></div>
<div id="addExcelFilePopup" class="popup_container content_container"></div>
<div id="ExcelDataMapPopup" class="popup_container content_container"></div>
