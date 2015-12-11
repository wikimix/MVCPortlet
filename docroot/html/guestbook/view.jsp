<%@include file="/html/init.jsp"%>
<jsp:useBean id="entries" class="java.util.ArrayList" scope="request" />

<%
    long guestbookId = Long.valueOf((Long) renderRequest
            .getAttribute("guestbookId"));
%>

<!-- 
The first thing this does is declare that you’re using a navigation element, and that you want it to use tabs.  
These are implemented as a CSS class in Liferay’s default theme. 
-->

<aui:nav cssClass="nav-tabs">

<!--
Next is a scriptlet that gets all the Guestbook entities out of the database and loops through them. 
During each loop, it checks to see if the current guestbook in the loop has the same ID as the one the user has selected. 
If it is, it sets a String variable for the CSS class to active.
-->
	<%
        List<Guestbook> guestbooks = GuestbookLocalServiceUtil
                    .getGuestbooks(scopeGroupId);
            for (int i = 0; i < guestbooks.size(); i++) {
                Guestbook curGuestbook = (Guestbook) guestbooks.get(i);

                String cssClass = StringPool.BLANK;

                if (curGuestbook.getGuestbookId() == guestbookId) {
                    cssClass = "active";
                }
    %>

	<!--  
A render URL is then created for the guestbook, and then a navigation item is created that uses the CSS class as a parameter. 
In this way, the loop builds a list of navigation items on the page that are styled as tabs, 
and the currently selected tab gets an active class so it shows as selected.
-->

	<portlet:renderURL var="viewPageURL">
		<portlet:param name="mvcPath" value="/html/guestbook/view.jsp" />
		<portlet:param name="guestbookId"
			value="<%=String.valueOf(curGuestbook.getGuestbookId())%>" />
	</portlet:renderURL>

	<aui:nav-item cssClass="<%=cssClass%>" href="<%=viewPageURL%>"
		label="<%=HtmlUtil.escape(curGuestbook.getName())%>" />

	<%
        }
    %>

</aui:nav>

<!-- 
Next, you’ll add the button row, which is almost the same as the one you had in the previous version of this portlet
This is the same as the previous version of the button row, except for the additional Add Guestbook button. This points to a new JSP which you’ll create next.
-->

<aui:button-row cssClass="guestbook-buttons">

	<portlet:renderURL var="addGuestbookURL">
		<portlet:param name="mvcPath"
			value="/html/guestbook/edit_guestbook.jsp" />
	</portlet:renderURL>

	<portlet:renderURL var="addEntryURL">
		<portlet:param name="mvcPath" value="/html/guestbook/edit_entry.jsp" />
		<portlet:param name="guestbookId"
			value="<%=String.valueOf(guestbookId)%>" />
	</portlet:renderURL>

	<aui:button onClick="<%=addGuestbookURL.toString()%>"
		value="Add Guestbook" />
	<aui:button onClick="<%=addEntryURL.toString()%>" value="Add Entry"></aui:button>

</aui:button-row>

<!-- 
The last thing to be added is the new Search Container that uses your service layer to retrieve guestbook entries:
Again, this Search Container is almost the same as the previous version, except for the parameters in the liferay-ui:search-container-results  tag.
The results parameter now calls your service layer to retrieve guestbook entries and the total number of entries.
The same rows are displayed even though your entity also collects users’ email addresses,
because obviously you don’t want to publish email addresses on a web page: they’ll get harvested by spammers.
-->

<liferay-ui:search-container>
	<liferay-ui:search-container-results
		results="<%=EntryLocalServiceUtil.getEntries(scopeGroupId,
                        guestbookId, searchContainer.getStart(),
                        searchContainer.getEnd())%>"
		total="<%=EntryLocalServiceUtil.getEntriesCount()%>" />

	<liferay-ui:search-container-row
		className="com.liferay.docs.guestbook.model.Entry" modelVar="entry">

		<liferay-ui:search-container-column-text property="message" />

		<liferay-ui:search-container-column-text property="name" />

	</liferay-ui:search-container-row>

	<liferay-ui:search-iterator />
</liferay-ui:search-container>