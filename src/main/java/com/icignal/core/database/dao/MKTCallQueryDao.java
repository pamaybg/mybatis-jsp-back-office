package com.icignal.core.database.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.icignal.core.exception.DataSQLNonPopException;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.icignal.common.base.dto.request.GridPagingReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.ErrorHelper;
import com.icignal.common.util.CommonUtil.DB_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.LoggableStatementUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.core.database.dto.request.MKTDBQueryDTO;
import com.icignal.core.exception.DataFailException;
import com.icignal.core.exception.DataSQLException;

@Component
@Repository
public class MKTCallQueryDao {

	@Autowired
	StandardPBEStringEncryptor encrypor;

	/**
	 * @name : callSelectObject
	 * @date : 2016. 3. 16.
	 * @author : 류동균
	 * @description : SELECT SQL문 수행
	 * @return : Object
	 */
	@SuppressWarnings({ "resource", "unchecked", "rawtypes" })
	public Object callSelectObject(String page_info, String selectContent, List inParams, MKTDBInfoDTO dbInfo, Object objClass) {
		LogUtil.param(MKTCallQueryDao.class, page_info);
		
		Hashtable hashRow = new Hashtable();
		String query = "";
		String err_message = "";
		int rsCnt = 0;
		long startTime = System.currentTimeMillis();

		MKTDBQueryDTO BeanDB = new MKTDBQueryDTO();
		Connection conn = BeanDB.getConnection(dbInfo);
		PreparedStatement prepareStmt = null;
		ResultSet rs = null;

		try {
			if (conn != null) {
				prepareStmt = new LoggableStatementUtil(conn, selectContent);
				
				prepareStmt = setPrepareStmtInParams(prepareStmt, inParams);

				query = ((LoggableStatementUtil) prepareStmt).getQueryString();
				LogUtil.debug("[SQL Log : " + page_info + "] " + query);
				rs = prepareStmt.executeQuery();

				while (rs.next()) {
					int columnCount = rs.getMetaData().getColumnCount();
					for (int i = 1; i <= columnCount; i++) {
						hashRow.put(rs.getMetaData().getColumnLabel(i), StringUtil.convertNull(rs.getString(i), "").trim());
					}

					rsCnt++;
				}

				// row가 1개 이상일경우 exception 처리
				if (rsCnt > 1) {
					err_message = "return too many results";
					LogUtil.error(err_message);
					throw new DataSQLException();
				}

			} else {
				err_message = "DB Connection Error";
				LogUtil.error(err_message);
				throw new DataSQLException();
			}
		} catch (SQLException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLNonPopException();
		} catch (DataAccessException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		} catch (DataFailException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (prepareStmt != null)
					prepareStmt.close();
				if (conn != null)
					conn.close();
				BeanDB.close();

				LogUtil.debug("[SQL query time : " + page_info + "] " + (System.currentTimeMillis() - startTime) / 1000.0f);

			} catch (SQLException e) {
				LogUtil.error(e.getMessage(), e);
				
			} 
		}
		
		Object tempObjClass = objClass;
		tempObjClass = ObjectUtil.convertMapToObject(hashRow, (Class) objClass);

		if (tempObjClass == null) {
			err_message = "check response Class";
			LogUtil.error(err_message);
			throw new DataFailException();
		}

