<cfparam name="ideeventinfo">
<cfset xmlvar = xmlParse(ideeventinfo)>

<!--- Step 1
      Get callback URL from ideeventinfo xml
 --->
<cfset callbackurl = xmlvar.event.ide.callbackurl.xmlText>

<cfset projectlocation = xmlvar.event.ide.editor.file.XMLAttributes.projectlocation>
<cfset projectName = xmlvar.event.ide.editor.file.XMLAttributes.project>
<cffile action="write" file="#projectlocation#/test123.cfm" 
        output="test file for open file command
		Cursor should be on this line
		test file end" >
		


<!--- Step 2
      Create XML to send comman to IDE - openfile in this case
 --->
<cfsavecontent variable="callbackxml" >
<cfoutput>
<response>
    <ide >          
        <commands>    
		  <!--- Refresh file before opening it --->
		    <command type="refreshproject">
                <params>
                    <param key="projectname" value="#projectName#" />                        
                </params>                
            </command>      
		  <!--- Command to open file --->
		  	<command type="openfile">
                
				 <params>
                    <param key="filename" value="#projectlocation#/test123.cfm" />                        
                    <param key="linenumber" value="2" />                        
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

<cfoutput>File test123.cfm should be open with cursor on second line.</cfoutput><br>
<cfoutput>Command Result </cfoutput><br>
<cfdump var="#callbackresponse#">

