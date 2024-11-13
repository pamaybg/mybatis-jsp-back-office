<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
		<spring:message code="O00198" />
        &gt; <spring:message code="M00273" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span><spring:message code="D00069" /></span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
	    	<ifvm:inputNew type="button" id="faqSampleDownBtn" btnType="download"  btnFunc="faqSampleDownFn" nuc="true" text="FAQ_업로드샘플다운로드" objCode="faqSampleDownBtn_OBJ"/>
	    	<ifvm:inputNew type="button" id="fileUploadBtn" btnFunc="fileUploadFn" btnType="upload" text="M02436" objCode="fileUploadBtn_OBJ"/>
	    	<ifvm:inputNew type="button" id="excelExport" btnFunc="excelExport" btnType="download"  text="M01218"  objCode="excelExport_OBJ"/>
			<ifvm:inputNew type="button" id="btnNew" btnFunc="btnNewClick" btnType="plus" text="L00027" objCode="faqListbtnNew_OBJ" />
			<ifvm:inputNew type="button" id="BtnRemove" btnFunc="btnRemoveClick" btnType="minus" text="M01854" objCode="faqListBtnRemove_OBJ" />
	    </div>
	</div>
	<div id="faqGrid"></div>
</div>
<div id="excelFileUploadPop" class="popup_container"></div>

<div id="faqUploadDetailGrid" hidden="true" ></div>

<script>
var faqGrid;
var faqUploadDetailGrid;

function makeFaqGrid() {
	var ejGridOption = {
			recordDoubleClick : function(args){
	    		rid = args.data.rid;
	    		//qtjs.href('<ifvm:url name="faqExcelDownload"/>' + '?rid=' + rid);
	    		faqDetail(rid);
	    	},
	    	serializeGridData : function( data ){
	      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
	      			data.item = requestitem;
	            }   
	      	},
			loadComplete : function(obj){
			
			},
			dataUrl: '<ifvm:action name="getFAQList"/>',
			columns:[
		    	 {
		      		  field : 'faqType', headerText : '<spring:message code="L00291" />', headerTextAlign : 'center', textAlign : 'center', width:'50px',
		      		  customAttributes : {
		      			  index : 'c1.MARK_NAME' } /* 카테고리명 */
		      	  },{
		      		  field : 'seq', headerText : '<spring:message code="D10221" />', headerTextAlign : 'center', textAlign : 'center', width:'40px',
		      		  customAttributes : {
		      			  searchable : true}/* 카테고리순번 */
		      	  },{
		      		  field : 'faqNm', headerText : '<spring:message code="M00377" />', headerTextAlign : 'center', textAlign : 'left', width:'150px',
		      		  customAttributes : {
		      			  index : 'lf.faq_master_name' }/* 제목 */
		      	  },{
		      		  field : 'hitCnt', headerText : '<spring:message code="M01732" />', headerTextAlign : 'center', textAlign : 'right',width:'60px', visible:false,
		      		  customAttributes : {
		      			searchable : true}/* hitCnt */
		      	  },{
		      		  field : 'createBy', headerText : '<spring:message code="M01810" />', headerTextAlign : 'center', textAlign : 'center', width:'60px',
		      		  customAttributes : {
		      			  index : 'e.name' }/* 등록자 */
		      	  },{
		      		  field : 'createDate', headerText : '<spring:message code="M01860" />', headerTextAlign : 'center', textAlign : 'center', width:'60px',
		      		  customAttributes : {
		      			  index : 'lf.CREATE_DATE' }/* 등록일시 */
		      	  },{
		      		  field : 'openDate', headerText : '<spring:message code="L02457" />', headerTextAlign : 'center', textAlign : 'center', width:'60px',
		      		  customAttributes : {
		      			searchable : true}/* 게시일 */
		      	  },{
		      		  field : 'faq_status', headerText : '<spring:message code="L00337" />', headerTextAlign : 'center', textAlign : 'center', width:'60px',
		      		  customAttributes : {
		      			  index : 'c2.MARK_NAME' }/* 상태 */
		      	  },{
		      		  field : 'rid', headerText : 'id', headerTextAlign : 'center', textAlign : 'center',  visible:false,
		      		  customAttributes : {
		      			  index : 'lf.RID' }/* id */
		      	  }
		    ],
		requestGridData : {
			nd   : new Date().getTime(),
		    row : 10,
	    	sidx: "c1.MARK_NAME, lf.seq desc, openDate",
	    	sord: 'desc',
	    	_search : false
			
			},
		rowList : [10,30,50,100],
		autowidth : true ,
		radio : true,
		tempId : 'ifvGridOriginTemplete',
	};

	faqGrid = $('#faqGrid').ifvsfGrid({ ejGridOption : ejGridOption });
}

