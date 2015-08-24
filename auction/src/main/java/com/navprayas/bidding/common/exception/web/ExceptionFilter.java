package com.navprayas.bidding.common.exception.web;

import com.navprayas.bidding.common.exception.BaseException;
import com.navprayas.bidding.common.exception.ExceptionConstants;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;


/**
 * Web filter to handle exceptions.
 *
 * 
 */
public class ExceptionFilter implements Filter
{

    /**
     * Logger
     */
    private static final Logger _LOGGER = LoggerFactory.getLogger(ExceptionFilter.class);

    /**
     * TODO
     *
     * @param throwable DOCUMENT ME!
     *
     * @return DOCUMENT ME!
     */
    private BaseException getBaseException(Throwable throwable)
    {

    	Throwable tempThrowable = throwable;
    	BaseException baseException = null;
        while((tempThrowable != null))
        {
        	tempThrowable = tempThrowable.getCause();
        	if (tempThrowable instanceof BaseException) {
        		baseException = (BaseException) tempThrowable;
        		break;
        	}
        }

        return baseException;
    }

	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
        try
        {

            chain.doFilter(request, response);
        }
        catch(Throwable throwable)
        {

            _LOGGER.error("Unhandled Exception", throwable);

            BaseException baseException = null;
            
            baseException = getBaseException(throwable);

            if(baseException == null)
            {

                baseException = new BaseException(throwable,
                        ExceptionConstants.DEFAULT_EXCEPTION_NR);
            }      

            HttpServletRequest httpReq = (HttpServletRequest) request;
            httpReq.setAttribute("error", baseException.getMessage());
            System.out.println("Dispatch Request");
            httpReq.getRequestDispatcher("error").forward(request, response);
        }
		
	}
}