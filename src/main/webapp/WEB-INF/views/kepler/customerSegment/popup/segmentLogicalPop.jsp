<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="chnlGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnSelect" objCode="btnSelect_OBJ">
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancle" objCode="btnCancle_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	var LogicalListPop = function () {
	    var _logicalRid = null;
	    var _logicalGrRid = null;
	    var logicalNm=null;
	    var logicalGrNm=null;
	    var colNm=null;
	    var colId =null;
	    var logicalMartNm=null; 
	    var tblAliasColNm= null;
	
	    this.getLogicalRid = function () {
	        return _logicalRid;
	    },
        this.setLogicalRid = function (logicalRid) {
	    	_logicalRid = logicalRid;
        },
        
	    this.getLogicalGrRid = function () {
	        return _logicalGrRid;
	    },
        this.setLogicalGrRid = function (logicalGrRid) {
	    	_logicalGrRid = logicalGrRid;
        },
	        /* 그리드 생성 */
        this.setGridAndDataLoad = function () {
            var _rowSelected = function (args) {
            	var data = args.data;
                this.setLogicalRid(data.lgcCompId);
                this.setLogicalGrRid(data.lgcCompTblIntId);
                logicalNm=data.lgcCompNm;
                logicalGrNm=data.lgcCompTblIntNm;
                
                tblAliasColNm = data.tblAliasColNm;
                colId=data.colId;

                logicalMartNm = data.colNm;    //마트 항목명
            };

            var ejGridOption = {
                rowSelected: _rowSelected.bind(this),
                serializeGridData: function (data) {
                    return data;
                },
                dataUrl: '<ifvm:action name="getLogicalCompList"/>',
                columns: [ 
                    {
                        field: 'lgcCompNm',
                        headerText: '로지컬 컴포넌트',
                        textAlign : 'center',
                       width: '110px',
                        customAttributes: { searchable: true }
                    },{
                    	field: 'lgcCompTblIntNm',
                        headerText: '로지컬 컴포넌트 그룹',
                        width:'110px',
                        textAlign : 'center',
                        customAttributes: {
                        	index: 'atrib_group_nm',
                        	searchable: true }
                    },{
                    	field: 'tblAliasColNm',
                        headerText: 'ALIAS 컬럼명',
                        width:'140px',
                        textAlign : 'left',
                        customAttributes: { searchable: true }
                    },{
                    	field: 'colNm',
                        headerText: '고객 세분화 마트 항목명',
                        width:'160px',
                        textAlign : 'left',
                        customAttributes: {
                        	index: 'dp_nm',
                        	searchable: true }
                    },{
                        field: 'colId',
                        headerText: 'colId',
                        visible: false,
                    }                    
        			,{
                        field: 'lgcCompId',
                        headerText: 'lgcCompId',
                        visible: false,
                    },{
                        field: 'lgcCompTblIntId',
                        headerText: 'lgcCompTblIntId',
                        visible: false,

                    },{
                    	field: 'seqCreate',
                        headerText: 'seqCreate',
                        visible: false,

                    }
               		              
               ],
                requestGridData: {
                    sidx: 'lgcCompId',
                    sord : 'asc'
                },
                rowList : [10,25,50,100],
                radio: true
            };
            $("#chnlGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnSelect").on('click', function () {
               	$("#lgcCompNm").val(logicalNm);
             	$("#lgcCompId").val(this.getLogicalRid());
               	$("#lgcCompTblIntNm").val(logicalGrNm);
             	$("#lgcCompTblIntId").val(this.getLogicalGrRid());
            	$("#colNm").val(colNm);
            	$("#tblAliasColNm").val(tblAliasColNm);
               	$("#colId").val(colId);
               	$("#csegMtNm").val(logicalMartNm);
     			$.fn.ifvmPopupClose();
            }.bind(this));

            $("#btnCancle").on('click', function () {
    			$.fn.ifvmPopupClose();
            }.bind(this));
        },
        /* 페이지 초기화 */
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};
	
	$(document).ready(function () {
	    var LogicalList = new LogicalListPop();
	    LogicalList.init();
	});
</script>
