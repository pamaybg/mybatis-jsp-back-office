<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script type="text/javascript">
var mbrNo = '<%= cleanXss(request.getParameter("mbrNo")) %>';
var ivrSvcCd  = '<%= cleanXss(request.getParameter("ivrSvcCd")) %>';
var mbrListGrid;
gMbrList = {
		init : function(){
			//this.buttonAuth();
			//$("#mbrListGrid").ifvGrid({ jqGridOption : {} });
			$.ifvEnterSetting(["#searchFormArea input"], function(){
				gMbrList.search();
			});
			/* var birthDt  = $('#birthDt');
		    birthDt.val();
		    birthDt.ifvDateChecker({}); */
		    this.setMaskingBtn();

		    if(mbrNo != 'null'){
		    	$("#searchFormArea #mbrNo").val(mbrNo);
		    	gMbrList.search();
		    }
		    if(window.parent.CTI.ivrSvcCd != 'null'){
		    	$("#ivrCode").val(window.parent.CTI.ivrSvcCd); //세션 변수로 변경해야 함
		    }

		},
		buttonAuth : function(){
			//탈회 버튼권한
			/* var isAuth = false;
			var authArr = $.ifvmGetAuthInfo().authList;
			for(var i = 0 ; i < authArr.length ; i++){
				var authObj = authArr[i];
				var authName = authObj.authName;
				if(authName == 'E10009') isAuth = true;
			}
			if(!isAuth){
				$("#clearMaskingBtn").remove();
			} */
		},
		loadData : function(){
			mbrListGrid = $("#mbrListGrid").ifvGrid({ jqGridOption : gMbrList.jqGridOption });
			this.setMaskingBtn();
		},
		searchInit : function(){//초기화
			$("#searchFormArea input").val("");
			this.setMaskingBtn();
		},
		search : function(){//조회
			//조회 조건 미 입력시 return
	    	var valiCheck = $("#searchFormArea").ifvValidation();
	    	var isValue = false;
	    	if(valiCheck.confirm()){
	    		$("#searchFormArea input").filter(function(){
	    			if(this.value != ""){isValue = true;}
	    		});
	    		if($("#searchFormArea #custNm").val().length ==1){
	    			alert('<spring:message code="L01986"/>');//회원명은 한 자 이상 입력해주세요
	    			return;
	    		}

	    		if(!isValue){
					alert('<spring:message code="L01608"/>')//조회 조건을 입력해주세요
				}else{
					//submitData : 무슨조건르로 조회했는지 로그기록에 남겨야 한다.
					if(mbrListGrid){
						var submitData = $("#searchFormArea").getSubmitData();
						submitData.bonusCardNo = submitData.bonusCardNo.replaceAll("-","");
						submitData.hhpNo = submitData.hhpNo.replaceAll("-","");
						submitData.birthDt = submitData.birthDt.replaceAll("-","");
						mbrListGrid.requestData(submitData);
					}else{
						this.loadData();
					}
				}
	    	}
		},
		moveDetail : function(id){
			//location.href = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
			qtjs.href('<ifvm:url name="mbrDetail"/>' + '?rid=' + id);
		},
		clearMasking : function(){
			var selectedRid = mbrListGrid.getCheckedList()[0].rid;
			var targetField = [{
				type : 'mbr',
				field : 'phone',
				rid : selectedRid,
				target : 'hhpNo'
			}, {
				type : 'mbr',
				field : 'email',
				rid : selectedRid,
				target : 'emailAddr'
			}]

			for (var i=0  ; i < targetField.length ; i++){
				$.ifvSyncPostJSON('<ifvm:action name="getMasking"/>',
						targetField[i],
		        function(result) {
					var rowid = mbrListGrid.getRadioSelectedRowId();
		        	mbrListGrid.opt.grid.setCell(rowid , targetField[i].target , result.message );
			     })
			}


		},
		setMaskingBtn : function(){ //마스킹해제 버튼 상태 컨트롤
			if(!mbrListGrid || mbrListGrid.getRowData().length == 0){
				$("#clearMaskingBtn").prop("disabled",true);
			}else{
				//var selectedRow = mbrListGrid.getCheckedList();
				if(mbrListGrid.getCheckedList().length == 1){
					$("#clearMaskingBtn").prop("disabled",false);
				}else{
					$("#clearMaskingBtn").prop("disabled",true);
				}
			}
		},
		jqGridOptionInit : {
			colNames:[
	                  '<spring:message code="L00433"/>',
	                  '<spring:message code="L00435"/>',
	                  '<spring:message code="L00436"/>',
	                  '<spring:message code="L00786"/>',
	                  '<spring:message code="L00557"/>',
	                  '<spring:message code="L00187"/>',
	                  '<spring:message code="L00395"/>',
	                  '<spring:message code="L00651"/>',
	                  'rid'
	                ],
           colModel:[
  		           { name:'mbrNo', 	    index:'lm.mbr_no', 			width:'80px', 	align: 'center', 	resizable : false },
  		           { name:'custNm', 	index:'lc.cust_nm', 		width:'120px', 	align: 'left', 		resizable : false },
  		           { name:'hhpNo', 	    index:'lm.hhp_no', 			width:'120px', 	align: 'center', 	resizable : false },
  		           { name:'birthDt', 	index:'lc.birth_dt', 		width:'80px', 	align: 'center', 	resizable : false,	formatter:insertDot },
  		           { name:'memDiv', 	index:'cd.mark_name', 		width:'80px', 	align: 'center', 	resizable : false },
  		           { name:'tierNm', 	index:'lt.tier_nm', 		width:'80px', 	align: 'center', 	resizable : false },
  		           { name:'emailAddr', 	index:'lm.email_addr', 		width:'200px', 	align: 'center', 	resizable : false },
  		           { name:'wbMemId', 	index:'lm.wb_mem_id', 		width:'80px', 	align: 'center', 	resizable : false },
  		           { name:'rid', 		index:'lm.rid', 			hidden : true }
  		       ],
	        dataType:"clientSide",
	        data : {}
		},
		jqGridOption : {
		        serializeGridData : function( data ){
		        	var data = $("#searchFormArea").getSubmitData();
		        	data.bonusCardNo = data.bonusCardNo.replaceAll("-","");
		        	data.hhpNo = data.hhpNo.replaceAll("-","");
		        	data.birthDt = data.birthDt.replaceAll("-","");
		        	return data;
		        },
		        ondblClickRow : function (rowNo) {
		        	var data = mbrListGrid.getRowData()[rowNo-1];
					gMbrList.moveDetail(data.rid);
		        },
		        onSelectRow : function (data) {
		        	gMbrList.setMaskingBtn();
		        },
		        loadComplete : function(result){

		        	gMbrList.setMaskingBtn();

		        	//조회결과가 1개 일시 해당 회원의 상세 페이지 이동
		        	if(result.rows.length == 1 && result.records == 1){
		        		gMbrList.moveDetail(result.rows[0].rid)
		        	}
		        },
		        url : '<ifvm:action name="getMbrList"/>',
		        colNames:[
		                  '<spring:message code="L00433"/>',
		                  '<spring:message code="L00435"/>',
		                  '<spring:message code="L00436"/>',
		                  '<spring:message code="L00786"/>',
		                  '<spring:message code="L00557"/>',
		                  '<spring:message code="L00187"/>',
		                  '<spring:message code="L00395"/>',
		                  '<spring:message code="L00651"/>',
		                  'rid'
		                ],
		       colModel:[
		           { name:'mbrNo', 	    index:'lm.mbr_no', 			width:'80px', 	align: 'center', 	resizable : false },
		           { name:'custNm', 	index:'lm.cust_nm', 		width:'120px', 	align: 'left', 		resizable : false },
		           { name:'hhpNo', 	    index:'lm.hhp_no', 			width:'120px', 	align: 'center', 	resizable : false },
		           { name:'birthDt', 	index:'lc.birth_dt', 		width:'80px', 	align: 'center', 	resizable : false,	formatter:insertDot },
		           { name:'memDiv', 	index:'cd.mark_name', 		width:'80px', 	align: 'center', 	resizable : false },
		           { name:'tierNm', 	index:'lt.tier_nm', 		width:'80px', 	align: 'center', 	resizable : false },
		           { name:'emailAddr', 	index:'lm.email_addr', 		width:'200px', 	align: 'center', 	resizable : false },
		           { name:'wbMemId', 	index:'lm.wb_mem_id', 		width:'80px', 	align: 'center', 	resizable : false },
		           { name:'rid', 		index:'lm.rid', 			hidden : true }
		       ],
		        sortname: 'lm.create_date',
		        autowidth : true ,
		        sortorder: "desc",
// 		        radio : true
		    }
}



