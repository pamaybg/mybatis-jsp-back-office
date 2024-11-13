<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>
	var isNew = true;
	var interfaceProcedureGrid;
	var batchListGrid;
	var socketListGrid;

	var interfaceData = {
		procedureList : [], // 프로시저 파라미터 리스트
		batchList : [], // 배치 리스트
		socketList : [], // 소켓 리스트
	};

	var getInterfaceDetail = {
		init : function() {
			var rid = $.ifvGetParam('rid');
			if (typeof rid === 'undefined')
				isNew = true;
			else
				isNew = false;

			//인터페이스 유형
			$.fn.ifvmSetSelectOptionCommCode("ifType", "QIM_IF_METHOD", null, null, true);
			//인터페이스 방법
			$.fn.ifvmSetSelectOptionCommCode("ifMethod", "QIM_IF_TYPE", null, null, true);
			//프로시저 결과 유형
			$.fn.ifvmSetSelectOptionCommCode("procResultType", "QIM_PROC_RESULT", null, null, true);
			//Java
			$.fn.ifvmSetSelectOptionCommCode("svcMethod", "QIM_IF_TYPE", null, null, true);
			//FTP 유형
			$.fn.ifvmSetSelectOptionCommCode("ftpType", "QIM_IF_TYPE", null, null, true);
			//FTP 방법
			$.fn.ifvmSetSelectOptionCommCode("ftpMethod", "QIM_FTP_METHOD", null, null, true);

			if (!isNew) {
				$.ifvSyncPostJSON('<ifvm:action name="getInterfaceDetail"/>', {
					rid : rid
				}, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						$("#interfaceDetailForm").dataSetting(result);

						if (result.useYn == "1") {
							$("#useYn").attr("checked", true);
						} else {
							$("#useYn").attr("checked", false);
						}

						if (result.saveLog == "1") {
							$("#saveLog").attr("checked", true);
						} else {
							$("#saveLog").attr("checked", false);
						}

						// 프로시저 파라미터 리스트
						if ($.fn.ifvmIsNotEmpty(result.procedureList)) {
							interfaceData.procedureList = result.procedureList;
						}

						// 배치 리스트
						if ($.fn.ifvmIsNotEmpty(result.batchList)) {
							interfaceData.batchList = result.batchList;
						}

						// 소켓 리스트
						if ($.fn.ifvmIsNotEmpty(result.socketList)) {
							interfaceData.socketList = result.socketList;
						}
					}
				}, function(result) {
					alert(result.message);
				});
			}

			setArea();
		},
		save : function() {
			var validation = $("#interfaceDetail").ifvValidation();
			//유효성 체크
			if (validation.confirm()) {

				if ($("#ifType").val() == "P") {
					validation = $("#procArea").ifvValidation();
				} else if ($("#ifType").val() == "F") {
					validation = $("#ftpArea").ifvValidation();
				} else if ($("#ifType").val() == "B") {
					validation = $("#batchArea").ifvValidation();
				} else if ($("#ifType").val() == "S") {
					validation = $("#SocketArea").ifvValidation();
				} else if ($("#ifType").val() == "J") {
					validation = $("#JavaArea").ifvValidation();
				}

				//유효성 체크
				if (validation.confirm()) {
					var tUrl = isNew ? '<ifvm:action name="setInterface"/>' : '<ifvm:action name="modifyInterface"/>';
					var tData = null;
					tData = $("#interfaceDetailForm").getSubmitData();

					tData.saveLog = $("input:checkbox[id='saveLog']").is(":checked") ? "1" : "0";
					tData.useYn = $("input:checkbox[id='useYn']").is(":checked") ? "1" : "0";

					tData.ridRsc = $('#ridRsc').val();
					tData.ridSource = $('#ridSource').val();
					tData.ridTarget = $('#ridTarget').val();

					if ($("#ifType").val() == "P") {
						tData.procedureList = interfaceData.procedureList;
					} else if ($("#ifType").val() == "B") {
						tData.batchList = interfaceData.batchList;
					} else if ($("#ifType").val() == "S") {
						tData.socketList = interfaceData.socketList;
					}

					//console.log(tData);

					$.ifvSyncPostJSON(tUrl, tData, function(result) {
						if ($.fn.ifvmIsNotEmpty(result)) {
							alert('<spring:message code="V00219" />'); // 완료되었습니다.
							//location.href = '<ifvm:url name="interfaceList"/>';
							qtjs.href('<ifvm:url name="interfaceList"/>');
						}
					}, function(result) {
						alert(result.message);
					});
				}
			}
		},
		list : function() {
			//location.href = '<ifvm:url name="interfaceList"/>';
			qtjs.href('<ifvm:url name="interfaceList"/>');
		},
	}

	function procedureListInit() {

		var ejGridOption = {
			recordDoubleClick : function(args) {
				var data = args.rowIndex;
				pramPopOpen(data);
			},
			editSettings : {
				allowAdding : true,
				allowDeleting : true
			},
			dataSource : interfaceData.procedureList,
			datatype : 'clientSide',
			columns : [ {
				field : 'paramTypeMark',
				headerText : '<spring:message code="Q02875"/>',
				headerTextAlign : 'center', width : '120px' ,
				customAttributes : {
					index : 'c1.markName'
				}
			/*유형*/
			}, {
				field : 'paramSeq',
				headerText : '<spring:message code="Q02876"/>',
				headerTextAlign : 'center', width : '120px' ,
				customAttributes : {
					index : 'qp.seq'
				}
			/*순서*/
			}, {
				field : 'paramName',
				headerText : '<spring:message code="Q02877"/>',
				headerTextAlign : 'center', width : '120px' ,
				customAttributes : {
					index : 'qp.name'
				}
			/*이름*/
			}, {
				field : 'paramDataTypeMark',
				headerText : '<spring:message code="Q02878"/>',
				headerTextAlign : 'center', width : '120px' ,
				customAttributes : {
					index : 'c2.markName'
				}
			/*데이터 유형*/
			}, {
				field : 'paramDataLength',
				headerText : '<spring:message code="Q02879"/>',
				headerTextAlign : 'center', width : '120px' ,
				customAttributes : {
					index : 'qp.data_length'
				}
			/*데이터길이*/
			}, {
				field : 'paramRequiredYnMark',
				headerText : '<spring:message code="Q02880"/>',
				headerTextAlign : 'center', width : '120px' ,
				customAttributes : {
					index : 'c3.markName'
				}
			/*필수여부*/
			}, {
				field : 'paramDefaultValue',
				headerText : '<spring:message code="Q02881"/>',
				headerTextAlign : 'center', width : '120px' ,
				customAttributes : {
					index : 'qp.default_value'
				}
			/*기본값*/
			}, {
				field : 'paramUseYnMark',
				headerText : '<spring:message code="Q02882"/>',
				headerTextAlign : 'center', width : '120px' ,
				customAttributes : {
					index : 'c4.markName'
				}
			/*활성여부*/
			}, {
				field : 'paramComment',
				headerText : '<spring:message code="I00075"/>',
				headerTextAlign : 'center', width : '120px' ,
				customAttributes : {
					index : 'qp.comment'
				}
			/*설명*/
			}, {
				field : 'paramRid',
				headerText : 'rid',
				visible : false,
				customAttributes : {
					index : 'qp.rid'
				}
			}, {
				field : 'paramType',
				headerText : 'paramType',
				visible : false,
				customAttributes : {
					index : 'qp.type'
				}
			}, {
				field : 'paramDataType',
				headerText : 'paramDataType',
				visible : false,
				customAttributes : {
					index : 'qp.data_type'
				}
			}, {
				field : 'paramRequiredYn',
				headerText : 'paramRequiredYn',
				visible : false,
				customAttributes : {
					index : 'qp.required_yn'
				}
			}, {
				field : 'paramUseYn',
				headerText : 'paramUseYn',
				visible : false,
				customAttributes : {
					index : 'qp.use_yn'
				}
			}, ],
			requestGridData : {
				nd : new Date().getTime(),
				rows : 10,
				sidx : 'lm.mbr_no',
				sord : 'desc',
				_search : false
			},
			radio : true,
			rowList : [ 100000 ],
			tempId : 'ifvGridSimpleTemplete',
		};

		interfaceProcedureGrid = $("#interfaceProcedureGrid").ifvsfGrid({
			ejGridOption : ejGridOption
		});
	};

	/**
	 * 파라미터 삭제
	 */
	function pramDelete() {

		var checkedList = interfaceProcedureGrid.opt.gridControl.getSelectedRecords();
		if (checkedList.length > 0) {
			interfaceProcedureGrid.opt.gridControl.deleteRow();
		}

		// 전역변수에 값 매핑
		interfaceData.procedureList = interfaceProcedureGrid.opt.gridControl.model.currentViewData;

		// 그리드 재설정
		procedureListInit();
	}

	function pramPopOpen(rowId) {
		var contentUrl = '<ifvm:url name="ifPramPop"/>';
		var title = '<spring:message code="Q00003"/>';
		if (rowId == 0 || rowId) {
			contentUrl += '?rowId=' + rowId;
			title = '<spring:message code="Q00026"/>';
		}

		$("#popupContainer").ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : contentUrl,
			contentType : "ajax",
			title : title,
			width : '600',
			close : 'popupClose'
		});
	}

	/**
	 * 소켓 삭제
	 */
	function socketDelete() {

		var checkedList = socketListGrid.opt.gridControl.getSelectedRecords();
		if (checkedList.length > 0) {
			socketListGrid.opt.gridControl.deleteRow();
		}

		// 전역변수에 값 매핑
		interfaceData.socketList = socketListGrid.opt.gridControl.model.currentViewData;

		// 그리드 재설정
		socketListInit();
	}

	// 소켓 추가
	function socketPopOpen(rowId) {

		var contentUrl = '<ifvm:url name="ifSocketPop"/>';
		var title = '<spring:message code="Q00027"/>';
		if (rowId == 0 || rowId) {
			contentUrl += '?rowId=' + rowId;
			title = '<spring:message code="Q00028"/>';
		}

		$("#popupContainer").ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : contentUrl,
			contentType : "ajax",
			title : title,
			width : '600',
			close : 'popupClose'
		});
	}

	function socketListInit() {

		var ejGridOption = {
			recordDoubleClick : function(args) {
				var socketRid = args.rowIndex;
				socketPopOpen(socketRid);
			},
			editSettings : {
				allowAdding : true,
				allowDeleting : true
			},
			dataSource : interfaceData.socketList,
			datatype : 'clientSide',
			columns : [ {
				field : 'socketColumnNm',
				headerText : '<spring:message code="Q02901"/>',
				headerTextAlign : 'center' ,width : '120px' ,
				customAttributes : {
					index : 'qs.columnNm'
				}
			/*컬럼명*/
			}, {
				field : 'socketIoTypeMark',
				headerText : '<spring:message code="Q02875"/>',
				headerTextAlign : 'center' ,width : '120px' ,
				customAttributes : {
					index : 'c1.mark_name'
				}
			/*유형*/
			}, {
				field : 'socketDataLength',
				headerText : '<spring:message code="Q02879"/>',
				headerTextAlign : 'center' ,width : '120px' ,
				customAttributes : {
					index : 'qs.dataLength'
				}
			/*데이터길이*/
			}, {
				field : 'socketOrderBy',
				headerText : '<spring:message code="Q02899"/>',
				headerTextAlign : 'center' ,width : '120px' ,
				customAttributes : {
					index : 'qs.orderBy'
				}
			/*정렬순서*/
			}, {
				field : 'socketAttributeMark',
				headerText : '<spring:message code="Q02900"/>',
				headerTextAlign : 'center' ,width : '120px' ,
				customAttributes : {
					index : 'c3.mark_name'
				}
			/*속성*/
			}, {
				field : 'socketDefaultValue',
				headerText : '<spring:message code="M01641"/>',
				headerTextAlign : 'center' ,width : '120px' ,
				customAttributes : {
					index : 'qs.defaultValue'
				}
			/*기본값*/
			}, {
				field : 'socketUseYnMark',
				headerText : '<spring:message code="Q02830"/>',
				headerTextAlign : 'center' ,width : '120px' ,
				customAttributes : {
					index : 'c2.mark_name'
				}
			/*활성여부*/
			}, {
				field : 'socketRid',
				headerText : 'socketRid',
				visible : false,
				customAttributes : {
					index : 'qs.rid'
				}
			}, {
				field : 'socketIoType',
				headerText : 'socketIoType',
				visible : false,
				customAttributes : {
					index : 'qs.ioType'
				}
			}, {
				field : 'socketUseYn',
				headerText : 'socketUseYn',
				visible : false,
				customAttributes : {
					index : 'qs.use_yn'
				}
			}, {
				field : 'socketAttribute',
				headerText : 'socketAttribute',
				visible : false,
				customAttributes : {
					index : 'qs.attribute'
				}
			}, ],
			allowScrolling : true,
			requestGridData : {
				nd : new Date().getTime(),
				_search : false
			},
			radio : true,
			rowList : [ 100000 ],
			tempId : 'ifvGridSimpleTemplete',
		};

		socketListGrid = $("#socketListGrid").ifvsfGrid({
			ejGridOption : ejGridOption
		});
	};

	/* 유형별 영역 설정 */
	function setArea() {

		$("#procArea").hide();
		$("#ftpArea").hide();
		$("#batchArea").hide();
		$("#SocketArea").hide();
		$("#JavaArea").hide();

		if ($("#ifType").val() == "P") {
			procedureListInit();
			$("#procArea").show();
		} else if ($("#ifType").val() == "F") {
			$("#ftpArea").show();
		} else if ($("#ifType").val() == "B") {
			//batchListInit();
			$("#batchArea").show();
		} else if ($("#ifType").val() == "S") {
			socketListInit();
			$("#SocketArea").show();

			var ex = 'Function check Validation(msb, jsonData){\n';
			ex += '//스크립트 로직\n';
			ex += '}        function 제목과 파라미터 명은 예제와 동일하게 작성하시오.';

			$("#ex").html(ex);

		} else if ($("#ifType").val() == "J") {
			$("#JavaArea").show();
		}
	}

	/* 팝업 열기 */
	function popupOpen() {
		/*리소스명*/
		$('#accessInfoPopBtn').on('click', function() {
			$("#popupContainer").ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : '<ifvm:url name="accessInfoPop"/>',
				contentType : "ajax",
				title : '<spring:message code="Q02846"/>',
				width : '600',
				close : 'popupClose'
			});
		});

		/*원본 시스템 */
		$('#sourceInfoPopBtn').on('click', function() {
			$("#popupContainer").ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : '<ifvm:url name="srcTrgInfoPop"/>?srcTgtType=source',
				contentType : "ajax",
				title : '<spring:message code="Q02844"/>',
				width : '600',
				close : 'popupClose'
			});
		});

		/*대상 시스템 */
		$('#sourceTgtScreenBtn2').on('click', function() {
			$("#popupContainer").ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : '<ifvm:url name="srcTrgInfoPop"/>?srcTgtType=target',
				contentType : "ajax",
				title : '<spring:message code="Q02844"/>',
				width : '600',
				close : 'popupClose'
			});
		});

		/*socket_리소스명*/
		$('#recPop').on('click', function() {
			$("#popupContainer").ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : '<ifvm:url name="accessInfoPop"/>',
				contentType : "ajax",
				title : '<spring:message code="Q02846"/>',
				width : '600',
				close : 'popupClose'
			});
		});

		/*파라미터 추가*/
		$('#newPramAdd').on('click', function() {
			pramPopOpen();
		});

		/*배치 추가*/
		$('#newBatchAdd').on('click', function() {
			$("#popupContainer").ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : '<ifvm:url name="ifBatchPop"/>',
				contentType : "ajax",
				title : '<spring:message code="Q00008"/>',
				width : '600',
				close : 'popupClose'
			});
		});

		/*소켓 추가*/
		$('#newSocketAdd').on('click', function() {
			socketPopOpen();
		});

		/* 인터페이스 유형 변경 이벤트 */
		$("#ifType").change(function() {
			setArea();
		});
	}

	function popupClose() {
		popupContainer._destroy();
	}

	//리소스 선택시
	function accessInfoListModalSelected(obj) {
		$('#rscNm').val(obj.rscNm);
		$('#ridRsc').val(obj.rid);
	}

	//소스 타켓 선택시
	function srcTgtSourceListModalSelected(obj, srcTgtType) {
		if (srcTgtType == 'source') {
			$('#sourceAlias').val(obj.srcTgtAlias);
			$('#ridSource').val(obj.rid);
		} else {
			$('#targetAlias').val(obj.srcTgtAlias);
			$('#ridTarget').val(obj.rid);
		}
	}

	$(document).ready(function() {
		getInterfaceDetail.init();
		popupOpen();
	});
