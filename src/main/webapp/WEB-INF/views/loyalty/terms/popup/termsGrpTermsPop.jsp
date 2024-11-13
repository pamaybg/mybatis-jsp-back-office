<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="well form-horizontal well_bt5" id="TermsGrpVersionList"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnSelect" objCode="termsGrpTermsPopSelect_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00072" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnSelectCancel" objCode="termsGrpTermsPopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">

function getTermsGrpVersionList(){
    var columns = [
        {
            field : 'termsType', headerText : '<spring:message code="L02323"/>', textAlign : 'center',width:64,
            customAttributes: {index: 'termsTypeCd'}
        }
        , {
            field : 'termsNm', headerText : '<spring:message code="L02324"/>', textAlign : 'center',width:220, 
            customAttributes: {index: 'termsTypeSubCd'}
        }
        , {
            field : 'statCdNm', headerText : '<spring:message code="C00125"/>', textAlign : 'center',width:64,
            customAttributes: {index: 'statCd'}
        }, {
            field : 'createBy', headerText : '<spring:message code="M00221"/>',  textAlign : 'center',width:123,
        }, {
            field : 'createDate', headerText : '<spring:message code="M00222"/>',  textAlign : 'center',width:128,
        }, {
            field : 'modifyBy', headerText : '<spring:message code="L01604"/>', textAlign : 'center',width:141,
        },{
            field : 'modifyDate', headerText : '<spring:message code="L02703"/>', textAlign : 'center',width:128,
        }, {
            field : 'rid', headerText : 'rid', visible : false,
        } , {
			field : 'termsTypeSubCd', headerText : 'termsTypeSubCd', visible : false
		}
        ];

var ejGridOption = {
    serializeGridData : function(data) {
        if ($.fn.ifvmIsNotEmpty(requestitem)) {
            data.item = requestitem;
        }
        return data;
    },
    rowSelected : function (args) {
        termsRid = args.data.rid;
    },
    columns,
    requestGridData : {
        nd : new Date().getTime(),
        rows : 10,
        sidx : 'termsTypeCd',
        sord : 'asc',
        _search : false
    },
    rowList : [ 10, 25, 50, 100 ],
    radio : true,
    tempId : 'ifvGridNotSearchTemplete',
    dataUrl : '<ifvm:action name="getTermsGrpTermsPop"/>'
};

TermsGrpVersionList = $("#TermsGrpVersionList").ifvsfGrid({ejGridOption: ejGridOption});
};


$(document).ready(function() {
    getTermsGrpVersionList();
	$("#btnSelect").on('click', function(){
	    $('#termsPop').val(TermsGrpVersionList.opt.gridControl.getSelectedRecords()[0].termsNm);
	    $('#termsTypeSubCd').val(TermsGrpVersionList.opt.gridControl.getSelectedRecords()[0].termsTypeSubCd);
	       btnTermsPopupClose();
	});
	
	$("#btnSelectCancel").on('click', function(){
	    btnTermsPopupClose();
	}); 
});

</script>
