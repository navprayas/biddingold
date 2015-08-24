window.onresize= function()
{
    ZWWin.docDimensions = ZWWin.findDocumentDimensions();
    ZWWin.winDimensions = ZWWin.findWindowDimensions();
};
var ZWWin = {
    docDimensions : null,
    winDimensions : null,

    getWindowDimensions : function()
    {
        if (!ZWWin.winDimensions) ZWWin.winDimensions = ZWWin.findWindowDimensions();
        return ZWWin.winDimensions;
    },

    findWindowDimensions : function()
    {
        var x,y;
        if (self.innerHeight) // all except Explorer
        {
            x = self.innerWidth;
            y = self.innerHeight;
        }
        else if (document.documentElement && document.documentElement.clientHeight)
            // Explorer 6 Strict Mode
        {
            x = document.documentElement.clientWidth;
            y = document.documentElement.clientHeight;
        }
        else if (document.body) // other Explorers
        {
            x = document.body.clientWidth;
            y = document.body.clientHeight;
        }
        return {"width":x, "height":y};
    },

    getDocumentDimensions : function ()
    {
        if (!ZWWin.docDimensions) ZWWin.docDimensions = ZWWin.findDocumentDimensions();
        return ZWWin.docDimensions;
    },

    findDocumentDimensions : function ()
    {
        var x,y;
        var test1 = document.body.scrollHeight;
        var test2 = document.body.offsetHeight
        if (test1 > test2) // all but Explorer Mac
        {
            x = document.body.scrollWidth;
            y = document.body.scrollHeight;
        }
        else
        {
            // Explorer Mac; would also work in:
            // Explorer 6 Strict, Mozilla and Safari
            x = document.body.offsetWidth;
            y = document.body.offsetHeight;
        }
        return {"width":x, "height":y};
    },
    //usage: ZWWin.getCenteredTopLeft( {"width":200, "height":400} );
    getCenteredTopLeft : function (params)
    {
        var width   = params.width;
        var height  = params.height;
        var dim     = ZWWin.getWindowDimensions();
        var hScroll = 0;
        var vScroll = 0;
        var hPos    = Math.round(hScroll+((dim.width-width)/2));
        var vPos    = Math.round(vScroll+((dim.height-height)/2));
        var left    = (hPos < 0)?0:hPos;
        var top     = (vPos < 0)?0:vPos;
        return {"top":top, "left":left};
    },
    //usage: ZWWin.removeElementbyId('maindiv');
    removeElementbyId : function (element_name)
    {
        d = document.getElementById(element_name);
        p = d.parentNode ? d.parentNode : d.parentElement;
        p.removeChild( d );
    }
};

