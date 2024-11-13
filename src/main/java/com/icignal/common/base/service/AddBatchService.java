/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: AddBatchService.java
 * 2. Package	: com.icignal.common.base.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 24. 오전 10:00:48
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 24.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.common.base.service;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;

import com.icignal.common.util.BeansUtil;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.core.database.dto.request.MKTDBQueryDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.core.exception.DataSQLException;


/*
 * 1. 클래스명	: AddBatchService
 * 2. 파일명	: AddBatchService.java
 * 3. 패키지명	: com.icignal.common.base.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 24.
 */
/**
 * <PRE>
 * 1. 설명
 *  AddBatch용 서비스
 * </PRE>
 */
@Service
public class AddBatchService {

	@Autowired
	@Resource(name="transactionManager-batch")
	private DataSourceTransactionManager transactionManager;


	/**
	 * @name : addBatch
	 * @date : 2017. 2. 15.
	 * @author : dg.ryu
	 * @throws SQLException 
	 * @description : addBatch 사용
	 */
	public StatusResDto addBatch(String sql, List<Map<Integer, Object>> params) {
		LogUtil.param(this.getClass(), "");
		
		StatusResDto rtnValue = new StatusResDto();

		int splitSize = Integer.parseInt(BeansUtil.getApplicationProperty("icignal.jdbc-batch.splitSize"));


		Connection con = null;
        PreparedStatement pstmt = null ;
        int limitOnceCnt = splitSize;
        
		try {
			LogUtil.info("ExecuteBatch Start");
			//SET PrepareStatement
            con = transactionManager.getDataSource().getConnection();
            con.setAutoCommit(false); 
            LogUtil.info("AddBatch" + sql);
            pstmt = con.prepareStatement(sql) ;
            
            int idx = 0;
            for (Map<Integer, Object> param : params) {
            	
            	idx++;
            	
            	//SET Parameter
            	Set<Entry<Integer, Object>> entries = param.entrySet();
            	
            	for (Entry<Integer, Object> entry : entries) {
            		int index = entry.getKey();
            		Object obj = entry.getValue();
            		
            		if (obj == null) {
            			pstmt.setNull(index, java.sql.Types.NULL);
    				} else if (obj.equals(java.lang.Integer.class) || "java.lang.Integer".equals(obj.getClass().getName())) {
    					pstmt.setInt(index, (int) obj);
    				} else if (obj.equals(java.lang.Double.class) || "java.lang.Double".equals(obj.getClass().getName())) {
    					pstmt.setDouble(index, (double) obj);
    				} else if (obj.equals(java.sql.Date.class) || "java.sql.Date".equals(obj.getClass().getName())) {
    					pstmt.setDate(index,(Date) obj);
    				} else {
    					pstmt.setString(index, (String) obj);
    				}
            	}
	            // addBatch에 담기
	            pstmt.addBatch();
	             
	            // 파라미터 Clear
	            pstmt.clearParameters() ;
	             
	            // OutOfMemory를 고려하여 limitOnceCnt 단위로 커밋
	            if (idx % limitOnceCnt == 0) {
	            	
	            	LogUtil.info(pstmt.toString());
	                 
	                // Batch 실행
	                pstmt.executeBatch() ;
	                 
	                // Batch 초기화
	                pstmt.clearBatch();
	                
	                LogUtil.info("ExecuteBatch (" + idx + ")");
	            }
            }
            // 나머지 Batch 처리
            pstmt.executeBatch();
            con.commit();
            
            LogUtil.info("ExecuteBatch End (" + idx + ")");
            rtnValue.setSuccess(true);
            
        } catch (SQLException e) {
        	LogUtil.error(e.toString());
        	
        	try {con.rollback();} catch(SQLException ex){ LogUtil.error(ex); }
        	if (pstmt != null) try {pstmt.close(); pstmt = null;} catch(SQLException ex){ LogUtil.error(ex); }
            if (con != null) try {con.rollback(); con.close(); con = null;} catch(SQLException ex){ LogUtil.error(ex.getMessage(), ex);}
            
            throw new DataSQLException();
		} finally {
            if (pstmt != null) try {pstmt.close(); pstmt = null;} catch(SQLException ex){ LogUtil.error(ex); }
            if (con != null) try {con.setAutoCommit(true); con.close(); con = null;} catch(SQLException ex){LogUtil.error(ex.getMessage(), ex);}
        }
		return rtnValue;
	}

