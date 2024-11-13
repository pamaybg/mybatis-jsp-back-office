package com.icignal.core.database.dao;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import com.icignal.common.util.ObjectUtil;
import com.icignal.core.database.DynamicDBConfig;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;

public class DynamicDBDao {

	private JdbcTemplate jdbcTemplate;

	private DataSource dataSource;

	private MKTDBInfoDTO dbInfo;

	private String dbType;

	public DynamicDBDao(MKTDBInfoDTO dbInfo) {

		DynamicDBConfig conf = new DynamicDBConfig(dbInfo);

		this.jdbcTemplate = conf.JdbcTemplate();
		this.dataSource = conf.DataSource();

		this.dbInfo = dbInfo;
	}

	/**
	 * getDB Info
	 */
	public MKTDBInfoDTO getDbInfo() {

		return this.dbInfo;
	}

	/**
	 * jdbcTemplate
	 */
	public JdbcTemplate jdbcTemplate() {
		return this.jdbcTemplate;
	}

	/**
	 * dataSource
	 */
	public DataSource dataSource() {

		return this.dataSource;
	}

	/**
	 * getConnection
	 */
	public Connection getConnection() throws SQLException {

		return this.jdbcTemplate.getDataSource().getConnection();
	}

	/**
	 * getDbType
	 */
	public String getDbType() throws SQLException {

		if (dbType == null) {
			Connection conn = this.dataSource.getConnection();
			try {
				DatabaseMetaData meta = conn.getMetaData();
				this.dbType = meta.getDatabaseProductName().toUpperCase();

			} finally {
				conn.close();
			}
		}

		return dbType;
	}

	/**
	 * insert
	 */
	public void insert(String sql, Object parameterObject) {

		jdbcTemplate.update(sql, new Object[] { parameterObject });
	}

	/**
	 * insert
	 */
	public void insert(String sql) {

		jdbcTemplate.update(sql);
	}

	/**
	 * update
	 */
	public void update(String query, Object parameterObject) {
		jdbcTemplate.update(query, parameterObject);
	}

	/**
	 * update
	 */
	public void update(String query) {
		jdbcTemplate.update(query);
	}

	/**
	 * queryForObject 단일
	 * 
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	public Object queryForObject(Class<?> theClass, String sql, Object parameterObject)
			throws InstantiationException, IllegalAccessException {
		Object rtnValue = null;

		try {

			if (!theClass.isPrimitive()) {
				rtnValue = theClass.newInstance();
			}

			rtnValue = jdbcTemplate.queryForObject(sql, new Object[] { parameterObject }, theClass);

		} catch (EmptyResultDataAccessException e) {
			rtnValue = null;
		}

		return rtnValue;
	}

	/**
	 * queryForObject 단일
	 * 
	 * @throws InstantiationException
	 */
	public Object queryForObject(Class<?> theClass, String sql) throws InstantiationException, IllegalAccessException {
		Object rtnValue = null;

		try {

			/*
			 * if(!theClass.isPrimitive()) { rtnValue = theClass.newInstance(); }
			 */

			rtnValue = jdbcTemplate.queryForObject(sql, theClass);

		} catch (EmptyResultDataAccessException e) {
			rtnValue = null;
		}

		return rtnValue;
	}

	/**
	 * queryForMap 단일
	 */
	public Map queryForMap(String sql, Object parameterObject) {
		Map rtnValue = null;

		try {

			rtnValue = jdbcTemplate.queryForMap(sql, new Object[] { parameterObject });

		} catch (EmptyResultDataAccessException e) {
			rtnValue = null;
		}

		return rtnValue;
	}

	/**
	 * queryForMap 단일
	 */
	public Map queryForMap(String sql) {
		Map rtnValue = null;

		try {
			rtnValue = jdbcTemplate.queryForMap(sql);
		} catch (EmptyResultDataAccessException e) {
			rtnValue = null;
		}

		return rtnValue;
	}

	/**
	 * queryForList
	 */
	public List queryForList(String sql, Object parameterObject) {
		List rtnValue = null;

		rtnValue = jdbcTemplate.queryForList(sql, new Object[] { parameterObject });

		return rtnValue;
	}

	/**
	 * queryForList
	 */
	public List queryForList(String sql) {
		List rtnValue = null;

		rtnValue = jdbcTemplate.queryForList(sql);

		return rtnValue;
	}

	/**
	 * queryForList
	 */
	public List queryForList(String sql, Class<?> _class) {
		List<Object> rtnValue = new ArrayList<Object>();

		List<Map<String, Object>> rtnList = jdbcTemplate.queryForList(sql);

		if (ObjectUtil.isNotEmpty(rtnList)) {
			for (Map map : rtnList) {
				Object obj = ObjectUtil.convertMapToObject(map, _class);

				rtnValue.add(obj);
			}
		} else {
			rtnValue = null;
		}

		return rtnValue;
	}

	/**
	 * queryForListMap
	 */
	public List queryForListMap(String sql, Object parameterObject) {
		List<Map<String, Object>> rtnValue = null;

		rtnValue = jdbcTemplate.queryForList(sql, new Object[] { parameterObject });

		return rtnValue;
	}

	/**
	 * queryForListMap
	 */
	public List queryForListMap(String sql) {
		List<Map<String, Object>> rtnValue = null;

		rtnValue = jdbcTemplate.queryForList(sql);

		return rtnValue;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public DataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void setDbInfo(MKTDBInfoDTO dbInfo) {
		this.dbInfo = dbInfo;
	}

	public void setDbType(String dbType) {
		this.dbType = dbType;
	}

}