function getfaqUploadDetailList(){
    var ejGridOption = {
    	recordDoubleClick : function(args){
    		rid = args.data.rid;
    		//qtjs.href('<ifvm:url name="faqExcelDownload"/>' + '?rid=' + rid);
    	},
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }   
      		data.prodNm = $('#prodNm').val();
      		data.catNm = $('#catNm').val();
      		data.statusCd = $('#statusCd').val();
            return data;
       	},
       	rowSelected : function(args){
       		rid = args.data.rid;
       	},
       	dataUrl : '<ifvm:action name=""/>',
        columns:[ 
        	  {
	      		  field : 'faqType', headerText : '<spring:message code="L00291"/>', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : ' lfm.FAQ_TYPE' } /* 카테고리명 */
	      	  },{
	      		  field : 'seq', headerText : '<spring:message code="L02641" />', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lfm.SEQ' }/* 카테고리순번 */
	      	  },{
	      		  field : 'faqNm', headerText : '<spring:message code="M00377" />', headerTextAlign : 'center', textAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'lf.FAQ_NM' }/* faq제목 */
	      	  },{
	      		  field : 'faqDesc', headerText : '<spring:message code="M01739" />', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lf.faq_detail' }/* faq내용*/
	      	  },{
	      		  field : 'openDt', headerText : '<spring:message code="L02642" />', headerTextAlign : 'center', textAlign : 'center', 
	      		  customAttributes : {
	      			  index : 'lfm.OPEN_DATE' }/* 게시예정일 */
	      	  },{
	      		  field : 'faqStatus', headerText : '<spring:message code="M00147" />', headerTextAlign : 'center', textAlign : 'center',
	      		  customAttributes : {
	      			  index : 'lfm.exposure_yn' }/* 상태 */
	      	  }
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 30,
	      	  sidx : "lfm.FAQ_TYPE, lfm.seq desc, openDt",
	      	  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [30],
        autowidth : true ,
        radio : true,
        tempId : 'ifvGridNotSearchTemplete'
    };
    
    faqUploadDetailList = $("#faqUploadDetailGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}



$(document).ready(function() {
	makeFaqGrid();
	getfaqUploadDetailList();
	
/* 	//조회결과 엑셀다운로드
    $("#excelExportBtn").on('click', function() {     	
    	//$.ifvExcelDn('/loyalty/custChnl/faq/faqExcelDownload.do', 'faqGridGrid');
    	$.ifvExcelDn('<ifvm:action name="faqExcelDownload"/> ', 'faqUploadDetailList');
    }); */
	
});


function btnNewClick() {
	location.href = '<ifvm:url name="faqDetailUrl"/>';
}


function btnRemoveClick(){
	if($.fn.ifvmIsEmpty(faqGrid.opt.gridControl.getSelectedRecords()[0])){
		alert('목록을 선택해주세요.');
	}else{
		var rid = faqGrid.opt.gridControl.getSelectedRecords()[0].rid
		$.ifvSyncPostJSON('<ifvm:action name="removeFaq"/>', {
			rid : rid
	    },function(result){
	    	makeFaqGrid();
	    	alert('삭제되었습니다.');
	    },function(result){
	    	alert('삭제 실패하였습니다.');
	    });
	}
}

//엑셀 다운로드 
function excelExport() {
	$.ifvExcelDn('<ifvm:action name="faqExcelDownload"/>','faqUploadDetailGrid' );
}

//파일업로드
function fileUploadFn(){
	fileUploadPop ={
		        id : "excelFileUploadPop"
		    };
	fileUploadPop.popup = function (){
			 fileUploadPop.pop = $('#'+fileUploadPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="faqUploadDetailPop"/>',
		            contentType: "ajax",
		            title: '멤버십 FAQ 목록 업데이트',
		            width: "700px"
		        });
		};
		fileUploadPop.beforeClose = function (obj) {
		};
		fileUploadPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 fileUploadPop.popup();
}


//FAQ 샘플 다운로드
$.fn.ifvmBatchRgstExcelSampleDown2 = function(data) {
	var inputs = "";
	var url = "/system/batchRgst/excelSampleDown2.do";
	var method = "post"
		//data를 입력받음
		if( data ){
			if ($.fn.ifvmIsNotEmpty(data.offerType)) {
				inputs += '<input type="hidden" name="offerType" value="'+ data.offerType +'" />';

				// request를 보낸다.
				jQuery('<form action="'+ url +'" method="'+ (method||'post') +'">'+inputs+'</form>')
				.appendTo('body').submit().remove();
			}
		};
};

//FAQ 샘플 다운로드
function faqSampleDownFn(){
	var data = {};
	data.offerType = "FAQ";
	$.fn.ifvmBatchRgstExcelSampleDown2(data);
}


function faqDetail(id) {
	location.href = '<ifvm:url name="faqDetailUrl"/>' + '?rid=' + id;
}

</script>