	/**
	 * @name : addBatch
	 * @date : 2022. 03. 10.
	 * @author : gy.lee
	 * @throws SQLException
	 * @description : addBatch connection 연결 후 사용
	 */
	public StatusResDto addBatch(String sql, List<Map<Integer, Object>> params, MKTDBInfoDTO dbInfo) {
		LogUtil.param(this.getClass(), "");

		StatusResDto rtnValue = new StatusResDto();
		int splitSize = Integer.parseInt(BeansUtil.getApplicationProperty("icignal.jdbc-batch.splitSize"));


		MKTDBQueryDTO BeanDB = new MKTDBQueryDTO();
		Connection con = BeanDB.getConnection(dbInfo);
		PreparedStatement pstmt = null;
		int limitOnceCnt = splitSize;

		try {
			LogUtil.info("ExecuteBatch Start");
			//SET PrepareStatement
			con.setAutoCommit(false);
			LogUtil.info("AddBatch" + sql);
			pstmt = con.prepareStatement(sql) ;

			int idx = 0;
			for (Map<Integer, Object> param : params) {

				idx++;

				//SET Parameter
				Set<Entry<Integer, Object>> entries = param.entrySet();

				for (Entry<Integer, Object> entry : entries) {
					int index = entry.getKey();
					Object obj = entry.getValue();

					if (obj == null) {
						pstmt.setNull(index, java.sql.Types.NULL);
					} else if (obj.equals(java.lang.Integer.class) || "java.lang.Integer".equals(obj.getClass().getName())) {
						pstmt.setInt(index, (int) obj);
					} else if (obj.equals(java.lang.Double.class) || "java.lang.Double".equals(obj.getClass().getName())) {
						pstmt.setDouble(index, (double) obj);
					} else if (obj.equals(java.sql.Date.class) || "java.sql.Date".equals(obj.getClass().getName())) {
						pstmt.setDate(index,(Date) obj);
					} else {
						pstmt.setString(index, (String) obj);
					}
				}
				// addBatch에 담기
				pstmt.addBatch();

				// 파라미터 Clear
				pstmt.clearParameters() ;

				// OutOfMemory를 고려하여 limitOnceCnt 단위로 커밋
				if (idx % limitOnceCnt == 0) {

					LogUtil.info(pstmt.toString());

					// Batch 실행
					pstmt.executeBatch() ;

					// Batch 초기화
					pstmt.clearBatch();

					LogUtil.info("ExecuteBatch (" + idx + ")");
				}
			}
			// 나머지 Batch 처리
			pstmt.executeBatch();
			con.commit();

			LogUtil.info("ExecuteBatch End (" + idx + ")");
			rtnValue.setSuccess(true);

		} catch (SQLException e) {
			LogUtil.error(e.toString());

			try {con.rollback();} catch(SQLException ex){ LogUtil.error(ex); }
			if (pstmt != null) try {pstmt.close(); pstmt = null;} catch(SQLException ex){ LogUtil.error(ex); }
			if (con != null) try {con.rollback(); con.close(); con = null;} catch(SQLException ex){ LogUtil.error(ex.getMessage(), ex);}

			throw new DataSQLException();
		} finally {
			if (pstmt != null) try {pstmt.close(); pstmt = null;} catch(SQLException ex){ LogUtil.error(ex); }
			if (con != null) try {con.setAutoCommit(true); con.close(); con = null;} catch(SQLException ex){LogUtil.error(ex.getMessage(), ex);}
		}
		return rtnValue;
	}
	
	
	/**
	 * @name : truncateBeforeInsert
	 * @date : 2020. 12. 14.
	 * @author : jb.kim
	 * @throws SQLException 
	 * @description : '도로명주소관리'에서 엑셀주소를 새로 업로드할 때, com.b_code테이블에 데이터 insert 하기 전 truncate를 먼저 수행하는 작업
	 */
	public StatusResDto truncateBeforeInsert(String truncateSql) {
		LogUtil.param(this.getClass(), "");
		
		StatusResDto rtnValue = new StatusResDto();
        Connection con = null;
        PreparedStatement truncatePstmt = null ;
        
        // truncate 작업 수행
 		try {
 			LogUtil.info("Truncate table com.b_code Start, before Insert into com.b_code");
 			con = transactionManager.getDataSource().getConnection();
 			con.setAutoCommit(false);
 			LogUtil.info("truncate sql => " + truncateSql);
 			truncatePstmt = con.prepareStatement(truncateSql.toString());	
 			// com.b_code 테이블의 데이터 삭제 sql 수행
 			truncatePstmt.executeUpdate();
 			// 데이터 제거 후 성공 정보 담기
 			rtnValue.setSuccess(true);
 			
 		} catch(SQLException e) {
 			LogUtil.error(e.toString());
 			e.printStackTrace();
 			        	
         	try {con.rollback();} catch(SQLException ex){ LogUtil.error(ex); }
         	if (truncatePstmt != null) try {truncatePstmt.close(); truncatePstmt = null;} catch(SQLException ex){ LogUtil.error(ex); }
            if (con != null) try {con.rollback(); con.close(); con = null;} catch(SQLException ex){ LogUtil.error(ex.getMessage(), ex);}
             
            throw new DataSQLException();
             
 		} finally {
             if (truncatePstmt != null)
            	 try {truncatePstmt.close(); truncatePstmt = null;} catch(SQLException ex){ LogUtil.error(ex); }
             if (con != null) 
            	 try { con.setAutoCommit(true); con.close(); con = null;} catch(SQLException ex){LogUtil.error(ex.getMessage(), ex);}
        }
 		
 		return rtnValue;
	}// end truncateBeforeInsert
	
}
