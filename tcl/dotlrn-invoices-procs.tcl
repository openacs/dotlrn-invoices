#  Copyright (C) 2005 Cognovis
#  This file is part of dotLRN.
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.

ad_library {

    the dotlrn applet for invoices

    @author Bjoern Kiesbye <bjoern_kiesbye@web.de>
    @version $Id: dotlrn-invoices.tcl
}


namespace eval dotlrn_invoices {}

ad_proc -public dotlrn_invoices::package_key {
} {
    What package does this applet deal with?
} {
    return "invoices"
}

ad_proc -public dotlrn_invoices::my_package_key {
} {
    What's my package key?
} {
    return "dotlrn-invoices"
}

ad_proc -public dotlrn_invoices::applet_key {
} {
    What's my applet key?
} {
    return "dotlrn_invoices"
}

ad_proc -public dotlrn_invoices::get_pretty_name {
} {
} {
    return "Invoices"
}

ad_proc -public dotlrn_invoices::add_applet {
} {
    Called for one time init - must be repeatable!
    @return new pkg_id or 0 on failure
} {

    # FIXME: won't work with multiple dotlrn instances Use the package_key
    # for the -url param - "/" are not allowed!

    set package_id 0

    dotlrn_applet::add_applet_to_dotlrn -applet_key [applet_key] -package_key [my_package_key]

}

ad_proc -public dotlrn_invoices::remove_applet {
} {
    One-time destroy for when the entire applet is removed from dotlrn.
} {
    ad_return_complaint 1 "[applet_key] remove_applet not implimented!"
}

ad_proc -public dotlrn_invoices::project_manager_create_helper {
    {-community_id:required}
    {-package_id:required}
} {
    A helper proc to create a calendar for a comm, returns the new calendar_id
} {
    return "00"
}

ad_proc -public dotlrn_invoices::add_applet_to_community {
    community_id
} {
    Add the Invoices applet to a specific dotlrn community
} {

#    if {![dotlrn::is_package_mounted -package_key project_manager]} {
    
#	    ad_return_complaint 1 "The Project Manager Applet has to be added to let this Applet work !!"
#    }
    
    

    set results [add_applet_to_community_helper \
		     -community_id $community_id
		]

    return [lindex $results 0]
}

ad_proc -public dotlrn_invoices::add_applet_to_community_helper {
    {-community_id:required}
} {
    Add the invoices applet to a specific dotlrn community

    @params community_id
} {
    # We don't want to create a new instance or mount a new site node
    # for this invoices, always using "/invoices"
    # Set up the invoices portlet for this portal/community

    set package_id [apm_package_id_from_key invoices]    
    set portal_id [dotlrn_community::get_portal_id \
		       -community_id $community_id \
		      ]

    # Add all portlets to the Portal.

    invoices_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id 

    invoices_list_portlet::add_self_to_page -portal_id $portal_id  -package_id $package_id 

    invoices_offers_portlet::add_self_to_page -portal_id $portal_id  -package_id $package_id 

    invoices_offers_project_portlet::add_self_to_page -portal_id $portal_id  -package_id $package_id 


    set admin_portal_id [dotlrn_community::get_admin_portal_id \
			     -community_id $community_id
			]

    invoices_admin_portlet::add_self_to_page -portal_id $admin_portal_id  -package_id $package_id 

    # this should return the package_id
    return $package_id
}

ad_proc -public dotlrn_invoices::remove_applet_from_community {
    community_id
} {
    remove the applet from the community
} {
    ad_return_complaint 1 "[applet_key] remove_applet_from_community not implimented!"
}

ad_proc -public dotlrn_invoices::add_user {
    user_id
} {
    Called once when a user is added as a dotlrn user.
    Create a private, personal, global Project Manager for the User if they don't have one and add it to the user's portal
} {
}

ad_proc -public dotlrn_invoices::remove_user {
    user_id
} {
    Remove a user from dotlrn
} {

    # Not yet implemented.
}

