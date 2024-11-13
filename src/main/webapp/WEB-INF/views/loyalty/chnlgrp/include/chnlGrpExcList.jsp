<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        <span><spring:message code="제외채널 목록"/></span>
        </div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="addChnlExcBtn" text="신규" objCode="chnlGrpExcAdd_OBJ"/>
			<ifvm:inputNew type="button" id="removeChnlExcBtn" text="삭제" objCode="chnlGrpExcRemove_OBJ"/>
			<ifvm:inputNew type="button" id="removeAllTChnlExcBtn" text="전체 삭제" objCode="chnlGrpExcRemoveAll_OBJ"/>
        </div>
    </div>
    <div id="chnlExcListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="addChnlExcPop" class="popup_container"></div>

<script type="text/javascript">
var rid;
var chnlExcListGrid=null;
function getChnlExcList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
    		data.chnlGrpRid = chnlGrp_Rid;
			return data;
		},
		rowSelected : function(args){
        	rid = args.data.rid;
       	},
        dataUrl : '<ifvm:action name="getChnlExcList"/>',

        columns : [
        	{
      		  field : 'chnlNo', headerText : '채널번호', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
      	  },{
    		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center' ,textAlign : 'left',customAttributes :{searchable : true}
    	  },{
    		  field : 'name', headerText : '등록자', headerTextAlign : 'center', textAlign : 'center',customAttributes :{searchable : true}
    	  },{
    		  field : 'createDate', headerText : '등록일자', headerTextAlign : 'center', textAlign : 'center'
    	  },{
    		  field : 'rid', headerText : 'rid',visible : false 
    	  }
        ],

        requestGridData : {
      	  sidx : '1',
      	  sord : 'desc',

        },
    };

    chnlExcListGrid = $("#chnlExcListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

/**
 * 회원샘플다운로드
 */
function excelSampleChnlExc(){
	var data = {};
	data.offerType = "CHNL_GRP";
	$.fn.ifvmBatchRgstExcelSampleDown2(data);
}

//샘플데이터 다운로드
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

function addChnlExc() {
	$("#addChnlExcPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addChnlMultiExc"/>',
        contentType: "ajax",
        title: '채널 조회',
        width: 800,
        close : 'addChnlExcClosePop'
	});
}

function addChnlExcClosePop() {
	addChnlExcPop._destroy();
}


function removeChnlExc() {
	var v_rid;
    if ($.fn.ifvmIsNotEmpty(chnlExcListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = chnlExcListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="삭제할 목록을 클릭해주세요."/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeChnlExc"/>', {
            rid: v_rid
        },
        function(result) {
        	chnlExcListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

function removeAllTChnlExc() {

    	if( confirm('전체 삭제 하시겠습니까?') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeAllTChnlExc"/>', {
            chnlGrpRid : chnlGrp_Rid
        },
        function(result) {
        	chnlExcListGrid._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }

}


$(document).ready(function(){
	
	getChnlExcList();
	
	$("#addChnlExcBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 등록할 수 있습니다.");
			return;
		}
		
		addChnlExc();
	});
	
	$("#removeChnlExcBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 삭제할 수 있습니다.");
			return;
		}
		
		removeChnlExc();
	});
	
	$("#removeAllTChnlExcBtn").click(function() {
		if(statCd!='W') {
			alert("작성중일때만 삭제할 수 있습니다.");
			return;
		}
		
		removeAllTChnlExc();
	});
	



});

</script>