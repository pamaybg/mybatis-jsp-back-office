<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="mbrLinkTemplate">
	<a href="<ifvm:url name="mbrDetailNew"/>?rid={{:ridMbr}}&tabid=mbrEventHistoryList" style="color:#1266FF; text-decoration:underline;" >{{:mbrNo}}</a>
</script>

<div class="page-title">
    <h1>
        <spring:message code="L02522" />
        <span>&gt;<spring:message code="L00081"/></span>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="pointListSearchBtn" btnFunc="attendeListSearch"/>
            <ifvm:inputNew type="button"   text="M00278"  id="pointListSearchInitBtn" btnFunc="attendanceListSearchInit(attendanceGridGrid)"/>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="attendanceSearchList">
    </div>
</div>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L00033" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<button class="btn btn-sm" id="excelListBtn">
             	<spring:message code="M01218" />
         	</button>
         	<button class="btn btn-sm" id="clearMaskBtn">
             	<spring:message code="L00326" />
         	</button>
        </div>
    </div>
	<div class="row qt_border">

		<div class="half_content half_left" style="display: inline-block; border: solid 1px lightgray;">
			<div class="col-xs-2 conterl_content" style="display: inline-block; border-right: solid 1px lightgray; padding: 8.5px 0; text-align: center;">
				<label class=" control-label">포인트</label>
			</div>
			<div class="col-xs-2 control_content" style="text-align: center;">
				<span>적립누계</span>
				<ifvm:input type="text" id="acrl" names="acrl" className="text-right" readonly="readonly" />
			</div>
			<div class="col-xs-2 control_content" style="text-align: center;">
				<span>100P</span>
				<ifvm:input type="text" id="tot100p" names="tot100p" className="text-right" readonly="readonly"/>
			</div>
			<div class="col-xs-2 control_content" style="text-align: center;">
				<span>200P</span>
				<ifvm:input type="text" id="tot200p" names="tot200p" className="text-right"  readonly="readonly"/>
			</div>
			<div class="col-xs-2 control_content" style="text-align: center; ">
				<span>500P</span>
				<ifvm:input type="text" id="tot500p" names="tot500p" className="text-right"  readonly="readonly"/>
			</div>
			<div class="col-xs-2 control_content" style="text-align: center; ">
				<span>5000P</span>
				<ifvm:input type="text" id="tot5000p" names="tot5000p" className="text-right"  readonly="readonly"/>
			</div>
		</div>
		
		<div class="half_content half_left text-center" style="display: inline-block; border: solid 1px lightgray;">
			<div class="col-xs-2 conterl_content" style="display: inline-block; border-right: solid 1px lightgray; padding: 8.5px 0; text-align: center;">
				<label class=" control-label">참여현황</label>
			</div>
			<div class=" control_content" style="text-align: center;  width: 13.85%; float: left;">
				<span>참여횟수</span>
				<ifvm:input type="text" id="acrlJoin" names="acrlJoin" className="text-right" readonly="readonly" />
			</div>
			<div class=" control_content" style="text-align: center; width: 13.85%; float: left;">
				<span>참여인원</span>
				<ifvm:input type="text" id="acrlMbr" names="acrlMbr" className="text-right" readonly="readonly" />
			</div>
			<div class=" control_content" style="text-align: center; width: 13.85%; float: left;">
				<span>100P</span>
				<ifvm:input type="text" id="rate100p" names="rate100p" className="text-right" readonly="readonly"/>
			</div>
			<div class=" control_content" style="text-align: center; width: 13.85%; float: left;">
				<span>200P</span>
				<ifvm:input type="text" id="rate200p" names="rate200p" className="text-right" readonly="readonly"/>
			</div>
			<div class=" control_content" style="text-align: center; width: 13.85%; float: left;">
				<span>500P</span>
				<ifvm:input type="text" id="rate500p" names="rate500p" className="text-right" readonly="readonly"/>
			</div>
			<div class=" control_content" style="text-align: center; width: 13.85%; float: left;">
				<span>5000P</span>
				<ifvm:input type="text" id="rate5000p" names="rate5000p" className="text-right" readonly="readonly"/>
			</div>
		</div>
	</div>
	<div class="row qt_border">
		<div class="half_content half_left" style="display: inline-block; border: solid 1px lightgray;">
			<div class="col-xs-2 conterl_content" style="display: inline-block; border-right: solid 1px lightgray; padding: 8.5px 0; text-align: center;">
				<label class=" control-label">연령대</label>
			</div>
			<div class=" control_content" style="text-align: center; width: 13.85%; float: left;">
				<span>10대</span>
				<ifvm:input type="text" id="10s" names="10s" className="text-right" readonly="readonly" />
			</div>
			<div class=" control_content" style="text-align: center; width: 13.85%; float: left;">
				<span>20대</span>
				<ifvm:input type="text" id="20s" names="20s" className="text-right" readonly="readonly" />
			</div>
			<div class=" control_content" style="text-align: center; width: 13.85%; float: left;">
				<span>30대</span>
				<ifvm:input type="text" id="30s" names="30s" className="text-right" readonly="readonly"/>
			</div>
			<div class=" control_content" style="text-align: center; width: 13.85%; float: left;">
				<span>40대</span>
				<ifvm:input type="text" id="40s" names="40s" className="text-right" readonly="readonly"/>
			</div>
			<div class=" control_content" style="text-align: center; width: 13.85%; float: left;">
				<span>50대</span>
				<ifvm:input type="text" id="50s" names="50s" className="text-right"  readonly="readonly"/>
			</div>
			<div class=" control_content" style="text-align: center; width: 13.85%; float: left;">
				<span>60대이상</span>
				<ifvm:input type="text" id="over60s" names="over60s" className="text-right" readonly="readonly"/>
			</div>
		</div>
	</div>
	<div id="attendanceGridGrid" class="white_bg grid_bd0 grid_scroll5"></div>   
