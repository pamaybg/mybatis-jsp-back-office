package com.icignal.core.database.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Hashtable;

import javax.naming.Context;

import com.icignal.common.util.DateUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;

import oracle.jdbc.pool.OracleDataSource;

/**
 * @name : infavor.base.DB
 * @date : 2015. 11. 12.
 * @author : 류동균
 * @description : 
 */
public class MKTDBConnectDAO 
{
	private Connection conn;
	public ResultSet rset;
	public Statement stmt;
	public CallableStatement callstmt;	

	public MKTDBConnectDAO () 
	{
		super () ;		
	}

	/**
	 * CallableStatement 를 close
	 */

	 void callstmtClose ()
	{
		try
		{
			if ( this.callstmt != null ) this.callstmt.close () ;
		}
		catch ( SQLException ex )
		{
		    LogUtil.error ( DateUtil.getDateString() + " " + DateUtil.getTimeString() + " : " ) ;
		    LogUtil.error ( "DBConnectBean.callstmtClose : " + ex.getMessage (), ex );
		}
		finally
		{
			this.callstmt = null ;
		}
	}

	/**
	 * ResultSet, Statement, CallableStatement, Connection 을 차례로 close
	 */

	public  void closeAll () 
	{
		rsClose () ;
		stmtClose () ;
		callstmtClose() ;
		connClose () ;	
	}

	/**
	 * Connection 을 close 
	 */

	public  void connClose ()
	{

		try
		{
			if ( this.conn != null ) this.conn.close () ;
		}
		catch ( SQLException ex )
		{
		    LogUtil.error ( DateUtil.getDateString() + " " + DateUtil.getTimeString() + " : " ) ;
		    LogUtil.error ( "DBConnectBean.connClose : " + ex.getMessage (), ex ) ;
		}
		finally
		{
			this.conn = null ;
		}
	}

	/**
	 * Select Query 문을 수행할때 사용한다.
	 */

	public  ResultSet executeQuery ( String query ) throws SQLException
	{

		rsClose () ;
		this.rset = this.stmt.executeQuery (query) ;
		return this.rset ;
	}
	

	/**
	 * 반드시 저널을 사용시에 써야한다.
	 * Insert, Delete, Update 문을 수행시에 사용, Transaction 처리를 하여 수행도중 오류발생시 rollback 을 수행
	 */

	public  boolean executeUpdate ( String[] query ) throws SQLException
	{
		try 
		{
			this.conn.setAutoCommit ( false );						

			for ( int i = 0 ; i < query.length ; i ++ )
			{	
				this.stmt.executeUpdate ( query[i] ) ;
			}

			return true;
		}
		catch ( Exception ex )
		{
			for ( int i = 0 ; i < query.length ; i ++ )
			{
			    LogUtil.error ( DateUtil.getDateString() + " " + DateUtil.getTimeString() + " : " ) ;
			    LogUtil.error ( "DBConnectBean.executeUpdate [query" + i + "] : " + query[i] ) ;
			}
			LogUtil.error ( DateUtil.getDateString() + " " + DateUtil.getTimeString() + " : " ) ;
			LogUtil.error ( "DBConnectBean.executeUpdate Exception : " + ex.getMessage () ,ex ) ;

			if ( this.conn != null ) this.conn.rollback () ;

			return false;
		}
		finally
		{
			if (this.conn != null ) this.conn.setAutoCommit ( true ) ;
		}
	}

	/**
	 * Insert, Delete, Update 문을 수행시에 사용
	 */
	public  int executeUpdate ( String query ) throws SQLException
	{
		int result = 0 ;

			result = this.stmt.executeUpdate ( query ) ;
			return result ;

		
	}

	/**
	 * DB Connection 객체를 가져온다.
	 */
	public  Connection getConnection (MKTDBInfoDTO dbInfo) 
	{
	    openConnection(dbInfo);
		return this.conn;
	} 


	/**
	 * DB Connection을 해준다.
	 */

