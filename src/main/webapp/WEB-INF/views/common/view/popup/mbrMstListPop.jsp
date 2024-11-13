<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var mbrMstPopList;

// 회원마스터 조회
function mbrMstPopList(){
	var ejGridOption = {
        loadComplete : function(obj){
    		//로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
    		//$.fn.ifvmComCondLogging("LOY_MBR_NEW_LIST", mbrListPopGrid.opt.data.records);
        },
		serializeGridData : function(data) {
			return data;
		},recordDoubleClick : function(args){
			var data = args.data;
		},rowSelected : function (args) {
			var data = args.data;
    	},
	    dataUrl : '<ifvm:action name="getMbrMstPop"/>',
	    columns : [
	    	{
	  		  field : 'mbrNo', headerText : '<spring:message code="L00433"/>', textAlign : 'center', customAttributes : { searchable : true }
	  	  },{
			  field : 'custNm', headerText : '<spring:message code="L00435"/>',  textAlign : 'center',customAttributes : { searchable : true }
		  },{
			  field : 'tierNm', headerText : '<spring:message code="L00324"/>',  textAlign : 'center',customAttributes : { searchable : true }
		  },{
			  field : 'hhp', headerText : '전화번호',  textAlign : 'center',customAttributes : { searchable : true }
		  },{
			  field : 'email', headerText : '이메일',  textAlign : 'center',customAttributes : { searchable : true }
		  },{
			  field : 'mbrTypeCdNm', headerText : '유형',  textAlign : 'center', customAttributes : { index : 'mbrTypeCd' }
		  },{
			  field : 'mbrStatCdNm', headerText : '상태',  textAlign : 'center', customAttributes : { index : 'mbrStatCd' }, visible : false
		  },{
			  field : 'sbscDate', headerText : '가입일',  textAlign : 'center', customAttributes : { searchable : true }, visible : false
		  },{
			  field : 'ridsbscChnl', headerText : '가입채널', customAttributes : { searchable : true }, visible : false
		  }, {
			  field : 'createDate', headerText : '등록일시',  textAlign : 'center', visible : false
		  },{
			  field : 'rid', visible: false
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
	    gridDataInit: false,
	    radio: true,
	    tempId : 'ifvGridSimplePageTemplete'
	};
	mbrMstPopList = $("#mbrMstPopList").ifvsfGrid({ ejGridOption : ejGridOption });
}

/* function mbrMstPopList(){
		var jqGridOption = {
			serializeGridData : function( data ){
			},
			ondblClickRow : function(row){
			},
			onSelectCell : function (data) {
			},
			loadComplete : function(data){
			},
		    url:'<ifv:action name="getMbrMstPop"/>',
		    colNames:[
	              // '회원번호','회원 명','등급', '회원 유형', '회원상태', '휴대폰번호','rid','emailAddr','mbrTypeCd','custTypeCd','identiTypeCd','identiVal','clearMask'
	              	'<spring:message code="L00433"/>',
	              	'<spring:message code="L00435"/>',
	              	'<spring:message code="L00324"/>',
	              	'<spring:message code="L00434"/>',
	              	'<spring:message code="L00090"/>',
	              	'<spring:message code="L00436"/>',
	              	'rid','emailAddr','mbrTypeCd','custTypeCd','identiTypeCd','identiVal','clearMask'
	              	],
		    colModel:[{name:'mbrNo', index:'lm.MBR_NO', width: "100px", align:'center', formatter: goGridRowMbrLink},
		              {name:'custNm', index:'lm.cust_nm_decoding', width: "120px"},
		              {name:'tierNm', index:'lt.TIER_NM', width: "110px"},
		              {name:'mbrTypeNm', index:'cc1.MARK_NAME', width: "80px", align:'center'},
		              {name:'mbrStatNm', index:'cc2.MARK_NAME', width: "80px", align:'center'},
		              {name:'hhpNo', index:'lm.hhp_no_decoding', width: "120px"},
		              {name:'rid', index:'lm.rid', hidden : true},
		              {name:'emailAddr', index:'lm.email_addr_decoding', hidden : true},
		              {name:'mbrTypeCd', index:'lm.MBR_TYPE_CD', hidden : true},
		              {name:'custTypeCd', index:'lm.cust_type_cd', hidden : true},
		              {name:'identiTypeCd', index:'lm.identi_type_cd', hidden : true},
		              {name:'identiVal', index:'lm.identi_val_decoding', hidden : true},
		              {name:'clearMask'	,hidden : true ,searchable : false}
				      ],
			radio:true,
			sortname: 'lm.CREATE_DATE',
			autowidth : true , sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
		};
		mbrMstPopList = $("#mbrMstPopList").ifvGrid({ jqGridOption : jqGridOption });
} */

//그리드 텍스트 선택시 상세로 이동  참고 샘플
// formatter: goGridRowMbrLink - mbrNo column 에 넣어줌
/* function goGridRowMbrLink(cellvalue, options, rowObjec){
	var mbrNo = rowObjec.mbrNo;
    var url = '<ifvm:url name="mbrDetail"/>' + '?mbrNo=' + mbrNo;
    var tag=null;

    if(cellvalue!=null){
        tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
} */

//마스크해제
/* function mbrClearMaskAction() {
	var selectData = mbrMstPopList.getCheckedGridData();

	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		var v_rid;
		if ($.fn.ifvmIsNotEmpty(mbrMstPopList.getCheckedGridData()[0])) {
			v_rid = mbrMstPopList.getCheckedGridData()[0].rid;
		}

		if ($.fn.ifvmIsNotEmpty(v_rid)) {
			$.ifvSyncPostJSON('<ifv:action name="getMbrMstClearMask"/>', {
			    rid: v_rid
			},
			function(result) {
			 	var rowid = mbrMstPopList.getRadioSelectedRowId();
			 	mbrMstPopList.opt.grid.setCell( rowid, 'custNm' , result.custNm );  		// 고객명 세팅
			 	mbrMstPopList.opt.grid.setCell( rowid, 'hhpNo' , result.hhpNo ); 			// 휴대폰번호
			 	mbrMstPopList.opt.grid.setCell( rowid, 'emailAddr' , result.emailAddr  ); // 이메일
			 	mbrMstPopList.opt.grid.setCell( rowid, 'identiVal' , result.identiVal ); 	// 식별값 세팅
			 	mbrMstPopList.opt.grid.setCell( rowid, 'clearMask' , 'Y' ); 				// 마스크 해제 여부
			});
		}
	}
} */

function clearMaskAction() {
	  var v_rid;
	  if ($.fn.ifvmIsNotEmpty(mbrMstPopList.opt.gridControl.getSelectedRecords()[0])) {
	  	v_rid = mbrMstPopList.opt.gridControl.getSelectedRecords()[0].rid;
	  }
	  else {
	      alert('<spring:message code="M00004"/>');
	  }
	  if ($.fn.ifvmIsNotEmpty(v_rid)) {
	      $.ifvSyncPostJSON('<ifvm:action name="getMbrMstClearMask"/>', {
	          rid: v_rid
	      },
	      function(result) {
	      	var gridObj = mbrListPopGrid.opt.gridControl;
	      	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
		 	//mbrMstPopList.opt.grid.setCell( rowid, 'custNm' , result.custNm );  		// 고객명 세팅
		 	//mbrMstPopList.opt.grid.setCell( rowid, 'hhpNo' , result.hhpNo ); 			// 휴대폰번호
		 	//mbrMstPopList.opt.grid.setCell( rowid, 'emailAddr' , result.emailAddr  ); // 이메일
		 	//mbrMstPopList.opt.grid.setCell( rowid, 'identiVal' , result.identiVal ); 	// 식별값 세팅
		 	//mbrMstPopList.opt.grid.setCell( rowid, 'clearMask' , 'Y' ); 				// 마스크 해제 여부
	      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.custNm);
	      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.hhp);
	      	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('email'), result.email);
	      });
	  }
}

