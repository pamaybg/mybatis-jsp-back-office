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

var cafe24MemListGrid;
var targetGroupId = '<%= cleanXss(request.getParameter("targetGroupId")) %>';

var targetGroup = {
		targetGroupId:this.targetGroupId,
        targetGroupType: "SQL",
        data: {}
}

var tgtCnt;
/**
 * 타겟그룹 상세 조회
 */
function getTargetGroup() {
    var targetGroupId = this.targetGroupId;
    if ($.fn.ifvmIsNotEmpty(targetGroupId)) {
	    $.ifvProgressControl(true);

        $.ifvPostJSON('<ifvm:action name="getTargetSqlDetail"/>', {
            targetGroupId: targetGroupId
            , cafe24Yn : 'Y'
        },
        function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {

                //타겟그룹 설정
                targetGroup.data = result;
                setTargetSqlDtl();
            }
        },
        function(result) {
            $.errorChecker(result);
            $.ifvProgressControl(false);
        });
    } else {
    	getCafe24MemList(false);
    }
}

/**
 * 상세정보 보여주기
 */
function setTargetSqlDtl() {
    if ($.fn.ifvmIsNotEmpty(targetGroup.data)) {
        var data = targetGroup.data;
        $("#targetSqlName").val(data.targetGroupName);
        $("#targetSqlDesc").val(data.targetGroupDesc);
        $("#filterText").val(data.dpCond);

        //대상수 조회
        getTargetCount();

    }
}


/**
 * 대상수 조회
 */
function getTargetCount() {
    if ($.fn.ifvmIsNotEmpty(targetGroup.data)
            && $.fn.ifvmIsNotEmpty(targetGroup.data.dbInformId)
            && $.fn.ifvmIsNotEmpty(targetGroup.data.filterSql)) {

        $.ifvSyncPostJSON('<ifvm:action name="getTargetSqlCount"/>', {
            dbId: targetGroup.data.dbInformId,
            filterSql : targetGroup.data.filterSql,
            cafe24Yn : 'Y'
        },
        function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                targetGroup.data.cnt = result.message;
                targetGroup.data.targetCount = result.message;
                $('#targetSqlCount').val(numberWithCommas(result.message));
                tgtCnt = result.message;
            }
            else {
                $.ifvErrorPop('<spring:message code="M01694"/>');
            }
        });
    }
}

/**
 * 1000단위 정규식
 */
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/**
 * 목록 이동
 */
function targetGroupList() {
        location.href = '<ifvm:url name="targetGroupList"/>';
}

/**
 * 엑셀 다운로드
 */
function excelDownload() {
	$.ifvExcelDn('<ifvm:action name="exportExcelTargetCafe24List"/>',
			'cafe24MemListGrid', {targetGroupId : this.targetGroupId});
}

//마스킹 해제
function clearMaskAction() {
    var id;
    if ($.fn.ifvmIsNotEmpty(cafe24MemListGrid.opt.gridControl.getSelectedRecords()[0])) {
    	id = cafe24MemListGrid.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(id)) {
        $.ifvSyncPostJSON('<ifvm:action name="clearMaskCf24MbrList"/>', {
        	rid : id
        },
        function(result) {
        	var gridObj = cafe24MemListGrid.opt.gridControl;
        	var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('name'), result.unmaskName);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('cellPh'), result.unmaskCellPh);
        	gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('email'), result.unmaskEmail);
        });
    }
}