</div>

<script type="text/javascript">
var attendanceGrid;

//공통 조회 조건 목록 설정
function attendanceListSearchInit(gridId) {

    $.fn.ifvmSetCommonCondList("attendanceSearchList","LOY_PST_MBR_EVT", gridId);
    searchInitialize();
}

function searchInitialize(){
	$(".SearchCondition .searchCondition option[value='LIKE']").remove();
	$(".SearchCondition .searchCondition option[value='NOT']").remove();
}
//목록 조회
function makeAttendanceGrid(){
    var ejGridOption = {
    	rowSelected : function (args) {
 	        	rid=args.data.rid;
 	        },
      	serializeGridData : function(data){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }
            return data;
       	},
       	loadComplete : function(obj){
        	$("#excelListBtn").prop('disabled',false);
        },
       	dataUrl : '<ifvm:action name="getAttendanceList"/>',
       	columns : [ 
      	  	  {
	      		  field : 'pstDt', headerText : '<spring:message code="L02610" />', headerTextAlign : 'center', textAlign : 'center', width : '50px', 
	      		  customAttributes : {
	      			  index : 'lpme.pst_dt' }/* 출석일자 --> 참여일자 */
	      	  },{
	      		  field : 'modifyDate', headerText : '<spring:message code="L02611" />', headerTextAlign : 'center', textAlign : 'center', width : '50px',
	      		  customAttributes : {
	      			  index : 'lpme.modify_date' }/* 이벤트 일시-->참여시간 */
	      	  },{
	      		  field : 'custNm', headerText : '<spring:message code="L00435" />', headerTextAlign : 'center', textAlign : 'center', width : '40px',
	      		  customAttributes : {
	      			  index : 'lc.cust_nm' }/* 회원명 */
	      	  },{
	      		  field : 'mbrNo', headerText : '<spring:message code="L00690" />', headerTextAlign : 'center', textAlign : 'center', width : '60px',template: "#mbrLinkTemplate",
	      		  customAttributes : {
	      			  index : 'lm.mbr_no' }/* 회원번호 */
	      	  },{
	    		  field : 'genGbnCd', headerText : '<spring:message code="L00341"/>', headerTextAlign : 'center', textAlign :  'center', width : '50px', 
	    		  customAttributes : {
	    			  index : 'lc.GEN_GBN_CD' } /* 성별 */
	    	  },{
	    		  field : 'age', headerText : '<spring:message code="L02526"/>', headerTextAlign : 'center', textAlign :  'center', width : '50px', 
	    		  customAttributes : {
	    			  index : 'lc.BIRTH_DT' } /* 나이 */
	    	  },{
	    		  field : 'smokeYn', headerText : '<spring:message code="L02598"/>', headerTextAlign : 'center', textAlign :  'center', width : '50px', 
	    		  customAttributes : {
	    			  index : 'lm.SMOKING_YN' } /* 흡연여부 */
	    	  },{
	      		  field : 'mbrStat', headerText : '<spring:message code="L01454" />', headerTextAlign : 'center', textAlign : 'center', width : '60px',
	      		  customAttributes : {
	      			  index : 'cc.MARK_NAME' }/* 회원상태 */
	      	  },{
	      		  field : 'pntAmt', headerText : '<spring:message code="L00592" />', headerTextAlign : 'center', textAlign : 'right',  width : '60px', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'lpme.pnt_amt' }/* 적립포인트 */
	      	  },{
	      		  field : 'pstMbrRid', headerTextAlign : 'center', textAlign : 'center', visible : false,
	      		  customAttributes : {
	      			  index : 'lpme.rid' }/* 회원RID*/
	      	  },{
	    		  field : 'ridMbr', headerText : 'ridMbr', visible: false,
	    		  customAttributes : {
	    			  index : 'lm.ridMbr' }
	      	  
	      	 /*{
      		  field : 'txnUniqNo', headerText : '<spring:message code="L00933" />', headerTextAlign : 'center', textAlign : 'center',  width : '100px',
      		  customAttributes : {
      			  index : 'lpme.txn_uniq_no' } 거래번호  }*/ 
	    	},
      ],
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  autowidth : true,
	      	  sidx : 'lpme.create_date',
	      	  sord : 'desc',
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
	    radio: true,
        gridDataInit: false,
        tempId : 'ifvGridSimplePageTemplete2'
    };
    attendanceGrid = $('#attendanceGridGrid').ifvsfGrid({ejGridOption : ejGridOption});
}