function checkButtnAuth(){
	var isAuth = false;
	var authArr = $.ifvmGetAuthInfo().authList;
	for(var i = 0 ; i < authArr.length ; i++){
		var authObj = authArr[i];
		var authName = authObj.authName;
		if(authName == 'E10010') isAuth = true;
	}
	if(!isAuth){
		$("#mbrClearMaskBtn").remove();
	}

}
$(document).ready(function() {
	//마스킹해제 권한 체크
	//checkButtnAuth();
	mbrMstPopList();


	$("#btnSelect").on('click', function(){
		mbrMstArr = null;
		if(mbrMstPopList.getCheckedGridData() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = mbrMstPopList.getCheckedGridData();
    		if(dataArr[0].clearMask != "Y"){
    			alert('<spring:message code="L00440"/>');
    		}else {
	    		mbrMstArr = dataArr;
	    		mbrMstPopClose();
    		}
    	}
	});

	$("#btnCancel").on('click', function(){
		mbrMstArr = null;
		mbrMstPopClose();
	});

	//마스킹해제 클릭시
    $('#mbrClearMaskBtn').on('click', function(){
        mbrClearMaskAction();
    });
});
</script>

<div id="pop_main_div">
	<div class="page_btn_area" id=''>
       <div class="col-xs-7"></div>
       <div class="col-xs-5 searchbtn_r">
           <button class="btn btn-sm" id="mbrClearMaskBtn"><spring:message code="L00326"/></button>
        </div>
    </div>

    <div id='mbrMstPopFormArea'>
    	<div class="pop_inner_wrap">
    		<div id="mbrMstPopList" class="grid_bd0 grid_w660"></div>
    	</div>
    	<div class="pop_btn_area">
    		<button class="btn btn-sm btn_gray" id="btnSelect">
    			<i class="glyphicon glyphicon-check" ></i>
    			<spring:message code="M00282"/>
    		</button>
    		<button class="btn btn-sm btn_lightGray2" id="btnCancel">
    			<spring:message code="M00284"/>
    	    </button>
    	</div>
    </div>
</div>