	/* boolean openConnection (MKTDBInfoDTO dbInfo) 
	{
		Context context = null ;
		Hashtable env = null ;
		
		try 
		{
			//db별 driver class name
			if ("MYSQL".equals(dbInfo.getConDbType())) {
				dbInfo.setDriverClassName("com.mysql.jdbc.jdbc2.optional.MysqlDataSource");
			} else if ("ORACLE".equals(dbInfo.getConDbType())) {
				dbInfo.setDriverClassName("com.mysql.jdbc.jdbc2.optional.MysqlDataSource");
			} else if ("MSSQL".equals(dbInfo.getConDbType())) {
				dbInfo.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDataSource");
			} else if ("MARIADB".equals(dbInfo.getConDbType())) {
				dbInfo.setDriverClassName("org.mariadb.jdbc.MySQLDataSource");
			}
			
			//HikariConfig
			HikariDataSource config = new HikariDataSource();
			config.setDriverClassName(dbInfo.getDriverClassName());
			config.setJdbcUrl(dbInfo.getUrl());
			config.setUsername(dbInfo.getUserName());
			config.setPassword(dbInfo.getPassword());
			
			config.setAutoCommit(true);
			config.setMinimumIdle(10);
			config.setMaximumPoolSize(10);
			config.setConnectionTimeout(300000);

			config.addDataSourceProperty("dataSource.cachePrepStmts", "true");
			config.addDataSourceProperty("dataSource.prepStmtCacheSize", "250");
			config.addDataSourceProperty("dataSource.prepStmtCacheSqlLimit", "2048");
			config.addDataSourceProperty("dataSource.useServerPrepStmts", "true");
			
			DataSource datasource = config;
			
			this.conn = datasource.getConnection();
		    
			if(dbInfo.getDriverClassName().equals("com.microsoft.sqlserver.jdbc.SQLServerDriver")){
				this.stmt = this.conn.createStatement ( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE ) ;
			}
			else{
				this.stmt = this.conn.createStatement ( ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE ) ;
			}
			
			return true ;
		} 
		catch ( Exception ex ) 
		{
		    LogUtil.error ( IFVMDateUtility.getDateString() + " " + IFVMDateUtility.getTimeString() + " : " ) ;
		    LogUtil.error ( "DBConnectBean.openConnection NamingException : " + ex.getMessage () ) ;

			return false ;
		} 
		finally 
		{
			try 
			{ 
				if ( context != null ) context.close () ;
			} 
			catch ( Exception ex ) 
			{
				LogUtil.error ( IFVMDateUtility.getDateString() + " " + IFVMDateUtility.getTimeString() + " : " ) ;
				LogUtil.error ( "DBConnectBean.openConnection finally Exception : " +  ex.toString () ) ;
			} 
			finally 
			{
				if(context!=null) context = null ;
				
				LogUtil.debug("Returning JDBC Connection to DataSource");
			}

			if(env!=null) env = null;
		}
	}*/
	
	public  boolean openConnection (MKTDBInfoDTO dbInfo) 
	{
		Context context = null ;
		Hashtable env = null ;
		
		if (ObjectUtil.isEmpty(dbInfo.getDriverClassName())) {
			dbInfo.setDriverClassName(DB_TYPE.getDriverClassName(dbInfo.getConDbType()));
		}
		
		try 
		{	
		    //Oracle
		    //Class.forName("oracle.jdbc.driver.OracleDriver");
		    //MySql
			if(dbInfo.getDbFlag() != null && dbInfo.getDbFlag().equals("Y")){
				OracleDataSource ds = new OracleDataSource();
			    ds.setDriverType("thin");
			    ds.setServerName(dbInfo.getConIp());
			    ds.setPortNumber(Integer.parseInt(dbInfo.getConPort()));
			    ds.setDatabaseName(dbInfo.getDbNm()); // sid 
			    ds.setUser(dbInfo.getUserName());
			    ds.setPassword(dbInfo.getPassword());

			    this.conn = ds.getConnection();
			} else {
				Class.forName(dbInfo.getDriverClassName());
				this.conn = DriverManager.getConnection(dbInfo.getUrl(), dbInfo.getUserName(), dbInfo.getPassword());
			}
		    
			if(dbInfo.getDriverClassName().equals("com.microsoft.sqlserver.jdbc.SQLServerDriver")){
				this.stmt = this.conn.createStatement ( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY ) ;
			}
			else{
				this.stmt = this.conn.createStatement ( ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY ) ;
			}
			
			return true ;
		} 
		catch ( ClassNotFoundException ex ) 
		{
		    LogUtil.error ( DateUtil.getDateString() + " " + DateUtil.getTimeString() + " : " ) ;
		    LogUtil.error ( "DBConnectBean.openConnection NamingException : " + ex.getMessage () , ex) ;
            
		    
			return false ;
		} 
		catch ( SQLException ex ) 
		{
		    LogUtil.error ( DateUtil.getDateString() + " " + DateUtil.getTimeString() + " : " ) ;
		    LogUtil.error ( "DBConnectBean.openConnection NamingException : " + ex.getMessage () , ex) ;
            
		    
			return false ;
		} 
		finally 
		{
			try 
			{ 
				if ( context != null ) context.close () ;
			} 
			catch ( Exception ex ) 
			{
				LogUtil.error ( DateUtil.getDateString() + " " + DateUtil.getTimeString() + " : " ) ;
				LogUtil.error ( "DBConnectBean.openConnection finally Exception : " +  ex.toString () , ex) ;
			} 
			finally 
			{
				if(context!=null) context = null ;
				
				LogUtil.debug("Returning JDBC Connection to DataSource");
			}

			if(env!=null) env = null;
		}
	}
	