var ZWDrag = {
    BIG_Z_INDEX : 10000,
    LAST_Z_INDEX : 10001,
    isDragging : false,
    itemindrag : null,
    mouseXinit : null,
    mouseYinit : null,
    lastdragged : null,

    makeDraggable : function(draggableitem,itemhandle) {
        itemhandle.draggableitem   = draggableitem;
        itemhandle.onmousedown     = ZWDrag.onMouseDown;
        itemhandle.style["cursor"]="move";

        initPosition = ZWDragUtils.findPos(draggableitem);
        draggableitem.initPositionX= initPosition.x;
        draggableitem.initPositionY= initPosition.y;
        draggableitem.style["position"]="absolute";
        draggableitem.style["left"]= initPosition.x+"px";
        draggableitem.style["top"]= initPosition.y+"px";
        draggableitem.width = parseInt(draggableitem.style["width"]);
        draggableitem.height= parseInt(draggableitem.style["height"]);
        draggableitem.originalZIndex  = draggableitem.style["zIndex"];
        draggableitem.originalOpacity = draggableitem.style["opacity"];
    },

    onMouseDown : function(event) {

        event = ZWDragUtils.fixEvent(event);
        targ  = ZWDragUtils.findTarget(event);

        while (!targ.draggableitem && targ!=null)
            targ = targ.parentNode ? targ.parentNode : targ.parentElement;
        if (targ==null) return false;
        
        if (ZWDrag.lastdragged)
            ZWDrag.lastdragged.style["zIndex"]  = ZWDrag.lastdragged.originalZIndex;

        ditem = targ.draggableitem;
        ditem.originalLeft = parseInt(ditem.style["left"]);
        ditem.originalTop  = parseInt(ditem.style["top"]);

        document.onmousemove = ZWDrag.onMouseMove;
        document.onmouseup = ZWDrag.onMouseUp;
        ZWDrag.itemindrag = ditem;
        ZWDrag.isDragging = true;
        ZWDrag.mouseXinit = event.clientX;
        ZWDrag.mouseYinit = event.clientY;

        return false;
    },

    onMouseMove : function(event) {
        event = ZWDragUtils.fixEvent(event);
        if (ZWDrag.isDragging)
        {
            ditem = ZWDrag.itemindrag;
            ditem.style["zIndex"]  = ZWDrag.BIG_Z_INDEX;
            ditem.style["opacity"] = 0.75;
            ZWDragUtils.repositionItem(event,ditem);
        }

        return false;
    },

    onMouseUp : function(event) {
        event = ZWDragUtils.fixEvent(event);

        if (ZWDrag.itemindrag)
        {
            ditem = ZWDrag.itemindrag;
//            ditem.style["zIndex"] = ditem.originalZIndex;
            ditem.style["zIndex"] = ZWDrag.LAST_Z_INDEX;
            ditem.style["opacity"]= ditem.originalOpacity;
            ZWDrag.lastdragged = ditem;
        }


        ZWDrag.itemindrag = null;
        ZWDrag.isDragging = false;
        ZWDrag.mouseXinit = null;
        ZWDrag.mouseYinit = null;
        document.onmousemove = null;
        document.onmouseup = null;

        return false;
    }

};

var ZWDragUtils = {

    fixEvent : function (e) {
         return (!e) ? window.event : e;
    },

    findPos : function (obj) {
        var curleft = curtop = 0;
        if (obj.offsetParent) {
            curleft = obj.offsetLeft
            curtop = obj.offsetTop
            while (obj = obj.offsetParent) {
                curleft += obj.offsetLeft
                curtop += obj.offsetTop
            }
        }
        return {"x":curleft, "y":curtop};
    },

    findTarget : function (e) {
        if (e.target) targ = e.target;
        else if (e.srcElement) targ = e.srcElement;
        if (targ.nodeType == 3) // defeat Safari bug
        targ = targ.parentNode;
        return targ;
    },

    repositionItem : function (event,ditem) {
        eventx    = event.clientX;
        eventy    = event.clientY;

        newleft   = (ditem.originalLeft + eventx - ZWDrag.mouseXinit)*1;
        newtop    = (ditem.originalTop + eventy - ZWDrag.mouseYinit)*1;

        ditem.style["left"] = newleft+"px";
        ditem.style["top"]  = newtop+"px";
    }

};

function ZWDOMElement(txt)
{
    var o = new Object();
    o.elementname   = txt;
    o.attributes    = new Object();
    o.innerHTML        = '';
    o.innerText        = '';
    o.createElement = function()
    {
        var attribute_str = '';
        var css_style_str = '';
        for(attribute_name in o.attributes)
        {
            if (attribute_name.toLowerCase() != 'style')
                attribute_str+= attribute_name+"='"+escape(o.attributes[attribute_name])+"'";
            else
                css_style_str= o.attributes[attribute_name];
        }

        var element;
        try
        {
            element = document.createElement("<"+o.elementname+" "+attribute_str);//IE
        }
        catch (e)
        {
            element = document.createElement( o.elementname );
            for(attribute_name in o.attributes)
                element.setAttribute( attribute_name , o.attributes[attribute_name] );
        }
        if (css_style_str.length>0)
            element.style.cssText=css_style_str;
        if (o.innerHTML.length>0)
            element.innerHTML = o.innerHTML;
        else if (o.innerText.length>0)
            element.appendChild( document.createTextNode(o.innerText) );
        return element;
    }

    o.setAttribute = function(attribute,attribute_value)
    {
        o.attributes[attribute] = attribute_value;
    }
    return o;
}