</script>

<div class="page-title">
	<h1>
		<spring:message code="Q02849" />
		<!-- 인터페이스 관리 -->
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-2">
		<span><spring:message code="I00195" /></span>
		<!-- 상세 -->
	</div>
	<div class="col-xs-10 searchbtn_r">
		<ifvm:inputNew type="button" id="goSave" btnFunc="getInterfaceDetail.save" text="I00745" />
		<!-- 저장 -->
		<ifvm:inputNew type="button" id="goList" btnFunc="getInterfaceDetail.list" text="L00824" />
		<!-- 목록 -->
	</div>
</div>
<div class="form-horizontal underline top_well" id="interfaceDetailForm">
	<div class="form-horizontal top_well underline">
		<div class="page_btn_area">
			<div class="col-xs-2">
				<span><spring:message code="Q02857" /></span>
				<!-- 기본정보 -->
			</div>
		</div>
		<div class="form-horizontal top_well underline" id="interfaceDetail">
			<div class="row">
				<ifvm:inputNew type="hidden" id="rid" dto="rid" />
				<ifvm:inputNew type="text" id="ifName" dto="ifName" label="Q02842" labelClass="1" conClass="4" required="true" />
				<!-- 인터페이스명 -->
				<ifvm:inputNew type="select" id="ifType" names="ifType" dto="ifType" label="Q02850" labelClass="2" conClass="4" />
				<!-- 인터페이스 유형 -->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="ifId" dto="ifId" label="Q02841" labelClass="1" conClass="4" required="true" />
				<!-- 인터페이스ID -->
				<label class="col-xs-2 control-label"><span class="asterisk">*</span>
				<spring:message code="Q02846" /></label>
				<!-- 리소스명 -->
				<div class="col-xs-4 control_content">
					<div class="input-group">
						<ifvm:input type="hidden" id="ridRsc" dto="ridRsc" />
						<ifvm:input type="text" id="rscNm" dto="rscNm" disabled="true" required="true" />
						<span class="input-group-addon" id="accessInfoPopBtn"> <a><i class="fa fa-search"></i></a>
						</span>
					</div>
				</div>
			</div>
			<div class="row">
				<label class="col-xs-1 control-label"><span class="asterisk">*</span>
				<spring:message code="Q02844" /></label>
				<!-- 원본 시스템 -->
				<div class="col-xs-4 control_content">
					<div class="input-group">
						<ifvm:input type="hidden" id="ridSource" dto="ridSource" />
						<ifvm:input type="text" id="sourceAlias" dto="sourceAlias" disabled="true" required="true" />
						<span class="input-group-addon" id="sourceInfoPopBtn"> <a><i class="fa fa-search"></i></a>
						</span>
					</div>
				</div>
				<label class="col-xs-2 control-label"><span class="asterisk">*</span>
				<spring:message code="Q02845" /></label>
				<!-- 대상 시스템 -->
				<div class="col-xs-4 control_content">
					<div class="input-group">
						<ifvm:input type="hidden" id="ridTarget" dto="ridTarget" />
						<ifvm:input type="text" id="targetAlias" dto="targetAlias" disabled="true" required="true" />
						<span class="input-group-addon" id="sourceTgtScreenBtn2"> <a><i class="fa fa-search"></i></a>
						</span>
					</div>
				</div>
			</div>
			<div class="row">
				<ifvm:inputNew type="select" id="ifMethod" names="ifMethod" dto="ifMethod" label="Q02843" labelClass="1" conClass="4" />
				<!-- 인터페이스 방법 -->
			</div>
			<div class="row">
				<ifvm:inputNew type="textarea" id="comment" dto="comment" label="I00075" labelClass="1" conClass="10" rows="4" />
				<!-- 설명 -->
			</div>
			<div class="row">
				<ifvm:inputNew type="singleCheckbox" id="useYn" dto="useYn" label="M02513" values="" labelClass="1" conClass="2" checked="true" />
				<!-- 활성여부 -->
				<ifvm:inputNew type="singleCheckbox" id="saveLog" dto="saveLog" label="Q02851" values="" labelClass="1" conClass="1" />
				<!-- 개인정보 Log 저장여부 -->
			</div>

		</div>
		<!-- 		파라미터 -->
		<div id="procArea" style="display: none;">
			<div class="page_btn_area">
				<div class="col-xs-2">
					<span><spring:message code="Q02856" /></span>
					<!-- 프로시저 정보 -->
				</div>
			</div>
			<div class="form-horizontal top_well underline">
				<div class="row">
					<ifvm:inputNew type="text" id="procSchema" dto="procSchema" label="Q02852" labelClass="1" conClass="4" />
					<!-- 프로시저 스키마 -->
					<ifvm:inputNew type="text" id="procName" dto="procName" label="Q02853" labelClass="2" conClass="4" />
					<!-- 프로시저명 -->
				</div>
				<div class="row">
					<ifvm:inputNew type="select" id="procResultType" names="procResultType" dto="procResultType" label="Q02854" labelClass="1" conClass="4" />
					<!-- 결과 유형 -->
					<ifvm:inputNew type="text" id="procOption" dto="procOption" label="Q02855" labelClass="2" conClass="4" />
					<!-- 옵션 -->
				</div>
			</div>
			<div>
				<div class="page_btn_area">
					<div class="col-xs-7">
						<span><spring:message code="Q02883" /></span>
						<!-- 파라메터 -->
					</div>
					<div class="col-xs-5 searchbtn_r">
						<button class="btn btn-sm" id="newPramAdd">
							<spring:message code="Q00001" />
							<!--신규-->
						</button>
						<ifvm:inputNew type="button" id="pramDel" text="I02031" btnFunc="pramDelete" />
						<!-- 삭제 -->
					</div>
				</div>
				<div id="interfaceProcedureGrid" class="white_bg grid_bd0"></div>
			</div>
		</div>
		<!-- 		FTP -->
		<div id="ftpArea" style="display: none;">
			<div class="page_btn_area">
				<div class="col-xs-2">
					<span><spring:message code="Q00002" /></span>
					<!-- FTP 정보 -->
				</div>
			</div>
			<div class="form-horizontal top_well underline">
				<div class="row">
					<ifvm:inputNew type="hidden" id="ridFtp" dto="ridFtp" />
					<ifvm:inputNew type="select" id="ftpType" names="ftpType" dto="ftpType" label="Q00020" labelClass="1" conClass="4" />
					<!-- FTP 유형 -->
					<ifvm:inputNew type="select" id="ftpMethod" names="ftpMethod" dto="ftpMethod" label="Q00021" labelClass="1" conClass="4" />
					<!-- FTP 방법-->
				</div>
			</div>
		</div>
		<!-- 		Batch -->
		<div id="batchArea" style="display: none;">
			<div class="page_btn_area">
				<div class="col-xs-7">
					<span><spring:message code="Q02892" /></span>
					<!-- 배치리스트 -->
				</div>
				<div class="col-xs-5 searchbtn_r">
					<button class="btn btn-sm" id="newBatchAdd">
						<spring:message code="Q00007" />
						<!--추가-->
					</button>
					<ifvm:inputNew type="button" id="" text="I02031" btnFunc="" />
					<!-- 삭제 -->
				</div>
			</div>
			<div id="batchListGridCon" class="white_bg grid_bd0"></div>
		</div>
		<!-- 		Socket -->
		<div id="SocketArea" style="display: none;">
			<div class="page_btn_area">
				<div class="col-xs-2">
					<span><spring:message code="Q02896" /></span>
					<!-- 소켓 정보 -->
				</div>
			</div>
			<div class="form-horizontal top_well underline">
				<div class="row">
					<ifvm:inputNew type="text" id="timeout" dto="timeout" label="Q02894" labelClass="1" conClass="4" valiItem="number" />
					<!-- 타임아웃 -->
					<ifvm:inputNew type="text" id="encoding" dto="encoding" label="Q02895" labelClass="1" conClass="4" required="true" />
					<!-- 인코딩 -->
				</div>
				<div class="row">
					<ifvm:inputNew type="text" id="totalLength" dto="totalLength" label="Q02893" labelClass="1" conClass="4" valiItem="number" />
					<!-- 전체길이-->
				</div>
				<div class="row">
					<ifvm:inputNew type="textarea" id="ex" dto="ex" label="Q00006" labelClass="2" conClass="9" rows="4" />
					<!-- EX) -->
				</div>
				<div class="row">
					<ifvm:inputNew type="textarea" id="attr1" dto="attr1" label="Q02898" labelClass="1" conClass="9" rows="8" />
					<!-- 스크립트 -->
				</div>
			</div>
			<div>
				<div class="page_btn_area">
					<div class="col-xs-7">
						<span><spring:message code="L00930" /></span>
						<!-- 조회결과 -->
					</div>
					<div class="col-xs-5 searchbtn_r">
						<ifvm:inputNew type="button" id="newSocketAdd" text="L01169" />
						<!-- 신규 -->
						<ifvm:inputNew type="button" id="socketDel" text="I02031" btnFunc="socketDelete" />
						<!-- 삭제 -->
					</div>
				</div>
				<div id="socketListGrid" class="white_bg grid_bd0"></div>
			</div>
		</div>
		<!-- java -->
		<div id="JavaArea" style="display: none;">
			<div class="page_btn_area">
				<div class="col-xs-2">
					<span><spring:message code="Q02902" /></span>
					<!-- java 클래스 정보 -->
				</div>
			</div>
			<div class="form-horizontal top_well underline">
				<div class="row">
					<ifvm:inputNew type="hidden" id="ridJava" dto="ridJava" />
					<ifvm:inputNew type="text" id="pakageNm" dto="pakageNm" label="Q02903" labelClass="1" conClass="4" required="true" />
					<!-- 패키지명 -->
					<ifvm:inputNew type="text" id="classNm" dto="classNm" label="Q02904" labelClass="1" conClass="4" required="true" />
					<!-- 클래스명 -->
				</div>
				<div class="row">
					<ifvm:inputNew type="select" id="svcMethod" names="svcMethod" dto="svcMethod" label="Q02905" labelClass="1" conClass="4" />
					<!-- 서비스 메소드 -->
					<ifvm:inputNew type="text" id="annotation" dto="annotation" label="Q00022" labelClass="1" conClass="4" />
					<!-- 어노테이션 -->
				</div>
			</div>
		</div>
	</div>
</div>

<div id="popupContainer" class="popup_container"></div>
<!-- 팝업 -->