$(document).ready(function() {
	$("#excelListBtn").prop('disabled',true);
	//공통 조회 조건 목록 설정
	attendanceListSearchInit();
	
	makeAttendanceGrid();
	
	
	//마스킹해제 클릭시
	$('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
	
	//조회결과 엑셀다운로드
    $("#excelListBtn").on('click', function() {
      	$.ifvExcelDn('/loyalty/event/excelDownAttendanceList.do','attendanceGridGrid' );
    });
});

function attendeListSearch() {
	$.fn.ifvmSubmitSearchCondition_NoAllSearch("attendanceSearchList", function() {
		if($.fn.ifvmIsNotEmpty(requestitem)){
			totAcrlPoint();
			totAcrlRate();
			getGroupAge();
			attendanceGrid.searchGrid({item: requestitem});
		} else {
			alert('<spring:message code="L02383"/>');
		}
	});
}

function clearMaskAction() {
	var v_rid;
		if ($.fn.ifvmIsNotEmpty(attendanceGrid.opt.gridControl.getSelectedRecords()[0])) {
			v_rid = attendanceGrid.opt.gridControl.getSelectedRecords()[0].pstMbrRid;
		}
		else {
			alert('<spring:message code="M02219"/>');
		}
		
		if ($.fn.ifvmIsNotEmpty(v_rid)) {
			$.ifvSyncPostJSON('<ifvm:action name="clearMaskAttendance"/>',{
				pstMbrRid: v_rid
			},
			function(result) {
				var gridObj = attendanceGrid.opt.gridControl;
				var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
				gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
			});
		}
	}
	
function totAcrlPoint() {
	$.ifvPostJSON('<ifvm:action name="getAttendAcrlPoint"/>',{
		item : requestitem
	},function(result){
		if(result.acrlAmt == '0'){
			$('#acrl').val(0);
			$('#tot100p').val(0);
			$('#tot200p').val(0);
			$('#tot500p').val(0);
			$('#tot5000p').val(0);
		}else{
			$('#acrl').val((numberWithCommas(result.acrlAmt)));
			$('#tot100p').val((numberWithCommas(result.tot100p)));
			$('#tot200p').val((numberWithCommas(result.tot200p)));
			$('#tot500p').val((numberWithCommas(result.tot500p)));
			$('#tot5000p').val((numberWithCommas(result.tot5000p)));
		}
	},function(result){
		alert(result.message);
	});
}
function numberWithCommas(str) {
	return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function totAcrlRate(){
	$.ifvPostJSON('<ifvm:action name="getAttendAcrlJoin"/>',{
		item : requestitem
	},function(result){
		if(result.acrlJoin == '0' ||  result.acrlMbr == '0' || result.rate100p  == '0' || result.rate200p  == '0' || result.rate500p  == '0' || result.rate5000p == '0' ){
			$('#acrlJoin').val(0);
			$('#acrlMbr').val(0);
			$('#rate100p').val(0);
			$('#rate200p').val(0);
			$('#rate500p').val(0);
			$('#rate5000p').val(0);
		}else{
			$('#acrlJoin').val(numberWithCommas(result.acrlJoin));
			$('#acrlMbr').val(numberWithCommas(result.totMbr));
			$('#rate100p').val(numberWithCommas(result.cnt100p)+" ("+ ((result.cnt100p/result.acrlJoin)*100).toFixed(1) +"%)");
			$('#rate200p').val(numberWithCommas(result.cnt200p)+" ("+ ((result.cnt200p/result.acrlJoin)*100).toFixed(1) +"%)");
			$('#rate500p').val(numberWithCommas(result.cnt500p)+" ("+ ((result.cnt500p/result.acrlJoin)*100).toFixed(1) +"%)");
			$('#rate5000p').val(numberWithCommas(result.cnt5000p)+" ("+ ((result.cnt5000p/result.acrlJoin)*100).toFixed(1) +"%)");
		}
	},function(result){
		alert('<spring:message code="L02627" />');
	});
}

function getGroupAge(){
	$.ifvPostJSON('<ifvm:action name="getAttendAgeGroupCnt"/>',{
		item : requestitem
	},function(result){
		if ($.fn.ifvmIsNotEmpty(result)){
			$('#10s').val(numberWithCommas(result.s10));
			$('#20s').val(numberWithCommas(result.s20));
			$('#30s').val(numberWithCommas(result.s30));
			$('#40s').val(numberWithCommas(result.s40));
			$('#50s').val(numberWithCommas(result.s50));
			$('#over60s').val(numberWithCommas(result.over60s));
		} else{
			$('#10s').val(0);
			$('#20s').val(0);
			$('#30s').val(0);
			$('#40s').val(0);
			$('#50s').val(0);
			$('#over60s').val(0);
		}
	},function(result){
		alert('<spring:message code="L02628" />');
	});
}



</script>