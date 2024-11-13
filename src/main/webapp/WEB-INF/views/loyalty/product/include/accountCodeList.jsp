<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var accountCodeList;
var baseRid=null;

function getAccountCodeList(){
    var jqGridOption = {
  
        onSelectRow : function (data) {
        	baseRid=data.rid;
        },
       serializeGridData : function( data ){
    	   
    	   data.rid=testViewList_rid;
    	   data.listType="SAVE";
    	   return data;
        },  
        loadComplete : function(obj){
        }, 
        url : '<ifvm:action name="getPointItemBaseList"/>',
        colNames:[ 
                   '<spring:message code="L00901" />',  /*회원구분 */
                   '<spring:message code="L00902" />',  /*회원등급 */
                   '<spring:message code="L00903" />',  /*적립단위 */
                   '<spring:message code="L00904" />',  /*적립포인트 */
                   '<spring:message code="L00905" />',  /*적립한도 */
                   '<spring:message code="L00906" />',  /*사용여부 */
                   '<spring:message code="L00907" />',  /*적용시작일자 */
                   '<spring:message code="L00908" />',  /*적용종료일자 */
                
                   'rid',  /*rid */
                 ],
        colModel:[
             { name:'mbrDivCd',   index:'cc1.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
             { name:'tierCd',   index:'cc2.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
             { name:'acrlUnit',   index:'cc3.MARK_NAME',  resizable : true, align:'center',    width:'100px' },
             { name:'acrlPnt',   index:'lpbi.ACRL_PNT',  resizable : true, align:'right',    width:'120px', formatter:'integer'  },
             { name:'acrlPntLmt',   index:'lpbi.ACRL_PNT_LMT',  resizable : true, align:'right',    width:'120px', formatter:'integer'  },
             { name:'activeYn',   index:'lpbi.ACTIVE_YN',  resizable : true, align:'center',    width:'80px',   },
             { name:'aplyStartDd',   index:'lpbi.APLY_START_DD',  resizable : true, align:'center',    width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },
             { name:'aplyEndDd',   index:'lpbi.APLY_END_DD',  resizable : true, align:'center',    width:'120px', formatter:'date',  formatoptions:{newformat:"Y-m-d"}  },

             
             { name:'rid',   index:'lpbi.rid',  hidden:true },
        ],
        sortname: 'aplyStartDd',
        autowidth : true , sortorder: "desc",
        radio: true

    };
    
    accountCodeList = $("#accountCodeListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//그리드 텍스트 선택시 상세로 이동  참고 샘플 
function goGridRowMbrLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridMbr;
    var url = '<ifvm:url name="mbrDetail"/>' + '?rid=' + id;
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}
function goGridRowChnlLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridChnl;
    var url = '<ifvm:url name="chnlDetail"/>?rid=' + id; 
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}
function goGridRowPgmLink(cellvalue, options, rowObjec){
    var id = rowObjec.ridPgm;
    var url = '<ifvm:url name="pgmDetail"/>?rid=' + id; 
    var tag = '<a href="' + url + '" style="color:#1266FF; text-decoration:underline;" >' + cellvalue + '</a>';
    
    return tag;
}


function newPointStandardFn(){
	 pointSaveInfoPop ={
		        id : "pontSaveInfoPopDiv"
		    };
	 pointSaveInfoPop.popup = function (){
		 pointSaveInfoPop.pop = $('#'+pointSaveInfoPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="pointSaveInfoPop"/>',
		            contentType: "ajax",
		            title: '<spring:message code="L00897" />',
		            width: "800px"
		        });
		};
		pointSaveInfoPop.beforeClose = function (obj) {
		}; 
		pointSaveInfoPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 pointSaveInfoPop.popup();
}

function delTabSavePointFn(){
	
	if(baseRid==null){
		alert('<spring:message code="L00914"/>');
		return;
	}else{
		$.ifvSyncPostJSON('<ifvm:action name="deletePointItem"/>',{  
			rid:baseRid
			},function(result) {
				alert('<spring:message code="L00034"/>');
				accountCodeList.requestData();		
			});
		
	}
	
}



$(document).ready(function() {
	getAccountCodeList();

});

</script>

<div>   
    <div class="page_btn_area" id=''>
       <div class="col-xs-7">
           <span> <spring:message code="L00897"/></span>
       </div>   
        <div class="col-xs-5 searchbtn_r">
 			<ifvm:inputNew type="button" btnType="plus"  text="L00078"  id="newTabBtn" btnFunc="newPointStandardFn"/>
 			<ifvm:inputNew type="button" btnType="minus"  text="L00029"  id="delTabSavePointBtn" btnFunc="delTabSavePointFn"/>
        </div>     
    </div>
    <div id="accountCodeListGrid" class="white_bg grid_bd0"></div>     
</div>
 <div id="pontSaveInfoPopDiv" class="popup_container"></div>