//고객 목록
function getCafe24MemList(flag){

    var ejGridOption = {
    	serializeGridData : function(data) {
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			data.targetGroupId = targetGroupId;
			data.targetSqlCount = tgtCnt;
			return data;
		},
     
        columns : [
        	{
      		  field : 'mallNm', headerText : '가입몰', headerTextAlign : 'center', textAlign : 'center',customAttributes : {
    				sortable : false
    			}
      	  },{
    		  field : 'name', headerText : '이름', headerTextAlign : 'center', textAlign : 'center',customAttributes : {
    				sortable : false
    			}
    	  },{
    		  field : 'cellPh', headerText : '휴대전화번호', headerTextAlign : 'center', textAlign : 'center',customAttributes : {
    				sortable : false
    			}
    	  },{
    		  field : 'email', headerText : 'EMAIL', headerTextAlign : 'center', textAlign : 'center',customAttributes : {
    				sortable : false
    			}
    	  },{
    		  field : 'userId', headerText : '사용자ID', headerTextAlign : 'center', textAlign : 'center',customAttributes : {
    				sortable : false
    			}
    	  },{
    		  field : 'smsYn', headerText : 'SMS수신', headerTextAlign : 'center', textAlign : 'center',customAttributes : {
    				sortable : false
    			}
    	  },{
    		  field : 'emailYn', headerText : 'EMAIL수신', headerTextAlign : 'center', textAlign : 'center',customAttributes : {
    				sortable : false
    			}
    	  },{
    		  field : 'regDate', headerText : '가입일자', headerTextAlign : 'center', textAlign : 'center',customAttributes : {
    				sortable : false
    			}
    	  },{
    		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false
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
        radio: true,
        tempId : 'ifvGridSimplePageTemplete'
       };

    if(flag == true){
    	ejGridOption.dataUrl = '<ifvm:action name="getTargetCafe24List"/>';
    }else{
    	
    	 ejGridOption.dataSource = [];
    	 ejGridOption.datatype = 'clientSide';
    	 $.ifvProgressControl(false);
    }
    
    
    cafe24MemListGrid = $("#cafe24MemListGrid").ifvsfGrid({ ejGridOption : ejGridOption });

}



function targetCafe24Save(){
	
    var workflowSaveFlag = workflowFlag;
    if ($.fn.ifvmIsNotEmpty(workflowSaveFlag)) {
    	isAlert = false;
    	
        //캔버스 저장
        saveCampaignTarget();
    }
	
}


$(document).ready(function() {
    $.ifvmLnbSetting('targetGroupList');

    
    getTargetGroup(false);
    getCafe24MemList();

    //목록
    $('#targetGroupListBtn').on('click', function(){
        targetGroupList();
    });

    //타겟팅대상자 목록 조회 버튼
    $('#tgtSqlDtlListBtn').on('click', function(){
    	 getCafe24MemList(true);
    });

    //엑셀 다운로드
    $('#excelDownloadBtn').on('click', function() {
        excelDownload();
    });
    
    //저장버튼
    $('#targetSqlDtlSaveBtn').on('click', function() {
        targetCafe24Save();
    });

    
    //마스킹해제
    $('#clearMaskBtn').on('click', function(){
        clearMaskAction();
    });
    
});

</script>

<div id="targetSqlDetail_area">
<div class="well" style="margin-bottom:10px;">
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00556" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r" id="targetSqlDetailBtn_area">

            <!-- 목록 -->
            <button class="btn btn-sm" id="targetGroupListBtn">
                <spring:message code="M00002" />
            </button>
            <%-- 저장 --%>
            <button class="btn btn-sm" id="targetSqlDtlSaveBtn">
                <spring:message code="L00074" />
            </button>
        </div>
    </div>
    
	<div class="well form-horizontal well_wrap">
		<div class="row qt_border">
	
			<%-- 타겟팅명 --%>
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02438"/></label>
			<div class="col-xs-9 control_content">
		    	<ifvm:input type="text" required="true" id="targetSqlName" />
		    </div>
		</div>
		<div class="row qt_border">
	
			<%-- 설명 --%>
			<label class="col-xs-2 control-label"><spring:message code="M00324"/></label>
			<div class="col-xs-9 control_content">
	    		<ifvm:input type="text" id="targetSqlDesc" />
	    	</div>
		</div>
		<div class="row qt_border">
	
			<%-- 대상수 --%>
			<label class="col-xs-2 control-label"><spring:message code="M01495"/></label>
			<div class="col-xs-9 control_content">
	    		<ifvm:input type="text" required="true" disabled="true" id="targetSqlCount" />
			</div>
		</div>
	</div>
</div>

	
<div class="well">
	<div class="page_btn_area">
		<div class="col-xs-5">
			<span><spring:message code="M01217"/></span>
		</div>
		<div class="col-xs-7 searchbtn_r">
	
			<%-- 조회 --%>
			<button class="btn btn-sm" id="tgtSqlDtlListBtn">
			    <spring:message code="L00030" />
			</button>
	        <button class="btn btn-sm" id="clearMaskBtn">
                <spring:message code="L00326"/>
            </button>
			<%-- 엑셀 다운로드 --%>
			<button class="btn btn-sm" id="excelDownloadBtn">
			    <spring:message code="M01218" />
			</button>
		</div>
	</div>
     <!-- 그리드 -->
	<div id="cafe24MemListGrid" class="white_bg grid_bd0"></div>
</div>
