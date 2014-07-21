<#assign id = args.htmlid>
<#assign jsid = args.htmlid?js_string>


<script type="text/javascript"  src="/share/res/js/yui-common.js"></script>
<script type="text/javascript">
var UpdateDownloadLink = function(e)
{
	var elements = YAHOO.util.Dom.getElementsByClassName("dldownload-${id}");
	for(var i=0;i<elements.length;i++)
	{
		var el = new YAHOO.util.Element(elements[i]);
		var currenthref = el.get("href");
		var substr = currenthref.split('?format=');
		var newurl = substr[0]+"?format="+YAHOO.util.Event.getTarget(e).value;		
		YAHOO.util.Dom.setAttribute(el,"href",newurl);					
	}
};
YAHOO.util.Event.on("${id}-formats-menu", 'change', UpdateDownloadLink);
</script>

<script type="text/javascript">//<![CDATA[
(function()
{
   var exporter = new Quanticate.dashlet.DataListExport("${jsid}").
                  setMessages(${messages});

   new Alfresco.widget.DashletResizer("${id}", "${instance.object.id}");
   new Alfresco.widget.DashletTitleBarActions("${args.htmlid}").setOptions(
   {
      actions:
      [
         {
            cssClass: "help",
            bubbleOnClick:
            {
               message: "${msg("dashlet.help")?js_string}"
            },
            tooltip: "${msg("dashlet.help.tooltip")?js_string}"
         }
      ]
   });
})();
//]]></script>

<div class="dashlet">
	<div class="title">${msg("header")}</div>

   <#if datalists?has_content>
     <div class="toolbar flat-button">
        <div>
          <span class="align-left yui-button yui-menu-button" id="${id}-formats">
             <span class="first-child">
                <button type="button" tabindex="0"></button>
             </span>
          </span>
          <select id="${id}-formats-menu">
          <#list formats as format>
             <option value="${format}">${msg("format." + format)}</option>
          </#list>
          </select>

          <div class="clear"></div>
        </div>
     </div>
   </#if>

	<div class="body scrollableList" <#if args.height??>style="height: ${args.height}px;"</#if>>
      <div style="margin: 0.4em">

      <#if datalists?has_content>
	     <#list datalists as datalist>		
            <div style="padding-bottom: 0.5em">
               <div id="list">
                 <#assign baseUrl="${url.context}/proxy/alfresco/com/quanticate/datalists/list/site/${site}/dataLists/${datalist.name}">
                 <a href="${baseUrl}?format=xls" class="dldownload-${id}">
				        ${(datalist.title!"")?html}
                 </a>
                <div class="description">${(datalist.description!"")?html}</div>
                <div class="links">
                   <#list formats as format>
                      <a href="${baseUrl}?format=${format}">${msg("format." + format)}</a> - 
                   </#list>
                   <a href="${url.context}/page/site/${site}/data-lists?list=${datalist.name?html}">${msg("dashlet.view_datalist")}</a>
                 </div>
              </div>        
		     </div>
	     </#list>
      <#else>
         <p>${msg("dashlet.no_datalists")}</p>
         <#if site??>
           <p>${msg("dashlet.link_datalists", "${url.context}/page/site/${site}/data-lists")}</p>
         </#if>
      </#if>

      </div>
    </div>
</div>
