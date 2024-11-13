package com.icignal.core.database.dto.request;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import com.icignal.common.util.LogUtil;

/**
 * @name : infavor.base.DB.DBQueryBean.java
 * @date : 2015. 11. 12.
 * @author : 류동균
 * @description : DB 관련처리
 */
public class MKTDBQueryDTO 
{
	private MKTDBConnectDTO dc;
	
	/**
	 * DBConnectBean 객체 생성
	 */
	public MKTDBQueryDTO ()
	{
		super () ;
		dc = new MKTDBConnectDTO () ;
	}
	/**
	 * DBConnectBean 리턴함
	 */
	public MKTDBConnectDTO getDC()
	{
		return dc;
	}
	/**
	 * Cursor 위치를 이동
	 */
	public boolean absolute ( int row ) throws SQLException 
	{
		return dc.rset.absolute ( row ) ;
	}
	/**
	 * Cursor 위치를 이동
	 */
	public void afterLast () throws SQLException
	{
		dc.rset.afterLast () ;
	}
	/**
	 * Cursor 위치를 이동
	 */
	public void beforeFirst () throws SQLException
	{
		dc.rset.beforeFirst () ;
	}	
	/**
	 * ResultSet, Statement, CallableStatement, Connection 을 차례로 close 시킨다.	
	 */
	public void close () throws SQLException
	{
		synchronized(this) {
	
			dc.closeAll () ;
		}
	}	
	/**
	 * Select Query 수행
	 */
	public boolean executeQuery ( String query ) throws SQLException
	{
		synchronized(this) {
			//make_SQL_LOG(query);		
			try 
			{
				dc.rset = dc.executeQuery ( query ) ;
				return true;
			}
			catch ( SQLException ex )
			{
				throw ex ;
			}
			catch ( Exception ex ) 
			{
				return false;
			}	
		}
	}	
	/**
	 * 반드시 저널을 사용시에 써야한다.
	 * Insert, Delete, Update 문을 수행시에 사용, Transaction 처리를 하여 수행도중 오류발생시 rollback 을 수행
	 */
	public boolean executeUpdate ( String[] query ) throws SQLException
	{
		synchronized(this) {
			//make_SQL_LOG(query);		
			try
			{
				return dc.executeUpdate ( query ) ;
			}
			catch ( SQLException ex )
			{
				throw ex ;	
			}
			catch ( Exception ex )
			{
				return false ;
			}	
		}
	}
	/**
	 * Insert, Delete, Update 문을 수행시에 사용
	 */
	public int executeUpdate ( String query ) throws SQLException
	{
		synchronized(this) {
			//make_SQL_LOG(query);	
			try
			{
				return dc.executeUpdate ( query ) ;
			}
			catch ( SQLException ex )
			{
				throw ex ;
			}
			catch ( Exception ex )
			{
				return 0 ;
			}
		}
	}	
	/**
	 * Cursor 위치를 처음 Cursor 로 이동
	 */
	public boolean first () throws SQLException
	{
		return dc.rset.first () ;
	}	
	/**
	 * java.sql.Blob형 데이타를 가져온다.
	 */
	public java.sql.Blob getBlob ( int index ) throws SQLException 
	{
		return dc.rset.getBlob(index) ;	
	}
	
	/**
	 * java.sql.Blob형 데이타를 가져온다.
	 */
	public java.sql.Blob getBlob ( String columnName ) throws SQLException 
	{
		return dc.rset.getBlob ( columnName ) ;	
	}	
	/**
	 * RowCount를 얻는다.
	 */

	/**
	 * ResultSet의 Column수를 얻어온다.
	 */		
	public int getColumnCount () throws SQLException 
	{
		ResultSetMetaData rsmd = dc.rset.getMetaData () ;
		return rsmd.getColumnCount () ;
	}
	/**
	 * ResultSet의 Column이름를 얻어온다.
	 */
	public String getColumnName ( int index ) throws SQLException 
	{
		ResultSetMetaData rsmd = dc.rset.getMetaData () ;
		return rsmd.getColumnName ( index ) ;
	}
	
