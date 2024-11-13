<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
        <spring:message code="L00648"/>
        &gt;  <spring:message code="M00169"/>
    </h1>
</div>

<div class="page_btn_area" id="headForm">
    <div class="col-xs-7">
        <span>이미지 정보</span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <ifvm:inputNew type="button" id="addChnlImgDetail"  text="상세" objCode="chnlImgInfoDetail_OBJ"/>
        <ifvm:inputNew type="button" id="chnlImgNew"  text="신규" objCode="chnlImgInfoDetailNew_OBJ"/>
        <ifvm:inputNew type="button" id="chnlImgDel"  text="삭제" objCode="chnlImgInfoDetailDel_OBJ"/>
    </div>
</div>
<div id="chnlLoyImgListGrid" class="white_bg grid_bd0"></div>
<div id="chnlLoyImgPopup" class="popup_container"></div>
<div id="chnlLoyImgPopupNew" class="popup_container"></div>
<div id="chnlImgViewPopUp" class="popup_container"></div>

<script type="text/x-jsrender" id="imgTemplate">
 <img src={{:img1}} width="30" height="30">
</script>

<script type="text/javascript">
var pgmRid;
var chnlPgmRid;
var imgUrl=null;
var rid;
function getChnlLoyImageList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		
    		data.chnlRid = channelDetail_rid;
			return data;
		},
		recordDoubleClick : function (args) {
			openChnlImgPop();
		
        },rowSelected : function(args){
       		imgUrl =args.data.img1;
       	},
        dataUrl : '<ifvm:action name="getChnlLoyImgInfoList"/>',

        columns : [
          {
      		  field : 'seqNo', headerText : '순번', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'comments', headerText : '이미지 제목', headerTextAlign : 'center', textAlign:'center', customAttributes :{searchable : true}
    	  },{
    		  field : 'img2', headerText : '이미지', headerTextAlign : 'center', textAlign : 'center', template : '#imgTemplate', 
    	  },
    	  {
    		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center' 
    	  },{
    		  field : 'createBy', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center' 
    	  },{
    		  field : 'modifyDate', headerText : '수정일자', headerTextAlign : 'center', textAlign : 'center' 
    	  },{
    		  field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center', textAlign : 'center' 
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : '1',
      	  sord : 'desc',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    chnlLoyImgListGrid = $("#chnlLoyImgListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function openChnlImgPop(){
	$("#chnlImgViewPopUp").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlImgViewPop"/>',
        contentType: "ajax",
        title: '이미지',
        width: 600,
        close : 'openChnlImgPopClose'
	});
}
function chnlLoyImgPopupfn() {
	$("#chnlLoyImgPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addChnlLoyImgDetail"/>',
        contentType: "ajax",
        title: '이미지 정보 상세',
        width: 600,
        close : 'addChnlImgPopupClose'
	});
}

function addNewChnlLoyImgPopup() {
	$("#chnlLoyImgPopupNew").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addChnlLoyImgNewPop"/>',
        contentType: "ajax",
        title: '이미지 등록',
        width: 600,
        close : 'addChnlNewImgPopupClose'
	});
}

function openChnlImgPopClose() {
	chnlImgViewPopUp._destroy();
}

function addChnlImgPopupClose() {
	chnlLoyImgPopup._destroy();
}

function addChnlNewImgPopupClose() {
	chnlLoyImgPopupNew._destroy();
}

//삭제
function chnlImgDelfn(){
	if( confirm('<spring:message code="I01500"/>')){
	$.ifvSyncPostJSON('<ifvm:action name="getLoyImgDel"/>', {
			rid : chnlLoyImgListGrid.opt.gridControl.getSelectedRecords()[0].rid
		}, function(result) {
		
		chnlLoyImgListGrid._doAjax();
		alert('<spring:message code="I00726"/>');
	});
	}
}


$(document).ready(function(){
	getChnlLoyImageList();
	
	// 상세
	$("#addChnlImgDetail").click(function() {		
		if ($.fn.ifvmIsNotEmpty(chnlLoyImgListGrid.opt.gridControl.getSelectedRecords()[0])) {
			chnlLoyImgPopupfn();
		}else{
			 alert('목록을 선택해주세요.');
		}
	});
	//chnlImgNew
	$("#chnlImgNew").click(function() {
		addNewChnlLoyImgPopup();
	});
	
	//삭제	
	$("#chnlImgDel").click(function() {
		if ($.fn.ifvmIsNotEmpty(chnlLoyImgListGrid.opt.gridControl.getSelectedRecords()[0])) {
			chnlImgDelfn();
		}else{
			alert('목록을 선택해주세요.');
		}
	});
});

</script>