	/**
	 * SP 호출시 사용
	 */

	public  CallableStatement prepareCall(String query) throws SQLException 
	{			
		callstmtClose();
		this.callstmt = conn.prepareCall(query);	

		return this.callstmt;
	}

	/**
	 * ResultSet 을 close
	 */

	public  void rsClose ()
	{
		try
		{
			if ( this.rset != null ) this.rset.close () ;
		}
		catch ( SQLException ex )
		{
			LogUtil.error ( DateUtil.getDateString() + " " + DateUtil.getTimeString() + " : " ) ;
			LogUtil.error ( "DBConnectBean.rsClose : " + ex ) ;
		}
		finally
		{
			this.rset = null;
		}
	}
	

	/**
	 * Statement 를 close
	 */
	public  void stmtClose ()
	{
		try
		{
			if ( this.stmt != null ) this.stmt.close () ;
		}
		catch ( SQLException ex )
		{
			LogUtil.error ( DateUtil.getDateString() + " " + DateUtil.getTimeString() + " : " ) ;
			LogUtil.error ( "DBConnectBean.stmtClose : " + ex );
		}
		finally
		{
			this.stmt = null ;
		}
	}
	
    private enum DB_TYPE {
    	/**
    	 * MySql
    	 */
    	MYSQL("com.mysql.jdbc.Driver"),
    	/**
    	 * Oracle
    	 */
    	ORACLE("oracle.jdbc.OracleDriver"),
    	/**
    	 * MSsql
    	 */
    	MSSQL("com.microsoft.sqlserver.jdbc.SQLServerDriver"),
    	/**
    	 * DB2
    	 */
    	DB2("com.ibm.db2.jcc.DB2Driver"),
    	/**
    	 * MariaDB
    	 */
    	MARIADB("org.mariadb.jdbc.Driver"),
    	/**
    	 * POSTGRESQL
    	 */
    	POSTGRESQL("org.postgresql.Driver"),
    	;
    	
    	public static String getDriverClassName(String dbType) {
    		String driverClassName = "";
    		
    		if (dbType == null) {
    			LogUtil.info("dbType is null");
    		}
    		else if (DB_TYPE.MYSQL.toString().equalsIgnoreCase(dbType)) {
    			driverClassName = DB_TYPE.MYSQL.getDriverClassName();
    		}
    		
    		else if (DB_TYPE.ORACLE.toString().equalsIgnoreCase(dbType)) {
    			driverClassName = DB_TYPE.ORACLE.getDriverClassName();
    		}
    		
    		else if (DB_TYPE.MSSQL.toString().equalsIgnoreCase(dbType)) {
    			driverClassName = DB_TYPE.MSSQL.getDriverClassName();
    		}
    		
    		else if (DB_TYPE.DB2.toString().equalsIgnoreCase(dbType)) {
    			driverClassName = DB_TYPE.DB2.getDriverClassName();
    		}
    		
    		else if (DB_TYPE.MARIADB.toString().equalsIgnoreCase(dbType)) {
    			driverClassName = DB_TYPE.MARIADB.getDriverClassName();
    		}
    		
    		else if (DB_TYPE.POSTGRESQL.toString().equalsIgnoreCase(dbType)) {
    			driverClassName = DB_TYPE.POSTGRESQL.getDriverClassName();
    		}
    		
    		return driverClassName;
    	}
    	
		private String driverClassName;
		
		DB_TYPE(String _driverClassName) {
			driverClassName = _driverClassName;
		}
		
		public String getDriverClassName() {
			return driverClassName;
		}
    }  
}

