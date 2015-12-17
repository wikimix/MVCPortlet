package com.liferay.docs.guestbook.service.permission;

import com.liferay.docs.guestbook.model.Guestbook;
import com.liferay.docs.guestbook.service.GuestbookLocalServiceUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.security.auth.PrincipalException;
import com.liferay.portal.security.permission.PermissionChecker;

/**
 * This class is similar to GuestbookModelPermission.java. The difference is, of course, that you supply the primary key of the entity you’re checking permissions for,
 * which in this case is the guestbookId. You have the same two methods, one of which throws an exception if there is no permission, 
 * while the other returns a boolean denoting whether the current user has permission. 
 * Note also that you have to retrieve the entity to verify that it exists (if it doesn’t, an exception is thrown)
 */

public class GuestbookPermission {
	public static void check(PermissionChecker permissionChecker, long guestbookId, String actionId)
			throws PortalException, SystemException {

		if (!contains(permissionChecker, guestbookId, actionId)) {
			throw new PrincipalException();
		}
	}

	public static boolean contains(PermissionChecker permissionChecker, long guestbookId, String actionId)
			throws PortalException, SystemException {

		Guestbook guestbook = GuestbookLocalServiceUtil.getGuestbook(guestbookId);

		return permissionChecker.hasPermission(guestbook.getGroupId(), Guestbook.class.getName(),
				guestbook.getGuestbookId(), actionId);

	}
}