//생년월일 구분자 추가
function insertDot(cellvalue, options, rowObject){
	if(cellvalue){
		return cellvalue.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');;
	}
	else{
		return "";
	}
}
$(document).ready(function() {
    gMbrList.init();
    $("#mbrListGrid").ifvGrid({ jqGridOption : gMbrList.jqGridOptionInit });
});

</script>

<div class="page-title">
    <h1>
        <spring:message code="L00890"/>
        &gt; <spring:message code="L00081"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">

            <ifvm:inputNew type="button" btnFunc="gMbrList.search" btnType="search" text="L00081" />
            <ifvm:inputNew type="button" btnFunc="gMbrList.searchInit" text="L00082" />
        </div>
    </div>


    <!-- commSearchList -->
	<div class="form-horizontal underline top_well" id="searchFormArea" >
		<div class="row">
			<ifvm:inputNew type="text" id="hhpNo" maxLength="50"  dto="hhpNo"    label="L00436" labelClass="1" conClass="2" />
			<ifvm:inputNew type="text" id="custNm" maxLength="50"  dto="custNm"    label="L00435" labelClass="2" conClass="2" />
			<ifvm:inputNew type="text" id="bonusCardNo" maxLength="50"  dto="bonusCardNo"    label="L00649" labelClass="2" conClass="2" />
		</div>
		<div class="row">
			<ifvm:inputNew  type="text" id="birthDt" dto="birthDt" label="L00786" labelClass="1" conClass="2" />
			<ifvm:inputNew type="text" id="mbrNo" maxLength="50"  dto="mbrNo"    label="L00787" labelClass="2" conClass="2" />
			<ifvm:inputNew type="text" id="wbMemId" maxLength="50"  dto="wbMemId"    label="L00651" labelClass="2" conClass="2" />
		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="emailAddr" maxLength="50"  dto="emailAddr"    label="L00395" labelClass="1" conClass="2" />
		</div>

	</div>

