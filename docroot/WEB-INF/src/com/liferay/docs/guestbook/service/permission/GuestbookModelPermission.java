package com.liferay.docs.guestbook.service.permission;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.security.auth.PrincipalException;
import com.liferay.portal.security.permission.PermissionChecker;

/**
 * This class defines two static methods (so you don’t have to instantiate the class) that encapsulate the model that you’re checking permissions for.
 * This makes it easier for you to include the proper permissions check later.
 * As you can see, Liferay’s PermissionChecker class does most of the work: all you have to do is feed it the proper resource and and action, 
 * such as ADD_ENTRY, and it can determine whether the permission exists or not.
 * There are two implementations here: a check method that throws an exception if the user does not have permission, 
 * and a contains method that returns a boolean that’s true if the user has permission and false if he or she does not.
 */

public class GuestbookModelPermission {

	public static final String RESOURCE_NAME = "com.liferay.docs.guestbook.model";

	public static void check(PermissionChecker permissionChecker, long groupId, String actionId)
			throws PortalException {

		if (!contains(permissionChecker, groupId, actionId)) {
			throw new PrincipalException();
		}
	}

	public static boolean contains(PermissionChecker permissionChecker, long groupId, String actionId) {

		return permissionChecker.hasPermission(groupId, RESOURCE_NAME, groupId, actionId);
	}
}
