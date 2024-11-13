
(function ($) {
   /**
    *
    * @class ifvsfGrid
    *
    */
   $.fn.ifvsfGrid = function (options) {
      
       this.opt = {
           searchBox: null,
           rowsBox: null,
           grid: null,
           gridPage: null,
           page: null,
           pager: null,
           data: null,
           gridId: null,
           postData: null
       };

       /*
      * ejGrid 초기화
      */
       this._init = function () {
           /*
            * 기본 옵션 설정
            */
           var _this = this;
           this.opt.ejGridOption = {
              title: '',
              dataUrl: '',
              datatype: 'remote',
               tableType: 'normal',
               allowResizing: true,
               //commonWidth: 80,
               enableTouch: false,
               allowScrolling: false,
               allowTextWrap: true,
               isVerticalScroll: false,
               textWrapSettings: {wrapMode: "both"},
               isResponsive: true,
               allowSorting: false,
               columns: [],
               requestGridData : {
                nd   : new Date().getTime(),
                rows : 10,
                sidx : '',
                sord : 'desc',
                _search : false
               },
               tempId : "ifvGridOriginTemplete",
               rowNum: 10,
               rowList : [10, 25, 50, 100],
               emptyMsg : ifv.commonMessage.noData,
               total: ifv.commonMessage.total + ' : {total}' + ifv.commonMessage.gun,
              dataBound: function(args) {
                     if(_this.opt.ejGridOption.datatype == 'remote') {
                         var _thisId = this._id;
                       $('#' + _thisId + ' .e-gridheader').on('click', '.e-headercelldiv', function(args) {
                          var headerText = args.target.innerHTML,
                               gridObj = $('#' + _thisId).ejGrid('instance'),
                               length = gridObj.model.columns.length, columnData;
  
                          for (var i = 0; i < length; i++) {
                            if (gridObj.model.columns[i]['headerText'] == headerText) {
                               columnData = gridObj.getColumnByIndex(i);
                               _this._sortingData(columnData);
                            }
                          }
                      });
                     }
  
                     if(_this.opt.ejGridOption.isHorizontalScroll) {
                        var hasFooter = false;
                        _this.find("[gridId=grid]").addClass('horizontal_scroll_grid');
                        _this.find("[gridId=grid]").removeClass('has_footer');
  
                        if(_this.opt.ejGridOption.showSummary && args.model.dataSource != null && args.model.dataSource.length != 0) {
                           _this.find("[gridId=grid]").addClass('has_footer');
                           hasFooter = true;
                        }
  
                        if(hasFooter) {
                           _this.find("[gridId=grid] .e-gridfooter").scrollLeft(0);
                           _this.find("[gridId=grid] .e-gridfooter").off().on('scroll', function(e) {
                               $(this).siblings('.e-gridheader').children('div').scrollLeft(e.srcElement.scrollLeft);
                               $(this).siblings('.e-gridcontent').children('div').scrollLeft(e.srcElement.scrollLeft);
                            });
                        } else {
                           _this.find("[gridId=grid] .e-gridcontent > div").scrollLeft(0);
                           _this.find("[gridId=grid] .e-gridcontent > div").off().on('scroll', function(e) {
                               $(this).parent().siblings('.e-gridheader').children('div').scrollLeft(e.srcElement.scrollLeft);
                            });
                        }
                     }
              },
               radio: false,
               gridDataInit: true
           };
                                   
           $.extend(true, this.opt.ejGridOption, options.ejGridOption);

           this.gridId = "gridId" + this.attr('id');

           if(this.opt.ejGridOption.datatype == 'clientSide' && this.opt.ejGridOption.tableType == 'offer') {
              var lst = [];
              var rmv = [];
              this.opt.ejGridOption.dataSource.forEach(function(item, index) {
                 if (typeof item.dataStatus != 'undefined' && item.dataStatus == 'D') {
                    rmv.push(item);
                 } else {
                    lst.push(item);
                 }
              });

              this.opt.ejGridOption.dataSource = lst;
              this.opt.ejGridOption.removeData = rmv;
           }

           if(this.opt.ejGridOption.datatype == 'clientSide') {
              var pageSettings = {};
              pageSettings.page = 1;
              pageSettings.pageSize = this.opt.ejGridOption.rowList[0];
              pageSettings.pageCount = 10;

              this.opt.ejGridOption.pageSettings = pageSettings;
              this.opt.ejGridOption.allowPaging = true;
           }

           this._setColumnDefault();
           this._setPostData();
           this._optionSetting();
           this._uiSetting();
           this._makeGrid();
           this._titleInit();
           this._rowBoxInit();
           this._searchBoxInit();
           if(this.opt.ejGridOption.datatype == 'remote' && (this.opt.ejGridOption.gridDataInit || localStorage.getItem(this.attr('id') + "_PagerObj"))) this._doAjax();
           if(this.opt.ejGridOption.datatype == 'clientSide' && (this.opt.ejGridOption.gridDataInit || localStorage.getItem(this.attr('id') + "_PagerObj"))) this._setGridData();

       };
       
       /*
        * Column 디폴트 설정
        */
       this._setColumnDefault = function() {
          
          // 디폴트 Column 클래스
          var Column = function(c) {
             this.headerTextAlign = 'center',
             this.customAttributes = {
               sortable : true,
                   searchable : false,
             }
          }
          
          var columns = this.opt.ejGridOption.columns;
          
          this.opt.ejGridOption.columns = columns.map(function(c) {
             var column = new Column();
             // column과 머지함
             $.extend(true, column, c);
             column.customAttributes.index = (column.customAttributes && column.customAttributes.index)? column.customAttributes.index : column.field;
             return column;
          });

       };

         /*
          * ui 탬플릿 읽어들여서 컴퍼넌트 태그로 변환
          */
       this._uiSetting = function () {
           var con = $("#" + this.opt.ejGridOption.tempId).html();

           con = con.replace('{searchBox}', '<div class="search_box" gridId="searchBox" ></div>');
           con = con.replace('{rowsBox}', '<input class="combo_num_box" gridId="rowsBox" />');
           con = con.replace('{grid}', '<div class="responsive_grid" gridId="grid" id="' + this.gridId + '"></div>');
           con = con.replace('{gridPage}', '<div gridId="gridPage" id="gridPage" ></div>');
           con = con.replace('{page}', '<div gridId="page" ></div>');
           con = con.replace('{total}', '<div gridId="total" ></div>');
           con = con.replace('{btnAdd}', '<input type="button" class="btnAdd" gridId="btnAdd" value="등록"/>');
           con = con.replace('{btnDelete}', '<input type="button" class="btnDelete" gridId="btnDelete" value="삭제"/>');
           con = con.replace('{title}', '<div gridId="title" class="title"/>');
           con = con.replace('{excelDown}', '<button gridId="excelDown" class="btn btn-sm btn-imgonly"><i class="fa fa-search"></i></button>');

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

       /*
        * ajax통신 시 requestData 생성
        */
       this._setPostData = function () {
          var postData = {
               searchWord: '',
               searchText: '',
               page: 1,
               rows: this.opt.ejGridOption.rowList[0],
               appServiceId: window.appServiceId,
               country: window.country,
               lang: window.lang,
              nd : new Date().getTime(),
              _search: false
           };

           if (this.opt.ejGridOption.requestGridData)
               $.extend(postData, this.opt.ejGridOption.requestGridData);

           if (this.opt.ejGridOption.serializeGridData)
              postData = $.extend(postData, this.opt.ejGridOption.serializeGridData(postData));

           if (this.opt.ejGridOption.datatype == "clientSide")
              postData.records = postData.total = this.opt.ejGridOption.dataSource.length;

           if(localStorage.getItem(this.attr('id')+'_PagerObj')) {
              var pagerObj = JSON.parse(localStorage.getItem(this.attr('id')+'_PagerObj'));
              postData = $.extend(postData, pagerObj);
              this.opt.ejGridOption.rowNum = pagerObj.rows;
           }

           this.opt.postData = postData;
       };


       /*
        * 외부 검색함수
        */

       this.searchGrid = function(data) {
          $.extend(this.opt.postData, data);
         this.opt.ejGridOption.rowNum = this.opt.ejGridOption.rowList[0];
         this.rowSelectBox && this.rowSelectBox.setValue(this.opt.ejGridOption.rowList[0]);
         this.opt.postData.rows = this.opt.ejGridOption.rowList[0];
         this.opt.postData.page = 1;
         localStorage.setItem(this.attr('id')+'_PagerObj', JSON.stringify({page:1, rows:this.opt.ejGridOption.rowNum}));
          this._getData();
       }
       
       /*
        * 공통 조회조건 아닌 데이터들 조회
        */
       this.searchGrid2 = function(data) {
           $.extend(this.opt.postData, data);
           this._getData();
        }

       /*
        * Grid Data 가져오기
        */
       this._getData = function () {
          if(this.opt.ejGridOption.datatype == 'clientSide')
             this._setGridData();
          else
             this._doAjax();
       }

       /*
        * ClientSide Data Setting
        */
       this._setGridData = function() {
          this.opt.gridControl.dataSource(this.opt.ejGridOption.dataSource);
          this.opt.gridControl.gotoPage(this.opt.postData.page);

           this._pagerSetting(this.opt.postData);
           this._totalSetting(this.opt.postData);

          if(this.opt.ejGridOption.loadComplete) this.opt.ejGridOption.loadComplete(this.opt.gridControl);
       }

       /*
        * Ajax 통신
        */
       this._doAjax = function() {
           var _this = this;
           if(!this.opt.ejGridOption.gridDataInit && (!this.opt.postData.item || !this.opt.postData.item.length)) {
              return false;
           }
           $.ajax({
               url: this.opt.ejGridOption.dataUrl,
               datatype: 'json',
               type: 'POST',
               contentType: 'application/json; charset=utf-8',
               data: JSON.stringify(this.opt.postData),
               beforeSend: function () {
                   $('body').append($('<div>').addClass('loading').text(MESSAGE.common.progressTxt || '조회중'));
               },
               success: function (resultData) {
                 if ($.errorChecker(resultData)) {
                       _this.opt.gridControl.dataSource(resultData.rows);

                       $.extend(_this.opt.gridControl.model.requestGridData, _this.opt.postData);
                       _this.opt.gridControl.model.requestGridData.records = resultData.records;

                       _this._pagerSetting(resultData);
                       _this._totalSetting(resultData);

                       _this.find('.emptyrecord').text(_this.opt.ejGridOption.emptyMsg); // 빈데이터 그리드일 때 텍스트 수정

                      if(_this.opt.ejGridOption.loadComplete) _this.opt.ejGridOption.loadComplete(_this.opt.gridControl, resultData);
                  } else {
                     _this.opt.gridControl.dataSource([]);
                  }
               },
               error: function (xhr, status, error) {
                  _this.opt.gridControl.dataSource([]);
               },
               complete: function () {
                   $('.loading').remove();
                   _this.opt.grid.find('.e-headercell .e-headercelldiv').addClass('sort_type');

                   var columns = _this.opt.ejGridOption.columns;
                   var column = {};

                   for(var i = 0; i < columns.length; i++) {   
                     column = columns[i];
                     customAttributes = column.customAttributes;

                     if(column.type != 'checkbox' && column.type != 'radio' && customAttributes.index === _this.opt.postData.sidx) {
                        _this.opt.grid.find('.e-headercell[title="' + column['headerText'] + '"] .e-headercelldiv').addClass(_this.opt.postData.sord);
                     }
                  }
               }
           });
       };

       /*
        * header sorting
        */
     this._sortingData = function (cItem) {
         if(!cItem.customAttributes.sortable) {
            this.opt.grid.find('.e-headercell[title="' + cItem.headerText + '"] .e-headercelldiv').css({cursor:'default'});
            return;
         }

        this.opt.postData.sidx = cItem.customAttributes.index;

        this.opt.postData.sord = this.opt.postData.sord === 'desc' ? 'asc' : 'desc';

        this._getData();
     }

       /*
        * ejGrid 생성
        */
       this._makeGrid = function () {
          this.opt.ejGridOption.gridId = this.attr('id');
          if(this.opt.ejGridOption.isFixedGrid) this.find("[gridId=grid]").removeClass('responsive_grid');
           this.opt.grid = this.find("[gridId=grid]").ejGrid(this.opt.ejGridOption);
           this.opt.gridControl = this.opt.grid.data('ejGrid');
           this.find('.emptyrecord').text(this.opt.ejGridOption.emptyMsg); // 빈데이터 그리드일 때 텍스트 수정
       };

       this._optionSetting = function () {
           if (this.opt.ejGridOption.radio) this._setRadio();
       };

       /*
        * radio 셋팅
        */
       this._setRadio = function () {
           var _this = this;

           var radioColumn = {
               headerText: '선택',
               type: "radio",
               template: '<input type="radio" name="radio_' + this.gridId + '" />',
               width: 40,
               headerTextAlign: 'center',
               textAlign: 'center',
               customAttributes: {
                  searchable: false,
                  sortable: false
               }
           };
           if(this.opt.ejGridOption.columns[0].type!="radio") {
              this.opt.ejGridOption.columns.unshift(radioColumn);
           }
           this.opt.ejGridOption.rowSelecting = function (args) {
               $('input[name=radio_' + _this.gridId).eq(args.rowIndex).prop('checked', true);
           };
       };

       /*
      *   title 초기화
      */
       this._titleInit = function() {
          this.opt.ejGridOption.title ? this.opt.title.html(this.opt.ejGridOption.title) : this.opt.title.remove();
       }

     /*
     *   row 셀렉트 박스 초기화
     */
       this._rowBoxInit = function(){
           if(!this.opt.rowsBox.length) return;

           var arr = [];
           for( var i = 0; i < this.opt.ejGridOption.rowList.length; i++ ){
              var obj = { key : this.opt.ejGridOption.rowList[i], value : this.opt.ejGridOption.rowList[i], };
              if( i == 0 ) obj.selected = true;
              arr.push( obj );
           }

           this.rowSelectBox = this.opt.rowsBox.ifvSelectBox();
           var _this = this;
           this.rowSelectBox.setData(arr, function(obj){
              _this._pageInit();
              _this.opt.ejGridOption.rowNum = obj.key;
              _this.opt.postData.rows = _this.opt.ejGridOption.rowNum;
              if(_this.opt.ejGridOption.datatype == "clientSide") {
                 _this.opt.gridControl._setModel({"pageSettings" : {"pageSize" : _this.opt.postData.rows}});
              }

           var pagerObj = {
              page: _this.opt.page.currentNum
              , rows: _this.opt.ejGridOption.rowNum
           }

           localStorage.setItem(_this.attr('id')+'_PagerObj', JSON.stringify(pagerObj));

               _this._getData();
           });

           if(localStorage.getItem(this.attr('id')+'_PagerObj')) {
              var pagerObj = JSON.parse(localStorage.getItem(this.attr('id')+'_PagerObj'));
              this.rowSelectBox.setValue(pagerObj.rows);
           }
       };

       /*
      *   검색 박스 초기화
      */
       this._searchBoxInit = function(){
           if(!this.opt.searchBox.length) return;

           var headArr = [];
           for( var i = 0; i< this.opt.ejGridOption.columns.length; i++ ){
              var column = this.opt.ejGridOption.columns[i];
              if( column.visible != false && column.type != 'checkbox' && column.type != 'radio' && column.customAttributes.searchable){
                 headArr.push( {value: this.opt.ejGridOption.columns[i].headerText, key : this.opt.ejGridOption.columns[i].customAttributes.index, key2 : this.opt.ejGridOption.columns[i].customAttributes.encColFlag}); //colModel은 hidden이 있으므로 count로 indexing
              }
           }

           var _this = this;
           var searchBox = this.opt.searchBox.ifvSearchBox();
           searchBox.setData( headArr, function( searchObj ){
              //검색시에는 토탈 갯수 바뀌므로 페이지다시 만듬 page도 1로
              _this._pageInit();
           $.extend( _this.opt.postData, searchObj);
           _this._getData();
           });
       };

       /*
        * 페이지 초기화
        */
       this._pageInit = function () {
           if (this.opt.pager != null) {
               this.opt.pager.empty();
               this.opt.pager = null;
               this.opt.postData.page = 1;
           }
       };

       /*
      * 페이지 셋팅 및 변환
      */
       this._pagerSetting = function (data) {
           if (this.opt.pager == null) {
               var _this = this;
               this.opt.pager = this.opt.page.ifvSimplePager({
                   dataObj: {rows: _this.opt.ejGridOption.rowNum},
                   callback: function (page) {
                       var pagerObj = {
                          page : page
                          , rows: _this.opt.ejGridOption.rowNum
                       }
                       localStorage.setItem(_this.attr('id')+'_PagerObj', JSON.stringify(pagerObj));
                       _this.opt.postData.page = page;
                       _this._getData();
                   }
               });
           }

           var pagerObj = {
              page : this.opt.page.currentNum
              , rows: this.opt.ejGridOption.rowNum
           }
           localStorage.setItem(this.attr('id')+'_PagerObj', JSON.stringify(pagerObj));
           this.opt.pager.change(data);
       };

       /*
        * 토탈 셋팅
        */
       this._totalSetting = function (data) {
          if(!data.records) data.records = 0;
           this.opt.total.text(this.opt.ejGridOption.total.replace('{total}', $.fn.ifvmNumberWithCommas(data.records) ));
           this.opt.data = data;
       };

       this._init();
       return this;
   }
})(jQuery);