ad_proc -public dotlrn_invoices::add_user_to_community {
    community_id
    user_id
} {
    Add a user to a community
} {

    set package_id [dotlrn_community::get_applet_package_id -community_id $community_id -applet_key [applet_key]]
    set portal_id [dotlrn::get_portal_id -user_id $user_id]
    
    # use "append" here since we want to aggregate
    set param_action append

    # Add both portlets
    invoices_portlet::add_self_to_page \
        -portal_id $portal_id \
        -package_id $package_id \
        -param_action $param_action

    invoices_list_portlet::add_self_to_page \
        -portal_id $portal_id \
        -package_id $package_id \
        -param_action $param_action

    invoices_offers_portlet::add_self_to_page \
        -portal_id $portal_id \
        -package_id $package_id \
        -param_action $param_action

    invoices_offers_project_portlet::add_self_to_page \
	-portal_id $portal_id \
	-package_id $package_id \
	-param_action $param_action


}

ad_proc -public dotlrn_invoices::remove_user_from_community {
    community_id
    user_id
} {
    Remove a user from a community
} {
}

ad_proc -public dotlrn_invoices::add_portlet {
    portal_id
} {
    Set up default params for templates about to call add_portlet_helper

    @param portal_id
} {
    invoices_portlet::add_self_to_page \
	-portal_id $portal_id \
	-package_id 0
    
    invoices_list_portlet::add_self_to_page \
	-portal_id $portal_id \
	-package_id 0

    invoices_offers_portlet::add_self_to_page \
	-portal_id $portal_id \
	-package_id 0

    invoices_offers_project_portlet::add_self_to_page \
	-portal_id $portal_id \
	-package_id 0
}


ad_proc -public dotlrn_invoices::remove_portlet {
    portal_id
    args
} {
    A helper proc to remove the underlying portlet from the given portal.
    This is alot simpler than add_portlet.

    @param portal_id
    @param args An ns_set.
} {
    invoices_portlet::remove_self_from_page \
	-portal_id $portal_id \
	-package_id [ns_set get $args "package_id"]

    invoices_list_portlet::remove_self_from_page \
	-portal_id $portal_id \
	-package_id [ns_set get $args "package_id"]

    invoices_offers_portlet::remove_self_from_page \
	-portal_id $portal_id \
	-package_id [ns_set get $args "package_id"]

    invoices_offers_project_portlet::remove_self_from_page \
	-portal_id $portal_id \
	-package_id [ns_set get $args "package_id"]


}

ad_proc -public dotlrn_invoices::clone {
    old_community_id
    new_community_id
} {
    Clone this applet's content from the old community to the new one
} {
}

ad_proc -public dotlrn_invoices::change_event_handler {
    community_id
    event
    old_value
    new_value
} {
    listens for the following events: rename
} {
    switch $event {
	rename {

	    #	    handle_rename -community_id $community_id -old_value
	    #	$old_value -new_value $new_value
	}
    }
}

ad_proc -private dotlrn_invoices::handle_rename {
    {-community_id:required}
    {-old_value:required}
    {-new_value:required}
} {
    what to do in invoices when a dotlrn community is renamed
} {


}

# Some dotlrn_invoices specific procs

ad_proc -private dotlrn_invoices::upgrade {
    {-from_version_name:required }
    {-to_version_name:required }
} {
    Procedures to upgrade dotlrn-contacts
    
    @author Miguel Marin (miguelmarin@viaro.net)
    @author Viaro Networks www.viaro.net
} {
    apm_upgrade_logic \
	-from_version_name $from_version_name \
	-to_version_name $to_version_name \
	-spec {
	    0.1d 0.1d1 {
		# We are going to add invoice portlet to the 
		# templates
		
		db_foreach get_portal_templates { } {
		    invoices_portlet::add_self_to_page \
			-portal_id $portal_id \
			-package_id 0
		}
	    }
	    0.1d1 0.1d2 {
		# We are going to add invoice portlet to the 
		# templates
		
		db_foreach get_portal_templates { } {
		    invoices_portlet::add_self_to_page \
			-portal_id $portal_id \
			-package_id 0
		    
		    invoices_list_portlet::add_self_to_page \
			-portal_id $portal_id \
			-package_id 0
		    
		    invoices_offers_portlet::add_self_to_page \
			-portal_id $portal_id \
			-package_id 0
		}
	    }

	    0.1d3 0.1d4 {
		# We are going to add invoice portlet to the 
		# templates
		
		db_foreach get_portal_templates { } {
		    invoices_offers_project_portlet::add_self_to_page \
			-portal_id $portal_id \
			-package_id 0
		}
	    }
	}
}

