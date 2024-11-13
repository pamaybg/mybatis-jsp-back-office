<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
    <h1>
     	<spring:message code="사이트 관리"/> &gt; <spring:message code="조회"/>
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="systemMgtSearchBtn" objCode="systemMgtListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="systemMgtClearBtn" objCode="systemMgtListInit_OBJ">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="searchList"></div>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-7">
	        <span>사이트 목록</span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	    	<button class="btn btn-sm" id="systemMgtNewBtn" objCode="systemMgtListAdd_OBJ">
	        	<spring:message code="M00274" />
	   		</button>
	   		<button class="btn btn-sm" id='systemMgtRemoveBtn' objCode="systemMgtListDel_OBJ">
	        	<spring:message code="M00165" />
	    	</button>
	    </div>
	 </div>
	 <div id="systemMgtGrid" class="white_bg grid_bd0"></div>
 </div>
<script type="text/javascript">
var sytemMgtList = function () {
	    var _rid = null;
	    this.systemMgtGridOption = null,
	    this.getRid = function () {
	        return _rid;
	    },
        this.setRid = function (rid) {
	    	ifvGlobal["sysMgtRid"] = rid;
            _rid = rid;
        },
        /* 그리드 생성 */
        this.setGridAndDataLoad = function () {
            var _rowSelected = function (args) {
                var data = args.data;
                this.setRid(data.rid);
            };
            var _recordDoubleClick = function (args) {
                var data = args.data;
                qtjs.href('<ifvm:url name="systemMgtDetail"/>'+'?rid='+data.rid);
            };

            var ejGridOption = {
                rowSelected: _rowSelected.bind(this),
                recordDoubleClick : _recordDoubleClick.bind(this),
                serializeGridData: function (data) {
                    return data;
                },
                dataUrl : '<ifvm:action name="getSystemMgtList"/>',
                columns : [
            	{
		      		  field : 'systemNm', headerText : '시스템명', textAlign : 'left',
		      		  customAttributes : {searchable: true,}
		      	  },{
		      		  field : 'systemTypeCdNm', headerText : '유형', textAlign : 'center',
		      		  customAttributes : {index: 'systemTypeCd' }
		      	  },{
		      		  field : 'apiSiteId', headerText : '사이트ID', textAlign : 'center',
		      		  customAttributes : {index: 'apiSiteId' }
		      	  },{
            		  field : 'host', headerText : '호스트명'
            	  },{
              		  field : 'port', headerText : '포트', textAlign : 'center'
            	  },{
            		  field : 'company', headerText : '회사명', textAlign : 'center'
            	  },{
            		  field : 'statCdNm', headerText : '상태', textAlign : 'center'
            	  },{
            		  field : 'createBy', headerText : '생성자', textAlign : 'center'
            	  },{
            		  field : 'createDate', headerText : '생성일자', textAlign : 'center'
            	  },{
            		  field : 'rid', headerText : 'rid', visible: false,
            	  }
                ],
                requestGridData: {
                    sidx: 'createDate',
                },
                rowList : [10,25,50,100],
                radio: true
            };
           this.systemMgtGridOption =  $("#systemMgtGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            
         	// 조회
            $('#systemMgtSearchBtn').on('click', function () {
                var _GridOptions = this.systemMgtGridOption;
                $.fn.ifvmSubmitSearchCondition("searchList", function () {
                    _GridOptions.searchGrid({ item: requestitem });
                });

            }.bind(this));

            // 초기화
            $("#systemMgtClearBtn").on('click', function () {
                $.fn.ifvmSetCommonCondList("searchList", "SYS_MGT_LIST", "systemMgtList");
            }.bind(this));

            // 신규 클릭시
            $('#systemMgtNewBtn').on('click', function () {
                qtjs.href('<ifvm:url name="systemMgtDetail"/>');
            });

            // 삭제
            $('#systemMgtRemoveBtn').on('click', function () {
                this.removeAction();
            }.bind(this));
        },
        this.goToDetail = function () {
            qtjs.href('<ifvm:url name="systemMgtDetail"/>' + "?rid=" + this.getRid());
        },
        this.initSearchCondition = function () {
            $.fn.ifvmSetCommonCondList("searchList", "SYS_MGT_LIST", "systemMgtList");
        },
        this.removeAction = function(){
        	 var _success = function () {
                 $.ifvProgressControl(false);
                 setTimeout(`alert('<spring:message code="L00085"/>')`, 0);
                 this.setGridAndDataLoad();
             };

             var _fail = function (result) {
                 $.ifvProgressControl(false);
                 setTimeout(`alert(result.message)`, 0);
             };

             var _rid = this.getRid();

             if ($.fn.ifvmIsNotEmpty(_rid)) {
                 if (confirm('<spring:message code="L00086"/>')) {
                     $.ifvProgressControl(true);
                     $.ifvPostJSON('<ifvm:action name="removeSystemMgt"/>', { rid: _rid }, _success.bind(this), _fail);
                 }
             }
        },
        /* 페이지 초기화 */
        this.init = function () {
            this.initSearchCondition();
            this.setGridAndDataLoad();
            this.setButtons();
        }
};
	
$(document).ready(function () {
    var systemMgt = new sytemMgtList();
	systemMgt.init();
});
</script>
