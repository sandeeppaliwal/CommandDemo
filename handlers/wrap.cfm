﻿<cfparam name="ideeventinfo">
<cfset xmlvar = xmlParse(ideeventinfo)>

<!--- Step 1
      Get callback URL from ideeventinfo xml
 --->
<cfset callbackurl = xmlvar.event.ide.callbackurl.xmlText>


<!--- Step 2
      Create XML to send comman to IDE - inserttext in this case
 --->
<cfsavecontent variable="callbackxml" >
<cfoutput>
<response>
    <ide >          
        <commands>
        	<command type="inserttext">
					<params>
						
					<!--- set insert mode as wrap --->
					<param key="insertmode" value="wrap" />
					
					<param key="starttext">
						<![CDATA[Begin Text Before Selection--]]>
					</param>
					<param key="endtext">
						<![CDATA[--End Text After Selection]]>
					</param>
				</params>
	 			</command>
        </commands>
    </ide>
</response>

</cfoutput>

</cfsavecontent>
<!--- Step 3 Execute Callback command --->
<cfhttp method="post"  url="#callbackurl#" result="callbackresponse">
	<cfhttpparam type="body" value="#callbackxml#" >
    <cfhttpparam type="header" name="mimetype" value="text/xml" /> 
</cfhttp>

<cfdump var="#callbackresponse#">

