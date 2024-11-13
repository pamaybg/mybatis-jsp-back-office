package com.icignal.core.database;


import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.zaxxer.hikari.HikariDataSource;

/**
 * DBConfig 설정 클래스
 * @author 류동균
 *
 */
//@Configurable
public class DynamicDBConfig {
    
    private JdbcTemplate template;
    
    public DynamicDBConfig(MKTDBInfoDTO dbInfo) {
    	this.dbInfo = dbInfo;
    	
    	DataSource dataSource = this.dataSource();
    	template = new JdbcTemplate(dataSource);
    }
    
    public JdbcTemplate JdbcTemplate() {
        
        return template;
    }
    
    public DataSource DataSource() {
    	
    	return dataSource;
    }
    
    @SuppressWarnings("unused")
	private NamedParameterJdbcTemplate  NamedParameterJdbcTemplate() throws Exception{
        DataSource dataSource = this.dataSource();
        NamedParameterJdbcTemplate namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
        return namedParameterJdbcTemplate;
    }
    
    /**
     * Database 정보
     * 
     */
    private MKTDBInfoDTO dbInfo;
    
    private DataSource dataSource;
    
    
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
    
    /**
	 * Database 설정 datasource 함수 
	 * 
	 * @return DataSource
	 */
    private DataSource dataSource(){
    	DataSource ds = null;
        
        if (this.dbInfo != null) {
    		HikariDataSource hds = new HikariDataSource();

    		try {
    		//String url = this.dbInfo.getUrl().replaceAll("10.254.161.4", "52.231.75.91").replaceAll("10.254.161.6", "52.231.75.91").replaceAll("10.254.163.5:1433", "52.231.33.76:2344");
    		String url = this.dbInfo.getUrl();
    		String username = this.dbInfo.getUserName();
    		String password = this.dbInfo.getPassword();
    		String driverClassName = this.dbInfo.getDriverClassName();
    		
    		if (ObjectUtil.isEmpty(this.dbInfo.getDriverClassName())) {
    			driverClassName = DB_TYPE.getDriverClassName(this.dbInfo.getDbType());
    		}
    		
    		if (ObjectUtil.isNotEmpty(this.dbInfo.getPoolName())) {
    			hds.setPoolName(this.dbInfo.getPoolName() + "_DB_POOL");
    		}
    		
    		hds.setDriverClassName(driverClassName);
    		hds.setJdbcUrl(url);
    		hds.setUsername(username);
    		hds.setPassword(password);

    		hds.setAutoCommit(true);		/* auto-commit설정 (default: true) */
    		hds.setMinimumIdle(1);			/* 아무런 일을 하지않아도 Connection 유지 개수 (default: same as maximumPoolSize)*/
    		hds.setMaximumPoolSize(10);		/* 최대 Connection 개수 (default: 10) */
    		//hds.setConnectionTestQuery(validationQuery);	/* 커넥션 pool에서 커넥션을 획득하기전에 살아있는 커넥션인지 확인 (default: none) */
    		hds.setMaxLifetime(1800000);	/* Connection 최대 생명주기, 30~60분을 권장 (default: 30분) */
    		hds.setConnectionTimeout(300000);	/* Connection 연결 시도 Timeout (default:30초) */

    		hds.addDataSourceProperty("dataSource.cachePrepStmts", "true");
    		hds.addDataSourceProperty("dataSource.prepStmtCacheSize", "250");
    		hds.addDataSourceProperty("dataSource.prepStmtCacheSqlLimit", "2048");
    		hds.addDataSourceProperty("dataSource.useServerPrepStmts", "true");
    		hds.addDataSourceProperty("autoReconnect", "true");

    		ds = hds;
    		dataSource = ds;
    		} finally {
        		hds.close();
    		}
        }
        
        return ds;
    }

	public JdbcTemplate getTemplate() {
		return template;
	}

	public void setTemplate(JdbcTemplate template) {
		this.template = template;
	}

	public MKTDBInfoDTO getDbInfo() {
		return dbInfo;
	}

	public void setDbInfo(MKTDBInfoDTO dbInfo) {
		this.dbInfo = dbInfo;
	}

	public DataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
    
    
}
