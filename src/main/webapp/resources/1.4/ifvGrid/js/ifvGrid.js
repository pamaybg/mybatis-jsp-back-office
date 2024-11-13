(function($){
	/**
	 * 
	 * @class ifvGrid
	 * 
	 */
	$.fn.ifvGrid = function(options){

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
			trNum : 0
			
		}, options);
		
		this.init = function(){
			$.extend( options.jqGridOption.ajaxGridOptions, this.jqGridOption.ajaxGridOptions );	//ajaxGridOptions override
			$.extend( this.jqGridOption, options.jqGridOption );
			this.jqGridOption.caption = null;	

			if(this.opt.isRowspan) this.addClass('rowspan_grid');
			
			this.trNum = 0;
			
			this.optionSetting();
			
			this.uiSetting();
			this.keyCheck();
			this.makeGrid();
			this.titleInit();
			this.rowBoxInit();
			this.searchBoxInit();
			this.excelDownInit();
			this.btnInit();
			
			if( this.jqGridOption.url == null || this.jqGridOption.ajaxGridOptions.async == false ){
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
			if( this.opt.grid == null ) return;
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

			var colModels = this.jqGridOption.colModel;
			for ( var i=0, l=colModels.length; i<l; i++ ) {
			    if ( colModels[i].formatter == 'date') {
			        colModels[i].formatoptions.srcformat = 'Y-m-d H:i:s';
			    }
			}

			if( this.jqGridOption.cellurl != null || this.jqGridOption.cellurl == "" ){
				this.jqGridOption.ajaxCellOptions = { contentType: 'application/json', type: 'POST' };
				this.jqGridOption.cellEdit = true;
				this.jqGridOption.cellsubmit = 'remote';
			}
			
			if( this.jqGridOption.onSelectCell != null ){
				this.jqGridOption.cellEdit = true;
			}
			
			if( this.jqGridOption.radio == true ){
				this.radioSetting();
			}
			
			if( this.jqGridOption.seq == true ){
				this.seqSetting();
			}
			
			for( var i = 0; i < this.jqGridOption.colModel.length; i++ ){
				if( this.jqGridOption.colModel[i] != null && this.jqGridOption.colModel[i].width == null ){
					this.jqGridOption.colModel[i].width = 'auto';
				}
			}
			
		};
		
		this.radioSetting = function(){
			if(this.jqGridOption.colModel[0].name == 'radio') return;
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
		        $(this).setSelection(rowid, true);
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

		this.uiSetting = function(){
			var con = $("#" + this.jqGridOption.tempId ).html();
			
			this.gridId = "gridId" + this.attr('id');
			
			con = con.replace('{searchBox}', '<div class="search_box" gridId="searchBox" ></div>' );
			con = con.replace('{rowsBox}', '<input class="combo_num_box" gridId="rowsBox" />' );
			con = con.replace('{grid}', '<table gridId="grid" id="' + this.gridId + '"></table>' );
			con = con.replace('{gridPage}', '<div gridId="gridPage" id="gridPage" ></div>' );
			con = con.replace('{page}', '<div gridId="page" ></div>' );
			con = con.replace('{total}', '<div gridId="total" ></div>' );
			con = con.replace('{btnAdd}', '<input type="button" class="btnAdd" gridId="btnAdd" value="?�록"/>' );
			con = con.replace('{btnDelete}', '<input type="button" class="btnDelete" gridId="btnDelete" value="??��"/>' );
			con = con.replace('{title}', '<div gridId="title" class="title"/>' );
			con = con.replace('{excelDown}', '<button gridId="excelDown" class="btn btn-sm btn-imgonly"><i class="fa fa-search"></i></button>' );
				
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
			this.emptyMsgDiv = $('<div class="empty_msg"></div>');
			this.emptyMsgDiv.text( this.jqGridOption.emptyMsg );
		};
		
		this.makeGrid = function(){
			
			this.makeEmptyDiv();
			this.resizeEvent();
			this.gridEventOverride();
			this.jqGridOption.gridId = this.attr('id');
			this.opt.grid = this.find("[gridId=grid]").jqGrid( this.jqGridOption );
			this.opt.grid.navGrid( "#gridPage", { closeOnEscape:false, del:false, add:false, edit:false, search:false, refresh:false });
			
			this.emptyMsgDiv.insertAfter( this.opt.grid.parent() );
			
			$('.ui-pg-selbox').hide();
			$('.ui-jqgrid-titlebar-close.HeaderButton').hide();
			
			/*if( this.jqGridOption.radio == true ){
				this.find('.ui-jqgrid-hbox').find('input[type=checkbox]')[0].style.display = "none";
			}*/
			this.setWidth( this.width() );
		};
		
		this.styleSetting = function(){
			if( this.jqGridOption.onSelectCell != null && this.opt.grid != null && this.jqGridOption.usePointer != false){
				this.opt.grid.find('td').css({ cursor: "pointer" });
			}
			
			this.cssSetting();
		};
		
        this.cssSetting = function() {
            if (this.jqGridOption.multiselect == true && this.opt.grid != null) {
                this.opt.grid.find(".cbox").parent().addClass('cbox_parent');
            }
            
            if(this.jqGridOption.gridHeight) {
            	this.find('.grid_con').css({
            		'maxHeight' : this.jqGridOption.gridHeight
            		, 'overflow-y' : 'auto'
            	});
            }
        };

        this.resizeEvent = function() {

            var _this = this;
            var timer = null;
            $(window).bind('resize', function() {
            	
                if (timer != null) {
                    clearTimeout(timer);
                }
                timer = setTimeout(function() {
                	console.log('innerWidth : ' + _this.find('.grid_con').prop('clientWidth'));
                    _this.setWidth(_this.find('.grid_con').prop('clientWidth'));
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
		    	$("#gbox_" + this.gridId ).width( width );
				//this.opt.grid.setGridWidth( width, false);
			}
		};

        this.excelDownInit = function() {
            if (this.opt.excelDown == null) return;

            this.opt.excelDown.on('click', function() {
            	fnIfvExcelDownload(this.getAttribute('data-gid'));
            });
        };		

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
            	_this.pageInit();
				
            	_this.jqGridOption.rowNum = obj.key;
            	_this.opt.grid.setGridParam({ rowNum:obj.key });
            	_this.opt.grid.trigger("reloadGrid");
            	
            });
        };
        this.searchBoxInit = function(){

            if( this.opt.searchBox == null ) return;

            var headArr = [];
            var count = 0;
            for( var i = 0; i< this.jqGridOption.colNames.length; i++ ){
            	if( this.jqGridOption.colModel[i].hidden != true && ( this.jqGridOption.colModel[i].searchable == null || this.jqGridOption.colModel[i].searchable ) ){
            		headArr.push( {value: this.jqGridOption.colNames[count], key : this.jqGridOption.colModel[i].index });
            	}
            	if( this.jqGridOption.colModel[i].hidden != true ){
            		count++;
            	}
            }

            var _this = this;
            var searchBox = this.opt.searchBox.ifvSearchBox({ watermark : this.jqGridOption.searchInputWatermark });
            searchBox.setData( headArr, function( searchObj ){

            	_this.pageInit();
				
				$.extend( _this.opt.postData, searchObj);
            	_this.opt.grid.setGridParam({ postData : _this.opt.postData });
            	_this.opt.grid.trigger("reloadGrid");
                
            });
        };

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

		this.pagerSetting = function( data ){
			
			if( this.opt.pager == null ){
				var _this = this;
				this.opt.pager = this.opt.page.ifvSimplePager({
					dataObj : { rows : _this.jqGridOption.rowNum },
					callback: function( page ){
						/**
						 * datatype 이 clientSide 인 경우 서버와 통신하는 postData 가 없으므로 null 체크 추가
						 * 없을 경우 clientSide 에서 페이징 시 에러발생.
						 */
						if(_this.opt.postData != null) {
							_this.opt.postData.page = page;
						}
						_this.opt.grid.setGridParam({ page : page });
                        if(_this.opt.jqGridOption.addGridDataWhenPaging) {
                        	_this.opt.postData = _this.opt.jqGridOption.addGridDataWhenPaging(_this.opt.postData);
                        }
		            	_this.opt.grid.trigger("reloadGrid");
					}
				});
				this.opt.pager.change( data );
			}
		};
		

		this.totalSetting = function( data ){
            if (!data.records) data.records = 0;
			var txt = this.jqGridOption.total.replace('{total}', data.records );
			this.opt.total.text( txt );
		};

		this.gridEventOverride = function(){
			this.jqGridOptionCopy = $.extend({}, this.jqGridOption );
			
			var _this = this;

			this.jqGridOption.serializeGridData = function( data ) {
				
				if( _this.opt.postData == null ){
					_this.opt.postData = {};
					var userData = {};
					if( _this.jqGridOptionCopy.serializeGridData != null ){
						userData = _this.jqGridOptionCopy.serializeGridData( data );
						$.extend( _this.opt.postData, userData );
					};
					
					if( _this.jqGridOptionCopy.addGridDataWhenPaging != null ){
						userData = _this.jqGridOptionCopy.addGridDataWhenPaging( userData );
						$.extend( _this.opt.postData, userData );
					};
				}

				var savePage = _this.opt.postData.page;
				
	        	$.extend( _this.opt.postData, data );
	        	
	        	_this.opt.postData.page = savePage; 
	            return JSON.stringify(_this.opt.postData);
			};
			
			//resposeData ?�팅
			this.jqGridOption.loadComplete = function( data ){
				
				/*if( _this.jqGridOption.radio == true ){
					_this.find('radio_' + this.gridId ).parent().width(40);
				}*/
				
				//if(  data.message != null && _this.opt.postData != null ) _this.opt.postData.lastItemId = data.message;
				if( data.rows != null ){
					if( data.rows.length == 0 ){
						_this.emptyMsgDiv.show();
					}else{
						_this.emptyMsgDiv.hide();
					}
				}
				
				if( $.errorChecker( data ) == false ){
					return;
				}
				
				_this.opt.data = data;
				
				if(_this.opt.jqGridOption.useGroupHeader) {
					_this.groupHeaderSetting();
					delete _this.opt.jqGridOption.useGroupHeader;
				}
				
				_this.pagerSetting( data );
				_this.totalSetting( data );
				_this.styleSetting();
				if(_this.jqGridOptionCopy.isRowspan) _this.rowspanSetting();
				
				//_this.setWidth( _this.width() );
				
				_this.makeEmptyRows();

				if( _this.jqGridOptionCopy.loadComplete != null ){
					_this.jqGridOptionCopy.loadComplete( data );
				};
				
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
								_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, _this.opt.data.rows[i] );
								break;
							}
						}
					}else{
						_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, _this.opt.data.rows[index-1] ); 
					}
				};
			};
			
            var _index = 0;
            
            this.jqGridOption.onSelectRow = function(index, value) {
            	/* selectRow ?�벤?? 2�? 발생 방�? 체크. 2018.01.02 knlee */
            	if(_index == index) return;
            	 _index = index;

            	 if( _this.jqGridOptionCopy.onSelectRow != null ){
					
					if( _this.opt.data == null ){
						_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, index );
					}else if( _this.opt.keyName != null ){
						for( var i = 0; i<_this.opt.data.rows.length; i++ ){
							if( _this.opt.data.rows[i][_this.opt.keyName] == index ){
								_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, _this.opt.data.rows[i] );
								break;
							}
						}
					}else{
						_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, _this.opt.data.rows[index-1] );
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
			if( this.jqGridOption.cellsubmit != null )
				this.opt.grid.editCell(0,0,false);
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


		this.setRowDatas = function(data) {
			var selrowId =  this.opt.grid.jqGrid('getGridParam','selrow');
			this.opt.grid.jqGrid('setRowData', selrowId, data);
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
		
		this.groupHeaderSetting = function() {
			this.opt.grid.jqGrid('setGroupHeaders', this.opt.jqGridOption.useGroupHeader);
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
		
		this.delCheckedRow = function(){
			if( this.jqGridOption.cellsubmit != null )
				this.opt.grid.editCell(0,0,false);
			
			var _this = this;
			var selectlist = this.getCheckedRowIds();
			var deleList = [];
			for( var i = 0; i < selectlist.length; i++ ){
				deleList.push( selectlist[i] );
			}
			$.each(deleList,function(i,v){
				_this.opt.grid.delRowData( v );
			});
		};
		
		this.delRowData = function(){
			if( this.jqGridOption.cellsubmit != null )
				this.opt.grid.editCell(0,0,false);
			
			var ids = this.getCheckedRowIds();
		     var length = ids.length;
		     for( var i = length-1; i>-1; i-- ){
		    	 this.opt.grid.delRowData( ids[i] );
		     }
		};

        this.getSelectedRowId = function() {
			return this.opt.grid.getGridParam('selrow');
		}
		
		this.getSelectedRowData = function() {
			var selrowid = this.getSelectedRowId();
			return this.getRowDatas(selrowid);
		}
		
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
		
		this.removeAll = function(){
			this.opt.grid.jqGrid('clearGridData');
		};
		
		this.addLocalTr = function( obj ){
			this.emptyMsgDiv.hide();
			
			this.trNum++;
			var id = this.attr('id') + this.trNum;
			this.opt.grid.jqGrid('addRowData', id, obj || {} );
			
			this.cssSetting();

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

        this.setSelection = function(rowId) {
        	this.opt.grid.jqGrid('setSelection', rowId);
        	if (this.jqGridOption.radio == true)
        		$('#gridId' + this.attr('id')).find('tr#' + rowId + ' input[type=radio]').prop('checked', true);
        }
		this.jqGridOption = {
				ajaxGridOptions: {
	                contentType: 'application/json',
	                type: 'POST',
	                beforeSend : function(){
	                	var progTxt = MESSAGE.common.gridProgressTxt || '조회';
	                	$.ifvProgressControl(true, null, progTxt);
	                	$.setProgressZindex();
	                },
	                complete : function() {
	                	$.ifvProgressControl(false);
	                }
	            },
	        jsonReader: {
				repeatitems : false,
	            page: 'page',
	            total: 'total',
	            root: 'rows',
	            records : 'records',
	            id: 'colId'
	        },
	        serializeCellData : function(obj){
				delete obj.oper;
				return JSON.stringify(obj);
			},
	        datatype: "json",
	        colNames:[],
	        postData : { 
	        	searchWord : '', 
	        	searchText : '', 
	        	page : 1 ,
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
	        caption:"",
	        tempId : "ifvGridNonFilterTemplete",
	        emptyMsg : ifv.commonMessage.noData,
	        emptyRows : 0,
	        scope : null
		};
		
		this.init();

		return this;
	};
})(jQuery);