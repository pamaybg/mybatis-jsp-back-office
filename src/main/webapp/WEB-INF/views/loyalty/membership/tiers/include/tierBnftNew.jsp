<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="addTierBnftPop" class="popup_container"></div>


<div class="page_btn_area" id="tierBnftArea" style="margin-top:15px;">
	<div class="col-xs-7">
		<span><spring:message code="등급 혜택" /></span>
	</div>
	
<%--	 <div class="col-sm-5 searchbtn_r">--%>
<%-- <ifvm:inputNew type="button" className="dataAddBtn" id="addTierBnftBtn" btnFunc="addTierBnft" text="L00078" btnType="plus" objCode="addTierBnftBtn_OBJ"/>--%>
<%-- <ifvm:inputNew type="button" className="dataDelBtn" id="removeTierBnftBtn" btnFunc="removeTierBnft" text="I00888" btnType="minus" objCode="removeTierBnftBtn_OBJ"/>--%>
<%--	</div>--%>
	
</div>
<div id="tierBnftGirdList"></div>

<script type="text/javascript">
var tierBnftRid;

function gettierBnftList() {
	 var ejGridOption = {
		    	serializeGridData : function(data) {
		    		data.tierRid = tierRid;
					return data;
				},
				recordDoubleClick : function (args) {
					tierBnftRid = args.data.rid;
					addTierBnftPopup();
		        },rowSelected : function(args){
		        	tierBnftRid = args.data.rid;
		       	},
		        dataUrl : '<ifvm:action name="getTierBnftListNew"/>',

		        columns : [
		        	{
		      		  field : 'tierBnftTypeCdNm', headerText : '유형', width: '40px',headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'tierBnftTypeCd'}
		      	  },{
		    		  field : 'ofrNo', headerText : '오퍼번호', textAlign : 'center',width: '80px', headerTextAlign : 'center' , customAttributes : {searchable : true,index:'ofrNm'}
		    	  },{
		    		  field : 'ofrNm', headerText : '오퍼명', textAlign : 'left',width: '130px', headerTextAlign : 'center' , customAttributes : {searchable : true,index:'ofrNm'}
		    	  },{
		    		  field : 'ofrSubType', headerText : '오퍼 유형', textAlign : 'center',width: '130px', headerTextAlign : 'center' , customAttributes : {searchable : true}
		    	  },{
		    		  field : 'cpnYn', headerText : '쿠폰여부', textAlign : 'center',width: '50px', headerTextAlign : 'center' , customAttributes : {searchable : true}
		    	  },{
		    		  field : 'amt', headerText : '금액', headerTextAlign : 'center',width: '50px', textAlign : 'right' ,format : '{0:n0}', customAttributes :{searchable : true}
		    	  },{
		    		  field : 'qty', headerText : '수량', headerTextAlign : 'center',width: '50px', textAlign : 'right' ,format : '{0:n0}', customAttributes :{searchable : true}
		    	  },{
		    		  field : 'bnftActCycleCdNm', headerText : '주기',width: '60px', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'bnftActCycleCd'}
		    	  },{
		    		  field : 'bnftActRotCycleCdNm', headerText : '반복주기',width: '70px', headerTextAlign : 'center', textAlign : 'center', customAttributes :{index : 'bnftActRotCycleCd'}
		    	  },{
		    		  field : 'tierRid', headerText : 'tierRid',visible : false 
		    	  },{
		    		  field : 'rid', headerText : 'rid',visible : false 
		    	  }
		        ],

		        requestGridData : {
		      	  sidx : '1,2',
		      	  sord : 'desc',
		        },
		        radio: true
		    };

	 		tierBnftGirdList = $("#tierBnftGirdList").ifvsfGrid({ ejGridOption : ejGridOption });
}

function addTierBnft() {
	/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
		alert("작성중일때만 등록할수 있습니다.");
		return;
	}*/
	if ($.fn.ifvmIsEmpty(tierListGrid.opt.gridControl.getSelectedRecords()[0])) {
		alert('목록을 선택해주세요.');
		return;
    }
	tierBnftRid = null;
	addTierBnftPopup();
}

function addTierBnftPopup() {
	$("#addTierBnftPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="addTierBnftPop"/>',
        contentType: "ajax",
        title: '등급 혜택 신규',
        width: 700,
        close : 'addTierBnftClosePop'
	});
}

function addTierBnftClosePop() {
	addTierBnftPop._destroy();
}

function removeTierBnft() {
	var v_rid;
	/* if(tierGrpStatCd == 'A' || tierGrpStatCd=='S') {
		alert("작성중일때만 삭제할수 있습니다.");
		return;
	} */
    if ($.fn.ifvmIsNotEmpty(tierBnftGirdList.opt.gridControl.getSelectedRecords()[0])) {
    	v_rid = tierBnftGirdList.opt.gridControl.getSelectedRecords()[0].rid;
    }
    else {
        alert('목록을 선택해주세요.');
        return;
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {
    	if( confirm('<spring:message code="I01500"/>') == true ){
        $.ifvSyncPostJSON('<ifvm:action name="removeTierBnft"/>', {
            rid: v_rid
        },
        function(result) {
        	tierBnftGirdList._doAjax();
			alert('<spring:message code="I00726"/>');
        });
    }
  }
}

$(document).ready(function(){
	gettierBnftList();
});
</script>
