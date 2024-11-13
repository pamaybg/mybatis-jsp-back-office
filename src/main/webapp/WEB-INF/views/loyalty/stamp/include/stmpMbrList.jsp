<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var stmpMbrList;

function getStmpMbrList(){
    var ejGridOption = {
//         onSelectRow : function (data) {
//         },
       serializeGridData : function( data ){
			data.ridStmp = ridStmp;
			return data;
        },
//         loadComplete : function(obj){
//         },
        dataUrl : '<ifvm:action name="getLoyStmpMbrList"/>',
        columns:[
        	{
	      		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 'lm.MBR_NO' }
	      	  },{
	      		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 'lc.CUST_NM' }
	      	  },{
	      		  field : 'webId', headerText : 'Web Id', headerTextAlign : 'center', textAlign : 'left', width : '100px',
	      		  customAttributes : {
	      			  index : 'lm.WEB_ID' }
	      	  },{
	      		  field : 'mbrStatCdNm', headerText : '회원상태', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'c1.MARK_NAME' }
	      	  },{
	      		  field : 'stmpJoinDt', headerText : '참여일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'lsm.STMP_JOIN_DT' }
	      	  },{
	      		  field : 'stmpLastAcrlDt', headerText : '최근이용일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'lsm.MODIFY_DATE' }
	      	  },{
	      		  field : 'stmpMbrStatNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width : '100px',
	      		  customAttributes : {
	      			  index : 'lsm.CAM_NM', sortable : false, searchable : false }
	      	  },{
	      		  field : 'stmpMbrCnt', headerText : '적립개수', headerTextAlign : 'center', textAlign : 'right', width : '100px', format : "{0:n0}",
	      		  customAttributes : {
	      			  index : 'stmpMbrCnt', sortable : false, searchable : false }
	      	  },{
	      		  field : 'purAmt', headerText : '누적구매금액', headerTextAlign : 'center', textAlign : 'right', width : '100px', format : "{0:n0}",
	      		  customAttributes : {
	      			  index : 'purAmt', sortable : false, searchable : false }
	      	  },{
	      		  field : 'purCnt', headerText : '누적구매횟수', headerTextAlign : 'center', textAlign : 'right', width : '100px', format : "{0:n0}",
	      		  customAttributes : {
	      			  index : 'purCnt', sortable : false, searchable : false }
	      	  },{
	      		  field : 'stmpMbrBnft', headerText : '지급혜택개수', headerTextAlign : 'center', textAlign : 'right', width : '100px', format : "{0:n0}",
	      		  customAttributes : {
	      			  index : 'stmpMbrBnft', sortable : false, searchable : false }
	      	  },{
	      		  field : 'rid', headerText : 'rid', visible : false,
	      		  customAttributes : {
	      			  index : 'lsm.rid' }
	      	  },
        ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  sidx : 'lsm.MODIFY_DATE',
	      	  sord : 'desc',
	      	  _search : false
	        },
	        rowList : [10,25,50,100],
	        radio: true
    };
    stmpMbrList = $("#stmpMbrListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//스탬프 참여회원목록 엑셀 다운로드
function StmpMbrListExcel() {
	$.ifvExcelDn('<ifvm:action name="excelDownLoyStmpMbrList"/>','stmpMbrListGrid');
}

$(document).ready(function() {

	$.ifvmLnbSetting('stmpList');

	getStmpMbrList();
});
</script>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button" text="다운로드" nuc="true" id="stmpMbrListDownBtn" btnFunc="StmpMbrListExcel" objCode="stmpMbrListDownBtn_OBJ"/>
        </div>
    </div>
    <div id="stmpMbrListGrid" class="white_bg grid_bd0"></div>
</div>
