package com.navprayas.bidding.dwr;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

import org.directwebremoting.Container;
import org.directwebremoting.ServerContextFactory;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.event.ScriptSessionEvent;
import org.directwebremoting.event.ScriptSessionListener;
import org.directwebremoting.extend.ScriptSessionManager;
import org.directwebremoting.servlet.DwrServlet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DWRServletExtension extends DwrServlet {
	
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(DWRServletExtension.class);
	@Override
	 public void init(ServletConfig servletConfig)
	      throws ServletException {
	              super .init(servletConfig);
          Container container = ServerContextFactory.get().getContainer();
          ScriptSessionManager manager = container.getBean(ScriptSessionManager.class);
          ScriptSessionListener listener = new ScriptSessionListener() {
              public void sessionCreated(ScriptSessionEvent ev) {
                  HttpSession session = WebContextFactory.get().getSession();
                  String userName = (String) session.getAttribute("userName");
                  ev.getSession().setAttribute("userName", userName);
                  logger.debug("Script session created " + userName);
              }

              public void sessionDestroyed(ScriptSessionEvent ev) { 
            	  ev.getSession().removeAttribute("userName");
              }
          };
          manager.addScriptSessionListener(listener);        
	 }
}
