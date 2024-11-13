//jsonpgrid
(function($){
	/**
	 *
	 * @class ifvJSONPGrid
	 *
	 */
	$.fn.ifvJSONPGrid = function(options){
		options.url += '?callback=?';
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
			//$.extend( this.jqGridOption.url, options.jqGridOption.url + '?callback=?' );
			//this.jqGridOption.url += '?callback=?';
			this.jqGridOption.caption = null;	//jqgrid湲곕낯 ���댄� �덉벐�ㅺ퀬

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

			if( this.jqGridOption.url == null || this.jqGridOption.ajaxGridOptions.async == false ){	//�쒕쾭�듭떊�놁쓣�쒖� 鍮꾨룞湲곗씪�� td�쒓컻 �앹꽦
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
			if( this.opt.grid == null ) return;	//sync�쇰븣�� jqgrid媛� �몄뒪�댁뒪�� �섍린 �꾩뿉 loadComplete媛� �⑥뼱�몄꽌 由ы꽩 init�먯꽌 �ㅼ떆 �몄텧��
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

			// 理쒖씤��. 20150515 �좎옄 �낅젰�� �쒓컙or 遺꾩씠 �쒕�濡� �덈굹�ㅻ뒗 �ㅻ쪟 �섏젙.
			var colModels = this.jqGridOption.colModel;
			for ( var i=0, l=colModels.length; i<l; i++ ) {
			    if ( colModels[i].formatter == 'date') {
			        colModels[i].formatoptions.srcformat = 'Y-m-d H:i:s';
			    }
			}

			//cellurl�� �덉쑝硫� cell�섏젙紐⑤뱶 �듭뀡 異붽�
			if( this.jqGridOption.cellurl != null || this.jqGridOption.cellurl == "" ){
				this.jqGridOption.ajaxCellOptions = { contentType: 'application/json', type: 'POST' };
				this.jqGridOption.cellEdit = true;
				this.jqGridOption.cellsubmit = 'remote';
			}

			if( this.jqGridOption.onSelectCell != null ){
				this.jqGridOption.cellEdit = true;	//cellEdit媛� true �쇰븣留� onSelectCell �대깽�� 諛쒖깮
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
			var _this = this;
			var obj = { name : 'radio', align : 'center', width:45, editable : false, edittype : "radio", 
					customAttributes: { sortable : false, searchable :false }
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
							_this.opt.grid.jqJSONPGrid('addRowData', _this.opt.data.rows.length, {} );
						}else{
							//�쒕쾭�듭떊�덊븳�곹깭�먯꽌 tr異붽� �좊븣
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
		 * ui �ы뵆由� �쎌뼱�ㅼ뿬�� 而댄띁�뚰듃 �쒓렇濡� 蹂���
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
			con = con.replace('{btnAdd}', '<input type="button" class="btnAdd" gridId="btnAdd" value="�깅줉"/>' );
			con = con.replace('{btnDelete}', '<input type="button" class="btnDelete" gridId="btnDelete" value="��젣"/>' );
			con = con.replace('{title}', '<div gridId="title" class="title"/>' );

			this.html(con);

			this.opt.searchBox = this.find("[gridId=searchBox]");
			this.opt.rowsBox = this.find("[gridId=rowsBox]");
			this.opt.gridPage = this.find("[gridId=gridPage]");
			this.opt.page = this.find("[gridId=page]");
			this.opt.total = this.find("[gridId=total]");
			this.opt.btnAdd = this.find("[gridId=btnAdd]");
			this.opt.btnDelete = this.find("[gridId=btnDelete]");
			this.opt.title = this.find("[gridId=title]");

		};

		this.makeEmptyDiv = function(){
			//�곗씠���놁쓣�� �섏삤�� �곸뿭
			this.emptyMsgDiv = $('<div class="empty_msg"></div>');
			this.emptyMsgDiv.text( this.jqGridOption.emptyMsg );
		};


		/**
		 * jqGrid �앹꽦
		 */
		this.makeGrid = function(){
			this.makeEmptyDiv();
			this.resizeEvent();
			this.gridEventOverride();
			this.jqGridOption.gridId = this.attr('id');
			this.opt.grid = this.find("[gridId=grid]").jqJSONPGrid( this.jqGridOption );
			this.opt.grid.navGrid( "#gridPage", { closeOnEscape:false, del:false, add:false, edit:false, search:false, refresh:false });

			this.emptyMsgDiv.insertAfter( this.opt.grid.parent() );

			$('.ui-pg-selbox').hide();	//湲곕낯 �섏씠吏� ���됲듃 諛뺤뒪 �④린湲�
			$('.ui-jqgrid-titlebar-close.HeaderButton').hide(); //湲곕낯 �묎린 踰꾪듉 �④린湲�

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
		    	$("#gbox_" + this.gridId ).width( width ); //gbox ( grid�꾩껜 媛먯떥怨좎엳�� div ) width 蹂�寃�
				//this.opt.grid.setGridWidth( width, false);
			}
		};

		/**
		 *	row ���됲듃 諛뺤뒪 珥덇린��
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
            	//寃��됱떆�먮뒗 �좏깉 媛�닔 諛붾�뚮�濡� �섏씠吏��ㅼ떆 留뚮벉 page�� 1濡�
            	_this.pageInit();

            	_this.jqGridOption.rowNum = obj.key;
            	_this.opt.grid.setGridParam({ rowNum:obj.key });
            	_this.opt.grid.trigger("reloadGrid");

            });
        };

        /**
		 *	寃��� 諛뺤뒪 珥덇린��
		 */
        this.searchBoxInit = function(){

            if( this.opt.searchBox == null ) return;

            var headArr = [];
            var count = 0;
            for( var i = 0; i< this.jqGridOption.colNames.length; i++ ){
            	if( this.jqGridOption.colModel[i].hidden != true && ( this.jqGridOption.colModel[i].searchable == null || this.jqGridOption.colModel[i].searchable ) ){
            		headArr.push( {value: this.jqGridOption.colNames[count], key : this.jqGridOption.colModel[i].index }); //colModel�� hidden�� �덉쑝誘�濡� count濡� indexing
            	}
            	if( this.jqGridOption.colModel[i].hidden != true ){
            		count++;
            	}
            }

            var _this = this;
            var searchBox = this.opt.searchBox.ifvSearchBox({ watermark : this.jqGridOption.searchInputWatermark });
            searchBox.setData( headArr, function( searchObj ){

            	//寃��됱떆�먮뒗 �좏깉 媛�닔 諛붾�뚮�濡� �섏씠吏��ㅼ떆 留뚮벉 page�� 1濡�
            	_this.pageInit();

				$.extend( _this.opt.postData, searchObj);
            	_this.opt.grid.setGridParam({ postData : _this.opt.postData });
            	_this.opt.grid.trigger("reloadGrid");

            });
        };

        /**
		 * postData �ㅻ쾭�쇱씠�쒗썑 �쒕퉬�� �붿껌
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
		 * �섏씠吏� �뗮똿 諛� 蹂���
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
		 * �좏깉 �뗮똿
		 */
		this.totalSetting = function( data ){
			if (!data.records) data.records = 0;
			var txt = this.jqGridOption.total.replace('{total}', data.records );
			this.opt.total.text( txt );
		};

        /*
         * �ъ슜�� �ㅼ젙 option �댁뿉 �⑥닔 �ㅼ젙
         */
		this.gridEventOverride = function(){
			this.jqGridOptionCopy = $.extend({}, this.jqGridOption );	//�ъ슜�� �ㅼ젙 option����

			var _this = this;
			//jqGrid�먯꽌 �섏뼱�ㅻ뒗 �⑥닔

			//�쒕쾭�� �곗씠�� 蹂대궡湲� �� requestData �뗮똿
			this.jqGridOption.serializeGridData = function( data ) {

				if( _this.opt.postData == null ){	//理쒖큹�먮쭔 init �곗씠�� �ㅻ쾭�쇱씠��
					_this.opt.postData = {};
					if( _this.jqGridOptionCopy.serializeGridData != null ){
						var userData = _this.jqGridOptionCopy.serializeGridData( data );//�ъ슜�� �뺤쓽 �⑥닔 �몄텧
						$.extend( _this.opt.postData, userData );
					};
				}
				var savePage = _this.opt.postData.page;

	        	$.extend( _this.opt.postData, data );

	        	_this.opt.postData.page = savePage; //page�� grid�� page踰덊샇瑜� �덉벐怨� pager�� page踰덊샇瑜쇱벖��( sort�� gqrid�뷀럹�댁�1濡� 諛붽씀吏�留� ifv�� �덈컮袁몃뒗寃껋씠 洹쒖튃)

	            return JSON.stringify(_this.opt.postData);
			};

			//resposeData �뗮똿
			this.jqGridOption.loadComplete = function( data ){

				/*if( _this.jqGridOption.radio == true ){
					_this.find('radio_' + this.gridId ).parent().width(40);
				}*/

				//if(  data.message != null && _this.opt.postData != null ) _this.opt.postData.lastItemId = data.message;	//�쒕쾭�먯꽌 lastItemId�� 以꾧꼍�곕쭔 �ㅼ떆 二쇨린�꾪빐 ����
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

				_this.pagerSetting( data );
				_this.totalSetting( data );
				_this.styleSetting();
				if(_this.jqGridOptionCopy.isRowspan) _this.rowspanSetting();

				//_this.setWidth( _this.width() );

				_this.makeEmptyRows();

				//�꾩튂 蹂�寃� 15.10.14 hj.seo
				if( _this.jqGridOptionCopy.loadComplete != null ){
					_this.jqGridOptionCopy.loadComplete( data );//�ъ슜�� �뺤쓽 �⑥닔 �몄텧
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
								_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, _this.opt.data.rows[i] ); //�ъ슜�� �뺤쓽 �⑥닔 �몄텧
								break;
							}
						}
					}else{
						_this.jqGridOptionCopy.onSelectCell.call( _this.jqGridOption.scope, _this.opt.data.rows[index-1] );   //�ъ슜�� �뺤쓽 �⑥닔 �몄텧
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
								_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, _this.opt.data.rows[i] );//�ъ슜�� �뺤쓽 �⑥닔 �몄텧
								break;
							}
						}
					}else{
						_this.jqGridOptionCopy.onSelectRow.call( _this.jqGridOption.scope, _this.opt.data.rows[index-1] );//�ъ슜�� �뺤쓽 �⑥닔 �몄텧
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
			if( this.jqGridOption.cellsubmit != null )	//editCell諛쒖깮�� selectCell�대깽�� 諛쒖깮�섎뒗 踰꾧렇 �뚮Ц�� 遺꾧린泥섎━
				this.opt.grid.editCell(0,0,false);	//edit以묒씤 cell�덉쑝硫� �リ린
			return this.opt.grid.getRowData();
		};

		this.getRowDatas = function(rowId) {
			var selrowId;
			if(typeof rowId != "undefined")
				selrowId = rowId;
			else
				selrowId =  this.opt.grid.jqJSONPGrid('getGridParam','selrow');
			var selrowData = this.opt.grid.jqJSONPGrid('getRowData', selrowId);
			return selrowData;
		}


		this.setRowDatas = function(data) {
			var selrowId =  this.opt.grid.jqJSONPGrid('getGridParam','selrow');
			this.opt.grid.jqJSONPGrid('setRowData', selrowId, data);
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
			if( this.jqGridOption.cellsubmit != null )	//editCell諛쒖깮�� selectCell�대깽�� 諛쒖깮�섎뒗 踰꾧렇 �뚮Ц�� 遺꾧린泥섎━
				this.opt.grid.editCell(0,0,false);	//edit以묒씤 cell�덉쑝硫� �リ린

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
			if( this.jqGridOption.cellsubmit != null )	//editCell諛쒖깮�� selectCell�대깽�� 諛쒖깮�섎뒗 踰꾧렇 �뚮Ц�� 遺꾧린泥섎━
				this.opt.grid.editCell(0,0,false);	//edit以묒씤 cell�덉쑝硫� �リ린

			var ids = this.getCheckedRowIds();
		     var length = ids.length;
		     for( var i = length-1; i>-1; i-- ){
		    	 this.opt.grid.delRowData( ids[i] );
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
			selectlist = this.opt.grid.jqJSONPGrid('getDataIDs');
			return selectlist;
		};

		this.removeAll = function(){
			this.opt.grid.jqJSONPGrid('clearGridData');
		};

		this.addLocalTr = function( obj ){
			this.emptyMsgDiv.hide();

			this.trNum++;
			var id = this.attr('id') + this.trNum;
			this.opt.grid.jqJSONPGrid('addRowData', id, obj || {} );

			this.cssSetting();

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
				this.opt.grid.jqJSONPGrid('setLabel', obj[i].colName, obj[i].newName, obj[i].styleType);
			}
		};

        /**
         * 湲곕낯 �듭뀡 �ㅼ젙, 由ы꽩func �ㅼ젙�� this.gridEventOverride�먯꽌
         */
		this.jqGridOption = {
			//ajaxGridOptions: { contentType: 'application/json', type: 'POST' },
			ajaxGridOptions: { contentType: 'application/json; charset=utf-8', type: 'GET' },
			mtype : 'GET',
	        crossDomain: true,
	       // ignoreCase: true,
			datatype: 'jsonp',
	        jsonReader: {
				repeatitems : false,
	            page: 'page',
	            total: 'total',
	            root: 'rows',
	            records : 'records',
	            id: 'colId'//瑗� �붾㈃ �꾩껜�먯꽌 寃뱀튂�� 媛믪씠 �낅뒗 column�� �ㅼ젙�� 寃� �덇렇�щ㈃ �먮윭 諛쒖깮
	        },
	        serializeCellData : function(obj){	//cell edit�� �곗씠�� json蹂���
				delete obj.oper;
				return JSON.stringify(obj);
			},
	        //datatype: "json",
	        colNames:[],
	        postData : {
	        	searchWord : '',
	        	searchText : '',
	        	page : 1 ,
	        	/* 20150511 理쒖씤�� language parameter 異붽�. */
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

		this.init();

		return this;
	};
})(jQuery);