(function($){
	/**
	 *
	 * @class ifvGrid
	 *
	 */
	$.fn.ifvGrid2 = function(options) {

		this.opt = $.extend({
			searchBox : null,
			rowsBox : null,
			grid : null,
			gridPage : null,
			page : null,
			pager : null,
			data : null,
			gridId : null,
			postData : null,
			keyName : null,
			isRsizeTime : false,
			jqGridOptionCopy : null,
			isRowspan : false,
			trNum : 0,
			removeData: []

		}, options);

		this.init = function(){
			//data 기본 설정
        	var lst = [];
        	var rmv = [];
        	for (var i=0; i <  options.jqGridOption.data.length; i++) {
        		var obj = options.jqGridOption.data[i];
        		if (typeof obj.dataStatus != 'undefined' && obj.dataStatus == 'D') {
        			rmv.push(obj);
        		} else {
        			lst.push(obj);
        		}
        	}

        	options.jqGridOption.data = lst;
        	this.opt.removeData = rmv;

			$.extend( options.jqGridOption.ajaxGridOptions, this.jqGridOption.ajaxGridOptions );	//ajaxGridOptions override
			$.extend( this.jqGridOption, options.jqGridOption );
			this.jqGridOption.caption = null;	//jqgrid기본 타이틀 안쓰려고

			//20160728 sj.baek - rowspan 기능이 들어갈 경우 hover 및 highlight style 제거를 위해 class 추가
			if(this.opt.isRowspan) this.addClass('rowspan_grid');

			this.trNum = 0;

			this.optionSetting();

			this.uiSetting();
			this.keyCheck();
			this.makeGrid();
			this.titleInit();
			this.rowBoxInit();
			this.searchBoxInit();
			this.btnInit();

			if( this.jqGridOption.url == null || this.jqGridOption.ajaxGridOptions.async == false ){	//서버통신없을시와 비동기일때 td한개 생성
				if( this.jqGridOption.emptyRows == 0 ){
					var rowDatas = this.opt.grid.getRowData();
					if( rowDatas.length == 0 ){
						this.emptyMsgDiv.show();
					}
				}else{
					this.makeEmptyRows();
				}
			}
		};

		this.setEmptyRows = function(emptyRows){
			this.jqGridOption.emptyRows = emptyRows;
			this.makeEmptyRows();
		};

		this.makeEmptyRows = function(){
			if( this.opt.grid == null ) return;	//sync일때는 jqgrid가 인스턴스화 되기 전에 loadComplete가 떨어져서 리턴 init에서 다시 호출함
			var dataRow = this.getRowData();
			var length = this.jqGridOption.emptyRows - dataRow.length;

			for( var i = 0; i < length; i++ ){
				this.addLocalTr();
			}
		};

		this.addRows = function(list){
			for( var i = 0; i < list.length; i++ ){
				this.addLocalTr(list[i]);
			}
			this.makeEmptyRows();
		};

		this.optionSetting = function(){

			var _this = this;

			this.jqGridOption.rowNum = this.jqGridOption.rowList[0];	//default rowNum

			// 최인한. 20150515 날자 입력시 시간or 분이 제대로 안나오는 오류 수정.
			var colModels = this.jqGridOption.colModel;
			for ( var i=0, l=colModels.length; i<l; i++ ) {
			    if ( colModels[i].formatter == 'date') {
			        colModels[i].formatoptions.srcformat = 'Y-m-d H:i:s';
			    }
			}

			//cellurl이 있으면 cell수정모드 옵션 추가
			if( this.jqGridOption.cellurl != null || this.jqGridOption.cellurl == "" ){
				this.jqGridOption.ajaxCellOptions = { contentType: 'application/json', type: 'POST' };
				this.jqGridOption.cellEdit = true;
				this.jqGridOption.cellsubmit = 'remote';
			}

			if( this.jqGridOption.onSelectCell != null ){
				this.jqGridOption.cellEdit = true;	//cellEdit가 true 일때만 onSelectCell 이벤트 발생
			}

			if( this.jqGridOption.radio == true ){
				this.radioSetting();
				/*this.jqGridOption.multiselect = true;
				this.jqGridOption.beforeSelectRow = function(){
					if( _this.jqGridOption.cellEdit == true ){
						_this.find( '[aria-describedby=' + _this.gridId + '_cb]' ).find('input[type=checkbox]').prop('checked', false );
					}else{
						_this.opt.grid.jqGrid('resetSelection');
					}
					return(true);
				};*/
			}

			for( var i = 0; i < this.jqGridOption.colModel.length; i++ ){
				if( this.jqGridOption.colModel[i] != null && this.jqGridOption.colModel[i].width == null ){
					this.jqGridOption.colModel[i].width = 'auto';
				}
			}

		};

		this.radioSetting = function(){
			var _this = this;
			var obj = { name : 'radio', align : 'center', width:45, editable : false, edittype : "radio", sortable : false, searchable :false
				,formatter: function( cellValue, option ){
        			return '<input type="radio" name="radio_' + _this.gridId + '"  />';
    			}
			};
			this.jqGridOption.colNames.unshift( ifv.commonMessage.select );
			this.jqGridOption.colModel.unshift(obj);

			this.jqGridOption.beforeSelectRow = function( rowid, e ){
		        var $radio = $(e.target).closest('tr').find('input[type="radio"]');
		        $radio.attr('checked', 'checked');
		        return true; // allow row selection
		    };
		};

		this.titleInit = function(){
			var title = options.jqGridOption.caption;
			if( title != null && title != "" ){
				this.opt.title.html( title );
			}else{
				this.opt.title.remove();
			}
		};

		this.btnInit = function(){
			var _this = this;




			if( this.opt.rowsBox != null ){
				this.opt.btnAdd.click(function() {
					if( _this.jqGridOption.cellEdit == true ){

						if( _this.opt.data != null && _this.opt.data.rows != null ){
							_this.opt.grid.jqGrid('addRowData', _this.opt.data.rows.length, {} );
						}else{
							//서버통신안한상태에서 tr추가 할때
							_this.addLocalTr();
						}
					}else if( _this.jqGridOption.addBtnClick != null ){
						_this.jqGridOption.addBtnClick();
					}
				});
			}

			if( this.jqGridOption.multiselect == true ){
				if( this.opt.btnDelete != null ){
					this.opt.btnDelete.click(function() {
					     _this.delRowData();
					});
				}
			}
		};


		this.keyCheck = function(){
			for( var i = 0; i<this.jqGridOption.colModel.length; i++ ){
				if( this.jqGridOption.colModel[i].key != null ){
					this.opt.keyName = this.jqGridOption.colModel[i].name;
					break;
				}
			}
		};

		/*
		 * ui 탬플릿 읽어들여서 컴퍼넌트 태그로 변환
		 */
		this.uiSetting = function(){

			var con = $("#" + this.jqGridOption.tempId ).html();

			this.gridId = "gridId" + this.attr('id');

			con = con.replace('{searchBox}', '<div class="search_box" gridId="searchBox" ></div>' );
			con = con.replace('{rowsBox}', '<input class="combo_num_box" gridId="rowsBox" />' );
			con = con.replace('{grid}', '<table gridId="grid" id="' + this.gridId + '"></table>' );
			con = con.replace('{gridPage}', '<div gridId="gridPage" id="gridPage" ></div>' );
			con = con.replace('{page}', '<div gridId="page" ></div>' );
			con = con.replace('{total}', '<div gridId="total" ></div>' );
			con = con.replace('{btnAdd}', '<input type="button" class="btnAdd" gridId="btnAdd" value="등록"/>' );
			con = con.replace('{btnDelete}', '<input type="button" class="btnDelete" gridId="btnDelete" value="삭제"/>' );
			con = con.replace('{title}', '<div gridId="title" class="title"/>' );
			con = con.replace('{excelDown}', '<input type="button" class="excelDown" gridId="excelDown" value="다운로드"/>' );

			this.html(con);

			this.opt.searchBox = this.find("[gridId=searchBox]");
			this.opt.rowsBox = this.find("[gridId=rowsBox]");
			this.opt.gridPage = this.find("[gridId=gridPage]");
			this.opt.page = this.find("[gridId=page]");
			this.opt.total = this.find("[gridId=total]");
			this.opt.btnAdd = this.find("[gridId=btnAdd]");
			this.opt.btnDelete = this.find("[gridId=btnDelete]");
			this.opt.title = this.find("[gridId=title]");
			this.opt.excelDown = this.find("[gridId=excelDown]");

		};

		this.makeEmptyDiv = function(){
			//데이타없을때 나오는 영역
			this.emptyMsgDiv = $('<div class="empty_msg"></div>');
			this.emptyMsgDiv.text( this.jqGridOption.emptyMsg );
		};


		/**
		 * jqGrid 생성
		 */
		this.makeGrid = function(){

			this.makeEmptyDiv();
			this.resizeEvent();
			this.gridEventOverride();
			this.jqGridOption.gridId = this.attr('id');
			this.opt.grid = this.find("[gridId=grid]").jqGrid( this.jqGridOption );
			this.opt.grid.navGrid( "#gridPage", { closeOnEscape:false, del:false, add:false, edit:false, search:false, refresh:false });

			this.emptyMsgDiv.insertAfter( this.opt.grid.parent() );

			$('.ui-pg-selbox').hide();	//기본 페이지 셀렉트 박스 숨기기
			$('.ui-jqgrid-titlebar-close.HeaderButton').hide(); //기본 접기 버튼 숨기기

			/*if( this.jqGridOption.radio == true ){
				this.find('.ui-jqgrid-hbox').find('input[type=checkbox]')[0].style.display = "none";
			}*/
			this.setWidth( this.width() );
		};

		this.styleSetting = function(){
			if( this.jqGridOption.onSelectCell != null && this.opt.grid != null ){
				this.opt.grid.find('td').css({ cursor: "pointer" });
			}

			this.cssSetting();
		};

		this.cssSetting = function(){
			if( this.jqGridOption.multiselect == true && this.opt.grid != null ){
				this.opt.grid.find(".cbox").parent().addClass('cbox_parent');
			}
		};

		this.resizeEvent = function(){

			var _this = this;
			var timer = null;
		    $(window).bind('resize', function() {

		    	if( timer != null ){
		    		clearTimeout( timer );
		    	}
		    	timer = setTimeout(function(){
		    		_this.setWidth( _this.width() );
		    	}, 250);
		    });
		};

		this.setWidth = function( width ){

			if( this.opt.grid != null ){
				this.find('.ui-jqgrid-view').width( width );
				this.find('.ui-state-default.ui-jqgrid-hdiv').width( width );
				this.find('.ui-jqgrid-bdiv').width( width );
				this.find('.ui-jqgrid-hbox table').width( width );
		    	this.find('.ui-jqgrid-bdiv table').width( width );
		    	this.find('.ui-jqgrid-sdiv').width( width );
		    	$("#gbox_" + this.gridId ).width( width ); //gbox ( grid전체 감싸고있는 div ) width 변경
				//this.opt.grid.setGridWidth( width, false);
			}
		};

		/**
		 *	row 셀렉트 박스 초기화
		 */
		this.rowBoxInit = function(){
            if( this.opt.rowsBox == null ) return;

            var arr = [];
            for( var i = 0; i < this.jqGridOption.rowList.length; i++ ){
            	var obj = { value : this.jqGridOption.rowList[i], key : this.jqGridOption.rowList[i] };
            	if( i == 0 ) obj.selected = true;
            	arr.push( obj );
            }

            var selectbox = this.opt.rowsBox.ifvSelectBox();

            var _this = this;
            selectbox.setData(arr, function(obj){
            	//검색시에는 토탈 갯수 바뀌므로 페이지다시 만듬 page도 1로
            	_this.pageInit();

            	_this.jqGridOption.rowNum = obj.key;
            	_this.opt.grid.setGridParam({ rowNum:obj.key });
            	_this.opt.grid.trigger("reloadGrid");

            });
        };

        /**
		 *	검색 박스 초기화
		 */
        this.searchBoxInit = function(){

            if( this.opt.searchBox == null ) return;

            var headArr = [];
            var count = 0;
            for( var i = 0; i< this.jqGridOption.colNames.length; i++ ){
            	if( this.jqGridOption.colModel[i].hidden != true && ( this.jqGridOption.colModel[i].searchable == null || this.jqGridOption.colModel[i].searchable == true) ){
            		headArr.push( {value: this.jqGridOption.colNames[count], key : this.jqGridOption.colModel[i].index }); //colModel은 hidden이 있으므로 count로 indexing
            	}
            	if( this.jqGridOption.colModel[i].hidden != true ){
            		count++;
            	}
            }

            var _this = this;
            var searchBox = this.opt.searchBox.ifvSearchBox({ watermark : this.jqGridOption.searchInputWatermark });
            searchBox.setData( headArr, function( searchObj ){

            	//검색시에는 토탈 갯수 바뀌므로 페이지다시 만듬 page도 1로
            	_this.pageInit();

				$.extend( _this.opt.postData, searchObj);
            	_this.opt.grid.setGridParam({ postData : _this.opt.postData });
            	_this.opt.grid.trigger("reloadGrid");

            });
        };

        /**
		 * postData 오버라이드후 서비스 요청
		 */
        this.requestData = function(obj){

        	this.pageInit();

        	$.extend( this.opt.postData, obj);

        	this.opt.grid.setGridParam({ postData : this.opt.postData });
        	this.opt.grid.trigger("reloadGrid");
        };

        this.pageInit = function(){
        	if( this.opt.pager != null ){
        		this.opt.pager.empty();
            	this.opt.pager = null;
            	this.opt.grid.setGridParam({ page : 1 });
            	this.opt.postData.page = 1;
        	}
        };

        /*
		 * 페이지 셋팅 및 변환
		 */
		this.pagerSetting = function( data ){

			if( this.opt.pager == null ){
				var _this = this;
				this.opt.pager = this.opt.page.ifvSimplePager({
					dataObj : { rows : _this.jqGridOption.rowNum },
					callback: function( page ){
						_this.opt.postData.page = page;
						_this.opt.grid.setGridParam({ page : page });
		            	_this.opt.grid.trigger("reloadGrid");
					}
				});
				this.opt.pager.change( data );
			}
		};

		/*
		 * 토탈 셋팅
		 */
		this.totalSetting = function( data ){
			if (!data.records) data.records = 0;
			var txt = this.jqGridOption.total.replace('{total}', data.records );
			this.opt.total.text( txt );
		};

        /*
         * 사용자 설정 option 내에 함수 설정
         */
		this.gridEventOverride = function(){
			this.jqGridOptionCopy = $.extend({}, this.jqGridOption );	//사용자 설정 option저장

			var _this = this;
			//jqGrid에서 넘어오는 함수

			//서버에 데이타 보내기 전 requestData 셋팅
			this.jqGridOption.serializeGridData = function( data ) {

				if( _this.opt.postData == null ){	//최초에만 init 데이타 오버라이드
					_this.opt.postData = {};
					if( _this.jqGridOptionCopy.serializeGridData != null ){
						var userData = _this.jqGridOptionCopy.serializeGridData( data );//사용자 정의 함수 호출
						$.extend( _this.opt.postData, userData );
					};
				}
				var savePage = _this.opt.postData.page;

	        	$.extend( _this.opt.postData, data );

	        	_this.opt.postData.page = savePage; //page는 grid에 page번호를 안쓰고 pager의 page번호를쓴다( sort시 gqrid는페이지1로 바꾸지만 ifv는 안바꾸는것이 규칙)

	            return JSON.stringify(_this.opt.postData);
			};

			//resposeData 셋팅
			this.jqGridOption.loadComplete = function( data ){

				/*if( _this.jqGridOption.radio == true ){
					_this.find('radio_' + this.gridId ).parent().width(40);
				}*/

				//if(  data.message != null && _this.opt.postData != null ) _this.opt.postData.lastItemId = data.message;	//서버에서 lastItemId을 줄경우만 다시 주기위해 저장
				if( data.rows != null ){
					if( data.rows.length == 0 ){
						_this.emptyMsgDiv.show();
					}else{
						_this.emptyMsgDiv.hide();
					}
				}

				//금지어가 있을 경우 grid empty
				if( data.errorType == '200600' ){
					_this.emptyMsgDiv.show();
				}

				if( $.errorChecker( data ) == false ){
					return;
				}

				_this.opt.data = data;

				if( _this.jqGridOptionCopy.loadComplete != null ){
					_this.jqGridOptionCopy.loadComplete( data );//사용자 정의 함수 호출
				};

				_this.pagerSetting( data );
				_this.totalSetting( data );
				_this.styleSetting();
				if(_this.jqGridOptionCopy.isRowspan) _this.rowspanSetting();

				//_this.setWidth( _this.width() );

				_this.makeEmptyRows();

				//data.rows status
				for (var i=0; i < _this.opt.data.rows.length; i++) {
					var obj = _this.opt.data.rows[i];
					if (typeof obj.dataStatus == 'undefined' || obj.dataStatus == '' || obj.dataStatus == 'null') {
						_this.opt.data.rows[i].dataStatus = 'N';
					}
				}

			};

			this.rowspanSetting = function() {
				var rowGrid = this;
				$('td[name="cellRowspan"]', rowGrid).each(function() {
					var spans = $('td[rowspanid="' + this.id + '"]', rowGrid).length+1;
					if(spans>1){
						$(this).attr('rowspan', spans);
					}
				});
			};

			this.jqGridOption.onSelectCell = function( index, value, element, row, col ){
				if( _this.jqGridOptionCopy.onSelectCell != null ){
					if( _this.isRadioAreaClick(col) ) return;

					if( _this.opt.data == null ){
						_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, index );
					}else if( _this.opt.keyName != null ){
						for( var i = 0; i<_this.opt.data.rows.length; i++ ){
							if( _this.opt.data.rows[i][_this.opt.keyName] == index ){
								_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, _this.opt.data.rows[i] ); //사용자 정의 함수 호출
								break;
							}
						}
					}else{
						_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, _this.opt.data.rows[index-1] );   //사용자 정의 함수 호출
					}
				};
			};

			this.jqGridOption.onSelectRow = function( index, value ){
				if( _this.jqGridOptionCopy.onSelectRow != null ){

					if( _this.opt.data == null ){
						_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, index );
					}else if( _this.opt.keyName != null ){
						for( var i = 0; i<_this.opt.data.rows.length; i++ ){
							if( _this.opt.data.rows[i][_this.opt.keyName] == index ){
								_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, _this.opt.data.rows[i] );//사용자 정의 함수 호출
								break;
							}
						}
					}else{
						_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, _this.opt.data.rows[index-1] );//사용자 정의 함수 호출
					}
				};
			};

			this.jqGridOption.onCellSelect = function( id, colIndex ){

				if( _this.jqGridOptionCopy.onCellSelect != null ){

					if( _this.isRadioAreaClick(colIndex) ) return;
					var obj = _this.opt.grid.getRowData( id );
					obj.rowId = id;
					obj.colIndex = colIndex;
					_this.jqGridOptionCopy.onCellSelect.call( _this.jqGridOption.scope, obj );
				}
			};

		};

		this.isRadioAreaClick = function(colIndex){
			return this.jqGridOption.radio == true && colIndex == 0;
		};

		/**
		 *
		 * public method
		 *
		 */

		this.resetChecked = function(){
			this.opt.grid.resetSelection();
		};

		this.setCheckRow = function( list ){

			var checkedArr = this.opt.grid.getGridParam('selarrrow');

			for( var i = 0; i < this.opt.data.rows.length; i++ ){
				var id = list[i];
				if( checkedArr.indexOf( list[i] ) < 0 ){
					this.opt.grid.setSelection( id, false);
				}
			};
		};

		this.getRowData = function(){
			if( this.opt.grid == null ) return [];
			if( this.jqGridOption.cellsubmit != null )	//editCell발생시 selectCell이벤트 발생하는 버그 때문에 분기처리
				this.opt.grid.editCell(0,0,false);	//edit중인 cell있으면 닫기
			return this.opt.grid.getRowData();
		};

		this.getRowDatas = function(rowId) {
			var selrowId;
			if(typeof rowId != "undefined")
				selrowId = rowId;
			else
				selrowId =  this.opt.grid.jqGrid('getGridParam','selrow');
			var selrowData = this.opt.grid.jqGrid('getRowData', selrowId);
			return selrowData;
		}

		//17.07.03 dg.ryu
		this.setRowDatas = function(data) {
			var selrowId =  this.opt.grid.jqGrid('getGridParam','selrow');
			this.opt.grid.jqGrid('setRowData', selrowId, data);

			//row data 수정
			var idx = this.opt.grid.getInd(selrowId) - 1;

			var obj = this.opt.data.rows[idx];

			var rtn = $.fn.ifvmMergeObjectProperty(obj, data);
			rtn.dataStatus = 'U';
			this.opt.data.rows[idx] = rtn;
		}

		this.getSum = function(cName, vName) {
			return this.opt.grid.jqGrid('getCol', cName, false, vName);
		}

		this.setFooter = function(data){
			this.opt.grid.jqGrid("footerData", "set", data);

			var rowDatas = this.opt.grid.getRowData();
			if( rowDatas.length == 0 )
				$("#" + this.attr('id') + " .ui-jqgrid-sdiv").hide();
			else
				$("#" + this.attr('id') + " .ui-jqgrid-sdiv").show();
		}

		this.setColspanTotal = function( arr ){

			var footRow = $("#" + this.attr('id') ).find(".footrow");
			var nameArr = [];
			var width2 = 0;

			for( var i=0; i<arr.length; i++){
				var item = footRow.find('>td[aria-describedby="gridId' + this.attr('id') + '_'+ arr[i] +'"]');
				nameArr.push(item);
				if( i == 0 ){
					width2 += item.width();
				}else {
					width2 += item.outerWidth();
				}
			}

			for( var i=0; i<arr.length; i++){
				if( i !== 0 ){
					nameArr[i].hide();
				}
			}

			nameArr[0].attr("colspan", nameArr.length).width(width2);
		}

		this.getCheckedList = function(){
			var selectlist = this.getCheckedRowIds();
			var returnList = [];
			for( var i = 0; i<this.opt.data.rows.length; i++ ){
				if( selectlist.indexOf( String(i + 1) ) > -1 ){
					returnList.push( this.opt.data.rows[i] );
				}
			}
			return returnList;
		};

		this.getCheckedGridData = function(){
			var selectlist = this.getCheckedRowIds();

			var returnList = [];
			for( var i = 0; i<selectlist.length; i++ ){
				var obj = this.opt.grid.getRowData( selectlist[i] );
				obj.rowId = selectlist[i];
				returnList.push( obj );
			}
			return returnList;
		};

		this.getRadioSelectedRowId = function(){
			var radioArr = this.opt.grid.find('[name=radio_' + this.gridId + ']:checked').parent().parent();
			var arr = [];
			for( var i = 0; i < radioArr.length; i++ ){
				arr.push( $(radioArr[i]).attr('id') );
			}
			return arr;
		};

		//17.07.03 dg.ryu
		this.delCheckedRow = function(){
			if( this.jqGridOption.cellsubmit != null )	//editCell발생시 selectCell이벤트 발생하는 버그 때문에 분기처리
				this.opt.grid.editCell(0,0,false);	//edit중인 cell있으면 닫기

			var _this = this;
			var selectlist = this.getCheckedRowIds();
			var deleList = [];
			for( var i = 0; i < selectlist.length; i++ ){
				deleList.push( selectlist[i] );
			}

			//row 상태 (D: 삭제)
			$.each(deleList,function(i,v){
				var idx = this.opt.grid.getInd(v) - 1;
				_this.opt.data.rows[idx].dataStatus='D';

				_this.opt.grid.delRowData( v );

				_this.opt.removeData.push(this.opt.data.rows[idx]);
				_this.opt.data.rows.remove(idx);
			});

			//row 없을때 표시
			if (_this.getAllRowIds().length == 0) {
				_this.emptyMsgDiv.show()
			}
		};

		//17.07.03 dg.ryu
		this.delRowData = function(){
			if( this.jqGridOption.cellsubmit != null )	//editCell발생시 selectCell이벤트 발생하는 버그 때문에 분기처리
				this.opt.grid.editCell(0,0,false);	//edit중인 cell있으면 닫기

			var ids = this.getCheckedRowIds();
			var length = ids.length;
			for( var i = length-1; i>-1; i-- ){
				var idx = this.opt.grid.getInd(ids[i]) - 1;
				this.opt.data.rows[idx].dataStatus='D';

				this.opt.grid.delRowData( ids[i] );

				this.opt.removeData.push(this.opt.data.rows[idx]);
				this.opt.data.rows.remove(idx);
			}

			//row 없을때 표시
			if (this.getAllRowIds().length == 0) {
				this.emptyMsgDiv.show()
			}
		};

		this.getCheckedRowIds = function(){
			var selectlist = [];
			if( this.jqGridOption.radio == true ){
				selectlist = this.getRadioSelectedRowId();
			}else{
				selectlist = this.opt.grid.getGridParam('selarrrow');
			}
			return selectlist;
		};

		this.getAllRowIds = function(){
			var selectlist = [];
			selectlist = this.opt.grid.jqGrid('getDataIDs');
			return selectlist;
		};

		//17.07.03 dg.ryu
		this.removeAll = function(){
			this.opt.grid.jqGrid('clearGridData');

			for (var i=0; i < this.opt.data.rows.length; i++) {
				this.opt.data.rows[i].dataStatus = 'D';
				this.opt.removeData.push(this.opt.data.rows[i]);
			}

			this.opt.data.rows = [];
			this.emptyMsgDiv.show();
		};

		//17.07.03 dg.ryu
		this.addLocalTr = function( obj ){
			this.emptyMsgDiv.hide();

			this.trNum++;
			var id = this.attr('id') + this.trNum;
			this.opt.grid.jqGrid('addRowData', id, obj || {} );

			this.cssSetting();

			var data;
			if (typeof obj != 'undefined') {
				data = obj;
			} else {
				data = this.getRowDatas(id);
			}

			data.dataStatus = 'I';

			this.opt.data.rows.push(data);

			//this.opt.grid.find('#' + id).attr('dataObj', obj || {} );
		};

		this.editCell = function(rowId, colIndex, active ){
			if( this.opt.grid.find(".edit-cell").length > 0 ){
				this.opt.grid.editCell( rowId, colIndex, active);
			}
		};

		this.setLabel = function(obj){
			if(obj.length == 0) return;
			for(var i = 0; i < obj.length; i++) {
				this.opt.grid.jqGrid('setLabel', obj[i].colName, obj[i].newName, obj[i].styleType);
			}
		};

		/**
		 * 17.07.03
		 * dg.ryu
		 * 라디오 선택된 row 생성 아이디
		 */
		this.getSelRadioGenId = function() {
			var rowid = this.getRadioSelectedRowId()[0];	//라디오버튼 선택 rowid
			var genid = this.opt.grid.getInd(rowid);		//생성 아이디

			return genid;
		}

		/**
		 * 17.07.03
		 * dg.ryu
		 * 라디오 선택된 row 데이터
		 */
		this.getSelRadioData = function() {
			var idx = this.getSelRadioGenId() - 1;
			var data = this.opt.data.rows[idx];

			return data;
		}
		/**
		 * 17.07.03
		 * 그리드의 데이터 rows 추출
		 */
		this.getDataRows = function() {
			return this.opt.data.rows;
		}

		/**
		 * 17.07.03
		 * dg.ryu
		 * 그리드 데이터
		 */
		this.getAllRowData = function() {
			var rtn = [];
			//현재 rows
			for (var i=0; i <  this.opt.data.rows.length; i++) {
				rtn.push(this.opt.data.rows[i]);
			}

			//삭제 rows
			for (var i=0; i <  this.opt.removeData.length; i++) {
				rtn.push(this.opt.removeData[i]);
			}

			return rtn;
		}

        /**
         * 기본 옵션 설정, 리턴func 설정은 this.gridEventOverride에서
         */
		this.jqGridOption = {
			ajaxGridOptions: { contentType: 'application/json', type: 'POST',  async: true},
	        jsonReader: {
				repeatitems : false,
	            page: 'page',
	            total: 'total',
	            root: 'rows',
	            records : 'records',
	            id: 'colId'//꼭 화면 전체에서 겹치는 값이 업는 column을 설정할 것 안그러면 에러 발생
	        },
	        serializeCellData : function(obj){	//cell edit시 데이타 json변환
				delete obj.oper;
				return JSON.stringify(obj);
			},
	        datatype: "json",
	        colNames:[],
	        postData : {
	        	searchWord : '',
	        	searchText : '',
	        	page : 1 ,
	        	/* 20150511 최인한 language parameter 추가. */
	        	appServiceId : window.appServiceId,
	        	country : window.country,
	        	lang : window.lang
	         },
	        colModel:[],
	        rowNum:10,
	        height:'auto',
	        rowList:[10,20,30],
	        pager: '',
	        //autowidth : true,
	        total : ifv.commonMessage.total + ' : {total}' + ifv.commonMessage.gun,
	        /*sortname: 'invdate',
	        sortorder: "desc",*/
	        caption:"",
	        tempId : "ifvGridTemplete",
	        emptyMsg : ifv.commonMessage.noData,
	        emptyRows : 0,
	        scope : null
		};

		//18.08.20 jk.kim
		this.delAllRowData = function(){
			if( this.jqGridOption.cellsubmit != null )	//editCell발생시 selectCell이벤트 발생하는 버그 때문에 분기처리
				this.opt.grid.editCell(0,0,false);	//edit중인 cell있으면 닫기

			var ids = this.getAllRowData();
			var length = ids.length;
			if(this.opt.data.rows.length>0){
				for( var i = length-1; i>-1; i-- ){

					this.opt.data.rows[i].dataStatus='D';

					this.opt.grid.delRowData( ids[i] );

					this.opt.removeData.push(this.opt.data.rows[i]);
					this.opt.data.rows.remove(i);
				}
			}

			//row 없을때 표시
			if (this.getAllRowIds().length == 0) {
				this.emptyMsgDiv.show()
			}
		};


		this.init();

		return this;
	};
})(jQuery);