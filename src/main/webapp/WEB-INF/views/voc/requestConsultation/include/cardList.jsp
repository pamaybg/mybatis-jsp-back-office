<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script type="text/javascript">
var mbrOrangeCardList;
var gridIdmbrOrangeCardList;
var rid ;

//E1 오렌지 카드
function mbrOrangeCardListSearch(){
    var jqGridOption = {
           serializeGridData : function( data ){
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                    data.item = requestitem;
                }     
	            if($("#detail_memRid").val() == ""){
	        		data.mbrRidFlag = "1";
	        	}else{
	        		data.ridMbr = $("#detail_memRid").val();
	        	}
	            
                return data;
            },
            loadComplete : function(data) {
				parent.setParentIframeHeight();
			},
            url : '<ifvm:action name="getRgstCardListByRidMbr"/>',
            colNames:[
                      '<spring:message code="L00917" />',
                      '<spring:message code="L00918" />',
                      '<spring:message code="L00919" />',
                      '<spring:message code="L00710" />',
                      '<spring:message code="L00921" />',
                      '<spring:message code="L00922" />',
                      '<spring:message code="L00923" />',
                      '<spring:message code="L00924" />',
                      '<spring:message code="L00925" />',
                      '<spring:message code="L00926" />',
                      '<spring:message code="L00927" />',

                      'rid',
                      'statCd',
                      'mbrType',
                      'cprtCardCd'
                    ],
           colModel:[
                { name:'cardNo',   		index:'b.card_no',  		resizable : true, align:'center',  	width:'150px' },
                { name:'cardKndNm',   		index:'c.card_knd_nm',  	resizable : true, align:'center',   width:'100px' },
                { name:'cprtCard',   		index:'d.mark_name',  		resizable : true, align:'center',   width:'100px' },
                { name:'cprtCardItemCd',   index:'cc.mark_name',  		resizable : true, align:'center',   width:'100px' },

                { name:'stat',   			index:'e.mark_name',  		resizable : true, align:'center',   width:'100px' },
                { name:'regChnlCd',   		index:'f.mark_name',  		resizable : true, align:'center',   width:'100px' },
                { name:'createDate',   	index:'b.create_date',  	resizable : true, align:'center',  	formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'150px' },
                { name:'createBy',   		index:'i.name',  			resizable : true, align:'center',   width:'100px' },
                { name:'loseDt',   		index:'b.lose_dt',  		resizable : true, align:'center',  	formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'150px' },
                { name:'loseTrTr',   		index:'j.name',  			resizable : true, align:'center',   width:'100px' },
                { name:'cardLeavDate',   	index:'b.card_leav_date',  	resizable : true, align:'center',  	formatter:'date',  formatoptions:{newformat:"Y-m-d H:i:s"} ,  width:'150px' },

                { name:'rid',    			index:'b.rid',    		hidden : true},
                { name:'statCd',    		index:'b.stat',    		hidden : true},
                { name:'mbrType',    		index:'c.mbr_type',    	hidden : true},
                { name:'cprtCardCd',    	index:'b.cprt_card_cd', hidden : true}
           ],
           sortname: 'b.create_date',
    		autowidth : true , sortorder: "desc",
//            	radio: true
        };
    
    mbrOrangeCardList = $("#mbrOrangeCardList").ifvGrid({ jqGridOption : jqGridOption });
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플 
function goGridRowMbrLink(cellvalue, options, rowObjec){
	var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag=null;
    
    if(cellvalue!=null){
//         tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    }else{
    	tag="";
    }
    return tag;
}

$(document).ready(function() {
    mbrOrangeCardListSearch();
});

</script>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="V00068"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
   		<ifvm:inputNew type="button" btnType="download" text="M01218" id="excelDownloadBtn"  btnFunc="fnIfvExcelDownload('mbrOrangeCardList')" objCode="COM_EXC_001"/>
 	</div>
</div>
<div id="mbrOrangeCardList" class="white_bg grid_bd0"></div>