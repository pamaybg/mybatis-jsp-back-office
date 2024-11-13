<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        	<span><spring:message code="동의" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" id="agreHistbtn" text="이력" btnFunc="" objCode=""/>
        	<ifvm:inputNew type="button" id="agreDetailInfoPopBtn" text="약관내용"  objCode=""/>   
        </div>
    </div>
    <div id="custAgreListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="agreHistpop" class="popup_container"></div>

<script type="text/javascript">
var agreRid=null;
var agreTypeCd=null;
function getCustAgreList(){

    var ejGridOption = {
    	serializeGridData : function(data) {
			data.rid = cust_rid;
			return data;
		},
		rowSelected : function(args) {
			agreRid = args.data.custRid;
			agreTypeCd = args.data.agreTypeCd;
		},
        dataUrl : '<ifvm:action name="getCustAgreList"/>',

        columns : [
        	{
      		  field : 'agreTypeCdNm', headerText : '항목', headerTextAlign : 'center', textAlign : 'left', customAttributes :{index : 'agreTypeCd'}
      	  },{
    		  field : 'ver', headerText : '버전', headerTextAlign : 'center', textAlign : 'center', customAttributes :{searchable : true} , format : '{0:n1}'
    	  },{
    		  field : 'regDate', headerText : '동의일자', headerTextAlign : 'center', textAlign : 'center',
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
      	  sidx : '5',
      	  sord : 'ASC',
      	  _search : false,

        },
        rowList : [10,25,50,100],
        gridDataInit: true,
        radio: true
    };

    custAgreListGrid = $("#custAgreListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
function termsDetailInfoPop() {
	var t_rid;
	 if($(custAgreListGrid.opt.gridControl.getSelectedRecords()).length==0){
		   alert('<spring:message code="M01051"/>');
	 }else{
		 
		 termVerRid = mbrAgreListGrid.opt.gridControl.getSelectedRecords()[0].termVerRid;
		 if(termVerRid == null || termVerRid=='undefined') {
			 alert('약관 내용이 없습니다.');
			 return;
		 }
		 
		 t_rid = custAgreListGrid.opt.gridControl.getSelectedRecords()[0].termVerRid;
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
	getCustAgreList();
	
	$("#agreHistbtn").click(function() {
		if(agreRid==null) {
			alert("목록을 선택해주세요.");
			return;
		}
		agreHistpopup();
	});
	
	$("#agreDetailInfoPopBtn").click(function() {
		termsDetailInfoPop();
	});
});

</script>