</div>
<!-- 조회결과 -->
<div>
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M00277"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="text" id="ivrCode" maxLength="50"  dto="ivrCode"    label="L00805" labelClass="2" conClass="2" className="right"	disabled="true" />
        	<ifvm:inputNew type="button" id="vocDetailPopBtn" text="L00819"/><!-- 상담생성 -->
           	<ifvm:inputNew type="button" id="clearMaskingBtn" text="L00326" btnFunc="gMbrList.clearMasking" />
           	<ifvm:inputNew type="button" id="addBtn" text="L00741" btnFunc="certiOwn.pop" />
           	<script>
           	certiOwn = {
					id : "certiPopup",
					pop : function(){
						var url = '<ifvm:url name="certiOwnPop"/>';
	           			url += '?certiCase=001'
						$("#"+this.id).ifvsfPopup({
				            enableModal : true,
				            enableResize : false,
				            contentUrl : url,
				            contentType : "ajax",
				            title : '<spring:message code="L00741"/>', // 회원 찾기
				            width : '500px'
				        });
					},
					beforeClose : function(obj){

					},
					close: function(obj){
						if(obj){
							this.beforeClose(obj)
						}
						var _popObj = eval(this.id)
						_popObj._destroy();
					}
			}

           	$("#vocDetailPopBtn").click(function(){
        		var url = '<ifvm:url name="vocDetailPop"/>';
        		//url += '?ridMbr='+gMbrDetail.data.rid
        		window.open(url, 'vocDetailPop', 'toolbar=no,scrollbars=no,resizable=no,top=0,left=0,width=1200,height=740')
        	})

           	</script>
        </div>
    </div>
    <div id="mbrListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="certiPopup" class="popup_container"></div>