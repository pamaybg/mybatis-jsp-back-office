package com.icignal.common.base.dto.request;

import net.sf.oval.constraint.Size;
import org.apache.commons.lang.StringUtils;

import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.DB_TYPE;
import com.icignal.common.util.SecurityUtil;
import com.icignal.common.util.StringUtil;

import java.text.SimpleDateFormat;

import static com.icignal.common.util.StringUtil.getStrWhereValueEncoded;


/**
 * 그리드 페이징 요청 클래스
 *
 * @author jskim
 *
 */
public class GridPagingReqDto extends PagingReqDto{
	private boolean search;
	private long     nd;
	private int      rows;

	@Size(min = 1)
	private int      page;
	private String   sidx;
	private String   sord;

	private String searchWord;
	private String searchType;

	private String gridType;

	// 암호화 필드 검색 여부
	private boolean encColFlag;
	private String encKey;
	private String encFnName;

	private String strWhere;
	private String strColumn;
	private String strOrderby;
	private String strStartPaging;
	private String strEndPaging;
	private String strRownumDecod; //mj.kim
	

	public GridPagingReqDto init(DB_TYPE dbType) {
		init();
		return this;
	}
	public void init() {
		// this.setStrStartPaging("SELECT * FROM (");

		if (this.rows == 0) {
			this.setRows(10);
		}

		String column = "";
		if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.ORACLE)) {
			column += " CEIL(COUNT(1) OVER()) totalCount";
		} else if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)){
			column += " CEILING(COUNT(1) OVER()) totalCount";
		}
		this.setStrColumn(column);

		if ( StringUtils.isNotBlank(this.getStrSVCType()) && this.getSidx() != null && this.getSidx().length() > 0) {
			if( sidx.indexOf('.') != -1 )
			super.setSVCAlias(this.sidx.substring(0, sidx.indexOf('.')));

			this.setStrOrderby(this.getSidx() + " " + this.getSord());
		}

		String where = "1=1";

		if (this.getSearchWord() != null && this.getSearchWord().length() > 0 && this.getSearchText() != null && this.getSearchText().length() > 0){
			where += parseSearchCond(this.getSearchWord() , this.getSearchText());
		}
		
		this.setStrWhere(where);

		if ("EXCEL".equals(this.getGridType())) {
			this.setStrEndPaging("");
		} else if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MYSQL)) {
			this.setStrEndPaging("limit " + this.getSkipCount() + ", " + this.getPageSize());
		}
		else{
			this.setStrEndPaging("offset " + this.getSkipCount() + " rows fetch next " + this.getPageSize() + " rows only");
		}
		//포인트 소멸 예정자 조회 페이징 처리
		//속도 향상을 위한  처리...
		if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MYSQL)) {
			this.setStrRownumDecod("limit " + this.getSkipCount() + ", " + this.getPageSize());
		} else {
			this.setStrRownumDecod("DECODE("+this.getSkipCount()+",0,1,"+this.getSkipCount()+"+1) AS START_SEQ_NO ,"+this.getSkipCount()+"+"+this.getPageSize()+" AS END_SEQ_NO");
		}
	}

	private String parseSearchCond(String searchWord, String searchText) {
		String searchCond = "";
		String parsedSearchText = StringUtil.camelToSnakeCase(searchText);
		//SQL INJECTION 검사로 주석(') 맨앞에오면 없애게 수정 hr.noh 2022.04.07
		String parsedSearchWord = searchWord.replace("'", "\\").replace("\\'", "\\\\");

		if (this.getEncColFlag()) {
			String dataKey = BeansUtil.getDbEncryptDataKey();
			String data = SecurityUtil.encodeDbAES256(dataKey, parsedSearchWord);
			searchCond += " AND " + parsedSearchText + " = " +  "'"	+ data + "'";
		} else {

			boolean checkDate = false;
			SimpleDateFormat dateFormatCheckParse;
			if(parsedSearchWord.indexOf("-") > -1) {
				try {
					dateFormatCheckParse = new SimpleDateFormat("yyyy-MM-dd");
					dateFormatCheckParse.setLenient(false);
					dateFormatCheckParse.parse(parsedSearchWord);
					checkDate = true;
				} catch (Exception e) {
					checkDate = false;
				}
			} else {
				try {
					dateFormatCheckParse = new SimpleDateFormat("yyyyMMdd");
					dateFormatCheckParse.setLenient(false);
					dateFormatCheckParse.parse(parsedSearchWord);
					checkDate = true;
				} catch (Exception e) {
					checkDate = false;
				}
			}

			if(checkDate){
				if(CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
					searchCond = " AND convert(date," + parsedSearchText + ") = convert(date,'" + parsedSearchWord + "')";
				} else {
					searchCond = " AND INSTR(" + parsedSearchText + ", '" + parsedSearchWord + "') > 0";
				}
			} else {
				if(CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL)) {
					searchCond = " AND convert(nvarchar," + parsedSearchText + ") like N'%" + parsedSearchWord + "%'";
				}else{
					searchCond = " AND INSTR(" + parsedSearchText + ", '" + parsedSearchWord + "') > 0";
				}
			}

		}

		return searchCond;
	}


	public boolean isSearch() {
		return search;
	}
	public void setSearch(boolean search) {
		this.search = search;
	}
	public long getNd() {
		return nd;
	}
	public void setNd(long nd) {
		this.nd = nd;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;

		this.setInitSize(this.rows);
		this.setPageSize(this.rows);

		//모바일에서 page를 먼저 바인딩 할 경우를 위한 처리
		if(this.page != 0){
			this.setPage(this.page);
		}
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;

		this.setPageNum(this.page - 1);
		if(this.page == 1) {
			this.setInitSize(0);
		}
	}
	public String getSidx() {
		return sidx;
	}
	public void setSidx(String sidx) {
		this.sidx = sidx;
	}
	public String getSord() {
		return sord;
	}
	public void setSord(String sord) {
		this.sord = sord;
	}
	public GridPagingReqDto() {
		super();
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public boolean isEncColFlag() {
		return encColFlag;
	}

	public String getStrWhere() {
		//System.out.println(" getStrWhere()~~~~~~~~~~~~~~: " + strWhere);
		return strWhere;
	}

	public void setStrWhere(String strWhere) {
		this.strWhere = strWhere;
	}

	public String getStrColumn() {
		return strColumn;
	}

	public void setStrColumn(String strColumn) {
		this.strColumn = strColumn;
	}

	public String getStrOrderby() {
		return strOrderby;
	}

	public void setStrOrderby(String strOrderby) {
		this.strOrderby = strOrderby;
	}

	public String getStrStartPaging() {
		return strStartPaging;
	}

	public void setStrStartPaging(String strStartPaging) {
		this.strStartPaging = strStartPaging;
	}

	public String getStrEndPaging() {
		return strEndPaging;
	}

	public void setStrEndPaging(String strEndPaging) {
		this.strEndPaging = strEndPaging;
	}
	@Override
	public String toString() {
		return "GridRequestDTO [search=" + search + ", nd=" + nd + ", rows=" + rows + ", page=" + page + ", sidx=" + sidx + ", sord=" + sord + ", searchWord=" + searchWord + ", searchType=" + searchType + ", strWhere=" + strWhere + ", strColumn=" + strColumn + ", strOrderby=" + strOrderby + ", strStartPaging=" + strStartPaging + ", strEndPaging=" + strEndPaging + "]";
	}

	public String getEncKey() {
		return encKey;
	}

	public void setEncKey(String encKey) {
		this.encKey = encKey;
	}

	public String getEncFnName() {
		return encFnName;
	}

	public void setEncFnName(String encFnName) {
		this.encFnName = encFnName;
	}

	public boolean getEncColFlag() {
		return encColFlag;
	}

	public void setEncColFlag(boolean encColFlag) {
		this.encColFlag = encColFlag;
	}
	///// mj.kim 추가//////
	public String getStrRownumDecod() {
		return strRownumDecod;
	}
	public void setStrRownumDecod(String strRownumDecod) {
		this.strRownumDecod = strRownumDecod;
	}
	//////////////////////
	public String getGridType() {
		return gridType;
	}
	public void setGridType(String gridType) {
		this.gridType = gridType;
	}

}