//-------------------------------------------------------------------------------------------------

var ZWDialog = {
    windowid : 0,
    Close : function (e){
        var e = ZWDragUtils.fixEvent(e);
        var d = ZWDragUtils.findTarget(e);

        var startswith='zd_dlg_dialog_';
        while(d)
        {
            if (d.id.substring(0,startswith.length)==startswith)
            {
                ZWWin.removeElementbyId(d.id);
                ZWWin.removeElementbyId( "zd_dlg_transp_"+d.id.substring(startswith.length) );//grey background
                return;
            }
            d = d.parentNode ? d.parentNode : d.parentElement;
        }
    },
    Alert : function (dlg_body,dlg_title, w, h, t, l) {

        //set defaults
        dlg_body  = (dlg_body ) ? dlg_body  : "default message";
        dlg_title = (dlg_title) ? dlg_title : "Bid"  ;//default title
        w = (w) ? w : 400;
        h = (h) ? h : 110;
        if (!t && !l) {
            c = ZWWin.getCenteredTopLeft( {"width":w, "height":h} );
            t = (t) ? t : c.top;
            l = (l) ? l : c.left;
        }
        
        //build dialog ui
        var id= ZWDialog.windowid++;
        var hh= 26;//handleheight
        var x = "ZWDialog.Close(event);"
        var r = '';
        r+="<div style='border:1px solid #999; font-family: Verdana; font-size:10pt;'>";
        r+=    "<div style='height:"+hh+"px; background:#9cba5a;' id =zd_dlg_handle_"+id+">";
        r+=      "<div style='float:right;padding:5px;'>";
        r+=        "<a href='javascript:void(0);' onclick='"+x+"' style='text-decoration: none; color:#000'>";
        r+=           "<img src='images/closelable.jpg' width=31 height=17 border=0 />";
        r+=        "</a>";
        r+=      "</div>";
        r+=      "<div style='padding:5px; color:#fff'>";
        r+=        dlg_title;
        r+=      "</div>";
        r+=    "</div>";
        r+=    "<div style='border-top: 1px solid #999;height:"+(h-hh-3)+"px;background:#fff;'>";//3 1px borders
        r+=      "<div style='font:12px calibri;'>";
        r+=        dlg_body;
        r+=      "</div>";
        r+=    "</div>";
        r+="</div>";

        //make draggable with dialog container and handle
        var div = ZWDOMElement("div");
        div.setAttribute("style", "width:"+w+"px; top:"+c.top+"px; left:"+c.left+"px;position:absolute;z-index:"+(1001+id));
        div.setAttribute("id"   , "zd_dlg_dialog_"+id);
        div.innerHTML = r;
        document.body.appendChild( div.createElement() );

        var dialog = document.getElementById( 'zd_dlg_dialog_'+id );
        var handle = document.getElementById( 'zd_dlg_handle_'+id );
        ZWDrag.makeDraggable( dialog, handle );
    },
    Alert2 : function (dlg_body,dlg_title, w, h, t, l) {

         //set defaults
        dlg_body  = (dlg_body ) ? dlg_body  : "Bid Approval :  OTHERS ";
        dlg_title = (dlg_title) ? dlg_title : "Bid Approval :  OTHERS "  ;//default title
        w = (w) ? w : 400;
        h = (h) ? h : 150;
        if (!t && !l) {
            c = ZWWin.getCenteredTopLeft( {"width":w, "height":h} );
            t = (t) ? t : c.top;
            l = (l) ? l : c.left;
        }
        
        //build dialog ui
        var id= ZWDialog.windowid++;
        var hh= 26;//handleheight
        var x = "ZWDialog.Close(event);"
        var r = '';
        r+="<div style='border:1px solid #999; font-family: Verdana; font-size:10pt;'>";
        r+=    "<div style='height:"+hh+"px; background:#9cba5a;' id =zd_dlg_handle_"+id+">";
        r+=      "<div style='float:right;padding:5px;'>";
        r+=        "<a href='javascript:void(0);' onclick='"+x+"' style='text-decoration: none; color:#000'>";
        r+=           "<img src='images/closelable.jpg' width=31 height=17 border=0 />";
        r+=        "</a>";
        r+=      "</div>";
        r+=      "<div style='padding:5px; color:#fff'>";
        r+=        dlg_title;
        r+=      "</div>";
        r+=    "</div>";
        r+=    "<div style='border-top: 1px solid #999;height:"+(h-hh-3)+"px;background:#fff;'>";//3 1px borders
        r+=      "<div style='font:12px calibri;'>";
        r+=        dlg_body;
        r+=      "</div>";
        r+=    "</div>";
        r+="</div>";

        //make draggable with dialog container and handle
        var div = ZWDOMElement("div");
        div.setAttribute("style", "width:"+w+"px; top:"+c.top+"px; left:"+c.left+"px;position:absolute;z-index:"+(1001+id));
        div.setAttribute("id"   , "zd_dlg_dialog_"+id);
        div.innerHTML = r;
        document.body.appendChild( div.createElement() );

        var dialog = document.getElementById( 'zd_dlg_dialog_'+id );
        var handle = document.getElementById( 'zd_dlg_handle_'+id );
        ZWDrag.makeDraggable( dialog, handle );

    },
	Alert3 : function (dlg_body,dlg_title, w, h, t, l) {

        //set defaults
        dlg_body  = (dlg_body ) ? dlg_body  : "Bid Approval :Reject";
        dlg_title = (dlg_title) ? dlg_title : "Bid Approval :Reject"  ;//default title
        w = (w) ? w : 400;
        h = (h) ? h : 110;
        if (!t && !l) {
            c = ZWWin.getCenteredTopLeft( {"width":w, "height":h} );
            t = (t) ? t : c.top;
            l = (l) ? l : c.left;
        }
        
        //build dialog ui
        var id= ZWDialog.windowid++;
        var hh= 26;//handleheight
        var x = "ZWDialog.Close(event);"
        var r = '';
        r+="<div style='border:1px solid #999; font-family: Verdana; font-size:10pt;'>";
        r+=    "<div style='height:"+hh+"px; background:#9cba5a;' id =zd_dlg_handle_"+id+">";
        r+=      "<div style='float:right;padding:5px;'>";
        r+=        "<a href='javascript:void(0);' onclick='"+x+"' style='text-decoration: none; color:#000'>";
        r+=           "<img src='images/closelable.jpg' width=31 height=17 border=0 />";
        r+=        "</a>";
        r+=      "</div>";
        r+=      "<div style='padding:5px; color:#fff'>";
        r+=        dlg_title;
        r+=      "</div>";
        r+=    "</div>";
        r+=    "<div style='border-top: 1px solid #999;height:"+(h-hh-3)+"px;background:#fff;'>";//3 1px borders
        r+=      "<div style='font:12px calibri;'>";
        r+=        dlg_body;
        r+=      "</div>";
        r+=    "</div>";
        r+="</div>";

        //make draggable with dialog container and handle
        var div = ZWDOMElement("div");
        div.setAttribute("style", "width:"+w+"px; top:"+c.top+"px; left:"+c.left+"px;position:absolute;z-index:"+(1001+id));
        div.setAttribute("id"   , "zd_dlg_dialog_"+id);
        div.innerHTML = r;
        document.body.appendChild( div.createElement() );

        var dialog = document.getElementById( 'zd_dlg_dialog_'+id );
        var handle = document.getElementById( 'zd_dlg_handle_'+id );
        ZWDrag.makeDraggable( dialog, handle );
    },
	Alert4 : function (dlg_body,dlg_title, w, h, t, l) {

        //set defaults
        dlg_body  = (dlg_body ) ? dlg_body  : "Bid Approval :Reject";
        dlg_title = (dlg_title) ? dlg_title : "Bid Approval :Reject"  ;//default title
        w = (w) ? w : 400;
        h = (h) ? h : 210;
        if (!t && !l) {
            c = ZWWin.getCenteredTopLeft( {"width":w, "height":h} );
            t = (t) ? t : c.top;
            l = (l) ? l : c.left;
        }
        
        //build dialog ui
        var id= ZWDialog.windowid++;
        var hh= 26;//handleheight
        var x = "ZWDialog.Close(event);"
        var r = '';
        r+="<div style='border:1px solid #999; font-family: Verdana; font-size:10pt;'>";
        r+=    "<div style='height:"+hh+"px; background:#9cba5a;' id =zd_dlg_handle_"+id+">";
        r+=      "<div style='float:right;padding:5px;'>";
        r+=        "<a href='javascript:void(0);' onclick='"+x+"' style='text-decoration: none; color:#000'>";
        r+=           "<img src='images/closelable.jpg' width=31 height=17 border=0 />";
        r+=        "</a>";
        r+=      "</div>";
        r+=      "<div style='padding:5px; color:#fff'>";
        r+=        dlg_title;
        r+=      "</div>";
        r+=    "</div>";
        r+=    "<div style='border-top: 1px solid #999;height:"+(h-hh-3)+"px;background:#fff;'>";//3 1px borders
        r+=      "<div style='font:12px calibri;'>";
        r+=        dlg_body;
        r+=      "</div>";
        r+=    "</div>";
        r+="</div>";

        //make draggable with dialog container and handle
        var div = ZWDOMElement("div");
        div.setAttribute("style", "width:"+w+"px; top:"+c.top+"px; left:"+c.left+"px;position:absolute;z-index:"+(1001+id));
        div.setAttribute("id"   , "zd_dlg_dialog_"+id);
        div.innerHTML = r;
        document.body.appendChild( div.createElement() );

        var dialog = document.getElementById( 'zd_dlg_dialog_'+id );
        var handle = document.getElementById( 'zd_dlg_handle_'+id );
        ZWDrag.makeDraggable( dialog, handle );
    },
	Alert5 : function (dlg_body,dlg_title, w, h, t, l) {

        //set defaults
        dlg_body  = (dlg_body ) ? dlg_body  : "Bid Approval :Reject";
        dlg_title = (dlg_title) ? dlg_title : "Bid Approval :Reject"  ;//default title
        w = (w) ? w : 400;
        h = (h) ? h : 170;
        if (!t && !l) {
            c = ZWWin.getCenteredTopLeft( {"width":w, "height":h} );
            t = (t) ? t : c.top;
            l = (l) ? l : c.left;
        }
        
        //build dialog ui
        var id= ZWDialog.windowid++;
        var hh= 26;//handleheight
        var x = "ZWDialog.Close(event);"
        var r = '';
        r+="<div style='border:1px solid #999; font-family: Verdana; font-size:10pt;'>";
        r+=    "<div style='height:"+hh+"px; background:#9cba5a;' id =zd_dlg_handle_"+id+">";
        r+=      "<div style='float:right;padding:5px;'>";
        r+=        "<a href='javascript:void(0);' onclick='"+x+"' style='text-decoration: none; color:#000'>";
        r+=           "<img src='images/closelable.jpg' width=31 height=17 border=0 />";
        r+=        "</a>";
        r+=      "</div>";
        r+=      "<div style='padding:5px; color:#fff'>";
        r+=        dlg_title;
        r+=      "</div>";
        r+=    "</div>";
        r+=    "<div style='border-top: 1px solid #999;height:"+(h-hh-3)+"px;background:#fff;'>";//3 1px borders
        r+=      "<div style='font:12px calibri;'>";
        r+=        dlg_body;
        r+=      "</div>";
        r+=    "</div>";
        r+="</div>";

        //make draggable with dialog container and handle
        var div = ZWDOMElement("div");
        div.setAttribute("style", "width:"+w+"px; top:"+c.top+"px; left:"+c.left+"px;position:absolute;z-index:"+(1001+id));
        div.setAttribute("id"   , "zd_dlg_dialog_"+id);
        div.innerHTML = r;
        document.body.appendChild( div.createElement() );

        var dialog = document.getElementById( 'zd_dlg_dialog_'+id );
        var handle = document.getElementById( 'zd_dlg_handle_'+id );
        ZWDrag.makeDraggable( dialog, handle );
    },
	Alert6 : function (dlg_body,dlg_title, w, h, t, l) {

        //set defaults
        dlg_body  = (dlg_body ) ? dlg_body  : "Bid Approval :Change Amount";
        dlg_title = (dlg_title) ? dlg_title : "Bid Approval :Change Amount"  ;//default title
        w = (w) ? w : 400;
        h = (h) ? h : 210;
        if (!t && !l) {
            c = ZWWin.getCenteredTopLeft( {"width":w, "height":h} );
            t = (t) ? t : c.top;
            l = (l) ? l : c.left;
        }
        
        //build dialog ui
        var id= ZWDialog.windowid++;
        var hh= 26;//handleheight
        var x = "ZWDialog.Close(event);"
        var r = '';
        r+="<div style='border:1px solid #999; font-family: Verdana; font-size:10pt;'>";
        r+=    "<div style='height:"+hh+"px; background:#9cba5a;' id =zd_dlg_handle_"+id+">";
        r+=      "<div style='float:right;padding:5px;'>";
        r+=        "<a href='javascript:void(0);' onclick='"+x+"' style='text-decoration: none; color:#000'>";
        r+=           "<img src='images/closelable.jpg' width=31 height=17 border=0 />";
        r+=        "</a>";
        r+=      "</div>";
        r+=      "<div style='padding:5px; color:#fff'>";
        r+=        dlg_title;
        r+=      "</div>";
        r+=    "</div>";
        r+=    "<div style='border-top: 1px solid #999;height:"+(h-hh-3)+"px;background:#fff;'>";//3 1px borders
        r+=      "<div style='font:12px calibri;'>";
        r+=        dlg_body;
        r+=      "</div>";
        r+=    "</div>";
        r+="</div>";

        //make draggable with dialog container and handle
        var div = ZWDOMElement("div");
        div.setAttribute("style", "width:"+w+"px; top:"+c.top+"px; left:"+c.left+"px;position:absolute;z-index:"+(1001+id));
        div.setAttribute("id"   , "zd_dlg_dialog_"+id);
        div.innerHTML = r;
        document.body.appendChild( div.createElement() );

        var dialog = document.getElementById( 'zd_dlg_dialog_'+id );
        var handle = document.getElementById( 'zd_dlg_handle_'+id );
        ZWDrag.makeDraggable( dialog, handle );
    },
}

/*
function open_grey_screen()
{
    dim = ZWWin.getDocumentDimensions();
    style='display:block;width:100%;height:'+dim.height+'px;background-color:#000000;filter:alpha(opacity=50);opacity:0.5;-moz-opacity:0.5;position:absolute;top:0px;left:0px;z-index:1000';
    divid='grey_screen_div_'+id;
    obj = ZWDOMelement("DIV");
    obj.setAttribute("style",style);
    document.body.appendChild( obj.createElement() );
}
*/