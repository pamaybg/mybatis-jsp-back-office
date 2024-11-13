<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page-title">
    <h1>
     	<spring:message code="공지사항(BO)" />
        &gt; <spring:message code="조회" />
    </h1>
</div>
<%-- <div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="noticeBoSearchBtn" objCode="noticeBoListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="noticeBoClearBtn" objCode="noticeBoListInit_OBJ">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="searchList"></div>
</div> --%>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-7">
	        <span>공지사항 목록</span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	    	<button class="btn btn-sm" id="noticeBoNewBtn" objCode="noticeBoListAdd_OBJ">
	        	<spring:message code="M00274" />
	   		</button>
	   		<button class="btn btn-sm" id='noticeBoRemoveBtn' objCode="noticeBoListDel_OBJ">
	        	<spring:message code="M00165" />
	    	</button>
	    </div>
	 </div>
	 <div id="noticeBoGrid" class="white_bg grid_bd0"></div>
 </div>
 <div id="popupContainer" ></div>
<script type="text/javascript">
var noticeBoList = function () {
	    var _rid = null;
	    this.noticeBoGridOption = null,
	    this.getRid = function () {
	        return _rid;
	    },
        this.setRid = function (rid) {
	    	ifvGlobal["noticeRid"] = rid;
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
                
                $.fn.ifvmPopupOpen('popupContainer',  data.rid ,
    		            '<ifvm:url name="noticeBoDetailPop"/>', '공지 상세', 800);
            };

            var ejGridOption = {
                rowSelected: _rowSelected.bind(this),
                recordDoubleClick : _recordDoubleClick.bind(this),
                serializeGridData: function (data) {
                    return data;
                },
                dataUrl : '<ifvm:action name="getNoticeBoList"/>',
                columns : [
            	{
		      		  field : 'noticeNm', headerText : '제목', textAlign : 'center',
		      		  customAttributes : {searchable: true,}
		      	  },{
		      		  field : 'noticeContent', headerText : '내용', textAlign : 'left'
		      	  },{
            		  field : 'modifyBy', headerText : '작성자', textAlign : 'center',
            		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'modifyDate', headerText : '작성일자', textAlign : 'center',
            		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'rid', headerText : 'rid', visible: false,
            	  }
                ],
                requestGridData: {
                    sidx: 'modifyDate',
                },
                rowList : [10,25,50,100],
                radio: true
            };
           this.noticeBoGridOption =  $("#noticeBoGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            
         	/* // 조회
            $('#noticeBoSearchBtn').on('click', function () {
                var _GridOptions = this.noticeBoGridOption;
                $.fn.ifvmSubmitSearchCondition("searchList", function () {
                    _GridOptions.searchGrid({ item: requestitem });
                });

            }.bind(this));

            // 초기화
            $("#noticeBoClearBtn").on('click', function () {
                $.fn.ifvmSetCommonCondList("searchList", "SYS_NOTICE_BO_LIST", "noticeBoList");
            }.bind(this)); */

            // 신규 클릭시
            $('#noticeBoNewBtn').on('click', function () {
            	this.setRid(null)
    			$.fn.ifvmPopupOpen('popupContainer',  this.getRid() ,
    		            '<ifvm:url name="noticeBoDetailPop"/>', '공지 상세', 800);
            }.bind(this));
            
            // 삭제
            $('#noticeBoRemoveBtn').on('click', function () {
                this.removeAction();
            }.bind(this));
        },
        /* this.initSearchCondition = function () {
            $.fn.ifvmSetCommonCondList("searchList", "SYS_NOTICE_BO_LIST", "noticeBoList");
        }, */
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
                     $.ifvPostJSON('<ifvm:action name="removeNoticeBo"/>', { rid: _rid }, _success.bind(this), _fail);
                 }
             }
        },
        /* 페이지 초기화 */
        this.init = function () {
            //this.initSearchCondition();
            this.setGridAndDataLoad();
            this.setButtons();
        }
};
	
$(document).ready(function () {
    var noticeBo = new noticeBoList();
	noticeBo.init();
});
</script>
