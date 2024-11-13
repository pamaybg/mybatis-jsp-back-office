<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        	<span><spring:message code="동의 이력" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="agreHistbtn" text="이력"  objCode="agreHistbtn_OBJ"/>
			<ifvm:inputNew type="button" id="agreDetailInfoPopBtn" text="약관내용"  objCode="agreDetailInfoPopBtn_OBJ"/>
        </div>
    </div>
    <br>
    <div id="mbrAgreListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="agreHistpop" class="popup_container"></div>

<script type="text/javascript">
var agreRid=null;
var agreTypeCd=null;
function getMbrAgreList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = mbr_rid;
			data.ridCust = custRid;
			data.ridPgm = pgmRid;
			return data;
		},
		rowSelected : function(args) {
			agreRid = args.data.custRid;
			agreTypeCd = args.data.agreTypeCd;
		},
        dataUrl : '<ifvm:action name="getMbrAgreList"/>',

        columns : [
        	{
      		  field : 'agreTypeCdNm', headerText : '항목', headerTextAlign : 'center', textAlign : 'left', customAttributes :{index : 'agreTypeCd'}
      	  },{
    		  field : 'ver', headerText : '버전', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true} , format : '{0:n1}'
    	  },{
    		  field : 'agreYn', headerText : '동의여부', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true}
    	  },{
    		  field : 'regDate', headerText : '최종 변경일자', headerTextAlign : 'center', textAlign : 'center',
    	  },{
    		  field : 'custRid', headerText : 'custRid', headerTextAlign : '' ,visible: false,
    	  },{
    		  field : 'agreTypeCd', headerText : 'agreTypeCd', headerTextAlign : '' ,visible: false,
    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
    	  },{
    		  field : 'termRid', headerText : 'termRid', headerTextAlign : '' ,visible: false,
    	  },{
    		  field : 'termVerRid', headerText : 'termVerRid', headerTextAlign : '' ,visible: false,
    	  }
        ],

        requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'agreTypeCd ASC, ver',
      	  sord : 'ASC',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true,
        tempId : 'ifvGridSimplePageTemplete'
    };

    mbrAgreListGrid = $("#mbrAgreListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function agreHistpopup() {
	$("#agreHistpop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="agreHistpop"/>',
        contentType: "ajax",
        title: '동의 이력 상세 조회',
        width: 1000,
        close : 'agreClosepop'
    });
}

function agreClosepop() {
	agreHistpop._destroy();
}

//상세 팝업 화면 호출
function termsDetailInfoPopOpen() {
	var t_rid;
	
	 if(mbrAgreListGrid.opt.gridControl.getSelectedRecords().length==0){
		   alert('<spring:message code="M01051"/>');
	 }else{
		 termVerRid = mbrAgreListGrid.opt.gridControl.getSelectedRecords()[0].termVerRid;
		 if(termVerRid == null || termVerRid=='undefined') {
			 alert('약관 내용이 없습니다.');
			 return;
		 }
		 t_rid = mbrAgreListGrid.opt.gridControl.getSelectedRecords()[0].termVerRid;
		 $.ifvSyncPostJSON('<ifvm:action name="getTermsInfoDetail"/>', {
			 termVerRid : t_rid
		 },function(result){
			 var popUrl= '<ifvm:url name="termsMbrInfoPop"/>?rid='+t_rid;
			 var popOption ="width=900, height=800, resizable=no, scrollbars=no, status=no;";
			window.open(popUrl,"",popOption);
		 },function(result){
			 alert(result.message);
		 });
	 }
}

$(document).ready(function(){
	getMbrAgreList();
	
	$("#agreHistbtn").click(function() {
		 if(mbrAgreListGrid.opt.gridControl.getSelectedRecords().length==0){
			alert("목록을 선택해주세요.");
			return;
		}
		agreHistpopup();
	});
	
	$("#agreDetailInfoPopBtn").click(function() {
		
		termsDetailInfoPopOpen();
	});
});

</script>