	/**
	 * ResultSet의 Column타입을 얻어온다.
	 */
	public int getColumnType ( int index ) throws SQLException 
	{
		ResultSetMetaData rsmd = dc.rset.getMetaData () ;
		return rsmd.getColumnType ( index ) ;
	}	
	/**
	 * ResultSet의 Column타입이름를 얻어온다.
	 */
	public String getColumnTypeName ( int index ) throws SQLException 
	{
		ResultSetMetaData rsmd = dc.rset.getMetaData () ;
		return rsmd.getColumnTypeName ( index ) ;
	}	
	/**
	 * DB를 connect 객체를 가져온다.
	 */	
	public Connection getConnection (MKTDBInfoDTO dbInfo)
	{
		synchronized(this) {
			 Connection con = null;
			
			try 
			{
				con = dc.getConnection (dbInfo) ;
			}catch ( Exception ex ){
				LogUtil.error(ex);			
			}
			
			return con;	
		}
	}	
	/**
	 * double형 데이타를 가져온다.
	 */
	public double getDouble ( int index ) throws SQLException 
	{		
		return dc.rset.getDouble ( index ) ;	
	}
	/**
	 * double형 데이타를 가져온다.
	 */
	public double getDouble ( String columnName ) throws SQLException 
	{
		return dc.rset.getDouble ( columnName ) ;
	}	
	/**
	 * int형 데이타를 가져온다.
	 */
	public int getInt ( int index ) throws SQLException 
	{		
		return dc.rset.getInt ( index ) ;	
	}	
	/**
	 * int형 데이타를 가져온다.
	 */
	public int getInt ( String columnName ) throws SQLException 
	{
		return dc.rset.getInt ( columnName ) ;
	}	
	/**
	 * long형 데이타를 가져온다.
	 */
	public long getLong ( int index ) throws SQLException 
	{		
		return dc.rset.getLong ( index ) ;	
	}	
	/**
	 * long형 데이타를 가져온다.
	 */
	public long getLong ( String columnName ) throws SQLException 
	{
		return dc.rset.getLong ( columnName ) ;
	}	
	/**
	 * Row 수를 얻는다.
	 */
	public int getRow () throws SQLException
	{
		return dc.rset.getRow () ;
	}	
	/**
	 * String형 데이타를 가져온다.
	 */
	public String getString ( int index ) throws SQLException 
	{		
		return dc.rset.getString ( index ) ;	
	}	
	/**
	 * String형 데이타를 가져온다.
	 */
	public String getString ( String columnName ) throws SQLException 
	{
		return dc.rset.getString ( columnName ) ;
	}	
	/**
	 * Cursor위치를 마지막 Cursor로 이동시킨다.
	 */
	public boolean last () throws SQLException 
	{
		return dc.rset.last () ;
	}	
	/**
	 * Cursor위치를 다음 Cursor로 이동시킨다.
	 */
	public boolean next () throws SQLException 
	{
		return dc.rset.next () ;
	}	
	/**
	 * DB를 connect한다.
	 */	
	public boolean openConnection (MKTDBInfoDTO dbInfo)
	{
		synchronized(this) {
			try 
			{
				return dc.openConnection (dbInfo) ;
			} 
			catch ( Exception ex ) 
			{
				return false;	
			}
		}
	}	
	/**
	 * SP 호출시 사용
	 */
	public boolean prepareCall ( String query ) throws SQLException
	{
		synchronized(this) {
			//make_SQL_LOG(query);		
			try 
			{
				dc.callstmt = dc.prepareCall ( query ) ;
				return true;
			}
			catch ( SQLException ex )
			{
				throw ex ;
			}
			catch ( Exception ex ) 
			{
				return false;
			}	
		}
	}	
	/**
	 * Select Query 수행
	 */
	public boolean getCursor ( CallableStatement callableStmt, int paramIndex ) throws SQLException
	{
		synchronized(this) {
			//OracleCallableStatement tstmt = null;
			try 
			{
				//tstmt = (OracleCallableStatement)callableStmt;
				//dc.rset = tstmt.getCursor(paramIndex);
				dc.rset = (ResultSet) callableStmt.getObject(paramIndex);
	
				return true;
			}
			catch ( SQLException ex )
			{
				LogUtil.error("Error:" + ex.toString());
				throw ex ;
			}
			catch ( Exception ex ) 
			{
				LogUtil.error("Error:" + ex.toString());
				return false;
			}
		}
	}	
	/**
	 * CallableStatement 리턴함
	 */
	public CallableStatement getCallableStatement() throws SQLException
	{
		synchronized(this) {
			return dc.callstmt;
		}
	}
	/**
	 * Cursor위치를 이전 Cursor로 이동시킨다.
	 */
	public boolean previous () throws SQLException 
	{
		return dc.rset.previous () ;
	}	
	/**
	 * Row를 refresh한다.
	 */
	public void refreshRow () throws SQLException 
	{
		dc.rset.refreshRow () ;
	}	
	/**
	 * Cursor위치를 이동시킨다.
	 */
	public boolean relative ( int rows ) throws SQLException 
	{
		return dc.rset.relative ( rows ) ; 
	}
	public MKTDBConnectDTO getDc() {
		return dc;
	}
	public void setDc(MKTDBConnectDTO dc) {
		this.dc = dc;
	}
	
	
}