		return tempObjClass;
	}

	/**
	 * @name : callSelectForGridList
	 * @date : 2016. 7. 11.
	 * @author : 류동균
	 * @description : Select Grid List SQL문 수행
	 * @return : GridPagingResDto<Object>
	 */
	@SuppressWarnings({ "unchecked", "resource", "rawtypes", "unused" })
	public GridPagingResDto<Object> callSelectForGridList(String page_info, String selectContent, List inParams, MKTDBInfoDTO dbInfo, Object obj) {
		LogUtil.param(MKTCallQueryDao.class, page_info);
		String query = "";
		String err_message = "";
		String rsTotalCount = "";
		List rsList = new ArrayList();
		String sqlQuery = "";
		String dbType = dbInfo.getConDbType();

		MKTDBQueryDTO BeanDB = new MKTDBQueryDTO();
		Connection conn = BeanDB.getConnection(dbInfo);
		PreparedStatement prepareStmt = null;
		ResultSet rs = null;

		try {
			if (conn != null) {
				// 페이징 쿼리 설정
				sqlQuery = selectQueryPageing(selectContent, obj, dbType);

				prepareStmt = new LoggableStatementUtil(conn, sqlQuery);
				prepareStmt = setPrepareStmtInParams(prepareStmt, inParams);

				query = ((LoggableStatementUtil) prepareStmt).getQueryString();
				LogUtil.debug("[SQL Log : " + page_info + "] " + query);
				rs = prepareStmt.executeQuery();

				while (rs.next()) {
					Hashtable hashRow = new Hashtable();
					int columnCount = rs.getMetaData().getColumnCount();
					for (int i = 1; i <= columnCount; i++) {
						hashRow.put(rs.getMetaData().getColumnLabel(i), StringUtil.convertNull(rs.getString(i), "").trim());
					}

					rsList.add(hashRow);
				}

				if ("MYSQL".equals(dbType)) {
					String countQuery = "select FOUND_ROWS() as count";
					prepareStmt = new LoggableStatementUtil(conn, countQuery);
					rs = prepareStmt.executeQuery();

					while (rs.next()) {
						rsTotalCount = StringUtil.convertNull(rs.getString(1), "").trim();
					}
				}
			} else {
				err_message = "DB Connection Error";
				LogUtil.error(err_message);
				throw new DataSQLException();
			}
		} catch (DataAccessException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		} catch (SQLException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (prepareStmt != null)
					prepareStmt.close();
				if (conn != null)
					conn.close();
				BeanDB.close();
			} catch (SQLException e) {
				LogUtil.error(e.getMessage(), e);
				
			} 
		}

		// null 확인
		if (rsList == null) {
			LogUtil.error("results is null");
			throw new DataFailException(ErrorHelper.MSG_1001);

		}

		// 그리드 설정
		GridPagingResDto<Object> rtnValue = new GridPagingResDto<Object>();
		try {
			if (rsList.size() > 0) {
				int page = 0;
				int totalCount = 0;
				int pageCount = 1;

				if ("ORACLE".equals(dbType) || "POSTGRESQL".equals(dbType)||"MEMSQL".equals(dbType)) {
					page = 0;
					totalCount = 0;
					pageCount = 1;
					Hashtable tmp = (Hashtable) rsList.get(0);

					page = Integer.parseInt(tmp.get("pageNum").toString());
					pageCount = Integer.parseInt(tmp.get("totalPage").toString());
					totalCount = Integer.parseInt(tmp.get("totalCount").toString());
				} else if ("MSSQL".equals(dbType)){
					((GridPagingReqDto) obj).init(DB_TYPE.MSSQL);
					GridPagingReqDto parseParam = (GridPagingReqDto) obj;
					page = parseParam.getPage();
					totalCount = 0;
					pageCount = 1;

					Hashtable tmp = (Hashtable) rsList.get(0);
					pageCount = Integer.parseInt(tmp.get("totalPage").toString());
					totalCount = Integer.parseInt(tmp.get("totalCount").toString());

				} else {
					((GridPagingReqDto) obj).init(DB_TYPE.MYSQL);
					GridPagingReqDto parseParam = (GridPagingReqDto) obj;
					page = parseParam.getPage();
					totalCount = 0;
					pageCount = 1;

					String totalCountStr = rsTotalCount;
					if (!"".equals(totalCountStr)) {
						totalCount = Integer.parseInt(totalCountStr);
					}

					if (parseParam.getRows() != 0) {
						if (totalCount % parseParam.getRows() == 0) {
							pageCount = totalCount / parseParam.getRows();
						} else {
							pageCount = totalCount / parseParam.getRows() + 1;
						}
					}
				}

				rtnValue.setSuccess(true);
				rtnValue.setRows(rsList);
				rtnValue.setRecords(totalCount);
				rtnValue.setPage(page);
				rtnValue.setTotal(pageCount);
			}
		} catch (Exception e) {
			LogUtil.error(e.getMessage(),e);
			throw new DataSQLException();
		}

		return rtnValue;
	}

	/**
	 * @name : callSelectForList
	 * @date : 2016. 7. 11.
	 * @author : 류동균
	 * @description : Select List SQL문 수행
	 * @return : List
	 */
	@SuppressWarnings({ "unchecked", "resource", "rawtypes" })
	
	public List callSelectForList(String page_info, String selectContent, List inParams, MKTDBInfoDTO dbInfo, Object objClass) {
		LogUtil.param(MKTCallQueryDao.class, page_info);

		String query = "";
		String err_message = "";
		List rsList = new ArrayList();

		MKTDBQueryDTO BeanDB = new MKTDBQueryDTO();
		Connection conn = BeanDB.getConnection(dbInfo);
		PreparedStatement prepareStmt = null;
		ResultSet rs = null;

		try {
			if (conn != null) {
				prepareStmt = new LoggableStatementUtil(conn, selectContent);
				prepareStmt = setPrepareStmtInParams(prepareStmt, inParams);

				query = ((LoggableStatementUtil) prepareStmt).getQueryString();
				LogUtil.debug("[SQL Log : " + page_info + "] " + query);
				rs = prepareStmt.executeQuery();

				while (rs.next()) {
					Hashtable hashRow = new Hashtable();
					int columnCount = rs.getMetaData().getColumnCount();
					for (int i = 1; i <= columnCount; i++) {
						hashRow.put(rs.getMetaData().getColumnLabel(i), StringUtil.convertNull(rs.getString(i), "").trim());
					}

					Object conObj = ObjectUtil.convertMapToObject(hashRow, (Class) objClass);

					if (conObj != null) {
						rsList.add(conObj);
					} else {
						err_message = "check response Class";
						LogUtil.error(err_message);
						throw new DataFailException();
					}
				}
			} else {
				err_message = "DB Connection Error";
				LogUtil.error(err_message);
				throw new DataSQLException();
			}
		} catch (DataAccessException e) {
			LogUtil.error(e.getMessage(),e);
			throw new DataSQLException();
		} catch (SQLException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (prepareStmt != null)
					prepareStmt.close();
				if (conn != null)
					conn.close();
				BeanDB.close();
			} catch (SQLException e) {
				LogUtil.error(e.getMessage(), e);
				
			} 
		}

		return rsList;
	}

	/**
	 * @name : callSelectForListMap
	 * @date : 2016. 7. 11.
	 * @author : 류동균
	 * @description : Select List SQL문 수행
	 * @return : List Map
	 */
	@SuppressWarnings({ "rawtypes", "resource", "unchecked" })
	
	public List callSelectForListMap(String page_info, String selectContent, List inParams, MKTDBInfoDTO dbInfo) {
		LogUtil.param(MKTCallQueryDao.class, page_info);

		String query = "";
		String err_message = "";
		List rsList = new ArrayList();

		MKTDBQueryDTO BeanDB = new MKTDBQueryDTO();
		Connection conn = BeanDB.getConnection(dbInfo);
		PreparedStatement prepareStmt = null;
		ResultSet rs = null;

		try {
			if (conn != null) {
				prepareStmt = new LoggableStatementUtil(conn, selectContent);
				prepareStmt = setPrepareStmtInParams(prepareStmt, inParams);

				query = ((LoggableStatementUtil) prepareStmt).getQueryString();
				LogUtil.debug("[SQL Log : " + page_info + "] " + query);
				rs = prepareStmt.executeQuery();

				while (rs.next()) {
					Map<String, String> hashRow = new LinkedHashMap<String, String>();
					int columnCount = rs.getMetaData().getColumnCount();
					for (int i = 1; i <= columnCount; i++) {
						hashRow.put(rs.getMetaData().getColumnLabel(i), StringUtil.convertNull(rs.getString(i), "").trim());
					}

					rsList.add(hashRow);
				}

			} else {
				err_message = "DB Connection Error";
				LogUtil.error(err_message);
				throw new DataSQLException();
			}
		} catch (DataAccessException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		} catch (SQLException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (prepareStmt != null)
					prepareStmt.close();
				if (conn != null)
					conn.close();
				BeanDB.close();
			} catch (SQLException e) {
				LogUtil.error(e.getMessage(), e);
				
			} 
		}

		return rsList;
	}

	/**
	 * @name : callSelectForMap
	 * @date : 2016. 7. 11.
	 * @author : 류동균
	 * @description : Select SQL문 수행
	 * @return : Map
	 */
	@SuppressWarnings({ "rawtypes", "resource" })
	
	public Map callSelectForMap(String page_info, String selectContent, List inParams, MKTDBInfoDTO dbInfo) {
		LogUtil.param(MKTCallQueryDao.class, page_info);

		String query = "";
		String err_message = "";
		Map rsMap = new HashMap();

		MKTDBQueryDTO BeanDB = new MKTDBQueryDTO();
		Connection conn = BeanDB.getConnection(dbInfo);
		PreparedStatement prepareStmt = null;
		ResultSet rs = null;

		try {
			if (conn != null) {
				prepareStmt = new LoggableStatementUtil(conn, selectContent);
				prepareStmt = setPrepareStmtInParams(prepareStmt, inParams);

				query = ((LoggableStatementUtil) prepareStmt).getQueryString();
				LogUtil.debug("[SQL Log : " + page_info + "] " + query);
				rs = prepareStmt.executeQuery();

				while (rs.next()) {
					Map<String, Object> hashRow = new LinkedHashMap<String, Object>();
					int columnCount = rs.getMetaData().getColumnCount();
					for (int i = 1; i <= columnCount; i++) {
						hashRow.put(rs.getMetaData().getColumnLabel(i), rs.getObject(i));
					}

					rsMap = hashRow;
				}

			} else {
				err_message = "DB Connection Error";
				LogUtil.error(err_message);
				throw new DataSQLException();
			}
		} catch (DataAccessException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		} catch (SQLException e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		} finally {
			try { if (rs != null) rs.close(); } catch (SQLException e) { LogUtil.error(e.getMessage()); };
			try { if (prepareStmt != null) prepareStmt.close(); } catch (SQLException e) { LogUtil.error(e.getMessage()); };
			try { if (conn != null) conn.close(); } catch (SQLException e) { LogUtil.error(e.getMessage()); };
			try { BeanDB.close(); } catch (SQLException e) { LogUtil.error(e.getMessage()); };
		}

		return rsMap;
	}

	/**
	 * @name : callInsert
	 * @date : 2015. 08. 03.
	 * @author : 류동균
	 * @description : insert SQL문 수행
	 * @return : StatusResDto
	 */
	@SuppressWarnings({ "resource", "rawtypes" })
	
	public StatusResDto callInsert(String page_info, String insertContent, List inParams, MKTDBInfoDTO dbInfo, boolean ignoreZero) {
		LogUtil.param(MKTCallQueryDao.class, page_info);

		StatusResDto rtnValue = new StatusResDto();

		String query = "";
		String err_message = "";
		int rowCount = 0;

		MKTDBQueryDTO BeanDB = new MKTDBQueryDTO();
		Connection conn = BeanDB.getConnection(dbInfo);
		PreparedStatement prepareStmt = null;

		try {
			if (conn != null) {
				prepareStmt = new LoggableStatementUtil(conn, insertContent);
				prepareStmt = setPrepareStmtInParams(prepareStmt, inParams);

				query = ((LoggableStatementUtil) prepareStmt).getQueryString();
				LogUtil.debug("[SQL Log : " + page_info + "] " + query);
				rowCount = prepareStmt.executeUpdate();

				if (rowCount > 0 || ignoreZero) {
					rtnValue.setSuccess(true);
				} else {
					LogUtil.error("results is null");

					throw new DataFailException(ErrorHelper.MSG_1001);
				}
			} else {
				err_message = "DB Connection Error";
				LogUtil.error("callInsert : " + (err_message));
				throw new DataSQLException();
			}
		} catch (DataAccessException e) {
			LogUtil.error(e.getMessage(), e);
			throw e;
		} catch (DataFailException e) {
			LogUtil.error(e.getMessage(), e);

			throw e;
		} catch (SQLException e) {
			LogUtil.error(e.getMessage(), e);

			throw new DataSQLException();
		} finally {
			try {
				if (prepareStmt != null)
					prepareStmt.close();
				if (conn != null)
					conn.close();
				BeanDB.close();
			} catch (SQLException e) {
				LogUtil.error(e.getMessage(), e);
				
			} 
		}

		return rtnValue;
	}

	/**
	 * @name : callUpdate
	 * @date : 2015. 08. 03.
	 * @author : 류동균
	 * @description : update SQL문 수행
	 * @return : StatusResDto
	 */
	@SuppressWarnings({ "resource", "rawtypes" })
	
	public StatusResDto callUpdate(String page_info, String updateContent, List inParams, MKTDBInfoDTO dbInfo, boolean ignoreZero) {
		LogUtil.param(MKTCallQueryDao.class, page_info);

		StatusResDto rtnValue = new StatusResDto();

		String query = "";
		String err_message = "";
		int rowCount = 0;

		MKTDBQueryDTO BeanDB = new MKTDBQueryDTO();
		Connection conn = BeanDB.getConnection(dbInfo);
		PreparedStatement prepareStmt = null;

		try {
			if (conn != null) {
				prepareStmt = new LoggableStatementUtil(conn, updateContent);
				prepareStmt = setPrepareStmtInParams(prepareStmt, inParams);

				query = ((LoggableStatementUtil) prepareStmt).getQueryString();
				LogUtil.debug("[SQL Log : " + page_info + "] " + query);
				rowCount = prepareStmt.executeUpdate();

				if (rowCount > 0 || ignoreZero) {
					rtnValue.setSuccess(true);
				} else {
					LogUtil.error("results is null");
					throw new DataFailException(ErrorHelper.MSG_1001);
				}
			} else {
				err_message = "DB Connection Error";
				LogUtil.error("callInsert : " + (err_message));
				throw new DataSQLException();
			}
		} catch (DataAccessException e) {
			LogUtil.error(e.getMessage(), e);
			throw e;
		} catch (DataFailException e) {
			LogUtil.error(e.getMessage(), e);

			throw e;
		} catch (SQLException e) {
			LogUtil.error(e.getMessage(), e);

			throw new DataSQLException();
		} finally {
			try {
				if (prepareStmt != null)
					prepareStmt.close();
				if (conn != null)
					conn.close();
				BeanDB.close();
			} catch (SQLException e) {
				LogUtil.error(e.getMessage(), e);
				
			} 		}

		return rtnValue;
	}

	/**
	 * @name : callDelete
	 * @date : 2015. 08. 03.
	 * @author : 류동균
	 * @description : delete SQL문 수행
	 * @return : StatusResDto
	 */
	@SuppressWarnings({ "resource", "rawtypes" })
	
	public StatusResDto callDelete(String page_info, String deleteContent, List inParams, MKTDBInfoDTO dbInfo, boolean ignoreZero) {
		LogUtil.param(MKTCallQueryDao.class, page_info);

		StatusResDto rtnValue = new StatusResDto();

		String query = "";
		String err_message = "";
		int rowCount = 0;

		MKTDBQueryDTO BeanDB = new MKTDBQueryDTO();
		Connection conn = BeanDB.getConnection(dbInfo);
		PreparedStatement prepareStmt = null;
		ResultSet rs = null;

		try {
			if (conn != null) {
				prepareStmt = new LoggableStatementUtil(conn, deleteContent);
				prepareStmt = setPrepareStmtInParams(prepareStmt, inParams);

				query = ((LoggableStatementUtil) prepareStmt).getQueryString();
				LogUtil.debug("[SQL Log : " + page_info + "] " + query);
				rowCount = prepareStmt.executeUpdate();

				if (rowCount > 0 || ignoreZero) {
					rtnValue.setSuccess(true);
				} else {
					LogUtil.error("results is null");

					throw new DataFailException(ErrorHelper.MSG_1001);
				}
			} else {
				err_message = "DB Connection Error";
				LogUtil.error("callInsert : " + (err_message));
				throw new DataSQLException();
			}
		} catch (DataAccessException e) {
			LogUtil.error(e.getMessage(), e);

			throw e;
		} catch (DataFailException e) {
			LogUtil.error(e.getMessage(), e);

			throw e;
		} catch (SQLException e) {
			LogUtil.error(e.getMessage(), e);

			throw new DataSQLException();
		} finally {
			try {
				if (prepareStmt != null)
					prepareStmt.close();
				if (conn != null)
					conn.close();
				BeanDB.close();
			} catch (SQLException e) {
				LogUtil.error(e.getMessage(), e);
			} 
		}

		return rtnValue;
	}

	/**
	 * @name : selectQueryPageing
	 * @date : 2016. 8. 3.
	 * @author : 류동균
	 * @return :
	 * @description : 해당 쿼리를 DB유형별 그리드 페이징 쿼리로 변환
	 */
	@SuppressWarnings("unused")
	
	public String selectQueryPageing(String queryStr, Object obj, String type) {
		String rtnQuery = "";
		GridPagingReqDto parseParam = new GridPagingReqDto();
	//	List<Object> rsList = new ArrayList<Object>();

		try {
			parseParam = (GridPagingReqDto) obj;
			
			if (parseParam.getRows() == 0) {
				parseParam.setRows(10);
			}

			String sidx = parseParam.getSidx();
//			if (!"1".equals(sidx)) {
//				sidx = "\"" + sidx + "\"";
//			}
			if ("ORACLE".equals(type) || "POSTGRESQL".equals(type) ||"MEMSQL".equals(type)) {
				rtnQuery += "select t.*\n";
				rtnQuery += "  from (\n";
				rtnQuery += "    select t.*\n";
				rtnQuery += "         , floor((row_number() over(order by " + sidx + " " + parseParam.getSord() + ") - 1) / " + parseParam.getPageSize() + ") + 1 as \"pageNum\"\n";
				rtnQuery += "         , ceil(count(1) over() / " + parseParam.getPageSize() + ") as \"totalPage\"\n";
				rtnQuery += "         , ceil(count(1) over()) as \"totalCount\"\n";
				rtnQuery += "      from (\n";
				rtnQuery += "        select t.*\n";
				rtnQuery += "          from (\n" + queryStr + "\n";
				rtnQuery += "        ) t\n";

				// 그리드 검색 조건 추가
  				if (ObjectUtil.isNotEmpty(parseParam.getSearchWord())) {
					rtnQuery += "     where t.\"" + parseParam.getSearchText() + "\" like '%" + parseParam.getSearchWord() + "%'\n";
				}

 				int page = parseParam.getPage() == 0 ? 1 : parseParam.getPage();
 				if("MEMSQL".equals(type)) {
 					rtnQuery += ") t\n ) t\n where t.pageNum = " + page;
 				}
 				else{rtnQuery += ") t\n ) t\n where t.\"pageNum\" = " + page;}
			} else if ( "MSSQL".equals(type) ){

				int page = parseParam.getPage() == 0 ? 1 : parseParam.getPage();

				rtnQuery += "select t.*\n";
				rtnQuery += "  from (\n";
				rtnQuery += "select t.* ";
				rtnQuery += "       , ceiling(count(1) over() / " + parseParam.getPageSize() + ")+1 as \"totalPage\"\n";
				rtnQuery += "       , ceiling(count(1) over()) as \"totalCount\"\n";
				rtnQuery += "       , ROW_NUMBER() OVER (ORDER BY COL_VALUE DESC) as \"RowNumber\"\n";
				rtnQuery += "  from ( ";
				rtnQuery += "    " + queryStr;
				rtnQuery += ") t";
				rtnQuery += "        ) t \n";
				rtnQuery += " WHERE RowNumber > "+parseParam.getSkipCount()+" and RowNumber <= " + parseParam.getPageSize()* page +"\n";

				// 그리드 검색 조건 추가
				if (ObjectUtil.isNotEmpty(parseParam.getSearchWord())) {
					rtnQuery += "     and t.\"" + parseParam.getSearchText() + "\" like '%" + parseParam.getSearchWord() + "%'\n";
				}

				rtnQuery += " order by " + sidx + " " + parseParam.getSord()+"\n";
//				rtnQuery += "OFFSET "+parseParam.getSkipCount()+" ROWS FETCH NEXT " + parseParam.getPageSize() + " ROWS ONLY";

			} else {
				
				rtnQuery += "select sql_calc_found_rows a.* ";
				rtnQuery += "  from ( ";
				rtnQuery += "    " + queryStr;
				rtnQuery += ") a";

				// 그리드 검색 조건 추가
				if (ObjectUtil.isNotEmpty(parseParam.getSearchWord())) {
					rtnQuery += " where a." + parseParam.getSearchText() + " like '%" + parseParam.getSearchWord() + "%'\n";
				}

				rtnQuery += " order by " + sidx + " " + parseParam.getSord();
				rtnQuery += " limit " + parseParam.getSkipCount() + ", " + parseParam.getPageSize();
			}
		} catch (Exception e) {
			LogUtil.error(e.getMessage(), e);
			throw new DataSQLException();
		}

		return rtnQuery;
	}

	/**
	 * @name : setPrepareStmtInParams
	 * @date : 2016. 8. 3.
	 * @author : 류동균
	 * @return : PreparedStatement
	 * @description : PreparedStatement의 파라메터 설정
	 */
	@SuppressWarnings("rawtypes")
	public PreparedStatement setPrepareStmtInParams(PreparedStatement prepareStmt, List list) {

		int index = 1;
		try {
			for (Object obj : list) {
				if (obj == null) {
					prepareStmt.setNull(index++, java.sql.Types.NULL);
				} else if (obj.equals(java.lang.Integer.class) || "java.lang.Integer".equals(obj.getClass().getName())) {
					prepareStmt.setInt(index++, (int) obj);
				} else {
					prepareStmt.setString(index++, (String) obj);
				}
			}
		} catch (Exception e) {
			LogUtil.error("setPrepareStmtInParams : " , e);
			
		}

		return prepareStmt;
	}

	/**
	 * @name : callSelect
	 * @date : 2015. 11. 12.
	 * @author : 류동균
	 * @description : SELECT SQL문 수행 - 2017.08.03 사용 중지
	 * @return : Hashtable Key => query, err_code, err_message, rsList,
	 *         cursor_info
	 */
	@Deprecated
	@SuppressWarnings({ "rawtypes", "resource", "unchecked" })
	
	public Hashtable callSelect(String page_info, String selectContent, List inParams, MKTDBInfoDTO dbInfo) {

		Hashtable hash = new Hashtable();
		String query = "";
		String err_code = "F";
		String err_message = "no Data";
		String totalCount = "";

		List rsList = new ArrayList();
		String cursorInfo = "";

		MKTDBQueryDTO BeanDB = new MKTDBQueryDTO();
		Connection conn = BeanDB.getConnection(dbInfo);
		PreparedStatement prepareStmt = null;
		ResultSet rs = null;

		try {
			if (conn != null) {
				prepareStmt = new LoggableStatementUtil(conn, selectContent);
				prepareStmt = setPrepareStmtInParams(prepareStmt, inParams);

				query = ((LoggableStatementUtil) prepareStmt).getQueryString();
				LogUtil.debug("[SQL Log : " + page_info + "] " + query);
				rs = prepareStmt.executeQuery();

				rs = prepareStmt.executeQuery();

				while (rs.next()) {
					Hashtable hashRow = new Hashtable();
					int columnCount = rs.getMetaData().getColumnCount();

					for (int i = 1; i <= columnCount; i++) {
						hashRow.put(rs.getMetaData().getColumnName(i), StringUtil.convertNull(rs.getString(i), "").trim());
						if (rsList.size() == 0) {
							cursorInfo = cursorInfo + "[" + i + "]" + rs.getMetaData().getColumnName(i) + ":" + (StringUtil.convertNull(rs.getString(i), "").trim()) + "\n";
						}
					}

					rsList.add(hashRow);
					err_code = "S";
				}

				if ("MYSQL".equals(dbInfo.getConDbType())) {
					String countQuery = "select FOUND_ROWS() as count";
					prepareStmt = conn.prepareStatement(countQuery);
					rs = prepareStmt.executeQuery();

					while (rs.next()) {
						totalCount = StringUtil.convertNull(rs.getString(1), "").trim();
					}
				}

				if (err_code.equals("S"))
					err_message = "select : " + rsList.size();
			} else {
				err_code = "F";
				err_message = "DB Connection Error";
				LogUtil.error("callSelect : " + (err_message));
			}
		} catch (SQLException sqle) {
			err_message = sqle.toString();			
			LogUtil.error("callSelect : " + err_message, sqle);
			err_message = "select Error";
			
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (prepareStmt != null)
					prepareStmt.close();
				if (conn != null)
					conn.close();
				BeanDB.close();
			} catch (SQLException sqle) {LogUtil.error(sqle);}
		}

		hash.put("query", query);
		hash.put("err_code", err_code);
		hash.put("err_message", err_message);
		hash.put("rsList", rsList);
		hash.put("totalCount", totalCount);
		hash.put("cursor_info", cursorInfo);

		StringBuffer debug_message = new StringBuffer();
		debug_message.append(" ===> " + page_info + " ===> query ===> \n" + (query) + "\n")
				     .append(" ===> " + page_info + " ===> err_code ===> " + (err_code) + "\n")
				     .append(" ===> " + page_info + " ===> err_message ===> " + (err_message) + "\n")
				     .append(" ===> " + page_info + " ===> cursorInfo ===> \n" + (cursorInfo));
		LogUtil.debug("\n" + debug_message.toString());

		return hash;
	}

	/**
	 * @name : queryForGridList
	 * @date : 2016. 3. 15.
	 * @author : 송원희
	 * @description : 그리드 리스트 변환 - 2017.08.03 사용 중지
	 * @return : GridPagingResDto<Object>
	 */
	@Deprecated
	@SuppressWarnings({ "unchecked", "rawtypes" })
	
	public GridPagingResDto<Object> queryForGridList(Hashtable hash) {

		GridPagingResDto<Object> rtnValue = new GridPagingResDto<Object>();
		List<Object> rsList = new ArrayList<Object>();
		try {
			rsList = (ArrayList) hash.get("rsList");

			if (rsList != null && rsList.size() > 0) {
				int page = 0;
				int totalCount = 0;
				int pageCount = 1;
				Hashtable tmp = (Hashtable) rsList.get(0);

				page = Integer.parseInt(tmp.get("PAGENUM").toString());
				pageCount = Integer.parseInt(tmp.get("TOTALPAGE").toString());
				totalCount = Integer.parseInt(tmp.get("TOTALCOUNT").toString());

				rtnValue.setSuccess(true);
				rtnValue.setRows(rsList);
				rtnValue.setRecords(totalCount);
				rtnValue.setPage(page);
				rtnValue.setTotal(pageCount);
			} else {
				LogUtil.error("results is null");
				throw new DataFailException(ErrorHelper.MSG_1001);
			}
		} catch (Exception e) {
			LogUtil.error(e.getMessage(), e);
		}

		return rtnValue;
	}

	/**
	 * @name : selectQueryPageing
	 * @date : 2016. 3. 16.
	 * @author : 송원희
	 * @description : 페이징 쿼리 수정 - 2017.08.03 사용 중지
	 * @return : String
	 */
	@Deprecated
	@SuppressWarnings("unused")
	
	public String selectQueryPageing(String queryStr, Object obj) {
		String rtnQuery = "";
		GridPagingReqDto parseParam = new GridPagingReqDto();
	//	List<Object> rsList = new ArrayList<Object>();
		try {
			parseParam = (GridPagingReqDto) obj;

			rtnQuery += "SELECT * FROM (    ";
			rtnQuery += "SELECT    A.*  ";
			rtnQuery += ", CEIL((ROW_NUMBER() OVER(order by " + parseParam.getSidx() + " " + parseParam.getSord() + ")) / " + parseParam.getPageSize() + ") pageNum ";
			rtnQuery += ", CEIL(COUNT(1) OVER() / " + parseParam.getPageSize() + ") totalPage   ";
			rtnQuery += ", CEIL(COUNT(1) OVER()) totalCount ";
			rtnQuery += "FROM ( ";
			rtnQuery += "SELECT A.* FROM (  ";
			rtnQuery += queryStr;
			rtnQuery += ") A ";

			// 그리드 검색 조건 추가
			if (!"".equals(parseParam.getSearchWord())) {
				rtnQuery += "WHERE A." + parseParam.getSearchText() + " like '%" + parseParam.getSearchWord() + "%' ";
			}

			int page = parseParam.getPage() == 0 ? 1 : parseParam.getPage();
			rtnQuery += ")A ) WHERE pageNum = least(" + page + ", totalPage)";

		} catch (Exception e) {
			LogUtil.error(e.getMessage(), e);
		}

		return rtnQuery;
	}

}
