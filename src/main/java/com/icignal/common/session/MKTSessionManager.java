package com.icignal.common.session;

import java.util.HashMap;
import java.util.List;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpSession;

/*-
 * ==================================================
 *  Class Name  : BMWSessionManager.java
 *  Create Date : 2018. 1. 31.
 *  Create User : 이기오
 * ==================================================
 *  History
 * --------------------------------------------------
 *  Modify Date  | Modify User  | Description
 * -------------- -------------- --------------------
 *  2018. 1. 31.   이기오         최초작성
 * ==================================================
 * */
public class MKTSessionManager {
	private static volatile MKTSessionManager instance;
	static MKTSessionPool pool;

	public static MKTSessionManager getInstance() {
		if (instance == null) {
			synchronized (MKTSessionManager.class) {
				if (instance == null) {
					instance = new MKTSessionManager();
				}
			}
		}

		return instance;
	}

	public MKTSessionManager() {
		pool = MKTSessionPool.getInstance();
	}

	public void addSession(HttpSession session) {
		pool.addSession(session);
	}

	public void updateSession(HttpSession session) {
		pool.updateSession(session);
	}

	public void removeSession(HttpSession session) {
		pool.removeSession(session);
	}

	public HttpSession getSession(String id, boolean isSessionId) {
		return pool.getSession(id, isSessionId);
	}

	public List<HttpSession> getSessions(List<String> memIds) {
		return pool.getSessions(memIds);
	}

	public HttpSession getSession(HttpSession session) {
		return this.getSession(session.getId(), true);
	}

	public HashMap<String, HttpSession> getSessionPool() {
		return pool.getSessionPool();
	}

	public Set<String> getSessionIds() {
		return pool.getSessionIds();
	}

	public Set<Entry<String, HttpSession>> getSessionEntrys() {
		return pool.getSessionEntrys();
	}

	public void resetSessionPool() {
		pool.resetSessionPool();
	}

	public void printSessionPool() {
		pool.printSessionPool();
	}
}