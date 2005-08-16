--
--  Copyright (C) 2005 Cognovis
--
--  This file is part of dotLRN.
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--

-- The dotlrn-invoices applet's implimentation of the dotlrn applet contract
--
-- 
--
--

create function inline_0()
returns integer as '
declare
	foo integer;
begin
	-- create the implementation
	foo := acs_sc_impl__new (
		''dotlrn_applet'',
		''dotlrn_invoices'',
		''dotlrn_invoices''
	);

	-- GetPrettyName
	foo := acs_sc_impl_alias__new (
	       ''dotlrn_applet'',
	       ''dotlrn_invoices'',
	       ''GetPrettyName'',
	       ''dotlrn_invoices::get_pretty_name'',
	       ''TCL''
	);

	-- AddApplet
	foo := acs_sc_impl_alias__new (
	       ''dotlrn_applet'',
	       ''dotlrn_invoices'',
	       ''AddApplet'',
	       ''dotlrn_invoices::add_applet'',
	       ''TCL''
	);

	-- RemoveApplet
	foo := acs_sc_impl_alias__new (
	       ''dotlrn_applet'',
	       ''dotlrn_invoices'',
	       ''RemoveApplet'',
	       ''dotlrn_invoices::remove_applet'',
	       ''TCL''
	);

	-- AddAppletToCommunity
	foo := acs_sc_impl_alias__new (
	       ''dotlrn_applet'',
	       ''dotlrn_invoices'',
	       ''AddAppletToCommunity'',
	       ''dotlrn_invoices::add_applet_to_community'',
	       ''TCL''
	);

	-- RemoveAppletFromCommunity
	foo := acs_sc_impl_alias__new (
	       ''dotlrn_applet'',
	       ''dotlrn_invoices'',
	       ''RemoveAppletFromCommunity'',
	       ''dotlrn_invoices::remove_applet_from_community'',
	       ''TCL''
	);

	-- AddUser
	foo := acs_sc_impl_alias__new (
	       ''dotlrn_applet'',
	       ''dotlrn_invoices'',
	       ''AddUser'',
	       ''dotlrn_invoices::add_user'',
	       ''TCL''
	);

	-- RemoveUser
	foo := acs_sc_impl_alias__new (
	       ''dotlrn_applet'',
	       ''dotlrn_invoices'',
	       ''RemoveUser'',
	       ''dotlrn_invoices::remove_user'',
	       ''TCL''
	);

	-- AddUserToCommunity
	foo := acs_sc_impl_alias__new (
	       ''dotlrn_applet'',
	       ''dotlrn_invoices'',
	       ''AddUserToCommunity'',
	       ''dotlrn_invoices::add_user_to_community'',
	       ''TCL''
	);

	-- RemoveUserFromCommunity
	foo := acs_sc_impl_alias__new (
	       ''dotlrn_applet'',
	       ''dotlrn_invoices'',
	       ''RemoveUserFromCommunity'',
	       ''dotlrn_invoices::remove_user_from_community'',
	       ''TCL''
	);

    -- AddPortlet
    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_invoices'',
        ''AddPortlet'',
        ''dotlrn_invoices::add_portlet'',
        ''TCL''
    );

    -- RemovePortlet
    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_invoices'',
        ''RemovePortlet'',
        ''dotlrn_invoices::remove_portlet'',
        ''TCL''
    );

    -- Clone
    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_invoices'',
        ''Clone'',
        ''dotlrn_invoices::clone'',
        ''TCL''
    );

    foo := acs_sc_impl_alias__new (
        ''dotlrn_applet'',
        ''dotlrn_invoices'',
        ''ChangeEventHandler'',
        ''dotlrn_invoices::change_event_handler'',
        ''TCL''
    );

	-- Add the binding
	perform acs_sc_binding__new (
	    ''dotlrn_applet'',
	    ''dotlrn_invoices''
	);

	return 0;

end;' language 'plpgsql';
select inline_0();
drop function inline_0();
