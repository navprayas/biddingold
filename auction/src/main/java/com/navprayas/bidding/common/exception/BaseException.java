package com.navprayas.bidding.common.exception;

/**
 * Base Exception Class.
 *
 * @author 30076192
 */
@SuppressWarnings("serial")
public class BaseException extends RuntimeException
{

    /**
     * Exception Number, Used to find appropriate exception resolver.
     * Also use to pick appropriate message number from resource bundle.
     */
    private String exNum;

    /**
     * Objects used to replace message token while displaying message
     * to user.
     */
    private Object[] messageVar;

    /**
     * Boolean flag to indicate the exception is handled.s
     */
    private boolean handled;

    /**
     * 
     * 
     * @param ex Exception.
     * @param exNum exception number.
     */
    public BaseException(Throwable ex, String exNum)
    {
        super(ex);
        this.exNum = exNum;
        this.handled = false;
    }

    /**
     * 
     * 
     * @param message Exception message.
     * @param ex Exception.
     * @param exNum exception number.
     */
    public BaseException(String message, Throwable ex, String exNum)
    {
        super(message, ex);
        this.exNum = exNum;
        this.handled = false;
    }

    /**
     * 
     * 
     * @param message Exception message.
     * @param exNum exception number.
     */
    public BaseException(String message, String exNum)
    {
        super(message);
        this.exNum = exNum;
        this.handled = false;
    }

    /**
     * 
     * @param exNum exception number.
     */
    public BaseException(String exNum)
    {
        super();
        this.exNum = exNum;
        this.handled = false;
    }

    /**
     * TODO
     *
     * @return DOCUMENT ME!
     */
    public String getExNum()
    {

        return exNum;
    }

    /**
     * TODO
     *
     * @return DOCUMENT ME!
     */
    public Object[] getMessageVar()
    {

        return messageVar;
    }

    /**
     * TODO
     *
     * @param messageVar DOCUMENT ME!
     */
    public void setMessageVar(Object[] messageVar)
    {

        this.messageVar = messageVar;
    }

    /**
     * TODO
     *
     * @return DOCUMENT ME!
     */
    public boolean isHandled()
    {

        return handled;
    }

    /**
     * TODO
     *
     * @param handled DOCUMENT ME!
     */
    public void setHandled(boolean handled)
    {

        this.handled = handled;
    }
}